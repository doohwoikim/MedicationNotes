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
<title>Project</title>
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

.navbar{
		margin: 0 auto;
		max-width: 1200px
	}
</style>
<body class="h-100 text-center bg-light">
	<nav class="navbar navbar-expand-lg">
		<a class="navbar-brand p-3" href="/dashboard">Welcome, <c:out
				value="${userName }" />
		</a>
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
	<div class="card" style="width: 18rem;">
		<div class="card-body">
			<h1>
				<c:out value="${oneMedication.name}" />
			</h1>
			<h6 class="card-subtitle mb-2 text-muted text-end">
				<fmt:formatDate value="${oneMedication.date}" pattern="MMMM dd" />
			</h6>
			<h6 class="text-end">
				Added By:
				<c:out value="${oneMedication.user.userName}" />
			</h6>
			<p class="card-text">
				<c:out value="${oneMedication.note}" />
			</p>
			<c:if test="${oneMedication.user.id.equals(userId) }">
				<form action="/medications/delete/${oneMedication.id }"
					method="POST">
					<input type="hidden" name="_method" value="delete" />
					<button class="btn btn-danger" type="submit">Delete</button>
				</form>
			</c:if>
		</div>
	</div>
	<footer class="mt-auto text-white-50 p-5">
			<p class="text-start">Doohwoi Kim @2023-04-24</p>
		</footer>
	<script src="/js/script.js"></script>
</body>
</html>
