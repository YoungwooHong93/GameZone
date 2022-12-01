<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 비밀번호 수정</title>
	<!-- <link rel="stylesheet" type="text/css" href="resources/css/myStyle.css"> -->
	<link rel="stylesheet" type="text/css" href="resources/css/user.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/inCheck.js"></script>
	<script>
		let opCheck = false;
		let pCheck = false;
		let ppCheck = false;	
		
		$(function() {
			
			$('#oldPassword').focus();
			
			// ** Old Password
			$('#oldPassword').keydown(function(e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#password').focus();
				}
			}).focusout(function() {
				opCheck = opwCheck();
			}); // oldPassword
	
			// ** Password
			$('#password').keydown(function(e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#password2').focus();
				}
			}).focusout(function() {
				pCheck = pwCheck();
			}); // password
			
			// ** Password
			$('#password2').keydown(function(e) {
				if (e.which == 13) {
					e.preventDefault();
					$('#submit').focus();
				}
			}).focusout(function() {
				ppCheck = pw2Check();
			}); // password2
			
		}); // ready
		
		function inCheck() {
			
			if (opCheck == false) {
				$('#opMessage').html('현재 비밀번호를 확인하세요.');
			}
			
			if (pCheck == false) {
				$('#pMessage').html('새 비밀번호를 확인하세요.');
			}
			
			if (ppCheck == false) {
				$('#ppMessage').html('비밀번호가 일치하지 않습니다.');
			}
			
			if (opCheck && pCheck && ppCheck) {
				
				if (confirm("비밀번호를 변경하시겠습니까 ? (Yes:확인 / No:취소)") == false) {
					alert('비밀번호 변경이 취소되었습니다.');
					return false;
					
				} else
					return true;
				
			} else {
				//alert('오류가 있습니다 다시 시도 부탁드립니다.');
				return false;
			}
		
		} // inCheck()
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
                  		<a href="loginUser">로그인</a> / <a href="joinForm">회원가입</a>
               		</c:otherwise>
            	</c:choose>
         	</div>
      	</div>
   	</header>
   	<!-- Header section end -->
   	<c:if test="${not empty message}">
		<script>
			alert(`${message}`);
		</script>		
	</c:if>
   	<main>
		<form action="updatePassword" method="post" id="myForm">
			<div class="container rounded bg-white">
				<div class="row">
					<div class="col-md-5 text-center">
						<div class="row mt-3 p-3 py-5">
							<div class="col-updatePw">
								<label class="labels" for="oldPassword">현재 비밀번호</label>
								<input type="password" name="oldPassword" id="oldPassword" class="controlBox" placeholder="현재 비밀번호">
								<div class="updatepwMessage">
									<b><span id="opMessage" class="eMessage"></span></b>
								</div>
							</div>

							<div class="col-updatePw">
								<label class="labels" for="password">새 비밀번호</label>
								<input type="password" name="password" id="password" class="controlBox" placeholder="특수문자 반드시 포함">
								<div class="updatepwMessage">
									<b><span id="pMessage" class="eMessage"></span></b>
								</div>
							</div>
							
							<div class="col-updatePw">
								<label class="labels" for="password2">새 비밀번호 확인</label>
								<input type="password" name=password2 id=password2 class="controlBox">
								<div class="updatepwMessage">
									<b><span id="ppMessage" class="eMessage"></span></b>
								</div>
							</div>
						</div>
						
						<div class="pwbutton">
							<div class="text-center">
								<input class="btn btn-primary" type="submit" value="수정" onclick="return inCheck()">
							</div>
							<div class="text-center">
								<input class="btn btn-primary" type="reset" value="리셋">
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="text-center">
								<a class="btn btn-primary" href="javascript:history.go(-1)">뒤로</a>
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
</html>