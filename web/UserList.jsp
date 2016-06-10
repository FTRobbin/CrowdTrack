<%-- 
    Document   : UserList
    Created on : Jun 10, 2016, 2:52:10 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*,ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User List</title>
    </head>
    <body>
	<h1>User List</h1>
	<style type="text/css">
	.table5 {
	  border-collapse: collapse;
	}
	.table5 th {
	  background-color: #cccccc;
	}
	.table5 td {
	  text-align: center;
	}
	</style>
	<table class="table5" border=1 cellpadding="5">
	 <tr><th>Login</th><th>Password</th><th>Name</th><th>Privilege</th><th>Trust</th></tr>
	 <%
	     ArrayList<ArrayList<String>> list = UserOperations.getTrustList(UserOperations.getList(),(String)session.getAttribute("login"));
	     for (ArrayList<String> ss : list) {
		 %>
			<tr>
		 <%
		 for (int i = 0; i < ss.size() - 1; ++i) {
		     %> <td> <%= ss.get(i) %> </td> <%
		 }
		 %>
		 <td> <a href="Trust.jsp?login=<%= ss.get(0) %>"> <%= ss.get(ss.size() - 1) %> </a> </td> <%
		 %>
			</tr>
		 <%
	     }
	 %>
	</table>
	
	<br/>
	<a href="index.jsp">Back</a>	    </body>
</html>
