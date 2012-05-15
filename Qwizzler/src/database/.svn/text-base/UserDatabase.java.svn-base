package database;
import user.*;
import quiz.*;

import java.sql.*;
import java.util.*;

public class UserDatabase {
	private DBConnection con;
	private static QuizDatabase qdb;
	
	public static String ACCOUNT_INFO = "accountInfo";
	public static String FRIENDS = "friends";
	public static String ACHIEVEMENTS = "achievements";
	public static String QUIZ_INFO = "quizInfo";
	public static String QUIZ_SCORES = "quizScores";
	public static String MESSAGES = "messages";
	public static int MAX_CHARACTERS = 16;
	
	public static String USERNAME = "username";
	public static String PASSWORD = "password";
	public static String FULL_NAME = "fullname";
	public static String EMAIL = "email";
	public static String ISADMIN = "isAdmin";
	
	public UserDatabase() {
		con = DBConnection.getSharedConnection();
		qdb = new QuizDatabase();
	}
	
	/**
	 * Checks the database for the specified username.  Returns false
	 * if the username already exists in the database or if it's over
	 * 16 characters.  Otherwise, the username is valid and it returns
	 * true.
	 */
	public boolean validUserName(String username) {
		if (username.length() > MAX_CHARACTERS)
			return false;
		if ((username.equals("Qwizzler")) || (username.equals("QwizzlerSite")))
			return false;
		ResultSet rs = con.queryDB("SELECT * FROM " + ACCOUNT_INFO + " WHERE username = \"" + username + "\"");
		try {
			if (rs.next())
				return false;
			else
				return true;
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::validUserName");
		}
	}
	
	/**
	 * Adds the user info to the database.  Returns true if
	 * successful, false otherwise.  Sets the timestamp to the 
	 * String provided
	 */
	public boolean addUser(String username, String password, String fullname, String email, boolean admin, String timeStamp) {
		if (!validUserName(username))
			return false;
		con.updateDB("INSERT INTO " + ACCOUNT_INFO + " VALUES ( \"" + username + "\", \"" + password + "\", \"" + fullname + "\", \"" + email + "\", " + admin + ", \"" + timeStamp + "\")");
		return true;
	}
	
	
	/**
	 * Adds the user info to the database.  Returns true if
	 * successful, false otherwise.  Sets the timestamp to the
	 * current time. 
	 */
	public boolean addUser(String username, String password, String fullname, String email, boolean admin) {
		if (!validUserName(username))
			return false;
		con.updateDB("INSERT INTO " + ACCOUNT_INFO + " VALUES ( \"" + username + "\", \"" + password + "\", \"" + fullname + "\", \"" + email + "\", " + admin + ", NOW())");
		return true;
	}
	
	/**
	 * Adds the username and password to the database.  Returns true if
	 * successful, false otherwise.
	 */
	public boolean addUser(User user) {
		if (!validUserName(user.getUsername())) return false;
		con.updateDB("INSERT INTO " + ACCOUNT_INFO + " VALUES(\"" + user.getUsername() + "\",\"" + user.getPassword() + "\",\"" + user.getFullName() + "\",\"" + user.getEmail() + "\"," + user.isAdmin() + "," + null + ")");
		return true;
	}
	
	/**
	 * Changes the specified attribute for the user to whatever's in String s.  Use 
	 * the static variables to specify.
	 */
	public void changeAttribute(String username, String s, String attribute) {
		con.updateDB("UPDATE " + ACCOUNT_INFO + " SET " + attribute + " = \"" + s + "\" WHERE username = \"" + username + "\"");
	}
	
	/**
	 * Sets the admin status of the account
	 */
	public void changeAdminStatus(String username, boolean admin) {
		con.updateDB("UPDATE " + ACCOUNT_INFO + " SET isAdmin = " + admin + " WHERE username = \"" + username + "\"");
	}
	
