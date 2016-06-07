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
	<p>Project Title : <c:out value="${projectTitle}"/> </p>
	<table id="t1">
		<th>Group Id</th>
		<th>Group Name</th>
		<c:forEach items="${projectGroup}" var="projectGroup">
        <tr>
            <td> <c:out value="${projectGroup.getGroupId()}"/></a></td>
            <td> <a href="${pageContext.request.contextPath}/projectFileView?groupId=${projectGroup.getGroupId()}&projectTitle=${projectTitle}"> <c:out value="${projectGroup.getGroupName()}"/></td>        
        </tr>
    </c:forEach>
	</table>
</body>
</html>