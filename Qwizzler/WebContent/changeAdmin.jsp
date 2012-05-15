<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String user = (String) request.getParameter("user");
String admin = (String) request.getParameter("admin");
request.setAttribute("user",user);
request.setAttribute("change", admin);
RequestDispatcher d = request.getRequestDispatcher("ChangeAdminServlet");
d.forward(request,response);
%>

</body>
</html>