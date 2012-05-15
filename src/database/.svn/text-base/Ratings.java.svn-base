package database;

public class Ratings implements Comparable<Ratings>{
	private String name;
	private double numplayed;

	public Ratings(String name, double numplayed){
		this.name = name;
		this.numplayed = numplayed;
	}
	
	public String getName(){
		return name;
	}
	
	public double getNumplayed(){
		return numplayed;
	}

	@Override
	public int compareTo(Ratings o) {
		if (this.numplayed < o.getNumplayed()) return 1;
		else return -1;
	}

}
