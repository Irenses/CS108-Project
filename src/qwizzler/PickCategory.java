package qwizzler;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PickCategory")
public class PickCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public PickCategory() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return; 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cat = request.getParameter("category");
		RequestDispatcher dispatch = request.getRequestDispatcher("quizzes.jsp?cat=" + cat);
		dispatch.forward(request, response);
	}

}
