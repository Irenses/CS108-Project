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
 * Servlet implementation class ChangeAdminServlet
 */
@WebServlet("/ChangeAdminServlet")
public class ChangeAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = this.getServletContext();
		UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");	
		String user = (String) request.getAttribute("user");
		int up = Integer.parseInt((String) request.getAttribute("change"));
		if (up == 0) {//downgrade account from admin
			udb.changeAdminStatus(user, false);
			RequestDispatcher dispatch = request.getRequestDispatcher("profile.jsp?user=" + user);
			dispatch.forward(request,response);	//should reload profile to reflect admin change
		} else if(up == 1) {//upgrade account to admin
			udb.changeAdminStatus(user, true);
			RequestDispatcher dispatch = request.getRequestDispatcher("profile.jsp?user=" + user);
			dispatch.forward(request,response);	//should reload profile to reflect admin change
		} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
