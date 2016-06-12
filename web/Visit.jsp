<%-- 
    Document   : Visit
    Created on : 2016-6-9, 6:25:35
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visit</title>
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
	<jsp:include page="PrivilegeLevelCheck.jsp">
		<jsp:param name="requiredPL" value="1"/>
	</jsp:include>

        <% String searchAttribute = request.getParameter("searchAttribute");
           if( searchAttribute.equals("Visit") ){ %>
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
        
         <% int n = Integer.valueOf(request.getParameter("num"));
             if (n>0) { %>
        <h1>Already Visit</h1>
	<table class="table5" border=1>
	 <tr><th>POI</th><th>Date</th><th>Cost</th><th>Number of Heads</th></tr>
	 <%
	     for (int i = 0; i < n; i++) {
		 %>
			<tr>
                            <td> <%= request.getParameter("VisitPoi"+i) %></td><td> <%= request.getParameter("VisitDate"+i) %></td><td> <%= request.getParameter("cost"+i) %></td><td> <%= request.getParameter("numberofheads"+i) %></td>
			</tr>
		 <%
	     }
	 %>
	</table>
        <%
            out.println("Suggestion POIs for "+request.getParameter("VisitPoi"+(n-1))+": ");
            java.util.ArrayList<String[]> poiList = POIOperations.getSuggestion(request.getParameter("VisitPoi"+(n-1)));
        %>
        <table class="table5" border=1>
	 <tr><th>Times</th><th>POI</th></tr>
	 <%
	     for (int j = 0; j < poiList.size() && j<10; j++) {
                 String[] ss = poiList.get(j);
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
        <% } %>
        Visit POIs on name:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="Visit.jsp">
                <input type=hidden name="searchAttribute" value="Visit">
                <input type=hidden name="num" value="<%= Integer.toString(n+1) %>">
                <% for (int i = 0; i < n; i++) { %>
                <input type=hidden name="VisitPoi<%= Integer.toString(i) %>" value="<%= request.getParameter("VisitPoi"+i) %>">
                <input type=hidden name="VisitDate<%= Integer.toString(i) %>" value="<%= request.getParameter("VisitDate"+i) %>">
                <input type=hidden name="cost<%= Integer.toString(i) %>" value="<%= request.getParameter("cost"+i) %>">
                <input type=hidden name="numberofheads<%= Integer.toString(i) %>" value="<%= request.getParameter("numberofheads"+i) %>">
		<% } %>
                Visit POI:<input type=text name="VisitPoi<%= Integer.toString(n) %>" length=50>
                Visit Date(YYYY-MM-DD):<input type=text name="VisitDate<%= Integer.toString(n) %>" length=20>
                Cost:<input type=text name="cost<%= Integer.toString(n) %>" length=20>
                Number of heads:<input type=text name="numberofheads<%= Integer.toString(n) %>" length=20>
                <input type=submit value="Visit">
        </form>
        Confirm Visit:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="Visit.jsp">
                <input type=hidden name="searchAttribute" value="Confirm">
                <input type=hidden name="num" value="<%= Integer.toString(n) %>">
                <% for (int i = 0; i < n; i++) { %>
                <input type=hidden name="VisitPoi<%= Integer.toString(i) %>" value="<%= request.getParameter("VisitPoi"+i) %>">
                <input type=hidden name="VisitDate<%= Integer.toString(i) %>" value="<%= request.getParameter("VisitDate"+i) %>">
                <input type=hidden name="cost<%= Integer.toString(i) %>" value="<%= request.getParameter("cost"+i) %>">
                <input type=hidden name="numberofheads<%= Integer.toString(i) %>" value="<%= request.getParameter("numberofheads"+i) %>">
		<% } %>
                <input type=submit value="Confirm">
        </form>
        <a href="index.jsp">Back</a>
        <% } else if (searchAttribute.equals("Confirm")) {
                int vis = 1;
                int n = Integer.valueOf(request.getParameter("num"));
                for (int i = 0; i < n; i++) {
                    int vis1 = Visit.doVisit((String)session.getAttribute("login"), request.getParameter("VisitPoi"+i), request.getParameter("VisitDate"+i), Integer.valueOf(request.getParameter("cost"+i)), Integer.valueOf(request.getParameter("numberofheads"+i)));
                    if (vis1 == 0) vis = 0;
                }
                if (vis == 1) {
        %>
        <script>
	    if (!alert("Visit Success.")) location.href = 'index.jsp';
	</script>
        <% } else { %>
        <script>
	    if (!alert("Visit Fail.")) location.href = 'index.jsp';
	</script>
        <% } %>
        <% } %>
    </body>
</html>
