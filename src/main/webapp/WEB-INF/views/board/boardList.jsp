<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 자유 게시판</title>
	<!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>
		/* SearchType 및 검색 후 요청 처리 (스크립트로 url 호출) */
		$(function() {
	
			// SearchType이 '전체'이면 keyword 클리어
			$('#searchType').change(function() {
				if ($(this).val() == 'n')
					$('#keyword').val('');
			}); // change
			
			$('#searchBtn').click(function() {
	            self.location = "boardList" + "${pageMaker.makeQuery(1)}" 
	               + "&searchType=" + $('#searchType').val()
	               + "&keyword=" + $('#keyword').val()
	         }) // click
			
		}); // Ready
		
		function readPost() {
     		alert('로그인 후 상세보기가 가능합니다 :)')
     	} // readPost
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
	<!-- Recent game section  -->
	<c:if test="${not empty message}">
		<script>
			alert(`${message}`);
		</script>
	</c:if>
	<main>
		<div class="board_top">
			<a href="https://lineagem.plaync.com/preorder/record/oasis2you/index?LM=19208101" target="_blank">
				<img src="resources/img/aion.jpg">
			</a>
		</div>
		<div id="board_bg_set">
			<a href="https://rox.gnjoy.com/pre-register?af_xp=email&pid=Email&c=ApolloMKTMedia&af_adset=m11&af_ad=ruliwebpc" target="_blank">
				<img id="board_img_left" alt="ragnarokX" src="resources/img/dungeon_left.jpg">
			</a>
			
			<div class="section-title">
				<h2>자유 게시판</h2>
			</div>
			<!-- searchBar -->
			<div id="searchBar">
				<select name="searchType" id="searchType">
					<option value="n" ${pageMaker.cri.searchType==null ? 'selected' : ' ' }>전체</option>
					<option value="t" ${pageMaker.cri.searchType=='t' ? 'selected' : ' ' }>제목</option>
					<option value="c" ${pageMaker.cri.searchType=='c' ? 'selected' : ' ' }>내용</option>
					<option value="i" ${pageMaker.cri.searchType=='i' ? 'selected' : ' ' }>ID(작성자)</option>
					<option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected' : ' ' }>제목 or 내용</option>
				</select> 
				<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
				<button id="searchBtn">검색</button>
				<div id="writePostbtn">
					<c:if test="${not empty loginID}">
						<a href="writePostForm" class="writePostbtn">새 게시글 등록하기</a><br>
					</c:if>
				</div>
			</div>
			<br>

			<!-- Board table -->
			<table id="boardtable">
				<tr id="boardth">
					<th width=10%>글 번호</th>
					<th width=40%>제목</th>
					<th width=15%>아이디</th>
					<th width=25%>작성일자</th>
					<th width=10%>조회수</th>
				</tr>
				<c:if test="${not empty list}">
					<c:forEach var="board" items="${list}">
						<tr class="boardtd">
							<td>${board.seq}</td>
							<td id="board_title_left">
								<!-- 로그인을 한 경우에만 title을 클릭하면 content를 볼 수 있도록 함 => bDetail 실행 -->
								<c:if test="${not empty loginID}">
									<!-- loginID가 있을 때(로그인을 한 경우) -->
									<a class="pointer" href="readPost?seq=${board.seq}">${board.title}</a>
									<c:if test="${board.replyCount > 0}">
										<a class="pointer color_gamezone" href="readPost?seq=${board.seq}">[${board.replyCount}]</a>
									</c:if>
								</c:if> 
								<c:if test="${empty loginID}">
									<!-- loginID가 없을 때 -->
									<a class="pointer" onclick="readPost()">${board.title}</a>
									<c:if test="${board.replyCount > 0}">
										<a class="pointer color_gamezone">[${board.replyCount}]</a>
									</c:if>
								</c:if>
							</td>
							<td><c:if test="${loginID == 'admin'}">
									<!-- 로그인 ID가 admin일 때 -->
									<a href="detailUser?id=${board.id}">${board.id}</a>
								</c:if> <c:if test="${loginID != 'admin'}">
									<!-- 로그인 ID가 admin이 아닐 때 -->
									<a>${board.id}</a>
								</c:if></td>
							<td>${board.regdate}</td>
							<td>${board.cnt}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<a href="https://rox.gnjoy.com/pre-register?af_xp=email&pid=Email&c=ApolloMKTMedia&af_adset=m11&af_ad=ruliwebpc" target="_blank">
				<img id="board_img_right" alt="ragnarokX" src="resources/img/dungeon_right.jpg">
			</a>
		</div>
		<!-- Criteria_Page -->
		<div id="Criteria_Page">
			<!-- First, Prev -->
			<div id="Criteria_left">
				<c:choose>
					<c:when test="${pageMaker.prev && pageMaker.spageNo > 1}">
						<a href="boardList${pageMaker.searchQuery(1)}"><img src="resources/img/first.png"></a>&nbsp;&nbsp;
				    	<a href="boardList${pageMaker.searchQuery(pageMaker.spageNo - 1)}"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
					</c:when>
					<c:otherwise>
						<font size="5" color="Gray"><img src="resources/img/first.png">&nbsp;
						<img src="resources/img/left.png">&nbsp;&nbsp;</font>
						<%-- <font size="5" color="Gray"><img onclick = "changePage('${pageMaker.searchQuery(1)}')"  src="resources/img/first.png">&nbsp;<img onclick = "changePage('${pageMaker.searchQuery(pageMaker.spageNo-1)}')" src="resources/img/left.png">&nbsp;&nbsp;</font> --%>
					</c:otherwise>
				</c:choose>
			</div>
	
			<!-- Display PageNo -->
			<div id="Criteria_num">
				<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
					<c:if test="${i == pageMaker.cri.currPage}">
						<font size="5" color="Orange">${i}</font>&nbsp;
				   	</c:if>
					<c:if test="${i!=pageMaker.cri.currPage}">
						<a href="boardList${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
					</c:if>
				</c:forEach>
			</div>
	
			<!-- Next, Last -->
			<div id="Criteria_right">
				<c:choose>
					<c:when test="${pageMaker.next && pageMaker.epageNo>0}"> &nbsp;&nbsp;
						<a href="boardList${pageMaker.searchQuery(pageMaker.epageNo+1)}"><img src="resources/img/right.png"></a> &nbsp;&nbsp;
						<a href="boardList${pageMaker.searchQuery(pageMaker.lastPageNo)}"><img src="resources/img/last.png"></a>
					</c:when>
					<c:otherwise>
						<font size="5" color="Gray">&nbsp;
							<img src="resources/img/right.png">&nbsp;&nbsp;
							<img src="resources/img/last.png">
						</font>
					</c:otherwise>
				</c:choose>
			</div>
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
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/owl.carousel.min.js"></script>
	<script src="resources/js/jquery.marquee.min.js"></script>
	<script src="resources/js/main.js"></script>

</body>
</html>