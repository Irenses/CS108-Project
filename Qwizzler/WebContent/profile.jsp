<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, java.text.DecimalFormat, user.*, quiz.*, message.*, database.UserDatabase, database.QuizDatabase"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script type="text/javascript" src="js/jquery-1.7.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
    
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
    <%
    boolean usersOwnProfile = false; 
    User user = null;
    User yourself = null;
    ServletContext context = this.getServletContext();
    if (session.getAttribute("user") == null) {
    	response.sendRedirect("login.jsp");
    	return; 
    }
	QuizDatabase qdb = (QuizDatabase) context.getAttribute("quizDBC");
	UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
    if (request.getParameter("user") != null) {
		String username = (String) request.getParameter("user");
 		user = udb.getUserInfo(username);
 		yourself = (User) session.getAttribute("user");
 		if (user.getUsername().equals(yourself.getUsername())) {
 			usersOwnProfile = true;
 		}
    } else {
    	user = (User) session.getAttribute("user");
    	yourself = user; 
    	usersOwnProfile = true;
    }
  	if (usersOwnProfile) {
  		out.println("<title>Your Profile</title>");
  	} else {
  		out.println("<title>" + user.getUsername() + "'s Profile</title>");
  	}
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
      
      <div id="details-box">
      	<%
  	  	if (usersOwnProfile) {
  	    	out.println("<div id=\"welcome-message\">Welcome " + user.getUsername() + ".</div>");
      	} else {
    		out.println("<div id=\"welcome-message\">Viewing " + user.getUsername() + "'s profile.</div>");
      	}
  	  	%>
      	<ul>
           <li><span>User Name: </span><%=user.getUsername()%></li>
      	   <li><span>Full Name: </span><%=user.getFullName()%></li>
      	   <li><span>Email: </span><%=user.getEmail()%></li>
      	   <li><span>Joined Qwizzler: </span><%=user.getDateString()%></li>
      	   <%
      	   if (usersOwnProfile) {
      		   out.println("<li><a href=\"createQuiz.jsp\" class=\"button blue profile-button\">Create a Qwizzle</a></li>");
      	   } else if (!yourself.isFriendsWith(user.getUsername())) {
      		   out.println("<li><a href=\"\" id=\"add-friend-button\" class=\"button blue profile-button\">Add Friend</a></li>");
      	   } else {
      		   out.println("<li><a href=\"\" id=\"send-message-button\" class=\"button blue profile-button\">Send Message</a></li>");
      	   }
      	   %>
	  
      	</ul>
      </div>
      
      <div id="user-activity">
        <%
  	    if (usersOwnProfile) {
  	      out.println("<h2 style=\"text-align: center;\">Your Recent Activity</h2>");
        } else {
          out.println("<h2 style=\"text-align: center;\">" + user.getUsername() + "'s Recent Activity</h2>");
        }
  	    %>
        <div id="user-activity-box">
          <ul class="box-content">
          	<%
          	Vector<String> acts; 
          	if (usersOwnProfile) {
          		acts = user.getLastNActivities(20, 0);
          	}
          	else acts = user.getLastNActivities(20, 1);
          	if (acts.size() == 0) {
          		out.println("<li>You haven't done anything yet! Start playing some games by clicking the \"Qwizzes\" tab above.</li>");
          	}
          	for (String a : acts) {
          		out.println("<li>" + a + "</li>");
          	}
          	%>
            <!-- <li><a href="">See full history and more detailed statistics.</a></li> -->
          </ul>
      	</div>
      </div>
      
       <div id="friends-list">
        <%
  	    if (usersOwnProfile) {
  	      out.println("<h2 style=\"text-align: center;\">Your Friend List</h2>");
        } else {
          out.println("<h2 style=\"text-align: center;\">" + user.getUsername() + "'s Friend List</h2>");
        }
  	    %>
        <div id="friends-list-box">
          <table>
          	<%
          	Vector<User> friends = user.getFriends();
          	if (friends.size() == 0) out.println("<ul><li>You have no friends yet! Try searching for your friends' names in the Search bar up top.</li></ul>");
          	for (User friend : friends) {
          		out.println("<tr>");
          		out.println("<td><a href=\"profile.jsp?user=" + friend.getUsername() + "\">" + friend.getUsername() + "</a></td>");
          		if (usersOwnProfile) {
          			out.println("<td>" + friend.getFullName() + " <a href=\"deleteFriend.jsp?from=" + yourself.getUsername() + "&to=" + friend.getUsername() + "\" id=\"delete-icon\"><img src=\"images/x_icon.png\"></a></td>");
          		} else {
          			out.println("<td>" + friend.getFullName() + "</td>");
          		}
          		
          		out.println("</tr>");
          	}
          	%>
          </table>
      	</div>
       </div>
      
      <div id="quiz-stats">
        <h2 style="text-align: center;">Qwizzes</h2>
        <div class="tabbed-box" id="tabbed-quiz-stats-box">
          <ul class="tabs">
          	<%
  	        if (usersOwnProfile) {
  	          out.println("<li><a href=\"\">Created by You</a></li>");
              out.println("<li><a href=\"\">Completed by You</a></li>");
            } else {
              out.println("<li><a href=\"\">Created by " + user.getUsername() + "</a></li>");
              out.println("<li><a href=\"\">Completed by " + user.getUsername() + "</a></li>");
            }
  	        %>
          </ul>
         <br />
   			<div class="tabbed-content"> 
   			  <table>
			  <%
			  Vector<QuizName> qzsCreated = udb.getLastNMadeQwizzes(user.getUsername(), 20); 
			  for (QuizName q : qzsCreated) {
				  out.println("<tr>");
				  out.println("<td><a href=\"quiz.jsp?id=" + q.getID() + "\"/>"+ q.getName() + "</td>");
				  out.println("</tr>");
			  }
			  %>
			  </table>
			</div>
			<div class="tabbed-content">
			   <table>
			   <thead><tr><th>Qwiz Name</th><th>Score</th></tr></thead>
			   <%
 			   Vector<Record> qzsTaken = qdb.getUserRecords(user.getUsername(), QuizDatabase.ORDER_BY_DATE, false);
			   for (Record r : qzsTaken) {
				  out.println("<tr>");
			      out.println("<td><a href=\"quiz.jsp?id=" + r.getQuizID() + "\"/>"+ r.getQuizName() + "</td>");
			      out.println("<td>" + df.format(r.getScore()) + "</td>");
			      out.println("</tr>");
			   }	
			   %>
			   </table>
			</div>
        </div>
      </div>
      
      <br />
      <br />
     
       <div id="achievements">
        <%
  	    if (usersOwnProfile) {
  	      out.println("<h2 style=\"text-align: center;\">Your Achievements</h2>");
        } else {
          out.println("<h2 style=\"text-align: center;\">" + user.getUsername() + "'s Achievements</h2>");
        }
  	    %>
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
	  if (yourself.isAdmin() && !usersOwnProfile) {
	  	out.println("<div id=\"admin-buttons-profile\">");
      	out.println("<p>Administrative Options:</p>");
    	out.println("<ul>"); 
        out.println("<li> <a href=\"deleteAccount.jsp?user=" + user.getUsername() +"\">delete</a> </li>");
	  	if (user.isAdmin()) out.println("<li> <a href=\"changeAdmin.jsp?user=" + user.getUsername() +"&admin=0\">downgrade</a> </li>");
	  	else out.println("<li> <a href=\"changeAdmin.jsp?user=" + user.getUsername() +"&admin=1\">upgrade to admin</a> </li>");
        out.println("</ul>"); 
      	out.println("</div>"); 
	  }
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
      
      <!-- Hidden popups -->
      
      <div class="messagepop pop centered" id="message-pop">
		<form method="post" id="send-message" action="NoteServlet">
			<input type="hidden" value="<%=user.getUsername()%>" name="to"/>
			<input type="hidden" value="<%=yourself.getUsername() %>" name="from"/>	
			<p><label for="body">Message</label>
			<textarea class="formBox" rows="6" name="body" cols="45"></textarea></p>
			
			<div id="send-buttons-row">
			<p><input type="submit" value="Send Message" name="send" class="button orange"/><input type="submit" value="Cancel" class="button blue" id="msg-close-button" onClick="this.form.reset()"/></p>
			</div>
		</form>
	  </div>
	  
	  <div class="messagepop pop centered" id="friend-pop">
	  <p><%=user.getUsername()%> was sent a friend request.</p>
	 	<form method="post" id="send-message" action="FriendRequestServlet">
			<input type="hidden" value="<%=user.getUsername()%>" name="to"/>
			<input type="hidden" value="<%=yourself.getUsername() %>" name="from"/>	
	  		<div id="friend-buttons-row">
	  		  <p><input type="submit" value="Close" class="button blue" id="friend-close-button"/></p>
	  		</div>
		</form>
	  </div>
      
  </div>
  </div>
  </body>
  
</html>
    