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
			
			if ($('#mobile_category').val() == null || $('#mobile_category').val() == '') {
				alert('카테고리를 입력하세요.');
				return false;
			}
	
			if ($('#mobile_price').val() == null || $('#mobile_price').val() == '') {
				alert('가격을 입력하세요.');
				return false;
			}
	
			if ($('#mobile_grade').val() == null || $('#mobile_grade').val() == '') {
				alert('등급을 입력하세요.');
				return false;
			}
			if ($('#mobile_site').val() == null || $('#mobile_site').val() == '') {
				alert('사이트를 입력하세요.');
				return false;
			}
			
			if (confirm("수정하시겠습니까? (Yes : 확인 / No : 취소)")) {
				$('#updateMobileGameForm').submit();
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
		<form action="updateMobileGame" class="update_game_form" id="updateMobileGameForm" method="post" enctype="multipart/form-data">
			<table id="update_game">
				<thead>
					<tr class="update_game_row">
						<th>게임 사진</th>
						<td style=" vertical-align: bottom;">
							<img src="${one.game_img}" class="new_img" width="233" height="303"> <input type="hidden" name="game_img" value="${one.game_img}"><br>
							<input type="file" name="uploadimgfile" id="uploadimgfile">
							<script>
								$('#uploadimgfile').change(function() {
									if (this.files && this.files[0]) {
										var reader = new FileReader;
										reader.readAsDataURL(this.files[0]);
										reader.onload = function(e) {
											$(".new_img").attr("src", e.target.result).width(233).height(303);
										} // onload_function
									} // if
								}); // change
							</script>
						</td>
					</tr>
					<tr id="update_game_text">
						<td></td>
		        		<td>사진 크기는 가로 233px 세로 303px 로 고정</td>
		        	</tr>
				</thead>
				<tbody>
					<tr>
						<th>장르</th>
						<td>
							<input type="text" name="category" id="mobile_category" value="${one.category}">
						</td>
					</tr>
		
					<tr>
						<th>게임이름</th>
						<td>
							<input type="text" name="game_name" id="mobile_game_name" value="${one.game_name}" readonly>
						</td>
					</tr>
		
					<tr>
						<th>출시일</th>
						<td>
							<input type="text" name="launch" value="${one.launch}">
						</td>
					</tr>
		
					<tr>
						<th>배급사</th>
						<td>
							<input type="text" name="publisher" value="${one.publisher}">
						</td>
					</tr>
		
					<tr>
						<th>가격</th>
						<td>
							<input type="text" name="price" id="mobile_price" value="${one.price}">
						</td>
					</tr>
		
					<tr>
						<th>이용 등급</th>
						<td>
							<input type="text" name="grade" id="mobile_grade" value="${one.grade}">
						</td>
					</tr>
		
					<tr>
						<th>공식 사이트</th>
						<td>
							<input type="text" name="site" id="mobile_site" value="${one.site}">
						</td>
					</tr>
		
					<tr>
						<th>게임 소개</th>
						<td>
							<input type="text" name="intro" value="${one.intro}">
						</td>
					</tr>
		
					<tr>
						<th>영상 링크</th>
						<td>
							<input type="text" name="video" value="${one.video}">
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td></td>
						<td>
		           			<input class="update_game_btn" type="submit" value="등록" onclick="return updateGame()">&nbsp;&nbsp;&nbsp;
		              		<input class="update_game_btn" type="reset" value="초기화">&nbsp;&nbsp;&nbsp;
		              		<input class="update_game_btn" type="button" onClick="history.go(-1)" value="이전으로">
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
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