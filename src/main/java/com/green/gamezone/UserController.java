package com.green.gamezone;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criTest.PageMaker;
import criTest.SearchCriteria;
import service.UserService;
import vo.UserVO;

@Controller
public class UserController {

	@Autowired
	UserService service;

	PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(); // 전역 선언

// -----------------------------------------------------------------------------------------------------

	// ** ID 중복 확인
	@RequestMapping(value = "/idDuplicationCheck")
	public ModelAndView idDuplicationCheck(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo) {

		// 1) 입력한 newID 보관
		mv.addObject("newId", vo.getId());

		// 2) service
		vo = service.detailUser(vo);

		// 3) 결과
		if (vo != null) {
			mv.addObject("isUse", "F");

		} else {
			mv.addObject("isUse", "T");
		}
		
		mv.setViewName("/user/idDuplicationCheck");

		return mv;

	} // idDuplicationCheck

// -----------------------------------------------------------------------------------------------------

	// ** User List
	@RequestMapping(value = "/userList")
	public ModelAndView userList(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {

		// 1) Criteria
		cri.setSnoEno();

		// 2) Service
		mv.addObject("list", service.userList(cri)); // ver02

		// 3) View => PageMaker
		pageMaker.setCri(cri);
		pageMaker.setTotalRowsCount(service.viewCount(cri));

		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("/user/userList");
		return mv;

	} // userList

// -----------------------------------------------------------------------------------------------------------------------

	// ** userDetail
	@RequestMapping(value = "/detailUser")
	public ModelAndView detailUser(HttpServletRequest request, HttpServletResponse response, UserVO vo, ModelAndView mv) {

		// 1. 요청
		HttpSession session = request.getSession(false);

		if (vo.getId() == null || vo.getId().length() < 1) {

			if (session != null && session.getAttribute("loginID") != null) {
				vo.setId((String) session.getAttribute("loginID"));

			} else {
				request.setAttribute("message", "해당 ID가 없습니다, 로그인 후 이용 부탁드립니다.");
				mv.setViewName("home");

				return mv;
			}

		}

		String uri = "/user/detailUser";

		// 2. Service
		vo = service.detailUser(vo);

		if (vo != null) {
			mv.addObject("one", vo);

			if ("U".equals(request.getParameter("jCode"))) {
				uri = "/user/updateProfile";

			} else if ("P".equals(request.getParameter("jCode"))) {
				uri = "/user/updatePassword";
			}

		} else {
			mv.addObject("message",
					request.getParameter("id") + "님의 정보가 존재하지 않습니다 **");
		}

		mv.setViewName(uri);
		return mv;

	} // detailUser

// -----------------------------------------------------------------------------------------------------------------------

	// ** Login & Logout
	@RequestMapping(value = "/loginForm")
	public ModelAndView loginForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {

		mv.setViewName("/user/loginUser");

		return mv;

	} // loginForm

	@RequestMapping(value = "/loginUser")
	public ModelAndView loginUser(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo) {

		// 1) Request
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String uri = "/user/loginUser";

		// 2) Service
		vo.setId(id);
		vo = service.detailUser(vo);

		if (vo != null) {

			// => password 암호화 이후
			if (passwordEncoder.matches(password, vo.getPassword())) { // (rawData, digest) => 비교 후 true이면 보관

				request.getSession().setAttribute("loginID", id);
				request.getSession().setAttribute("loginName", vo.getUser_name());
				request.getSession().setAttribute("loginPW", password);

				uri = "home";

			} else {
				mv.addObject("message", "비밀번호 오류, 다시 시도해주세요");
			}

		} else {
			mv.addObject("message", "ID 오류, 다시 시도해주세요");
		}

		mv.setViewName(uri);
		return mv;

	} // loginUser

// -----------------------------------------------------------------------------------------------------------------------

	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {

		HttpSession session = request.getSession(false);

		if (session != null)
			session.invalidate();

		mv.addObject("message", "로그아웃 되었습니다");
		mv.setViewName("home");

		return mv;

	} // logout

// -----------------------------------------------------------------------------------------------------------------------

	// ** Join : 회원가입
	@RequestMapping(value = "/joinForm")
	public ModelAndView joinForm(HttpServletRequest request, HttpServletResponse response, ModelAndView mv) {

		mv.setViewName("/user/joinUser");
		return mv;

	} // joinForm


	@RequestMapping(value = "/joinUser")
	public ModelAndView joinUser(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo,
			@RequestParam("birth_year") String year, @RequestParam("birth_month") String month, @RequestParam("birth_day") String day) throws IOException {

		vo.setBirthday(year + "-" + month + "-" + day);

		// 1. 요청
		String uri = "/user/loginUser";

		// ** Email 처리
		String domain = null;

		if ("1".equals(request.getParameter("domain"))) {
			domain = request.getParameter("dw");

		} else {
			domain = request.getParameter("domain");
		}

		vo.setDomain(domain);

		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath = " + realPath);

		if (realPath.contains(".eclipse."))
			realPath = "D:\\MTest\\myWork\\GameZone\\src\\main\\webapp\\resources\\user_uploadImg\\";

		else
			realPath += "resources\\user_uploadImg\\";

		// ** 폴더 만들기 (File 클래스활용)
		File f1 = new File(realPath);
		if (!f1.exists())
			f1.mkdir();

		// ** 기본 이미지 지정하기
		String file1, file2 = "resources/user_uploadImg/basicimg.png";

		MultipartFile uploadimgfile = vo.getUploadimgfile();
		if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

			// ** Image를 선택 함 -> Image 저장 (경로_realPath + 파일명)
			file1 = realPath + uploadimgfile.getOriginalFilename();
			uploadimgfile.transferTo(new File(file1));

			file2 = "resources/user_uploadImg/"
					+ uploadimgfile.getOriginalFilename();
		}
		// ** 완성된 경로 vo에 set
		vo.setUploadimg(file2);

		// *** PasswordEncoder (암호화 적용하기)
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));

		// 2. Service
		if (service.joinUser(vo) > 0) {
			mv.addObject("message", "회원가입 되었습니다. 로그인 후 이용해주세요.");

		} else {
			mv.addObject("message", "회원가입 실패. 다시 가입 부탁드립니다.");
			uri = "/user/joinUser";
		}

		// 3. 결과(View -> Forward)
		mv.setViewName(uri);
		return mv;

	} // joinUser

