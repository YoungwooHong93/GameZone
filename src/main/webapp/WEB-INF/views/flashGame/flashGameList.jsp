<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | 플래시게임 리스트</title>
	<link rel="stylesheet" type="text/css" href="resources/css/myStyle.css">
	<link rel="stylesheet" href="resources/css/owl.carousel.css" />
	<link rel="stylesheet" href="resources/css/style.css" />
	<link rel="stylesheet" href="resources/css/animate.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axFlashGame.js"></script>
	<script>
		function detailContent() {
			alert('로그인 후 상세보기가 가능합니다 :-)')
		} // detailContent
	</script>
</head>
<body>
	<div>
		<div class="flashLink"> 클릭 시 와플래시 게임 아카이브 페이지로 이동합니다.</div>
	</div>
	<div class="searchresult">
		<div> 검색결과 : ${gamePageMaker.totalRowsCount} 건</div>
	</div>
	<table style="width: 100;" class="game_table">
		<c:if test="${not empty list}">
			<c:forEach var="flashgame" items="${list}">
				<tr>
					<td class="flash_td">
                    	<!-- admin 제외하고 로그인을 한 경우에만 해당 게임 사이트로 이동 가능 -->
	              		<c:if test="${not empty loginID && loginID != 'admin'}">
							<a href="${flashgame.site}" target="_blank">
								<img class="flash_game_img" src="${flashgame.game_img}">
							</a>
							<a class="flash_content" href="${flashgame.site}" target="_blank">${flashgame.game_name}</a>
						</c:if> 
						
						<!-- admin으로 로그인 한 경우에만 detailFlashGame 확인 가능 -->
						<c:if test="${loginID == 'admin'}">
							<a href="detailFlashGame?game_name=${flashgame.game_name}">
								<img class="flash_game_img" src="${flashgame.game_img}">
							</a>
							<a class="flash_content" href="detailFlashGame?game_name=${flashgame.game_name}">${flashgame.game_name}</a>
						</c:if> 
						
						<!-- loginID가 없을 때 -->
						<c:if test="${empty loginID}">
							<img class="pointer flash_game_img" src="${flashgame.game_img}" onclick="detailContent()">
							<a class="pointer flash_content" onclick="detailContent()">${flashgame.game_name}</a>
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
				<a href="flashGameList${gamePageMaker.searchQuery(1)}" class="aclick"><img src="resources/img/first.png"></a>&nbsp;
                <a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.spageNo-1)}" class="aclick"><img src="resources/img/left.png"></a>&nbsp;&nbsp;
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
				<a href="flashGameList${gamePageMaker.searchQuery(i)}" class="aclick">${i}</a>&nbsp;
            </c:if>
		</c:forEach>

		<!-- Next, Last -->
		<c:choose>
			<c:when test="${gamePageMaker.next && gamePageMaker.epageNo > 0}">
				<a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.epageNo+1)}" class="aclick"><img src="resources/img/right.png"></a>
				<a href="flashGameList${gamePageMaker.searchQuery(gamePageMaker.lastPageNo)}" class="aclick">&nbsp;&nbsp;<img src="resources/img/last.png"></a>
			</c:when>

			<c:otherwise>
				<font color="DimGray">&nbsp;<img src="resources/img/right.png">&nbsp;&nbsp;<img src="resources/img/last.png"></font>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</body>
</html>