<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="database.*" %>
   	<%@ page import="quiz.*" %>
   	<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <%
	String username = (String)session.getAttribute("username");
    out.print("<title>");
    out.print(username);
    out.print("'s Profile</title>");
    %>
</head>
<body>
<%
 QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
 UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
 int quizID = Integer.parseInt(request.getParameter("quizID"));
 Quiz quiz = quizDB.ReconstructQuiz(quizID);
 boolean random = quizDB.getRandom(quizID);
 boolean onepage = quizDB.getOnepage(quizID);
 boolean practice = quizDB.getPractice(quizID);
 
 if ((practice) && (request.getParameter("practice") != null)) {
	quiz.setUpPractice();
	
	session.setAttribute("quiz", quiz);
	RequestDispatcher dispatch = request.getRequestDispatcher("practiceMode.jsp");
	dispatch.forward(request, response);
 }
 
 if (random) 
 	quiz.setUpRandomQuestion();
 quiz.startQuiz(username);
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
	  	  		
	    	 	out.print("Question " + (x + 1) + ":<br/>");
	    	  	questionComponents = currQuestion.getQuestion();
	    	  	int numAnswers = 0;
	    	 	if (currQuestion.getType().equals(QuizDatabase.QUESTION_RESPONSE)) {
	    			out.print(questionComponents.get(0));
	    		  	out.print("<br/>");
				  	out.println("<input type=\"text\" name=\"answer" + x + "_0\" />");
				  	numAnswers++;	
				  	totalScore++;
	    	  	}
	    	  	if (currQuestion.getType().equals(QuizDatabase.FILL_IN_THE_BLANK)) {
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

	    	  	}
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
 		%>
	<input type="submit" value="Submit"/>
	</form>
</body>
</html>