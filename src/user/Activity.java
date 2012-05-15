package user;

import java.sql.Timestamp;

public class Activity implements Comparable<Activity> {
	
	private Timestamp time;
	private int type;//0 for quiz made, 1 for quiz taken, 2 for achievement earned
	private String name;
	private int id;//>=0 for quizzes, -1 for achievements
	private String user;
	
	public Activity(Timestamp t, int i, String n, int d) {
		this.time = t;
		this.type = i;
		this.name = n;
		this.id = d;
		this.user = null;
	}
	
	//used for friends activities
	public Activity(Timestamp t, int i, String n, int d, String user) {
		this.time = t;
		this.type = i;
		this.name = n;
		this.id = d;
		this.user = user;
	}
	
	public Timestamp getTime() {
		return this.time;
	}
	
	public int getType() {
		return this.type;
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getID() {
		return this.id;
	}
	
	public String getUser() {
		return this.user;
	}
	

	@Override
	public int compareTo(Activity arg0) {
		return -1*this.time.compareTo(arg0.getTime());
	}

}