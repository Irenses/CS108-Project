DROP TABLE IF EXISTS accountInfo;
DROP TABLE IF EXISTS achievements;
DROP TABLE IF EXISTS friends;

CREATE TABLE accountInfo (
	username CHAR(16),
	password CHAR(64),
	fullname CHAR(32),
	email CHAR(32),
<<<<<<< .mine
	isAdmin BOOLEAN,
	timeStamp TIMESTAMP,
=======
	isAdmin BOOLEAN,
	created TIMESTAMP
>>>>>>> .r112
);

CREATE TABLE achievements (
	username CHAR(16),
	achievementID INT
);

CREATE TABLE friends (
	username1 CHAR(16),
	username2 CHAR(16)
);

INSERT INTO accountInfo VALUES
<<<<<<< .mine
	("Sean", "1234", "Sean Tannehill", "seantana@stanford.edu", true, "2012-03-01 12:00:00"),
	("Kyle", "1234", "Kyle Dumovic", "kdumovic@stanford.edu", true, "2012-03-01 12:00:00"),
	("Joaquin", "1234", "Joaquin Carcache", "jmcarcac@stanford.edu", true, "2012-03-01 12:00:00"),
	("James", "1234", "James Liu", "yuqiliu@stanford.edu", true, "2012-03-01 12:00:00"),
	("notAdmin", "1234", "I am not an admin", "notAdmin@isuck.org", false, "2012-03-01 12:00:00");
=======
	("Sean", "1234", "Sean Tannehill", "seantana@stanford.edu", true,69),
	("Kyle", "1234", "Kyle Dumovic", "kdumovic@stanford.edu", true,69),
	("Joaquin", "1234", "Joaquin Carcache", "jmcarcac@stanford.edu", true,69),
	("James", "1234", "James Liu", "yuqiliu@stanford.edu", true,69),
	("notAdmin", "1234", "I am not an admin", "notAdmin@isuck.org", false,69),
	("test", "7110eda4d09e062aa5e4a390b0a572ac0d2c0220", "test account", "test@aol.com", true,69);
>>>>>>> .r112
	
INSERT INTO friends VALUES
	("Sean", "Kyle"),
	("Kyle", "Sean"),
	("Sean", "Joaquin"),
	("Joaquin", "Sean"),
	("Sean", "James"),
	("James", "Sean"),
	("Kyle", "Joaquin"),
	("Joaquin", "Kyle"),
	("Kyle", "James"),
	("James", "Kyle"),
	("Joaquin", "James"),
	("James", "Joaquin");
