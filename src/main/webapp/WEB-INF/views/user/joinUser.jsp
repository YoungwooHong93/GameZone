<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 회원가입</title>
	<link rel="stylesheet" href="resources/css/user.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/js/inCheck.js"></script>
	<script>
		function idDupCheck() {
			// 1) id 무결성 확인
			if (iCheck == false) {
				iCheck = idCheck();
                	
			} else {
				// 2) 서버로 확인 요청 => 결과는 새 창으로 처리
				let url = 'idDuplicationCheck?id=' + $('#id').val();
				window.open(url, '_blank', 'width = 400, height = 300, resizable = yes, scrollbars = yes, toolbar = no, menubar = yes');
			}

		} // idDupCheck

// ----------------------------------------------------------------------------------------------------------

		let iCheck = false; // id
		let pCheck = false; // pw
		let ppCheck = false; // pw 확인
		let nCheck = false; // 이름
		let bCheck = false; // 생년월일
		let phCheck = false; // 핸드폰 번호
		let emCheck = false; // 이메일
		let dwCheck = false; // 도메인_직접입력
		let dCheck = false; // 도메인_선택
            
		let mail_auth_check = false; // 이메일 인증

		$(function () {
			$('#id').focus();

			$('#id').keydown(function (e) {
				// ** ID
				if (e.which == 13) {
					e.preventDefault();
					$('#password').focus();
				}
			}).focusout(function () {
				iCheck = idCheck();
			}); //id

			// ** Password
			$('#password').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#password2').focus();
				}
			}).focusout(function () {
				pCheck = pwCheck();
			}); // password

			// ** Password2
			$('#password2').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#user_name').focus();
				}
			}).focusout(function () {
				ppCheck = pw2Check();
			}); // password2

			// ** User_name
			$('#user_name').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#birth_year').focus();
				}
			}).focusout(function () {
				nCheck = nmCheck();
			}); // user_name

			// ** Birthday
			$('#birth_year').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#birth_month').focus();
				}
			}).focusout(function () {
				bCheck = bdyearCheck();
			}); // birthday
               
			// ** Birthday
			$('#birth_month').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#birth_day').focus();
				}
			}).focusout(function () {
				bCheck = bdmonthCheck();
			}); // birthday
               
			// ** Birthday
			$('#birth_day').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#email').focus();
				}
			}).focusout(function () {
				bCheck = bddayCheck();
			}); // birthday
               
			// ** Phone
			$('#phone').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#email').focus();
				}
			}).focusout(function () {
				phCheck = phoCheck();
			}); // phone

			// ** Email
			$('#email').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#domain').focus();
				}
			}).focusout(function () {
				emCheck = emaCheck();
			}); // email

			// ** Domain_Write (직접입력)
			$('#dw').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#emailCheck').focus();
				}
			}).focusout(function () {
				dwCheck = dowCheck();
			}); // dw

			// ** Domain (선택)
			$('#domain').keydown(function (e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#emailCheck').focus();
				}
			}).focusout(function () {
				dCheck = doCheck();
			}); // domain

