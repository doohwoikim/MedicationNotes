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
<title>Create</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link href="./css/style.css" rel="stylesheet" />
</head>
<style>
* {
	margin: 0 auto;
}

body {
	text-shadow: 0 .05rem .05rem rgba(0, 0, 0, .5);
	box-shadow: inset 0 0 5rem rgba(0, 0, 0, .5);
}

.navbar {
	margin: 0 auto;
	max-width: 1200px
}
</style>
<body class="h-100 text-center bg-light">
	<nav class="navbar navbar-expand-lg">
		<a class="navbar-brand p-3" href="/dashboard">Welcome, <c:out
				value="${userName }" /></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
				<li class="nav-link"><a class="nav-link" href="/dashboard">Home</a>
				</li>
				<li class="nav-link"><a class="nav-link"
					href="/medications/new">Add New</a></li>
				<li class="nav-link"><a class="nav-link"
					href="/medications/mymed">PillPal!</a></li>
			</ul>
			<form>
				<input type="text" id="medication-name" name="medication-name"
					required>
				<button class="btn btn-outline-primary" type="submit"
					onclick="getMedicationInfo()">Search</button>
			</form>
			<a href="/logout"><button class="btn btn-outline-danger">Log
					out</button></a>
		</div>
	</nav>
	<div id="medication-info"></div>
	<hr>
	<div class="container">
		<form:form class="w-50" action="/medications/new" method="post"
			modelAttribute="newMedication">
			<form:hidden path="user" value="${userId }" />
			<div class="form-group">
				<form:label path="name">Name: </form:label>
				<br>
				<form:input path="name" class="form-control" />
				<form:errors path="name" class="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="date">Date: </form:label>
				<br>
				<form:input type="date" path="date" class="form-control" />
				<form:errors path="date" class="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="note">Notes: </form:label>
				<br>
				<form:textarea path="note" class="form-control" />
				<form:errors path="note" class="text-danger" />
			</div>
			<input type="submit" value="Submit"
				class="btn btn-outline-primary mt-3" />
		</form:form>
	</div>
	<footer class="mt-auto text-white-50 p-5">
		<p class="text-start">Doohwoi Kim @2023-04-24</p>
	</footer>
	<script src="/js/script.js"></script>
</body>
</html>
