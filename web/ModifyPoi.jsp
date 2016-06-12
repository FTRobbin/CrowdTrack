<%-- 
    Document   : ModifyPoi
    Created on : 2016-6-9, 7:41:07
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Modify POI</title>
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
		<jsp:param name="requiredPL" value="2"/>
	</jsp:include>

        <jsp:include page="PrivilegeLevel.jsp" />
	
        <% if (session.getAttribute("privilege") != null && Integer.valueOf((String)session.getAttribute("privilege"))>=2) { %>
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
        New POI:
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
        <BR><BR>
        Update POI:
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
        
        Add Keyword:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="ModifyPoi.jsp">
                <input type=hidden name="searchAttribute" value="Keyword">
                Pid:<input type=text name="pid" length=10>
                Keyword:<input type=text name="keyword" length=50>
                <input type=submit value="Add">
        </form>
        <a href="index.jsp">Back</a>
        <% } else {
                if (request.getParameter("searchAttribute").equals("New")) {
                    int flag = POIOperations.addPoi(request.getParameter("poiName"), request.getParameter("poiCategory"),request.getParameter("poiState"),request.getParameter("poiCity"),request.getParameter("poiStreet"),Double.parseDouble(request.getParameter("poiPrice")));
                    if (flag == 1) {
        %>
        <script>
	    if (!alert("New Success.")) location.href = 'index.jsp';
	</script>
        <%          } else { %>
        <script>
	    if (!alert("New Fail.")) location.href = 'index.jsp';
	</script>
        <%          } %>
        <%      }
                if (request.getParameter("searchAttribute").equals("Update")) {
                    int flag = POIOperations.updatePoi(Integer.valueOf(request.getParameter("pid")), request.getParameter("poiName"), request.getParameter("poiCategory"),request.getParameter("poiState"),request.getParameter("poiCity"),request.getParameter("poiStreet"),Double.parseDouble(request.getParameter("poiPrice")));
                    if (flag == 1) {
        %>
        <script>
	    if (!alert("Update Success.")) location.href = 'index.jsp';
	</script>
        <%          } else { %>
        <script>
	    if (!alert("Update Fail.")) location.href = 'index.jsp';
	</script>
        <%          } 
                }
                if (request.getParameter("searchAttribute").equals("Keyword")) {
                    int flag = KeywordsOperations.addKeyword(Integer.valueOf(request.getParameter("pid")), request.getParameter("keyword"));
                    if (flag == 1) {
        %>
        <script>
	    if (!alert("Add Keyword Success.")) location.href = 'index.jsp';
	</script>
        <%          } else { %>
        <script>
	    if (!alert("Add Keyword Fail.")) location.href = 'index.jsp';
	</script>
        <%          } 
                }
           }
        } else {
           out.print("No permission!");
        }
        %>
    </body>
</html>
