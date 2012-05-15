<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, database.*, quiz.*, java.text.DecimalFormat, user.*, quiz.Quiz, quiz.Record, message.*,database.*"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script type="text/javascript" src="js/jquery-1.7.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
    
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title>Qwizzler</title>
    
    <% 
    User user = null;
    String profileLink = "profile.jsp";
	if (session.getAttribute("user") != null) {
		user = (User) session.getAttribute("user");
	} else {
		response.sendRedirect("login.jsp");
		return; 
	}
	ServletContext context = request.getServletContext();
	UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
	QuizDatabase qdb = (QuizDatabase) context.getAttribute("quizDBC");
	DecimalFormat df = new DecimalFormat("#.#");
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
      <div id="fun-fact">
        <%
        if (qdb != null) {
        	out.println("<p>Qwizzler is home to " + udb.getNumUsers() + " registered users and " + qdb.getNumQuizes() + " free trivia games played " + qdb.getTotalRecords() + " times.</p>");
        }
        %>
      </div>
      <br />
      <div id="a-whole">
        <h2 style="text-align: center;">Announcements</h2>
        <div id="a-box">
          <ul>
          	<%
          	if (user.isAdmin()) {
          		out.println("<li><a id=\"announce-button\" href=\"\">Add Announcement</a></li>");
          	}
          	%>
            <%
			  Vector<Message> meh = user.getAnnounce(); //challenges
			  for (Message m : meh) {
				  out.println("<li>" + m.getBody() + "</li>");
			  }
			  %>
          </ul>
        </div>
      </div>
      <div id="message-center">
        <h2 style="text-align: center;">Message Center</h2>
        <div class="tabbed-box" id="tabbed-message-box">
       	  <ul class="tabs">
          	<li><a href="#">Friend Requests</a></li>
          	<li><a href="#">Private Messages</a></li>
          	<li><a href="#">Qwiz Challenges</a></li>
          </ul>
          <br />
 			<div class="tabbed-content">
			  <%
			  Vector<Message> mess = user.getMessages(2);//friend requests
			  if (mess.size() == 0) out.println("<li>You have no friend requests.</li>");
			  for (Message m : mess) {
				  out.println("<li>" + m.getBody() + "</li>");
			  }
			  %>
			</div>
			<div class="tabbed-content">
			  <%
			  Vector<Message> mes = user.getMessages(3);//notes
			  if (mes.size() == 0) out.println("<li>You have no messages.</li>");
			  for (Message m : mes) {
				  out.println("<li> <a href=\"profile.jsp?user=" + m.getFrom() + "\">" + m.getFrom() + "</a> said: " + m.getBody() + "</li>");//should do more formatting so it says who it's from
			  }
			  %>
			</div> 
			<div class="tabbed-content">
			  <%
			  Vector<Message> me = user.getMessages(1);//challenges
			  if (me.size() == 0) out.println("<li>You have not been challenged.</li>");
			  for (Message m : me) {
				  out.println("<li>" + m.getBody() + "</li>");
			  }
			  %>
			</div>
        </div>
      </div>
		<br />
		<br />
      <div id="quizzes">
        <h2 style="text-align: center;">Qwiz Selection</h2>
        <div class="tabbed-box" id="tabbed-quiz-box">
          <ul class="tabs">
         	<li><a href="#">Popular Qwizzes</a></li>
         	<li><a href="#">Recent Qwizzes</a></li>
         	<li><a href="#">Your History</a></li>
         </ul>
         <br />
   			<div class="tabbed-content">
   			  <table>
   			    <thead><tr><th>Qwiz Name</th><th>Description</th></tr></thead>
   			    <%
     			Vector<QuizName> popQzs = qdb.getPopularQuiz(20); 
   			    for (QuizName q : popQzs) {
   			    	out.println("<tr><td><a href=\"quiz.jsp?id=" + q.getID() + "\">" + q.getName() + "</td>");
   			    	out.println("<td>" + q.getDescription() + "</td></tr>"); 
   			    }
   			    %>
   			  </table>
			</div>
			<div class="tabbed-content">
			  <table>
			    <thead><tr><th>Qwiz Name</th><th>Description</th></tr></thead>
   			    <%
    			Vector<QuizName> recQzs = qdb.getRecentQuiz(20);
   			    for (QuizName q : recQzs) {
   			    	out.println("<tr><td><a href=\"quiz.jsp?id=" + q.getID() + "\">" + q.getName() + "</td>");
   			    	out.println("<td>" + q.getDescription() + "</td></tr>"); 
   			    }  
   			    %>
   			  </table>
			</div>
			<div class="tabbed-content">
			  <table>
			    <thead><tr><th>Qwiz Name</th><th>Score</th><th>Time</th></tr></thead>
   			    <%
   			    Vector<Record> histQzs = qdb.getUserRecords(user.getUsername(), QuizDatabase.ORDER_BY_DATE, false);
			    for (Record r : histQzs) {
		    		out.println("<tr>");
		    		out.println("<td><a href=\"quiz.jsp?id=" + r.getQuizID() + "\">" + r.getQuizName() + "</a></td>");
		    		out.println("<td>" + df.format(r.getScore()) + "</td>");
		    		out.println("<td>" + df.format(r.getTime()) + "s</td>"); 
		    		out.println("</tr>");
		    	}
   			    %>
   			  </table>
			</div>
        </div>
      </div>
      
      <br />
      
      <% 
      Vector<String> acts = user.getLastNActivities(10, 0);
      if (acts.size() != 0) {
      	out.println("<div id=\"recent-activity\">");
     	out.println("<h2 style=\"text-align: center;\">Your Recent Activity</h2>"); 
        out.println("<div class=\"box\" id=\"recent-boxes\"><ul class=\"box-content\">"); 
        for (String a : acts) {
            out.println("<li>" + a + "</li>");
        }
        out.println("</ul></div></div>");
        
        Vector<String> fracts = user.getFriendActivity(10);
        out.println("<div id=\"friend-activity\">");
        out.println("<h2 style=\"text-align: center;\">Friends' Recent Activity</h2>"); 
        out.println("<div class=\"box\" id=\"recent-boxes\"><ul class=\"box-content\">"); 
        for (String f : fracts) {
          	out.println("<li>" + f + "</li>");
        }
        out.println("</ul></div></div>");
        out.println("<br /><br />");
      }
      %>
      

      
      <div id="achievements">
        <h2>Your Achievements</h2>
      	<div id="achievement-tabs">
      	  <ul>
         	<%
      	    Vector<Achievement> ach = user.getAchievements();
         	if (ach.size() == 0) out.println("<p>None yet.</p>");
      	    for (Achievement a : ach) {
      	    	out.println("<li><a href=\"\"><img src=\"images/achievements/" + a.getPicture() + "\"/></a></li>"); 
      	    }
      	    %>
          </ul>
        	<%
      	    for (Achievement a : ach) {
      	    	out.println("<div class=\"achievement-description\">");
      	    	out.println("<p><span class=\"achievement-title\">" + a.getAchievementName() + "</span><br />" + a.getDescription() + "</p>");
    			out.println("</div>");
      	    }
      	    %>
	     </div>
      </div>
 
 <%     
//             if (fracts.size() == 0) {
//            		out.println("<script type=\"text/javascript\">");
//            		out.println("$(document).ready(function() {");
//            		out.println("$(\"#friend-activity\").css(\"visibility\", \"hidden\");");
//            		out.println("});");
//            		out.println("</script>");
//             }
 %>
      
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
      
      <div class="messagepop pop centered" id="announce-pop">
		<form method="post" id="send-message" action="AnnounceServlet">
			<input type="hidden" value="<%=user.getUsername()%>" name="from"/>
			
			<p><label for="subject">Announcement</label>
			<input class="formBox" type="text" size="58" name="announcement" id="announcement-field"/></p>
			
			<div id="send-buttons-row">
			<p><input type="submit" value="Add Announcement" name="add" class="button orange"/><input type="submit" value="Cancel" class="button blue" id="announce-close-button" onClick="this.form.reset()"/></p>
			</div>
		</form>
	  </div>
      
  </div>
  </div>
  </body>
  
</html>
    