<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<spring:url value="/resources/jquery-1.11.1/" var="jquery" />
<spring:url value="/resources/bootstrap/css" var="bootstrapCSS" />
<spring:url value="/resources/bootstrap/js" var="bootstrapJS" />
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap.min.css" />
<link rel="stylesheet" href="${bootstrapCSS}/bootstrap-theme.min.css" />
<script src="${jquery}/jquery-1.11.1.min.js"></script>
<script src="${jquery}/jquery.dataTables.min.js"></script>
<script src="${bootstrapJS}/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>
</head>

<style>
body {
	padding-top: 70px;
	padding-bottom: 30px;
}

.theme-dropdown .dropdown-menu {
	position: static;
	display: block;
	margin-bottom: 20px;
}

.theme-showcase>p>.btn {
	margin: 5px 0;
}

.theme-showcase .navbar .container {
	width: auto;
}

.thead-inverse th {
	color: #fff;
	background-color: #373a3c;
}

.input-group {
	margin-bottom: 10px;
}

#modalImg {
	margin-bottom: 10px;
}

#modalPrice {
	margin-bottom: 10px;
}
</style>

<!--
change button color to black
.btn-primary {
	background-image: linear-gradient(#484e55, #3a3f44 60%, #313539);
}
-->
<body>
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		boolean isAdmin = loggedinID.equals("admin");
		request.setAttribute("loggedinID", loggedinID);
		request.setAttribute("isAdmin", isAdmin);
	%>
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
					<li><a href="aboutPage">About Us</a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">${loggedinID}<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href=<c:url value='/view-${loggedinID}-my-products' />>View My Books</a></li>
							<li><a href=<c:url value='/edit-${loggedinID}-user'/>>Edit Personal Information</a></li>
							<li><a href="logout">Sign Out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- navbar end -->

	<div class="container">
		<!-- jumbotron for a primary marketing message or call to action -->
		<div class="jumbotron">
			<h1>
				Welcome
				<%=loggedinID%>!
			</h1>
			<p>Contact xxx-xxx-xxxx for issue</p>
		</div>
		<!-- jumbotron end -->
		<div class="page-header">
			<h1>Products</h1>
		</div>

		<div class="row">
			<div class="col-lg-6">
				<div class="input-group">
					<input id="keyword" type="text" class="form-control"
						placeholder="Search Textbook Name..."> <span
						class="input-group-btn"> <a type="button"
						id="btnSearchByTitle" class="btn btn-default">Search</a>
					</span>
				</div>
			</div>
			<!-- table -->
			<table class="table table-striped" id="productsTable">
				<thead class="thead-inverse">
					<tr>
						<th>Textbook Name</th>
	
						<th>Seller's User ID</th>

						<th>Price($)</th>

						<th>Textbook Status</th>

						<th>Registration Date</th>

						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${products}" var="product">
						<tr data-name='${product.name}' data-price='${product.price}'
							data-imageurl='${product.imageURL}'
							data-description='${product.description}'>
							<td><a data-toggle="modal" data-target="#modalViewProduct"><Strong>${product.name}</Strong></a></td>
							<td>${product.user.user_id}</td>
							<td>${product.price}</td>
							<c:choose>
								<c:when test="${loggedinID == product.user.user_id || isAdmin}">
									<td>
										<form id="radioForm">
											<label class="radio-inline"><input type="radio"
												name="radioStatus" id="radioSelling"
												data-productid='${product.product_id}' value="selling"
												${product.status == 'selling'?'checked':''}>selling</label>
											<label class="radio-inline"><input type="radio"
												name="radioStatus" id="radioSold"
												data-productid='${product.product_id}' value="sold"
												${product.status == 'sold'?'checked':''}>sold</label>
										</form>
									</td>
								</c:when>
								<c:otherwise>
									<td id="rowStatus">${product.status}</td>
								</c:otherwise>
							</c:choose>
							<td>${product.registration_date}</td>
							<c:choose>
								<c:when test="${isAdmin}">
									<td><a id="editBtn" data-para="${product.product_id}" class="btn btn-sm btn-primary" data-toggle="modal"
										data-target="#modalEditProduct"><span
											class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
											class="glyphicon-class">Edit</span></a> <a
											class="btn btn-sm btn-primary"
											href="<c:url value='/delete-${product.product_id}-product' />"><span
												class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
												class="glyphicon-class">Delete</span></a> <a
											class="btn btn-sm btn-primary" id="btnSendEmail"
											href="<c:url value='/email-${loggedinID}-${product.product_id}' />"><span
												class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
												class="glyphicon-class">Send Email</span></a></td>
								</c:when>

								<c:when test="${loggedinID == product.user.user_id}">
									<td><a id="editBtn" data-para="${product.product_id}" class="btn btn-sm btn-primary" data-toggle="modal"
										data-target="#modalEditProduct"><span
											class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
											class="glyphicon-class">Edit</span></a> <a
										class="btn btn-sm btn-primary"
										href="<c:url value='/delete-${product.product_id}-product' />"><span
											class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
											class="glyphicon-class">Delete</span></a></td>
								</c:when>
								<c:when test="${loggedinID ne product.user.user_id}">
									<td><a class="btn btn-sm btn-primary" id="btnSendEmail"
										href="<c:url value='/email-${loggedinID}-${product.product_id}' />"><span
											class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
											class="glyphicon-class">Send Email</span></a></td>
								</c:when>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- table end -->
			<!-- Modal View Product-->
			<div id="modalViewProduct" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title" id="inpViewTitle"></h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Price:</label>
								</div>
								<div class="col-md-4">
									<input id="inpViewPrice" type="number" readonly
										class="form-control input-sm">
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Image:</label>
								</div>
								<div class="col-md-4">
									<img id="inpViewImage" src="" style="width: 304px; height: 228px;">
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Description:</label>
								</div>
								<div class="col-md-4">
									<input id="inpViewDescription" type="text" readonly
										class="form-control input-sm">
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Modal Sell Product -->
		<form action="newProduct" method="POST" enctype="multipart/form-data"
			name="send">
			<input type="hidden" name="${status.expression}"
				value="<%=session.getAttribute("user_id")%>" />
			<div id="modalSellProduct" class="modal fade" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">New Book</h4>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Title:</label>
								</div>
								<div class="col-md-4">
									<spring:bind path="product.name">
										<input id="inpNewName" type="text" class="form-control input-sm"
											name="${status.expression}" value="${status.value}">
										<span class="fieldError">${status.errorMessage}</span>
									</spring:bind>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Price:</label>
								</div>
								<div class="col-md-4">
									<spring:bind path="product.price">
										<input id="inpNewPrice" type="number"
											class="form-control input-sm" name="${status.expression}"
											value="${status.value}">
										<span class="fieldError">${status.errorMessage}</span>
									</spring:bind>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Image:</label>
								</div>
								<div class="col-md-4">
									<spring:bind path="product.imageURL">
										<input id="inpNewImage" type="file" name="file" />
										<span class="fieldError">${status.errorMessage}</span>
									</spring:bind>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4">
									<label class="form-group">Description:</label>
								</div>
								<div class="col-md-4">
									<spring:bind path="product.description">
										<input id="inpNewDescription" type="text"
											class="form-control input-lg" name="${status.expression}"
											value="${status.value}">
										<span class="fieldError">${status.errorMessage}</span>
									</spring:bind>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<a class="btn btn-sm btn-primary" id="btnSubmit"
								href="javascript:validateProductInfo();"><span
								class="glyphicon glyphicon-ok" aria-hidden="true"></span><span
								class="glyphicon-class"> Submit</span></a>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	
	<!-- Modal Edit Product -->
	<form action="editProduct" method="POST" enctype="multipart/form-data"
		name="modify">
		<input type="hidden" name="${status.expression}"
			value="<%=session.getAttribute("user_id")%>" />
		<div id="modalEditProduct" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-body">
						<div class="row">
							<div class="col-md-4">
								<label class="form-group">Title:</label>
							</div>
							<div class="col-md-4">
								<spring:bind path="product.name">
									<input id="inpEditTitle" type="text" class="form-control input-sm"
										name="${status.expression}" value="${status.value}">
									<span class="fieldError">${status.errorMessage}</span>
								</spring:bind>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<label class="form-group">Price:</label>
							</div>
							<div class="col-md-4">
								<spring:bind path="product.price">
									<input id="inpEditPrice" type="number"
										class="form-control input-sm" name="${status.expression}"
										value="${status.value}">
									<span class="fieldError">${status.errorMessage}</span>
								</spring:bind>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<label class="form-group">Image:</label>
							</div>
							<div class="col-md-4">
								<spring:bind path="product.imageURL">
									<input id="inpEditImage" type="file" name="file" />
									<span class="fieldError">${status.errorMessage}</span>
								</spring:bind>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4">
								<label class="form-group">Description:</label>
							</div>
							<div class="col-md-4">
								<spring:bind path="product.description">
									<input id="inpEditDescription" type="text"
										class="form-control input-lg" name="${status.expression}"
										value="${status.value}">
									<span class="fieldError">${status.errorMessage}</span>
								</spring:bind>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<a class="btn btn-sm btn-primary" id="btnSubmit"
							href="javascript:validateEditProductInfo();"><span
							class="glyphicon glyphicon-ok" aria-hidden="true"></span><span
							class="glyphicon-class"> Modify Book Information</span></a>
						<button type="button" class="btn btn-primarxy"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</form>


	<div id="action" align="center">
		<a class="btn btn-lg btn-primary" data-toggle="modal"
			data-target="#modalSellProduct"><span
			class="glyphicon glyphicon-plus" aria-hidden="true"></span> <span
			class="glyphicon-class">Sell Book</span></a> <a
			class="btn btn-lg btn-primary"
			href=<c:url value='/view-${loggedinID}-my-products' />><span
			class="glyphicon glyphicon-edit" aria-hidden="true"></span> <span
			class="glyphicon-class">View Your Books</span></a>
	</div>
</body>

<script>
	function validateProductInfo() {
		var oTitle = document.getElementById('inpNewName').value;
		var oPrice = document.getElementById('inpNewPrice').value;
		var oImageFile = document.getElementById('inpNewImage').files.length;
		if(!oTitle)
			alert("Please fill in the title");
		else if(!oPrice)
			alert("Please fill in the price");
		else if(oImageFile == 0)
			alert("Please attach an image file");
		else
			document.send.submit();
	}
	
</script>

<script>
	function validateEditProductInfo() {
		var oTitle = document.getElementById('inpEditTitle').value;
		var oPrice = document.getElementById('inpEditPrice').value;
		var oImageFile = document.getElementById('inpEditImage').files.length;
		if(!oTitle)
			alert("Please fill in the title");
		else if(!oPrice)
			alert("Please fill in the price");
		else if(oImageFile == 0)
			alert("Please attach an image file");
		else
			document.modify.submit();
	}
</script>

<script>


$(document).ready(function() {
	
	$("#productsTable").dataTable ({
		"iDisplayLength": 10,
		"aLengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
		"order": [[ 4, 'desc']]
	});

	$("#btnSendEmail").click(function() {
		var res = confirm("Send Email?");
		if (res) {
			alert("Email Succssfully Sent!");
		} else {
			$("#btnSendEmail").attr("href",
					"/Duke-Textbook-Exchange/dashboard");
		}
	});

	$("#btnSearchByTitle").click(function() {
		$("#btnSearchByTitle").attr("href", "/Duke-Textbook-Exchange/dashboard/search-" + $("#keyword").val());
	});

	$('td > a').click(function() {
		$('#inpViewTitle').text($(this).parent().parent().data('name'));
		$('#inpViewPrice').val($(this).parent().parent().data('price'));
		$("#inpViewImage").attr("src", $(this).parent().parent().data('imageurl'));
		$('#inpViewDescription').val($(this).parent().parent().data('description'));
	});
	
	$("#editBtn").click(function() {
		var product_id = this.dataset['para'];
		$('form[name=modify]').attr("action", "editProduct-" + product_id);
		$('#inpEditTitle').text($(this).parent().parent().data('name'));
		$('#inpEditPrice').val($(this).parent().parent().data('price'));
		$("#inpEditImage").attr("src", $(this).parent().parent().data('imageurl'));
		$('#inpEditDescription').val($(this).parent().parent().data('description'));
	});
	

	$('#radioForm input').on('change', function() {
		var stat = $('input[name=radioStatus]:checked').val();
		var product_id = $(this).data('productid');
		var dataObj = new Object();
		dataObj.id = product_id;
		dataObj.status = stat;
		var jsonObj = JSON.stringify(dataObj);
		$.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json;charset=utf-8'
			},
			type : 'post',
			url : '/Duke-Textbook-Exchange/update',
			data : jsonObj,
			dataType : 'json',
			success : function(json) {
				alert("Status updated!");
			}
		});
	});

	$('#radioForm input').on('change', function() {
		var stat = $('input[name=radioStatus]:checked').val();
		var product_id = $(this).data('productid');
		var dataObj = new Object();
		dataObj.id = product_id;
		dataObj.status = stat;
		var jsonObj = JSON.stringify(dataObj);
		$.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json;charset=utf-8'
			},
			type : 'post',
			url : '/Duke-Textbook-Exchange/update',
			data : jsonObj,
			dataType : 'json',
			success : function(json) {
				alert("Status updated!");
			}
		});
	});
});
</script>
</html>