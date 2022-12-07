package com.green.gamezone;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	
	@Autowired private 
	JavaMailSender mailSender;
	 

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );

		return "home";

	} // home

//-----------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/emailAuth", method = RequestMethod.POST)
	public ModelAndView emailAuth(String email, ModelAndView mv) {		
		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		// ** 이메일 보내기
        String setFrom = "gamezone.green@gmail.com";
        // String setFrom = "보낼 이메일 주소";
        String toMail = email;
        String title = "GameZone 회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다 *^_^*" +
                "<br><br>" + 
                "인증 번호는 " + checkNum + " 입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 정확하게 입력해주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        mv.addObject("code", checkNum);
        mv.setViewName("jsonView");
        System.out.println(checkNum);
        return mv;
	
	} // emailAuth

} // class
