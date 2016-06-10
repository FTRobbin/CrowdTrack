<%-- 
    Document   : FeedbackSubmit
    Created on : 2016-6-10, 12:40:31
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Feedback Submit</title>
    </head>
    <body>
        <% if (request.getParameter("searchAttribute")==null) {
            out.println("Access Forbidden!");
           } else {
            int flag = FeedbackOperations.setFeedback((String)session.getAttribute("login"),Integer.valueOf(request.getParameter("pid")),Integer.valueOf(request.getParameter("Score")),request.getParameter("Text"));
            if (flag == 1) {
        %>
                <script>
			if (!alert("Feedback Success.")) location.href = 'index.jsp';
		</script>
        <%  } else { %>
                <script>
			if (!alert("Feedback Fail.")) location.href = 'index.jsp';
		</script>
        <%  }%>
        <%  }%>
    </body>
</html>
