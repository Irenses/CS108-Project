package quiz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import java.util.Collections;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Queue;
import java.util.Random;
import java.util.Vector;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

import database.DBConnection;

import database.*;
import quiz.*;


public class Quiz {
	
	private DBConnection con;
	
	//Key variables
	private Vector<Question> qs = new Vector<Question>();
	private Vector<Record> records;

	//ID variables
	private int id;
	private String name;
	private String description;
	private String creator;
	private String category;
	private boolean random;
	private boolean onepage;
	private boolean immediate;
	private boolean practice;
	
	private BlockingQueue<Question> practiceQ;	
	private BlockingQueue<Question> practiceQrandom;
	
	//Characteristics variables
	private int numquestion = 0;
	private int score = 0;
	private int totalScore = 0;
	private double avgtime;
	private double avgscore;
	private int totalplayed;
	
	private int maxscore = 0;

	private int curquestion = 0;
	private int currandom = 0;
	
	//Per game variables
	private Vector<Question> temp;
	private Vector<Question> randoms;	
	private Vector<Integer> scores;
	private String user;
	private long starttime;
	private long endtime;
	private double elapse;
	private double rating;
	
	/***********************************
	 * Note:
	 * 
	 * 1. To create a quiz;
	 * 2. To take a quiz in random vs. normal mode;
	 * 3. To take a quiz in onepage vs multi-page (immediate correction or not) mode;
	 * 4. To play a quiz in practice mode;
	 * 
	 * 1. To create a quiz:
	 * 	1.1 Ask the user for quiz name, description, 4 booleans;
	 * 	1.2 CHeck if the name is unique, if not, ask for a new one;
	 * 	1.3 Use's Sean's method to get an available quizID;
	 * 	1.4 Create a quiz object by calling Quiz constructor Quiz(name, desp, creator, id, random, onepage, immediate, practice);
	 * 	1.5 Create questions:
	 * 		1.5.1 Ask the creator for type;
	 * 		1.5.2 Ask the creator for question:
	 * 			  If q-r, pic-r, ask for the question string/url;
	 * 			  If multi-choice, multi-answer, ask for the question and nu of choices then choices;
	 *            If f-in-blank, ask for the string before blank and after;
	 *            If multi-response (ordered or unordered) ask for #of blanks n and the (n+1) string parts around those balnks;
	 *      1.5.3 Call on Quiz.convertToVector(String[] strs) to convert the parts into a "question string";
	 *      1.5.4 Ask the creator for answer:
	 *      	  If q-r, pic-r, f-in-blank, ask for the possible answer strings, call on Quiz.convertToVector(String[] strs) to convert the parts into a "answer string";
	 *            If multi-choice, multi-answer, ask for the correct choice, call on Quiz.convertToVector(Integer[] strs) to convert the parts into a "answer string";
	 * 		      If multi-response (ordered) ask for the possible answer strings for each blank, call on Quiz.convertToVector(String[] strs) to convert the parts into a "answer string";
	 * 			  If multi-response (unordered) ask for the possible answer strings for all possible answers, call on Quiz.convertToVector(String[] strs) to convert the parts into a "answer string";
	 * 		1.5.5 Call on Quiz.convertToVector(Vector<String>[] strs) to convert the parts into a "answer combo";
	 * 		1.5.6 Call addQuestion(id, type, question, answers); id is from 1.3, type from 1.5.1, question string from 1.5.3, answer combo from 1.5.5.
	 * 	1.6 Repeat 1.5 until all questions created for the quiz;
	 * 
	 * 2. To take a quiz in random vs. normal mode;
	 * 	2.1 Get the quizID from the quiz name by creating a QuizDatabase qdb = new Quizdatabase(); then call qdb.getID(name), where name is the name of the quiz;
	 * 	2.2 Call Quiz qz = qdb.ReconstructQuiz(quizID) to get the quiz back;
	 * 	2.3 Get the random boolean from the database by calling getRandom(quizID);
	 * 	2.4 ->&If random is yes, call qz.setUpRandomQuestion()&; 
	 * 	2.5 Get the # of questions by calling qz.getNumQuestion(), call qz.startQuiz(user);
	 * 	2.6 Use a for loop for(int 1 = 0; i < numQuestions; i++) and 
	 * 		2.6.1 Call qz.getNextQuestion() for normal and qz.getRandomQuestion() for random inside to get the Vector of strings from 1.5.3;
	 * 		2.6.2 According to type (mc, ma, f-in-b, other), print question out in a right form (string, picture, textbox within, radiobox/checkbox);
	 * 		2.6.3 Collect the answer, call on convertToVector(String/Integer[] inputs) to convert the user's answer into a "answer string";
	 * 	2.7 Other part see sections below;
	 * 
	 * 3. To take a quiz in onepage vs multi-page (immediate correction or not) mode;
	 * 	3.1 Follow 2.1-2.6.1;
	 * 	3.2.1 If one page: 
	 * 		  3.2.1.1 In 2.6.2, end the for loop and print out all the questions;
	 * 		  3.2.1.2 Then after collecting all answers, call convertToVector() twice to convert the strings/integers into Vector<Vector<String> >;
	 * 		  3.2.1.3 Call endOnepageQuiz(user, answers) and displayAnswers() methods to display answers; 
	 * 	      3.2.1.4 Call Sean's record methods to display own/highest/recent records.
	 * 	3.2.2 If multi-page:
	 * 		3.2.2.1 In 2.6.2, print out a question;
	 * 		3.2.2.2 If no immediate correction, collecting answers for the question, call convertToVector() to put it in a vector; The call it one more time to form a vector of vector;
	 * 		        Go on with the for loop, call vectorAnswers.add(Vector<String> from convertToVector()) after we get answer for each question;
	 * 				Back to 3.2.1.3 + 3.2.1.4.
	 * 		3.2.2.3 If immediate correction, collecting answers for the question, call convertToVector() to put it in a vector;
	 * 				Call int scored = qz.checkAnswer(answer);
	 * 				if (scored == answer.size()) print("Correct!");
	 * 				else print out correct answers returned by qz.getCurrectAnswer();
	 * 				Call endMultipageQuiz(user) and back to 3.2.1.4.
	 * 
	 * 4. To take a quiz in practice mode;
	 * 	4.1 Do 2.1, 2.2, get the practice boolean by calling getPractice(quizID);
	 * 	4.2 If true, ask player to select whether to take quiz in practice mode if not, back to 2 and 3, if yes:
	 * 	4.3 Call qz.setUpPractice();
	 * 	4.4 while(qz.getPracticeQuestion() != null), print out the Vector<String> returned by qz.getPracticeQuestion() following 2.6.2, collect answers and put into a Vector<String>;
	 * 	4.5 Print out the String returned by checkPractice(answer); (I used a queue here so it will end.)
	 * 	4.6 Bring the user back to previous page after done with practice mode.
	 * 
	 ***********************************/
	
