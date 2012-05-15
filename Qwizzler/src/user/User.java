package user;

import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.Timestamp;
import java.security.*;

import javax.servlet.ServletContext;

import message.Message;

import quiz.Quiz;

import database.MessageDatabase;
import database.UserDatabase;


public class User {	
	
	private final String username;
	private final String password;
	private Vector<Integer> achievements;
	private Timestamp dateCreated;	
	private String fullName;
	private String email;
	private boolean admin;
	private Vector<String> friends;

	//prototype for local servlet object creation
	public User(String username, String password, String fullname, String email) {
		this.username = username;
		this.password = password;
		this.achievements = new Vector<Integer>();
		this.dateCreated = null;
		this.admin = false;
		this.email = email;//needs an @ character, MAYBE ADD A '.' that must come after the @
		//email really is still superfluous now though
		this.fullName = fullname;
		this.friends = new Vector<String>();
	}
	
	//Constructor prototype for database retrievals
	public User(String username, String password,String fullname, String email, Timestamp time,Vector<String> friends,Vector<Integer> achievements, boolean admin) {
		this.username = username;
		this.password = password;
		this.achievements = achievements;
		this.dateCreated = time;
		this.admin = admin;
		this.email = email;
		this.fullName = fullname;
		this.friends = friends;
	}
	
	public boolean checkPassword(String attempt) {
    	return (this.password.equals(hashPassword(attempt)));
    }
	
	
	public String getPassword() {
		return this.password;
	}
	
	
	/*returns encrypted version of password for storage in database/checking against password in login */
	public static String hashPassword(String p) {
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("SHA");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return hexToString(md.digest(p.getBytes()));
	}
	
	/*
	 Given a byte[] array, produces a hex String,
	 such as "234a6f". with 2 chars for each byte in the array.
	 (provided code)
	*/
	private static String hexToString(byte[] bytes) {
		StringBuffer buff = new StringBuffer();
		for (int i=0; i<bytes.length; i++) {
			int val = bytes[i];
			val = val & 0xff;  // remove higher bits, sign
			if (val<16) buff.append('0'); // leading 0
			buff.append(Integer.toString(val, 16));
		}
		return buff.toString();
	}
	
	public void setAdminStatus(boolean b) {
		UserDatabase udb = new UserDatabase();
		udb.changeAdminStatus(this.username, b);
		this.admin = b;
	}
	
	public boolean isAdmin() {
		return this.admin;
	}
	
	public Timestamp getTimestamp() {
		return this.dateCreated;
	}
	
	public String getDateString() {
		String date = new SimpleDateFormat("MM/dd/yyyy").format(this.dateCreated);
		return date; 
	}
	
