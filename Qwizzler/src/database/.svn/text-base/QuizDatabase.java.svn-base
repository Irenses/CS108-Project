package database;

import quiz.*;
import user.QuizAct;

import java.sql.*;
import java.util.Collections;
import java.util.HashMap;
import java.util.Vector;

/*
 * Notes:
 * The way the QuizDatabase is structured is every question is stored with an
 * associated quizID and questionID (both 0 based).  Both are required in order to 
 * access anything.
 * Use DatabaseTest.sql to construct a test database.
 */

public class QuizDatabase {
	
	private DBConnection con;
	
	//These represent the 4 question types currently supported.  We can add more if necessary
	public static String QUESTION_RESPONSE = "qr";
	public static String FILL_IN_THE_BLANK = "fitb";
	public static String MULTIPLE_CHOICE = "mc";
	public static String PICTURE_RESPONSE = "pr";
	
	public static String MULTIPLE_ANSWER = "ma";
	public static String MULTI_UNORDERED_RESPONSE = "mu";
	public static String MULTI_ORDERED_RESPONSE = "mr";

	//Other tables
	public static String NUM_QUESTIONS = "numQuestions";
	public static String ANSWERS = "answers";
	public static String QUIZ_MAP = "quizMap";
	public static String QUIZ_INFO = "quizInfo";
	public static String QUIZ_SCORES = "quizScores";
	public static String QUIZ_CATEGORIES = "quizCategories";
	public static String QUIZ_RATINGS = "quizRatings";
	public static String QUIZ_POPULARITY = "quizPopularity";
	
	//Use these variables when requesting records for a specific user
	public static String ORDER_BY_DATE = "timeStamp";
	public static String ORDER_BY_SCORE = "score";
	public static String ORDER_BY_TIME = "totalTime";

	//Use this when asking for recent quizes in a day
	public static long RECENT_BY_DAY = 86400000;

	public static String CATEGORY_GEOGRAPHY = "Geo";
	public static String CATEGORY_ENTERTAINMENT = "Ent";
	public static String CATEGORY_HISTORY = "His";
	public static String CATEGORY_ARTS = "Art";
	public static String CATEGORY_SCIENCE = "Sci";
	public static String CATEGORY_SPORTS = "Spo";
	
	public QuizDatabase() {
		con = DBConnection.getSharedConnection();
	}
	
	/**
	 * Adds the quiz information to the database.
	 * The timestamp is set to the time when this method is called.
	 */
	public Quiz addQuiz(int quizID, String name, String description, String creator, String category, boolean random, boolean onePage, boolean immediate, boolean practice) {
		con.updateDB("INSERT INTO " + QUIZ_INFO + " VALUES ( " + quizID + ", \"" + name + "\", \"" + description + "\", \"" + creator + "\", " + random + ", " + onePage + ", " + immediate + ", " + practice + ", NOW())");
		con.updateDB("INSERT INTO " + QUIZ_CATEGORIES + " VALUES ( " + quizID + ", \"" + category + "\")");
		Quiz qz= new Quiz(name, description, creator, quizID, category, random, onePage, immediate, practice);
		con.updateDB("INSERT INTO " + NUM_QUESTIONS + " VALUES ( " + quizID + ", 0)");
		con.updateDB("INSERT INTO " + QUIZ_POPULARITY + " VALUES ( " + quizID + ", 0)");
		return qz;
	}

	
	//Add by James. Correct?
	
	/**
	 * Reconstruct a quiz from scratch using only the ID.
	 */
	public Quiz ReconstructQuiz(int quizID){
		QuizDatabase qdb = new QuizDatabase();
		int numq = qdb.getNumQuestions(quizID);
		Vector<Record> records = qdb.getRecords(quizID);
		Vector<Question> qs = ReconstructQuestions(quizID, numq);
		boolean rand = qdb.getRandom(quizID);
		boolean op = qdb.getOnepage(quizID);
		boolean immed = qdb.getImmediate(quizID);
		boolean prtc = qdb.getPractice(quizID);
		String desp = qdb.getDescription(quizID);
		String catr = qdb.getCreator(quizID);
		String name = qdb.getName(quizID);
		String category = qdb.getCategory(quizID);
		double rating = qdb.getAverageRating(quizID);
		
		Quiz qz = new Quiz(name, desp, catr, quizID, category, rating, rand, op, immed, prtc, qs, records);
		return qz;
	}
	
