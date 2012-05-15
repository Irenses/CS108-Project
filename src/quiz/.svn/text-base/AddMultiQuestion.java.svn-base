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

@WebServlet("/AddMultiQuestion")
public class AddMultiQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddMultiQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		
		Integer numblank = Integer.parseInt(request.getParameter("numblank"));
		request.setAttribute("numblank", numblank);
		
		String type = request.getParameter("type");
		if(type.equals("mr")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addMR.jsp");
			dispatch.forward(request, response);
		}else{
			RequestDispatcher dispatch = request.getRequestDispatcher("addMU.jsp");
			dispatch.forward(request, response);
		}
	}

}
