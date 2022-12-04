<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>GameZone | ${one.title}</title>
      <!-- Stylesheets -->
   <link rel="stylesheet" href="resources/css/owl.carousel.css" />
   <link rel="stylesheet" href="resources/css/style.css" />
   <link rel="stylesheet" href="resources/css/animate.css" />
   <link rel="shortcut icon" href="resources/img/icon2.ico"/>
   <script src="resources/js/jquery-3.2.1.min.js"></script>
   <script src="resources/js/axReadPost.js"></script>
   <script>
	   function removePost() {
	      
	      if (confirm("삭제하시겠습니까? (Yes : 확인 / No : 취소)")) {
	             return true; // 삭제
	      } else {
	             alert('삭제가 취소되었습니다.');
	         return false;
	      }
	   } // removePost(삭제)
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
		<div class="readPost_outer">
			<div class="readPost_container">
				<div class="board_titleBox">
					<span class="board_title">${one.title}</span>
				</div>
				<c:if test="${not empty one}">
					<div class="readPost_contents" hidden>
						<span>Seq</span>
						<span>${one.seq}</span>
						<input type="text" value="${one.seq}" id="seq">
					</div>
					<div class="readPost_info">
						<div class="color-choi">${one.id} &nbsp;&nbsp; | &nbsp;&nbsp; ${one.regdate}</div>
					</div>

					<div class="board_contentBox">
						<textarea readonly>${one.content}</textarea>
					</div>
				</c:if>
			</div>

			<div class="readPost_btnBox">
				<c:if test="${loginID == one.id || loginID == 'admin'}">
					<a href="readPost?jCode=U&seq=${one.seq}" class="readPost_btn">게시글 수정</a>
					<!-- root 추가 : 삭제 시 원글 삭제 or 댓글 삭제 확인을 위함 -->
					&nbsp;&nbsp;&nbsp;<a href="removePost?seq=${one.seq}&root=${one.root}" class="readPost_btn" onclick="return removePost()">게시글 삭제</a>
					&nbsp;&nbsp;&nbsp;<a href="javascript:history.go(-1)" class="readPost_btn">목록으로</a>
				</c:if>
				<br>
			</div>
			<div id="writeReply" class="replyArea" name="replylist">
				<div class="writeReply">
					<c:if test="${not empty loginID}">
						<!-- textarea -->
						<textarea rows="3" cols="94" name="content" id="replyContent"
							placeholder="명예훼손, 개인정보 유출, 분쟁 유발, 허위사실 유포 등의 글은 법률에 의해 처벌받을 수 있습니다. 건전한 커뮤니티를 위해 자제를 당부드립니다."></textarea>
						<!-- 등록 -->
						<input type="button" value="등록" class="sclick">
					</c:if>
				</div> <!-- 댓글 폼 -->
				<div class="reply_btnBox">
					<ul id="replyaddlist">
						<c:if test="${not empty list}">
							<c:forEach var="reply" items="${list}" varStatus="status">
								<div class="reply_border">
									<div id="acontent${reply.reply_number}" class="board_reply">
										<ul>
											<li class="color-choi">${reply.id} &nbsp;|&nbsp; ${reply.regdate}</li>
											<li id="replyContentLi${reply.reply_number}"
											class="replyContentLi">${reply.content}</li>
										</ul>
									</div>	
	
									<input class="replyId" id="replyId" value="${reply.id}" hidden>
									<input id="replyNumber${status.count}" value="${reply.reply_number}"
										name="${reply.reply_number}" hidden>
									<div id="abt${reply.reply_number}" class="reply_btns">
										<!-- 댓글 입력 후 수정, 삭제 -->
										<c:if test="${loginID == reply.id || loginID == 'admin'}">
											<input class="reply_update reply_btn" type="button" value="수정"
												id="${reply.reply_number}">
											<input class="reply_delete reply_btn" type="button" value="삭제"
												id="${reply.reply_number}">
										</c:if>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</ul>
				</div> <!-- 댓글 리스트 -->
				<input class="loginId" id="loginId" value="${loginID}" hidden>
			</div> <!-- replyArea -->
		</div> <!-- readPost_outer -->
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
   <script src="resources/js/jquery-3.2.1.min.js"></script>
   <script src="resources/js/bootstrap.min.js"></script>
   <script src="resources/js/owl.carousel.min.js"></script>
   <script src="resources/js/jquery.marquee.min.js"></script>
   <script src="resources/js/main.js"></script>
</body>
</html>