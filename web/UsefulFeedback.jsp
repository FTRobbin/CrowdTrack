<%-- 
    Document   : UsefulFeedback
    Created on : 2016-6-10, 14:03:41
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Useful Feedback</title>
    </head>
    <body>
        <% if (request.getParameter("searchAttribute")==null) {
            out.println("Access Forbidden!");
           } else {
            String[] info = POIOperations.getInfo(Integer.valueOf(request.getParameter("pid")));
        %>
        <h1><%= info[1] %></h1>
        <h2><%= info[2] %></h2>
        <%  
            java.util.ArrayList<String[]> list = FeedbackOperations.getUsefulFeedback(Integer.valueOf(request.getParameter("pid")),Integer.valueOf(request.getParameter("top")));
            
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
        <table class="table5" border=1>
            <tr><th>Usefulness</th><th>User</th><th>Date</th><th>Score</th><th>Text</th></tr>
            <%
	     for (String[] ss : list) {
		 %>
            <tr><td><%= ss[0]%></td>
		 <%
                 String[] sp = FeedbackOperations.getFeedback(Integer.valueOf(ss[1]));
		 for (int i = 0; i < sp.length; ++i) {
		     %> <td> <%= sp[i] %> </td> <%
		 }
                
            %></tr>

            
	    <% } %>
	 
	</table>
        <a href="index.jsp">Back</a>
        <%  }%>
    </body>
</html>
