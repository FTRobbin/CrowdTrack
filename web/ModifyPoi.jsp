<%-- 
    Document   : ModifyPoi
    Created on : 2016-6-9, 7:41:07
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
	<title>Modify POI</title>


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
				<jsp:param name="content" value="<li class=\"active\"><a href=\"ModifyPoi.jsp\">Modify POI</a></li>"/>
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
		<jsp:param name="requiredPL" value="2"/>
	</jsp:include>

        <%-- <jsp:include page="PrivilegeLevel.jsp" /> --%>
	<div class="container theme-showcase" role="main">    
	    <div class="jumbotron"> </div>
	    <% if (session.getAttribute("privilege") != null && Integer.valueOf((String) session.getAttribute("privilege")) >= 2) { %>
	    <% String searchAttribute = request.getParameter("searchAttribute");
            if (searchAttribute == null) { %>


	    <div class="page-header">
		<h1>Modify POI</h1>
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
		    %> <td> <%= ss[i]%> </td> <%
			    }
		    %>
		</tr>
		<%
		    }
		%>
	    </table>
	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title"> New POI</h3>
		</div>
		<div class="panel-body">

		    <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="ModifyPoi.jsp">
			<input type=hidden name="searchAttribute" value="New">
			POI name:<input type=text name="poiName" length=50>
			POI category:<input type=text name="poiCategory" length=30>
			POI State:<input type=text name="poiState" length=30>
			POI City:<input type=text name="poiCity" length=30>
			POI Street:<input type=text name="poiStreet" length=30>
			POI Price:<input type=text name="poiPrice" length=30>
			<input type=submit value="New">
		    </form> 
		</div>
	    </div>

	    <BR><BR>
	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title"> Update POI</h3>
		</div>
		<div class="panel-body">
		    <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="ModifyPoi.jsp">
			<input type=hidden name="searchAttribute" value="Update">
			Pid:<input type=text name="pid" length=10>
			POI name:<input type=text name="poiName" length=50>
			POI category:<input type=text name="poiCategory" length=30>
			POI State:<input type=text name="poiState" length=30>
			POI City:<input type=text name="poiCity" length=30>
			POI Street:<input type=text name="poiStreet" length=30>
			POI Price:<input type=text name="poiPrice" length=30>
			<input type=submit value="Update">
		    </form>
		</div>
	    </div>

	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title"> Add Keyword</h3>
		</div>
		<div class="panel-body">
		    <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="ModifyPoi.jsp">
			<input type=hidden name="searchAttribute" value="Keyword">
			Pid:<input type=text name="pid" length=10>
			Keyword:<input type=text name="keyword" length=50>
			<input type=submit value="Add">
		    </form>
		</div>
	    </div>
	    <a href="index.jsp">Back</a>
	    <% } else {
		if (request.getParameter("searchAttribute").equals("New")) {
		    int flag = POIOperations.addPoi(request.getParameter("poiName"), request.getParameter("poiCategory"), request.getParameter("poiState"), request.getParameter("poiCity"), request.getParameter("poiStreet"), Double.parseDouble(request.getParameter("poiPrice")));
		    if (flag == 1) {
	    %>
	    <script>
		    if (!alert("New Success."))
			    location.href = 'index.jsp';
	    </script>
	    <%          } else { %>
	    <script>
		    if (!alert("New Fail."))
			    location.href = 'index.jsp';
	    </script>
	    <%          } %>
	    <%      }
		if (request.getParameter("searchAttribute").equals("Update")) {
		    int flag = POIOperations.updatePoi(Integer.valueOf(request.getParameter("pid")), request.getParameter("poiName"), request.getParameter("poiCategory"), request.getParameter("poiState"), request.getParameter("poiCity"), request.getParameter("poiStreet"), Double.parseDouble(request.getParameter("poiPrice")));
		    if (flag == 1) {
	    %>
	    <script>
		    if (!alert("Update Success."))
			    location.href = 'index.jsp';
	    </script>
	    <%          } else { %>
	    <script>
		    if (!alert("Update Fail."))
			    location.href = 'index.jsp';
	    </script>
	    <%          }
		}
		if (request.getParameter("searchAttribute").equals("Keyword")) {
		    int flag = KeywordsOperations.addKeyword(Integer.valueOf(request.getParameter("pid")), request.getParameter("keyword"));
		    if (flag == 1) {
	    %>
	    <script>
		    if (!alert("Add Keyword Success."))
			    location.href = 'index.jsp';
	    </script>
	    <%          } else { %>
	    <script>
		    if (!alert("Add Keyword Fail."))
			    location.href = 'index.jsp';
	    </script>
	    <%          }
			}
		    }
		} else {
		    out.print("No permission!");
		}
	    %>
	</div>
    </body>
</html>
