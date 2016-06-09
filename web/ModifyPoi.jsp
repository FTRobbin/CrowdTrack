<%-- 
    Document   : ModifyPoi
    Created on : 2016-6-9, 7:41:07
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="DatabaseInterface.*"%>
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
        <% if (session.getAttribute("login") == null) { %>
            <p>Not login</p>
        <% } else { %>
            <p>Now user: <%= (String)session.getAttribute("login")%></p>
        <% } %>
        <% String searchAttribute = request.getParameter("searchAttribute");
           if( searchAttribute == null ){ %>
           
        New POI:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="orders.jsp">
                <input type=hidden name="searchAttribute" value="New">
                <input type=text name="poiName" length=50>
                <input type=text name="poiCategory" length=30>
                <input type=submit value="New">
        </form>
        <BR><BR>
        Update POI:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="orders.jsp">
                <input type=hidden name="searchAttribute" value="Update">
                <input type=text name="pid" length=10>
                <input type=text name="poiName" length=50>
                <input type=text name="poiCategory" length=30>
                <input type=submit value="Update">
        </form>

        <% } else {
           SQLExecutor.executeUpdate("INSERT INTO VisEvent VALUES ()");
           }
        %>
        <h1>Hello World!</h1>
    </body>
</html>
