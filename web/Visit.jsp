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
    </body>
</html>
