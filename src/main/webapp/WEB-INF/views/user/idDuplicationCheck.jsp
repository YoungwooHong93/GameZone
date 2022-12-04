<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>GameZone | ID 중복확인</title>
	<link rel="stylesheet" href="resources/css/style.css">
	<link rel="stylesheet" href="resources/css/user.css">
	<script src="resources/js/jquery-3.2.1.min.js"></script>
	<script src="resources/js/inCheck.js"></script>
	<script>
		function idOK() {
			opener.$('#id').val('${newId}');
			opener.$('#submit').attr('disabled', false);
			opener.$('#idDuplicationCheck').attr('disabled', 'disabled');
			opener.$('#id').prop('readonly', true);
			opener.$('#password').focus();

			window.close();
		} // idOK
	</script>
</head>
<body>
	<div id="duplication-form">
		<h3>GameZone | ID 중복확인</h3>
		<form action="idDuplicationCheck" method="get">
			ID :
			<input type="text" id="duplicationform-control" name="id" id="id">&nbsp;
			<input type="submit" class="idDuplicationCheck" value="ID 중복확인" onclick="return idCheck()">
			<!-- inCheck.js의 idCheck()의 결과에 따라 submit 결정 -->
			<span id="iMessage" class="eMessage"></span>
		</form>
		<br><br>
		<hr>
		<!-- ** 서버의 확인 결과에 따른 처리 영역
				=> isUse : 'T' 가능 / 'F' 불가능 -->
		<div>
			<c:if test="${isUse == 'T'}">
				${newId}는(은) 사용 가능합니다.&nbsp;&nbsp;
				<input type="button" class="btn btn-primary" value="사용" onclick="idOK()">
				<!-- 사용자가 입력한 ID를 사용 가능하도록 해주고, 현재(this)창은 close -->
			</c:if>

			<c:if test="${isUse == 'F'}">
				${newId}은(는) 이미 사용 중인 ID입니다.<br>
				다시 입력해주세요.
				<!-- 부모창(joinForm, opener)에 남아있는 사용자가 입력한 id는 지워주고,
				현재(this)창에서는 id에 focus를 주고 재입력 유도 -> script 필요 -->
				<script>
					$('#id').focus();
					opener.document.getElementById('id').value = '';
				</script>
			</c:if>
		</div>
	</div>
</body>
</html>