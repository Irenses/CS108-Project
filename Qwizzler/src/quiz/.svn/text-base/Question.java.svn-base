package quiz;

import java.util.*;

import database.QuizDatabase;

public class Question extends Object {
	private int score = 0;
	private String type;
	private Vector<String> question;
	private int id;
	private Vector<Vector<String> > answers = new Vector<Vector<String> >();
	
	public Question(String type, int id, Vector<String> question, Vector<Vector<String> > answers){
		this.id = id;
		this.type = type;
		this.question = question;
		this.answers = answers;
	}
	
	/*Get the score earned in this question
	 */
	public int getScore(){
		return score;
	}
	
	public int getNumAnswer(){
		return answers.size();
	}
	
	/*Get the type of this question
	 */
	public String getType(){
		return type;
	}
	
	public int getID() {
		return id;
	}
	
	public Vector<String> getQuestion(){
		return question;
	}
	
	/*Checks the String answer against the stored answers.
	 *Returns the score getting in this question.
	 */
	public int checkAnswer(Vector<String> useranswers){
		if(getType().equals(QuizDatabase.MULTIPLE_CHOICE) || getType().equals(QuizDatabase.QUESTION_RESPONSE) || getType().equals(QuizDatabase.PICTURE_RESPONSE) || getType().equals(QuizDatabase.FILL_IN_THE_BLANK)){
			int count = 0;
			String useransweri = useranswers.get(0);
			if(useransweri == null || useransweri.equals("")) return 0;
			if(answers.get(0).contains(useransweri)) count++;	
			return count;
		}else if(getType().equals(QuizDatabase.MULTI_ORDERED_RESPONSE)){
			int count = 0;
			for(int i = 0; i < answers.size(); i++){
				if(useranswers.size() > i && useranswers.get(i) != null && !useranswers.get(i).equals("") && answers.get(i).contains(useranswers.get(i))) count++;
			}
			return count;
		}else if (getType().equals(QuizDatabase.MULTI_UNORDERED_RESPONSE)  || getType().equals(QuizDatabase.MULTIPLE_ANSWER)){
			Vector<Vector<String> > ansrep = new Vector<Vector<String> >();
			for(int i = 0; i < answers.size(); i++){
				Vector<String> temp = new Vector<String>();
				for(int j = 0; j < answers.get(i).size(); j++){
					temp.add(answers.get(i).get(j));
				}
				ansrep.add(temp);
			}
			int count = 0;
			for(int i = 0; i < useranswers.size(); i++){
				int record = -1;
				int length = ansrep.size();
				for(int j = 0; j < length; j++){
					String useransweri = useranswers.get(i);
					if(useransweri != null && !useransweri.equals("") && ansrep.get(j).contains(useransweri)){
						count++;
						record = j;
					}
				}
				if(record != -1) ansrep.remove(record);
			}
			return count;
		}
		return 0;
	}
	
	public String getAnswer(){
		StringBuilder sb = new StringBuilder();
		for(int i = 0; i < answers.size(); i++){
			sb.append("\n" + (i + 1) + ". ");
			for(int j = 0; j < answers.get(i).size(); j++){
				if (j > 0)
					sb.append(", or ");
				sb.append(answers.get(i).get(j));
			}
		}		
		return sb.toString();
		
	}
}
