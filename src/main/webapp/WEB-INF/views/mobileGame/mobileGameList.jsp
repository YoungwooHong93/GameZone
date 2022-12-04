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
	<script src="resources/js/axMobileGame.js"></script>
	<script>
		function detailContent() {
			alert('로그인 후 상세보기가 가능합니다 :-)')
		} // detailContent
	</script>
</head>
<body>
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
							<!-- loginID가 있을 때(로그인을 한 경우) -->
							<a href="detailMobileGame?game_name=${mobilegame.game_name}">
								<img class="game_img" src="${mobilegame.game_img}">
							</a>
							<a href="detailMobileGame?game_name=${mobilegame.game_name}">${mobilegame.game_name}</a>
						</c:if> 
						<c:if test="${empty loginID}">
							<!-- loginID가 없을 때 -->
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
	</div>
</body>
</html>