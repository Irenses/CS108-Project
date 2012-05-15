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
    QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
    UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
    User user = (User)session.getAttribute("user");
    int quizID = Integer.parseInt(request.getParameter("id"));
	session.setAttribute("quizID", quizID);
    Quiz quiz = quizDB.ReconstructQuiz(quizID);
    String username = user.getUsername();  
    out.print("<title>Playing: " + quiz.getName() + "</title>");
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
	<form action="Results.jsp" method="POST">
  	<%
  	    Vector<Question> questions = quiz.getQuestions();
  	    Question currQuestion;
		Vector<String> questionComponents;
		
		int totalScore = 0;
 	    for (int x = 0; x < quiz.getNumQuestions(); x++) {
  	  		currQuestion = questions.get(x);
    	 	out.print("Question " + (x + 1) + ":<br/>");
    	  	questionComponents = currQuestion.getQuestion();
    	  	int numAnswers = 0;
		  	out.print("<br/>");
		  	out.print("<br/>");

    	 	out.print("Question " + (x + 1) + ":<br/>");
    	  	questionComponents = currQuestion.getQuestion();
    	  	numAnswers = 0;
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
				  	numAnswers++;
    		  	}
			  	totalScore++;
    	  	}
 	    }
	  out.println("<input name=\"username\" type=\"hidden\" value=\"" + username + "\"/>");
	  out.println("<input name=\"quizID\" type=\"hidden\" value=\"" + quizID + "\"/>");
	  long startTime = System.currentTimeMillis();
	  out.println("<input name=\"startTime\" type=\"hidden\" value=\"" + startTime + "\"/>");
      %>
	<input id="create-button" class="button orange" type="submit" value="Submit!"/>
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