<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GameZone | ${one.game_name}</title>
    <link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.css" />
    <link rel="stylesheet" href="resources/css/style.css" />
    <link rel="stylesheet" href="resources/css/animate.css" />
    <link rel="stylesheet" href="resources/css/detailGame.css" />
    <link rel="shortcut icon" href="resources/img/icon2.ico">
    <script src="resources/js/jquery-3.2.1.min.js"></script>
    <script>
       function deleteGame() {
         if (confirm("삭제하시겠습니까? (Yes : 확인 / No : 취소)")) {
                 return true; // 삭제
                 
         } else {
                 alert('삭제가 취소되었습니다.');
            return false;
         }
       } // deleteGame
    </script>
    
    <style>
    	.content-left > a {
    	    border: 1px solid;
		    color: white;
		    background-color: black;
		    width: 150px;
		    border-radius: 5px;
    	}
    
    	.gameThumb > img {
    		max-width: 500px;
    		max-height: 500px;
    		min-width: 500px;
    		min-height: 500px;
    		transform: translateX(-130px);
    		border-radius: 20px;
    	}
    </style>
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
    <main class="main_min">
        <div class="content-left" align="center">
            <!-- intro 기본 정보 -->
            <c:if test="${not empty one}">
                <h2 class="h_gm"><strong>${one.game_name}</strong></h2>
                <div class="gm_info_area" style="margin: auto; height: 692px;">
                    <div class="gm_info" style="flex-direction: column">
                        <div class="gameThumb">
                            <img src="${one.game_img}">
                        </div>
                        <div class="GmaeInfoTxt" style="margin: 0; transform: translateY(220px);">
                            <p class="btmSocial">
                                <a href="${one.site}" target="_blank" style="font-size: 18px">게임사이트로 이동</a>
                            </p>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${loginID=='admin'}">
                &nbsp;&nbsp;<a href="detailFlashGame?jCode=U&game_name=${one.game_name}">게임 수정</a>
                &nbsp;&nbsp;<a href="deleteFlashGame?game_name=${one.game_name}" onclick="return deleteGame()" style="margin: 0px 10px 0px 15px;">게임 삭제</a>
            </c:if>
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
    <!-- ====== Javascripts & Jquery ====== -->
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/owl.carousel.min.js"></script>
    <script src="/js/jquery.marquee.min.js"></script>
    <script src="/js/main.js"></script>
</body>
</html>