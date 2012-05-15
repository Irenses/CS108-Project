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
    
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <%
    String username = "";
    if (session.getAttribute("user") != null) {
			User yourself = (User) session.getAttribute("user");
			username = yourself.getUsername();
		} 
    out.print("<title>");
    out.print("Your Time!!</title>"); 
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
	<% 
	
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
	Vector<Vector<String>> answers = (Vector<Vector<String>>)session.getAttribute("answers");
	int currentQuestion = (Integer)session.getAttribute("currentQuestion");
	Integer totalScore = (Integer)session.getAttribute("totalScore");
	boolean random = quizDB.getRandom(quiz.getID());
	Boolean immediate = quizDB.getImmediate(quiz.getID());
	session.setAttribute("immediate", immediate);
	session.setAttribute("quizID", quiz.getID());

	
		out.print("<form action=\"immediateCorrection.jsp\" method=\"POST\">");

	/*if ((currentQuestion > 0) && (!immediate)) {
		int prevQuestion = currentQuestion - 1;
		int numAnswers = Integer.parseInt(request.getParameter("numAnswers" + prevQuestion));
		Vector<String> questionAnswers = new Vector<String>(numAnswers);
		String answerString;
		for (int i = 0; i < numAnswers; i++) {
			String ans = request.getParameter("answer" + prevQuestion + "_" + i);
			if(ans != null && !ans.equals("")) questionAnswers.add(ans.toLowerCase());
			questionAnswers.add(ans);
		}
		answers.add(questionAnswers);
	}*/
	
	if (currentQuestion == quiz.getNumQuestions()) {
		RequestDispatcher dispatch = request.getRequestDispatcher("Results.jsp");
		dispatch.forward(request, response);	
		return;
	}
	
	System.out.println("CurrentQuestionIndex: " + currentQuestion);
	System.out.println("numQuestions : " + quiz.getNumQuestions());
	Integer totalanswer = 0;
	Question currQuestion;
	Vector<String> questionComponents;
	if (random)
			currQuestion = quiz.getRandomQuestionObject();
		else
			currQuestion = quiz.getNextQuestionObject();
	
 	out.print("Question " + (currentQuestion + 1) + ":<br/>");
  	questionComponents = currQuestion.getQuestion();
  	int numAnswers = 0;
 	if (currQuestion.getType().equals(QuizDatabase.QUESTION_RESPONSE)) {
	 	out.print("<br/>");
		out.print(questionComponents.get(0));
	  	out.print("<br/>");
	  	out.println("<input type=\"text\" name=\"answer" + currentQuestion + "_0\" />");
	  	numAnswers++;	
	  	totalScore++;
	 	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.FILL_IN_THE_BLANK)) {
	 	out.print("<br/>");
	  	for (int i = 0; i < questionComponents.size() - 1; i++) {
		  	out.println(questionComponents.get(i) + "<input type=\"text\" name=\"answer" + currentQuestion + "_" + i + "\" />");
		  	numAnswers++;
		  	totalScore++;
	  	}
	  	out.print(questionComponents.get(questionComponents.size() - 1));
	 	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.MULTIPLE_CHOICE)) {
	 	out.print("<br/>");
	  	out.print(questionComponents.get(0));
	  	out.print("<br/>");
	  	for (int i = 1; i < questionComponents.size(); i++) {
	  		char choice = (char)(i + 96);
		  	out.print("<input type=\"radio\" name=\"answer" + currentQuestion + "_0\" value=\"" + choice + "\">" + questionComponents.get(i) + "<br>");
	  	}
	  	numAnswers++;
	  	totalScore++;
	 	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.PICTURE_RESPONSE)) {
	 	out.print("<br/>");
	  	out.print("<img src = \"" + questionComponents.get(0) + "\">");
	  	out.print("<br/>");
	  	out.println("<input type=\"text\" name=\"answer" + currentQuestion + "_0\" />");
	  	numAnswers++;
	  	totalScore++;
	 	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.MULTIPLE_ANSWER)) {
	 	out.print("<br/>");
	 	out.print(questionComponents.get(0));
	 	out.print("<br/>");
	  	for (int i = 1; i < questionComponents.size(); i++) {
	  		char choice = (char)(i + 96);
		 	int newI = i - 1;
		  	out.print("<input type=\"checkbox\" name=\"answer" + currentQuestion + "_" + newI + "\" value=\"" + choice + "\">" + questionComponents.get(i) + "<br>");
		  	numAnswers ++;
	  	}	
	  	totalanswer = currQuestion.getNumAnswer();
	  	totalScore += totalanswer;
	  	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.MULTI_ORDERED_RESPONSE)) {
	 	out.print("<br/>");
	 	out.print(questionComponents.get(0));
	  	for (int i = 1; i < questionComponents.size(); i++) {
		 	int newI = i - 1;
		  	out.println("<input type=\"text\" name=\"answer" + currentQuestion + "_" + newI + "\" />");
		 	out.print(questionComponents.get(i));
		  	numAnswers++;
		  	totalScore++;
	  	}
	 	out.print("<br/>");
  	}
  	if (currQuestion.getType().equals(QuizDatabase.MULTI_UNORDERED_RESPONSE)) {
	 	out.print("<br/>");
	 	out.print(questionComponents.get(0));
	  	for (int i = 1; i < questionComponents.size(); i++) {
		 	int newI = i - 1;
		  	out.println("<input type=\"text\" name=\"answer" + currentQuestion + "_" + newI + "\" />");
		 	out.print(questionComponents.get(i));
		  	numAnswers++;
		  	totalScore++;
	  	}
	 	out.print("<br/>");
 	}
    out.println("<input name=\"numAnswers" + currentQuestion + "\" type=\"hidden\" value=\"" + numAnswers + "\"/>");
  	out.print("<p>");
  	
  	currentQuestion++;
 	out.print("<br/>");
 	out.print("<input type=\"hidden\" name=\"totalanswer\" value=" + totalanswer + ">");

	if (currentQuestion == quiz.getNumQuestions() - 1) 
	  	out.print("<input id=\"create-button\" class=\"button orange\" type=\"submit\" value = \"Next\"");
	else
	  	out.print("<input id=\"create-button\" class=\"button orange\" type=\"submit\" value = \"Submit\"");
	
  	session.setAttribute("quiz", quiz);
	session.setAttribute("answers", answers);
	session.setAttribute("currentQuestion", currentQuestion);
	session.setAttribute("totalScore", totalScore);
	%>
	
	</form>
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