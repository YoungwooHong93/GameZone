<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<title>Welcome to GameZone</title>
	<link rel="shortcut icon" href="resources/img/icon2.ico">
   	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
   	<link rel="stylesheet" href="resources/css/style.css" />
   	<link rel="stylesheet" href="resources/css/animate.css" />
   	<script>
    	function detailContent() {
        	alert('로그인 후 상세보기가 가능합니다 :-)')
        } // detailContent
   	</script>
</head>
<body>
	<!-- Page Preloder -->
   	<div id="preloder">
    	<div class="loader"></div>
   	</div>

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
   	<!-- Header section End -->
	<!-- Hero section -->
   	<section class="hero-section">
    	<div class="hero-slider owl-carousel">
        	<div class="hs-item set-bg" data-setbg="resources/img/EuroTruck4.jpg">
            	<div class="hs-text">
               		<div class="container">
                  		<h2>The Best <span>Games</span> Out There</h2>
                  		<p id="slide_title">EURO TRUCK SIMULATOR 2<p>
                  		<p id="slide_content1">도로의 왕인 트럭 기사로서 유럽을 여행하며<br>
                    		놀라울 정도의 거리를 주행하여 중요한 화물을 전달하십시오!
                  		</p>
                   		<c:if test="${not empty loginID}">
                  			<!-- detailPcGame?game_name=연결시킬 게임이름 -->
                     		<a href="detailPcGame?game_name=Euro%20Truck%20Simulator%202" class="site-btn" onclick="loginCheck()">더 보기</a>
                   		</c:if> 
                  
                  		<c:if test="${empty loginID}">
                     		<!-- detailPcGame?game_name=연결시킬 게임이름 -->
                     		<a href="#" class="site-btn" onclick="detailContent()">더 보기</a>
                  		</c:if> 
               		</div>
            	</div>
         	</div>
         	
         	<div class="hs-item set-bg" data-setbg="resources/img/Battleground_bg2.jpg">
				<div class="hs-text">
               		<div class="container">
	                  	<h2>The Best <span>Games</span> Out There</h2>
	                  	<p id="slide_title">PUBG: BATTLEGROUNDS<p>
	                  	<p>다양한 전장에서 전략적 위치를 선점하고<br>
	                    	무기와 장비를 확보해 최후의 1인이 되기 위한 생존의 사투를 펼칩니다.<br>
	                     	친구들과 함께 팀을 만들어 배틀로얄 건플레이 장르의 선구자인<br>
	                     	PUBG: BATTLEGROUNDS만이 선사하는 긴장감 넘치는 경험을 위해 도전하세요.
	                  	</p>
	                  	<c:if test="${not empty loginID}">
	                    	<!-- detailPcGame?game_name=연결시킬 게임이름 -->
	                     	<a href="detailPcGame?game_name=PUBG:%20배틀그라운드" class="site-btn">더 보기</a>
	                  	</c:if>
	                  
	                  	<c:if test="${empty loginID}">
	                    	<!-- detailPcGame?game_name=연결시킬 게임이름 -->
	                     	<a href="#" class="site-btn" onclick="detailContent()">더 보기</a>
	                  	</c:if>   
               		</div>
            	</div>
         	</div>
      	</div>
	</section>
   	<!-- Hero section end -->
   	<!-- Latest news section -->
   	<div class="latest-news-section">
    	<div class="ln-title">게임 소개</div>
      	<div class="news-ticker">
        	<div class="news-ticker-contant">
            	<div class="nt-item">
               		<span class="new">출시예정</span>디아블로 Ⅳ : 2023년 4월 출시 예상! 
            	</div>
            	<div class="nt-item">
               		<span class="strategy">전략 게임</span>문명 5 : 플레이어들은 원시시대부터 우주시대까지 문명을 건설하고 이끌며 세계의 지배자가 되기 위해 사투를...
            	</div>
            	<div class="nt-item">
               		<span class="racing">RPG</span>로스트 아크 : 스마일게이트에서 만든 신작 쿼터뷰 MMORPG로 총 6개의 클래스와 클래스별로 전직 가능한...
            	</div>
         	</div>
      	</div>
   	</div>
   	<!-- Latest news section end -->
   	<!-- Feature section -->
   	<section class="feature-section spad">
    	<div class="section-title">
        	<div class="cata new">PC Online</div>
         	<h2>PC 게임</h2>
      	</div>
      	<div class="container">
        	<div class="row">
            	<div class="col-lg-3 col-md-6 p-0">
               		<div class="feature-item set-bg" data-setbg="resources/img/features/디아블로4.png">
                  		<span class="cata new">출시예정</span>
                  		<div class="fi-content text-white">
                     		<c:if test="${not empty loginID}">
                        		<h5><a href="detailPcGame?game_name=디아블로%20IV">디아블로 4</a></h5>
                        		<p>세 명의 영웅이 이 땅을 잠식하고 있는 형언 불가능한 공포와 맞서 싸울 준비를 마쳤습니다... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://diablo4.blizzard.com/ko-kr/" class="fi-comment" target="_blank">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">디아블로 4</a></h5>
                        		<p>세 명의 영웅이 이 땅을 잠식하고 있는 형언 불가능한 공포와 맞서 싸울 준비를 마쳤습니다... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://diablo4.blizzard.com/ko-kr/" class="fi-comment" target="_blank">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6 p-0">
               		<div class="feature-item set-bg" data-setbg="resources/img/features/문명5.jpg">
                  		<span class="cata strategy">전략 게임</span>
                  		<div class="fi-content text-white">
                     		<c:if test="${not empty loginID}">
                        		<!-- detailPcGame?game_name=연결시킬 게임이름 -->
                        		<h5><a href="detailPcGame?game_name=시드%20마이어의%20문명%205">문명 5</a></h5>
                        		<p>플레이어들은 원시시대부터 우주시대까지 문명을 건설하고 이끌며 세계의 지배자가 되기 위해 사투를... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://civilization.com/ko-KR/" class="fi-comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">문명 5</a></h5>
                        		<p>플레이어들은 원시시대부터 우주시대까지 문명을 건설하고 이끌며 세계의 지배자가 되기 위해 사투를... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://civilization.com/ko-KR/" class="fi-comment" target="_blank">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6 p-0">
               		<div class="feature-item set-bg" data-setbg="resources/img/features/오버워치2.jpg">
                  		<span class="cata new">Hot</span>
                  		<div class="fi-content text-white">
                     		<c:if test="${not empty loginID}">
                        		<!-- detailPcGame?game_name=연결시킬 게임이름 -->
                        		<h5><a href="detailPcGame?game_name=오버워치%202">오버워치 2</a></h5>
                        		<p>오버워치 2는 희망적인 미래를 배경으로 펼쳐지는 팀 기반 액션 무료 플레이 게임으로... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://overwatch.blizzard.com/ko-kr/" class="fi-comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                       	 		<h5><a href="#" class="pointer" onclick="detailContent()">오버워치 2</a></h5>
                        		<p>오버워치 2는 희망적인 미래를 배경으로 펼쳐지는 팀 기반 액션 무료 플레이 게임으로... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="https://overwatch.blizzard.com/ko-kr/" class="fi-comment" target="_blank">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6 p-0" style="border-right: 0px;">
               		<div class="feature-item set-bg" data-setbg="resources/img/features/로스트아크.jpg">
                  		<span class="cata racing">RPG</span>
                  		<div class="fi-content text-white">
                     		<c:if test="${not empty loginID}">
	                        	<!-- detailPcGame?game_name=연결시킬 게임이름 -->
	                        	<h5><a href="detailPcGame?game_name=로스트아크">로스트아크</a></h5>
	                        	<p>스마일게이트에서 만든 신작 쿼터뷰 MMORPG로 총 6개의 클래스와 클래스별로 전직 가능한... </p>
	                        	<!-- 연결시킬 게임사이트 주소 넣기 -->
	                        	<a href="http://lostark.game.onstove.com/" class="fi-comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">로스트아크</a></h5>
                        		<p>스마일게이트에서 만든 신작 쿼터뷰 MMORPG로 총 6개의 클래스와 클래스별로 전직 가능한... </p>
                        		<!-- 연결시킬 게임사이트 주소 넣기 -->
                        		<a href="http://lostark.game.onstove.com/" class="fi-comment" target="_blank">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
         	</div>
      	</div>
	</section>
   	<!-- Feature section end -->
   	<!-- Recent game section  -->
   	<section class="recent-game-section spad set-bg" data-setbg="resources/img/recent-game-bg.png">
    	<div class="container">
        	<div class="section-title">
            	<div class="cata new">Mobile</div>
            	<h2 style="color: black;">모바일 게임</h2>
         	</div>
         	<div class="row">
            	<div class="col-lg-4 col-md-6">
               		<div class="recent-game-item">
                  		<div class="rgi-thumb set-bg" data-setbg="resources/img/recent-game/라그나로크X.jpg">
                     		<div class="cata new">출시예정</div>
                  		</div>
                  		<div class="rgi-content">
                     		<c:if test="${not empty loginID}">
                        		<h5><a href="detailMobileGame?game_name=라그나로크X:%20Next%20Generation">라그나로크X: Next Generation</a></h5>
                        		<p>[라그나로크 X: Next Generation]은 U3D 엔진을 사용, 라그나로크 온라인의 내용을 기반으로... </p>
                        		<a href="https://rox.gnjoy.com/pre-register" class="comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">라그나로크X: Next Generation</a></h5>
                        		<p>[라그나로크 X: Next Generation]은 U3D 엔진을 사용, 라그나로크 온라인의 내용을 기반으로... </p>
                        		<a href="https://rox.gnjoy.com/pre-register" class="comment">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-4 col-md-6">
               		<div class="recent-game-item">
                  		<div class="rgi-thumb set-bg" data-setbg="resources/img/recent-game/탕탕특공대.jpg">
                     		<div class="cata racing">HOT</div>
                  		</div>
                  		<div class="rgi-content">
                     		<c:if test="${not empty loginID}">
                        		<h5><a href="detailMobileGame?game_name=탕탕특공대">탕탕특공대</a></h5>
                        		<p>위험한 좀비들이 도시 전체를 공격하고 있습니다! 도시가 위기에 빠졌어요! 적군이 너무 강해서... </p>
                        		<a href="https://www.facebook.com/%ED%83%95%ED%83%95%ED%8A%B9%EA%B3%B5%EB%8C%80-104971712253133" class="comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">탕탕특공대</a></h5>
                        		<p>위험한 좀비들이 도시 전체를 공격하고 있습니다! 도시가 위기에 빠졌어요! 적군이 너무 강해서... </p>
                        		<a href="https://www.facebook.com/%ED%83%95%ED%83%95%ED%8A%B9%EA%B3%B5%EB%8C%80-104971712253133" class="comment">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-4 col-md-6">
               		<div class="recent-game-item">
                  		<div class="rgi-thumb set-bg" data-setbg="resources/img/recent-game/바람의나라연.jpg">
                     		<div class="cata adventure">RPG</div>
                  		</div>
                  		<div class="rgi-content">
                     		<c:if test="${not empty loginID}">
                        		<h5><a href="detailMobileGame?game_name=바람의나라:%20연">바람의나라: 연</a></h5>
                        		<p>플레이어들은 원시시대부터 우주시대까지 문명을 건설하고 이끌며 세계의 지배자가 되기 위해... </p>
                        		<a href="https://baramy.nexon.com/?channel=3801" class="comment">공식사이트</a>
                     		</c:if>
                     
                     		<c:if test="${empty loginID}">
                        		<h5><a href="#" class="pointer" onclick="detailContent()">바람의나라: 연</a></h5>
                        		<p>플레이어들은 원시시대부터 우주시대까지 문명을 건설하고 이끌며 세계의 지배자가 되기 위해... </p>
                        		<a href="https://baramy.nexon.com/?channel=3801" class="comment">공식사이트</a>
                     		</c:if>
                  		</div>
               		</div>
            	</div>
         	</div>
      	</div>
   	</section>
   	<!-- Recent game section end -->
   	<!-- Review section -->
   	<section class="review-section spad set-bg" data-setbg="resources/img/review-bg.png">
    	<div class="container text-white">
        	<div class="section-title">
            	<div class="cata new">Ranking</div>
            	<h2>PC방 게임 점유율 순위</h2>
         	</div>
         	<div class="row">
            	<div class="col-lg-3 col-md-6">
               		<div class="review-item">
                  		<div class="review-cover set-bg" data-setbg="resources/img/review/leagueoflegends.jpg">
                     		<div class="score yellow">39%</div>
                  		</div>
                  		<div class="review-text">
                     		<h5>리그 오브 레전드</h5>
                     		<p>세계 최고의 MOBA(Multiplayer Online Battle Arena)게임이며, RTS와 RPG를 하나의 게임에서 동시에 즐길 수 있는 새로운 장르의 온라인 게임입니다.</p>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6">
               		<div class="review-item">
                  		<div class="review-cover set-bg" data-setbg="resources/img/review/FIFA온라인4.png">
                     		<div class="score purple">13%</div>
                  		</div>
                  		<div class="review-text">
                     		<h5>FIFA 온라인 4</h5>
                     		<p>FIFA 온라인 4 (EA Sports™ FIFA Online 4)는 EA 산하의 스피어헤드에서 개발하고 넥슨이 배급하는 피파 온라인 3의 후속작이다.</p>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6">
               		<div class="review-item">
                  		<div class="review-cover set-bg" data-setbg="resources/img/review/오버워치2.jpg">
                     		<div class="score green">8%</div>
                  		</div>
                  		<div class="review-text">
                     		<h5>오버워치 2</h5>
                     		<p>오버워치 2는 희망적인 미래를 배경으로 펼쳐지는 팀 기반 액션 무료 플레이 게임으로, 플레이어는 5대5 전장에서 난투를 벌이게 됩니다.</p>
                  		</div>
               		</div>
            	</div>
            	<div class="col-lg-3 col-md-6" style="border-right: 0px;">
               		<div class="review-item">
                  		<div class="review-cover set-bg" data-setbg="resources/img/review/서든어택.png">
                     		<div class="score pink">6%</div>
                  		</div>
                  		<div class="review-text">
                     		<h5>서든어택</h5>
                     		<p>넥슨GT에서 제작하고 넥슨에서 배급하는 온라인 슈팅 게임. 기습공격이라는 뜻이며 이 게임때문에 국내에서는 서든이라는 단어 자체가 이 게임을 명칭하는 용어나 다름없게 되었다.</p>
                  		</div>
               		</div>
            	</div>
         	</div>
      	</div>
   	</section>
   	<!-- Review section end -->
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
   	<script src="resources/js/jquery-3.2.1.min.js"></script>
   	<script src="resources/js/owl.carousel.min.js"></script>
   	<script src="resources/js/jquery.marquee.min.js"></script>
   	<script src="resources/js/main.js"></script>
</body>
</html>