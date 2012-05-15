package quiz;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Vector;

import org.junit.*;


import junit.framework.TestCase;


public class QuizTest extends TestCase {
	@Test
	public void testSample1() {
		Quiz qz = new Quiz("Q1", "My quiz", "James", 1, "", false, true, true, true);
		
		
		//Quiz Set up
		Vector<String> q1 = new Vector<String>();
		Vector<String> q2 = new Vector<String>();
		Vector<String> q3 = new Vector<String>();
		Vector<String> q4 = new Vector<String>();
		Vector<String> q5 = new Vector<String>();

		
		Vector<Vector<String> > ans1 = new Vector<Vector<String> >();
		Vector<Vector<String> > ans2 = new Vector<Vector<String> >();
		Vector<Vector<String> > ans3 = new Vector<Vector<String> >();
		Vector<Vector<String> > ans4 = new Vector<Vector<String> >();
		Vector<Vector<String> > ans5 = new Vector<Vector<String> >();

		q1.add("MC: The first letter?");
		q1.add("A: A");
		q1.add("B: B");
		q1.add("C: C");
		q1.add("D: D");

		q2.add("QR: Who's the Greatest NBA Player?");
		
		q3.add("MR: First 3 letters?");
		
		q4.add("MU: Name 3 large cities in China.");
		
		q5.add("MA: States in the US?");
		q5.add("1. CA");
		q5.add("2. AL");
		q5.add("3. BJ");
		q5.add("4. SH");

		Vector<String> ans11 = new Vector<String>();
		ans11.add("A");
		ans1.add(ans11);
		
		Vector<String> ans21 = new Vector<String>();
		ans21.add("James");
		ans21.add("LeBron James");
		ans21.add("L.James");
		ans2.add(ans21);
		
		Vector<String> ans31 = new Vector<String>();
		ans31.add("A");
		ans31.add("a");
		ans3.add(ans31);
		Vector<String> ans32 = new Vector<String>();
		ans32.add("B");
		ans32.add("b");
		ans3.add(ans32);
		Vector<String> ans33 = new Vector<String>();
		ans33.add("C");
		ans33.add("c");
		ans3.add(ans33);
		
		Vector<String> ans41 = new Vector<String>();
		ans41.add("BJ");
		ans41.add("Beijing");
		ans4.add(ans41);
		Vector<String> ans42 = new Vector<String>();
		ans42.add("SH");
		ans42.add("Shanghai");
		ans4.add(ans42);
		Vector<String> ans43 = new Vector<String>();
		ans43.add("GZ");
		ans43.add("Guangzhou");
		ans4.add(ans43);
		Vector<String> ans44 = new Vector<String>();
		ans43.add("SZ");
		ans43.add("Shenzhen");
		ans4.add(ans44);
		
		Vector<String> ans51 = new Vector<String>();
		ans51.add("1");
		ans5.add(ans51);
		Vector<String> ans52 = new Vector<String>();
		ans52.add("2");
		ans5.add(ans52);
		
		qz.addQuestion(0, "MC", q1, ans1);
		qz.addQuestion(1, "QR", q2, ans2);
		qz.addQuestion(2, "MR", q3, ans3);
		qz.addQuestion(3, "MU", q4, ans4);
		qz.addQuestion(4, "MA", q5, ans5);
		
		//User Answer
		Vector<String> uans1 = new Vector<String>();
		uans1.add("A");
		
		Vector<String> uans2 = new Vector<String>();
		uans2.add("L.James");
		
		Vector<String> uans3 = new Vector<String>();
		uans3.add("A");
		uans3.add("B");
		uans3.add("C");
		
		Vector<String> uans4 = new Vector<String>();
		uans4.add("GZ");
		uans4.add("Beijing");
		uans4.add("SH");
		
		Vector<String> uans5 = new Vector<String>();
		uans5.add("1");
		uans5.add("2");
		
		Vector<Vector<String> > useranswers = new Vector<Vector<String> >();
		useranswers.add(uans1);
		useranswers.add(uans2);
		useranswers.add(uans3);
		useranswers.add(uans4);
		useranswers.add(uans5);

		


		Vector<String> uuans1 = new Vector<String>();
		uuans1.add("A");
		
		Vector<String> uuans2 = new Vector<String>();
		uuans2.add("Kobe");
		
		Vector<String> uuans3 = new Vector<String>();
		uuans3.add("A");
		uuans3.add("B");
		uuans3.add("C");
		
		Vector<String> uuans4 = new Vector<String>();
		uuans4.add("BJ");
		uuans4.add("Beijing");
		uuans4.add("FL");
		
		Vector<String> uuans5 = new Vector<String>();
		uuans5.add("2");
		uuans5.add("1");
		
		Vector<Vector<String> > uuseranswers = new Vector<Vector<String> >();
		uuseranswers.add(uuans1);
		uuseranswers.add(uuans2);
		uuseranswers.add(uuans3);
		uuseranswers.add(uuans4);
		uuseranswers.add(uuans5);
		

		
		Vector<Record> records = qz.getHighest(3);
		Record rec0 = records.get(0);
		Record rec1 = records.get(1);
		System.out.println(records.size());
		System.out.println("User: " + rec0.getUser() + " Score: " + rec0.getScore() + " Time: " + rec0.getTime());
		System.out.println("User: " + rec1.getUser() + " Score: " + rec1.getScore() + " Time: " + rec1.getTime());
		
		/*ArrayList<String> ans = new ArrayList<String>();
		ans.add("1");
		ans.add("2");
		ans.add("3");

		ArrayList<String> ans3 = new ArrayList<String>();
		ans3.add("0");
		ans3.add("2");
		ans3.add("3");
		ans3.add("4");
		
		HashSet<String> aset1 = new HashSet<String>();
		aset1.add("Me");
		aset1.add("me");
		
		HashSet<String> aset2 = new HashSet<String>();
		aset2.add("Here");
		
		qz.addQRQuestion("Who?", aset1);
		qz.addQRQuestion("Where", aset2);
		qz.addMRQuestion("First 3 integer", ans);
		
		ArrayList<Object> useranswers = new ArrayList<Object>();
		useranswers.add("Me");
		useranswers.add("He");
		useranswers.add(ans3);	
		
		assertEquals(1, qz.checkAnswer(0, "Me"));
		assertEquals(0, qz.checkAnswer(1, "Me"));
		assertEquals(3, qz.checkAnswer(2, ans));
		assertEquals(2, qz.checkAnswer(2, ans3));
		
		qz.solve("James", useranswers);
		
		qz.startSolve("LeBron");
		
		ArrayList<Object> useranswers2 = new ArrayList<Object>();
		useranswers2.add("Me");
		useranswers2.add("Here");
		useranswers2.add(ans);	
		
		qz.solve("LeBron", useranswers2);
		*/
		
		/*
		ArrayList<String> ans = new ArrayList<String>();
		ans.add("Me");
		ArrayList<String> myans1 = new ArrayList<String>();
		myans1.add("Me");
		ArrayList<String> myans2 = new ArrayList<String>();
		myans2.add("Mess");
		HashSet<String> aset1 = new HashSet<String>();
		aset1.add("Me");
		aset1.add("me");
		QRQuestion q1 = new QRQuestion("Who?", aset1);
		assertEquals(1, q1.checkAnswer("Me"));
		assertEquals(0, q1.checkAnswer("met"));
		*/

	}
	
