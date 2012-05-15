<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, database.*, user.*,quiz.*"%>
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
	Integer id = (Integer) request.getAttribute("quizID");
	out.print("<title>Create a Qwizzle</title>");
	User user =(User) session.getAttribute("user");
	
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
        <p><span>Question successfully added!  </span></p>
        <br>

		<br>
       	<form action="IDKeeper" method="post">
        	<input type="hidden" name="quizID" value=<%=id.toString() %>>
			<input id="create-button" class="button blue" type="submit" value="  Add More Questions   "/>
       	</form>
       	<br>
       	<form action=<%="quiz.jsp?id=" + id%> method="post">
       	<%
       	Vector<QuizName> q = userDB.getLastNMadeQwizzes(user.getUsername(),10);
       	Integer achieve = -1;
       	if (q.size() == 1) {
       		if (!user.hasAchievement(20)) {
           		Achievement a = Achievement.getAchievement(20);
           		user.addAchievement(a);
           		achieve = 20;
           	}
       	} else if (q.size() == 5) {
       		if (!user.hasAchievement(21)) {
           		Achievement a = Achievement.getAchievement(21);
           		user.addAchievement(a);
           		achieve = 21;
           	}
       	} else if (q.size() == 10) {
       		if (!user.hasAchievement(22)) {
           		Achievement a = Achievement.getAchievement(22);
           		user.addAchievement(a);
           		achieve = 22;
           	}
       	}       	
       	%>
        	<input type="hidden" name="quizID" value=<%=id.toString() %>>
        	<input type="hidden" name="achieve" value=<%=achieve.toString() %>>
			<input id="create-button" class="button orange" type="submit" value="Done with the QWIZZLE"/>
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