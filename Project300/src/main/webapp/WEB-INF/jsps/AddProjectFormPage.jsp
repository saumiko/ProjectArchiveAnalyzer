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
			<a class="navbar-brand" href="/greatweb">SUST Archives<sup>beta</sup></a>
		</div>
	</div>
	</nav>
	</div>
	</nav>
	<div class="container">
  <h2>Provide New Project Info</h2>
  <form action="${pageContext.request.contextPath}/addproject" method="get">
	<% 
		User user = (User) session.getAttribute("User");
		if (user==null)
			response.sendRedirect("Failure");
	%>
	<input type="hidden" class="form-control" id="task_id" name="task_id" value="${task_id}">
    <div class="form-group">
      <label for="projectTitle">Project Title:</label>
      <input type="text" class="form-control" id="projectTitle" name="projectTitle" placeholder="Enter Project Title">
    </div>
    <div class="form-group">
      <label for="projectDesc">Project Description:</label>
      <input type="text" class="form-control" id="projectDesc" name="projectDesc" placeholder="Enter Description">
    </div>
    
    <input type="submit"></input>
  </form>
</div>
</body>
<script>
function submitForm(task_id){
	projectTitle = $('#projectTitle').val();
	projectDesc = $('#projectDesc').val();
	window.location.href = "${pageContext.request.contextPath}/addproject?task_id="+task_id+"&projectTitle="+projectTitle+"&projectDesc="+projectDesc;
}
</script>
</html>