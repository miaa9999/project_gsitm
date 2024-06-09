<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
</head>
<body>
<h2>일단 여기가 메인화면 입니다</h2><br>
	<li><a href="<c:url value='/customerInfoPage'></c:url>">고객정보관리</a></li>
</body>
</html>