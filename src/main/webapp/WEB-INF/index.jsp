<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en" class="h-100">

<head>
<meta charset="UTF-8">
<title>Index</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link href="./css/style.css" rel="stylesheet" />
</head>

<body class="d-flex h-100 text-center bg-light">

	<div class="cover-container d-flex w-100 h-100 p-3 mx-auto flex-column">
		<h1>PillPal!</h1>
		<div class="container p-5">
			<h1>Register</h1>
			<form:form action="/register" method="post" modelAttribute="newUser">
				<div class="form-group p-2">
					<form:label path="userName">User Name: </form:label>
					<br>
					<form:input path="userName" class="form-control" />
					<form:errors path="userName" class="text-danger" />
				</div>
				<div class="form-group p-2">
					<form:label path="email">Email: </form:label>
					<br>
					<form:input path="email" class="form-control" />
					<form:errors path="email" class="text-danger" />
				</div>
				<div class="form-group p-2">
					<form:label path="password">Password: </form:label>
					<br>
					<form:input type="password" path="password" class="form-control" />
					<form:errors path="password" class="text-danger" />
				</div>
				<div class="form-group p-2">
					<form:label path="confirm">Confirm PW: </form:label>
					<br>
					<form:input type="password" path="confirm" class="form-control" />
					<form:errors path="confirm" class="text-danger" />
				</div>
				<input class="btn btn-outline-primary" type="submit" value="Submit" />
			</form:form>
		</div>
		<div class="container p-5">
			<h1>Log in</h1>
			<form:form action="/login" method="post" modelAttribute="newLogin">
				<div class="form-group p-2">
					<form:label path="email">Email: </form:label>
					<br>
					<form:input path="email" class="form-control" />
					<form:errors path="email" class="text-danger" />
				</div>
				<div class="form-group p-2">
					<form:label path="password">Password: </form:label>
					<br>
					<form:input type="password" path="password" class="form-control" />
					<form:errors path="password" class="text-danger" />
				</div>
				<input class="btn btn-outline-primary" type="submit" value="Submit" />
			</form:form>
		</div>

		<footer class="mt-auto text-white-50 p-5">
			<p class="text-start">Doohwoi Kim @2023-04-24</p>
		</footer>
	</div>



</body>

</html>