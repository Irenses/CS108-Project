package database;
import message.*;
import java.util.*;
import java.sql.*;

public class MessageDatabase {
	private DBConnection con;

	public static String MESSAGES = "messages";
	
	public MessageDatabase() {
		con = DBConnection.getSharedConnection();
	}
	
	/**
	 * Puts a message in the database
	 * Note: the timestamp will be stored as the current time at which this
	 * method is called.
	 */
	public void storeMessage(String from, String to, String message, int messageType, String timestamp) {
		con.updateDB("INSERT INTO " + MESSAGES + " VALUES ( \"" + from + "\", \"" + to + "\", \"" + message + "\", " + null + ", " + messageType + ")");
	}
	
	/**
	 * Puts a message in the database
	 * Note: the timestamp will be stored as the current time at which this
	 * method is called.
	 */
	public void storeMessage(Message message) {
		con.updateDB("INSERT INTO " + MESSAGES + " VALUES ( \"" + message.getFrom() + "\", \"" + message.getTo() + "\", \"" + message.getBody() + "\", " + null + ", " + message.getType() + ")");
	}
	
	/*
	 * Returns a Vector representing all messages in the user's inbox.  The most recent
	 * messages are at the beginning, and the oldest ones are at the end.
	 */
	public Vector<Message> getInboxMessages(String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + MESSAGES + " WHERE toName = \"" + username + "\" ORDER BY timeStamp DESC");
		Vector<Message> inbox = new Vector<Message>();
		try {
			while (rs.next()) {
				inbox.add(new Message(rs.getString("fromName"), username, rs.getString("message"), rs.getInt("messageType"), rs.getTimestamp("timeStamp")));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in MessageDatabase::getInboxMessages");
		}
		return inbox;
	}
	
	/*
	 * Returns a Vector representing all messages in the user's outbox.  The most recent
	 * messages are at the beginning, and the oldest ones are at the end.
	 */
	public Vector<Message> getOutboxMessages(String username) {
		ResultSet rs = con.queryDB("SELECT * FROM " + MESSAGES + " WHERE fromName = \"" + username + "\" ORDER BY timeStamp DESC");
		Vector<Message> outbox = new Vector<Message>();
		try {
			while (rs.next()) {
				outbox.add(new Message(username, rs.getString("toName"), rs.getString("message"), rs.getInt("messageType"), rs.getTimestamp("timeStamp")));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in MessageDatabase::getOutboxMessages");
		}
		return outbox;
	}
	
	public Vector<Message> getAnnouncements() {
		return getInboxMessages("Qwizzler");
	}
	
	public Vector<Message> getInboxMessages(String username, int type) {
		if (type == 4) username = "Qwizzler";
		ResultSet rs = con.queryDB("SELECT * FROM " + MESSAGES + " WHERE toName = \"" + username + "\" AND messageType = " + type + " ORDER BY timeStamp DESC");
		Vector<Message> inbox = new Vector<Message>();
		try {
			while (rs.next()) {
				inbox.add(new Message(rs.getString("fromName"), username, rs.getString("message"), rs.getInt("messageType"), rs.getTimestamp("timeStamp")));
			}
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in MessageDatabase::getInboxMessages");
		}
		return inbox;
	}
	
	public boolean containsFriendRequest(String from, String to) {
		ResultSet rs = con.queryDB("SELECT * FROM " + MESSAGES + " WHERE fromName = \"" + from + "\" AND toName = \"" + to + "\" AND messageType = 2");
		try {
			if (rs.next()) return true;
		}
		catch (SQLException e) {
			throw new RuntimeException("SQLException in MessageDatabase::containsFriendRequest");
		}
		return false;
	}
}
