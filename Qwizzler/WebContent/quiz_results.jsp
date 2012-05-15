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
    
    <%
    
    out.print("<title>Your Result</title>");
    String username = "";
    if (session.getAttribute("user") != null) {
			User yourself = (User) session.getAttribute("user");
			username = yourself.getUsername();
		}    
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
      </div>

<% out.print("Results for" + username);%>:
<p>
<br>
<%
	long stopTime = System.currentTimeMillis();
	ServletContext context = getServletContext();
	QuizDatabase quizDB = (QuizDatabase)context.getAttribute("quizDBC");
	int quizID = Integer.parseInt(request.getParameter("quizID"));
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	int numAnswers = 0;
	Vector<Vector<String>> quizAnswers;
	Vector<String> userAnswers;
	int score = 0, totalScore = 0;
	int numQuestions = quizDB.getNumQuestions(quizID);
	for (int x = 0; x < numQuestions; x++) {
		numAnswers = Integer.parseInt(request.getParameter("numAnswers" + x));
		userAnswers = new Vector<String>(numAnswers);
		for (int i = 0; i < numAnswers; i++) {
			userAnswers.add(request.getParameter("answer" + x + "_" + i));
		}
		quizAnswers = quizDB.getAnswers(quizID, x);
		String currAnswer;
		boolean rightAnswer;
		for (int i = 0; i < numAnswers; i++) {
			totalScore++;
			currAnswer = userAnswers.get(i);
			int j = 0;
			rightAnswer = false;
			while ((j < quizAnswers.size()) && (!rightAnswer)) {
				if (quizAnswers.get(j).contains(currAnswer)) {
					score++;
					rightAnswer = true;
				}
				j++;
			}
		}
	
	}
	long startTime = Long.parseLong(request.getParameter("startTime"));
	double totalTime = (double)((stopTime - startTime)/1000);
	totalTime = totalTime/60;
	Record record = new Record(request.getParameter("username"), score, totalTime, startTime);
	quizDB.putRecord(quizID, record);
	
%>
<br>
</br>
<span>Score:</span> <%out.print(record.getScore());%> out of <%out.print((Integer)session.getAttribute("totalScore"));%>
<br>
<p>
<span>Time:</span> <%out.print(QuizDatabase.getTimeFromDouble(record.getTime()));%>
<p>
<br>
<br>
<span>Qwiz Statistics: </span>
<br>
<p>
<span>Total number of times taken:</span> <%out.print(quizDB.getRecords(quizID).size()); %>
<p>
<span>Average Score:</span> <%out.print(quizDB.getAverageScore(quizID));%>
<p> 
<span>Average Time Spent:</span> <%out.print(quiz.getAvgTime());%> seconds
<p>
<br>
<br>
<span>Top 5 Scores of all time:</span> <br/>
<%
	Vector<Record> highScores = quizDB.getTopRecords(quizID, 5);
	for (int x = 0; x < highScores.size(); x++) {
	  	out.print("<br/>");

		out.print(x + 1);
		out.print(". ");
		out.print(highScores.get(x).getUser());
		out.print("<br/>");
		out.print("Score: ");
		out.print(highScores.get(x).getScore());
		out.print("<br/>");
		out.print("Time:");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken:");
		Date date = new Date(highScores.get(x).getStart()); 
		out.print(date.toString());
		out.print("<p>");
	}
%>
<p>
<br>

<br>

<span>Recent high scores (1 day):</span> <br/>
<%
	highScores = quizDB.getBestRecentRecords(quizID, QuizDatabase.RECENT_BY_DAY,10);
	for (int x = 0; x < highScores.size(); x++) {
	  	out.print("<br/>");

		out.print(x + 1);
		out.print(". ");
		out.print(highScores.get(x).getUser());
		out.print("<br/>");
		out.print("Score: ");
		out.print(highScores.get(x).getScore());
		out.print("<br/>");
		out.print("Time:");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken:");
		Date date = new Date(highScores.get(x).getStart()); 
		out.print(date.toString());
		out.print("<p>");
	}
%>
<p>
<br>

<br>

<span>Your high scores (by Score)</span><br/>
<%
	highScores = quizDB.getUserRecords(quizID, username, QuizDatabase.ORDER_BY_SCORE, false);
	for (int x = 0; x < highScores.size(); x++) {
	  	out.print("<br/>");

		out.print(x + 1);
		out.print(". ");
		out.print(highScores.get(x).getUser());
		out.print("<br/>");
		out.print("Score: ");
		out.print(highScores.get(x).getScore());
		out.print("<br/>");
		out.print("Time:");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken:");
		Date date = new Date(highScores.get(x).getStart()); 
		out.print(date.toString());
		out.print("<p>");
	}
%>
<br>
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