	//Constructor
	
	/*Construct a quiz, need to specify
	 *all the quiz options.
	 */
	public Quiz(String name, String desp, String creator, int id, String category, boolean random, boolean onepage, boolean immediate, boolean practice){
		this.random = random;
		this.onepage = onepage;
		this.immediate = immediate;
		this.practice = practice;
		this.description = desp;
		this.name = name;
		this.creator = creator;
		this.id = id;
		this.category = category;
		scores = new Vector<Integer>();
		records = new Vector<Record>();
		avgtime = 0;
		avgscore = 0;
		totalplayed = 0;
		score = 0;
		rating = 0;
		
		curquestion = 0;
		currandom = 0;
		
		con = DBConnection.getSharedConnection();

	}
	
	/*Reconstruct a quiz from the database, need to specify
	 *all the quiz options.
	 */
	public Quiz(String name, String desp, String creator, int id, String category, double rating, boolean random, boolean onepage, boolean immediate, boolean practice,
			Vector<Question> qs, Vector<Record> records){
		this.random = random;
		this.onepage = onepage;
		this.immediate = immediate;
		this.practice = practice;
		this.description = desp;
		this.name = name;
		this.creator = creator;
		this.id = id;
		this.category = category;
		scores = new Vector<Integer>();
		this.qs = qs;
		this.records = records;
		this.rating = rating;
		totalplayed = records.size();
		avgtime = getAvgTime(records);
		avgscore = getAvgScore(records);
		numquestion = qs.size();
		score = 0;
		
		curquestion = 0;
		currandom = 0;
		
		con = DBConnection.getSharedConnection();

	}
	
	
	//Getters
	
//	public int getMaxScore() {
//		return maxscore; 
//	}
	
	public double getRating(){
		return rating;
	}
	
	// Get the total # of times played
	public int getTotal(){
		return records.size();
	}
	
	// Get the average score on the quiz
	public double getAvgScore(){
		return avgscore;
	}
	
	// Get the average score on the quiz
	public double getAvgScore(Vector<Record> records){
		double totalScore = 0;
		for(int i = 0; i < records.size(); i++){
			totalScore += records.get(i).getScore();
		}
		return totalScore/records.size();
	}
	
