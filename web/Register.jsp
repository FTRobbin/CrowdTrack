<%-- 
    Document   : Register
    Created on : Jun 9, 2016, 3:31:40 PM
    Author     : RobbinNi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<script Language="JavaScript">
	function checkAllFields(formObj) {
		//alert(formObj.login.value + formObj.name.value + formObj.pass.value + formObj.confirmPass.value);
		if (formObj.login.value == "" || formObj.name.value == "" || formObj.pass.value == "" || formObj.confirmPass.value == "") {
			alert("None of the fields can be empty!");
			return false;
		}
		if (formObj.pass.value !== formObj.confirmPass.value) {
			alert("The passwords are not the same!");
			return false;
		}
		return true;
	}
</script>	

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
	<h1>Register a new user</h1>
        <form name="regForm" method="POST" onsubmit="return checkAllFields(this)" action="RegisterSubmit.jsp">
	    Login : <div><input type="text" name="login" maxlength="30"> </div> <br/>
	    Username : <div><input type="text" name="name" maxlength="40"> </div> <br/>
	    Password : <div><input type="password" name="pass" maxlength="30"> </div> <br/>
	    Confirm Password : <div><input type="password" name="confirmPass" maxlength="30"> </div> <br/>
	    <input type="submit"> 
	</form>

	<br/>
	<a href="index.jsp">Back</a>	

    </body>
</html>
