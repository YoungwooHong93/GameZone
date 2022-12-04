package com.green.gamezone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.BoardService;
import service.ReplyService;
import vo.BoardVO;
import vo.ReplyVO;

@Controller
public class BoardController {
	// ** 전역변수 활용
	@Autowired
	BoardService service;

	@Autowired
	ReplyService replyService;
	// ** Criteria PageList
	
	@RequestMapping(value = "/boardList")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {

		// 1) Paging
		cri.setSnoEno();

		// 2) Service
		mv.addObject("list", service.searchPost(cri));

		// 3) View 처리 => PageMaker
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(service.countPost(cri));
		mv.addObject("pageMaker", pageMaker);

		mv.setViewName("/board/boardList");
		return mv;
		
	}

// ----------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/readPost")
	public ModelAndView readPost(HttpServletRequest request, HttpServletResponse response, BoardVO vo, ModelAndView mv) {

		// 1. 요청
		String uri = "/board/readPost";

		// 2. Service 처리
		vo = service.readPost(vo);

		if (vo != null) {

			// 2.1) 조회수 증가
			String loginID = (String) request.getSession().getAttribute("loginID");
			
			if (!vo.getId().equals(loginID) && !"U".equals(request.getParameter("jCode"))) {
				
				// => 조회수 증가
				if (service.countHits(vo) > 0)
					vo.setCnt(vo.getCnt() + 1);
			}

			// 2.2) 수정요청 확인
			if ("U".equals(request.getParameter("jCode")))
				uri = "/board/modifyPost";

			// 2.3) 결과 전달
			mv.addObject("one", vo);

			// 댓글 조회
			ReplyVO replyVO = new ReplyVO();
			replyVO.setSeq(vo.getSeq());

			mv.addObject("list", replyService.replyList(replyVO));

		} else
			mv.addObject("message", "해당 번호의 게시물이 존재하지 않습니다.");

		mv.setViewName(uri);
		return mv;

	} // readPost

// ----------------------------------------------------------------------------------------------------------------------

	// ** writePost : 새글등록
	@RequestMapping(value = "/writePostForm")
	public ModelAndView writePostForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		
		mv.setViewName("/board/writePostForm");
		return mv;
		
	}

// ----------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/writePost", method = RequestMethod.POST)
	public ModelAndView writeBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:boardList";

		// 2. Service
		if (service.writePost(vo) > 0) {
			rttr.addFlashAttribute("message", "새 게시물이 등록되었습니다.");

		} else {
			mv.addObject("message", "게시물 등록 실패. 다시 시도해주세요");
			uri = "/board/writePostForm";
		}

		// 3. 결과(View -> forward)
		mv.setViewName(uri);
		return mv;
		
	} // writePost

// ----------------------------------------------------------------------------------------------------------------------

	// ** modifyPost : 게시물 수정
	@RequestMapping(value = "/modifyPost", method = RequestMethod.POST)
	public ModelAndView modifyPost(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, BoardVO vo) {

		// 1. 요청
		String uri = "/board/readPost";
		
		mv.addObject("one", vo);

		// 2. Service
		if (service.modifyPost(vo) > 0) {
			mv.addObject("message", "게시물이 수정되었습니다.");

		} else {
			mv.addObject("message", "게시물 수정 실패. 다시 시도해주세요.");
			uri = "/modifyPost";
		}

		mv.setViewName(uri);
		return mv;

	} // modifyPost

// ----------------------------------------------------------------------------------------------------------------------

	// ** removePost : 게시글 삭제
	@RequestMapping(value = "/removePost")
	public ModelAndView removeBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, BoardVO vo, RedirectAttributes rttr) {
		
		// 1. 요청
		String uri = "redirect:boardList";
	
		// * 해당 seq의 댓글 지우기
		service.removeReply(vo);
	
		// 2. Service
		if (service.removePost(vo) > 0) {
			rttr.addFlashAttribute("message", "게시물이 삭제되었습니다.");
	
		} else {
			rttr.addFlashAttribute("message", "게시물 삭제 실패. 다시 시도해주세요.");
			uri = "redirect:detailBoard?seq=" + vo.getSeq();
		} // Service
	
		// 3. 결과(ModelAndView) 전달
		mv.setViewName(uri);
		return mv;
	
	} // removePost

// ----------------------------------------------------------------------------------------------------------------------
	// ************ 댓글로 대체 함 **************************************************************************************
/*	// ** Reply_Insert : 답글등록
	@RequestMapping(value = "/writeReplyForm")
	public ModelAndView writeReplyForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, BoardVO vo) {
		
		mv.setViewName("/board/writeReplyForm");
		return mv;
		
	}

// ----------------------------------------------------------------------------------------------------------------------

	// ** 답글 등록
	@RequestMapping(value = "/writeReply", method = RequestMethod.POST)
	public ModelAndView writeReply(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, 
									BoardVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:boardList";
		
		vo.setStep(vo.getStep() + 1);
		vo.setIndent(vo.getIndent() + 1);

		// 2. Service
		if (service.writeReply(vo) > 0) {
			rttr.addFlashAttribute("message", "댓글이 등록되었습니다.");

		} else {
			mv.addObject("message", "댓글 작성 실패. 다시 시도해주세요.");
			uri = "/board/writeReplyForm";
		}

		// 3. 결과(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // writeReply
*/
} // class