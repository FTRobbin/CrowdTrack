<%-- 
    Document   : Feedback
    Created on : 2016-6-10, 10:32:16
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Feedback</title>
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
        <jsp:include page="PrivilegeLevel.jsp" />
        <% String searchAttribute = request.getParameter("searchAttribute");
           if( searchAttribute == null ){ %>
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
	 <tr><th>Pid</th><th>Name</th><th>Category</th><th>View Feedback</th></tr>
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
			<td><a href="index.jsp?searchAttribute=Feedback&pid=<%= ss[0] %>">View Feedback</a>  </td></tr>
		 <%
	     }
	 %>
	</table>
        <a href="index.jsp">Back</a>
        <% } else { 
            String[] info = POIOperations.getInfo(Integer.valueOf(request.getParameter("pid")));
        %>
        <h1><%= info[1] %></h1>
        <h2><%= info[2] %></h2>
        
        <% } %>
    </body>
</html>
