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
  <h2>Add A Task</h2>
  
  <% 
		User user = (User) session.getAttribute("User");
		if (user==null)
			response.sendRedirect("Failure");
	%>
  <form action="${pageContext.request.contextPath}/addtask" method="post" onsubmit=" return validation();" >
	
	
	
    <div class="form-group">
      <label for="taskTitle">Task Title</label>
      <input type="text" class="form-control" id="taskTitle" name="taskTitle" >
    </div>
    <div class="form-group">
      <label for="taskTitle">Task Desc</label>
      <input type="text" class="form-control" id="taskDesc" name="taskDesc" >
    </div>
    <div class="form-group">
      <label for="deadline">DeadLine(Please follow this format YYYY-MM-DD hh:mm:ss)</label>
      <input type="text" class="form-control" id="deadline" name="deadline" >
    </div>
    
   
    
    <input type="submit" ></input>
  </form>
</div>
</body>

<script>

function validation(){

	var text=document.getElementById('deadline').value.toString();
	var text2=document.getElementById('taskDesc').value.toString();
	var text3=document.getElementById('taskTitle').value.toString();
	if(text2=="" || text3=="")
		  {
		  alert("No field should be empty");
		return false;
		  
		  }
  var num=text.length;
  
  if(num!=19)
  {alert("Formate MisMatched");
  return false;}

  var m=0;

for(var i=0;i<num;i++)
	{
if((i==4||i==7)&&(text.charAt(i)!='-'))
{alert("Formate MisMatched");
return false;}
	
else if((i==13||i==16)&&(text.charAt(i)!=':'))
{alert("Formate MisMatched");
return false;}

else if((i==10)&&(text.charAt(i)!=' '))
{alert("Formate MisMatched");
return false;}
else if((text.charAt(i)>='0' && text.charAt(i)<='9'))
{
m++;
}	
	}
if(m!=14)
{alert("Formate MisMatched");
return false;}

	return true;

}
</script>

</html>