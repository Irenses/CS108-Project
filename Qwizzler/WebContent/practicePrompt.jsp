<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="database.*" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String username = request.getParameter("username");
	session.setAttribute("username", username);
	
	QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
	int quizID = Integer.parseInt(request.getParameter("quizID"));
	boolean practice = quizDB.getPractice(quizID);
	if (!practice) {
		RequestDispatcher dispatch = request.getRequestDispatcher("quizTest.jsp");
		dispatch.forward(request, response);
		return;
	}
		
%>
	<form action="quizTest.jsp" method="POST">
	<input type="checkbox" name="p" /> Practice?<br />
	<p>
	<input id="create-button" class="button orange" type="submit" value="Start"/>
	<%
    out.println("<input name=\"quizID\" type=\"hidden\" value=\"" + quizID + "\"/>");
	%>
	</form>
</body>
</html>