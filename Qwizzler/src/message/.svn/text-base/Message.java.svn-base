package message;

import java.util.*;
import java.sql.Timestamp;

public class Message {
	
	private String to;
	private String from;
	private String message;
	private Timestamp messageDate;
	private int messageType;
	
	//NOTE: Announcements make use of restricted global constants for the 'to' and 'from' 
	//fields, which means these names cannot be used in the creation of a normal user account
	//THESE constant vals are: Qwizzler (from) and QwizzlerSite (to)
	public Message (String from, String to, String body, int type) {
		this.from = from;
		this.to = to;
		this.messageDate = null;//new Timestamp(System.currentTimeMillis());
		this.message = body;
		this.messageType = type;
	}
	
	public Message(String from, String to, String body, int type, Timestamp t) {
		this.from = from;
		this.to = to;
		this.messageDate = t;
		this.message = body;
		this.messageType = type;
	}
	
	/*Returns strings that serve as 'subject' lines of a message when displayed*/
	public String getTypeName() {
		switch (messageType) {
		case 1: return "Qwiz Challenge";
		case 2: return "Friend Request";
		case 3: return "Note";
		case 4: return "Announcement";
		default: return "";
		}
	}
	
	public int getType() {
		return this.messageType;
	}
	
	//***********************************************************************************************
	//* EXAMPLE: for retrieving the body of a quiz challenge(which should link						*
	//* to the quiz page) the body of the challenge should be set to include						*
	//* HTML tags that will display correctly when pasted directly into a webpage					*
	//* [NOTE: we probably also want to link the sender's profile page in all message-types]		*
	//* i.e.																						*
	//* 	"<a href=\"profile.jsp?user=USERNAME\">USERNAME</a> has challenged you to beat their 	*
	//* 	score of USERSCORE in <a href=\"quiz.jsp?id=QUIZNAME\">QUIZNAME</a>." 					*
	//*	would be the string passed in as the body for a challenge,									*
	//*																								*
	//* 	"<a href=\"profile.jsp?user=USERNAME\">USERNAME</a> want to be your friend.  			*
	//* 	<a href=\"acceptFriendRequest.jsp">Accept?</a>											*
	//*	for a friend request, and																	*
	//*																								*
	//* 	"<a href=\"profile.jsp?user=USERNAME\">USERNAME</a> sent you a note: \n NOTE CONTENT"	*
	//*	for a note																					*
	//*																								*
	//* where the creator has hardcoded the names and stuff	into the appropriate					*
	//* spot after calling methods on local objects													*
	//*																								*
	//*	[NOTE: THE ABOVE WERE JUST EXAMPLES OF WHAT THE LINKS MIGHT BE FORMED AS, but whoever 		*
	//* develops the JSPs or whatever will finalize it and decide on GET v. POST stuff]				*
	//***********************************************************************************************
	
	public String getBody() {
		return this.message;
	}
	
	public String getTo() {
		return this.to;
	}
	
	public String getFrom() {
		return this.from;
	}
	
	public Timestamp getDate() {
		return this.messageDate;
	}

}
