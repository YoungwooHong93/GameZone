<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | ${one.game_name}</title>
	<link rel="stylesheet" type="text/css" href="/css/myStyle.css">
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
      
		function goSite(site) {
        	console.log($('.btmSocial').val());
           
	       	if ($('.btmSocial').val() == '' || $('.btmSocial').val() == null) {
	        	location.href="exception_404.jsp";
	          
	       	} else {
	        	location.href=site;
	       	}
        
		} // goSite
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
    <main>
        <div class="content-left" align="center">
            <!--기본 정보-->
            <c:if test="${not empty one}">
                <h2 class="h_gm"><strong>${one.game_name}</strong></h2>
                <div class="gm_info_area ">
                    <div class="gm_info">
                        <div class="gameThumb">
                            <img src="${one.game_img}">
                        </div>
                        <div class="GmaeInfoTxt">
                            <ul>
                                <li class="leftA">장르 : </li>
                                <li class="rightA">
	                                <c:set var="category1" value="${one.category}" />
	                                <c:set var="category2" value="${fn:replace(category1, 'action', '액션')}" /> 
	                                <c:set var="category3" value="${fn:replace(category2, 'rpg', 'RPG')}" />
	                                <c:set var="category4" value="${fn:replace(category3, 'adventure', '어드벤처')}" />
	                                <c:set var="category5" value="${fn:replace(category4, 'strategy', '전략')}" />
	                                <c:set var="category6" value="${fn:replace(category5, 'simulation', '시뮬레이션')}" />
	                                <c:set var="category7" value="${fn:replace(category6, 'sports', '스포츠')}" />
	                                <c:set var="category8" value="${fn:replace(category7, 'racing', '레이싱')}" />
	                                <c:set var="category9" value="${fn:replace(category8, 'survival', '서바이벌')}" />
	                                <c:set var="category10" value="${fn:replace(category9, 'casual', '캐주얼')}" />
	                                <c:set var="category11" value="${fn:replace(category10, 'openworld', '오픈월드')}" />
	                                <c:set var="category12" value="${fn:replace(category11, 'puzzle', '퍼즐')}" />
	                                <c:set var="category13" value="${fn:replace(category12, 'quiz', '퀴즈')}" />
	                                <c:set var="category14" value="${fn:replace(category13, 'shooting', '슈팅')}" />
	                                <c:set var="category15" value="${fn:replace(category14, 'battleroyale', '배틀로얄')}" />
	                                <c:set var="category16" value="${fn:replace(category15, 'rhythm', '리듬')}" />
	                                <c:set var="category17" value="${fn:replace(category16, 'classic', '고전')}" />
	                                <c:set var="category18" value="${fn:replace(category17, 'threedim', '3D')}" />
	                                <c:set var="category19" value="${fn:replace(category18, 'horror', '호러')}" />
	                                <c:set var="category20" value="${fn:replace(category19, 'card', '카드')}" />
	                                ${category20}
                                </li>
                            </ul>
                            <ul>
                                <li class="leftA">가격 : </li>
                                <li class="rightA">${one.price}</li>
                            </ul>
                            <ul>
                                <li class="leftA">출시일 : </li>
                                <li class="rightA">${one.launch}</li>
                            </ul>
                            <ul>
                                <li class="leftA">배급사 : </li>
                                <li class="rightA">${one.publisher}</li>
                            </ul>
                            <ul>
                                <li class="leftA">이용등급 : </li>
                                <li class="rightA">${one.grade}</li>
                            </ul>
                            <p class="btmSocial" onclick="return goSite(${one.site})">
                            	<a href="${one.site}" target="_blank">공식사이트</a>
                            </p>
                        </div>
                    </div>
                </div>

                <div>
                    <!-- 게임소개 -->
                    <div class="db-cont1">
                        <div class="title ">게임소개</div>
                        <div class="db-cont1-left">${one.intro}</div>
                    </div>
                    <!-- 게임소개 -->

                    <!-- 시리즈 -->
                    <div class="db-cont1">
                        <div class="title ">시리즈</div>
                        <div class="db-cont1-left">
                            <span class="no-contents">관련 정보가 없습니다</span>
                        </div>
                    </div>

                    <div class="db-cont1">
                        <div class="title">동영상</div>
                        <div class="db-cont1-left">
                            <iframe src="${one.video}?autoplay=1&mute=1" width="650" height="368" allow="autoplay" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${loginID=='admin'}">
                &nbsp;&nbsp;<a href="detailPcGame?jCode=U&game_name=${one.game_name}">[게임 수정]</a>
                &nbsp;&nbsp;<a href="deletePcGame?game_name=${one.game_name}" onclick="return deleteGame()">[게임 삭제]</a>
                &nbsp;&nbsp;<a href="javascript:history.go(-1)">[목록]</a>
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