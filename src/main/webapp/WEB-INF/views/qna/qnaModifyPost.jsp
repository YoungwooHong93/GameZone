<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 문의글 수정</title>
	<link rel="stylesheet" type="text/css" href ="resources/css/myStyle.css">
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>
		function modifyQnA() {
			
			if (confirm("수정하시겠습니까? (Yes : 확인 / No : 취소)")) {
	           	return true;
			} else {
	           	alert('수정이 취소되었습니다.');
				return false;
			}
		} // modifyQnA(수정)
		
		function removeQnA() {
			
			if (confirm("삭제하시겠습니까? (Yes : 확인 / No : 취소)")) {
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
                  		<a href="loginForm">로그인</a> / <a href="joinForm">회원가입</a>
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
   	<section>
		<form action="qnaModifyPost" method="post">
			<table>
				<tr>
					<td>Seq</td>
					<td><input type="text" name="seq" value="${one.seq}" size="20" readonly></td>
				</tr>
				<tr>
					<td>I D</td>
					<td><input type="text" name="id" value="${one.id}"  size="20" readonly> </td>
				</tr>
				<tr>
					<td>Title</td>
					<td><input type="text" name="title" value="${one.title}"> </td>
				</tr>
				<tr>
					<td>Content</td>
					<td><textarea rows="5" cols="50" name="content">${one.content}</textarea></td>
				</tr>
				<tr>
					<td>RegDate</td>
					<td><input type="text" name="regdate" value="${one.regdate}"  readonly></td>
				</tr>
				<tr>
					<td>조회수</td>
					<td><input type="text" name="cnt" value="${one.cnt}"  size="20" readonly></td>
				</tr>
				
				<tr>
					<td></td>
					<td>
						<input type="submit" value="글 수정" onclick="return modifyQnA()">&nbsp;&nbsp;
						<a href="javascript:history.go(-1)">취소</a>
					</td>
				</tr>
			</table>
		</form>
		<c:if test="${not empty message}">
			<hr><${message}<br>
		</c:if>
		
		<c:if test="${loginID == one.id || loginID == 'admin'}">&nbsp;&nbsp;
	      <a href="qnaRemovePost?seq=${one.seq}&root=${one.root}" onclick="return removeQnA()">[글 삭제]</a>
		</c:if>
		<br> 
		&nbsp;&nbsp;<a href="qnaBoardList">목록으로</a>
	</section>
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
	<!--====== Javascripts & Jquery ======-->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/owl.carousel.min.js"></script>
	<script src="resources/js/jquery.marquee.min.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>