	// Get the average time spent on the quiz
	public double getAvgTime(){
		return avgtime;
	}
	
	public boolean getImmediate(){
		return immediate;
	}
	
	public void changeRecord(int score){
		records.get(records.size() - 1).setScore(score);
	}
	
	// Get the average time spent on the quiz
	public double getAvgTime(Vector<Record> records){
		double totalTime = 0;
		for(int i = 0; i < records.size(); i++){
			totalTime += records.get(i).getTime();
		}
		return totalTime/records.size();
	}
	
	// Get the # of questions in the current quiz.
	public int getNumQuestions(){
		return qs.size();
	}
	
	// Get the list of question objects in the current quiz.
	public Vector<Question> getQuestions(){
		return qs;
	}
	
	// Get the id of the current quiz.
	public int getID(){
		return id;
	}
	
	// Get name -- added by Kyle
	public String getName() {
		return name; 
	}
	
	// Get the creator of the current quiz.
	public String getCreator(){
		return creator;
	}
	
	// Get the description of the current quiz.
	public String getDescription(){
		return description;
	}

	// Get the next question string, 
	// can only be used # of question times in a for loop.
	public Vector<String> getNextQuestion(){
		if(curquestion > qs.size()) curquestion = 0;
		curquestion++;
		if (curquestion <= qs.size()) return qs.get(curquestion - 1).getQuestion();
		return null;
	}
	
	public Question getNextQuestionObject() {
		if(curquestion > qs.size()) curquestion = 0;
		curquestion++;
		if (curquestion <= qs.size()) return qs.get(curquestion - 1);
		return null;
	}
	
	// Set up a random list of questions, used in random mode
	public void setUpRandomQuestion(){
		temp = new Vector<Question>();
		randoms = new Vector<Question>();
		for (int i = 0; i < qs.size(); i++){
			temp.add(qs.get(i));
		}
		for (int j = 0; j < qs.size(); j++){
			Random rn = new Random();
			int ran = rn.nextInt(temp.size());
			randoms.add(temp.get(ran));
			temp.remove(ran);
		}
	}
	
	// Get the next question string in the random mode, 
	// can only be used # of question times in a for loop.
	public Vector<String> getRandomQuestion(){
		if(currandom > randoms.size()) currandom = 0;
		currandom++;
		if (currandom <= randoms.size()) return randoms.get(currandom - 1).getQuestion();
		return null;
	}
	
	public Question getRandomQuestionObject(){
		if(currandom > randoms.size()) currandom = 0;
		currandom++;
		if (currandom <= randoms.size()) return randoms.get(currandom - 1);
		return null;
	}
	
	// Get the answer string of the current question.
	public String getCurrentAnswer(){
		Question question;
		if(!random) question = qs.get(curquestion - 1);
		else question = randoms.get(currandom - 1);
		return question.getAnswer();
	}
	
	// Get the vector of records of the quiz.
	public Vector<Record> getRecords(){
		return records;
	}
	
	/*Get the current score on the quiz.
	 */
	public int getScore(){
		return score;
	}
	
	public boolean getOnepage(){
		return onepage;
	}
	
	public long getStart(){
		return starttime;
	}
	
	public void setStart(long start){
		starttime = start;
	}
	
	//Added by Kyle
	public boolean hasPractice() {
		return practice; 
	}
	
	/*Get the current score on the quiz.
	 */
	public void clearRecord(){
		records = new Vector<Record>();
	}
	
	// Put several strings into a vector
	public static Vector<String> convertToVector(String[] inputs){
		Vector<String> output = new Vector<String>();
		for(int i = 0; i < inputs.length; i++){
			output.add(inputs[i]);
		}
		return output;
	}
	
	// Put several integers into a vector
	public static Vector<String> convertToVector(Integer[] inputs){
		Vector<String> output = new Vector<String>();
		for(int i = 0; i < inputs.length; i++){
			output.add(inputs[i].toString());
		}
		return output;
	}
	
	// Put several vectors into a vector of vectors
	public static Vector<Vector<String> > convertToVector(Vector<String>[] inputs){
		Vector<Vector<String> > output = new Vector<Vector<String> >();
		for(int i = 0; i < inputs.length; i++){
			output.add(inputs[i]);
		}
		return output;
	}
	
	//Add questions

