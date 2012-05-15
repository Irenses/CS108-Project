package message;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.User;
import database.MessageDatabase;
import database.UserDatabase;

/**
 * Servlet implementation class FriendRequestServlet
 */
@WebServlet("/FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendRequestServlet() {
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
		ServletContext context = this.getServletContext();
		MessageDatabase mdb = (MessageDatabase) context.getAttribute("messageDBC");		
		String from = request.getParameter("from");//requester
		String to = request.getParameter("to");//person u wanna be friends with
		String body = "<a href=\\\"profile.jsp?user=" + from + "\\\">" + from + "</a> wants to be your friend. <a href=\\\"acceptFriendR.jsp?from=" + from + "&to=" + to + "\\\">Accept?</a>";
		Message fr = new Message(from,to,body,2);
		if (!mdb.containsFriendRequest(from, to)) mdb.storeMessage(fr);
		RequestDispatcher dispatch = request.getRequestDispatcher("profile.jsp?user=" + to);
		dispatch.forward(request,response);	
	}

}
