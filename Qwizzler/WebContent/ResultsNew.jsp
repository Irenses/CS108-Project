<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="database.*" %>
   	<%@ page import="quiz.*" %>
   	<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%String username = (String)session.getAttribute("username");%>
Results for <%out.print(username);%>:
<p>
<%
	long stopTime = System.currentTimeMillis();
	ServletContext context = getServletContext();
	QuizDatabase quizDB = (QuizDatabase)context.getAttribute("quizDBC");
	int quizID = (Integer)session.getAttribute("quizID"); 
	Quiz quiz = (Quiz)session.getAttribute("quiz");
	Vector<Vector<String>> userAnswers = new Vector<Vector<String>>();

	if (quizDB.getOnepage(quizID)) {
		int numAnswers = 0;
		Vector<String> questionAnswers;
		//int score = 0, totalScore = 0;
		int numQuestions = quizDB.getNumQuestions(quizID);
		for (int x = 0; x < numQuestions; x++) {
			numAnswers = Integer.parseInt(request.getParameter("numAnswers" + x));
			questionAnswers = new Vector<String>(numAnswers);
			for (int i = 0; i < numAnswers; i++) {
				questionAnswers.add(request.getParameter("answer" + x + "_" + i).toLowerCase());
			}
			userAnswers.add(questionAnswers);
			
		}
		quiz.endOnepageQuiz(username, userAnswers);
	}
	else {
		if (quizDB.getImmediate(quizID))
			quiz.endMultipageQuiz(username);
		else {
			userAnswers = (Vector<Vector<String>>)session.getAttribute("answers");
			System.out.println(userAnswers);
			quiz.endOnepageQuiz(username, userAnswers);
		}
	}
	
	out.print(quiz.displayAnswers());
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
%>
Score: <%out.print(record.getScore());%> out of <%out.print((Integer)session.getAttribute("totalScore"));%>
<p>
Time: <%out.print(QuizDatabase.getTimeFromDouble(record.getTime()));%>
<p>
<p>
Total number of times taken: <%out.print(quizDB.getRecords(quizID).size()); %>
<p>
Average Score: <%out.print(quizDB.getAverageScore(quizID));%>
<p> 
Average Time Spent: <%out.print(quizDB.getAverageTimeSpent(quizID));%>
<p>
Top 5 Scores of all time: <br/>
<%
	Vector<Record> highScores = quizDB.getTopRecords(quizID, 5);
	for (int x = 0; x < highScores.size(); x++) {
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
Recent high scores (1 day): <br/>
<%
	highScores = quizDB.getBestRecentRecords(0, QuizDatabase.RECENT_BY_DAY);
	for (int x = 0; x < highScores.size(); x++) {
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
Your high scores (by Score)<br/>
<%
	highScores = quizDB.getUserRecords(0, username, QuizDatabase.ORDER_BY_SCORE, false);
	for (int x = 0; x < highScores.size(); x++) {
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
</body>
</html>