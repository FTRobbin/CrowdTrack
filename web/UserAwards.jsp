<%-- 
    Document   : UserAwards
    Created on : Jun 10, 2016, 9:05:26 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*,ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<title>User Awards</title>


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
				<jsp:param name="content" value="<li><a href=\"Visit.jsp\">New Visit</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"PoiList.jsp\">POI List</a></li>"/>
			</jsp:include>

			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"Feedback.jsp\">Feedback</a></li>"/>
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
				<jsp:param name="content" value="<li class=\"active\"><a href=\"UserAwards.jsp\">User Awards</a></li>"/>
			</jsp:include>


			<jsp:include page="PrivilegeLevelHide.jsp" >
				<jsp:param name="requiredPL" value="1"/>
				<jsp:param name="content" value="<li><a href=\"Logout.jsp\">Logout</a></li>"/>
			</jsp:include>

		    </ul>
		</div><!--/.nav-collapse -->
	    </div>
	</nav>

	<jsp:include page="PrivilegeLevelCheck.jsp">
		<jsp:param name="requiredPL" value="2"/>
	</jsp:include>
	<div class="container theme-showcase" role="main">    
	    <div class="jumbotron"> </div>
	    <div class="page-header">
		<h1>User Awards</h1>
	    </div>
	    <%
                ArrayList<String[]> list = new ArrayList<>();
                String extraCol = "";
                if (request.getParameter("sortg") != null) {
                    int top = Integer.valueOf((String) request.getParameter("topnum"));
                    if (request.getParameter("sortg").equals("trusted")) {
                        extraCol = "Trusts";
                        list = UserOperations.getTrustCntList(top);
                    } else if (request.getParameter("sortg").equals("useful")) {
                        extraCol = "Usefulness";
                        list = UserOperations.getUsefulnessList(top);
                    }
                }
	    %>

	    <%
                if (list.size() > 0) {
	    %>

	    <table class="table table-striped">
		<tr><th>Login</th><th>Name</th><th><%= extraCol%></th></tr>
			<%
                            for (String[] ss : list) {
			%>
		<tr>
		    <%
                        for (int i = 0; i < ss.length; ++i) {
		    %> <td> <%= ss[i]%> </td> <%
                        }
		    %>
		</tr>
		<%
                    }
		%>
	    </table>
	    <%
                }
	    %>

	    <br/>
	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title"> Search </h3>
		</div>
		<div class="panel-body">
		    <form>
			<div> TOP <input type="text" name="topnum" value="5"> </div>
			<div>
			    <input type="radio" name="sortg" value="trusted" checked> Most Trusted
			    <input type="radio" name="sortg" value="useful"> Most Useful
			</div>
			<div>
			    <input type="submit">
			</div>
		    </form>
		</div>
	    </div>


	    <br/>
	    <a href="index.jsp">Back</a>
	</div>
    </body>
</html>
