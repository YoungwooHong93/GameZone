<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 댓글 작성</title>
	<link rel="stylesheet" type="text/css" href="/resources/myLib/myStyle.css">
	<!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico" />
	<script src="resources/js/jquery-3.2.1.min.js"></script>

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

	<form action="writeReply" method="post">
		<table>
			<tr height="40">
				<td bgcolor="violet">아이디</td>
				<td><input type="text" name="id" value="${loginID}" size="20"
					readonly></td>
			</tr>
			<tr height="40">
				<td bgcolor="violet">제목</td>
				<td><input type="text" name="title"
					placeholder="제목을 반드시 입력하세요."></td>
			</tr>
			<tr height="40">
				<td bgcolor="violet">내용</td>
				<td><textarea rows="5" cols="50" name="content"></textarea></td>
			</tr>
			<!-- 답글 등록시 필요한 부모글의 root, step, indent 전달을 위함 
			-> 매핑 메서드의 인자로 정의된 vo 와 param 모두 가능 -->
			<tr height="40">
				<td></td>
				<td>
					<input type="text" name="root" value="${boardVO.root}" hidden> 
					<input type="text" name="step" value="${boardVO.step}" hidden> 
					<input type="text" name="indent" value="${param.indent}" hidden>
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<input type="submit" value="등록">&nbsp;&nbsp; 
					<a href="javascript:history.go(-1)"><input type="button" value="취소"></a>
				</td>
			</tr>
		</table>
	</form>

	<c:if test="${not empty message}">
		<hr>
	${message}<br>
	</c:if>
	<hr>

	&nbsp;&nbsp;
	<a href="boardList">목록으로</a> &nbsp;&nbsp;
	<a href="javascript:history.go(-1)">이전으로</a>
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
             <script>
                         document.write(new Date().getFullYear());
                   </script>
             All rights reserved | This template is made with <i
                class="fa fa-heart-o" aria-hidden="true"></i> by <a
                href="#" target="_blank">GameZone</a>
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