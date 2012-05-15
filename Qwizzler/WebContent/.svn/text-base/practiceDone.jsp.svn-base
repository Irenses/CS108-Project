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
   
    out.print("<title>Your Result</title>");
    String username = "";
    User yourself = null;
    if (session.getAttribute("user") != null) {
			yourself = (User) session.getAttribute("user");
			username = yourself.getUsername();
		} 
	int quizID = (Integer)session.getAttribute("quizID"); 

    %>
    
</head>
<body>
   <!-- Keeps the site in the center of the page; width controlled. -->
   <div id ="outer">
   <div id="wrapper">
         <form method="get" action="" id="search">
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
      	

<div id="quiz-details-box">
<br>
<br>
<%
if (!yourself.hasAchievement(30)) {
	Achievement a = Achievement.getAchievement(30);
	yourself.addAchievement(a);
	out.println("<script type=\"text/javascript\">");
	out.println("$(document).ready(function() {");
	out.println("alert(\"Congratulations you just earned the achievement \"" + a.getAchievementName() + "\"!\");");
	out.println("});");
	out.println("</script>");
}


%>
<%out.print("<Scan>Done with practice mode!</scan>");%>
<br>
<br>


      <form action=<%="quiz.jsp?id=" + quizID%> method = "post">
      	      <input id="create-button" class="button orange" type="submit" value="Ok"/>
      </form>
     
<br>
<br>
</div>
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
</body>
</html>