// -----------------------------------------------------------------------------------------------------------------------

	   // ** Update : 내 정보 수정하기
	   @RequestMapping(value = "/updateProfile")
	   public ModelAndView updateProfile(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo, RedirectAttributes rttr) throws IOException {

	      // 1. 요청
	      //String uri = "redirect:detailUser?id=" + vo.getId();
	      String uri = "/user/detailUser";

	      
	      mv.addObject("one", vo);

	      // ** Email
	      String domain = vo.getDomain();

	      if ("1".equals(request.getParameter("domain"))) {
	         domain = request.getParameter("dw");

	      } else {
	         domain = request.getParameter("domain");
	      }

	      vo.setDomain(domain);

	      // ** Image Update 추가
	      // 1) Image 물리적 위치에 저장
	      String realPath = request.getRealPath("/");

	      // 1-1) 위의 값을 이용해서 실제 저장위치 확인
	      if (realPath.contains(".eclipse."))
	         realPath = "C:\\Users\\User\\git\\GameZone\\src\\main\\webapp\\resources\\user_uploadImg\\";

	      else
	         realPath += "resources\\user_uploadImg\\";

	      // 1-2) 폴더 만들기 (File 클래스활용)
	      File f1 = new File(realPath);
	      if (!f1.exists())
	         f1.mkdir();

	      // 2) 기본 이미지 지정하기
	      String file1, file2 = "resources/user_uploadImg/basicimg.png";

	      // 3) MultipartFile : file은 저장, 저장된 경로는 vo에 set
	      MultipartFile uploadimgfile = vo.getUploadimgfile();
	      if (uploadimgfile != null && !uploadimgfile.isEmpty()) {

	         // ** 새 Image 파일을 선택 함 -> Image 저장 (경로_realPath + 파일명)
	         // 3-1) 물리적 저장경로에 Image 저장
	         file1 = realPath + uploadimgfile.getOriginalFilename();
	         uploadimgfile.transferTo(new File(file1));

	         // 3-2) Table 저장 준비
	         file2 = "resources/user_uploadImg/" + uploadimgfile.getOriginalFilename();
	         vo.setUploadimg(file2);
	      }
	      
	      // 2. Service
	      if (service.updateProfile(vo) > 0) {
	         mv.addObject("one", vo); // 수정된 vo를 보관
	         //rttr.addFlashAttribute("message", "정보 수정이 완료되었습니다.");
	         mv.addObject("message", "정보 수정이 완료되었습니다.");

	      } else {
	         mv.addObject("message", "정보 수정 실패. 다시 수정 부탁드립니다.");
	         uri = "/user/updateProfile";
	      }

	      // 3. 결과(ModelAndView)
	      mv.setViewName(uri);
	      return mv;
	   } // updateProfile

	// -----------------------------------------------------------------------------------------------------------------------

	   // ** Password Update : 비밀번호 수정하기
	   @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
	   public ModelAndView updatePassword(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo, RedirectAttributes rttr) {

	      // 1. 요청
	      String oldPW = (String) request.getParameter("oldPassword");

	      UserVO vo2 = new UserVO();

	      String id = (String) request.getSession().getAttribute("loginID");
	      String uri = "redirect:detailUser";

	      vo2.setId(id);
	      vo2 = service.detailUser(vo2);

	      HttpSession session = request.getSession(false);

	      // 있는 ID인 지 확인
	      if (session != null && session.getAttribute("loginID") != null) {
	         vo.setId((String) session.getAttribute("loginID"));

	      } else {
	         request.setAttribute("message", "해당 ID가 없습니다, 로그인 후 이용 부탁드립니다.");
	         mv.setViewName("home");

	         return mv;
	      }

	      // 2. Service
	      // ** passwordEncoder.matches 사용 시
	      // => 암호화 된 password를 무조건 두 번째에 써야 됨.
	      if (passwordEncoder.matches(oldPW, vo2.getPassword())) { // 암호화 전 PW와 암호화 후 PW 비교

	         // 맞으면 암호화 다시 함
	         vo.setPassword(passwordEncoder.encode(vo.getPassword()));

	         if (service.updatePassword(vo) > 0) {
	            rttr.addFlashAttribute("message", "비밀번호가 변경되었습니다.");

	         } else {
	            mv.addObject("message", "비밀번호 변경 실패, 다시 변경 부탁드립니다.");
	            uri = "/user/updatePassword";
	         }

	      } else {
	         mv.addObject("message", "현재 비밀번호가 다릅니다. 다시 시도 부탁드립니다.");
	         uri = "/user/updatePassword";
	      }

	      // 3. 결과(ModelAndView)
	      mv.setViewName(uri);
	      return mv;

	   } // updatePassword

// -----------------------------------------------------------------------------------------------------------------------

	// ** Delete : 회원탈퇴
	@RequestMapping(value = "/deleteUser")
	public ModelAndView deleteUser(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, UserVO vo, RedirectAttributes rttr) {

		// 1. 요청
		String id = "null";
		HttpSession session = request.getSession(false);

		if (session != null && session.getAttribute("loginID") != null) {

			id = (String) session.getAttribute("loginID");

			if (!"admin".equals(id))
				vo.setId(id);

			// 2. Service
			if (service.deleteUser(vo) > 0) {
				rttr.addFlashAttribute("message", "탈퇴 성공, 그 동안 이용해주셔서 감사합니다.");

				if (!"admin".equals(id))
					session.invalidate();

			} else {
				rttr.addFlashAttribute("message",
						"탈퇴 실패, 다시 시도해주시고 계속 실패할 시 Q&A 문의 부탁드립니다.");
			}

		} else {
			rttr.addFlashAttribute("message",
					"session 정보 없음, 로그인 후 이용 부탁드립니다.");
		}

		// 3. 결과(ModelAndView)
		mv.setViewName("redirect:home");
		return mv;

	} // deleteUser

} // class
