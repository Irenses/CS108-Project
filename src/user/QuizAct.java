package user;

import java.sql.Timestamp;

public class QuizAct {
	
	private String name;
	private int id;
	private Timestamp time;
	private String desc;
	
	public QuizAct(String name, int id, Timestamp time) {
		this.name = name;
		this.id = id;
		this.time = time;
	}
	
	public QuizAct(String name, int id, String desc) {
		this.name = name;
		this.id = id;
		this.desc = desc;
	}
	
	public String getName() {
		return this.name;
	}
	
	public String getDesc() {
		return this.desc;
	}
	
	public int getID() {
		return this.id;
	}
	
	public Timestamp getTime() {
		return this.time;
	}

}
