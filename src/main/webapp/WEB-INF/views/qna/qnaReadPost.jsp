<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | ${one.title}</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>
		function removeQnA() {
			if (confirm("삭제하시겠습니까? (Yes : 확인 / No : 취소)")) {
				
				alert('문의글 삭제하겠습니다.');
	           	return true; // 삭제
			} else {
	           	alert('삭제가 취소되었습니다.');
				return false;
			}
		} // removeQnA(삭제)
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
   	
   	<main>
		<hr>
		<h2>${one.title}</h2>
		<c:if test="${not empty one}">
			<table>
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">Seq</th>
					<td>${one.seq}</td>
				</tr>
				
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">I  D</th>
					<td>${one.id}</td>
				</tr>
				
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">Title</th>
					<td>${one.title}</td>
				</tr>
				
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">Content</th>
					<td><textarea rows="5" cols="50" readonly>${one.content}</textarea></td>
				</tr>
				
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">RegDate</th>
					<td>${one.regdate}</td>
				</tr>
				
				<tr height="40">
					<th bgcolor="DarkKhaki" style="text-align: center;">조회수</th>
					<td>${one.cnt}</td>
				</tr>
			</table>
		</c:if>
	
		<hr>
		<c:if test="${loginID == one.id || loginID == 'admin'}">&nbsp;&nbsp;&nbsp;
			<a href="qnaReadPost?jCode=U&seq=${one.seq}">[문의글 수정]</a>&nbsp;&nbsp;&nbsp;
										<!-- root 추가 : 삭제 시 원글 삭제 or 댓글 삭제 확인을 위함 -->
			<a href="qnaRemovePost?seq=${one.seq}&root=${one.root}" onclick="return removeQnA()">[문의글 삭제]</a>
		</c:if>
	
		<c:if test="${not empty loginID}">&nbsp;&nbsp;&nbsp; 
			<!-- 로그인ID가 비어있지 않다면 = 로그인을 했다면 -->
			<c:if test="${loginID == 'admin'}">
				<a href="qnaWriteReplyForm?root=${one.root}&step=${one.step}&indent=${one.indent}&secret=${one.secret}">[답글 달기]</a>&nbsp;&nbsp;&nbsp;
			</c:if>
			<a href="javascript:history.go(-1)">[목록으로]</a>
		</c:if>
		<hr>
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
	<!-- ====== Javascripts & Jquery ====== -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/owl.carousel.min.js"></script>
	<script src="resources/js/jquery.marquee.min.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>