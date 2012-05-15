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
    Quiz quiz = (Quiz) request.getAttribute("quiz");
	Integer id = (Integer) request.getAttribute("quizID");
	out.print("<title>Create a Qwizzle</title>");
	
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
        <h1><a href="home.html" style="text-decoration: none;">Qwizzler</a></h1>
      </div>
      <div id="nav-bar">
        <ul>
          <li><a href="quizzes.html">QWIZZES</a></li>
          <li><a href="profile.jsp">MY PROFILE</a></li>
          <li><a href="LogoutServlet">LOGOUT</a></li>
        </ul>
      </div>A
      
      <div id="quiz-details-box">
        <br>
        <p><span>Quiz successfully created!</span></p>
        <br>
        <p><span>Quiz Name: </span><% out.print(request.getAttribute("name"));%></p>       
        <br>
        <p><span>Quiz Description: </span><% out.print(request.getAttribute("description"));%></p>
		<br>
        <form action="IDKeeper" method="post">
            <input type="hidden" name="method" value=<%="sc" %>>
        	<input type="hidden" name="quizID" value=<%=id.toString() %>>
			<input id="create-button" class="button blue" type="submit" value="Add A Question!"/>
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