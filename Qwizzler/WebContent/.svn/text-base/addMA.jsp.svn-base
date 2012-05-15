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
    
    Integer choice;
    if(request.getAttribute("numchoice") == null){
    	choice = 3;
    }else{
    	choice = (Integer) request.getAttribute("numchoice");
    }
	request.setAttribute("numchoice", choice);
	
	Integer id = (Integer) request.getAttribute("quizID");

	request.setAttribute("type", "ma");
	int numchoice = choice;
	
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
        	<form action="AddMAQuestion" method="post">
	  			<ul>
				  	<li>	
				  	  <input id="question" class="fieldBox" placeholder="Your question" type="text" name="question"/>	
				  	</li>
				</ul>
        <br>
              
      <%
      
      for(int i = 0; i < numchoice; i++){
   		  out.print("<br/>");
		  out.println("<p><span>Choice " + (i+1) + ": </span></p>" + "<input type=\"text\" class=\"fieldBox\" placeholder=\"The choice\" name=" + i + " />");
      }
      
		  out.print("<p>");
		  
		  out.print("</p>");
		  out.print("<br> The correct answer is: <br>");
	  for(int i = 0; i < numchoice; i++){
			  out.println("<input type=\"checkbox\" name=\"a" + i + "\"value=\"" + (char)(i + 97) + "\">" + (i+1) + "<br>");
	  }
	      
	  out.print("<p>");
      %>
      <br />

      <input type="hidden" name="quizID" value=<%=id.toString() %>>
      <input type="hidden" name="type" value="ma">
      <input type="hidden" name="numchoice" value=<%=choice.toString()%>>
      <input id="create-button" class="button green" type="submit" value="Create Question!"/>
      </form>
  <br />
  <br />
  <br />
        	
    <div id="friend-buttons-with-add">      
      <form action="IncreaseChoice" method = "post">
              <input type="hidden" name="quizID" value=<%=id.toString() %>>
      		  <input type="hidden" name="type" value="ma">
      		  <input type="hidden" name="numchoice" value=<%=choice.toString()%>>
      	      <input id="create-button" class="button orange" type="submit" value="More choices  "/>
      </form>
      <form action="DecreaseChoice" method = "post">
           	  <input type="hidden" name="quizID" value=<%=id.toString() %>>
           	  <input type="hidden" name="type" value="ma">
      		  <input type="hidden" name="numchoice" value=<%=choice.toString()%>>
      	      <input id="create-button" class="button orange" type="submit" value="Fewer choices"/>
      </form>
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