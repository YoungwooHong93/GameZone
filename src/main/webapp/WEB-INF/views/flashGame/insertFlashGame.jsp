<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 새로운 게임 등록</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script>
		function insertGame() {
			
			if ($('#flash_game_name').val() == null || $('#flash_game_name').val() == '') {
				alert('게임 이름을 입력하세요.');
				return false;
			}
	
			if ($('#flash_site').val() == null || $('#flash_site').val() == '') {
				alert('사이트를 입력하세요.');
				return false;
			}
			
			if (confirm("게임을 등록하시겠습니까? (Yes : 확인 / No : 취소)")) {
				$('#insertFlashGameForm').submit();
				return true;
				
			} else {
				alert('등록이 취소되었습니다.');
				return false;
			}
			
		} // insertGame
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
		<form action="insertFlashGame" method="post" id="insertFlashGameForm" enctype="multipart/form-data">
			<table>
				<tr height="40">
					<th bgcolor="YellowGreen" style="text-align: center;">Image</th>
					<td>
						<img src="" class="new_img"><br>
						<input type="file" name="uploadimgfile" id="uploadimgfile">
						<script>
							$('#uploadimgfile').change(function() {
								if(this.files && this.files[0]) {
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
					<th bgcolor="YellowGreen" style="text-align: center;">Game_Name</th>
					<td><input type="text" name="game_name" id="flash_game_name" placeholder="게임 이름" size="40"></td>
				</tr>
					
				<tr height="40">
					<th bgcolor="YellowGreen" style="text-align: center;">Site</th>
					<td><input type="text" name="site" id="flash_site" placeholder="사이트" size="40"></td>
				</tr>
					
				<tr>
					<td></td>
					<td>
						<input type="submit" value="등록" onclick="return insertGame()">&nbsp;&nbsp;&nbsp;
						<input type="reset" value="취소">
					</td>
				</tr>
			</table>
		</form>
		&nbsp;&nbsp;&nbsp;<a href="javascript:history.go(-1)">[이전으로]</a>
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