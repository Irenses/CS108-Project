package quiz;

public class Score {
	private int quizID;
	private String username;
	private int score;
	private String time;
	
	public Score(int q, String u, int s, String t) {
		quizID = q;
		username = u;
		score = s;
		time = t;
	}
	
	public int getQuizID() {
		return quizID;
	}
	
	public String getUsername() {
		return username;
	}
	
	public int getScore() {
		return score;
	}
	
	public String getTime() {
		return time;
	}
}
