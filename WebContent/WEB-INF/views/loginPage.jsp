<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
 <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
   <!-- Latest compiled and minified CSS -->
<spring:url value="/resources/jquery-1.11.1/" var="jquery" />
<spring:url value="/resources/bootstrap/css" var="bootstrapCSS" />
<spring:url value="/resources/bootstrap/js" var="bootstrapJS" />
<spring:url value="/resources/external" var="external"/>
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap.min.css" />
<link rel="stylesheet" href="${external}/font-awesome/css/font-awesome.min.css" />
<link rel="stylesheet" href="${external}/css/form-elements.css">
<link rel="stylesheet" href="${external}/css/style.css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media
    queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file://
    -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

  </head>
  <style>
  a, a:hover, a:focus {
    color: #fff;
}
button.btn {
	background: #337ab7;
}
  </style>
  <body>
    <!-- Top content -->
    <c:choose>
		<c:when test="${loggedinID == null}">
    <div class="top-content">
      <div class="inner-bg">
        <div class="container">
          <div class="row">
            <div class="col-sm-8 col-sm-offset-2 text">
              <h1>
                <strong>Duke</strong> Textbook Exchange</h1>
              <div class="description">
                <p>Web app for Textbook exchange between <strong>Duke</strong> students</p>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-sm-offset-3 form-box">
              <div class="form-top">
                <div class="form-top-left">
                  <h3>Login</h3>
                  <p>Enter your username and password to log on:</p>
                </div>
                <div class="form-top-right">
                  <i class="fa fa-lock"></i>
                </div>
              </div>
              <div class="form-bottom">
                <form role="form" action="validate" method="get" class="login-form">
                  <div class="form-group">
                    <label class="sr-only" for="userID">User ID</label>
                    <input type="text" name="userID" placeholder="UserID..."
                    class="form-userId form-control" id="form-userId">
                  </div>
                  <div class="form-group">
                    <label class="sr-only" for="form-password">Password</label>
                    <input type="password" name="password" placeholder="Password..."
                    class="form-password form-control" id="form-password">
                  </div>
                  <button type="submit" class="btn" name="btnLogin" value="login">Sign in!</button>
                  <div class="col-md-4"><a href="new">New Account</a></div>     
                </form>
              </div>              
            </div>
          </div>
        </div>
      </div>
    </div>
    	</c:when>
		<c:otherwise>
			<%
				response.sendRedirect("/Duke-Textbook-Exchange/dashboard");
			%>
		</c:otherwise>
	</c:choose>
  </body>
<!-- Javascript -->
<script src="${jquery}/jquery-1.11.1.min.js"></script>
<script src="${bootstrapJS}/bootstrap.min.js"></script>
<script src="${external}/js/jquery.backstretch.min.js"></script>
<script src="${external}/js/scripts.js"></script>
<!--[if lt IE 10]>
<script src="assets/js/placeholder.js"></script>
<![endif]-->
