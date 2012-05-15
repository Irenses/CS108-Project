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
    UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
    User yourself = null;
    if (session.getAttribute("user") != null) {
		yourself = (User) session.getAttribute("user");
		username = yourself.getUsername();
	} else {
	    response.sendRedirect("login.jsp");
	    return; 
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
      	

<div id="quiz-details-box">
<br>
<%out.print("<h3>Results for " + username + "</h3>");%>
<p>
<%
	long stopTime = System.currentTimeMillis();
	ServletContext context = getServletContext();
	QuizDatabase quizDB = (QuizDatabase)context.getAttribute("quizDBC");
	int quizID = (Integer)session.getAttribute("quizID"); 
	Quiz quiz = quizDB.ReconstructQuiz(quizID);
	Vector<Vector<String>> userAnswers = new Vector<Vector<String>>();
	quiz.setStart((Long)session.getAttribute("start")); 
	
	if (quizDB.getOnepage(quizID)) {
		int numAnswers = 0;
		Vector<String> questionAnswers;
		//int score = 0, totalScore = 0;
		int numQuestions = quizDB.getNumQuestions(quizID);
		for (int x = 0; x < numQuestions; x++) {
			numAnswers = Integer.parseInt(request.getParameter("numAnswers" + x));
			questionAnswers = new Vector<String>(numAnswers);
			for (int i = 0; i < numAnswers; i++) {
				String ans = request.getParameter("answer" + x + "_" + i);

				if(ans != null && !ans.equals("") && !ans.equals(null)) questionAnswers.add(ans.toLowerCase());
			}
			if(questionAnswers.size() == 0) questionAnswers.add("");
			userAnswers.add(questionAnswers);
			 
		}
		Quiz curquiz = (Quiz)session.getAttribute("curquiz"); 	
		curquiz.endOnepageQuiz(quizID, username, userAnswers);
	}
	else {
			quiz.endMultipageQuiz(quizID, username, (Integer)session.getAttribute("score"));
	}
	
	out.print("<br/>");
	/*
		quizAnswers = quizDB.getAnswers(quizID, x);
		String currAnswer;
		boolean rightAnswer;
		for (int i = 0; i < numAnswers; i++) {
			totalScore++;
			currAnswer = questionAnswers.get(i);
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
		
	long startTime = Long.parseLong(request.getParameter("startTime"));
	double totalTime = (double)((stopTime - startTime)/1000);
	totalTime = totalTime/60;
	Record record = new Record(username, score, totalTime, startTime);
	quizDB.putRecord(quizID, record);
	*/
	Record record = quizDB.getUserRecords(quizID, username, QuizDatabase.ORDER_BY_DATE, false).get(0);
	session.removeAttribute("quiz");
	session.removeAttribute("quizID");
%>

<span>Score:</span> <%
int usersScore = 0;
int totalScore = 0;
if (quiz.getOnepage()) {
	usersScore = record.getScore(); 
	out.print(usersScore);
} else {
	usersScore = (Integer) session.getAttribute("score"); 
	out.print(usersScore);
}
totalScore = (Integer) session.getAttribute("totalScore");
out.println(" out of " + totalScore);
out.print("<br><p><span>Percentage: </span>" + df.format(((double)usersScore/totalScore)*100) + "%</p>");
%>
<p>
<span>Time:</span> <%out.print(df.format(record.getTime()));%> seconds
<p>
<br>
<!-- <div style="font-family: DoodlePenLimited; font-size: 20px">Qwiz Statistics</div> -->
<br>
<h3>Qwiz Statistics:</h3>
<br>
<p> 
<span>Average Score:</span> <%out.print(df.format(quizDB.getAverageScore(quizID)));%>
<p> 
<span>Average Time Spent:</span> <%out.print(df.format(quiz.getAvgTime(quizDB.getUserRecords(quizID, username, QuizDatabase.ORDER_BY_DATE, false))));%> seconds
<p>
<span>Total number of times taken:</span> <%out.print(quizDB.getRecords(quizID).size()); %>
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
		out.print("Time: ");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken: ");
		Date date = new Date(highScores.get(x).getStart()); 
		out.print(date.toString());
		out.print("<p>");
	}
%>
<p>
<br>
<%
if(highScores.size() != 0 && highScores.get(0).getUser().equals(yourself.getUsername())) {
	 if (!yourself.hasAchievement(0)) {
			Achievement a = Achievement.getAchievement(0);
			yourself.addAchievement(a);
			out.println("<script type=\"text/javascript\">");
			out.println("$(document).ready(function() {");
			out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
			out.println("});");
			out.println("</script>");
		}
	 //add greatest achievement
	 //alert giving achievement id for achievement
}
	Vector<QuizName> q = userDB.getLastNTakenQwizzes(yourself.getUsername(),10);
	if (q.size() == 1) {
		if (!yourself.hasAchievement(10)) {
   			Achievement a = Achievement.getAchievement(10);
   			yourself.addAchievement(a);
   			out.println("<script type=\"text/javascript\">");
			out.println("$(document).ready(function() {");
			out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
			out.println("});");
			out.println("</script>");
   		}
	} else if (q.size() == 5) {
		if (!yourself.hasAchievement(11)) {
   			Achievement a = Achievement.getAchievement(11);
   			yourself.addAchievement(a);
   			out.println("<script type=\"text/javascript\">");
			out.println("$(document).ready(function() {");
			out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
			out.println("});");
			out.println("</script>");
   		}
	} else if (q.size() == 10) {
		if (!yourself.hasAchievement(12)) {
   			Achievement a = Achievement.getAchievement(12);
   			yourself.addAchievement(a);
   			out.println("<script type=\"text/javascript\">");
			out.println("$(document).ready(function() {");
			out.println("alert(\"Congratulations you just earned the achievement " + a.getAchievementName() + "!\");");
			out.println("});");
			out.println("</script>");
	   	}
	}       	
%>

<br>

<span>Recent high scores (1 day):</span> <br/>
<%
	highScores = quizDB.getBestRecentRecords(quizID, QuizDatabase.RECENT_BY_DAY, 5);
	for (int x = 0; x < highScores.size(); x++) {
	  	out.print("<br/>");

		out.print(x + 1);
		out.print(". ");
		out.print(highScores.get(x).getUser());
		out.print("<br/>");
		out.print("Score: ");
		out.print(highScores.get(x).getScore());
		out.print("<br/>");
		out.print("Time: ");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken: ");
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
		out.print("Time: ");
		out.print(QuizDatabase.getTimeFromDouble(highScores.get(x).getTime()));
		out.print("<br/>");
		out.print("Date taken: ");
		Date date = new Date(highScores.get(x).getStart()); 
		out.print(date.toString());
		out.print("<p>");
	}
%>
<br>
<br>
      <form action="RateQuiz" method = "post">
	      	<br>
			<p><span>Please rate the Qwiz: </span></p>
				<input name="rating" value="1" type="radio" class="star"/>
				<input name="rating" value="2" type="radio" class="star"/>
				<input name="rating" value="3" type="radio" class="star"/>
				<input name="rating" value="4" type="radio" class="star"/>
				<input name="rating" value="5" type="radio" class="star" checked="checked"/>
			<br>	
			<br>
				
           	  <input type="hidden" name="quizID" value=<%=quizID %>>
      	      <input id="create-button" class="button orange" type="submit" value="Done"/>
      </form>
     
<br>
<br>
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