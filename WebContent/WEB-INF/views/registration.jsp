<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>
<head>
<spring:url value="/resources/jquery-1.11.1/" var="jquery" />
<spring:url value="/resources/bootstrap/css" var="bootstrapCSS" />
<spring:url value="/resources/bootstrap/js" var="bootstrapJS" />
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap.min.css" />
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap-theme.min.css" />
<script src="${jquery}/jquery-1.11.1.min.js"></script>
<script src="${bootstrapJS}/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Form</title>
</head>

<style>
.error {
	color: #ff0000;
}

body {
	margin: auto;
	text-align: center;
	padding: 70px;
	font-family: Helvetica;
}

input {
	font-family: Helvetica;
}

h1 {
	text-align: center;
}
</style>

<body>
	<div class="jumbotron">
		<c:choose>
			<c:when test="${edit}">
				<h1>Modify Your Account!</h1>
			</c:when>
			<c:otherwise>
				<h1>Create Your Account!</h1>
			</c:otherwise>
		</c:choose>
	</div>
	<form:form method="POST" modelAttribute="user">
		<table class="userDetails" align="center">
			<tr>
				<td><label for="user_id">User ID: </label></td>
				<c:choose>
					<c:when test="${edit}">
						<td><form:input path="user_id" id="user_id" readonly="true" /></td>
					</c:when>
					<c:otherwise>
						<td><form:input path="user_id" id="user_id" /></td>
					</c:otherwise>
				</c:choose>				
				<td><form:errors path="user_id" cssClass="error" /></td>
			</tr>
			<c:choose>
				<c:when test="${edit}"> 
					<td><form:input type="hidden" path="password" id="password"/></td>
				</c:when>
				<c:otherwise>
				<tr>
					<td><label for="password">Password: </label>
					<td><form:input type="password" path="password" id="password" /></td>
					<td><form:errors path="password" cssClass="error" /></td>
				</tr>
				</c:otherwise>
			</c:choose>		
							
			<tr>
				<td><label for="first_name">First Name: </label></td>
				<td><form:input path="first_name" id="first_name" /></td>
				<td><form:errors path="first_name" cssClass="error" /></td>
			</tr>

			<tr>
				<td><label for="last_name">Last Name: </label></td>
				<td><form:input path="last_name" id="last_name" /></td>
				<td><form:errors path="last_name" cssClass="error" /></td>
			</tr>
			
			<tr>
				<td><label for="email">Email: </label></td>
				<td><form:input path="email" id="email" /></td>
				<td><form:errors path="email" cssClass="error" /></td>
			</tr>

			<tr>
				<td><label for="phone_number">Phone Number: </label></td>
				<td><form:input path="phone_number" id="phone_number" /></td>
				<td><form:errors path="phone_number" cssClass="error" /></td>
			</tr>

			<tr>
				<td colspan="3">
					<c:choose>
						<c:when test="${edit}">
							<input type="submit" value="Update" />
						</c:when>
						<c:otherwise>
							<input type="submit" value="Register" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</form:form>
	<br />
	<br />			
	Go back to <a href="login"><c:choose> <c:when test="${edit}"> Dashboard </c:when> <c:otherwise>Login Page</c:otherwise></c:choose></a>
</body>
</html>