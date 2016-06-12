<%-- 
    Document   : Visit
    Created on : 2016-6-9, 6:25:35
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
                <title>Visit</title>


	<!-- Bootstrap core CSS -->
	<link href="Style/css/bootstrap.min.css" rel="stylesheet">
	<!-- Bootstrap theme -->
	<link href="Style/css/bootstrap-theme.min.css" rel="stylesheet">


        <script LANGUAGE="javascript">

function check_all_fields(form_obj){
        alert(form_obj.searchAttribute.value+"='"+form_obj.attributeValue.value+"'");
        if( form_obj.attributeValue.value == ""){
                alert("Search field should be nonempty");
                return false;
        }
        return true;
}
        </script>
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
				<jsp:param name="content" value="<li class=\"active\"><a href=\"Visit.jsp\">New Visit</a></li>"/>
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
	
	<jsp:include page="PrivilegeLevelCheck.jsp">
		<jsp:param name="requiredPL" value="1"/>
	</jsp:include>
	<div class="container theme-showcase" role="main">    
	    <div class="jumbotron"> </div>

        <% String searchAttribute = request.getParameter("searchAttribute");
           if( searchAttribute == null ){ %>
	   <div class="page-header">
	   <h1>POI List</h1>
	       
	   </div>

	<table class="table table-striped">
	 <tr><th>Pid</th><th>Name</th><th>Category</th><th>State</th><th>City</th><th>Street</th><th>Price</th></tr>
	 <%
	     java.util.ArrayList<String[]> list = POIOperations.getList();
	     for (String[] ss : list) {
		 %>
			<tr>
		 <%
		 for (int i = 0; i < ss.length; ++i) {
		     %> <td> <%= ss[i] %> </td> <%
		 }
		 %>
			</tr>
		 <%
	     }
	 %>
	</table>       
           
         
        Search POIs on name:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="Visit.jsp">
                <input type=hidden name="searchAttribute" value="Visit">
                Visit POI:<input type=text name="VisitPoi" length=50>
                Visit Date(YYYY-MM-DD):<input type=text name="VisitDate" length=20>
                Cost:<input type=text name="cost" length=20>
                Number of heads:<input type=text name="numberofheads" length=20>
                <input type=submit value="Visit">
        </form>
        <a href="index.jsp">Back</a>
        <% } else {
               int vis = Visit.doVisit((String)session.getAttribute("login"), request.getParameter("VisitPoi"), request.getParameter("VisitDate"), Integer.valueOf(request.getParameter("cost")), Integer.valueOf(request.getParameter("numberofheads")));
               if (vis == 1) {
        %>
        <script>
	    alert("Visit Success."));
	</script>
        <%
            out.println("Suggestion POIs: ");
            java.util.ArrayList<String[]> poiList = POIOperations.getSuggestion(request.getParameter("VisitPoi"));
        %>
        <table class="table5" border=1>
	 <tr><th>Times</th><th>POI</th></tr>
	 <%
	     for (String[] ss : poiList) {
		 %>
			<tr>
		 <%
		 for (int i = 0; i < ss.length; ++i) {
		     %> <td> <%= ss[i] %> </td> <%
		 }
		 %>
			</tr>
		 <%
	     }
	 %>
	</table>
        <a href="index.jsp">Back</a>
        <% } else { %>
        <script>
	    if (!alert("Visit Fail.")) location.href = 'index.jsp';
	</script>
        <% } %>
        <% } %>
	</div>
    </body>
</html>
