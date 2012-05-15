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

@WebServlet("/AddMCQuestion")
public class AddMCQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddMCQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer curchoice = Integer.parseInt(request.getParameter("numchoice"));
		String[] question = new String[curchoice + 1];
		
		int error = 0;
		if(((String)request.getParameter("question")).equals("")) error = 1;;
		
		question[0] = request.getParameter("question");
		for(int i = 0; i < curchoice; i++){
			Integer cur = i;
			if(request.getParameter(cur.toString()).equals("")) error = 1;
			question[i + 1] = request.getParameter(cur.toString()).toLowerCase();
		}
		Vector<String> q = Quiz.convertToVector(question);
		String[] answer = new String[1];
		if(request.getParameter("answer") == null) error = 1 ;
		
		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		
		if(error == 1){
			request.setAttribute("error", "1");
			RequestDispatcher dispatch = request.getRequestDispatcher("addMC.jsp");
			dispatch.forward(request, response);
		}else{
			answer[0] = request.getParameter("answer").toLowerCase();
			

	
			Vector<String> apre = Quiz.convertToVector(answer);
			Vector<Vector<String> > a = new Vector<Vector<String> >();
			a.add(apre);
			
			QuizDatabase qdb = new QuizDatabase();
			
			qdb.addQuestion(id, "mc", q, a);
			
			RequestDispatcher dispatch = request.getRequestDispatcher("questionAdded.jsp");
			dispatch.forward(request, response);
		}
	}

}