	/**
	 * Returns x number of names of recently created quizzes in String.
	 */
	public Vector<QuizName> getRecentQuiz(int num) {
		Vector<QuizName> recentIds = new Vector<QuizName>();
		QuizName quizname;
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " ORDER BY timeCreated DESC");
		int count = 0;
		try {
			while(rs.next()){
				if (count == num)
					return recentIds;
				quizname = new QuizName(rs.getInt("quizID"), rs.getString("name"), rs.getString("description"));
				recentIds.add(quizname);
				count++;
			}
			return recentIds;
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRecentQuiz");
		} 
	}
	
	/**
	 * Returns the most popular quizzes. 
	 */
	public Vector<QuizName> getPopularQuiz(int num) {

		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_POPULARITY + " INNER JOIN " + QUIZ_INFO + " USING(quizID) ORDER BY numPlays DESC");
		Vector<QuizName> allID = new Vector<QuizName>();
		int count = 0;
		try {
			QuizName quizname;
			while(rs.next()) {
				if (count == num)
					return allID;
				quizname = new QuizName(rs.getInt("quizID"), rs.getString("name"), rs.getString("description"));
				allID.add(quizname);
				count++;
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getPopularQuiz");
		}
		
		return allID;
	}
	
	/**
	 * Returns x number of names of most popular quizzes in String.
	 */
	public Vector<QuizName> getPopularQuiz(int num, String category) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_POPULARITY + " INNER JOIN " + QUIZ_INFO + " USING(quizID) INNER JOIN " + QUIZ_CATEGORIES + " USING(quizID) ORDER BY numPlays DESC");
		Vector<QuizName> allID = new Vector<QuizName>();
		int count = 0;
		try {
			QuizName quizname;
			while(rs.next()) {
				if (count == num)
					return allID;
				if (rs.getString("category").equals(category)) {
					quizname = new QuizName(rs.getInt("quizID"), rs.getString("name"), rs.getString("description"));
					allID.add(quizname);
					count++;
				}
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getPopularQuiz");
		}
		return allID;
	}
	
	/**
	 * Returns x number of names of most popular quizzes in String.
	 */
	public Vector<QuizName> getHighRatingQuiz(int num) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_RATINGS + " INNER JOIN " + QUIZ_INFO + " USING(quizID) ORDER BY rating DESC");
		Vector<QuizName> allID = new Vector<QuizName>();
		int count = 0;
		try {
			QuizName quizname;
			while(rs.next()) {
				if (count == num)
					return allID;
				quizname = new QuizName(rs.getInt("quizID"), rs.getString("name"), rs.getString("description"));
				allID.add(quizname);
				count++;
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getPopularQuiz");
		}
		return allID;
	}
	 
	public Vector<QuizName> getQuizzesFromCategory(String category) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_CATEGORIES + " q INNER JOIN " + QUIZ_INFO + " USING(quizID) WHERE category = \"" + category + "\"");
		Vector<QuizName> quizzes = new Vector<QuizName>();
		try {
			while(rs.next()) {
				quizzes.add(new QuizName(rs.getInt("quizID"), rs.getString("name"), rs.getString("description")));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getPopularQuiz");
		}
		return quizzes;
	}
	/**
	 * Returns the id of the quiz given the name of the quiz
	 */
	public int getID(String name){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE name = " + name);
		try {
			while (rs.next()) {
				return rs.getInt("quizID");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getID");
		}
		return -1;
	}
	
	
	/**
	 * Returns the id of the quiz given the name of the quiz
	 */
	public Vector<Integer> getIDs(String creator){
		Vector<Integer> id = new Vector<Integer>();
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE creator = \"" + creator + "\"");
		try {
			while (rs.next()) {
				id.add(rs.getInt("quizID"));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getIDs");
		}
		return id;
	}
	
	/**
	 * Returns the name of the quiz
	 */
	public String getName(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getString("name");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getName");
		}
		return null;
	}
	
	/**
	 * Returns the creator of the quiz
	 */
	public String getCreator(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getString("creator");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getCreator");
		}
		return null;
	}
	
	
	/**
	 * Returns the description of the quiz
	 */
	public String getDescription(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getString("description");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getDescription");
		}
		return null;
	}
	
	/**
	 * Returns whether the quiz is random order
	 */
	public boolean getRandom(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getBoolean("random");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRandom");
		}
		return false;
	}
	
	/**
	 * Returns whether the quiz is one page
	 */
	public boolean getOnepage(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getBoolean("onePage");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getOnepage");
		}
		return false;
	}
	
	/**
	 * Returns whether the quiz immediately corrects
	 */
	public boolean getImmediate(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getBoolean("immediateFeedback");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getImmediate");
		}
		return false;
	}
	
	/**
	 * Returns whether the quiz has practice
	 */
	public boolean getPractice(int quizID){
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo WHERE quizID = " + quizID);
		try {
			while (rs.next()) {
				return rs.getBoolean("practice");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getPractice");
		}
		return false;
	}
	
	
	//Ending the addition by James
	
	/**
	 * When creating a new quiz, this method will check whether the name is valid.
	 */
	public boolean checkName(String name) {
		ResultSet rs = con.queryDB("SELECT * FROM quizInfo ORDER BY quizID");
		try {
			while (rs.next()) {
				if (rs.getString("name").equals(name))
					return false;
			}
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::checkName");
		}
		return true;
	}
	
	/**
	 * When creating a new quiz, this method will return an available quizID to assign
	 * to that specific quiz.
	 */
	public int getAvailableQuizID() {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " ORDER BY quizID");
		int quizID = 0;
		try {
			while (rs.next()) {
				if (rs.getInt("quizID") != quizID)
					return quizID;
				quizID++;
			}
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getAvailableQuizID");
		}
		return quizID;
	}
	
	public boolean quizExists(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE quizID = " + quizID);
		try {
			if (rs.next())
				return true;
			else
				return false;
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::quizExists");
		}
	}
	
	/**
	 * Returns the number of quizes currently in the database.
	 */
	public int getNumQuizes() {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO);
		int numQuizes = 0;
		try {
			while (rs.next()) {
				numQuizes++;
			}
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getNumQuizes");
		}
		return numQuizes;
	}
	
	public String getCategory(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_CATEGORIES + " WHERE quizID = " + quizID);
		try {
			if (!rs.next())
				return null;
			return rs.getString("category");
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getCategory");
		}
	}
	
	public void addCategory(int quizID, String category) {
		con.updateDB("INSERT INTO " + QUIZ_CATEGORIES + " VALUES ( " + quizID + ", \"" + category + "\")");
	}
	
	public double getAvgRating(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_RATINGS + " WHERE quizID = " + quizID);
		double total = 0;
		int numrating = 0;
		try {
			while (rs.next()){
				total += rs.getInt("rating");
				numrating++;
			}
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRating");
		}
		if(numrating == 0) return -1;
		return (total / numrating);
	}
	
	public int getRating(int quizID, String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_RATINGS + " WHERE quizID = " + quizID + " AND username = \"" + username + "\"");
		try {
			if (!rs.next())
				return -1;
			return rs.getInt("rating");
		}
		catch(SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRating");
		}
	}
	
	public void addRating(int quizID, String username, int rating) {
		con.updateDB("INSERT INTO " + QUIZ_RATINGS + " VALUES ( " + quizID + ", \"" + username + "\", " + rating + ")");
	}
	
	public void addRating(Rating rating) {
		con.updateDB("INSERT INTO " + QUIZ_RATINGS + " VALUES ( " + rating.getQuizID() + ", \"" + rating.getUsername() + "\", " + rating.getRating() + ")");
	}
	
	public double getAverageRating(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_RATINGS + " WHERE quizID = " + quizID);
		double average = 0;
		double count = 0;
		try {
			while (rs.next()) {
				average = average + rs.getInt("rating");
				count++;
			}
			average = average/count;
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getAverageRating");
		}
		return average;
	}
	
	/**
	 * Deletes the quiz and all its associated data.
	 */
	public void deleteQuiz(int quizID) {
		
		for (int x = 0; x < getNumQuestions(quizID); x++) {
			deleteQuestion(quizID, x);
		}
		
		con.updateDB("DELETE FROM " + QUIZ_MAP + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + QUIZ_INFO + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + NUM_QUESTIONS + " WHERE quizID = " + quizID);

		con.updateDB("DELETE FROM " + QUIZ_CATEGORIES + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + QUIZ_RATINGS + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + QUIZ_POPULARITY + " WHERE quizID = " + quizID);
	}
	
	public void clearHistory(int quizID) {
		con.updateDB("DELETE FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID);
		con.updateDB("DELETE FROM " + QUIZ_RATINGS + " WHERE quizID = " + quizID);
		con.updateDB("UPDATE " + QUIZ_POPULARITY + " SET numPlays = 0 WHERE quizID = " + quizID);
	}
	/**
	 * Pretty straightforward.  Gets you the number of questions
	 * associated with the particular quiz.
	 */
	public int getNumQuestions(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + NUM_QUESTIONS + " WHERE quizID = " + quizID);
		int num;
		try {
			if (!rs.next())
				throw new RuntimeException("unknown id in Database::getNumQuestions");
			num = rs.getInt("numQuestions");
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getNumQuestions");
		}
		return num;
	}
	
	/**
	 * Returns one of the four question types (see static variables) for the associated
	 * question
	 */
	public String getQuestionType(int quizID, int questionID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_MAP + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		String type = null;
		try {
			if (!rs.next())
				throw new RuntimeException("unknown id in Database::getQuestionType");
			type = rs.getString("type");
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getQuestionType");
		}
		return type;
	}
	
	/**
	 * Returns a Vector<String> representing the components that make up a question. These are as follows:
	 * Question Response: Returns only one string (index 0) representing the question (e.g. "Who is the 
	 * 	president?")
	 * Fill in the Blank: Returns two strings, one representing the first part, the other representing 
	 * 	the second part (e.g. the first string will be "One of President Lincoln’s most famous speeches 
	 * 	was the" and the second will be "address".  If there is no second part, the vector will only have
	 * 	one string representing the first part)
	 * Multiple Choice: The String at 0 is the question, everything following that are the choices
	 * Picture Response: The String at 0 is the url.
	 */
	public Vector<String> getQuestion(int quizID, int questionID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_MAP + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		String type;
		try {
			if (!rs.next())
				throw new RuntimeException("unknown id in question component constructor");
			type = rs.getString("type");
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getQuestion");
		}
		return getQuestionFromDatabase(type, quizID, questionID);
	}
	
	/**
	 * Returns a Vector<Vector<String>> representing the answers to the associated question.  The
	 * reason it's a double vector is to allow for multiple answer questions.  All Strings in the 
	 * vector located at their respective index will represent all possible answers for that answer
	 * (For example, suppose we have a multi-answer question "Name the 50 states".  The vector at
	 * index 0 could contain {"California", "CA"}, meaning that these answers all represent the
	 * same answer.  Other vectors represent different answers).
	 */
	public Vector<Vector<String>> getAnswers(int quizID, int questionID) {
		Vector<Vector<String>> answers = new Vector<Vector<String>>();
		ResultSet rs = con.queryDB("SELECT * FROM " + ANSWERS + " WHERE quizID = " + quizID + " AND questionID = " + questionID + " ORDER BY answerID DESC");
		int answerID;
		try {
			rs.next();
			answerID = rs.getInt("answerID");
			for (int x = 0; x <= answerID; x++) {
				rs = con.queryDB("SELECT * FROM " + ANSWERS + " WHERE quizID = " + quizID + " AND questionID = " + questionID + " AND answerID = " + x);
				Vector<String> answerVec = new Vector<String>();
				while (rs.next()) {
					answerVec.add(rs.getString("answer"));
				}
				answers.add(answerVec);
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getAnswers");
		}	
		return answers;
	}
	
	/**
	 * Add a question at the end of the quiz.  Needs the Vector<String> of components and the 
	 * Vector<Vector<String>> of answers.
	 */
	public void addQuestion(int quizID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		int numQuestions = getNumQuestions(quizID);
		insertQuestionType(quizID, numQuestions, type, components, answers);
		adjustNumQuestions(quizID, true);
	}
	
	/**
	 * Insert a question into the specified questionID index.  Similar to add, it requires the
	 * question components and answers
	 */
	public void insertQuestion(int quizID, int questionID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		incrementQuestions(quizID, questionID);
		insertQuestionType(quizID, questionID, type, components, answers);
		adjustNumQuestions(quizID, true);
	}
	
	/**
	 * Deletes the question in the specified quiz.
	 */
	public void deleteQuestion(int quizID, int questionID) {
		String type = getQuestionType(quizID, questionID);
		deleteQuestionType(quizID, questionID, type);
		decrementQuestions(quizID, questionID);
		adjustNumQuestions(quizID, false);
	}
	
	public static String getTimeFromDouble(double time) {
		String newTime = "";
		int minutes = ((int)time)/60;
		int seconds = (int)(time);
		if (minutes == 1)
			newTime = minutes + " minute, ";
		else
			newTime = minutes + " minutes, ";
		
		newTime = newTime + "" + seconds + " seconds";
		return newTime;
	}
	
	public int getTotalRecords() {
		int count = 0;
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_POPULARITY);
		
		try {
			while(rs.next()) {
				count = count + rs.getInt("numPlays");
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getTotalRecords");
		}
		return count;
	}
	
	/**
	 * Returns the history of the quiz, from earliest to most recent
	 */
	public Vector<Record> getRecords(int quizID) {
		Vector<Record> records = new Vector<Record>();
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID + " ORDER BY timeStamp");
		try {
			while (rs.next()) {
				records.add(new Record(rs.getString("username"), rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRecords");
		}
		return records;
	}
	
	public double getAverageScore(int quizID) {
		Vector<Record> records = getRecords(quizID);
		double average = 0;
		for (int x = 0; x < records.size(); x++) {
			average+= records.get(x).getScore();
		}
		average = average/records.size();
		return average;
	}
	
	public String getAverageTimeSpent(int quizID) {
		Vector<Record> records = getRecords(quizID);
		String averageTime = "";
		double average = 0;
		for (int x = 0; x < records.size(); x++) {
			average+= records.get(x).getTime();
		}
		average = average/records.size();
		int hours = (int)average;
		int seconds = (int)(average * 60)%60;
		averageTime = hours + " minutes, " + seconds + " seconds";
		return averageTime;
	}
	
	/**
	 * Returns x number of records (represented by numScores), from best to worst, 
	 * for the specified quiz.
	 */
	public Vector<Record> getTopRecords(int quizID, int numScores) {
		Vector<Record> highScores = new Vector<Record>();
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID + " ORDER BY score DESC, totalTime ASC, timeStamp DESC");
		try {
			for (int x = 0; x < numScores; x++) {
				if (!rs.next())
					return highScores;
				highScores.add(new Record(rs.getString("username"), rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getTopScores");
		}
		return highScores;
	}
	
	/**
	 * Returns all records for the user for all quizzes.  Use one of the static variables
	 * for orderBy (see top).  Use true if you want the results to be from lowest to highest, 
	 * false otherwise.
	 */
	public Vector<Record> getUserRecords(String username, String orderBy, boolean ascending) {
		Vector<Record> highScores = new Vector<Record>();
		String query = "SELECT * FROM " + QUIZ_SCORES + " WHERE username = \"" + username + "\" ORDER BY ";
		if (orderBy.equals(ORDER_BY_SCORE)){
			query = "" + query + "" + orderBy;
			if (ascending)
				query = query + " ASC, " + ORDER_BY_TIME + " DESC";
			else
				query = query + " DESC, " + ORDER_BY_TIME + " ASC";
		}
		else {
			if (ascending)
				query = query + orderBy + " ASC";
			else
				query = query + orderBy + " DESC";
		}
		ResultSet rs = con.queryDB(query);
		int quizID;
		String quizName;
		try {
			while (rs.next()) {
				quizID = Integer.parseInt(rs.getString("quizID"));
				quizName = rs.getString("name");
				highScores.add(new Record(quizID, quizName, username, rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::derpderpderpinGetUserRecords");
		}
		return highScores;
	}
	
	public Vector<Record> getUserRecords(int quizID, String username, String orderBy, boolean ascending) {
		Vector<Record> highScores = new Vector<Record>();
		String query = "SELECT * FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID + " AND username = \"" + username + "\" ORDER BY ";
		if (orderBy.equals(ORDER_BY_SCORE)){
			query = "" + query + "" + orderBy;
			if (ascending)
				query = query + " ASC, " + ORDER_BY_TIME + " DESC";
			else
				query = query + " DESC, " + ORDER_BY_TIME + " ASC";
		}
		else {
			if (ascending)
				query = query + orderBy + " ASC";
			else
				query = query + orderBy + " DESC";
		}
		ResultSet rs = con.queryDB(query);
		String quizName;
		try {
			while (rs.next()) {
				quizName = rs.getString("name");
				highScores.add(new Record(quizID, quizName, username, rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::derpderpderpinGetUserRecords");
		}
		return highScores;
	}
	
	/**
	 * Returns the most recent records (good and bad).
	 */
	public Vector<Record> getRecentRecords(int quizID, long interval) {
		long cutoff = System.currentTimeMillis() - interval;
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID + " ORDER BY timeStamp DESC");
		Vector<Record> records = new Vector<Record>();
		try {
			while(rs.next()) {
				if (rs.getTimestamp("timeStamp").getTime() < cutoff)
					return records;
				records.add(new Record(rs.getString("username"), rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRecentRecords");
		}
		return records;
	}
	
	/**
	 * Returns the most recent top records.
	 */
	public Vector<Record> getBestRecentRecords(int quizID, long interval, int numRequested) {
		long cutoff = System.currentTimeMillis() - interval;
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE quizID = " + quizID + " ORDER BY score DESC, totalTime ASC, timeStamp DESC");
		Vector<Record> records = new Vector<Record>();
		try {
			while(rs.next()) {
				if (rs.getTimestamp("timeStamp").getTime() >= cutoff)
					if (records.size() >= numRequested) break;
					records.add(new Record(rs.getString("username"), rs.getInt("score"), rs.getDouble("totalTime"), rs.getTimestamp("timeStamp").getTime()));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::getRecentRecords");
		}
		return records;
	}
	
	public void clearRecords(int quizID) {
		int numQuestions = getNumQuestions(quizID);
		for (int x = 0; x < numQuestions; x++) {
			
		}
	}
	/**
	 * Adds a record to the database.
	 */
	public void putRecord(int quizID, Record r) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE quizID = " + quizID);
		String name;
		try {
			rs.next();
			name = rs.getString("name");
			con.updateDB("INSERT INTO " + QUIZ_SCORES + " VALUES ( " + quizID + ", \"" + r.getUser() + "\", " + r.getScore() + ", " + r.getTime() + ", NOW(), \"" + name + "\")");
			
			rs  = con.queryDB("SELECT * FROM " + QUIZ_POPULARITY + " WHERE quizID = " + quizID);
			rs.next();
			int popularity = rs.getInt("numPlays");
			popularity++;
			con.updateDB("UPDATE " + QUIZ_POPULARITY + " SET numPlays = " + popularity + " WHERE quizID =  " + quizID);
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in QuizDatabase::putRecord");
		}
	}
	
	
	//*****************************
	//* Helper methods after here *
	//*****************************
	
	private Vector<Question> ReconstructQuestions(int quizID, int numq){
		Vector<Question> qs = new Vector<Question>();
		QuizDatabase qdb = new QuizDatabase();
		for(int i = 0; i < numq; i++){
			String type = qdb.getQuestionType(quizID, i);
			Vector<String> question = qdb.getQuestion(quizID, i);
			Vector<Vector<String> > answers = qdb.getAnswers(quizID, i);
			Question q = new Question(type, i, question, answers);
			qs.add(q);
		}
		return qs;
	}
	
	private void incrementQuestions(int quizID, int questionID) {
		incrementQuestionType(quizID, questionID, QUESTION_RESPONSE);
		incrementQuestionType(quizID, questionID, FILL_IN_THE_BLANK);
		incrementQuestionType(quizID, questionID, MULTIPLE_CHOICE);
		incrementQuestionType(quizID, questionID, PICTURE_RESPONSE);
		incrementQuestionType(quizID, questionID, MULTIPLE_ANSWER);
		incrementQuestionType(quizID, questionID, MULTI_UNORDERED_RESPONSE);
		incrementQuestionType(quizID, questionID, MULTI_ORDERED_RESPONSE);
		incrementQuestionType(quizID, questionID, ANSWERS);
		incrementQuestionType(quizID, questionID, QUIZ_MAP);

	}
	
	private void decrementQuestions(int quizID, int questionID) {
		decrementQuestionType(quizID, questionID, QUESTION_RESPONSE);
		decrementQuestionType(quizID, questionID, FILL_IN_THE_BLANK);
		decrementQuestionType(quizID, questionID, MULTIPLE_CHOICE);
		decrementQuestionType(quizID, questionID, PICTURE_RESPONSE);
		incrementQuestionType(quizID, questionID, MULTIPLE_ANSWER);
		incrementQuestionType(quizID, questionID, MULTI_UNORDERED_RESPONSE);
		incrementQuestionType(quizID, questionID, MULTI_ORDERED_RESPONSE);
		decrementQuestionType(quizID, questionID, ANSWERS);
		decrementQuestionType(quizID, questionID, QUIZ_MAP);
	}
	
	private void incrementQuestionType(int quizID, int questionID, String type) {
		ResultSet rs = con.queryDB("SELECT * FROM " + type + " WHERE quizID = " + quizID + " AND questionID >= " + questionID + " ORDER BY questionID DESC");
		HashMap<Integer, Integer> newValues = new HashMap<Integer, Integer>();
		Vector<Integer> ids = new Vector<Integer>();
		int currID, newID;
		try {
			while (rs.next()) {
				currID = rs.getInt("questionID");
				newID = currID + 1;
				newValues.put(currID, newID);
				ids.add(currID);
			}
			
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::incrementQuestionType");
		}	
		for (int x = 0; x < ids.size(); x++)
			con.updateDB("UPDATE " + type + " SET questionID = " + newValues.get(ids.get(x)) + " WHERE quizID = " + quizID + " AND questionID = " + ids.get(x));
	}
	
	private void decrementQuestionType(int quizID, int questionID, String type) {
		ResultSet rs = con.queryDB("SELECT * FROM " + type + " WHERE quizID = " + quizID + " AND questionID > " + questionID + " ORDER BY questionID");
		HashMap<Integer, Integer> newValues = new HashMap<Integer, Integer>();
		Vector<Integer> ids = new Vector<Integer>();
		int currID, newID;
		try {
			while (rs.next()) {
				currID = rs.getInt("questionID");
				newID = currID - 1;
				newValues.put(currID, newID);
				ids.add(currID);
			}
			
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::incrementQuestionType");
		}	
		for (int x = 0; x < ids.size(); x++)
			con.updateDB("UPDATE " + type + " SET questionID = " + newValues.get(ids.get(x)) + " WHERE quizID = " + quizID + " AND questionID = " + ids.get(x));
	}
	
	private void insertQuestionType(int quizID, int questionID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		for (int x = 0; x < components.size(); x++) {
			con.updateDB("INSERT INTO " + type + " VALUES ( " + quizID + ", " + questionID + ", " + x + ", \"" + components.get(x) + "\")");
		}
		for (int x = 0; x < answers.size(); x++) {
			for (int y = 0; y < answers.get(x).size(); y++) {
				con.updateDB("INSERT INTO " + ANSWERS + " VALUES ( " + quizID + ", " + questionID + ", " + x + ", \"" + answers.get(x).get(y).toLowerCase() + "\")");
			}
		}
		con.updateDB("INSERT INTO " + QUIZ_MAP + " VALUES ( " + quizID + ", " + questionID + ", \"" + type + "\")");
	}
	
	private void deleteQuestionType(int quizID, int questionID, String type) {
		con.updateDB("DELETE FROM " + type + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		con.updateDB("DELETE FROM " + ANSWERS + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		con.updateDB("DELETE FROM " + QUIZ_MAP + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
	}

	private void adjustNumQuestions(int quizID, boolean increment) {
		ResultSet rs = con.queryDB("SELECT * FROM " + NUM_QUESTIONS + " WHERE quizID = " + quizID);
		int currNum, newNum;
		try {
			if (!rs.next())
				throw new RuntimeException("Quiz ID wrong in Database::incrementNumQuestions");
			currNum = rs.getInt("numQuestions");
			if (increment)
				newNum = currNum + 1;
			else
				newNum = currNum - 1;
			con.updateDB("UPDATE " + NUM_QUESTIONS + " SET numQuestions = " + newNum + " WHERE quizID = " + quizID + " AND numQuestions = " + currNum);
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::incrementNumQuestions");
		}	
	}
	
	private Vector<String> createQuestionVector(ResultSet rs) {
		Vector<String> questionComponents = new Vector<String>();
		try {
			while (rs.next()) {
				questionComponents.add(rs.getString("question"));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::createQuestionVector");
		}
		return questionComponents;
	}
	
	private Vector<String> getQuestionFromDatabase(String type, int quizID, int questionID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + type + " WHERE quizID = " + quizID + " AND questionID = " + questionID);
		return createQuestionVector(rs);
	}
	
	public Vector<QuizAct> getQuizSearch(String s) {
		Vector<QuizAct> vq = new Vector<QuizAct>();
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE name LIKE \"%" + s + "%\" OR description LIKE \"%" + s + "%\"");
		try {
			while(rs.next()) {
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String desc = rs.getString("description");
				QuizAct t = new QuizAct(name,quizID,desc);
				vq.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getUserNames");
		}
		
		return vq;
	}

}
