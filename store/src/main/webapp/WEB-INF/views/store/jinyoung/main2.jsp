<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String ctxPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" type="text/css"	href="<%=ctxPath%>/resources/css/bootstrap.min.css">
<script src="../resources/js/jquery-2.2.4.min.js" type="text/javascript"></script>

<style type="text/css">
* { padding: 0; margin: 0; }
html, body {  height: 100%;  background: #ffffff; }
#container {  display: flex;  flex-direction: row;  justify-content: center;  align-items: center;  height: 100%; }
#loginBox {  width: 400px;  text-align: center;  background-color: #ffffff; }
.input-form-box {  border: 0px solid #ff0000;  display: flex;  margin-bottom: 5px; }
.input-form-box > span {  display: block;  text-align: left;  padding-top: 5px;  min-width: 65px; }
.button-login-box {  margin: 10px 0; }
#loginBoxTitle {  color:#000000;  font-weight: bold;  font-size: 32px;  text-transform: uppercase;  padding: 5px;  margin-bottom: 20px;}
#inputBox {  margin: 10px;}
#inputBox button {  padding: 3px 5px;}
</style>

<script type="text/javascript">
$(document).ready(function(){
	
	$("button#googleLogin").click(function(){
		
		location.href="/oauth2/authorization/google";
		
	});
	
	$("button#naverLogin").click(function(){
		
		location.href="/oauth2/authorization/naver";
		
	});
	
});
</script>

<title>로그인 완료 페이지</title>
</head>
<body>
    <div id="container">
      <div id="loginBox">
	        <div id="loginBoxTitle">Login</div>
	        <div id="inputBox">
	          <div class="UserInfo">
                <div class="utilList_User"></div>
              </div>
              <form class="formps" action="/logout" method="post"></form>
	        </div>
      </div>
    </div>
</body>



</html>