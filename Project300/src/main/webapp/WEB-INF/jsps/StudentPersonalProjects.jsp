<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setHeader("Cache-Control", "no-cache");
	/*HTTP 1.1*/ response.setHeader("Pragma", "no-cache");
	/*HTTP 1.0*/ response.setDateHeader("Expires", 0);
%>
<%@page import="com.great.cms.db.entity.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width-device-width, initial-scale=1.0">
 <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
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
		<div
			class="
                 col-sm-5 col-sm-offset-1
                 col-xs-12">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#">${UserRole.getUserName()}</a></li>
				<li><a href="#">Settings</a></li>
				<li><a href="sign-in.html">Log out</a></li>
			</ul>
		</div>
	</div>
	</nav>


	<div class="container">

		
		<div class="row searchbar">

			<div class="clearfix"></div>
		</div>
		
		<% 
		User user = (User) session.getAttribute("User");
		if (user==null)
			response.sendRedirect("Failure");
	%>
		<div class="panel col-lg-6 col-sm-6">
			<div class="row">
				
				<div class="col-xs-4 rowAddButton">

					

				</div>
			</div>
			<table id="projectTable"
				class="table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th
							class="	col-md-1
                            col-sm-1
                            col-xs-1">
							ID</th>
						<th
							class="	col-md-2
                            col-sm-4
                            col-xs-4">
							Title</th>
						<th
							class="	col-md-3
                            col-sm-3
                            col-xs-3">
							Description</th>
						<th
							class="	col-md-2
                            col-sm-2
                            col-xs-2">
							Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${projectList}" var="projectList">
						<tr>
							<td><c:out value="${projectList.getProjectId()}" /></td>
							<td><a
								href="${pageContext.request.contextPath}/projectgroups?task_id=${task_id}&project_id=${projectList.getProjectId()}">
									<c:out value="${projectList.getProjectTitle()}" />
							</a></td>
							<td><c:out value="${projectList.getProjectDesc()}" /></td>
							<td><a href="toUpdateProjectFormPage?task_id=${task_id}&projectId=${projectList.getProjectId()}&projectTitle=${projectList.getProjectTitle()}&projectDesc=${projectList.getProjectDesc()}" class="btn btn-info btn-sm editbutton"><i
									class="glyphicon glyphicon-edit "></i></a> <a onclick="confirmDelete(${task_id},${projectList.getProjectId()})"
								class="btn btn-danger btn-sm removebutton"><i
									class="glyphicon glyphicon-remove "></i></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	
		

		<!--panel 2-->




		

		

		<!-- body container -->
</body>
<script>
$(document).ready(function(){
    $('#projectTable').DataTable();
    $('#groupTable').DataTable();
});

function confirmDelete(taskId,projectId){
	var result = confirm("Want to delete?");
	if (result) {
	    window.location.href = "${pageContext.request.contextPath}/deleteproject?taskId="+taskId+"&projectId="+projectId;
	}
}
function goToAddProjectForm(task_id){
	window.location.href = "${pageContext.request.contextPath}/addproject2?task_id="+task_id;
}
function goToAddGroupFormPage(task_id){
	alert("whoops!!!!");
	window.location.href = "${pageContext.request.contextPath}/goToAddGroupFormPage?task_id="+task_id;
}
function goToUpdateGroupPage(groupId,taskId){
	alert("whoops!!!!");
	window.location.href = "${pageContext.request.contextPath}/gotoupdategroupformpage?groupId="+groupId+"&taskId="+taskId;
}
function goDeleteGroup(groupId,taskId){
	alert("whoops!!!!");
	window.location.href = "${pageContext.request.contextPath}/deletegroup?groupId="+groupId+"&taskId="+taskId;
}
</script>
</html>