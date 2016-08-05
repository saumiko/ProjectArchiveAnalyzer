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
	
	<link href="<c:url value="/resources/css/stylesStudentRegistration.css" />"
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
		
		<label for="firstname">First Name:</label>
		
		<input type="name" id="firstname" name="firstname">
		
		<label for="firstname">Last Name:</label>
		
		<input type="name" id="lastname" name="lastname">
		
		<label for="reg">Registration Number:</label>
		
		<input type="name" id="reg" name="reg">
		
		<input type="hidden" name="dept" value="CSE">
		<input type="hidden" name="contact" value="+8801*********">
		<input type="hidden" name="address" value="Surma R/A">
		<input type="hidden" name="mstatus" value="Single">
		<input type="hidden" name="blood" value="A+">
		<input type="hidden" name="religion" value="islam">
		<input type="hidden" name="gender" value="male">
		
		<label for="bday">Date of Birth:</label>
		<input type="date" name = "bday">
		
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