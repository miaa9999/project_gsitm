<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>일단 여기가 메인화면 입니다</h2>
<c:url var="cusManagementUrl" value="/cus/cus_management" />
<button type="button"><a href="${cusManagementUrl}">고객 정보 관리</a></button>
</body>
</html>