	public void addRating(String user, int id, int newrating){
		int totalplayed = records.size();
		double totalrating = totalplayed * totalplayed + newrating;
		rating = totalrating / (totalplayed + 1);
		QuizDatabase qdb = new QuizDatabase();
		qdb.addRating(id, user, newrating);
	}
			
	
	public void addQuestion(int id, String type, Vector<String> q, Vector<Vector<String> > a){
		Question ques = new Question(type, id, q, a);
		qs.add(ques);
		numquestion++;
		maxscore += a.size();
		
		QuizDatabase qdb = new QuizDatabase();
		int numQuestions = qdb.getNumQuestions(id);
		insertQuestionType(id, numQuestions, type, q, a);
		adjustNumQuestions(id, true);
	}
	
	// Play
	
	//Call this function when quiz begins
	public void startQuiz(String user){
		setUp(user);
		setStartTime(new Date());
	}
	
	//Call this function when all the answers collected at the end if onepage is on
	public void endOnepageQuiz(int id, String user, Vector<Vector<String> > useranswers){
		checkAnswers(useranswers);
		elapse = getElapse(new Date());
		playedOneMore(id, user, score, elapse);
	}
	
	//Call this function only when the quiz ends and onepage is off
	public void endMultipageQuiz(int id, String user){
		elapse = getElapse(new Date());
		playedOneMore(id, user, score, elapse);
	}
	
	public void endMultipageQuiz(int id, String user, int score){
		elapse = getElapse(new Date());
		playedOneMore(id, user, score, elapse);
	}
	
	//Check answers
	
	/*Check answers for all questions in the quiz at once.
	 * Returns the total scores got.
	 */
	public int checkAnswers(Vector<Vector<String> > useranswers){
		score = 0;
		
		for(int i = 0; i < qs.size(); i++){
			if(useranswers.size() > i){
				int scored = 0;
				if(!random){
					scored = qs.get(i).checkAnswer(useranswers.get(i));
				}else{
					scored = randoms.get(i).checkAnswer(useranswers.get(i));
				}
				score += scored;
				scores.add(scored);
			}
		}
		return score;
	}
	
	// Check the answer of an individual question.
	public int checkAnswer(Vector<String> useranswer){
		Question question;
		if(!random) question = qs.get(curquestion - 1);
		else question = randoms.get(currandom - 1);
		int scored = question.checkAnswer(useranswer);
		score += scored;
		return scored;
	}
	
