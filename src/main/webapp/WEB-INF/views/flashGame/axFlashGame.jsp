<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 플래시게임 리스트</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/js/axFlashGame.js"></script>
	<script>
        function detailContent() {
        	alert('로그인 후 상세보기가 가능합니다 :-)')
        } // detailContent
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
   	<main id="Game_main">
    	<div id="gameSearchBar">
			<form action="axFlashGame" method="get" id="GameForm">
				<div style="display: none;"></div>
            	<div id="search" class="search_part">
               		<input type="text" name="keyword" id="keyword" value="${GamePageMaker.gameCriteria.keyword}" placeholder="게임명으로 검색" class="search_box">
               		<input type="button" value="검색" id="axFlashGame">
               		<!-- <input type="reset" value="취소" onclick="checkClear()"> -->
            	</div>
	         	<c:if test="${loginID == 'admin'}">
	            	<a href="insertFlashForm">새로운 게임 등록</a>
	         	</c:if>
            	<br>
			</form>
      	</div>
      	<div id="resultArea" class="GameList">
      		<div>
				<div class="flashLink"> 클릭 시 와플래시 게임 아카이브 페이지로 이동합니다.</div>
			</div>
	    	<div class="searchresult">
	        	<div> 검색결과 : ${gamePageMaker.totalRowsCount} 건</div>
	      	</div>
          	<table style="width: 100;" class="game_table">
            	<c:if test="${not empty list}">
                	<c:forEach var="flashgame" items="${list}">
                   		<tr>
                   			<td class="flash_td">
                      			<!-- admin 제외하고 로그인을 한 경우에만 해당 게임 사이트로 이동 가능 -->
	                         	<c:if test="${not empty loginID && loginID != 'admin'}">
		                           	<a href="${flashgame.site}" target="_blank"> 
										<img class="flash_game_img" src="${flashgame.game_img}">
									</a>
									<a class="flash_content" href="${flashgame.site}" target="_blank">${flashgame.game_name}</a>
	                         	</c:if> 
	                         	
	                         	<!-- admin으로 로그인 한 경우에만 detailFlashGame 확인 가능 --> 
								<c:if test="${loginID == 'admin'}">
									<a href="detailFlashGame?game_name=${flashgame.game_name}"> 
										<img class="flash_game_img" src="${flashgame.game_img}">
									</a>
									<a class="flash_content" href="detailFlashGame?game_name=${flashgame.game_name}">${flashgame.game_name}</a>
								</c:if>
								
	                         	<!-- loginID가 없을 때 -->
								<c:if test="${empty loginID}">
									<img class="pointer flash_game_img" src="${flashgame.game_img}" onclick="detailContent()">
									<a class="pointer flash_content" onclick="detailContent()">${flashgame.game_name}</a>
								</c:if>
	                   		</td>
                   		</tr>
                	</c:forEach>
             	</c:if>
             	
             	<c:if test="${empty list}">
                	<tr height="50">
                   		<td colspan="2">해당하는 게임이 존재하지 않습니다.</td>
                	</tr>
             	</c:if>
			</table>

         	<!-- ** Criteria_Page ** -->
			<div id="Criteria_Page">
				<!-- First, Prev -->
				<div id="Criteria_left">
	            	<c:choose>
	                	<c:when test="${gamePageMaker.prev && gamePageMaker.spageNo > 1}">
	                   		<a href="flashGameList${gamePageMaker.searchQuery(1)}" class="aclick"><img src="resources/img/first.png"></a>&nbsp;
	                   		<a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.spageNo-1)}" class="aclick"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
	                	</c:when>
	
		                <c:otherwise>
	                   		<font color="DimGray"><img src="resources/img/first.png">&nbsp;<img src="resources/img/left.png">&nbsp;&nbsp;</font>
	                	</c:otherwise>
	             	</c:choose>
	
	            	<!-- Display PageNo -->
	             	<c:forEach var="i" begin="${gamePageMaker.spageNo}" end="${gamePageMaker.epageNo}">
	                	<c:if test="${i == gamePageMaker.gameCriteria.currPage}">
	                   		<font size="5" color="DarkOrange">${i}</font>&nbsp;
	                	</c:if>
	
	                	<c:if test="${i != gamePageMaker.gameCriteria.currPage}">
	                   		<a href="flashGameList${gamePageMaker.searchQuery(i)}" class="aclick">${i}</a>&nbsp;
	                	</c:if>
	             	</c:forEach>
	
	            	<!-- Next, Last -->
	             	<c:choose>
	                	<c:when test="${gamePageMaker.next && gamePageMaker.epageNo > 0}">
	                   		<a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.epageNo+1)}" class="aclick"><img src="resources/img/right.png"></a>
	                   		<a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.lastPageNo)}" class="aclick">&nbsp;&nbsp;<img src="resources/img/last.png"></a>
	                	</c:when>
	 
	                	<c:otherwise>
	                   		<font color="DimGray">&nbsp;<img src="resources/img/right.png">&nbsp;&nbsp;<img src="resources/img/last.png"></font>
	                	</c:otherwise>
	             	</c:choose>
             	</div>
          	</div> <!-- Paging -->
       	</div> <!-- resultArea -->
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