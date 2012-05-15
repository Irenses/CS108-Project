package quiz;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.QuizDatabase;

@WebServlet("/AddQuestion")
public class AddQuestion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddQuestion() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("questiontype");
		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		if(type.equals("mc")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addMC.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("mr")){
			request.setAttribute("multi", "mr");
			RequestDispatcher dispatch = request.getRequestDispatcher("addMBlank.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("mu")){
			request.setAttribute("multi", "mu");
			RequestDispatcher dispatch = request.getRequestDispatcher("addMBlank.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("ma")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addMA.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("pr")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addPR.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("qr")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addQR.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("fitb")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addFITB.jsp");
			dispatch.forward(request, response);
		}
	}

}
