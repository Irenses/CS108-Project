package user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.UserDatabase;

/**
 * Servlet implementation class CreateAccountServlet
 */
@WebServlet("/CreateAccountServlet")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAccountServlet() {
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
		String username = request.getParameter("username");
		String password = User.hashPassword(request.getParameter("pass"));//hopefully this works
		String email = request.getParameter("email");
		String fullname = request.getParameter("name");
		ServletContext context = this.getServletContext();
		UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");
		RequestDispatcher dispatch;
		//rudimentary check for '@' in email-->may actually be enough since this class isn't focused on error checking
		if (email.indexOf('@') != -1 && udb.validUserName(username)) {
			User u = new User(username,password,fullname,email);
			udb.addUser(u);
			u = udb.getUserInfo(username);
			dispatch = request.getRequestDispatcher("profile.jsp?user=" + username);
			HttpSession session = request.getSession();//do I need sessions?
			session.setAttribute("user", u);
		} else {
			dispatch = request.getRequestDispatcher("login.jsp");
			request.setAttribute("error", "2");
		}
		dispatch.forward(request,response);
	}

}
