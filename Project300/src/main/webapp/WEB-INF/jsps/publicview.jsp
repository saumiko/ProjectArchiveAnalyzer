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
	<form method="get" action="publicview">
 		<select name="session">
  		<option value="2010">2010</option>
  		<option value="2011">2011</option>
  		<option value="2012">2012</option>
  		<option value="2013">2013</option>
		</select>
		<input type="submit" value="go"></input>
	</form>
	<p>Session Selected : <c:out value="${courseSession}"/> </p>
	<table id="t1">
		<th>Course Id</th>
		<th>Course Title</th>
		<th>Course Code</th>
		<th>Credit</th>
		<c:forEach items="${courses}" var="courses">
        <tr>
            <td> <c:out value="${courses.getCourseId()}"/></a></td>
            <td> <a href="${pageContext.request.contextPath}/courseTaskViewReq?courseId=${courses.getCourseId()}"> <c:out value="${courses.getCourseTitle()}"/></td>
            <td><c:out value="${courses.getCredit()}"/></td>
            <td><c:out value="${courses.getCourseCode()}"/></td>
        </tr>
    </c:forEach>
	</table>
</body>
</html>