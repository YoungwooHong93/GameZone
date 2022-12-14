package com.green.gamezone;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

		// 1. ??????
		String uri = "/flashGame/detailFlashGame";

		// 2. Service
		vo = service.detailFlashGame(vo);

		if (vo != null) {

			// ** ??????????????? ??? ??????
			if ("U".equals(request.getParameter("jCode"))) {
				uri = "/flashGame/updateFlashGame";
			}

			// ?????? ??????
			request.setAttribute("one", vo);

		} else {
			mv.addObject("message", "?????? ????????? ???????????? ????????? ????????????.");
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
		
		// 1. ??????
		String uri = "redirect:axFlashGame";

		String realPath = request.getRealPath("/"); // deprecated Method

		if (realPath.contains(".eclipse."))
			realPath = "D:\\MTest\\myWork\\GameZone\\src\\main\\webapp\\resources\\flashGameImg\\";

		else
			realPath += "resources\\flashGameImg\\";

		// ** ?????? ????????? (File ???????????????)
		File f1 = new File(realPath);
		if (!f1.exists())
			f1.mkdir();

		// ** ?????? ????????? ????????????
		String file1, file2 = "resources/flashGameImg/gamelogo.png";

		MultipartFile uploadimgfile = vo.getUploadimgfile();
		if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

			// ** Image??? ?????? ??? -> Image ?????? (??????_realPath + ?????????)
			file1 = realPath + uploadimgfile.getOriginalFilename();
			uploadimgfile.transferTo(new File(file1));

			file2 = "resources/flashGameImg/" + uploadimgfile.getOriginalFilename();
		}

		// ** ????????? ?????? vo??? set
		vo.setGame_img(file2);

		// 2. Service
		if (service.insertFlashGame(vo) > 0) {
			mv.addObject("message", "????????? ?????????????????????.");

		} else {
			mv.addObject("message", "?????? ?????? ??????, ?????? ??????????????????.");
			uri = "/flashGame/insertFlashGame";
		}

		// 3. ??????(View -> Forward) ??????
		mv.setViewName(uri);
		return mv;

	} // insertFlashGame

// ----------------------------------------------------------------------------------------------------------------------------------------

	// ** Update : Game ?????? ????????????
	@RequestMapping(value = "/updateFlashGame", method = RequestMethod.POST)
	public ModelAndView updateFlashGame(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, GameVO vo) throws IOException {

		// 1. ??????
		String uri = "/flashGame/detailFlashGame";

		mv.addObject("one", vo);

		String realPath = request.getRealPath("/"); // deprecated Method

		if (realPath.contains(".eclipse."))
			realPath = "D:\\MTest\\myWork\\GameZone\\src\\main\\webapp\\resources\\flashGameImg\\";

		else
			realPath += "resources\\flashGameImg\\";

		// ** ?????? ????????? (File ???????????????)
		File f1 = new File(realPath);
		if (!f1.exists())
			f1.mkdir();

		// ** ?????? ????????? ????????????
		String file1, file2 = "resources/flashGameImg/gamelogo.png";

		MultipartFile uploadimgfile = vo.getUploadimgfile();
		if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

			// ** Image??? ?????? ??? -> Image ?????? (??????_realPath + ?????????)
			file1 = realPath + uploadimgfile.getOriginalFilename();
			uploadimgfile.transferTo(new File(file1));

			file2 = "resources/flashGameImg/" + uploadimgfile.getOriginalFilename();
			vo.setGame_img(file2);
		}

		// 2. Service
		if (service.updateFlashGame(vo) > 0) {
			mv.addObject("message", "????????? ?????????????????????.");
			mv.addObject("one", vo);

		} else {
			mv.addObject("message", "?????? ?????? ??????, ?????? ?????? ????????????.");
			uri = "/flashGame/updateFlashGame";
		}

		// 3. ??????(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // updateFlashGame

// ----------------------------------------------------------------------------------------------------------------------------------------

	// ** Delete : Game ??????
	@RequestMapping(value = "/deleteFlashGame")
	public ModelAndView deleteFlashGame(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, GameVO vo, RedirectAttributes rttr) {

		// 1. ??????
		String uri = "redirect:axFlashGame";

		// 2. Service
		if (service.deleteFlashGame(vo) > 0) {
			rttr.addFlashAttribute("message", "????????? ?????????????????????.");

		} else {
			rttr.addFlashAttribute("message", "?????? ?????? ??????, ?????? ??????????????????.");
			uri = "redirect:detailFlashGame?game_name=" + vo.getGame_name();
		} // Service

		// 3. ??????(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // deleteFlashGame

} // class
