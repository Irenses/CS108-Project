<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, java.util.*, java.text.DecimalFormat, user.*, quiz.*, message.*, database.UserDatabase, database.QuizDatabase"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<script type="text/javascript" src="js/jquery-1.7.js"></script>
	<script type="text/javascript" src="js/jquery.rating.pack.js"></script>
	
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/jquery.rating.css" rel="stylesheet" type="text/css">
    
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
   
    out.print("<title>Search Results</title>");
    String username = "";
    User yourself = null;
    if (session.getAttribute("user") != null) {
			yourself = (User) session.getAttribute("user");
			username = yourself.getUsername();
		} 
    ServletContext context = request.getServletContext();
	UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
	QuizDatabase qdb = (QuizDatabase) context.getAttribute("quizDBC");
	String search = request.getParameter("query");
    %>
</head>
<body>
   <!-- Keeps the site in the center of the page; width controlled. -->
   <div id ="outer">
   <div id="wrapper">
         <form method="get" action="search.jsp" id="search">
   		 <input name="query" type="text" size="40" placeholder="Search..."/>
      </form>
      
      <div id="logo">
        <h1><a href="home.jsp" style="text-decoration: none;">Qwizzler</a></h1>
      </div>
      <div id="nav-bar">
        <ul>
          <li><a href="quizzes.jsp">QWIZZES</a></li>
          <li><a href="profile.jsp">MY PROFILE</a></li>
          <li><a href="LogoutServlet">LOGOUT</a></li>
        </ul>
      </div>
<br>
<br>

<div id="search-results">

<p>Search results...</p>
<br />

<%
Vector<UserDerp> vs = udb.getUserNames(search);//returns list of usernames matching query, can then build string that links to appropriate page
if (vs.size() > 0) { 
	out.println("<h2>Users:</h2><ul>");
for(UserDerp s: vs) {
	out.println("<li> <a href=\"profile.jsp?user=" + s.getUserName() + "\">" + s.getUserName() + "</a>       (" + s.getFullName() + ")</li>");
}
out.println("</ul>");
out.println("<br>");
}
%>

<%
Vector<QuizAct> qs = qdb.getQuizSearch(search);
if (qs.size() > 0) {
	out.println("<h2>Qwizzes:</h2><ul>");
for(QuizAct s : qs) {
	out.println("<li> <a href=\"quiz.jsp?id=" + s.getID() + "\">" + s.getName() + "</a>     -   " + s.getDesc() +" </li>");
}
out.println("</ul>");
}
%>

<br>
<br>
<br>
<br>

     <div id="footer">
        <ul>
          <li class="copyright-text">Created by:</li>
          <li class="footer-text">Kyle</li>
          <li class="footer-text">Sean</li>
          <li class="footer-text">Joaquin</li>
          <li class="footer-text">James</li>
        </ul>
      </div>
  </div> 
  </div>
  </div>
</body>
</html>