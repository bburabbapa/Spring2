<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>doFboardWrite.jsp</title>
	</head>
	<body>
	  <c:choose>
	    <c:when test="${result=='write-s'}">
	     <script>
	       alert("게시글이 저장되었습니다.");
	       location.href="blist";
	     </script>
	   </c:when>
	  </c:choose>
	</body>
</html>