<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 모바일게임 리스트</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axMobileGame.js"></script>
	<script>
    	function checkClear() {
        	$('.clear').attr('checked', false);
           	return false; // reset의 기본 onclick 취소
   		} // checkClear
        
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
   	<main id="Game_main">
   		<div id="rank_section">
			<span> 게임검색순위 TOP 10</span>
			<ol class="rank_list">
				<c:if test="${not empty rank}">
					<c:if test="${not empty loginID}">
						<c:forEach var="rank" items="${rank}">
							<li>
								<a class="rank_list" href="detailMobileGame?game_name=${rank.game_name}">${rank.game_name}</a>
							</li>
						</c:forEach>
					</c:if>
				
					<c:if test="${empty loginID}">
						<c:forEach var="rank" items="${rank}">
							<li>
								<span class="rank_list pointer" href="detailMobileGame?game_name=${rank.game_name}" onclick="detailContent()">${rank.game_name}</span>
							</li>
						</c:forEach>
					</c:if>
				</c:if>
			</ol>
		</div>
     
     	<div id="gameSearchBar">
			<form action="axMobileGame" method="get" id="GameForm">
            	<div>
               		<div id="left_title">
                  		<span><strong>장르</strong></span>
               		</div>
               		<div id="right_contents">
                  		<div class="game_category">
                    		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'action'}">
                              			<input type="checkbox" name="check" value="action" checked class="clear">액션 &nbsp;
                              			<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="action"> 액션 &nbsp;
                            	</c:if>
                     		</div>
                     
                     		<div>
                     			<c:set var="ckPrint" value="false" />
                     			<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                        			<c:if test="${category == 'rpg'}">
                           				<input type="checkbox" name="check" value="rpg" checked   class="clear">RPG &nbsp;
                              			<c:set var="ckPrint" value="true" />
                        			</c:if>
                     			</c:forEach>
                     			<c:if test="${not ckPrint}">
                        			<input type="checkbox" name="check" value="rpg"> RPG &nbsp;
                       			</c:if>
                     		</div>
                     
                     		<div>
                     			<c:set var="ckPrint" value="false" />
                     			<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                        			<c:if test="${category == 'adventure'}">
                           				<input type="checkbox" name="check" value="adventure" checked class="clear">어드벤쳐 &nbsp;
                              			<c:set var="ckPrint" value="true" />
                        			</c:if>
                     			</c:forEach>
                     			<c:if test="${not ckPrint}">
                        			<input type="checkbox" name="check" value="adventure"> 어드벤쳐 &nbsp;
                       			</c:if>
                     		</div>
                     
                     		<div>
                     			<c:set var="ckPrint" value="false" />
                     			<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                        			<c:if test="${category == 'strategy'}">
                           				<input type="checkbox" name="check" value="strategy" checked class="clear">전략 &nbsp;
                              			<c:set var="ckPrint" value="true" />
                        			</c:if>
                     			</c:forEach>
                     			<c:if test="${not ckPrint}">
                        			<input type="checkbox" name="check" value="strategy"> 전략 &nbsp;
                       			</c:if>
                     		</div>
                     
                     		<div>
                     			<c:set var="ckPrint" value="false" />
                     			<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                        			<c:if test="${category == 'simulation'}">
                           				<input type="checkbox" name="check" value="simulation" checked class="clear">시뮬레이션 &nbsp;
                              			<c:set var="ckPrint" value="true" />
                        			</c:if>
                     			</c:forEach>
                     			<c:if test="${not ckPrint}">
                        			<input type="checkbox" name="check" value="simulation"> 시뮬레이션 &nbsp;
                      	 		</c:if>
                       		</div>
                  		</div>
            
                  		<div class="game_category">
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'sports'}">
                              			<input type="checkbox" name="check" value="sports" checked class="clear">스포츠 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="sports"> 스포츠 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'racing'}">
                              			<input type="checkbox" name="check" value="racing" checked class="clear">레이싱 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="racing"> 레이싱 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>   
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'survival'}">
                              			<input type="checkbox" name="check" value="survival" checked class="clear">생존(서바이벌) &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="survival"> 생존(서바이벌) &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'casual'}">
                              			<input type="checkbox" name="check" value="casual" checked class="clear">캐주얼 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="casual"> 캐주얼 &nbsp;
                          		</c:if>
                     		</div>
                     		<div>   
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'openworld'}">
                              			<input type="checkbox" name="check" value="openworld" checked class="clear">오픈월드 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="openworld"> 오픈월드 &nbsp;
                          		</c:if>
                       		</div>
                  		</div>
            
                  		<div class="game_category">
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'puzzle'}">
                              			<input type="checkbox" name="check" value="puzzle" checked class="clear">퍼즐 &nbsp;
                                   		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="puzzle"> 퍼즐 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'quiz'}">
                              			<input type="checkbox" name="check" value="quiz" checked class="clear">퀴즈 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="quiz"> 퀴즈 &nbsp;
                          		</c:if>
                     		</div>
                     
                    	 	<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'shooting'}">
                              			<input type="checkbox" name="check" value="shooting" checked class="clear">슈팅 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="shooting"> 슈팅 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'battleroyale'}">
                              			<input type="checkbox" name="check" value="battleroyale" checked class="clear">배틀로얄 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="battleroyale"> 배틀로얄 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'rhythm'}">
                              			<input type="checkbox" name="check" value="rhythm" checked class="clear">리듬 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="rhythm"> 리듬 &nbsp;
                          		</c:if>
                       		</div>
                  		</div>
            
                  		<div class="game_category">
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'classic'}">
                              			<input type="checkbox" name="check" value="classic" checked   class="clear">고전 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="classic"> 고전 &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'threedim'}">
                              			<input type="checkbox" name="check" value="threedim" checked class="clear">3D &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="threedim"> 3D &nbsp;
                          		</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'horror'}">
                              			<input type="checkbox" name="check" value="horror" checked class="clear">공포 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="horror"> 공포 &nbsp;
                            	</c:if>
                     		</div>
                     
                     		<div>
                        		<c:set var="ckPrint" value="false" />
                        		<c:forEach var="category" items="${GamePageMaker.gameCriteria.check}">
                           			<c:if test="${category == 'card'}">
                              			<input type="checkbox" name="check" value="card" checked class="clear">카드 &nbsp;
                                 		<c:set var="ckPrint" value="true" />
                           			</c:if>
                        		</c:forEach>
                        		<c:if test="${not ckPrint}">
                           			<input type="checkbox" name="check" value="card"> 카드 &nbsp;
                          		</c:if>
                       		</div>
                    	</div>
                 	</div>
            	</div>
            	<br>
            	<div id="search" class="search_part">
               		<input type="text" name="keyword" id="keyword" value="${GamePageMaker.gameCriteria.keyword}" placeholder="게임명으로 검색" class="search_box">
               		<input type="button" value="검색" id="axMobileGame">
               		<input type="reset" value="취소" onclick="checkClear()">
            	</div>
	         	<c:if test="${loginID == 'admin'}">
	            	<a href="insertPcForm">새로운 PC게임 등록</a>
	         	</c:if>
            	<br>
			</form>
      	</div>
      	<div id="resultArea" class="GameList">
	    	<div class="searchresult">
	        	<div> 검색결과 : ${gamePageMaker.totalRowsCount} 건</div>
	      	</div>
          	<table style="width: 100;" class="game_table">
            	<c:if test="${not empty list}">
                	<c:forEach var="mobilegame" items="${list}">
                   		<tr>
                      		<td style="text-align: center;">
                        		<!-- 로그인을 한 경우에만 detailPcGame 볼 수 있음 --> 
                         		<c:if test="${not empty loginID}">
                            		<a href="detailMobileGame?game_name=${mobilegame.game_name}"> 
                               			<img class="game_img" src="${mobilegame.game_img}">
                            		</a>
                            		<a href="detailMobileGame?game_name=${mobilegame.game_name}">${mobilegame.game_name}</a>
                         		</c:if> 
                           		<!-- loginID가 없을 때 -->
                         		<c:if test="${empty loginID}">
                            		<img class="pointer game_img" src="${mobilegame.game_img}" onclick="detailContent()">
                            		<p class="pointer" onclick="detailContent()">${mobilegame.game_name}</p>
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
	                   		<a href="mobileGameList${gamePageMaker.searchQuery(1)}" class="aclick"><img src="resources/img/first.png"></a>&nbsp;
	                   		<a href="mobileGameList${gamePageMaker.searchQuery(gamePageMaker.spageNo-1)}" class="aclick"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
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
	                   		<a href="mobileGameList${gamePageMaker.searchQuery(i)}" class="aclick">${i}</a>&nbsp;
	                	</c:if>
	             	</c:forEach>
	
	            	<!-- Next, Last -->
	             	<c:choose>
	                	<c:when test="${gamePageMaker.next && gamePageMaker.epageNo > 0}">
	                   		<a href="mobileGameList${gamePageMaker.searchQuery(gamePageMaker.epageNo+1)}" class="aclick"><img src="resources/img/right.png"></a>
	                   		<a href="mobileGameList${gamePageMaker.searchQuery(gamePageMaker.lastPageNo)}" class="aclick">&nbsp;&nbsp;<img src="resources/img/last.png"></a>
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