	//Display all the answers 
	public String displayAnswers(){
		Vector<Question> questionlist;
		if(!random) questionlist = qs;
		else questionlist = randoms;
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < questionlist.size(); i++){
			sb.append("Question " + (i + 1) + ": \n");
			sb.append(questionlist.get(i).getAnswer());
			sb.append("\n");
		}
		return sb.toString();
	}
	
	//Practice mode
	
	public void setUpPractice(){
		if(!random){
			practiceQ = new ArrayBlockingQueue<Question>(qs.size() * 4);
			for(int i = 0; i < 3; i++){
				for(int j = 0; j < qs.size(); j++){
					try {
						practiceQ.put(qs.get(j));
					} catch (InterruptedException e) {
					}
				}
			}
		}else{
			practiceQ = new ArrayBlockingQueue<Question>(qs.size() * 4);
			for(int i = 0; i < 3; i++){
				setUpRandomQuestion();
				for(int j = 0; j < randoms.size(); j++){
					try {
						practiceQ.put(randoms.get(j));
					} catch (InterruptedException e) {
					}
				}
			}
		}
	}
	
	
	public Vector<String> getPracticeQuestion(){
		if(practiceQ.isEmpty()) return null;
		return practiceQ.peek().getQuestion();
	}
	
	public Question getPracticeQuestionObject() {
		if(practiceQ.isEmpty()) return null;
		return practiceQ.peek();
	}
	
	public String checkPractice(Vector<String> answer){
		try {
			Question q = practiceQ.take();
			if(q.checkAnswer(answer) == answer.size() && q.checkAnswer(answer) == q.getNumAnswer()){
				return "Correct!";
			}else{
				practiceQ.put(q);
				StringBuilder sb = new StringBuilder();
				sb.append("Sorry... it's not correct... \n The Correct answer is: \n");
				sb.append(q.getAnswer());
				return sb.toString();
			}
		} catch (InterruptedException e) {
		}
		return null;
	}
	
	//Helpers
	
	/*Initialize the quiz with the name of the user.
	 */
	public void setUp(String user){
		this.user = user;
		this.score = 0;
		curquestion = 0;
		currandom = 0;
	}
	
	/*Update the quiz after played one more time.
	 */
	public void playedOneMore(int id, String user, int scoregot, double timespent){
		avgtime = (avgtime * totalplayed + timespent) / (totalplayed + 1);
		avgscore = (avgscore * totalplayed + scoregot) / (totalplayed + 1);
		totalplayed++;
		Record rc = new Record(user, scoregot, timespent, starttime);
		records.add(rc);
		
		QuizDatabase qdb = new QuizDatabase();
		qdb.putRecord(id, rc);
	}
	
	/*Called by quiz player to set the start time.
	 */
	public void setStartTime(Date dt){
		starttime = dt.getTime();
	}

	/*Called by quiz player to get the total time elapsed after quiz is done.
	 */
	public double getElapse(Date dt){
		endtime = dt.getTime();
		long pass = endtime - starttime;
		elapse = (double) pass / 1000;
		return elapse; 
	}
	
	
	/*Check answer for an individual question, adding score got.
	 * Return the score got on this question.

	public int checkAnswer(int index, String useranswer){
		if(index >= 0 && index < qs.size()){
			Question curq = qs.get(index);
			int scored = curq.checkAnswer(useranswer);
			if(scored > 0){ 
				score++;
				return 1;
			}
		}
		return 0;
	}
	
	public int checkAnswer(int index, Vector<String> useranswer){
		if(index >= 0 && index < qs.size()){
			Question curq = qs.get(index);
			int scored = curq.checkAnswer(useranswer);
			if(scored > 0){
				score += scored;
				return scored;
			}
		}
		return 0;
	}
	*/
	
	//Play
	

	
	//Results: Records
	
	public Vector<Record> getRecent(int numRecent){
		Vector<Record> recent = new Vector<Record>();
		for (int i = records.size() - 1; i >= records.size() - numRecent; i--){
			if (i >= 0) recent.add(records.get(i));
			else break;
		}
		return recent;
	}
	
	public Vector<Record> getSelf(String User){
		Vector<Record> self = new Vector<Record>();
		for (int i = records.size() - 1; i >= 0; i--){
			if (records.get(i).getUser().equals(User)) self.add(records.get(i));
		}
		return self;
	}
	
	public Vector<Record> getHighest(int numHighest){
		Vector<Record> highest = new Vector<Record>();
		Collections.sort(records);
		for (int i = 0; i < numHighest; i++){
			if (i < records.size()) highest.add(records.get(i));
			else break;
		}
		return highest;
	}
	
	public Vector<Record> getRecentHighest(int numHighest, long within){
		Vector<Record> highest = new Vector<Record>();
		Collections.sort(records);
		int num = 0;
		Date dt = new Date();
		long benchmark = dt.getTime() - within;
		for (int i = 0; i < records.size(); i++){
			if (num >= numHighest) return highest;
			if (records.get(i).getStart() >= benchmark){
				highest.add(records.get(i));
				num++;
			}
		}
		return highest;
	}
	
	
	//Database helpers
	private void insertQuestionType(int quizID, int questionID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		for (int x = 0; x < components.size(); x++) {
			con.updateDB("INSERT INTO " + type + " VALUES ( " + quizID + ", " + questionID + ", " + x + ", \"" + components.get(x) + "\")");
		}
		for (int x = 0; x < answers.size(); x++) {
			for (int y = 0; y < answers.get(x).size(); y++) {
				con.updateDB("INSERT INTO answers VALUES ( " + quizID + ", " + questionID + ", " + x + ", \"" + answers.get(x).get(y) + "\")");
			}
		}
		con.updateDB("INSERT INTO quizMap VALUES ( " + quizID + ", " + questionID + ", \"" + type + "\")");
	}
	
	private void deleteQuestionType(int quizID, int questionID, String type) {
		con.updateDB("DELETE FROM " + type + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		con.updateDB("DELETE FROM answers WHERE quizID = " + quizID + " AND questionID = " + questionID);
		con.updateDB("DELETE FROM quizMap WHERE quizID = " + quizID + " AND questionID = " + questionID);
	}

	private void adjustNumQuestions(int quizID, boolean increment) {
		ResultSet rs = con.queryDB("SELECT * FROM numQuestions WHERE quizID = " + quizID);
		int currNum, newNum;
		try {
			if (!rs.next())
				throw new RuntimeException("Quiz ID wrong in Database::incrementNumQuestions");
			currNum = rs.getInt("numQuestions");
			if (increment)
				newNum = currNum + 1;
			else
				newNum = currNum - 1;
			con.updateDB("UPDATE numQuestions SET numQuestions = " + newNum + " WHERE quizID = " + quizID + " AND numQuestions = " + currNum);
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::incrementNumQuestions");
		}	
	}
}
