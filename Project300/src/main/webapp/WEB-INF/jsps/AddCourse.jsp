<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.great.cms.db.entity.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SUST Archives</title>
<link href="<c:url value="/resources/css/topbar.css" />"
	rel="stylesheet" type="text/css" />

<link href="<c:url value="/resources/css/bootstrap.min.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/bootstrap-theme.min.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/jquery.dataTables.min.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/dataTables.bootstrap.css" />"
	rel="stylesheet" type="text/css" />
<link href="<c:url value="/resources/css/project-groups.css"/>"
	rel="stylesheet" type="text/css" />

<script
	src="<c:url value="/resources/javascript/jquery-1.11.3.min.js" />"
	type="text/javascript"></script>
<script src="<c:url value="/resources/javascript/bootstrap.min.js" />"
	type="text/javascript"></script>
<script
	src="<c:url value="/resources/javascript/jquery.dataTables.min.js" />"
	type="text/javascript"></script>
<script
	src="<c:url value="/resources/javascript/dataTables.bootstrap.js" />"
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
	<div class="container">
  <h2>Add A Course</h2>
  
  <% 
		User user = (User) session.getAttribute("User");
		if (user==null)
			response.sendRedirect("Failure");
	%>
  <form action="${pageContext.request.contextPath}/submitNewCourse" method="post" onsubmit=" return validation();">
	
	
	
    <div class="form-group">
      <label for="courseCode">Course Code</label>
      <input type="text" class="form-control" id="courseCode" name="courseCode" placeholder="Enter Course Code">
    </div>
    <div class="form-group">
      <label for="courseTitle">Course Title</label>
      <input type="text" class="form-control" id="courseTitle" name="courseTitle" placeholder="Enter Course Title">
    </div>
    <div class="form-group">
      <label for="credit">Credit</label>
      <input type="text" class="form-control" id="credit" name="credit" placeholder="Enter Credit">
    </div>
    <div class="form-group">
      <label for="semester">Semester</label>
      <input type="text" class="form-control" id="semester" name="semester" placeholder="Enter Semester">
    </div>
    <div class="form-group">
      <label for="session">Session</label>
      <input type="text" class="form-control" id="session" name="session" placeholder="Enter Session">
    </div>
   
    <input type="hidden" class="form-control" name="offeringDept" value="1">
	<input type="hidden" class="form-control" name="acceptingDept" value="1">
    <input type="submit"></input>
  </form>
</div>
</body>

<script>

function validation(){

	var text1=document.getElementById('courseCode').value.toString();
	var text2=document.getElementById('session').value.toString();
	var text3=document.getElementById('semester').value.toString();
	var text4=document.getElementById('credit').value.toString();
	var text5=document.getElementById('courseTitle').value.toString();
	if(text2=="" || text3==""||text1==""||text4==""||text5=="")
		  {
		  alert("No field should be empty");
		return false;
		  
		  }
	return true;

}
</script>


</html>