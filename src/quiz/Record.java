package quiz;


public class Record implements Comparable<Record>{
	private int quizID;
	private String quizName;
	private String user;
	private int score;
	private double time;
	private long start; //Start time of a player playing the quiz.
	
	public Record(String user, int score, double time, long start){
		this.user = user;
		this.score = score;
		this.time = time;
		this.start = start;
	}
	
	public Record(int quizID, String quizName, String user, int score, double time, long start) {
		this.quizID = quizID;
		this.quizName = quizName;
		this.user = user;
		this.score = score;
		this.time = time;
		this.start = start;
	}
	
	public String getUser(){
		return user;
	}
	
	public int getScore(){
		return score;
	}
	
	public void setScore(int newscore){
		score = newscore;
	}
	
	public double getTime(){
		return time;
	}

	public long getStart(){
		return start;
	}
	
	public int getQuizID() {
		return quizID;
	}
	
	public String getQuizName() {
		return quizName;
	}
	
	public int compareTo(Record o) {
		if (this.score > o.getScore()) return -1;
		else if (this.score == o.getScore() && this.time < o.getTime()) return -1;
		return 1;
	}

	
}
