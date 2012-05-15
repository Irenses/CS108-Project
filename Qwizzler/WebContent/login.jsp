<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="user.*, java.util.*"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <script src="js/jquery-1.7.js" type="text/javascript"></script>
    <script src="js/scripts.js" type="text/javascript"></script>
    <script src="js/jquery.validate.js" type="text/javascript"></script>
    <link href="css/styles.css" rel="stylesheet" type="text/css" media="screen">
    <link href="css/buttons.css" rel="stylesheet" type="text/css" media="screen">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title>Qwizzler Login</title>
  </head>
  
  <body>
   <div class="centered" id="login-outer">
   <div id="login-wrapper">
   
   <div class="content-box header-box">
    <h3>Welcome to</h3>
    <h1>Qwizzler</h1>
   </div>
   
    <div class="content-box">
    <h2 style="text-align: center;">Please log in.</h2>
	<form action="LoginServlet" method="post">
	 <ul id="login-form">
	  <li>
        <input id="userField" class="fieldBox" placeholder="Username" type="text" name="name"/>
      </li>
	  <li>
        <input id="passField" class="fieldBox" placeholder="Password" type="password" name="pass"/>
        <input id="submit-button" class="button blue" type="submit" value="Sign in"/>
      </li>
     </ul>
	</form>
	</div>

	<div class="content-box">
	<h2 style="text-align: center;">New to Qwizzler? Sign up.</h2>
	<form action="CreateAccountServlet" method="post">
	  <ul id="create-account-form">
	  	<li>	
	  	  <input id="user-createField" class="fieldBox" placeholder="Desired username" type="text" name="username"/>	
	  	</li>
	  	<li>
		 <input class="fieldBox" placeholder="Full name" type="text" name="name"/>
		</li>
		<li>
		  <input class="fieldBox" placeholder="Email" type="text" name="email"/>
		</li>
		<li>
		  <input class="fieldBox" placeholder="Password" type="password" name="pass"/>
		</li>
	  </ul>
		<input id="create-button" class="button orange" type="submit" value="Sign up for Qwizzler"/>
	</form>
    </div>
    
    
    <!-- Hidden popups -->
    
    <div class="messagepop pop centered" id="incorrect-login-pop">
	  <p>Your username or password was incorrect.</p>
	  <div id="incorrect-login-buttons-row">
	  	<input type="submit" value="Cancel" class="button blue" id="incorrect-login-close-button"/>
	  </div>
	</div>
	
	 <div class="messagepop pop centered" id="incorrect-creation-pop" style="text-align: center;">
	  <p>Error in account creation.<br />
	  Please re-enter your details.</p>
	  <div id="incorrect-creation-buttons-row">
	  	<input type="submit" value="Cancel" class="button blue" id="incorrect-creation-close-button"/>
	  </div>
	</div>
	
   </div>
   </div>
   
  <%
  if (request.getAttribute("error") != null) {
  	int errorNum = Integer.parseInt((String) request.getAttribute("error"));
  	if (errorNum > 0) {
  		out.println("<script type=\"text/javascript\">");
  		out.println("$(document).ready(function() {"); 
  		if (errorNum == 1) {
  			out.println("alert(\"Your username or password was incorrect.\");");
  			out.println("$(\"#userField\").focus();");
  			//out.println("$(\"#incorrect-login-pop\").css(\"visibility\", \"visible\");");
  		}
  		if (errorNum == 2) {
  			out.println("alert(\"Error in account creation. Please re-enter your login details.\");");
  			out.println("$(\"#user-createField\").focus();");
  			//out.println("$(\"#incorrect-creation-pop\").css(\"visibility\", \"visible\");");
  		}
  		out.println("});");
  		out.println("</script>");
  	}
  }
  %>
  
  </body>

</html>