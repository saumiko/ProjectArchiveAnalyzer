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
		<th>Submission Id</th>
		<th>Download Link</th>
		<c:forEach items="${submissions}" var="submissions">
        <tr>
            <td> <c:out value="${submissions.getSubmissionId()}"/></td>
            <td> <c:out value="${submissions.getSubmissionUrl()}"/></td>        
        </tr>
    </c:forEach>
	</table>
</body>
</html>