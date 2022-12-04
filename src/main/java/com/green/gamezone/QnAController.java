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
import service.QnAService;
import vo.QnAVO;

@Controller
public class QnAController {
	
	@Autowired
	QnAService service;

	@RequestMapping(value = "/qnaBoardList")
	public ModelAndView qnaBoardList(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		
		cri.setSnoEno();

		// Service
		// => List 처리
		mv.addObject("list", service.searchPost(cri));

		// View => PageMaker
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(service.countPost(cri));
		mv.addObject("pageMaker", pageMaker);

		mv.setViewName("/qna/qnaBoardList");
		return mv;
		
	} // qnaBoardList

// ----------------------------------------------------------------------------------------------------------------------------------

	// ** readPost
	@RequestMapping(value = "/qnaReadPost")
	public ModelAndView qnaReadPost(HttpServletRequest request, HttpServletResponse response, QnAVO vo, ModelAndView mv) {

		// 1. 요청
		String uri = "/qna/qnaReadPost";

		// 2. Service
		vo = service.readPost(vo);

		if (vo != null) {
			
			// 2.1) 조회수 증가
			String loginID = (String) request.getSession().getAttribute("loginID");
			
			if (!vo.getId().equals(loginID) && !"U".equals(request.getParameter("jCode"))) {
				
				// => 조회수 증가
				if (service.countHits(vo) > 0)
					vo.setCnt(vo.getCnt() + 1);
				
			} // if_증가조건

			// 2.2) 수정요청 확인
			if ("U".equals(request.getParameter("jCode")))
				uri = "/qna/qnaModifyPost";

			// 2.3) 비밀글
			if (vo.getSecret().equals("true")) {
			
				if (vo.getId().equals(loginID) || "admin".equals(loginID)) {
					// 비밀인데 login id가 작성자고 admin -> 조회하는 uri
					uri = "/qna/qnaReadPost";

				} else {
					// 비밀이고 login id가 작성자가 아니고 조회 -> 비밀글이니 조회못하도록 하는 uri
					uri = "/qna/qnaBoardList";
				}
				
			} else {
				uri = "/qna/qnaReadPost";
			}

			// 2.4) 결과 전달
			mv.addObject("one", vo);

		} else
			mv.addObject("message", "해당 번호의 문의글이 존재하지 않습니다.");

		mv.setViewName(uri);
		return mv;
		
	} // qnaReadPost

// ----------------------------------------------------------------------------------------------------------------------------------

	// ** writePost : 새글등록
	@RequestMapping(value = "/qnaWritePostForm")
	public ModelAndView qnawritePostForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {
		mv.setViewName("/qna/qnaWritePostForm");
		return mv;
	} // qnawritePostForm

// ----------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/qnaWritePost", method = RequestMethod.POST)
	public ModelAndView qnawriteBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:qnaBoardList";

		// 2. Service
		if (service.writePost(vo) > 0) {
			rttr.addFlashAttribute("message", "새 문의글이 등록되었습니다.");
			
		} else {
			mv.addObject("message", "새 문의글 등록 실패. 다시 시도해주세요.");
			uri = "/qna/qnaWritePostForm";
		}

		// 3. 결과(View -> forward)
		mv.setViewName(uri);
		return mv;

	} // writePost

// ----------------------------------------------------------------------------------------------------------------------------------

	// ** modifyPost : 게시물 수정하기 1
	@RequestMapping(value = "/qnaModifyPost")
	// Request method 'GET' not supported
	public ModelAndView qnaModifyPost(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo) {

		String uri = "/qna/qnaModifyPost";

		mv.addObject("one", service.readPost(vo));
		mv.setViewName(uri);
		
		return mv;

	} // modifyPost

	// ** modifyPost : 게시물 수정하기 2
	@RequestMapping(value = "/qnaModifyPost", method = RequestMethod.POST)
	public ModelAndView qnaUpdatePost(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo) {

		// 1. 요청
		String uri = "/qna/qnaReadPost";

		mv.addObject("one", vo);

		// 2. Service
		if (service.modifyPost(vo) > 0) {
			mv.addObject("message", "문의글이 수정되었습니다.");

		} else {
			mv.addObject("message", "문의글 수정 실패. 다시 시도해주세요.");
			uri = "/qna/qnaModifyPost";
		}
		
		// 3) 결과
		mv.setViewName(uri);
		return mv;

	} // modifyPost

// ----------------------------------------------------------------------------------------------------------------------------------

	// ** removePost : 게시글 삭제
	@RequestMapping(value = "/qnaRemovePost")
	public ModelAndView qnaRemoveBoard(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:qnaBoardList";

		// 2. Service
		if (service.removePost(vo) > 0) {
			rttr.addFlashAttribute("message", "문의글이 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "문의글 삭제 실패. 다시 시도해주세요.");
			uri = "redirect:qnaDetailBoard?seq=" + vo.getSeq();
		} // Service

		// 3. 결과(ModelAndView)
		mv.setViewName(uri);
		return mv;

	} // removePost

// ----------------------------------------------------------------------------------------------------------------------------------

	// ** Reply_Insert : 답글등록
	@RequestMapping(value = "/qnaWriteReplyForm")
	public ModelAndView qnaWriteReplyForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo) {
		
		mv.setViewName("/qna/qnaWriteReplyForm");
		return mv;
	
	} // qnaWriteReplyForm

// ----------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/qnaWriteReply", method = RequestMethod.POST)
	public ModelAndView qnaWriteReply(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, QnAVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String uri = "redirect:qnaBoardList";
		
		vo.setStep(vo.getStep() + 1);
		vo.setIndent(vo.getIndent() + 1);

		// 2. Service
		if (service.writeReply(vo) > 0) {
			rttr.addFlashAttribute("message", "답글이 등록되었습니다.");

		} else {
			mv.addObject("message", "답글 등록 실패. 다시 시도해주세요.");
			uri = "/qna/qnaWriteReplyForm";
		}

		// 3. 결과(ModelAndView)
		mv.setViewName(uri);
		return mv;
		
	} // qnaWriteReply

} // class