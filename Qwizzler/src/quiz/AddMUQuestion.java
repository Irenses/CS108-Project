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

@WebServlet("/AddMUQuestion")
public class AddMUQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddMUQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer curchoice = Integer.parseInt(request.getParameter("numchoice"));
		Integer numblank = Integer.parseInt(request.getParameter("numblank"));
		String[] question = new String[numblank + 1];
		
		int error = 0;
		for(int i = 0; i <= numblank; i++){
			if(request.getParameter("question" + i).equals("")) error = 1;
			question[i] = request.getParameter("question" + i);
		}
		Vector<String> q = Quiz.convertToVector(question);
		
		Vector<Vector<String> > a = new Vector<Vector<String> >();

		for(int i = 0; i < curchoice; i++){
			Integer cur = i;
			if(request.getParameter(cur.toString()).equals("")) error = 1;
			Vector<String> apre = new Vector<String>();
			apre.add(request.getParameter(cur.toString()).toLowerCase());
			a.add(apre);
		}
		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		
		if(error == 1){
			request.setAttribute("error", "1");
			request.setAttribute("numblank", Integer.parseInt(request.getParameter("numblank")));
			RequestDispatcher dispatch = request.getRequestDispatcher("addMU.jsp");
			dispatch.forward(request, response);
		}else{			
			QuizDatabase qdb = new QuizDatabase();
			
			qdb.addQuestion(id, "mu", q, a);
			
			RequestDispatcher dispatch = request.getRequestDispatcher("questionAdded.jsp");
			dispatch.forward(request, response);
		}
	}

}
