<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% response.setHeader("Cache-Control","no-cache"); 
/*HTTP 1.1*/ response.setHeader("Pragma","no-cache"); 
/*HTTP 1.0*/ response.setDateHeader ("Expires", 0);
%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width-device-width, initial-scale=1.0">
<title>SUST Archives</title>
<link href="<c:url value="/resources/css/topbar.css" />"
	rel="stylesheet" type="text/css" />
	
	<link href="<c:url value="/resources/css/reset.css" />"
	rel="stylesheet" type="text/css" />
	
	<link href="<c:url value="/resources/css/animate.css" />"
	rel="stylesheet" type="text/css" />
	
	<link href="<c:url value="/resources/css/stylesRegistration.css" />"
	rel="stylesheet" type="text/css" />

<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/bootstrap-theme.min.css" />"
	rel="stylesheet" type="text/css" />

<script
	src="<c:url value="/resources/javascript/jquery-1.11.3.min.js" />"
	type="text/javascript"></script>
<script src="<c:url value="/resources/javascript/bootstrap.min.js" />"
	type="text/javascript"></script>


</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="row topbar">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div
			class="
                 col-sm-4 col-sm-offset-1
                 col-xs-12">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/sign-in.html">SUST Archives<sup>beta</sup></a>
		</div>
	</div>
	</nav>
	</div>
	</nav>



	<h4>Register</h4>

     <div id="container">
		
		<form action="submitRegistrationForm" method="post" onsubmit=" return validation();">
		
		<label for="name">Username:</label>
		
		<input type="name" id="userName" name="userName">
		
		<label for="password">Password:</label>
		
		<input id="password" name="password" type="password">
		
		<label for="email">Email:</label>
		
		<input type="name" id="userEmail" name="userEmail">
		
		<label for="UserType">User Type:</label>
		
		<select name="userTypeName">
			<option value="Teacher" >Teacher</option>
			<option value="Student" >Student</option>
		</select>
		
		<div id="lower">
		
		
		
		<input type="submit" value="Register">
		
		<p id="login_status_message">
			<c:out value='${message}' />
		</p>
		
		</div>
		
		</form>
		
	</div>
	

</body>
<script>

function validation(){

	var text1=document.getElementById('userName').value.toString();
	var text2=document.getElementById('password').value.toString();
	var text3=document.getElementById('userEmail').value.toString();
	
	if(text2=="" || text3==""||text1=="")
		  {
		  alert("No field should be empty");
		return false;
		  
		  }
	return true;

}
</script>

</html>