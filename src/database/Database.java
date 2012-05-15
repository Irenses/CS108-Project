package database;
import java.util.*;
import java.sql.*;
/*
 * Notes:
 * The way the Database is structured is every question is stored with an
 * associated quizID and questionID (both 0 based).  Both are required in order to 
 * access anything.
 * Use DatabaseTest.sql to construct a test database.
 */
public class Database {
	private DBConnection con;
	
	// *****************************************************************
	// * DO NOT USE THIS ONE IT IS OBSOLETE.  Use QuizDatabase instead *
	// *****************************************************************
	 
	
	/*************************
	 * Note by James:
	 * 
	 * 1. We currently support the 4 types plus muli-choice, multi-answer, ordered multiple response, and unordered multi-response
	 * 
	 * 2. We need to store the 4 booleans: random? one-page? immediate? practice?
	 * 
	 * 3. We need to store the number of questions in the quiz (done) and number of times played.
	 * 
	 * 4. We can store the records in the same format as questions: quizID-recordID, and the 4 fields of a record is stored in the "Record" table
	 * 
	 * 5. To reconstruct a question, ID, tyep, question, and answers are fine;
	 * 
	 * 6. To reconstruct a quiz, I need the list of questions and records reconstructed and put in two arraylists, 
	 *    plus the 4 booleans, quizID, creator, description.
	 *    
	 * 7. Thank you!!!!!
	 * 
	 ***************************/
	
	//These represent the 4 question types currently supported.  We can add more if necessary
	public static String QUESTION_RESPONSE = "qr";
	public static String FILL_IN_THE_BLANK = "fitb";
	public static String MULTIPLE_CHOICE = "mc";
	public static String PICTURE_RESPONSE = "pr";
	
	public static String ANSWERS = "answers";
	public static String QUIZ_MAP = "quizMap";
	
	
	public Database() {
		con = DBConnection.getSharedConnection();
	}
	
	/*
	 * Pretty straightforward.  Gets you the number of questions
	 * associated with the particular quiz.
	 */
	public int getNumQuestions(int quizID) {
		ResultSet rs = con.queryDB("SELECT * FROM numQuestions WHERE quizID = " + quizID);
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
	
	/*
	 * Returns one of the four question types (see static variables) for the associated
	 * question
	 */
	public String getQuestionType(int quizID, int questionID) {
		ResultSet rs = con.queryDB("SELECT * FROM quizMap WHERE quizID = " + quizID + " AND questionID = " + questionID);
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
	
	/*
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
		ResultSet rs = con.queryDB("SELECT * FROM quizMap WHERE quizID = " + quizID + " AND questionID = " + questionID);
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
	
	/*
	 * Returns a Vector<Vector<String>> representing the answers to the associated question.  The
	 * reason it's a double vector is to allow for multiple answer questions.  All Strings in the 
	 * vector located at their respective index will represent all possible answers for that answer
	 * (For example, suppose we have a multi-answer question "Name the 50 states".  The vector at
	 * index 0 could contain {"California", "CA"}, meaning that these answers all represent the
	 * same answer.  Other vectors represent different answers).
	 */
	
	public Vector<Vector<String>> getAnswers(int quizID, int questionID) {
		Vector<Vector<String>> answers = new Vector<Vector<String>>();
		ResultSet rs = con.queryDB("SELECT * FROM answers WHERE quizID = " + quizID + " AND questionID = " + questionID + " ORDER BY answerID DESC");
		int answerID;
		
		try {
			rs.next();
			answerID = rs.getInt("answerID");
			for (int x = 0; x <= answerID; x++) {
				rs = con.queryDB("SELECT * FROM answers WHERE quizID = " + quizID + " AND questionID = " + questionID + " AND answerID = " + x);
				while (rs.next()) {
					answers.add(new Vector<String>());
					answers.get(answerID).add(rs.getString("answer"));
				}
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in Database::getAnswers");
		}	
		return answers;
	}
	
	/*
	 * Add a question at the end of the quiz.  Needs the Vector<String> of components and the 
	 * Vector<Vector<String>> of answers.
	 */
	public void addQuestion(int quizID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		int numQuestions = getNumQuestions(quizID);
		insertQuestionType(quizID, numQuestions, type, components, answers);
		adjustNumQuestions(quizID, true);
	}
	
	/*
	 * Insert a question into the specified questionID index.  Similar to add, it requires the
	 * question components and answers
	 */
	public void insertQuestion(int quizID, int questionID, String type, Vector<String> components, Vector<Vector<String>> answers) {
		incrementQuestions(quizID, questionID);
		insertQuestionType(quizID, questionID, type, components, answers);
		adjustNumQuestions(quizID, true);
	}
	
	/*
	 * Deletes the question in the specified quiz.
	 */
	public void deleteQuestion(int quizID, int questionID) {
		String type = getQuestionType(quizID, questionID);
		deleteQuestionType(quizID, questionID, type);
		decrementQuestions(quizID, questionID);
		adjustNumQuestions(quizID, false);
	}
	
	
	//***************************
	//Helper methods after here	*
	//***************************
	
	
	private void incrementQuestions(int quizID, int questionID) {
		incrementQuestionType(quizID, questionID, QUESTION_RESPONSE);
		incrementQuestionType(quizID, questionID, FILL_IN_THE_BLANK);
		incrementQuestionType(quizID, questionID, MULTIPLE_CHOICE);
		incrementQuestionType(quizID, questionID, PICTURE_RESPONSE);
		incrementQuestionType(quizID, questionID, ANSWERS);
		incrementQuestionType(quizID, questionID, QUIZ_MAP);
	}
	
	private void decrementQuestions(int quizID, int questionID) {
		decrementQuestionType(quizID, questionID, QUESTION_RESPONSE);
		decrementQuestionType(quizID, questionID, FILL_IN_THE_BLANK);
		decrementQuestionType(quizID, questionID, MULTIPLE_CHOICE);
		decrementQuestionType(quizID, questionID, PICTURE_RESPONSE);
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
}