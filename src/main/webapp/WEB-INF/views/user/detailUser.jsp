<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 내 정보 보기</title>
	<link rel="stylesheet" href="resources/css/user.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/inCheck.js"></script>
	<script>
		function deleteUser() {
			if (confirm("탈퇴하시겠습니까? (Yes : 확인 / No : 취소)")) {
               	return true; // 탈퇴
               	
			} else {
               	alert('탈퇴가 취소되었습니다.');
				return false;
			}
		} // delete(탈퇴)
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
	<main class="detail_main">
		<div class="container rounded bg-white">
			<div class="row">
				<div class="col-md-3">
					<div class="d-flex flex-column align-items-center text-center p-3 py-5">
						<img src="${one.uploadimg}" class="select_img" width="230" height="300"><br>
						<h4><input type="text" class="font-weight-bold profile_id" value="${one.id}" name="id" id="id" readonly></h4>
						<h5 style="min-width: 300px;"><input type="text" class="text-black-50 profile_email" value="${one.email}${one.domain}" readonly></h5>
					</div>
				</div>

				<div class="col-md-5">
					<div class="p-3 py-5">
						<div class="d-flex justify-content-between align-items-center mb-4">
							<h4 class="text-right text-white">GameZone | 내 정보</h4>
						</div>
						<div class="row mt-3">
							<div class="col-md-12">
								<label class="labels">I D</label> <input type="text" class="detail-form controlBox" name="id"
									id="id" value="${one.id}" readonly>
							</div>

							<div class="col-md-12">
								<label class="labels">Name</label> <input type="text" class="detail-form controlBox" name="id"
									id="id" value="${one.user_name}" readonly>
							</div>

							<div class="col-md-12">
								<label class="labels">Gender</label>
								<input type="text" class="detail-form controlBox" name="gender" id="gender" <c:if
									test="${one.gender == 1}">
									value="woman"
								</c:if>
								
								<c:if test="${one.gender == 2}">
									value="man"
								</c:if> readonly>
							</div>

							<div class="col-md-12">
								<label class="labels">BirthDay</label> <input type="text" class="detail-form controlBox"
									name="birthday" id="birthday" value="${one.birthday}" readonly>
							</div>
							
							<div class="col-md-12">
								<label class="labels">Phone</label> <input type="text" class="detail-form controlBox" name="phone"
									id="phone" value="${one.phone}" readonly>
							</div>

							<div class="col-md-12">
								<label class="labels">Email</label> <input type="text" class="detail-form controlBox" name="email"
									id="email" value="${one.email}${one.domain}" readonly>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="detail-menu">
			&nbsp;&nbsp;&nbsp;
			<a href="detailUser?jCode=U&id=${one.id}" class="detail-menubtn">내 정보 수정</a>
			&nbsp;&nbsp;&nbsp;
			<a href="detailUser?jCode=P&id=${one.id}" class="detail-menubtn">비밀번호 변경</a>
			<!-- password 수정하기 만들어야 됨 -->

			&nbsp;&nbsp;&nbsp; <a href="javascript:history.go(-1)" class="detail-menubtn">이전으로</a>
			&nbsp; &nbsp; &nbsp; &nbsp;
			&nbsp;&nbsp;&nbsp; <a href="deleteUser?id=${one.id}" class="detail-menubtn" onclick="return deleteUser()">회원 탈퇴</a>
		</div>
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