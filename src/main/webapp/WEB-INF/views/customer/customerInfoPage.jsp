<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Management</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
//초기에는 상담 내역이 숨겨져 있도록 설정
$(document).ready(function() {
    $('.consultation-container').hide();
});

function validateSearch() {
    var keyword = document.getElementById("keywordInput").value.trim();
    if (keyword === "") {
        document.getElementById("errorMessage").style.display = "inline";
    } else {
        document.getElementById("errorMessage").style.display = "none";
        document.getElementById("searchForm").submit();
    }
}

function showCustomerDetail(cust_sn) {
    $.get('/customer/detail/' + cust_sn, function(data) {
        var detailsHtml = $(data).find('.details').html();
        $('.details-container .details').html(detailsHtml);
        $('.consultation-container').show(); // 상담 내역 표시
    });
}
   

</script>


<style>
.container {
	display: flex;
	justify-content: space-between;
	margin-bottom: 20px; /* 바닥에서 떨어진 정도 */
}

.search-container, .details-container, .consultation-container {
	width: 50%; /* 각 칸의 너비 */
	padding: 10px; /* 안쪽 여백 */
}

.search {
	margin-bottom: 20px; /* 아래 여백 */
}

.details form {
	display: flex;
	flex-direction: column;
}
</style>

</head>
<body>
	<div class="container">

		<div class="search-container">
			<div class="search">
				<br>
				<h4>고객 검색</h4>
				<form id="searchForm"
					action="<c:url value='/customer/searchCustomerConfirm'></c:url>"
					name="search_customer_confirm" method="get">
					<input id="keywordInput" type="text" name="keyword" value="">
					<br> <input type="button" value="Search"
						onclick="validateSearch()"> <span id="errorMessage"
						style="color: red; display: none;">검색어를 입력하세요.</span>
				</form>
				<br>
				<form action="<c:url value='/customer/allCustomers'></c:url>"
					name="search_all_customers" method="get">
					<input type="submit" value="전체검색">
				</form>
				<br>
				<c:if test="${not empty customerList}">
					<h4>검색 결과</h4>
					<ul>
						<c:forEach var="customer" items="${customerList}">
							<li><a href="javascript:void(0);"
								onclick="showCustomerDetail(${customer.cust_sn})">
									${customer.cust_nm} </a></li>
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>

		<!-- 수정 폼 -->
		<div class="details-container">
			<div class="details">
				<h4>고객 상세 정보</h4>
				<c:if test="${not empty message}">
					<div style="color: green; font-weight: bold;">${message}</div>
				</c:if>
				<br>
				<form action="<c:url value='/customer/updateCustomerInfo'></c:url>"
					method="post">
					<c:if test="${not empty customer}">
						<input type="hidden" name="cust_sn" value="${customer.cust_sn}">
						<label for="frst_reg_dt">작성일자:</label>
						<input type="text" id="frst_reg_dt" name="frst_reg_dt"
							value="${customer.frst_reg_dt}" readonly disabled>
						<br>
						<label for="cust_nm">이름:</label>
						<input type="text" id="cust_nm" name="cust_nm"
							value="${customer.cust_nm}">
						<br>
						<label for="pridtf_no">주민번호:</label>
						<input type="text" id="pridtf_no" name="pridtf_no"
							value="${customer.pridtf_no}">
						<br>
						<label for="eml_addr">이메일:</label>
						<input type="text" id="eml_addr" name="eml_addr"
							value="${customer.eml_addr}">
						<br>
						<label for="home_telno">전화번호:</label>
						<input type="text" id="home_telno" name="home_telno"
							value="${customer.home_telno}">
						<br>
						<label for="mbl_telno">핸드폰 번호:</label>
						<input type="text" id="mbl_telno" name="mbl_telno"
							value="${customer.mbl_telno}">
						<br>
						<label for="cr_nm">직업:</label>
						<input type="text" id="cr_nm" name="cr_nm"
							value="${customer.cr_nm}">
						<br>
						<label for="road_nm_addr">주소:</label>
						<input type="text" id="road_nm_addr" name="road_nm_addr"
							value="${customer.road_nm_addr}">
						<br>
						<input type="submit" value="사용자 정보 변경">
						<br>
						<input type="button" value="삭제"
							onclick="confirmDelete(${customer.cust_sn})">

					</c:if>
				</form>
				<br>
				<form action="<c:url value='/customer/updatePicInfo'></c:url>"
					method="post" id="updatePicForm">
					<c:if test="${not empty customer}">
						<input type="hidden" name="cust_sn" value="${customer.cust_sn}">
						<input type="hidden" name="cust_sn" value="${customer.pic_sn_vl}">
						<!-- 기존 관리자 정보 -->
						<label for="pic_name"> 관리자 이름:</label>
						<input type="text" id="pic_name" name="pic_name"
							value="${customer.pic_name}">
						<input type="submit" value="관리자 정보 변경">
						<label for="tkcg_dept_nm">부서:</label>
						<input type="text" id="tkcg_dept_nm" name="tkcg_dept_nm"
							value="${customer.tkcg_dept_nm}">
						<label for="pic_position">직위:</label>
						<input type="text" id="pic_position" name="pic_position"
							value="${customer.pic_position}">
						<label for="pic_phone">연락처:</label>
						<input type="text" id="pic_phone" name="pic_phone"
							value="${customer.pic_phone}">
					</c:if>

				</form>
				<div><h4>고객 상담 내역</h4>
				<div class="consultation-container">
					<c:choose>
						<c:when test="${not empty consultList}">
							<ul>
								<c:forEach var="consultation" items="${consultList}">
									<li>${consultation.cons_date}</li>
									<li>${consultation.consultation}</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<!-- 상담 내역이 없는 경우 -->
							<p>상담 내역이 없습니다.</p>
						</c:otherwise>
					</c:choose>
				</div>
				</div>
			</div>
		</div>


	</div>
</body>
</html>