//--------------------------------------------------------------

			$("#emailCheck").click(function() {
				
   				var email = $('#email').val();
   				var dw = $('#dw').val();
   				var domain = $('#domain').val();
   				var edomain = $('#email').val() + $('#dw').val()
           
   	        	if (email.length < 1) {
   	        		alert("이메일을 입력해주세요.");
   	           		return false;
   	        	}
   				
   				if (emCheck == false) {
   					alert('이메일을 확인해주세요.');
   					return false;
   				}
   	        	
   	        	if (domain == '1' && dw.length < 1) {
   	        		alert("도메인을 입력해주세요.");
   	           		return false;
   	        	}
   	        	
   	        	if (dwCheck == false) {
   	        		alert('이메일 형식을 맞춰 입력해주세요.');
   					return false;
   				}
   	        	
   	        	if (domain != '1' && dw.length < 1) {
   	        		alert("도메인을 선택해주세요.");
   	           		return false;
   	        	} 
   	       //----------------------------------------------------------------------
   	        	if (emCheck && dwCheck && dCheck) {
   	        		return true;
   	        	}
   	        	
				if ($('#enter_auth_number').css('display') == 'none') {
         			
					// 나타나도록
					$('#enter_auth_number').css('display', 'block');
         			
         			// 이메일 인증 처리
         			$.ajax({
						type : "POST",
       	        		url : "emailAuth",
       	        		data : {
       	        			email : edomain
       	        		},
       	        		success: function(data) {
       	        			if ($('#email').val() != '') {
       	          				alert("인증번호가 발송되었습니다.");
       	           				email_auth_cd = data.code;
       	            		
       	        			} else {
       	           				alert("E-mail을 정확히 입력해주세요.");
       	        			}
       	        		},
       	        		error: function(data) {
       	           			alert("메일 발송에 실패했습니다.");
       	        		}
       	      		}); // ajax
       	      		
				} // enter_auth_number
   	        	
			}); // emailCheck
      
      		$("#email_auth_key").click(function() {
            	console.log(email_auth_cd);
               	console.log($('#check_number').val());
         			
               	if ($('#check_number').val() != email_auth_cd) {
            		alert("인증번호가 일치하지 않습니다.");
            			
         		} else if ($('#check_number').val() == '' ) {
            		alert("인증번호가 일치하지 않습니다.");
            			
         		} else {
            		alert("인증 완료되었습니다.");
            		$(this).attr('disabled',true);
            		$(this).css('background-color','gray');
            		$('#emailCheck').attr('disabled', true);
            		$('#emailCheck').css('background-color', 'DimGray');
            			
            		mail_auth_check = true;
         		}
               	
			}); // email_auth_key
      	
		}); //ready
		

		function inCheck() {

			if (iCheck == false) {
				$('#iMessage').html('ID를 확인해주세요.');
			}

			if (pCheck == false) {
				$('#pMessage').html('비밀번호를 확인해주세요.');
			}

			if (ppCheck == false) {
				$('#ppMessage').html('비밀번호가 일치하지 않습니다.');
			}

			if (nCheck == false) {
				$('#nMessage').html('이름을 확인해주세요.');
			}

			if (bCheck == false) {
				$('#bMessage').html('생년월일을 확인해주세요.');
			}
               
			if (phCheck == false) {
				$('#phMessage').html('핸드폰 번호를 확인해주세요.');
			}

			if (emCheck == false) {
				$('#emMessage').html('이메일을 확인해주세요.');
			}

			if (dwCheck == false) {
				$('#dwMessage').html('이메일 형식을 맞춰 입력해주세요.');
			}

			if (dCheck == false) {
				$('#dMessage').html('도메인을 선택해주세요.');
			}
               	
			if (mail_auth_check == false) {
				$('#emMessage').html('이메일 인증이 필요합니다.');
			}

			if ($('#domain').val() == 1) {
				dCheck = true;
                  	
			} else {
				dwCheck = true;
			}

			if (iCheck && pCheck && ppCheck && nCheck && bCheck && phCheck && emCheck && dwCheck && dCheck && mail_auth_check) {
				if (confirm("가입하시겠습니까 ? (Yes : 확인 / No : 취소)") == false) {
					alert('가입이 취소되었습니다.');
					return false;

				} else {
					return true; // submit 진행
				}

			} else {
				//alert('오류가 있습니다.' + iCheck + pCheck + ppCheck + nCheck + bCheck + phCheck + emCheck + dwCheck + dCheck + mail_auth_check);
				alert('오류가 있습니다. 메시지 확인 후 다시 시도해주세요.');
				return false;
			}
		} //inCheck
	</script>
