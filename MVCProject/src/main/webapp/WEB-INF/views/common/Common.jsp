<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/style.css" />
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
		<script>
			var xhr = new XMLHttpRequest();
			
			function backToHome() {
				location.replace(location.origin);
			}
			
			function redirectUrl(url) {
				location.replace(url);
			}
			
			
		</script>
		
		
	</head>

	<body>
		<jsp:include page="Top.jsp" />
		<section>
			<sitemesh:write property='head'/>
			<sitemesh:write property='body'/>
		</section>
	</body>
</html>