<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%
 	String from = (String) request.getParameter("to");//backwards for this cuz other person gets request
	String to = (String) request.getParameter("from");
%>
</head>
<body>
<%
request.setAttribute("friend",to);
request.setAttribute("currentUser", from);
request.setAttribute("change", "1");
RequestDispatcher d = request.getRequestDispatcher("MakeFriendServlet");
d.forward(request,response);
%>
</body>
</html>