	/*
	@Test
	public void testSample2() {
		Quiz qz = new Quiz("My quiz", "James", 1, false, true, true, true);
		
		qz.startSolve("James");
		
		ArrayList<String> ans1 = new ArrayList<String>();
		ans1.add("Me");
		ArrayList<String> ans2 = new ArrayList<String>();
		ans2.add("Here");
		
		ArrayList<String> ans = new ArrayList<String>();
		ans.add("1");
		ans.add("2");
		ans.add("3");

		ArrayList<String> ans3 = new ArrayList<String>();
		ans3.add("0");
		ans3.add("2");
		ans3.add("3");
		ans3.add("4");
		
		HashSet<String> aset1 = new HashSet<String>();
		aset1.add("Me");
		aset1.add("me");
		
		HashSet<String> aset2 = new HashSet<String>();
		aset2.add("Here");
		
		qz.addQRQuestion("Who?", aset1);
		qz.addQRQuestion("Where", aset2);
		qz.addMRQuestion("First 3 integer", ans);
		
		ArrayList<Object> useranswers = new ArrayList<Object>();
		useranswers.add("Me");
		useranswers.add("He");
		useranswers.add(ans3);	
		
		assertEquals(1, qz.checkAnswer(0, "Me"));
		assertEquals(0, qz.checkAnswer(1, "Me"));
		assertEquals(3, qz.checkAnswer(2, ans));
		assertEquals(2, qz.checkAnswer(2, ans3));
		
		qz.solve("James", useranswers);
		
		qz.startSolve("LeBron");
		
		ArrayList<Object> useranswers2 = new ArrayList<Object>();
		useranswers2.add("Me");
		useranswers2.add("Here");
		useranswers2.add(ans);	
		
		qz.solve("LeBron", useranswers2);
		
		ArrayList<Record> records = qz.getRecords();
		Record rec0 = records.get(0);
		Record rec1 = records.get(1);
	}
	
	/*
	@Test
	public void testSample3() {
		Quiz qz = new Quiz("My quiz", "James", 1, false, true, true, true);
		qz.setUpRandomQuestion();

		qz.startSolve("James");
		
		ArrayList<String> ans1 = new ArrayList<String>();
		ans1.add("Me");
		ArrayList<String> ans2 = new ArrayList<String>();
		ans2.add("Here");
		
		ArrayList<String> ans = new ArrayList<String>();
		ans.add("1");
		ans.add("2");
		ans.add("3");

		ArrayList<String> ans3 = new ArrayList<String>();

		ans3.add("BJ");
		ans3.add("BJ");
		ans3.add("SZ");
		
		HashSet<String> aset1 = new HashSet<String>();
		aset1.add("Me");
		aset1.add("me");
		
		HashSet<String> aset2 = new HashSet<String>();
		aset2.add("Here");
		
		HashSet<String> un = new HashSet<String>();
		un.add("BJ");
		un.add("SH");
		un.add("SZ");
		un.add("GZ");
		
		HashSet<Integer> ma = new HashSet<Integer>();
		ma.add(1);
		ma.add(3);
		
		qz.addQRQuestion("Who?", aset1);
		qz.addQRQuestion("Where", aset2);
		qz.addMCQuestion("First letter?", "A");
		//qz.addMRQuestion("First 3 integer", ans);
		qz.addMUQuestion("Large city in China?", 3, un);
		//qz.addMAQuestion("First two odd numbers?", ma);
		
		ArrayList<Object> useranswers = new ArrayList<Object>();
		useranswers.add("Me");
		useranswers.add("Here");
		useranswers.add("A");
		useranswers.add(ans3);	
		
		assertEquals(1, qz.checkAnswer(0, "Me"));
		assertEquals(0, qz.checkAnswer(1, "Me"));
		//assertEquals(3, qz.checkAnswer(2, ans));
		//assertEquals(2, qz.checkAnswer(2, ans3));
		
		qz.solve("James", useranswers);
		
		qz.startSolve("LeBron");
		
		ArrayList<Object> useranswers2 = new ArrayList<Object>();
		useranswers2.add("Me");
		useranswers2.add("Here");
		useranswers2.add("C");
		useranswers2.add(ans);	
		
		qz.solve("LeBron", useranswers2);
		
		qz.startSolve("Kobe");
		
		ArrayList<Object> useranswers3 = new ArrayList<Object>();
		useranswers3.add("He");
		useranswers3.add("Pere");
		useranswers3.add("C");
		useranswers3.add(ans3);	
		
		qz.solve("Kobe", useranswers3);
		
		qz.startSolve("Kobe");
		
		qz.solve("Kobe", useranswers3);
		
		qz.startSolve("James");
		
		qz.solve("James", useranswers3);
		
		qz.startSolve("James");
		
		qz.setUpRandomQuestion();
		for(int i = 0; i < qz.getQuestions().size(); i++){
			System.out.println(qz.getRandomQuestion());
		}
		
		qz.solve("James", useranswers3);
		ArrayList<Record> records = qz.getHighest(3);
		Record rec0 = records.get(0);
		Record rec1 = records.get(1);
		Record rec2 = records.get(2);
		System.out.println(records.size());
		System.out.println(rec0.getUser() + rec0.getScore() + rec0.getTime());
		System.out.println(rec1.getUser() + rec1.getScore() + rec1.getTime());
		System.out.println(rec2.getUser() + rec2.getScore() + rec2.getTime());
		qz.display();
	}
	
	@Test
	public void testRandom() {
		Quiz qz = new Quiz("My quiz", "James", 1, true, true, true, true);

		qz.startSolve("Jamess");
		
		ArrayList<String> ans1 = new ArrayList<String>();
		ans1.add("Me");
		ArrayList<String> ans2 = new ArrayList<String>();
		ans2.add("Here");
		
		ArrayList<String> ans = new ArrayList<String>();
		ans.add("1");
		ans.add("2");
		ans.add("3");

		ArrayList<String> ans3 = new ArrayList<String>();
		ans3.add("0");
		ans3.add("2");
		ans3.add("3");
		ans3.add("4");
		
		HashSet<String> aset1 = new HashSet<String>();
		aset1.add("Me");
		aset1.add("me");
		
		HashSet<String> aset2 = new HashSet<String>();
		aset2.add("Here");
		
		qz.addQRQuestion("Who?", aset1);
		qz.addQRQuestion("Where", aset2);
		qz.addMCQuestion("First letter?", "A");
		//qz.addMRQuestion("First 3 integer", ans);
		
		qz.setUpRandomQuestion();

		ArrayList<Object> useranswers = new ArrayList<Object>();
		useranswers.add("Me");
		useranswers.add("Here");
		useranswers.add("A");
		useranswers.add(ans3);	
		
		assertEquals(1, qz.checkAnswer(0, "Me"));
		assertEquals(0, qz.checkAnswer(1, "Me"));
		//assertEquals(3, qz.checkAnswer(2, ans));
		//assertEquals(2, qz.checkAnswer(2, ans3));
		
		qz.solve("Jamess", useranswers);
		
		qz.startSolve("LeBron");
		
		ArrayList<Object> useranswers2 = new ArrayList<Object>();
		useranswers2.add("Me");
		useranswers2.add("Here");
		useranswers2.add("C");
		useranswers2.add(ans);	
		
		qz.solve("LeBron", useranswers2);


		
		qz.startSolve("James");
		
		qz.setUpRandomQuestion();
		for(int i = 0; i < qz.getQuestions().size(); i++){
			System.out.println(qz.getRandomQuestion());
		}
		
		qz.solve("James", useranswers);
		ArrayList<Record> records = qz.getSelf("James");
		Record rec0 = records.get(0);
		//Record rec1 = records.get(1);
		System.out.println(records.size());
		System.out.println(rec0.getUser() + rec0.getScore() + rec0.getTime());
		//System.out.println(rec1.getStart() + rec1.getUser() + rec1.getScore() + rec1.getTime());
	}
	*/
}
