<%-- 
    Document   : RatingSubmit
    Created on : 2016-6-10, 13:30:33
    Author     : yjt-Lab
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="ApplicationInterface.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rating Submit</title>
    </head>
    <body>
        <% if (request.getParameter("searchAttribute")==null) {
            out.println("Access Forbidden!");
           } else {
            int flag = FeedbackOperations.rateFeedback((String)session.getAttribute("login"),Integer.valueOf(request.getParameter("fid")),Integer.valueOf(request.getParameter("rate")));
            if (flag == 1) {
        %>
                <script>
			if (!alert("Rate Success.")) location.href = 'index.jsp';
		</script>
        <%  } else { %>
                <script>
			if (!alert("Rate Fail.")) location.href = 'index.jsp';
		</script>
        <%  }%>
        <%  }%>
    </body>
</html>