</head>
<body>
	<!-- Header section -->
   	<header class="header-section">
    	<div>
        	<!-- logo -->
         	<a class="site-logo" href="home">
	        	<img src="resources/img/logo22.png" alt="gamelogo">
	        </a>
         	<!-- site menu -->
         	<nav class="main-menu">
            	<ul>
               		<li><a href="home">Home</a></li>
               		<li><a href="axPcGame">PC 게임조회</a></li>
               		<li><a href="axMobileGame">모바일 게임조회</a></li>
	               	<li><a href="axFlashGame">플래시 게임</a></li>
	               	<li><a href="boardList">자유 게시판</a></li>
	               	<li><a href="qnaBoardList">Q&amp;A</a></li>
            	</ul>
         	</nav>
         	<div class="user-panel">
            	<c:choose>
               		<c:when test="${not empty loginID && loginID != 'admin'}">
                  		<a href="detailUser">내 정보 보기</a> / <a href="logout">로그아웃</a>
               		</c:when>
               		<c:when test="${loginID == 'admin'}">
                  		<a href="userList">회원 리스트</a> / <a href="logout">로그아웃</a>
               		</c:when>
               		<c:otherwise>
                  		<a href="loginForm">로그인</a> / <a href="joinForm">회원가입</a>
               		</c:otherwise>
            	</c:choose>
         	</div>
      	</div>
   	</header>
   	<!-- Header section end -->
   	<main>
		<form action="joinUser" method="post" id="myForm" enctype="multipart/form-data">
			<div class="container rounded bg-white mt-5 mb-5">
				<div class="row">
					<div class="col-md-3">
						<div class="d-flex flex-column align-items-center text-center p-3 py-5">
							<img src="resources/img/사진.png" class="select_img" width="230" height="300">
							<input type="hidden" name="uploadimg" value="${one.uploadimg}"><br>
							<input type="file" name="uploadimgfile" id="uploadimgfile">
							<script>
	                        	$('#uploadimgfile').change(function () {
	                            	if (this.files && this.files[0]) {
	                                	var reader = new FileReader;
	                                 	reader.readAsDataURL(this.files[0]);
	                                 	reader.onload = function (e) {
	                                    	$(".select_img").attr("src", e.target.result).width(230).height(300);
	                                 	} // onload_function
	                            	} // if
	                          	}); // change
	                        </script>
						</div>
					</div>
					<div class="col-md-5">
						<div class="p-3 join_py-5">
							<div class="d-flex justify-content-between align-items-center mb-3">
								<h4 class="text-right">GameZone | 회원가입</h4>
							</div>
							<div class="row mt-3">
								<!-- id -->
								<div class="col-md-12">
									<label class="id">I D</label><br> 
									<input type="text" class="iform-control controlBox" name="id" id="id" placeholder="영문, 숫자 5~10자만 가능">
									<button class="idDuplicationCheck" type="button" id="idDuplicationCheck" onclick="idDupCheck()">ID 중복확인</button><br>
									<b><span id="iMessage" class="eMessage"></span></b>
								</div>
								<!-- id end -->
	
								<!-- password -->
								<div class="col-md-12">
									<label class="password">PassWord</label>
									<input type="password" class="form-control controlBox" name="password" id="password" placeholder="특수문자 반드시 포함">
									<b><span id="pMessage" class="eMessage"></span></b>
								</div>
								<!-- password end -->
	
								<!-- password2 -->
								<div class="col-md-12">
									<label class="password2" for="password">PW 확인</label>
									<input type="password" class="form-control controlBox" name=password2 id=password2>
									<b><span id="ppMessage" class="eMessage"></span></b>
								</div>
								<!-- password2 end -->

								<!-- name -->
								<div class="col-md-12">
									<label class="user_name">Name</label>
									<input type="text" class="form-control controlBox" name="user_name" id="user_name">
									<b><span id="nMessage" class="eMessage"></span></b>
								</div>
								<!-- name end -->

								<!-- gender -->
								<div class="gcol-md-12">
									<label class="labels">Gender</label>
									<div class="radio_m">
										<span class="gradio_w">여</span>
										<input class="gradio" type="radio" name="gender" value="1" checked <c:if test="${one.gender == 1}">checked</c:if>> 
										<span class="gradio_m">남</span>
										<input class="gradio" type="radio" name="gender" value="2" <c:if test="${one.gender == 2}">checked</c:if>><br>
									</div>
								</div>
								<!-- gender end -->

								<!-- email -->
								<div class="col-md-12">
									<label class="birth_year">BirthDay</label>
									<div class="join_birth" id="birthday">
										<select class="year-select" name="birth_year" id="birth_year">
											<option id="year" disabled selected>출생 연도</option>
										</select> 
										<select class="month-select" name="birth_month" id="birth_month">
											<option disabled selected>월</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
										<select class="day-select" name="birth_day" id="birth_day">
											<option disabled selected>일</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											<option value="13">13</option>
											<option value="14">14</option>
											<option value="15">15</option>
											<option value="16">16</option>
											<option value="17">17</option>
											<option value="18">18</option>
											<option value="19">19</option>
											<option value="20">20</option>
											<option value="21">21</option>
											<option value="22">22</option>
											<option value="23">23</option>
											<option value="24">24</option>
											<option value="25">25</option>
											<option value="26">26</option>
											<option value="27">27</option>
											<option value="28">28</option>
											<option value="29">29</option>
											<option value="30">30</option>
											<option value="31">31</option>
										</select>
									</div>
									<b><span id="bMessage" class="eMessage"></span></b>
								</div>
								<!-- birthday end -->

								<div class="col-md-12">
									<label class="phone">Phone</label>
									<input type="text" class="form-control controlBox" name="phone" id="phone" placeholder="번호만 입력해주세요.  예) 01012345678">
									<b><span id="phMessage" class="eMessage"></span></b>
								</div>
	
								<div class="ecol-md-12">
									<label class="email">Email</label><br>
									<input type="text" class="eform-control controlBox" id="email" name="email" value="${one.email}" placeholder="[ -  _ ] 사용 가능">
									<input name="dw" class="dform-control controlBox" id="dw" type="text" value="${one.domain}" placeholder="@도메인"> 
									<select class="email-select" name="domain" id="domain">
										<option value="1">직접 입력</option>
										<option value="@naver.com">@naver.com</option>
										<option value="@gmail.com">@gmail.com</option>
										<option value="@daum.net">@daum.net</option>
										<option value="@nate.com">@nate.com</option>
										<option value="@kakao.com">@kakao.com</option>
									</select><br>
									<b><span id="emMessage" class="eMessage"></span></b>
								</div>

								<div class="email-check">
									<input type="button" id="emailCheck" value="이메일 인증하기">
									<div id="enter_auth_number">
										<input class="mail-check-input" id="check_number" placeholder="인증번호 6자리" maxlength="6">
										<input type="button" id="email_auth_key" value="인증번호 확인">
									</div>
									<b><span id="ecMessage" class="eMessage"></span></b>
								</div>
							</div>
						</div>
						<div class="button">
							<div class="text-center">
								<input class="btn btn-primary" type="submit" id="submit" value="가입" onclick="return inCheck()" disabled="disabled">
							</div>
							<div class="text-center">
								<input class="btn btn-primary" type="reset" value="취소">
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
	</main>
	
    <!-- Footer section -->
    <footer class="footer-section">
    	<div class="container">
        	<ul class="footer-menu">
            	<li><a href="home">Home</a></li>
             	<li><a href="axPcGame">PC 게임</a></li>
             	<li><a href="axMobileGame">모바일 게임</a></li>
             	<li><a href="boardList">자유 게시판</a></li>
             	<li><a href="qnaBoardList">Q&amp;A</a></li>
          	</ul>
          	<p class="copyright">
            	Copyright &copy;
            	<script>document.write(new Date().getFullYear());</script>
             	All rights reserved | This project is made with 
             	<i class="fa fa-heart-o" aria-hidden="true"></i> by 
             	<a href="#" target="_blank">GameZone</a>
          	</p>
       	</div>
    </footer>
    <!-- Footer section end -->
