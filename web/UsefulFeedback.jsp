<%-- 
    Document   : UsefulFeedback
    Created on : 2016-6-10, 14:03:41
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<title>Useful Feedback</title>


	<!-- Bootstrap core CSS -->
	<link href="Style/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap theme -->
	<link href="Style/css/bootstrap-theme.min.css" rel="stylesheet">


    </head>
    <body>

	<!-- Fixed navbar -->
	<nav class="navbar navbar-inverse navbar-fixed-top">
	    <div class="container">
		<div class="navbar-header">
		    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		    </button>
		    <a class="navbar-brand" href="#">CrowdTrack</a>
		</div>
		<div id="navbar" class="navbar-collapse collapse">
		    <ul class="nav navbar-nav">
			<li><a href="index.jsp">Home</a></li>
			    <jsp:include page="PrivilegeLevelHide.jsp" >
				    <jsp:param name="requiredPL" value="3"/>
				    <jsp:param name="content" value="<li><a href=\"Initialization.jsp\">Initialization</a></li>"/>
			    </jsp:include>

			<%
                            if (session.getAttribute("login") != null && session.getAttribute("login") != "") {
                            } else {
			%>
			<li><a href="Register.jsp">Register</a></li>
			<li><a href="Login.jsp">Login</a></li>
			    <%
                                }
			    %>


			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"Visit.jsp?searchAttribute=Visit&num=0\">New Visit</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"PoiList.jsp\">POI List</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li class=\"active\"><a href=\"Feedback.jsp\">Feedback</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"UserList.jsp\">User List</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"degree.jsp\">User Degree</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="2"/>
				<jsp:param name="content" value="<li><a href=\"ModifyPoi.jsp\">Modify POI</a></li>"/>
			</jsp:include>


			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="2"/>
				<jsp:param name="content" value="<li><a href=\"UserAwards.jsp\">User Awards</a></li>"/>
			</jsp:include>


			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"Logout.jsp\">Logout</a></li>"/>
			</jsp:include>

		    </ul>
		</div><!--/.nav-collapse -->
	    </div>
	</nav>
	<div class="container theme-showcase" role="main">    
	    <% if (request.getParameter("searchAttribute") == null) {
                    out.println("Access Forbidden!");
                } else {
                    String[] info = POIOperations.getInfo(Integer.valueOf(request.getParameter("pid")));
	    %>

	    <div class="jumbotron"> 

		<h1><%= info[1]%></h1>
		<h2><%= info[2]%></h2>
		<p><%= info[3]%></p>
	    </div>
	    <%
                java.util.ArrayList<String[]> list = FeedbackOperations.getUsefulFeedback(Integer.valueOf(request.getParameter("pid")), Integer.valueOf(request.getParameter("top")));

	    %>

	    <table class="table table-striped">
		<tr><th>Usefulness</th><th>User</th><th>Date</th><th>Score</th><th>Text</th></tr>
			<%                for (String[] ss : list) {
			%>
		<tr><td><%= ss[0]%></td>
		    <%
                        String[] sp = FeedbackOperations.getFeedback(Integer.valueOf(ss[1]));
                        for (int i = 0; i < sp.length; ++i) {
		    %> <td> <%= sp[i]%> </td> <%
                        }

		    %></tr>


		<% } %>

	    </table>
	    <a href="index.jsp">Back</a>
	    <%  }%>
	</div>
    </body>
</html>
