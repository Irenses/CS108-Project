<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, user.*, quiz.*, database.*, java.text.DecimalFormat"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script type="text/javascript" src="js/jquery-1.7.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
    
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <title>Challenge A Friend</title>
    
    <%
    User user = null;
	ServletContext context = this.getServletContext();
    UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
    if (session.getAttribute("user") != null) {
		user = (User) session.getAttribute("user");
	} else {
		response.sendRedirect("login.jsp");
		return; 
	}
    Integer id = Integer.parseInt(request.getParameter("id"));
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
      
      <br />
      <br />
      
      <br />
      
      	    <%
          	Vector<User> friends = user.getFriends();
          	if (friends.size() == 0) out.println("You have no friends yet! Go make some.");
          	else if (udb.getBestScore(user.getUsername(), id) == -1) out.println("You haven't taken this qwiz yet! Go take it so you can challenge your friends.");
          	else {
          		out.println("<p>Please check all of the friends you would like to challenge.</p>");
          		out.println("<form action=\"ChallengeServlet\" method=\"POST\">");
            	out.println("<input type=\"hidden\" value=\"" + user.getUsername() + "\" name=\"from\"/>");
            	out.println("<input type=\"hidden\" value=\"" + id.toString() + "\" name=\"quizID\"/>");
              	for (User friend : friends) {
              	
              		out.println("<input type=\"checkbox\" name=\"friend\" value=\"" + friend.getUsername() + "\"/> " + friend.getFullName() + " (" + friend.getUsername() + ")<br />");

              	}
              	out.println("<br />");
              	out.println("<input class=\"button blue\" type=\"submit\" value=\"Challenge Friends\""); 
          		out.println("</form>");
          	}
          	%>
      
      <br />
      <br />
      <br />
            
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