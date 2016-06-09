<%-- 
    Document   : PoiList
    Created on : Jun 9, 2016, 9:24:27 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Poi List</title>
    </head>
    <body>
	<h1>POI List</h1>
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
	<table class="table5" border=1>
	 <tr><th>Name</th><th>Category</th><th>Favorite</th></tr>
	 <%
	     ArrayList<ArrayList<String> > list = ApplicationInterface.POIOperations.getFavList((String)session.getAttribute("login"));
	     for (ArrayList<String> ss : list) {
		 %>
			<tr>
		 <%
		 for (int i = 1; i < ss.size() - 1; ++i) {
		     %> <td> <%= ss.get(i) %> </td> <%
		 }
		 %>
		<%
		 //if (ApplicationInterface.POIOperations.userFavPoiQuery((String)session.getAttribute("login"), ss[0])) {
		 %> <td> <a href="Favorite.jsp?pid=<%= ss.get(0) %>"> <%= ss.get(ss.size() - 1) %> </a> </td> <%
		 %>
			</tr>
		 <%
	     }
	 %>
	</table>
	
	<br/>
	<a href="index.jsp">Back</a>	

    </body>
</html>
