<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, database.*, quiz.*"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">

  <head>
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <%
    
    QuizDatabase quizDB = (QuizDatabase)application.getAttribute("quizDBC");
    UserDatabase userDB = (UserDatabase)application.getAttribute("userDBC");
    out.print("<title>Create a Qwizzle</title>");
    
    int error;
    if(request.getAttribute("error") == null) error = 0;
    else error = Integer.parseInt((String)request.getAttribute("error"));
    
    Integer numblank = (Integer) request.getAttribute("numblank");
    
    Integer choice = numblank;
	int numchoice = choice;
	
	Integer id = (Integer) request.getAttribute("quizID");

	request.setAttribute("type", "mr");
    %>
    
</head>

<body>
   <!-- Keeps the site in the center of the page; width controlled. -->
   <div id ="outer">
   <div id="wrapper">
   
      <form method="get" action="search.jsp" id="search">
   		 <input name="query" type="text" size="40" placeholder="Search..."/>
      </form>
      
      <div id="logo">
        <h1><a href="home.jsp" style="text-decoration: none;">Qwizzler</a></h1>
      </div>
      <div id="nav-bar">
        <ul>
          <li><a href="quizzes.jsp">QWIZZES</a></li>
          <li><a href="profile.jsp">MY PROFILE</a></li>
          <li><a href="LogoutServlet">LOGOUT</a></li>
        </ul>
      </div>
      
      <div id="quiz-details-box">
      <%
      	if(error > 0){
           out.print("<br/>");
		   out.println("<p><span>No field can be left blank, please try again.</span></p>");
      	}
      %>
        <br>
        <p><span>Your question:</span></p>
        	<form action="AddMRQuestion" method="post">
	  			<ul>
	  			<%
		  		    out.print("<br/>");
				    out.println("<li><input id=\"question\" class=\"fieldBox\" placeholder=\"Part of your question before blank 1\" type=\"text\" name=\"question0\"/></li>");
	  				for(int i = 1; i <= numblank; i++){
	  				  out.println("<li><input id=\"question\" class=\"fieldBox\" placeholder=\"Part of your question after blank " + i + "\" type=\"text\" name=\"question" + i + "\"/></li>");
	  				}
	  			%>	
				</ul>
        <br>
              
      <%
      
      for(int i = 0; i < numchoice; i++){
   		  out.print("<br/>");
		  out.println("<p><span>Answer for blank" + (i+1) + ": </span></p>" + "<input type=\"text\" class=\"fieldBox\" placeholder=\"Answer text\" name=" + i + " />");
      }
      
		  out.print("<p>");
		  
		  out.print("</p>");
	      
	  out.print("<p>");
      %>
      <br />

      <input type="hidden" name="quizID" value=<%=id.toString() %>>
      <input type="hidden" name="type" value="mr">
      <input type="hidden" name="numblank" value=<%=numblank.toString()%>>
      <input id="create-button" class="button green" type="submit" value="Create Question!"/>
      </form>
        	<br>
        	<br>
      </div>              
            
      </div>
      <div id="footer">
        <ul>
          <li class="copyright-text">Created by:</li>
          <li class="footer-text">Kyle</li>
          <li class="footer-text">Sean</li>
          <li class="footer-text">Joaquin</li>
          <li class="footer-text">James</li>
        </ul>
      </div>
      
  </div>
  </div>
</body>
</html>