<%-- 
    Document   : UserAwards
    Created on : Jun 10, 2016, 9:05:26 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*,ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Awards</title>
    </head>
    <body>
	<jsp:include page="PrivilegeLevelCheck.jsp">
		<jsp:param name="requiredPL" value="2"/>
	</jsp:include>
	
	<h1>User Awards</h1>
	<%
	  ArrayList<String[]> list = new ArrayList<>();
	  String extraCol = "";
	  if (request.getParameter("sortg") != null) {
		int top = Integer.valueOf((String)request.getParameter("topnum"));
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
	 <tr><th>Login</th><th>Name</th><th><%= extraCol %></th></tr>
	 <%
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
	<%
	    }
	%>
	
	<br/>
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

	
	<br/>
	<a href="index.jsp">Back</a>	    </body>
</html>
