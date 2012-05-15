<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, database.*, quiz.*"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    
    QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
    UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
    Quiz quiz = quizDB.ReconstructQuiz(0);
    out.print("<title>Create a Qwizzle</title>");
    
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
      
      <div id="quiz-details-box">
      	<br>
      	<p><span>Sorry, the name you chose for your QWIZZLE is used, please choose a new one. </span></p>
      	
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
		<p><span>Random order for your QWIZZLE? </span></p>
	  			<ul>
				  	<li>	
				  	  <input id="quiz_random_yes" type="radio" name="random" value="a">Yes
				  	</li>
				  	<li>	
				  	  <input id="quiz_random_no" type="radio" name="random" checked value="a">No	
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
				  	  <input id="quiz_practice_no" type="radio" name="practice" checked value="a">No	
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