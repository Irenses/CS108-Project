package user;


public enum Achievement {	
	
	TOP_SCORE (0,"I am the GREATEST!","Had the highest score for a qwiz.","flag.png"),
	//		   ^ID		^Achievement name		^Achievement Description	^achievement picture filename
	TAKE_ONE (10, "Qwiz Newbie","Took a qwiz.","glass.png"),
	TAKE_FIVE (11,"Qwiz Regular" ,"Took five qwizzes.","hat.png"),
	TAKE_TEN (12,"Qwiz Machine" ,"Took ten qwizzes.","star.png"),
	//		  ^ IDS are structured this way in case we want to add more levels to each type, may also allow simple incrementing (up to a point) to get the next one
	
	MAKE_ONE (20,"Amateur Author" ,"Created a qwiz.","write.png"),
	MAKE_FIVE (21,"Prolific Author" ,"Created five qwizzes.","write5.png"),
	MAKE_TEN (22,"Prodigious Author" ,"Created ten qwizzes.","write10.png"),
	PRACTICE_ONE (30, "Practice Makes Perfect", "Took a qwiz in practice mode.","time.png");
	
	/* individual I-Vars */
	private final int id;
	private final String achievement;
	private final String description;
	private final String picture;
	
	
	/** Constructor **/
	Achievement(int id, String name, String d, String pic) {
		this.id = id;
		this.achievement = name;
		this.description = d;
		this.picture = pic;	//picture file location w/in project
	}
	
	public static Achievement getAchievement(int id) {
		switch (id) {
		case 0: return TOP_SCORE;
		case 10: return TAKE_ONE;
		case 11: return TAKE_FIVE;
		case 12: return TAKE_TEN;
		case 20: return MAKE_ONE;
		case 21: return MAKE_FIVE;
		case 22: return MAKE_TEN;
		case 30: return PRACTICE_ONE;
		default: return null;
		}
	}
	
	//********************************************************************************
	//* In order to access all the items of this class, you can do something like:   *
	//*																				 *
	//*   for (Achievement a : Achievement.values()) {								 *
	//*            //code to access individual achievement info						 *
	//*        }																	 *
	//* 		 																	 *
	//* AND this class probably isn't completely finished yet, FYI					 *
	//*																				 *
	//* And to add an individual achievement ID to the user's achievements one can	 *
	//* probable just hardcode in that specific ID where a check is done to see 	 *
	//* if the requirement is met (IF THERE IS A BETTER WAY, LET ME KNOW)			 *
	//*																				 *
	//********************************************************************************
	
	public int getID() {
		return this.id;
	}
	
	public String getAchievementName() {
		return this.achievement;
	}
	
	public String getDescription() {
		return this.description;
	}
	
	//returns string of picture filename
	public String getPicture() {
		return this.picture;
	}
	
}
