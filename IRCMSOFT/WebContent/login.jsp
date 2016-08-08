<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>ИРЦМ</title>
		
		<link href="css/style.css" rel="stylesheet">
		<link href="css/ui-lightness/jquery-ui-1.10.4.custom.css" rel="stylesheet">
		<script src="js/jquery-1.10.2.js"></script>
		<script src="js/jquery-ui-1.10.4.custom.js"></script>
	
		<script>
			$(function() {
				$("input:submit").button();
			});
		</script>
	
	</head>
	<body>
 		<div class = "main_block">
        	<form action="index" method="post">
        		<span class="ui-icon ui-icon-person" style="float:left; margin-right:.3em;"></span>Логин<br>
				<input type = "text" name = "login" id="login" autofocus required /><br><br>
            	<span class="ui-icon ui-icon-locked" style="float:left; margin-right:.3em;"></span>Пароль<br>
            	<input type = "password" name = "pass" id="pass" required ><br><br>

		    	<input type="submit" name="btn" value="Вход">
        	</form>
  		</div>
		${errlogin }
	</body>
</html>