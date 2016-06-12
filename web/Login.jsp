<%-- 
    Document   : Login
    Created on : Jun 9, 2016, 3:07:46 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<title>Login</title>


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
			<li class="active"><a href="Login.jsp">Login</a></li>
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

	<%
            if (session.getAttribute("login") != null && session.getAttribute("login") != "") {
	%>
	<script>
		if (!alert("You have already logged in. Logout to use another account."))
			location.href = 'index.jsp';
	</script>
	<%
	    }
	    System.err.println(request.getParameter("clicked"));
	    if (request.getParameter("clicked") != null) {
		System.err.println(request.getParameter("clicked"));
		session.setAttribute("privilege", request.getParameter("clicked"));
	    }
	%>

	<%-- <jsp:include page="PrivilegeLevel.jsp"/> --%>
	<div class="container theme-showcase" role="main">     

	    <div class="jumbotron"> </div>
	    	    <div class="page-header">
		<h1>Login</h1>
	    </div>

	    <form name="loginForm" method="POST" action="LoginSubmit.jsp">
		Login : <div><input type="text" name="login"></div>
		Password : <div><input type="password" name="pass"></div>
		<input type="submit">
	    </form>

	    <br/>
	    <%--
	    <form name="form1" method="POST">
		<input type="hidden" name="clicked">
		<input type="button" value="I'm a Guest!" onclick="setPrivilege(0)">
		<input type="button" value="I'm a User!" onclick="setPrivilege(1)">
		<input type="button" value="I'm an Admin!" onclick="setPrivilege(2)">
		<input type="button" value="I'm a Lolicon!" onclick="setPrivilege(3)">
	    </form>
	    --%>
	    <script language="JavaScript">
		    <!--
		    function setPrivilege(lev) {
			document.form1.clicked.value = lev;
			form1.submit();
		    }
	    </script>	

	    <br/>
	    <a href="index.jsp">Back</a>
	</div>
    </body>
</html>
