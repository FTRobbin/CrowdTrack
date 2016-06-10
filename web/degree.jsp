<%-- 
    Document   : degree
    Created on : 2016-6-10, 7:18:52
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Degree</title>
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
           
        Get Users Degree:
        <form name="director_search" method=get onsubmit="return check_all_fields(this)" action="degree.jsp">
                <input type=hidden name="searchAttribute" value="degree">
                User1 login:<input type=text name="user1" length=50>
                User2 login:<input type=text name="user2" length=50>
                <input type=submit value="Compute">
        </form>
        <a href="index.jsp">Back</a>
        <% } else {
               int deg = Visit.doVisit((String)session.getAttribute("login"), request.getParameter("VisitPoi"), request.getParameter("VisitDate"), Integer.valueOf(request.getParameter("cost")), Integer.valueOf(request.getParameter("numberofheads")));
               out.println("User Degree: "+Integer.toString(deg));
        %>
        <a href="index.jsp">Back</a>
        <% } %>
    </body>
</html>
