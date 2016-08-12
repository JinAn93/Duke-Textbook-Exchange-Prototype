<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel = "stylesheet" href="/Duke-Textbook-Exchange/resources/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/Duke-Textbook-Exchange/resources/bootstrap/css/bootstrap-theme.min.css">


<script src="/Duke-Textbook-Exchange/resources/jquery-1.11.1//jquery-1.11.1.min.js"></script>
<script src="/Duke-Textbook_exchange/resources/bootstrap/js/bootstrap.min.js"></script>


<spring:url value="/resources/jquery-1.11.1/" var="jquery" />
<spring:url value="/resources/bootstrap/css" var="bootstrapCSS" />
<spring:url value="/resources/bootstrap/js" var="bootstrapJS" />
<spring:url value="external/img/backgrounds/Jin.jpg" var="profileImage"/>


<link rel="stylesheet" href="${bootstrapCSS}/bootstrap.min.css" />
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap-theme.min.css" />


<script src="${jquery}/jquery-1.11.1.min.js"></script>
<script src="${bootstrapJS}/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>About Page</title>

<style>
.error {
	color: #ff0000;
}

body {
	padding-top: 70px;
	padding-bottom: 30px;
	text-align: left;
	font-family: Helvetica;
}

input {
	font-family: Helvetica;
}

h1 {
	text-align: left;
	
}

h2 {
	text-align:left;

}

tr {
	border: 1px solid black;
}

.postForm {
	margin-left: 300px;
	margin-right: 300px;
	width: 1000px; 
	height: 500px;
	text-align: center;
}

#title{
	height: 40px;
	width: 750px;
	padding: 30px;
}

#contents{
	height: 400px;
	width: 750px;
	padding: 30px;
}

.theme-dropdown .dropdown-menu {
	position: static;
	display: block;
	margin-bottom: 20px;
}

.theme-showcase>p>.btn{
	margin: 5px 0;
}

.theme-showcase .navbar .container{
	width: auto;
}

</style>

<!--
change button color to black
.btn-primary {
	background-image: linear-gradient(#484e55, #3a3f44 60%, #313539);
}
-->


</head>
<body>
	<!-- navbar -->
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="dashboard">Duke Textbook Exchange</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="aboutPage" >About</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- navbar end -->
	
	<div class="container">
	
	
	<h1>About Us
	<small>Hello! It's nice to meet you!</small>
	</h1>
	<hr>
	

	<div class="jumbotron">
	<p>We aim to facilitate textbook exchange between college students by developing a robust and effective web application dedicated to textbook exchanging. The Duke Textbook Exchange App (referred to as DTE from now) will allow potential sellers to upload their textbooks to attract potential interested buyers.</p>
	</div>
	<div class="row">
	
	<div class="col-lg-12">
	<h2 class="page-header">Our Team</h2>
	</div>
	<div class="col-lg-4 col-sm-6 text-center">
	<img class="img-circle img-responsive img-center" src="https://s3.amazonaws.com/carduebucket/duke.jpg" style="margin: auto; height: 400px; width: 400px;">
	
	<h3>Jin An
	<small>Back End Developer</small>
	<p>Enter your description here</p>
	</h3>
	
	</div>
	
	<div class="col-lg-4 col-sm-6 text-center">
	<img class="img-circle img-responsive img-center" src="https://s3.amazonaws.com/carduebucket/duke.jpg" style="margin: auto; height: 400px; width: 400px;">
	
	<h3>Somi Choi
	<small>Back End/Front End Developer</small>
	<p>Enter your description here</p>
	</h3>
	
	</div>
	
	<div class="col-lg-4 col-sm-6 text-center">
	<img class="img-circle img-responsive img-center" src="https://s3.amazonaws.com/carduebucket/michin.jpg" style="margin: auto; height: 400px; width: 400px;">
	
	<h3>Jongho Shin
	<small>Front End Developer</small>
	<p>Enter your description here</p>
	</h3>
	
	</div>
	
	
	</div>
	<hr>
	

		
	<footer>
	 <div class="row">
		<div class="col-lg-12"><p>Copyright©Duke Textbook Exchange 2016</p>
		  </div>
	    </div>
	  </footer>
	
	
</body>
</html>