<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, user.*, quiz.*, database.QuizDatabase, java.text.DecimalFormat"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script type="text/javascript" src="js/jquery-1.7.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
    <script type="text/javascript" src="js/jquery.rating.pack.js"></script>
    
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/jquery.rating.css" rel="stylesheet" type="text/css">
 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
		Integer initial = 0;
		session.setAttribute("score",initial);
    Quiz quiz = null;
    User user = null;
    QuizDatabase qdb = null;
    if (session.getAttribute("user") == null) {
    	response.sendRedirect("login.jsp");
    	return; 
    }
    if (request.getParameter("id") != null) {
		String quizID = (String) request.getParameter("id");
		ServletContext context = this.getServletContext();
		qdb = (QuizDatabase) context.getAttribute("quizDBC");
 		quiz = qdb.ReconstructQuiz(Integer.parseInt(quizID));
 		context.setAttribute("quiz", quiz);
 		user = (User) session.getAttribute("user");
    }
    DecimalFormat df = new DecimalFormat("#.#");
    if (request.getParameter("achieve") != null) {
    	int ad = Integer.parseInt((String) request.getParameter("achieve"));
    	if (ad != -1) {
    		Achievement a = Achievement.getAchievement(ad);
       		out.println("<script type=\"text/javascript\">");
       		out.println("$(document).ready(function() {");
       		out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
       		out.println("});");
       		out.println("</script>");
    	}
    }
    %>
    
    <title><%=quiz.getName()%></title>
    
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
      
      <div id="quiz-title"><%=quiz.getName()%></div>
      
      <br />
      
      <div id="new-quiz-details-box">
        <p><span>Description: </span><%=quiz.getDescription()%></p>
        <%
        if (quiz.getCreator().equals(user.getUsername())) {
        	out.println("<p><span>Created by: </span>You");
        	out.println("<a href=\"DeleteServlet\">(delete Qwiz)</a></p>");
        } else {
        	out.println("<p><span>Created by: </span><a href=\"profile.jsp?user=" + quiz.getCreator() + "\">" + quiz.getCreator() + "</a></p>");
        }
        
       	if (quiz.hasPractice()) {
       		out.println("<ul id=\"with-practice\">");
       		out.println("<li><a href=\"quizTest.jsp?id=" + quiz.getID() + "&p=0\" class=\"button green\">Take Qwiz</a></li>");
       		out.println("<li><a href=\"quizTest.jsp?id=" + quiz.getID() + "&p=1\" class=\"button blue\">Practice</a></li>");
       		out.println("<li><a href=\"friendPicker.jsp?id=" + quiz.getID() + "&user=" + user.getUsername() + "\" class=\"button blue\">Challenge</a></li>");
       		out.println("</ul>");
       	} else {
       		out.println("<ul id=\"without-practice\">");
       		out.println("<li><a href=\"quizTest.jsp?id=" + quiz.getID() + "\" class=\"button green\">Take Qwiz</a></li>");
       		out.println("<li><a href=\"friendPicker.jsp?id=" + quiz.getID() + "&user=" + user.getUsername() + "\" class=\"button blue\">Challenge</a></li>");
       		out.println("</ul>");
       	}
       	%> 
      </div>
      
      <div id="quiz-stats-box">
      	<p><span>Statistics: </span></p>
      	<ul>
      	   <li><span>Rating:</span></li>
      	   <div id="star-rating">
    		<%
    		double starRatingD = quiz.getRating();
    		int starRating = (int) starRatingD; 
    		for (int i = 1; i <= 5; i++) {
    			if (i == starRating) {
    				out.println("<input name=\"star1\" type=\"radio\" class=\"star\" disabled=\"disabled\" checked=\"checked\"/>");
    			} else {
    				out.println("<input name=\"star1\" type=\"radio\" class=\"star\" disabled=\"disabled\"/>");
    			}
    		}
    		%>
      	   </div>
      	   
      	   <li><span>Average Score: </span><%=df.format(quiz.getAvgScore())%></li>
      	   <li><span>Average Time: </span><%=df.format(quiz.getAvgTime())%>s</li>
      	   <li><span>Times Taken: </span><%=quiz.getTotal()%></li>
      	 </ul>
      </div>
		
       <div id="quiz-leaderboard">
        <h2 style="text-align: center;">Top 10 Leaderboards</h2>
        <div class="tabbed-box" id="tabbed-quiz-leader-box">
       	  <ul class="tabs">
          	<li><a href="#">All Time</a></li>
          	<li><a href="#">Last 1 Day</a></li>
          	<li><a href="#">Recent</a></li>
          </ul>
          <br />
 			<div class="tabbed-content">
			  <table>
			  	<thead><tr><th></th><th>Score</th><th>Time</th></tr></thead>
			  <%
          	  Vector<Record> highestScores = quiz.getHighest(10);
			  if (highestScores.size() == 0) out.println("<tr><td>No one has played this Qwiz yet.</td></tr>");
          	  for (Record record : highestScores) {
          		  out.println("<tr>");
          		  out.println("<td>" + record.getUser() + "</td>");
          		  out.println("<td>" + df.format(record.getScore()) + "</td>");
          		  out.println("<td>" + df.format(record.getTime()) + "s</td>");
          		  out.println("</tr>");
          	  }
          	  %>
          	  </table>
			</div>
			<div class="tabbed-content">
			  <table>
			    <thead><tr><th></th><th>Score</th><th>Time</th></tr></thead>
			    <%
			    //long NUM_MILLISECONDS_DAY = 86400000; 
           	    Vector<Record> recentHighest = qdb.getBestRecentRecords(quiz.getID(), QuizDatabase.RECENT_BY_DAY, 10);
			    if (recentHighest.size() == 0) out.println("<tr><td>No one has played this Qwiz yet.</td></tr>");
           	    for (Record record : recentHighest) {
           	    	out.println("<tr>");
            		out.println("<td>" + record.getUser() + "</td>");
            		out.println("<td>" + df.format(record.getScore()) + "</td>");
            		out.println("<td>" + df.format(record.getTime()) + "s</td>");
            		out.println("</tr>");
           	    }
          	    %>
          	  </table>
			</div>
			<div class="tabbed-content">
			  <table>
			  	<thead><tr><th></th><th>Score</th><th>Time</th></tr></thead>
			      <%
	          	  Vector<Record> recentScores = quiz.getRecent(10);
			      if (recentScores.size() == 0) out.println("<tr><td>No one has played this Qwiz yet.</td></tr>");
	          	  for (Record record : recentScores) {
	          		  out.println("<tr>");
	          		  out.println("<td>" + record.getUser() + "</td>");
	          		  out.println("<td>" + df.format(record.getScore()) + "</td>");
	          		  out.println("<td>" + df.format(record.getTime()) + "s</td>");
	          		  out.println("</tr>");
	          	  }
          	      %>
          	  </table>
			</div>
        </div>
      </div>
      
      <div id="your-leaderboard">
        <h2>Your<br />Past Performance</h2>
        <div class="box">
          <table>
            <%
            Vector<Record> selfScores = quiz.getSelf(user.getUsername());
            if (selfScores.size() != 0) {
            	out.println("<thead><tr><th></th><th>Score</th><th>Time</th></tr></thead>");
	          	  for (Record record : selfScores) {
	          		  out.println("<tr>");
	          		  out.println("<td>" + record.getUser() + "</td>");
	          		  out.println("<td>" + df.format(record.getScore()) + "</td>");
	          		  out.println("<td>" + df.format(record.getTime()) + "s</td>");
	          		  out.println("</tr>");
	          	  }
            } else {
            	out.println("<thead><tr><th>You have not played this Qwiz.</th></tr></thead>");
            }
 			%>
          </table>
        </div>
      </div>
      
      <%
	  if (user.isAdmin()) {
	  	out.println("<div id=\"admin-buttons-quiz\">");
      	out.println("<p>Administrative Options:</p>");
    	out.println("<ul>");
        //out.println("<li> <a href=\"\">edit</a> </li>");
        out.println("<li> <a href=\"DeleteServlet\">delete</a> </li>");
        out.println("<li> <a href=\"ClearHistoryServlet\">clear history</a> </li>");
        out.println("</ul>");
        out.println("</div>");
	  }
	  %>
	  
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
    