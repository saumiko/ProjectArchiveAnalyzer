<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<p>Session Selected : <c:out value="${courseSession}"/> </p>
	<p>Course Title : <c:out value="${courseTitle}"/> </p>
	<a href="projectViewReq?taskId=${taskId}">Project Wise View</a>
	<a href="projectGroupViewReq?taskId=${taskId}">Group Wise View</a>
	<table id="t1">
		<th>Project Id</th>
		<th>Project Title</th>
		<th>Project Desc</th>
		<c:forEach items="${projects}" var="projects">
        <tr>
            <td> <c:out value="${projects.getProjectId()}"/></a></td>
            <td> <a href="${pageContext.request.contextPath}/projectGroupView?projectId=${projects.getProjectId()}&projectTitle=${projects.getProjectTitle()}"> <c:out value="${projects.getProjectTitle()}"/></td>        
        </tr>
    </c:forEach>
	</table>
</body>
</html>