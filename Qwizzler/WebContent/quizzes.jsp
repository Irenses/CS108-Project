<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.Vector, user.*, quiz.*, database.QuizDatabase, java.text.DecimalFormat"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script type="text/javascript" src="js/jquery-1.7.js"></script>
    <script type="text/javascript" src="js/scripts.js"></script>
    
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
 
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <title>View All Qwizzes</title>
    
    <%
    User user = null;
    if (session.getAttribute("user") != null) {
		user = (User) session.getAttribute("user");
	} else {
	    response.sendRedirect("login.jsp");
	    return; 
	}
	ServletContext context = request.getServletContext();
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
      
      <br />
      
      <div id="quizzes">
        <h2 style="text-align: center;">Qwiz Selection</h2>
        <div class="tabbed-box" id="tabbed-quiz-box">
          <ul class="tabs">
         	<li><a href="#">Popular Qwizzes</a></li>
         	<li><a href="#">Highest Rated</a></li>
         	<li><a href="#">Recent Qwizzes</a></li>
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
     			Vector<QuizName> topQzs = qdb.getHighRatingQuiz(20);
			    for (QuizName q : topQzs) {
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
        </div>
      </div>
      
      <br />
      
      <%
      String activeCat = "";
      if (request.getParameter("cat") != null) {
      	  activeCat = request.getParameter("cat");
      } else {
    	  activeCat = "Geo"; 
      }
      %>
      
        <div id="quiz-stuff-l">
      	<h2 style="text-align: center;">Sort by Category</h2>
      	
      	   <div id="quiz-selector-l">
			  <table>
			    <thead><tr><th>Qwiz Name</th><th><form action="PickCategory" method="POST" id="form">
      		<select name="category" onchange="document.getElementById('form').submit()">
      		<%
      		String[] cats = {"Geo", "Ent", "His", "Art", "Sci", "Spo"};
      		String[] Cats = {"Geography", "Entertainment", "History", "Arts and Literature", "Science and Nature", "Sports and Leisure"}; 
      	
      		String categoryName = ""; 
      		for (int i = 0; i < cats.length; i++) {
      			if (cats[i].equals(activeCat)) {
      				out.println("<option selected=\"selected\" value=" + cats[i] + ">" + Cats[i] + "</option>");
      				categoryName = Cats[i]; 
      			} else {
      				out.println("<option value=" + cats[i] + ">" + Cats[i] + "</option>");
      			}
      		}
      		%>
			</select>
			<noscript>
				<input type="submit" value="Go" id="Submit"/>
			</noscript>
		</form></th><th></th></tr></thead>
   			    <%
 			    Vector<QuizName> catQzs = qdb.getPopularQuiz(20, activeCat);
   			    for (QuizName q : catQzs) {
   			    	out.println("<tr><td><a href=\"quiz.jsp?id=" + q.getID() + "\">" + q.getName() + "</td>");
   			    	out.println("<td>" + categoryName + "</td></tr>"); 
   			    }
   			    %>
   			  </table>
      	   </div>
      	</div>
      	
      	<div id="quiz-stuff-r">
      	<h2 style="text-align: center;">Your History</h2>
      	   <div id="quiz-selector-r">
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