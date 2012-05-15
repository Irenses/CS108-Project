package qwizzler;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import database.DBConnection;
import database.MessageDatabase;
import database.QuizDatabase;
import database.UserDatabase;
import user.Achievement;

/**
 * Application Lifecycle Listener implementation class QwizzlerListener
 *
 */
@WebListener
/* *********Listener class to instantiate entire site data when users visit*************** */
public class QwizzlerListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public QwizzlerListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0) {
    	DBConnection dbc = new DBConnection();
    	QuizDatabase qdb = new QuizDatabase();
    	UserDatabase udb = new UserDatabase();
    	MessageDatabase mdb  = new MessageDatabase();
    	ServletContext context = arg0.getServletContext();
    	context.setAttribute("dbConnection", dbc);
    	context.setAttribute("userDBC", udb);
    	context.setAttribute("quizDBC", qdb);
    	context.setAttribute("messageDBC", mdb);
    }

	/**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
        // TODO Auto-generated method stub
    }
	
}
