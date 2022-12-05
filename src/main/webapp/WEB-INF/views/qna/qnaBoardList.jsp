<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | Q&amp;A</title>
	<!-- Stylesheets -->
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico" />
	<script src="resources/js/jquery-3.2.1.min.js"></script>
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
	<!-- Recent game section  -->
	<section>
		<div class="board_top">
			<a href="https://lineagem.plaync.com/preorder/record/oasis2you/index?LM=19208101" target="_blank">
				<img src="resources/img/lineagem.jpg">
			</a>
		</div>
		<div id="board_bg_set">
			<a href="https://worldofwarcraft.com/ko-kr/" target="_blank">
				<img id="board_img_left" alt="worldofwarcraft" src="resources/img/wow_side.jpg">
			</a>
			<div class="section-title">
				<h2>Q&amp;A</h2>
			</div>
			<div id="searchBar">
				<c:if test="${not empty loginID}">
					&nbsp;&nbsp;&nbsp;
					<a href="qnaWritePostForm" class="writePostbtn">QnA 등록하기</a>
					<br>
				</c:if>
			</div>
			<a href="https://worldofwarcraft.com/ko-kr/" target="_blank">
				<img id="board_img_right" alt="worldofwarcraft" src="resources/img/wow_side.jpg">
			</a>
		</div>
		<br>
		<!-- qna table -->
		<table id="boardtable">
			<tr id="boardth">
				<th width=10%>글 번호</th>
				<th width=40%>제목</th>
				<th width=15%>아이디</th>
				<th width=25%>작성일자</th>
				<!-- <th width=10%>조회수</th> -->
			</tr>
			<c:if test="${not empty list}">
				<c:forEach var="qna" items="${list}">
					<tr class="boardtd">
						<td style="text-align: center;">${qna.seq}</td>
						<td>
							<!-- 답글 등록 후 indent에 따른 들여쓰기 => 답글인 경우에만 적용 -->
							<c:if test="${qna.indent > 0}">
								<!-- indent가 0보다 크면 = 댓글이면 -->
								<c:forEach begin="1" end="${qna.indent}">
									<span>&nbsp;&nbsp;</span>
								</c:forEach>
								<span style="color: Crimson">re.</span>
							</c:if> <!-- 로그인을 한 경우에만 title을 클릭하면 content를 볼 수 있도록 함 => qnaReadPost 실행 -->

							<!-- ------------------------------------------------------------------------------------------------------------------------------------------------ -->

							<!-- 로그인 O : title -->
							<!-- 비밀글 : 접속불가 / 비밀글 x : 접속가능 ${qna.title} -->
							<!-- 로그인한 아이디는 내 글 볼 수 있음 -->

							<!-- 로그인 ID가 admin일 때 -->
							<!-- 비밀글 : 다 볼 수 있어야 함 -->

							<c:if test="${not empty loginID}">
								<!-- loginID가 있을 때(로그인을 한 경우) -->
								<c:choose>
									<c:when test="${qna.id == loginID || loginID == 'admin' }">
										<a href="qnaReadPost?seq=${qna.seq}">
											<c:out value="${qna.title}" />
										</a>
									</c:when>
									<c:when test="${qna.secret == false}">
										<a href="qnaReadPost?seq=${qna.seq}">
											<c:out value="${qna.title}" />
										</a>
									</c:when>
									<c:when test="${qna.secret == true}">작성자와 관리자만 볼 수 있습니다.</c:when>
								</c:choose>
							</c:if>

							<!-- 로그인 X : title -->
							<!-- 비밀글 : 비밀글은 작성자와 관리자만 볼 수 있습니다 / 비밀글 x : ${qna.title} -->
							<c:if test="${empty loginID}">
								<c:if test="${qna.secret == false}">${qna.title}</c:if>
								<c:if test="${qna.secret == true}">작성자와 관리자만 볼 수 있습니다.</c:if>
							</c:if>
						</td>

						<td style="text-align: center;">
							<!-- 로그인 ID가 admin일 때 -->
							<!-- id : detailUser -->
							<c:if test="${loginID == 'admin'}">
								<a href="detailUser?id=${qna.id}">${qna.id}</a>
							</c:if>

							<!-- 로그인 ID가 admin이 아닐 때 -->
							<c:if test="${loginID != 'admin'}">
								${qna.id}
							</c:if>
						</td>

						<td style="text-align: center;">${qna.regdate}</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
		<!-- Criteria_Page -->
		<div id="Criteria_Page">
			<!-- First, Prev -->
			<div id="Criteria_left">
				<c:choose>
					<c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
						<a href="qnaBoardList${pageMaker.searchQuery(1)}"><img src="resources/img/first.png"></a>&nbsp;&nbsp;
						<a href="qnaBoardList${pageMaker.searchQuery(pageMaker.spageNo-1)}"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
					</c:when>
					<c:otherwise>
						<font color="Gray">
							<img src="resources/img/first.png">&nbsp;
							<img src="resources/img/left.png">&nbsp;&nbsp;
						</font>
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
						<a href="qnaBoardList${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
					</c:if>
				</c:forEach>
			</div>
	
			<!-- Next, Last -->
			<div id="Criteria_right">
				<c:choose>
					<c:when test="${pageMaker.next && pageMaker.epageNo>0}">&nbsp;&nbsp;
					<a href="qnaBoardList${pageMaker.searchQuery(pageMaker.epageNo+1)}"><img src="resources/img/right.png"></a>&nbsp;&nbsp;
					<a href="qnaBoardList${pageMaker.searchQuery(pageMaker.lastPageNo)}"><img src="resources/img/last.png"></a>
					</c:when>
					<c:otherwise>
						<font color="Gray">&nbsp;<img src="resources/img/right.png">&nbsp;&nbsp;<img src="resources/img/last.png"></font>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
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