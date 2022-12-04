<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>GameZone | 로그인</title>
    <link rel="stylesheet" type="text/css" href="resources/css/login.css">
    <link rel="stylesheet" type="text/css" href="resources/css/style.css">
    <link rel="stylesheet" href="resources/css/style.css" />
	<link rel="shortcut icon" href="resources/img/icon2.ico">
    <script src="resources/js/jquery-3.2.1.min.js"></script>
    <script src="resources/js/inCheck.js"></script>

    <script>
        let iCheck = false;
        let pCheck = false;
        
		$(function() {
        	$('#id').focus();
            // ** ID
            $('#id').keydown(function(e) {
                if ( e.which == 13 ) {
                    e.preventDefault();
                    $('#password').focus();
                }
            }).focusout(function() {    
                iCheck = idCheck();
            }); //id
            
            // ** Password
            $('#password').keydown(function(e) {
                if ( e.which == 13 ) {
                    e.preventDefault();
                    $('#submit').focus();
                }
            }).focusout(function(){    
                pCheck = pwCheck();
            }); //password
            
        }); //ready

        function ipCheck() {
            if (iCheck == false) {
                    $('#iMessage').html('ID를 확인해주세요.');
                }
                
                if (pCheck == false) {
                    $('#pMessage').html('비밀번호를 확인해주세요');
                }
    
                if (iCheck && pCheck) {
                    return true;
                    
                } else
                    return false;
       	} //inCheck
	</script>
</head>
<body>
	<div class="loginBox">
		<a href="home">
			<img class="user" src="resources/img/gamelogo.png" height="200px" width="200px">
		</a>
            
		<form action="loginUser" method="post">
			<div class="inputBox">
				<input id="id" type="text" name="id" placeholder="아이디"><br>
				<span id="iMessage" class="eMessage"></span><br>
			</div>
			<div class="inputBox">
				<input id="password" type="password" name="password" placeholder="비밀번호"><br>
				<span id="pMessage" class="eMessage"></span>
			</div>
			<br>
			<input type="submit" value="로그인" id="submit">&nbsp;&nbsp;
		</form>
		<c:if test="${not empty message}">
			<script>
				alert(`${message}`);
			</script>		
		</c:if>
		<div class="text-center">
			<a href="joinForm" style="color: #59238F;">회원가입</a>
		</div>
	</div>
</body>
</html>