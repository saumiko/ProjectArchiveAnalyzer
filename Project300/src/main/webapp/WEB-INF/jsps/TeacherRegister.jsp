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
	
	<link href="<c:url value="/resources/css/stylesTeacherRegistration.css" />"
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
			<a class="navbar-brand" href="/greatweb">SUST Archives<sup>beta</sup></a>
		</div>
	</div>
	</nav>
	</div>
	</nav>



	<h4>Register</h4>

     <div id="container">
		
		<form action="checklogin" method="post">
		
		<label for="name">Department:</label>
		
		<input type="name" id="dept" name="user_name">
		
		<label for="Designation">Designation:</label>
		
		<select name="UserType">
			<option value="1" type = "name">Professor</option>
			<option value="2" type = "name">Assistant Professor</option>
			<option value="3" type = "name">Lecturer</option>
		</select>
		
		<input type="hidden" name="Permanent" value="1">
		<input type="hidden" name="Available" value="1">
		
		
		<div id="lower">
		
		
		
		<input type="submit" value="Continue">
		
		<p id="login_status_message">
			<c:out value='${message}' />
		</p>
		
		</div>
		
		</form>
		
	</div>
	

</body>
</html>