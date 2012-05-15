package database;

public class Popular implements Comparable<Popular>{
	private String name;
	private int numplayed;

	public Popular(String name, int numplayed){
		this.name = name;
		this.numplayed = numplayed;
	}
	
	public String getName(){
		return name;
	}
	
	public int getNumplayed(){
		return numplayed;
	}

	@Override
	public int compareTo(Popular o) {
		if (this.numplayed < o.getNumplayed()) return 1;
		else return -1;
	}

}
