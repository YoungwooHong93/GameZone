<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 회원 리스트</title>
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>

		$(function() {
			
			// 1) SearchType이 '전체'이면 keyword 클리어
			$('#searchType').change(function() {
				if ($(this).val() == 'n')
					$('#keyword').val('');
			}); // change
			
			// 2) 검색 후 요청 처리
			$('#searchBtn').click(function() {
				self.location = "userList" + "${pageMaker.makeQuery(1)}" 
					+ "&searchType=" + $('#searchType').val()
					+ "&keyword=" + $('#keyword').val()
			}) // click

		}); // Ready
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
	<main class="main_min">
		<c:if test="${not empty message}">
			${message}<br>
		</c:if>
		<div class="section-title">
			<h2>회원 관리</h2>
		</div>
		<div id="searchBar">
			<select name="searchType" id="searchType">
				<option value="n" ${pageMaker.cri.searchType == null ? 'selected' : '' }>전체(All)</option>
				<option value="i" ${pageMaker.cri.searchType == 'i' ? 'selected' : '' }>아이디</option>
				<option value="a" ${pageMaker.cri.searchType == 'a' ? 'selected' : '' }>이름</option>
				<option value="b" ${pageMaker.cri.searchType == 'b' ? 'selected' : '' }>생년월일</option>
				<option value="e" ${pageMaker.cri.searchType == 'e' ? 'selected' : '' }>이메일</option>
				<option value="p" ${pageMaker.cri.searchType == 'p' ? 'selected' : '' }>연락처</option>
			</select>
		
			<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
			<button id="searchBtn">검색</button>
		</div>
		<br>
		<table id="boardtable">
			<tr id="boardth">
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>이메일</th>
				<th>연락처</th>
			</tr>
			
			<c:if test="${not empty list}">
				<c:forEach var="user" items="${list}">
					<tr class="boardtd">
						<td>
							<c:if test="${loginID == 'admin'}">
								<a href="detailUser?id=${user.id}">${user.id}</a>
							</c:if>
						</td>
						<td id="board_title_center">
							${user.user_name}
						</td>
						<td>${user.birthday}</td>
						<c:if test="${user.gender == 1}">
							<td>여</td>
						</c:if>
						<c:if test="${user.gender == 2}">
							<td>남</td>
						</c:if>
						<td>${user.email}${user.domain}</td>
						<td>${user.phone}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<div id="Criteria_Page" align="center">
			<!-- First, Prev -->
			<c:choose>
				<c:when test="${pageMaker.prev && pageMaker.spageNo > 1}">
					<a href="userList${pageMaker.searchQuery(1)}"><img src="resources/img/first.png"></a>&nbsp;
					<a href="userList${pageMaker.searchQuery(pageMaker.spageNo-1)}"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
				</c:when>
				
				<c:otherwise>
					<img src="resources/img/first.png">&nbsp;
					<img src="resources/img/left.png">&nbsp;&nbsp;
				</c:otherwise>
			</c:choose>
		
		
			<!-- Display PageNo -->
			<div id="Criteria_num">
				<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
					<c:if test="${i == pageMaker.cri.currPage}">
						<font size="5" color="DarkOrange">${i}</font>&nbsp;
					</c:if>
					
					<c:if test="${i != pageMaker.cri.currPage}">
						<a href="userList${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
					</c:if>
				</c:forEach>
			</div>
		
			<!-- Next, Last -->
			<div id="Criteria_right">
				<c:choose>
					<c:when test="${pageMaker.next && pageMaker.epageNo > 0}">
						<a href="userList${pageMaker.searchQuery(pageMaker.epageNo+1)}"><img src="resources/img/right.png"></a>
						<a href="userList${pageMaker.searchQuery(pageMaker.lastPageNo)}">&nbsp;&nbsp;<img src="resources/img/last.png"></a>
					</c:when>
					
					<c:otherwise>
						<img src="resources/img/right.png">&nbsp;&nbsp;
						<img src="resources/img/last.png">
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
</body>
</html>