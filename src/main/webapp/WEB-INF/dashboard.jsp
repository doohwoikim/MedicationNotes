<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<%@ page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en" class="h-100">

<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
<link href="./css/style.css" rel="stylesheet" />
</head>
<style>
* {
	margin: 0 auto;
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
	<h3 class="text-center">
		Today's Date :
		<%=(new java.util.Date()).toLocaleString()%>
	</h3>
	<hr>



	<div class="d-flex container w-85 p-2 mt-3">
		<table class="table mt-5">
			<thead>
				<h4>Today's Medication</h4>
				<tr>
					<th>Name</th>
					<th>Due Date</th>
					<th colspan="2">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="medi" items="${takenMedications}">
					<tr>
						<td><a href="/medications/<c:out value=" ${medi.id}" />">
								<c:out value="${medi.name}" />
						</a></td>
						<td><fmt:formatDate value="${medi.date}"
								pattern="MMMM dd yyyy" /></td>
						<td><c:if test="${medi.user.id == loggedUser.id}">
								<a href="/medications/edit/${medi.id}"><button
										class="btn btn-primary">Edit</button></a>
							</c:if> <a href="/dashboard/undo/${medi.id}"><button
									class="btn btn-success">Move</button></a></td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		<h4>Medication List</h4>
		<table class="table mt-5">
			<thead>
				<tr>
					<th>Name</th>
					<th>Due Date</th>
					<th colspan="2">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="medi" items="${untakenMedications}">
					<tr>
						<td><a href="/medications/<c:out value=" ${medi.id}" />">
								<c:out value="${medi.name}" />
						</a></td>
						<td><fmt:formatDate value="${medi.date}"
								pattern="MMMM dd yyyy" /></td>
						<td><a href="/dashboard/take/${medi.id}"><button
									class="btn btn-success">Move</button></a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<footer class="mt-auto text-white-50 p-5">
		<p class="text-start">Doohwoi Kim @2023-04-24</p>
	</footer>
	<script src="/js/script.js"></script>



</body>

</html>