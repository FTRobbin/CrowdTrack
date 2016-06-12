<%-- 
    Document   : PrivilegeLevelHide
    Created on : Jun 12, 2016, 6:25:35 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

	<%
	    String privilege = (String)session.getAttribute("privilege");
	    int lev = 0;
	    if (privilege == null) {
		lev = 0;
	    } else {
		lev = Integer.valueOf(privilege);
	    }
	    int required = Integer.valueOf((String)request.getParameter("requiredPL"));
	    if (required <= lev) {
		%>
			<%= request.getParameter("content") %>
		<%
	    }
	%>