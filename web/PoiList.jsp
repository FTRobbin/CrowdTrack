<%-- 
    Document   : PoiList
    Created on : Jun 9, 2016, 9:24:27 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java" import="java.util.*,ApplicationInterface.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Poi List</title>
    </head>
    <body>
	<%
	    ArrayList<ArrayList<String> > list = null;
	    int special = 0;
	    String extraCol = "";
	    if (request.getParameter("isStat") != null && request.getParameter("isStat").equals("true")) {
		int top = Integer.valueOf((String)request.getParameter("topnum"));
		String cate = (String)request.getParameter("category"),
			cond = cate.equals("All") ? "" : "AND category=\"" + cate + "\" ";
		if (request.getParameter("sortg").equals("visits")) {
		    special = 3;
		    extraCol = "Visits";
		    list = POIOperations.getFavList(POIOperations.getMostVisitsList(top, cond), (String)session.getAttribute("login"));
		} else if (request.getParameter("sortg").equals("price")) {
		    special = 4;
		    extraCol = "Cost";
		    list = POIOperations.getFavList(POIOperations.getMostExpensiveList(top, cond), (String)session.getAttribute("login"));
		} else if (request.getParameter("sortg").equals("score")) {
		    special = 5;
		    extraCol = "Score";
		    list = POIOperations.getFavList(POIOperations.getHighestRatedList(top, cond), (String)session.getAttribute("login"));
		}
	    } else {
		ArrayList<String> conditions = new ArrayList<>();
		if (request.getParameter("minp") != null && request.getParameter("minp") != "") {
		    conditions.add("price >= " + request.getParameter("minp"));
		}
		if (request.getParameter("maxp") != null && request.getParameter("maxp") != "") {
		    conditions.add("price <= " + request.getParameter("maxp"));
		}
		if (request.getParameter("istate") != null && request.getParameter("istate") != "") {
		    conditions.add("istate = \"" + request.getParameter("istate") + "\"");
		}
		if (request.getParameter("city") != null && request.getParameter("city") != "") {
		    conditions.add("city = \"" + request.getParameter("city") + "\"");
		}
		if (request.getParameter("category") != null && request.getParameter("category") != "") {
		    conditions.add("category = \"" + request.getParameter("category") + "\"");
		}
		String query = "";
		if (conditions.size() > 0) {
		    query += "WHERE";
		    for (int i = 0; i < (int)conditions.size(); ++i) {
			if (i > 0) {
			    query += " AND";
			}
			query += " " + conditions.get(i);
		    }
		}
		if (request.getParameter("sortg") != null && request.getParameter("sortg") != "") {
		    String sortg = request.getParameter("sortg");
		    if (sortg.equals("pricei")) {
			    query += " ORDER BY price";
		    } else if (sortg.equals("priced")) {
			    query += " ORDER BY price DESC";
		    } else if (sortg.equals("avg")) {
			    special = 1;
			    extraCol = "Average";
		    } else if (sortg.equals("tavg")) {
			    special = 2;
			    extraCol = "Average";
		    }
		}
		int keywordCnt = 0;
		String keywordCondition = "";
		String numkeys = (String)request.getParameter("keynum");
		if (numkeys != null && numkeys != "") {
		    int numkey = Integer.valueOf(numkeys);
		    for (int i = 1; i <= numkey; ++i) { 
			if (request.getParameter("keywords" + i) != null) {
			    ++keywordCnt;
			    if (keywordCnt > 1) {
				keywordCondition += " OR";
			    }
			    keywordCondition += " wid = " + i;
			}
		    }
		    keywordCondition = "(" + keywordCondition + ")";
		}
		if (keywordCnt > 0) {
		    if (special != 0) {
			if (query.length() == 0) {
			    query = " WHERE";
			} else {
			    query += " AND ";
			}
			if (special == 1) {
				list = POIOperations.getFavList(POIOperations.getKeywordAvgSortedList(query, keywordCondition, keywordCnt), (String)session.getAttribute("login"));
			} else if (special == 2) {
				list = POIOperations.getFavList(POIOperations.getKeywordTrustAvgSortedList(query, (String)session.getAttribute("login"), keywordCondition, keywordCnt), (String)session.getAttribute("login"));
			}
		    } else {
			if (conditions.size() != 0) {
			    query = " AND " + query.substring(5);
			}
			if (query.length() > 0) {
			    list = POIOperations.getFavList(POIOperations.getKeywordList(query, keywordCondition, keywordCnt),(String)session.getAttribute("login"));
			} else {
			    list = POIOperations.getFavList(POIOperations.getKeywordList(keywordCondition, keywordCnt),(String)session.getAttribute("login"));
			}
		    }
		} else {
		    if (special != 0) {
			if (query.length() == 0) {
			    query = " WHERE";
			} else {
			    query += " AND ";
			}
			if (special == 1) {
				list = POIOperations.getFavList(POIOperations.getAvgSortedList(query), (String)session.getAttribute("login"));
			} else if (special == 2) {
				list = POIOperations.getFavList(POIOperations.getTrustAvgSortedList(query, (String)session.getAttribute("login")), (String)session.getAttribute("login"));
			}
		    } else {
			if (query.length() > 0) {
			    list = POIOperations.getFavList(POIOperations.getList(query),(String)session.getAttribute("login"));
			} else {
			    list = POIOperations.getFavList(POIOperations.getList(),(String)session.getAttribute("login"));
			}
		    }
		}
	    }
	%>
	
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
	<table class="table5" border=1 cellpadding="5">
	 <tr><th>Name</th><th>Category</th><th>State</th><th>City</th><th>Street</th><th>Price</th><%= special > 0 ? "<th>" + extraCol + "</th>" : "" %><th>Favorite</th></tr>
	 <%
	     for (ArrayList<String> ss : list) {
		 %>
			<tr>
		 <%
		 for (int i = 1; i < ss.size() - 1; ++i) {
		     %> <td> <%= ss.get(i) %> </td> <%
		 }
		 %>
		<%
		 //if (ApplicationInterface.POIOperations.userFavPoiQuery((String)session.getAttribute("login"), ss[0])) {
		 %> <td> <a href="Favorite.jsp?pid=<%= ss.get(0) %>"> <%= ss.get(ss.size() - 1) %> </a> </td> <%
		 %>
			</tr>
		 <%
	     }
	 %>
	</table>
	
	<br/>
	<form name="select" method="GET" action="PoiList.jsp">
	    <input type="hidden" name="isStat" value="false">
	    Price Range
	    <div>
		Min <input type="text" name="minp">
		Max <input type="text" name="maxp">
	    </div>
	    Location
	    <div>
		State <input type="text" name="istate"> City <input type="text" name="city">
	    </div>
	    Category
	    <div>
		<input type="text" name="category">
	    </div>
	    Sorted By 
	    <div>
		<input type="radio" name="sortg" value="none" checked> None
		<input type="radio" name="sortg" value="pricei"> Price Increasing
		<input type="radio" name="sortg" value="priced"> Price Decreasing
		<input type="radio" name="sortg" value="avg"> Average Score
		<input type="radio" name="sortg" value="tavg"> Trusted Average Score
	    </div>
	    Keywords
	    <div>
		<%
		    ArrayList<String[]> keywords = KeywordsOperations.getKeywordsList();
		    %>
		    <input type="hidden" name="keynum" value="<%= keywords.size()%>">
		    <%
		    for (String[] s : keywords) {
			%>
			<input type="checkbox" name="keywords<%= s[0] %>" value="checked"> <%= s[1] %>
			<%
		    }
		%>
	    </div>
	    <div> <input type="submit"> </div>
	</form>
	<br/>
	
	<form>
	    <input type="hidden" name="isStat" value="true">
	    <div> TOP <input type="text" name="topnum" value="5"> </div>
	    <div>
		<input type="radio" name="sortg" value="visits" checked> Most Visited
		<input type="radio" name="sortg" value="price"> Most Expensive
		<input type="radio" name="sortg" value="score"> Highest Rated
	    </div>
	    <div>
		In
		<%
		    ArrayList<String[]> categories = POIOperations.getCategoryList();
		%>
		<input type="hidden" name="catnum" value="<%= categories.size() %>">
		<select name="category">
			<option value="All">All</option>
			<%
			    for (String[] ss : categories) {
				%>
				<option value="<%= ss[0] %>"> <%= ss[0]%> </option>
				<%
			    }
			%>    
		</select>
	    </div>
	    <div>
		<input type="submit">
	    </div>
	</form>
	
	<br/>
	<a href="index.jsp">Back</a>	

    </body>
</html>
