package quiz;

import java.io.IOException;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.QuizDatabase;

@WebServlet("/AddFITBQuestion")
public class AddFITBQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddFITBQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer curchoice = Integer.parseInt(request.getParameter("numchoice"));
		String[] question = new String[2];
		
		int error = 0;
		if(request.getParameter("question1").equals("") || request.getParameter("question2").equals("")) error = 1;
		question[0] = request.getParameter("question1");
		question[1] = request.getParameter("question2");
		Vector<String> q = Quiz.convertToVector(question);
		
		String[] answer = new String[curchoice];
		for(int i = 0; i < curchoice; i++){
			Integer cur = i;
			if(request.getParameter(cur.toString()).equals("")) error = 1;
			answer[i] = request.getParameter(cur.toString().toLowerCase());
		}
		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		
		if(error == 1){
			request.setAttribute("error", "1");
			RequestDispatcher dispatch = request.getRequestDispatcher("addFITB.jsp");
			dispatch.forward(request, response);
		}else{
			
			Vector<String> apre = Quiz.convertToVector(answer);
			Vector<Vector<String> > a = new Vector<Vector<String> >();
			a.add(apre);
			
			QuizDatabase qdb = new QuizDatabase();
			
			qdb.addQuestion(id, "fitb", q, a);
			
			RequestDispatcher dispatch = request.getRequestDispatcher("questionAdded.jsp");
			dispatch.forward(request, response);
		}
	}

}
