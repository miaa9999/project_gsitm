<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 정보 관리</title>
</head>
<body>

<div class="cus_consult">
    <form method="get" action="<c:url value='/cus/consult_list' />">
        고객 시리얼 넘버 : <input type="text" name="custSn">
        <input type="submit" value="찾기">
    </form>
    <div>
        상담내역 :
    </div>
    <ul>
        <c:forEach var="consult" items="${consultList}">
            <li>${consult.cons_date}  ${consult.consultation}</li>
        </c:forEach>
    </ul>
</div>

</body>
</html>