</body>
	<script type="text/javascript">
    	//도메인 직접 입력 or domain option 선택
		const domainListEl = document.querySelector('#domain');
        const domainInputEl = document.querySelector('#dw');

        // select 옵션 변경 시
		domainListEl.addEventListener('change', (event) => {
			// option에 있는 도메인 선택 시
			if (event.target.value !== "1") {
				// 선택한 도메인을 input에 입력하고 disabled
				domainInputEl.value = event.target.value
               	domainInputEl.disabled = true
            } else { // 직접 입력 시
				// input 내용 초기화 & 입력 가능하도록 변경
               	domainInputEl.value = ""
               	domainInputEl.disabled = false
            }
		});

		// '생년' 셀렉트 박스 option 목록 동적 생성
		const birthYear = document.querySelector('#birth_year')
		/* const birthMonth = document.querySelector('#birth_month')
		const birthDay = document.querySelector('#birth_day') */

		// option 목록 생성 여부 확인
		isYearOptionExisted = false;
		
		birthYear.addEventListener('focus', function () {
			// year 목록 생성되지 않았을 때 (최초 클릭 시)
            if (!isYearOptionExisted) {
				isYearOptionExisted = true
				
				for (var i = 1940; i <= 2022; i++) {
					// option element 생성
					const YearOption = document.createElement('option')
					YearOption.setAttribute('value', i)
					YearOption.innerText = i
					// birthYearEl의 자식 요소로 추가
					this.appendChild(YearOption);
				}
			}
		});
	</script>
</html>