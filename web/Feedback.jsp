<%-- 
    Document   : Feedback
    Created on : 2016-6-10, 10:32:16
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<title>View Feedback</title>


	<!-- Bootstrap core CSS -->
	<link href="Style/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap theme -->
	<link href="Style/css/bootstrap-theme.min.css" rel="stylesheet">


        <script LANGUAGE="javascript">

                function check_all_fields(form_obj) {
                    alert(form_obj.searchAttribute.value + "='" + form_obj.attributeValue.value + "'");
                    if (form_obj.attributeValue.value == "") {
                        alert("Search field should be nonempty");
                        return false;
                    }
                    return true;
                }
        </script>
    </head>
    <body>
        <%--<jsp:include page="PrivilegeLevel.jsp" /> --%>

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

	    <% String searchAttribute = request.getParameter("searchAttribute");
            if (searchAttribute == null) { %>
	    <div class="jumbotron"></div>
	    <div class="page-header">
		<h1>View Feedbacks</h1>
	    </div>

	    <table class="table table-striped">
		<tr><th>Pid</th><th>Name</th><th>Category</th><th>State</th><th>City</th><th>Street</th><th>Price</th><th>View Feedback</th></tr>
			<%
			    java.util.ArrayList<String[]> list = POIOperations.getList();
			    for (String[] ss : list) {
			%>
		<tr>
		    <%
			for (int i = 0; i < ss.length; ++i) {
		    %> <td> <%= ss[i]%> </td> <%
			    }
		    %>
		    <td><a href="Feedback.jsp?searchAttribute=Feedback&pid=<%= ss[0]%>">View Feedback</a>  </td></tr>
		    <%
			}
		    %>
	    </table>
	    <br/>
	    <a href="index.jsp">Back</a>
	    <% } else {
		String[] info = POIOperations.getInfo(Integer.valueOf(request.getParameter("pid")));
	    %>
	    <div class="jumbotron">

		<h1><%= info[1]%></h1>
		<h2><%= info[2]%></h2>
		<p><%= info[3]%></p>


	    </div>

	    <br/>

	    <%  if (FeedbackOperations.hasFeedback((String) session.getAttribute("login"), Integer.valueOf(request.getParameter("pid"))) == 1) {
		    String[] ss = FeedbackOperations.getFeedback((String) session.getAttribute("login"), Integer.valueOf(request.getParameter("pid")));
		    out.println("Your Score:" + ss[0]);
		    out.println("Your Feedback:" + ss[1]);
		    out.println("Date:" + ss[2]);
		} else {%>
	    <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="FeedbackSubmit.jsp">
                <input type=hidden name="searchAttribute" value="FeedbackSubmit">
                <input type=hidden name="pid" value="<%= request.getParameter("pid")%>">
                
		<div> Score:<input type=text name="Score" length=5> </div>
		
                <div> Feedback:<input type=text name="Text" length=200 size="50"> </div>
                <input type=submit value="Submit">
	    </form>
	    <%  } %>
	    <table class="table table-striped">
		<tr><th>User</th><th>Date</th><th>Score</th><th>Text</th><th>Rating</th></tr>
			<%
			    java.util.ArrayList<String[]> list = FeedbackOperations.getAllFeedback((String) session.getAttribute("login"), Integer.valueOf(request.getParameter("pid")));
			    for (String[] ss : list) {
			%>
		<tr>
		    <%
			for (int i = 1; i < ss.length; ++i) {
		    %> <td> <%= ss[i]%> </td> <%
			    }
			    if (FeedbackOperations.hasRating((String) session.getAttribute("login"), Integer.valueOf(ss[0])) == 1) {
				int rat = Integer.valueOf(FeedbackOperations.getRating((String) session.getAttribute("login"), Integer.valueOf(ss[0])));
				String ratt = "";
				if (rat == 0) {
				    ratt = "Useless";
				}
				if (rat == 1) {
				    ratt = "Useful";
				}
				if (rat == 2) {
				    ratt = "Very Useful";
				}
		    %>
		    <td><%= ratt%></td></tr>

		<%  } else {%>
		<td><a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0]%>&rate=0">Useless</a>
		    <a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0]%>&rate=1">Useful</a>
		    <a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0]%>&rate=2">Very useful</a>
		</td></tr>
		<% }
		    }
		%>
	    </table>
	    <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="UsefulFeedback.jsp">
                <input type=hidden name="searchAttribute" value="UsefulFeedback">
                <input type=hidden name="pid" value="<%= request.getParameter("pid")%>">
                Get top <input type=text name="top" length=10> feedbacks.
                <input type=submit value="Get">
	    </form>
	    <br/>
	    <a href="index.jsp">Back</a>
	    <% }%>
	</div>

    </body>
</html>
