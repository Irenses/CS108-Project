package user;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.UserDatabase;


/**
 * Servlet implementation class Login
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * Default constructor. 
     */
    public LoginServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// NOT USING doGet
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("name");
		String password = request.getParameter("pass");
		ServletContext context = this.getServletContext();
		UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
		User user = udb.getUserInfo(username);
		RequestDispatcher dispatch; 
		if (user != null && user.checkPassword(password)) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			dispatch = request.getRequestDispatcher("home.jsp?user=" + username);
			//dispatch = request.getRequestDispatcher("home.jsp");
		} else {
			dispatch = request.getRequestDispatcher("login.jsp");
			request.setAttribute("error", "1");
		}
		dispatch.forward(request,response);
	}

}
