<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 게시글 작성</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/myStyle.css">
		<!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/ckeditor/ckeditor.js"></script>
	<script> 
	    var ckeditor_config = {
	
	    resize_enaleb : false,
	
	    enterMode : CKEDITOR.ENTER_BR,
	
	    shiftEnterMode : CKEDITOR.ENTER_P,
	
	    filebrowserUploadUrl : "/resources/ckUpload"
	
	    };
    </script>
	<script>
		function writePost() {
			// title 값이 null이거나 '' 일때 jqurey
			if ($('#title').val() == null || $('#title').val() == '') {
				alert('제목을 입력하세요.');
				return false;
			}
	
			// content
			if ($('#content').val() == null || $('#content').val() == '') {
				alert('내용을 입력하세요.');
				return false;
			}
			
			
			if (confirm("게시글을 등록하시겠습니까? (Yes : 확인 / No : 취소)")) {
				$('#writePostForm').submit();
	           	return true;
	           	
			} else {
	           	alert('등록이 취소되었습니다.');
				return false;
			}
		}
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
		<form action="writePost" method="post" id="writePostForm">
			<div class="main_title">
				<h2>자유 게시판 | 작성</h2>
			</div>
			<div class="readPost_outer">
				<div class="readPost_container">
					<div class="qna_titleBox">
						<span class="qna_title">제목</span>
						<span>
							<input type="text" name="title" id="title" class="qnaTitle_input"
								placeholder="제목을 반드시 입력하세요.">
						</span>
					</div>
					<div class="readPost_info" hidden>
						<input class="color-choi qna_id" type="text" name="id" value="${loginID}" hidden>
					</div>
					<div class="qna_contentBox">
						<span>내용</span>
						<textarea name="content" id="content"></textarea>
						<script>
							CKEDITOR.replace('content' , ckeditor_config );
						</script>
					</div>
				</div>
				<div class="readPost_btnBox">
					<input class="readPost_btn" type="submit" value="등록" onclick="return writePost()">
					&nbsp;&nbsp;<a href="javascript:history.go(-1)">
						<input class="readPost_btn" type="button" value="취소"></a>
				</div>
			</div>
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
	<!-- ====== Javascripts & Jquery ====== -->
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/owl.carousel.min.js"></script>
	<script src="resources/js/jquery.marquee.min.js"></script>
	<script src="resources/js/main.js"></script>
</body>
</html>