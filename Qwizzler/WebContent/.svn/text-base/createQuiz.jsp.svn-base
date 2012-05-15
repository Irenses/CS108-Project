<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, database.*,user.*, quiz.*"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    
    QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
    UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
    out.print("<title>Create a Qwizzle</title>");
    User user = (User) session.getAttribute("user");
    Integer error = 0;
    if (request.getAttribute("error") != null) {
      	error = (Integer) request.getAttribute("error");
    }
    
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
      	<%
       	//Vector<Quiz> q = udb.getLastNCreatedQwiz(10);
       	Vector<QuizName> q = userDB.getLastNMadeQwizzes(user.getUsername(),10);
       	if (q.size() == 1) {
       		if (!user.hasAchievement(20)) {
           		Achievement a = Achievement.getAchievement(20);
           		user.addAchievement(a);
           		out.println("<script type=\"text/javascript\">");
           		out.println("$(document).ready(function() {");
           		out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
           		out.println("});");
           		out.println("</script>");
           	}
       	} else if (q.size() == 5) {
       		if (!user.hasAchievement(21)) {
           		Achievement a = Achievement.getAchievement(21);
           		user.addAchievement(a);
           		out.println("<script type=\"text/javascript\">");
           		out.println("$(document).ready(function() {");
           		out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
           		out.println("});");
           		out.println("</script>");
           	}
       	} else if (q.size() == 10) {
       		if (!user.hasAchievement(22)) {
           		Achievement a = Achievement.getAchievement(22);
           		user.addAchievement(a);
           		out.println("<script type=\"text/javascript\">");
           		out.println("$(document).ready(function() {");
           		out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
           		out.println("});");
           		out.println("</script>");
           	}
       	}       	
       	%>
      
      <div id="quiz-details-box">
      <%
      	if(error == 1){
           out.print("<br/>");
		   out.println("<p><span>No field can be left blank, please try again.</span></p>");
      	}else if(error == 2){
            out.print("<br/>");
 		   out.println("<p><span>Sorry, the name you chose for your QWIZZLE is used, please choose a new one.</span></p>");
       	}
      %>
        <br>
        <p><span>Name of your QWIZZLE: </span></p>
        	<form action="CreateQuiz" method="post">
	  			<ul>
				  	<li>	
				  	  <input id="quiz_name" class="fieldBox" placeholder="Name of your QWIZZLE" type="text" name="name"/>	
				  	</li>
				</ul>
        <br>
        <p><span>Description of your QWIZZLE: </span></p>
	  			<ul>
				  	<li>	
				  	  <input id="quiz_description" class="fieldBox" placeholder="Description of your QWIZZLE" type="text" name="description"/>	
				  	</li>
				</ul>
		<br>
		<br>
		<p><span>Please select a category of your QWIZZLE: </span></p>
        <select name="category">
		  <option value="Geo">Geography</option>
		  <option value="Ent">Entertainment</option>
		  <option value="His">History</option>
		  <option value="Art">Arts and Literature</option>
		  <option value="Sci">Science and Nature</option>
		  <option value="Spo">Sports and Leisure</option>
		</select>
		<br>		
				<br>
				<br>
		<p><span>Random order for your QWIZZLE? </span></p>
	  			<ul>
				  	<li>	
				  	  <input id="quiz_random_yes" type="radio" name="random" value="a">Yes
				  	</li>
				  	<li>	
				  	  <input id="quiz_random_no" type="radio" name="random" checked value="b">No	
				  	</li>
				</ul>
		<br>
		<p><span>Show your QWIZZLE on multiple pages? </span></p>
	  			<ul>
				  	<li>	
				  	  <input id="quiz_onepage_yes" type="radio" name="onepage" value="a">Yes, and I want immediate correction
				  	</li>
				  	<li>	
				  	  <input id="quiz_onepage_yes" type="radio" name="onepage" value="b">Yes, and I don't want immediate correction
				  	</li>
				  	<li>	
				  	  <input id="quiz_onepage_no" type="radio" name="onepage" checked value="c">No	
				  	</li>
				</ul>
		<br>
		<p><span>Enable practice mode for your QWIZZLE? </span></p>
	  			<ul>
				  	<li>	
				  	  <input id="quiz_practice_yes" type="radio" name="practice" value="a">Yes
				  	</li>
				  	<li>	
				  	  <input id="quiz_practice_no" type="radio" name="practice" checked value="b">No	
				  	</li>
				</ul>

				<input id="create-button" class="button orange" type="submit" value="Create QWIZZLE!"/>
        	</form>
        	<br>
        	<br>
      </div>
      
            
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