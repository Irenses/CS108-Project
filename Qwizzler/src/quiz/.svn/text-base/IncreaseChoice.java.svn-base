package quiz;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/IncreaseChoice")
public class IncreaseChoice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public IncreaseChoice() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer curchoice = Integer.parseInt(request.getParameter("numchoice"));
		Integer id = Integer.parseInt(request.getParameter("quizID"));
		request.setAttribute("quizID", id);
		curchoice++;
		request.setAttribute("numchoice", curchoice);
		String type = (String) request.getParameter("type");
		
		if(type.equals("mc")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addMC.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("ma")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addMA.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("qr")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addQR.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("pr")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addPR.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("fitb")){
			RequestDispatcher dispatch = request.getRequestDispatcher("addFITB.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("mr")){
			request.setAttribute("numblank", Integer.parseInt(request.getParameter("numblank")));
			RequestDispatcher dispatch = request.getRequestDispatcher("addMR.jsp");
			dispatch.forward(request, response);
		}else if(type.equals("mu")){
			request.setAttribute("numblank", Integer.parseInt(request.getParameter("numblank")));
			RequestDispatcher dispatch = request.getRequestDispatcher("addMU.jsp");
			dispatch.forward(request, response);
		}
	}

}
