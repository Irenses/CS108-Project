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
    <title>Check Answer</title>
    
</head>
<body>
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
      </div>
      
	<form action="multiPage.jsp" method="POST">
	 		<br>
	
	 		<br>
	
<%
	Boolean immediate = (Boolean)session.getAttribute("immediate");
	Integer score = (Integer)session.getAttribute("score");
	Vector<Vector<String>> answers = (Vector<Vector<String>>)session.getAttribute("answers");
	int currentQuestion = (Integer)session.getAttribute("currentQuestion") - 1;
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	int numAnswers = Integer.parseInt(request.getParameter("numAnswers" + currentQuestion));
	Vector<String> questionAnswers = new Vector<String>(numAnswers);
	for (int i = 0; i < numAnswers; i++) {
		String ans = request.getParameter("answer" + currentQuestion + "_" + i);
		if(ans != null && !ans.equals("")) questionAnswers.add(ans.toLowerCase());
	}
	if(questionAnswers.size() == 0) questionAnswers.add("");
	int scored = quiz.checkAnswer(questionAnswers);
	score += scored;
	Integer totalanswer = Integer.parseInt(request.getParameter("totalanswer"));
	
	if(immediate == true){
		if ((totalanswer == 0 && scored == questionAnswers.size()) || (totalanswer > 0 && scored == questionAnswers.size() && scored == totalanswer))
			out.print("Correct!<br/>");
		else {
			out.print("Sorry, that's incorrect <br/> The correct answer is: ");
			out.print(quiz.getCurrentAnswer());
			out.print("<br/>");
		}
	}
	answers.add(questionAnswers);
	session.setAttribute("answers", answers);
	session.setAttribute("score", score);

%>

 		<br>
	<input id="create-button" class="button orange" type="submit" value="Next"/>
	 		<br>
	 		<br>
	 		<br>
	
	</form>
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