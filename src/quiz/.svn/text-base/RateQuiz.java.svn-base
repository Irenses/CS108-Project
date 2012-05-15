package quiz;

import java.io.IOException;
import user.*;
import database.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RateQuiz
 */
@WebServlet("/RateQuiz")
public class RateQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RateQuiz() {
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
		HttpSession session = request.getSession();

		Integer quizID = Integer.parseInt(request.getParameter("quizID"));
		QuizDatabase qdb = new QuizDatabase();
		Quiz quiz = qdb.ReconstructQuiz(quizID);
		quiz.addRating(((User)session.getAttribute("user")).getUsername(), quizID, Integer.parseInt(request.getParameter("rating")));
		RequestDispatcher dispatch = request.getRequestDispatcher("quiz.jsp?id=" + quizID);
		dispatch.forward(request, response);
	}

}
