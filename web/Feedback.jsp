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
        <%  if (FeedbackOperations.hasFeedback((String)session.getAttribute("login"),Integer.valueOf(request.getParameter("pid")))==1) { 
                String[] ss = FeedbackOperations.getFeedback((String)session.getAttribute("login"),Integer.valueOf(request.getParameter("pid")));
                out.println("Your Score:"+ss[0]);
                out.println("Your Feedback:"+ss[1]);
                out.println("Date:"+ss[2]);
            } else { %>
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="FeedbackSubmit.jsp">
                <input type=hidden name="searchAttribute" value="FeedbackSubmit">
                <input type=hidden name="pid" value="<%= request.getParameter("pid") %>">
                Score:<input type=text name="Score" length=10>
                Feedback:<input type=text name="Text" length=200>
                <input type=submit value="Submit">
        </form>
        <%  } %>
        <table class="table5" border=1>
            <tr><th>User</th><th>Date</th><th>Score</th><th>Text</th><th>Rating</th></tr>
            <%
	     java.util.ArrayList<String[]> list = FeedbackOperations.getAllFeedback((String)session.getAttribute("login"),Integer.valueOf(request.getParameter("pid")));
	     for (String[] ss : list) {
		 %>
			<tr>
		 <%
		 for (int i = 1; i < ss.length; ++i) {
		     %> <td> <%= ss[i] %> </td> <%
		 }
                if (FeedbackOperations.hasRating((String)session.getAttribute("login"), Integer.valueOf(ss[0]))==1) { 
                    int rat = Integer.valueOf(FeedbackOperations.getRating((String)session.getAttribute("login"), Integer.valueOf(ss[0])));
                    String ratt = "";
                    if (rat == 0) ratt = "Useless";
                    if (rat == 1) ratt = "Useful";
                    if (rat == 2) ratt = "Very Useful";
            %>
                <td><%= ratt %></td></tr>

            <%  } else { %>
			<td><a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0] %>&rate=0">Useless</a>
                            <a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0] %>&rate=1">Useful</a>
                            <a href="RatingSubmit.jsp?searchAttribute=Rating&fid=<%= ss[0] %>&rate=2">Very useful</a>
                        </td></tr>
		 <% }
	     }
	 %>
	</table>
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="UsefulFeedback.jsp">
                <input type=hidden name="searchAttribute" value="UsefulFeedback">
                <input type=hidden name="pid" value="<%= request.getParameter("pid") %>">
                Get top <input type=text name="top" length=10> feedbacks.
                <input type=submit value="Get">
        </form>
        <% } %>
    </body>
</html>
