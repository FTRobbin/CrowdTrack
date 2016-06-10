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
        <jsp:include page="PrivilegeLevel.jsp" />
        <% if (session.getAttribute("privilege") != null && Integer.valueOf((String)session.getAttribute("privilege"))>=2) { %>
        <% String searchAttribute = request.getParameter("searchAttribute");
           if( searchAttribute == null ){ %>
           
        New POI:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="orders.jsp">
                <input type=hidden name="searchAttribute" value="New">
                POI name:<input type=text name="poiName" length=50>
                POI category:<input type=text name="poiCategory" length=30>
                <input type=submit value="New">
        </form>
        <BR><BR>
        Update POI:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="orders.jsp">
                <input type=hidden name="searchAttribute" value="Update">
                Pid:<input type=text name="pid" length=10>
                POI name:<input type=text name="poiName" length=50>
                POI category:<input type=text name="poiCategory" length=30>
                <input type=submit value="Update">
        </form>

        <% } else {
                if (request.getParameter("searchAttribute")=="New") {
                    int flag = POIOperations.addPoi(request.getParameter("poiName"), request.getParameter("poiCategory"));
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
                if (request.getParameter("searchAttribute")=="Update") {
                    int flag = POIOperations.updatePoi(Integer.valueOf(request.getParameter("pid")), request.getParameter("poiName"), request.getParameter("poiCategory"));
                    if (flag == 1) {
        %>
        <script>
	    if (!alert("New Success.")) location.href = 'index.jsp';
	</script>
        <%          } else { %>
        <script>
	    if (!alert("New Fail.")) location.href = 'index.jsp';
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