	/**
	 * Given the username, returns a User object from the database representing all the 
	 * important information about the user
	 */
	public User getUserInfo(String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + ACCOUNT_INFO + " WHERE username = \"" + username + "\"");
		User user = null;
		String u = null;
		String p = null;
		String fr = null;
		String em = null;
		Timestamp t = null;
		boolean a = false;
		try {
			if (!rs.next()) return user;
			u =rs.getString("username");
			p = rs.getString("password");
			fr = rs.getString("fullname");
			em = rs.getString("email");
			a = rs.getBoolean("isAdmin");
			t = rs.getTimestamp("created");
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getUserInfo");
		}
		Vector<String> f = getFriends(username);
		user =  new User(u, p,fr,em,t, f, getAchievements(username), a);
		return user;
	}
	
	/**
	 * Adds two people as friends in the database
	 */
	public void addFriend(String username1, String username2) {
		con.updateDB("INSERT INTO " + FRIENDS + " VALUES ( \"" + username1 + "\", \"" + username2 + "\")");
		con.updateDB("INSERT INTO " + FRIENDS + " VALUES ( \"" + username2 + "\", \"" + username1 + "\")");
	}
	
	/**
	 * Deletes record of friendship between two people
	 */
	public void deleteFriend(String u1, String u2) {
		con.updateDB("DELETE FROM " + FRIENDS + " WHERE username1 = \"" + u1 + "\" AND username2 = \"" + u2 + "\"");
		con.updateDB("DELETE FROM " + FRIENDS + " WHERE username1 = \"" + u2 + "\" AND username2 = \"" + u1 + "\"");		
	}
	
	/**
	 * Returns a Vector of Users representing the username's friends list
	 */
	public Vector<String> getFriends(String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + FRIENDS + " WHERE username1 = \"" + username + "\"");
		Vector<String> friendsList = new Vector<String>();
		try {
			while (rs.next()) {
				String friend = rs.getString("username2");
				friendsList.add(friend);
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getFriends");
		}
		
		return friendsList;
	}
	
	
	/**
	 * Returns true of the two users are friends, false if they're not
	 */
	public boolean areFriends(String username1, String username2) {
		ResultSet rs = con.queryDB("SELECT * FROM " + FRIENDS + " WHERE username1 = \"" + username1 + "\" AND \" username 2 = \"" + username2 + "\"");
		try {
			if (rs.next())
				return true;
			else
				return false;
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::areFriends");
		}
	}
	
	/**
	 * Given a username and a quizID, returns the highest score the user
	 * has on that specific quiz.
	 */
	/*public int getScoreOnQuiz(String username, int quizID) {
		Vector<Record> records = qdb.getUserRecords(quizID, username, QuizDatabase.ORDER_BY_SCORE, false);
		return records.get(0).getScore();
	}*/
	
	/**
	 * Returns a Vector of achievementIDs representing all the user's 
	 * achievements
	 */
	public Vector<Integer> getAchievements(String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + ACHIEVEMENTS + " WHERE username = \"" + username + "\"");
		Vector<Integer> achievements = new Vector<Integer>();
		try {
			while(rs.next()) {
				int id = rs.getInt("achievementID");
				achievements.add(id);
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getAchievements");
		}
		return achievements;
	}
	
	/*
	 * Associates the username with the achievementID, and also creates a timestamp for when it was earned
	 */
	public void addAchievement(String username, int achievement) {
		con.updateDB("INSERT INTO " + ACHIEVEMENTS + " VALUES( \"" + username + "\", " + achievement + "," + null + ")");
	}
	
	public int getNumUsers() {
		ResultSet rs = con.queryDB("SELECT * FROM " + ACCOUNT_INFO);
		int size = 0;
		if (rs != null) {
			try {
				rs.last();
				size = rs.getRow();
				rs.beforeFirst();
			} catch (SQLException e) {
				throw new RuntimeException("SQLException in UserDatabase::getNumUsers");
			}
		}
		return size;
	}
	
	//NEED TO WORK between QuizInfo and QuizScore tables to implement the following methods
	
	//returns names of last n made quizzes
	/*public Vector<String> getLastNMadeQwiz(String maker, int n) {	//Hopefully order order in the right order, or else i have to reverse it
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE creator = \"" + maker + "\" ORDER BY timeCreated");
		Vector<String> lastN = new Vector<String>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				lastN.add(rs.getString("name"));
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNMadeQwiz");
		}
		return lastN;
	}
	
	//returns names of taken quizzes
	public Vector<String> getLastNTakenQwiz(String taker, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE username = \"" + taker + "\" ORDER BY timeStamp");
		Vector<String> lastN = new Vector<String>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int id = rs.getInt("quizID");
				lastN.add(qdb.getName(id));//hopefully this works
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNTakenQwiz");
		}
		return lastN;
	}*/
	
	public Vector<QuizName> getLastNMadeQwizzes(String maker, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE creator = \"" + maker + "\" ORDER BY timeCreated DESC");
		Vector<QuizName> lastN = new Vector<QuizName>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				QuizName t = new QuizName(quizID, name, description);
				lastN.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNMadeQwiz");
		}
		return lastN;
		
	}
	
	public Vector<QuizName> getLastNTakenQwizzes(String taker, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE username = \"" + taker + "\" ORDER BY timeStamp DESC");
		Vector<QuizName> lastN = new Vector<QuizName>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				String description = "";//rs.getString("description");
				QuizName t = new QuizName(quizID, name, description);
				lastN.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNTakenQwizzes");
		}
		return lastN;
	}
	
	//returns a list of the names of the latest achievements that were earned
	public Vector<QuizAct> getLastNAchievements(String earner, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + ACHIEVEMENTS + " WHERE username = \"" + earner + "\" ORDER BY timeStamp DESC");
		Vector<QuizAct> lastN = new Vector<QuizAct>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int d = -1;
				int id = rs.getInt("achievementID");
				Achievement a = Achievement.getAchievement(id);
				String name = a.getAchievementName();
				Timestamp y = rs.getTimestamp("timeStamp");
				QuizAct t = new QuizAct(name,d,y);
				lastN.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNMadeQwiz");
		}
		return lastN;
	}
	
	public Vector<Activity> getLastNActivities(String name, int n) {
		Vector<Activity> act = new Vector<Activity>();//i can prolly combine these into one type of object by jusy adding a type ot the QuizAct
		Vector<QuizAct> taken = this.getLastNTakenQ(name, n);
		for (int i = 0; i < taken.size(); i++) {			
			Activity a = new Activity(taken.get(i).getTime(),1,taken.get(i).getName(),taken.get(i).getID());
			act.add(a);
		}
		Vector<QuizAct> made = this.getLastNMadeQ(name, n);
		for (int i = 0; i < made.size(); i++) {			
			Activity a = new Activity(made.get(i).getTime(),0,made.get(i).getName(),made.get(i).getID());
			act.add(a);
		}
		Vector<QuizAct> achieve = this.getLastNAchievements(name, n);
		for (int i = 0; i < achieve.size(); i++) {			
			Activity a = new Activity(achieve.get(i).getTime(),2,achieve.get(i).getName(),achieve.get(i).getID());
			act.add(a);
		}
		return act;
	}
	
	
	private Vector<QuizAct> getLastNMadeQ(String maker, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_INFO + " WHERE creator = \"" + maker + "\" ORDER BY timeCreated DESC");
		Vector<QuizAct> lastN = new Vector<QuizAct>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				Timestamp y = rs.getTimestamp("timeCreated");
				QuizAct t = new QuizAct(name,quizID,y);
				lastN.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNMadeQwiz");
		}
		return lastN;
	}
		
	private Vector<QuizAct> getLastNTakenQ(String taker, int n) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE username = \"" + taker + "\" ORDER BY timeStamp DESC");
		Vector<QuizAct> lastN = new Vector<QuizAct>();
		try {
			for (int x = 0; x < n; x++) {
				if (!rs.next()) return lastN;
				int quizID = rs.getInt("quizID");
				String name = rs.getString("name");
				Timestamp y = rs.getTimestamp("timeStamp");
				QuizAct t = new QuizAct(name,quizID,y);
				lastN.add(t);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getLastNTakenQwiz");
		}
		return lastN;
	}
	
	public Vector<Activity> getFriendActivities(String name, int n) {
		Vector<Activity> act = new Vector<Activity>();
		Vector<QuizAct> taken = this.getLastNTakenQ(name, n);
		for (int i = 0; i < taken.size(); i++) {			
			Activity a = new Activity(taken.get(i).getTime(),1,taken.get(i).getName(),taken.get(i).getID(),name);
			act.add(a);
		}
		Vector<QuizAct> made = this.getLastNMadeQ(name, n);
		for (int i = 0; i < made.size(); i++) {			
			Activity a = new Activity(made.get(i).getTime(),0,made.get(i).getName(),made.get(i).getID(),name);
			act.add(a);
		}
		Vector<QuizAct> achieve = this.getLastNAchievements(name, n);
		for (int i = 0; i < achieve.size(); i++) {			
			Activity a = new Activity(achieve.get(i).getTime(),2,achieve.get(i).getName(),achieve.get(i).getID(),name);
			act.add(a);
		}
		return act;
	}
	
	public void deleteAccount(String username) {
		Vector<String> vs = this.getFriends(username);
		for (String f : vs) {
			this.deleteFriend(username, f); //deletes all records of associated friendship
		}
		this.deleteMessagesFrom(username);
		this.deleteMessagesTo(username);
		this.deleteAchievements(username);
		this.deleteQuizzes(username);
		//then need to delete actual account info entry
		this.deleteAccountInfo(username);
	}
	
	public void deleteQuizzes(String creator) {
		Vector<Integer> id = qdb.getIDs(creator);
		for (int i : id) {
			qdb.deleteQuiz(i);
		}
	}
	
	public void deleteAccountInfo(String username) {
		con.updateDB("DELETE FROM " + ACCOUNT_INFO + " WHERE username = \"" + username + "\"");
	}
	
	public void deleteAchievements(String e) {
		con.updateDB("DELETE FROM " + ACHIEVEMENTS + " WHERE username = \"" + e + "\"");
	}
	
	public void deleteMessagesFrom(String from) {
		con.updateDB("DELETE FROM " + MESSAGES + " WHERE fromName = \"" + from + "\"");
	}
	
	public void deleteMessagesTo(String to) {
		con.updateDB("DELETE FROM " + MESSAGES + " WHERE toName = \"" + to + "\"");
	}
	
	public void deleteMessage(String from, String to) {
		con.updateDB("DELETE FROM " + MESSAGES + " WHERE fromName = \"" + from + "\" AND toName = \"" + to + "\"");
	}
	
	public void deleteFriendRequest(String from, String to) {
		con.updateDB("DELETE FROM " + MESSAGES + " WHERE fromName = \"" + from + "\" AND toName = \"" + to + "\" AND messageType = 2");
	}
	
	public int getBestScore(String username, int qID) {
		ResultSet rs = con.queryDB("SELECT * FROM " + QUIZ_SCORES + " WHERE username = \"" + username + "\" AND quizID = " + qID + " ORDER BY score DESC");
		try {
			if (rs.next()) return rs.getInt("score");
			else return -1;
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getBestScore");
		}
	}
	
	public Vector<UserDerp> getUserNames(String username) {
		Vector<UserDerp> vs = new Vector<UserDerp>();
		ResultSet rs = con.queryDB("SELECT * FROM " + ACCOUNT_INFO + " WHERE username LIKE \"%" + username + "%\" OR fullname LIKE \"%" + username + "%\"");
		try {
			while(rs.next()) {
				String user =rs.getString("username");
				String name = rs.getString("fullname");
				UserDerp u = new UserDerp(user,name);
				vs.add(u);
			}
		} catch (SQLException e) {
			throw new RuntimeException("SQLException in UserDatabase::getUserNames");
		}
		
		return vs;
	}
	
}
