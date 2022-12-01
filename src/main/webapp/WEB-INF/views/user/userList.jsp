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
				self.location = "mcrilist" + "${pageMaker.makeQuery(1)}" 
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
                  		<a href="loginUser">로그인</a> / <a href="joinForm">회원가입</a>
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
		<hr>
		<div id="searchBar">
			<select name="searchType" id="searchType">
				<option value="n" ${pageMaker.cri.searchType == null ? 'selected' : '' }>전체(All)</option>
				<option value="i" ${pageMaker.cri.searchType == 'i' ? 'selected' : '' }>ID</option>
				<option value="a" ${pageMaker.cri.searchType == 'a' ? 'selected' : '' }>Name</option>
				<option value="b" ${pageMaker.cri.searchType == 'b' ? 'selected' : '' }>BirthDay</option>
				<option value="in" ${pageMaker.cri.searchType == 'in' ? 'selected' : '' }>ID or Name</option>
			</select>
		
			<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
			<button id="searchBtn">Search</button>
		</div>
		<br>
		<hr>
	   
		<table width=100%>
			<tr bgcolor="hotpink" height="30" style="text-align: center;">
				<th>I D</th>
				<th>Name</th>
				<th>Birthday</th>
				<th>Gender</th>
				<th>Email</th>
				<th>Phone</th>
			</tr>
			
			<c:if test="${not empty list}">
				<c:forEach var="user" items="${list}">
					<tr height="30">
						<td>
						<c:if test="${loginID == 'admin'}">
							<a href="detailUser?id=${user.id}">${user.id}</a>
						</c:if>
						
						</td>
						<td>${user.user_name}</td>
						<td>${user.birthday}</td>
						<td>${user.gender}</td>
						<td>${user.email}${user.domain}</td>
						<td>${user.phone}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<hr>
		
		<div align="center">
			<!-- First, Prev -->
			<c:choose>
				<c:when test="${pageMaker.prev && pageMaker.spageNo > 1}">
					<a href="userList${pageMaker.searchQuery(1)}"><img src="resources/img/first.png"></a>&nbsp;
					<a href="userList${pageMaker.searchQuery(pageMaker.spageNo-1)}"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
				</c:when>
				
				<c:otherwise>
					<font color="DimGray"><img src="resources/img/first.png">&nbsp;<img src="resources/img/left.png">&nbsp;&nbsp;</font>
				</c:otherwise>
			</c:choose>
		
		
			<!-- Display PageNo -->
			<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
				<c:if test="${i == pageMaker.cri.currPage}">
					<font size="5" color="DarkOrange">${i}</font>&nbsp;
				</c:if>
				
				<c:if test="${i != pageMaker.cri.currPage}">
					<a href="userList${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
				</c:if>
			</c:forEach>
		
		
			<!-- Next, Last -->
			<c:choose>
				<c:when test="${pageMaker.next && pageMaker.epageNo > 0}">
					<a href="userList${pageMaker.searchQuery(pageMaker.epageNo+1)}"><img src="resources/img/right.png"></a>
					<a href="userList${pageMaker.searchQuery(pageMaker.lastPageNo)}">&nbsp;&nbsp;<img src="resources/img/last.png"></a>
				</c:when>
				
				<c:otherwise>
					<font color="DimGray">&nbsp;<img src="resources/img/right.png">&nbsp;&nbsp;<img src="resources/img/last.png"></font>
				</c:otherwise>
			</c:choose>
		
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