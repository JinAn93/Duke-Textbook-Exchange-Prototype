<%--
	Document	: logout
	Created on	: June 21st, 2016
	Author		: Seung Jin An
--%>

<%
	session.setAttribute("user_id", null);
	session.invalidate();
	response.sendRedirect("/Duke-Textbook-Exchange/login");
%>
