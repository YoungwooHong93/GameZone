package com.green.gamezone;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.GamePageMaker;
import criTest.GameSearchCriteria;
import service.FlashGameService;
import vo.GameVO;
import vo.RankingVO;

@Controller
public class FlashGameController {
	
	@Autowired
	FlashGameService service;

// ----------------------------------------------------------------------------------------------------------------------

	// ** Ajax flashGameList
    @RequestMapping(value="/axFlashGame")
    public ModelAndView axFlashGame(ModelAndView mv, GameSearchCriteria gameCriteria, GamePageMaker gamePageMaker, GameVO vo) {
    	
		gameCriteria.setSnoEno();

		// 1) Criteria_Check
		gameCriteria.setCheck(null);
		
		mv.addObject("one", vo);

		// 2) Service
		mv.addObject("list", service.flashGameList(gameCriteria));

		// 3) View => gamePageMaker
		gamePageMaker.setCri(gameCriteria);
		gamePageMaker.setTotalRowsCount(service.viewCount(gameCriteria));

		mv.addObject("gamePageMaker", gamePageMaker);

		mv.setViewName("/flashGame/axFlashGame");

		return mv;
    	
    } // Ajax flashGameList
	
	
	// ** flashGameList
    @RequestMapping(value = "/flashGameList")
    public ModelAndView flashGameList(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, 
    									GameSearchCriteria gameCriteria, GamePageMaker gamePageMaker, GameVO vo) {

       gameCriteria.setSnoEno();

       // 1) Criteria_Check
       if (gameCriteria.getCheck() != null && gameCriteria.getCheck().length < 1 ) {
          gameCriteria.setCheck(null); 
       }
       
       mv.addObject("one", vo);
       
       // 2) Service
       mv.addObject("list", service.flashGameList(gameCriteria));
    
       // 3) View => gamePageMaker
       gamePageMaker.setCri(gameCriteria);
       gamePageMaker.setTotalRowsCount(service.viewCount(gameCriteria));
    
       mv.addObject("gamePageMaker", gamePageMaker);
       
       mv.setViewName("/flashGame/flashGameList");
       return mv;
    
    } // flashGameList
	
//----------------------------------------------------------------------------------------------------------------------------------------

	// ** Detail
	@RequestMapping(value = "/detailFlashGame")
	public ModelAndView detailFlashGame(HttpServletRequest request, HttpServletResponse response, GameVO vo, ModelAndView mv, RankingVO rvo) {

		// 1. 요청
		String uri = "/flashGame/detailFlashGame";

		// 2. Service
		vo = service.detailFlashGame(vo);

		if (vo != null) {

			// ** 수정요청인 지 확인
			if ("U".equals(request.getParameter("jCode"))) {
				uri = "/flashGame/updateFlashGame";
			}

			// 결과 전달
			request.setAttribute("one", vo);

		} else {
			mv.addObject("message", "게임 이름에 해당하는 자료가 없습니다.");
		} // vo != null

		// 3. View
		mv.setViewName(uri);

		return mv;

	} // detailFlashGame

// ----------------------------------------------------------------------------------------------------------------------------------------

	// ** Insert Game
	@RequestMapping(value = "/insertFlashForm")
	public ModelAndView insertFlashForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {

		mv.setViewName("/flashGame/insertFlashGame");
		return mv;

	} // insertFlashForm

	
	@RequestMapping(value = "/insertFlashGame")
	public ModelAndView insertFlashGame(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, GameVO vo, RedirectAttributes rttr) throws IOException {
		
		// 1. 요청
		String uri = "redirect:axFlashGame";

		String realPath = request.getRealPath("/"); // deprecated Method

		if (realPath.contains(".eclipse."))
			realPath = "C:\\Users\\User\\git\\GameZone\\src\\main\\webapp\\resources\\flashGameImg\\";

		else
			realPath += "resources\\flashGameImg\\";

		// ** 폴더 만들기 (File 클래스활용)
		File f1 = new File(realPath);
		if (!f1.exists())
			f1.mkdir();

		// ** 기본 이미지 지정하기
		String file1, file2 = "resources/flashGameImg/gamelogo.png";

		MultipartFile uploadimgfile = vo.getUploadimgfile();
		if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

			// ** Image를 선택 함 -> Image 저장 (경로_realPath + 파일명)
			file1 = realPath + uploadimgfile.getOriginalFilename();
			uploadimgfile.transferTo(new File(file1));

			file2 = "resources/flashGameImg/" + uploadimgfile.getOriginalFilename();
		}

		// ** 완성된 경로 vo에 set
		vo.setGame_img(file2);

		// 2. Service
		if (service.insertFlashGame(vo) > 0) {
			mv.addObject("message", "게임이 등록되었습니다.");

		} else {
			mv.addObject("message", "게임 등록 실패, 다시 시도해주세요.");
			uri = "/flashGame/insertFlashGame";
		}

		// 3. 결과(View -> Forward) 처리
		mv.setViewName(uri);
		return mv;

	} // insertFlashGame

// ----------------------------------------------------------------------------------------------------------------------------------------

	// ** Update : Game 정보 수정하기
	@RequestMapping(value = "/updateFlashGame", method = RequestMethod.POST)
	public ModelAndView updateFlashGame(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, GameVO vo) throws IOException {

		// 1. 요청
		String uri = "/flashGame/detailFlashGame";

		mv.addObject("one", vo);

		String realPath = request.getRealPath("/"); // deprecated Method

		if (realPath.contains(".eclipse."))
			realPath = "C:\\Users\\User\\git\\GameZone\\src\\main\\webapp\\resources\\flashGameImg\\";

		else
			realPath += "resources\\flashGameImg\\";

		// ** 폴더 만들기 (File 클래스활용)
		File f1 = new File(realPath);
		if (!f1.exists())
			f1.mkdir();

		// ** 기본 이미지 지정하기
		String file1, file2 = "resources/flashGameImg/gamelogo.png";

		MultipartFile uploadimgfile = vo.getUploadimgfile();
		if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

			// ** Image를 선택 함 -> Image 저장 (경로_realPath + 파일명)
			file1 = realPath + uploadimgfile.getOriginalFilename();
			uploadimgfile.transferTo(new File(file1));

			file2 = "resources/flashGameImg/" + uploadimgfile.getOriginalFilename();
			vo.setGame_img(file2);
		}

		// 2. Service
		if (service.updateFlashGame(vo) > 0) {
			mv.addObject("message", "게임이 수정되었습니다.");
			mv.addObject("one", vo);

		} else {
			mv.addObject("message", "게임 수정 실패, 다시 수정 해주세요.");
			uri = "/flashGame/updateFlashGame";
		}

		// 3. 결과(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // updateFlashGame

// ----------------------------------------------------------------------------------------------------------------------------------------

	// ** Delete : Game 삭제
	@RequestMapping(value = "/deleteFlashGame")
	public ModelAndView deleteFlashGame(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, GameVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:axFlashGame";

		// 2. Service
		if (service.deleteFlashGame(vo) > 0) {
			rttr.addFlashAttribute("message", "게임이 삭제되었습니다.");

		} else {
			rttr.addFlashAttribute("message", "게임 삭제 실패, 다시 시도해주세요.");
			uri = "redirect:detailFlashGame?game_name=" + vo.getGame_name();
		} // Service

		// 3. 결과(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // deleteFlashGame

} // class
