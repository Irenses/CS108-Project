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

import database.*;

/**
 * Servlet implementation class MakeFriendServlet
 */
@WebServlet("/MakeFriendServlet")
public class MakeFriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeFriendServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = this.getServletContext();
		UserDatabase udb = (UserDatabase) context.getAttribute("userDBC");	
		String cur = (String) request.getAttribute("currentUser");
		String friend = (String) request.getAttribute("friend");
		int del = Integer.parseInt((String) request.getAttribute("change"));
		if (del == 0) {//delete friend
			User user = udb.getUserInfo(cur);
			user.deleteFriend(friend);
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			RequestDispatcher dispatch = request.getRequestDispatcher("profile.jsp?user=" + cur);//hopefully this works
			dispatch.forward(request,response);	//should reload homepage to reflect latest friend addition
		} else if(del == 1) {//add friend
			udb.deleteFriendRequest(friend, cur);
			User user = udb.getUserInfo(cur);
			user.addFriend(friend);
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			RequestDispatcher dispatch = request.getRequestDispatcher("home.jsp?user=" + cur);//hopefully this works
			dispatch.forward(request,response);	//should reload homepage to reflect latest friend addition
		} else {
			//do nothing
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
