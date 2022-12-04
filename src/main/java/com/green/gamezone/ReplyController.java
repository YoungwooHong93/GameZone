package com.green.gamezone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.ReplyService;
import vo.ReplyVO;

@Controller
public class ReplyController {

	@Autowired
	ReplyService service;

	@RequestMapping(value = "/replyList")
	public ModelAndView replyList(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, ReplyVO vo) {

		mv.addObject("list", service.replyList(vo));
		mv.setViewName("/reply/replyList");
		return mv;
		
	} // replyList
	
//-------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/writeReply")
	public ModelAndView writeReply(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, ReplyVO vo, RedirectAttributes rttr) {

		response.setContentType("text/html; charset=UTF-8");

		String loginID = (String) request.getSession().getAttribute("loginID");
		vo.setId(loginID);

		if (service.writeReply(vo) > 0) {
			mv.addObject("message", "200");
			
		} else {
			mv.addObject("message", "201");
		}
		
		String uri = "/board/readPost";

		mv.addObject("list", service.replyList(vo));
		mv.setViewName("jsonView");
		
		return mv;

	} // writeReply

//-------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/modifyReply")
	public ModelAndView modifyReply(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, ReplyVO vo) {
	
		response.setContentType("text/html; charset=UTF-8");
	
		mv.addObject("one", vo);
	
		if (service.modifyReply(vo) > 0) {
			mv.addObject("message", "200");
			
		} else {
			mv.addObject("message", "201");
		}
		
		mv.setViewName("jsonView");
		return mv;
	
	} // modifyReply

//-------------------------------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/deleteReply")
	public ModelAndView deleteReply(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, ReplyVO vo) {

		response.setContentType("text/html; charset=UTF-8");

		if (service.deleteReply(vo) > 0) {
			mv.addObject("message", "200");
			
		} else {
			mv.addObject("message", "201");
		}

		mv.setViewName("jsonView");
		return mv;

	} // deleteReply

} // class