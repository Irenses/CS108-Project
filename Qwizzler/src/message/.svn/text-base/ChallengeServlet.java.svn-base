package message;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.MessageDatabase;
import database.QuizDatabase;
import database.UserDatabase;

/**
 * Servlet implementation class ChallengeServlet
 */
@WebServlet("/ChallengeServlet")
public class ChallengeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChallengeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] friends = request.getParameterValues("friend"); 
		ServletContext context = this.getServletContext();
		MessageDatabase mdb = (MessageDatabase) context.getAttribute("messageDBC");	
		UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
		String from = request.getParameter("from");
		int id = Integer.parseInt(request.getParameter("quizID"));
		QuizDatabase qdb = (QuizDatabase) context.getAttribute("quizDBC");
		String name = qdb.getName(id);
		int score = udb.getBestScore(from, id);
		if (score != -1) {
			for (String f : friends) {
				String body = "<a href=\\\"profile.jsp?user=" + from + "\\\">" + from + "</a> has challenged you to beat their score of " + score + " on <a href=\\\"quiz.jsp?id=" + id + "\\\">" + name + "</a>";
				Message m = new Message(from,f,body,1);
				mdb.storeMessage(m);
			}
		}
		RequestDispatcher dispatch = request.getRequestDispatcher("quiz.jsp?id=" + id);
		dispatch.forward(request,response);
	}

}
