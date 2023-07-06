<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<title>OpenFDA Medication Search</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<style>
	*{
		max-width: 1200px;
		margin: 0 auto;
	}
</style>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
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
	<hr>
	<div class="container p-5 text-center">

	<form>
		<label for="medication-name">Enter medication name:</label> <input
			type="text" id="medication-name" name="medication-name" required>
		<button type="submit" onclick="getMedicationInfo()">Search</button>
	</form>
	<div id="medication-info"></div>
	<script src="/js/script.js"></script>
</div>
</body>
</html>

