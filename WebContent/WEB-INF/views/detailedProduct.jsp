<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Detailed Product</title>

<style>

.action {
	padding-top: 50px;
	padding-right: 300px;
    padding-left: 300px;
}

.productDetails {
	margin-left: 300px;
	margin-right: 300px;
	border: 1px solid black;
	width: 1000px; 
	height: "500";
}

td, tr{
	border: 1px solid black;
}

td:not(#contents) {
	text-align: center;
}

.comments {
	padding-right: 300px;
    padding-left: 300px;
    border-collapse: collapse;
    width: 100%;
}

#productContents {
	padding: 30px;
}
p {
	line-height: 10px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

pre {
	font-family: Helvetica;
}
</style>
</head>

<body>
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		request.setAttribute("loggedinID", loggedinID);
	%>
	
	<div class="action">
		<a href="dashboard"> Go Back to Dashboard</a>

		<c:choose>
			<c:when test="${loggedinID == product.user.user_id}">
				<a href="<c:url value='/edit-${product.product_id}-prodouct' />">Edit</a>
				<a href="<c:url value='/delete-${product.product_id}-product' />">Delete</a>
			</c:when>
		</c:choose>
		<br>
	</div>
	
	<table class="productDetails">
		<tr>
			<td width="150" height="45">Textbook Name</td>
			<td colspan="3">${product.name}</td>
		</tr>
		<tr>
			<td width="150" height="45">Date Registered</td>
			<td width="450">${product.registration_date}</td>
			<td width="150" height="45">Created By</td>
			<td>${product.user.user_id}</td>
		</tr>
	</table>

	<div class="comment">
		<br>
		<div class="commentHistory">
			<c:forEach items="${comments}" var="onecomment">
				<c:choose>
					<c:when test="${editCommentPressed && onecomment.comment_id == clickedReplyID}">
						<form:form id="editedComment" method="POST" modelAttribute="editComment">
							<form:input size="75" path="contents" id="contents" value="${onecomment.contents}" />
							<form:input size="10" path="post_date" id="post_date" value="${onecomment.post_date}" readOnly="true" />
							<input type="submit" value="Edit"/>
							<form:input path="id" type="hidden" id="id" value="${onecomment.comment_id}" />
						</form:form>
					</c:when>
					<c:otherwise>
						<p id="commentDisplay">${onecomment.user.user_id}: ${onecomment.contents} (${onecomment.post_date})
						<c:choose>
							<c:when test="${loggedinID == onecomment.user.user_id}">
								<a href="<c:url value='/edit-${product.product_id}-${onecomment.comment_id}-comment' />">Edit</a>
								<a href="<c:url value='/delete-${product.product_id}-${onecomment.comment_id}-comment' />">Delete</a>
							</c:when>
						</c:choose>
						</p>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
			
		<div id="newCommentRow">
			<form:form method="POST" modelAttribute="comment">
				<form:input size="75" path="contents" id="contents" value="Write Your Comment Here!" />
				<form:input size="10" path="post_date" id="post_date" value="${comment.post_date}" readOnly="true" />
				<input type="submit" value="Comment"/>
			</form:form>
		</div>
	</div>
</body>
</html>