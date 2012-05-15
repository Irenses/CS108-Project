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
    
    out.print("<title>Your Time!!</title>");
    String username = "";
    if (session.getAttribute("user") != null) {
			User yourself = (User) session.getAttribute("user");
			username = yourself.getUsername();
		}
    
    else {
    	RequestDispatcher dispatch = request.getRequestDispatcher("login.jsp");
    	dispatch.forward(request, response);
    	return;
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
<%%>
<p>
<br>
<%
 QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
 UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
 int quizID = Integer.parseInt(request.getParameter("id"));
 Quiz quiz = quizDB.ReconstructQuiz(quizID);
 quiz.startQuiz(username);
 Long start = quiz.getStart();

 boolean random = quizDB.getRandom(quizID);
 boolean onepage = quizDB.getOnepage(quizID);
 boolean practice = quizDB.getPractice(quizID);
	session.setAttribute("quizID", quizID);
	session.setAttribute("start", start);

 if ((practice) && (request.getParameter("p").equals("1"))) {
	quiz.setUpPractice();
	
	session.setAttribute("quiz", quiz);
	RequestDispatcher dispatch = request.getRequestDispatcher("practiceMode.jsp");
	dispatch.forward(request, response);
	return;
 }
 
 if (random) 
 	quiz.setUpRandomQuestion();
 %>

<h1> <%out.print(quiz.getName()); %></h1>
<p>

	<form action="Results.jsp" method="POST">
  		<%
  		
  	    Question currQuestion;
		Vector<String> questionComponents;
		int totalScore = 0;
		
		if (onepage) {
	 		for (int x = 0; x < quiz.getNumQuestions(); x++) {
	  	  		if (random)
	  	  			currQuestion = quiz.getRandomQuestionObject();
	  	  		else
	  	  			currQuestion = quiz.getNextQuestionObject();
    		  	out.print("<br/>");
    		  	out.print("<br/>");

	    	 	out.print("<span>Question " + (x + 1) + ":</span><br/>");
	    	  	questionComponents = currQuestion.getQuestion();
	    	  	int numAnswers = 0;
	    	 	if (currQuestion.getType().equals(QuizDatabase.QUESTION_RESPONSE)) {
	    			out.print(questionComponents.get(0));
	    		  	out.print("<br/>");
				  	out.println("<input type=\"text\" name=\"answer" + x + "_0\" />");
				  	numAnswers++;	
				  	totalScore++;
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.FILL_IN_THE_BLANK) || currQuestion.getType().equals("mr") || currQuestion.getType().equals("mu")) {
	    		  	for (int i = 0; i < questionComponents.size() - 1; i++) {
	    			 	out.print(questionComponents.get(i));
	    			  	out.println("<input type=\"text\" name=\"answer" + x + "_" + i + "\" />");
	    			  	numAnswers++;
	    			  	totalScore++;
	    		  	}
				  	out.print(questionComponents.get(questionComponents.size() - 1));
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.MULTIPLE_CHOICE)) {
	    		  	out.print(questionComponents.get(0));
	    		  	out.print("<br/>");
	    		  	for (int i = 1; i < questionComponents.size(); i++) {
	    		  		char choice = (char)(i + 96);
	        		  	out.print("<input type=\"radio\" name=\"answer" + x + "_0\" value=\"" + choice + "\">" + questionComponents.get(i) + "<br>");
	    		  	}
				  	numAnswers++;
				  	totalScore++;
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.PICTURE_RESPONSE)) {
	    		  	out.print("<img src = \"" + questionComponents.get(0) + "\">");
	    		  	out.print("<br/>");
				  	out.println("<input type=\"text\" name=\"answer" + x + "_0\" />");
				  	numAnswers++;
				  	totalScore++;
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.MULTIPLE_ANSWER)) {
    			 	out.print(questionComponents.get(0));
    			 	out.print("<br/>");
	    		  	for (int i = 1; i < questionComponents.size(); i++) {
	    		  		char choice = (char)(i + 96);
	    			 	int newI = i - 1;
	        		  	out.print("<input type=\"checkbox\" name=\"answer" + x + "_" + newI + "\" value=\"" + choice + "\">" + questionComponents.get(i) + "<br>");
		    		  	numAnswers ++;
	    		  	}
	    		  	totalScore += currQuestion.getNumAnswer();
	    		  	}
	    	  	/*****
	    	  	if (currQuestion.getType().equals(QuizDatabase.MULTI_ORDERED_RESPONSE)) {
    			 	out.print(questionComponents.get(0));
    			 	out.print("<br/>");
	    		  	for (int i = 1; i < questionComponents.size() - 1; i++) {
	    			 	out.print(questionComponents.get(i));
	    			  	out.println("<input type=\"text\" name=\"answer" + x + "_" + i + "\" />");
	    			 	out.print("<br/>");
	    			  	numAnswers++;
	    			  	totalScore++;
	    		  	}
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.MULTI_UNORDERED_RESPONSE)) {
    			 	out.print(questionComponents.get(0));
    			 	out.print("<br/>");
	    		  	for (int i = 1; i < questionComponents.size(); i++) {
	    			 	out.print(questionComponents.get(i));
	    			  	out.println("<input type=\"text\" name=\"answer" + x + "_" + i + "\" />");
	    			 	out.print("<br/>");
	    			  	numAnswers++;
	    			  	totalScore++;
	    		  	}
	    	  	}
	    	  	*/
			    out.println("<input name=\"numAnswers" + x + "\" type=\"hidden\" value=\"" + numAnswers + "\"/>");
			  	out.print("<p>");
			}
 		  	long startTime = System.currentTimeMillis();
 		  	session.setAttribute("quiz", quiz);
 		  	session.setAttribute("totalScore", totalScore);
 		  	session.setAttribute("quizID", quizID);
 		  	session.setAttribute("startTime", startTime);
	  	}	
	  	else {
		  	session.setAttribute("quiz", quiz);
		  	Vector<Vector<String>> answers = new Vector<Vector<String>>();
			int currentQuestion = 0;
 		  	long startTime = System.currentTimeMillis();
			session.setAttribute("answers", answers);
			session.setAttribute("currentQuestion", currentQuestion);
			session.setAttribute("startTime", startTime);
			session.setAttribute("totalScore", totalScore);
 		  	session.setAttribute("quizID", quizID);
			RequestDispatcher dispatch = request.getRequestDispatcher("multiPage.jsp");
			dispatch.forward(request, response);
		}
		session.setAttribute("curquiz", quiz);
 		%>
 		<br>
 		<br>
	<input id="create-button" class="button orange" type="submit" value="Submit"/>
	
	<br />
	<br />
	
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