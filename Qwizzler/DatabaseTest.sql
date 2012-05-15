USE c_cs108_seantana;

DROP TABLE IF EXISTS quizInfo;

DROP TABLE IF EXISTS qr;
DROP TABLE IF EXISTS fitb;
DROP TABLE IF EXISTS mc;
DROP TABLE IF EXISTS pr;
DROP TABLE IF EXISTS ma;
DROP TABLE IF EXISTS mu;
DROP TABLE IF EXISTS mr;

DROP TABLE IF EXISTS quizMap;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS numQuestions;
DROP TABLE IF EXISTS quizScores;

CREATE TABLE quizInfo (
	quizID INT,
	name CHAR(64),
	description CHAR(255),
	creator CHAR(16),
	random BOOLEAN,
	onePage BOOLEAN,
	immediateFeedback BOOLEAN,
	practice BOOLEAN,
	timeCreated TIMESTAMP
);

CREATE TABLE qr (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE fitb (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE mc (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE pr (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE ma (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE mr (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE mu (
	quizID INT,
	questionID INT,
	componentID INT,
	question CHAR(128)
);

CREATE TABLE quizMap (
	quizID INT,
	questionID INT,
	type CHAR(4)
);

CREATE TABLE answers (
	quizID INT,
	questionID INT,
	answerID INT,
	answer CHAR(128)
);

CREATE TABLE numQuestions (
	quizID INT,
	numQuestions INT
);

CREATE TABLE quizScores (
	quizID INT,
	username char(16),
	score INT,
	totalTime DOUBLE,
	timeStamp TIMESTAMP
);


INSERT INTO quizInfo VALUES
	(100, "MultiPageTest", "Multipage test quiz", "Sean", true, false, false, true, "2012-03-10 12:00:00"),
	(0, "Test1", "This quiz has five questions and covers 4 basic question types", "Sean", true, false, false, true, "2012-02-01 12:00:00"),
	(1, "Test2", "Some more testing questions", "Sean", false, true, true, false, "2012-02-15 12:00:00");
	
INSERT INTO qr VALUES
	(0, 0, 0, "Who is the president?"),
	(0, 4, 0, "What's my name?"),
	(1, 1, 0, "Can you teach me how to Dougie?");

INSERT INTO fitb VALUES
	(0, 1, 0, "We are in the"),
	(0, 1, 1, "fraternity"),
	(1, 0, 0, "Kyle's last name is");
	
INSERT INTO mc VALUES
	(0, 2, 0, "2 + 2 = "),
	(0, 2, 1, "3"),
	(0, 2, 2, "5"),
	(0, 2, 3, "4"),
	(0, 2, 4, "Spongebob"),
	(1, 2, 0, "Joaquin is a lame-o"),
	(1, 2, 1, "True"),
	(1, 2, 2, "False");

INSERT INTO pr VALUES
	(100, 0, 0, "http://www.bankownedproperties.org/images/maps/california.gif"),
	(100, 1, 0, "http://alabamamaps.ua.edu/contemporarymaps/alabama/physical/soils_map.jpg"),
	(100, 2, 0, "http://floridavisitorscenter.org/wp-content/uploads/2010/12/regional-imap.gif"),
	(0, 3, 0, "http://i.imgur.com/dSFRk.jpg");
	
INSERT INTO quizMap VALUES
	(100, 0, "pr");
	(100, 1, "pr");
	(100, 2, "pr");
	(0, 0, "qr"),
	(0, 1, "fitb"),
	(0, 2, "mc"),
	(0, 3, "pr"),
	(0, 4, "qr"),
	(1, 1, "qr"),
	(1, 2, "mc"),
	(1, 0, "fitb");

INSERT INTO answers VALUES
	(100, 0, 0, "california"),
	(100, 0, 0, "ca"),
	(100, 1, 0, "alabama"),
	(100, 1, 0, "al"),
	(100, 2, 0, "florida"),
	(100, 2, 0, "fl"),
	(0, 0, 0, "barack obama"),
	(0, 0, 0, "barack"),
	(0, 0, 0, "obama"),
	(0, 1, 0, "phi kappa psi"),
	(0, 1, 0, "phi psi"),
	(0, 2, 0, "d"),
	(0, 3, 0, "scorpion"),
	(0, 3, 0, "nightmare"),
	(0, 4, 0, "sean"),
	(1, 0, 0, "dumovic"),
	(1, 1, 0, "yes"),
	(1, 2, 0, "b");

INSERT INTO numQuestions VALUES
	(100, 3),
	(0, 5),
	(1, 3);
	
INSERT INTO quizScores VALUES
	(0, "Joaquin", 10, 2, "2012-03-01 12:00:00"),
	(0, "Sean", 9, 2.25, "2012-03-05 15:00:00"),
	(0, "James", 10, 1.75, "2012-03-04 02:00:00");
	