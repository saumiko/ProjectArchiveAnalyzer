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
	<table id="t1">
		<th>Task Id</th>
		<th>Task Title</th>
		<c:forEach items="${tasks}" var="tasks">
        <tr>
            <td> <c:out value="${tasks.getTaskId()}"/></a></td>
            <td> <a href="${pageContext.request.contextPath}/projectViewReq?taskId=${tasks.getTaskId()}"> <c:out value="${tasks.getTaskTitle()}"/></td>
            
        </tr>
    </c:forEach>
	</table>
</body>
</html>