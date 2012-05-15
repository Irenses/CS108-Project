package quiz;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import user.User;
import database.QuizDatabase;

@WebServlet("/CreateQuiz")
public class CreateQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateQuiz() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		QuizDatabase qdb = new QuizDatabase();
		
		boolean random = false;
		boolean onepage = true;
		boolean immediate = false;
		boolean practice = false;
		
		int id = qdb.getAvailableQuizID();
		String randomStr = request.getParameter("random");
		String onepageStr = request.getParameter("onepage");
		String practiceStr = request.getParameter("practice");
		
		if(randomStr.equals("a")){
			random = true;
		}
		if(onepageStr.equals("a")){
			onepage = false;
			immediate = true;
		}
		if(onepageStr.equals("b")){
			onepage = false;
		}
		if(practiceStr.equals("a")){
			practice = true;
		}
		
		Integer error = 0;
		request.setAttribute("error", error);
		
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		String category = request.getParameter("category");
		
		if(name.equals("") || description.equals("")){
			error = 1;
			request.setAttribute("error", error);
			RequestDispatcher dispatch = request.getRequestDispatcher("createQuiz.jsp");
			dispatch.forward(request, response);
		}else{
			User userObj = (User) session.getAttribute("user");
			String user = userObj.getUsername(); 
			Quiz qz;
			if(qdb.checkName(name)){
				qz = qdb.addQuiz(id, name, description, user, category, random, onepage, immediate, practice);
				request.setAttribute("name", name);
				request.setAttribute("description", description);
				request.setAttribute("quizID", id);
				request.setAttribute("user", user);
				request.setAttribute("category", category);				
				request.setAttribute("random", random);
				request.setAttribute("onepage", onepage);
				request.setAttribute("immediate", immediate);
				request.setAttribute("practice", practice);
				request.setAttribute("quiz", qz);
				RequestDispatcher dispatch = request.getRequestDispatcher("successfullyCreated.jsp");
				dispatch.forward(request, response);
			}else{
				error = 2;
				request.setAttribute("error", error);
				RequestDispatcher dispatch = request.getRequestDispatcher("createQuiz.jsp");
				dispatch.forward(request, response);
			}
		}
	}

}