	public String getFullName() {
		return this.fullName;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getUsername() {
		return this.username;
	}
	
	public boolean hasAchievement(int n) {
		return this.achievements.contains(n);
	}
	
	public Vector<Achievement> getAchievements() {
		Vector<Achievement> a = new Vector<Achievement>();
		for (int i = 0; i < achievements.size(); i++) {
			int id = achievements.get(i);
			Achievement ac = Achievement.getAchievement(id);
			a.add(ac);
		}
		return a;
	}
	
	public Vector<Integer> getAchievementIDs() {
		return this.achievements;
	}
	
	public void addAchievement(Achievement a) {
		if (!this.achievements.contains(a.getID())) {
			UserDatabase udb = new UserDatabase();
			udb.addAchievement(this.username, a.getID());
			this.achievements = udb.getAchievements(this.username);
		}
		
	}
	
	public Vector<User> getFriends() {
		Vector<User> f = new Vector<User>();
		UserDatabase udb = new UserDatabase();
		for (int i = 0; i < friends.size(); i++) {
			String fr = friends.get(i);
			User user = udb.getUserInfo(fr);
			f.add(user);
		}
		return f;
	}
	
	public Vector<String> getFriendNames() {
		UserDatabase udb = new UserDatabase();//trying to make user's friend list reflect a recent friend acceptance upon reload of the page
		this.friends = udb.getFriends(this.username);
		return this.friends;
	}
	
	//might be good to have a popup window say: Friend successfully added, when a friend request it confirmed
	public void addFriend(User friend) {
		if (!this.friends.contains(friend.getUsername())) {
			UserDatabase udb = new UserDatabase();
			udb.addFriend(this.username, friend.getUsername());
			this.friends = udb.getFriends(this.username);
		}
	}
	
	public void addFriend(String friend) {
		if (!this.friends.contains(friend)) {//hopefully these checks protect against hitting 'add' button
											//more than once / friend requests going both ways
			UserDatabase udb = new UserDatabase();
			udb.addFriend(this.username, friend);
			this.friends = udb.getFriends(this.username);
		}
	}
	
	//need to add a delete friend function that updates DB
	public void deleteFriend(String friendName) {
		if (this.friends.contains(friendName)) {
			UserDatabase udb = new UserDatabase(); 
			udb.deleteFriend(this.username, friendName);
			this.friends = udb.getFriends(this.username);
		}
	}
	
	@Override
	public boolean equals(Object obj) { 
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		User other = (User) obj;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}
	
	/* Admin functions below */

	public boolean isFriendsWith(String otherUser) {
		return this.friends.contains(otherUser);
	}
	
	/*
	//returns list of strings saying "X created the Y qwiz
	public Vector<String> getLastNCreatedQwizzes(int n) {
		UserDatabase udb = new UserDatabase();
		Vector<String> quizNames = udb.getLastNMadeQwiz(this.username, n);
		Vector<String> retV = new Vector<String>();
		for (int i = 0; i < quizNames.size(); i++) {
			retV.add("" + this.username + " created the " + quizNames.get(i) + " qwiz!");
		}
		return retV;
	}
	
	//returns list of strings, in order, saying "X took the Y qwiz"
	//NOTE: it may be kind of weird to visit your own profile and look at your recent histor
	//because it will say: "Joaquin took the Presidents qwiz!" instead of something more logical
	// like "You took the Presidents qwiz!"
	//I don't know if we really care about this, but it will happen
	public Vector<String> getLastNTakenQwizzes(int n) {
		UserDatabase udb = new UserDatabase();
		Vector<String> quizNames = udb.getLastNTakenQwiz(this.username, n);
		Vector<String> retV = new Vector<String>();
		for (int i = 0; i < quizNames.size(); i++) {
			retV.add("" + this.username + " took the " + quizNames.get(i) + " qwiz!");
		}
		return retV;
	}*/
	
	/*
	public Vector<Quiz> getLastNCreatedQwiz(int n) {
		UserDatabase udb = new UserDatabase();
		Vector<Quiz> ret = udb.getLastNMadeQwizzes(this.username, n);
		return ret;
	}
	
	public Vector<Quiz> getLastNTakenQwiz(int n) {
		UserDatabase udb = new UserDatabase();
		Vector<Quiz> t = udb.getLastNTakenQwizzes(this.username, n);
		return t;
	}
	*/
	
	
	//recent activities includes qwizzes created and taken, and achievements earned
	public Vector<String> getLastNActivities(int n, int b) {
		Vector<String> s = new Vector<String>();
		UserDatabase udb = new UserDatabase();
		List<Activity> a = udb.getLastNActivities(this.username, n);
		Collections.sort(a);
		for (int i = 0; i < n; i++) {
			if(a.size()<=i) break;
			Activity t = a.get(i);
			String res;
			if (b == 0) res = "You";
			else res = "" + this.getUsername();//b == 1
			//String res = "<a href=\"profile.jsp?user=" + this.getUsername() + "\"/>" + this.getUsername();
			if (t.getType() == 2) {//achievement
				res += " earned the \"" + t.getName() + "\" achievement!";
			} else if (t.getType() == 1) {//taken quiz
				res += " took the qwiz " + "<a href=\"quiz.jsp?id=" + t.getID() + "\"/>" + t.getName() + "</a>.";
			} else {//made quiz
				res += " created the qwiz " + "<a href=\"quiz.jsp?id=" + t.getID() + "\"/>" + t.getName() + "</a>.";
			}
			s.add(res);
		}
		return s;
	}

	
	public Vector<String> getFriendActivity(int n) {
		Vector<String> v = new Vector<String>();
		UserDatabase udb = new UserDatabase();
		List<Activity> a = new Vector<Activity>();
		for (String u : this.friends) {//iterates through all friends, adds all friends recent activity to list
			Vector<Activity> f = udb.getFriendActivities(u,n);
			for (Activity y : f) {
				a.add(y);
			}
		}
		Collections.sort(a);//sorts friends list of activities
		for (int i = 0; i < n; i++) {
			if (a.size() <= i) break;
			Activity t = a.get(i);
			String res = "<a href=\"profile.jsp?user=" + a.get(i).getUser() + "\"/>" + a.get(i).getUser()  + "</a>";
			if (t.getType() == 2) {//achievement
				res += " earned the \"" + t.getName() + "\" achievement!";
			} else if (t.getType() == 1) {//taken quiz
				res += " took the qwiz " + "<a href=\"quiz.jsp?id=" + t.getID() + "\"/>" + t.getName() + "</a>.";
			} else {//made quiz
				res += " created the qwiz " + "<a href=\"quiz.jsp?id=" + t.getID() + "\"/>" + t.getName() + "</a>.";
			}
			v.add(res);
		}
		return v;
	}
	
	//should delete user info from DB tables, delete the quizzes they made, and delete their name from friends lists of their friends
	public void deleteUserAccount(String username) {
		UserDatabase udb = new UserDatabase(); 
		udb.deleteAccount(username);	
	}
	
	public Vector<Message> getMessages(int type) {
		MessageDatabase mdb = new MessageDatabase();
		Vector<Message> vm = mdb.getInboxMessages(this.username, type);
		return vm;
	}
	public Vector<Message> getAnnounce() {
		MessageDatabase mdb = new MessageDatabase();
		Vector<Message> vm = mdb.getAnnouncements();
		return vm;
	}
	
}
