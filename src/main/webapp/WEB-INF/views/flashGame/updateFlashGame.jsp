<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | ${one.game_name} 수정</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>
		function updateGame() {
			if (confirm("수정하시겠습니까? (Yes : 확인 / No : 취소)")) {
				alert(`${one.game_name}을(를) 수정하겠습니다.`);
	           	return true;
	           	
			} else {
	           	alert('수정이 취소되었습니다.');
				return false;
			}
		} // updateGame
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
   	<main>
		<h3>${param.game_name}</h3>
		<c:if test="${not empty message}">
			<script>
				alert(`${message}`);
			</script>
		</c:if>
		<hr>
		<form action="updateFlashGame" method="post" enctype="multipart/form-data">
			<table>
				<tr height="40">
					<th bgcolor="DarkSeaGreen" style="text-align: center;">Image</th>
					<td>
						<img src="${one.game_img}" class="new_img" width="80" height="100">
						<input type="hidden" name="game_img" value="${one.game_img}"><br>
						<input type="file" name="uploadimgfile" id="uploadimgfile">
						<script>
							$('#uploadimgfile').change(function() {
								if (this.files && this.files[0]) {
									var reader = new FileReader;
									reader.readAsDataURL(this.files[0]);
									reader.onload = function(e) {
										$(".new_img").attr("src", e.target.result).width(100).height(100);
									} // onload_function
	
								} // if
	
							}); // change
						</script>
					</td>
				</tr>
	
				<tr height="40">
					<th bgcolor="DarkSeaGreen" style="text-align: center;">Game_Name</th>
					<td>
						<input type="text" name="game_name" value="${one.game_name}" size="40" readonly>
					</td>
				</tr>
	
				<tr height="40">
					<th bgcolor="DarkSeaGreen" style="text-align: center;">Site</th>
					<td>
						<input type="text" name="site" value="${one.site}" size="40">
					</td>
				</tr>
	
				<tr>
					<td></td>
					<td>
						<input type="submit" value="수정" onclick="return updateGame()">&nbsp;&nbsp;&nbsp;
						<a href="javascript:history.go(-1)">수정 취소</a>
					</td>
				</tr>
			</table>
		</form>
		&nbsp;&nbsp;&nbsp;
		<a href="javascript:history.go(-1)">[이전으로]</a>
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