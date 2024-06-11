<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Customer Management</title>
<link href="${path}/resources/css/customerPage.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

function submitNewCustomerForm() {
    // 폼 데이터를 수집합니다.           
//     var registerButton = document.getElementById("registerButton");
//     registerButton.disabled = true;
    var formData = {
        new_cust_nm: $("#new_cust_nm").val(),
        new_pridtf_no: $("#new_pridtf_no").val(),
        new_eml_addr: $("#new_eml_addr").val(),
        new_home_telno: $("#new_home_telno").val(),
        new_mbl_telno: $("#new_mbl_telno").val(),
        new_cr_nm: $("#new_cr_nm").val(),
        new_road_nm_addr: $("#new_road_nm_addr").val()
    };

    // AJAX를 사용하여 폼 데이터를 서버로 전송합니다.
    $.ajax({
        url: "<c:url value='/customer/addCustomer'></c:url>",
        type: "POST",
        data: formData,
        success: function(response) {
            // 서버로부터 응답을 받은 경우 처리할 내용을 추가합니다.
            alert("사용자 등록이 완료되었습니다.");
            // 사용자 등록이 성공하면 원하는 동작을 수행합니다.
        },
        error: function(xhr, status, error) {
            // 오류가 발생한 경우 오류를 처리합니다.
            console.error("Error:", error);
            alert("사용자 등록 중 오류가 발생했습니다.");
        }
    });
}

function toggleNewCustomerForm() {
	
	 var disableButton = document.getElementById("disableRegisterButton");
     var ableButton = document.getElementById("ableRegisterButton");

     // 첫 번째 등록 버튼을 숨깁니다.
     disableButton.style.display = "none";
     // 두 번째 등록 버튼을 보이게 합니다.
     ableButton.style.display = "inline";
     
    var newCustomerForm = document.getElementById("newCustomer");
    newCustomerForm.style.display = "block";
    $(".customerList").hide();
    $(".consult").hide(); 
    $(".details-container").hide();
    $(".newCustomer").show();
}
function validateSearch() {
	$(".newCustomerForm").hide();
    var keyword = $("#keywordInput").val().trim();
    if (keyword === "") {
        $("#errorMessage").show();
        return;
    }

    $.ajax({
        url: $("#searchForm").attr('action'),
        type: $("#searchForm").attr('method'),
        data: $("#searchForm").serialize(),
        success: function(response) {
            // 받은 데이터로 고객 목록 섹션만 업데이트합니다.
            $(".customerList").html($(response).find(".customerList").html());
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
            alert("조건 검색 중 오류가 발생했습니다.");
        }
    });
}
function performFullSearch() {
	$(".newCustomerForm").hide();
    $.ajax({
        url: $("#fullSearchForm").attr('action'),
        type: $("#fullSearchForm").attr('method'),
        success: function(response) {
            // 새로운 페이지로 교체
            $("body").html(response);
        },
        error: function(xhr, status, error) {
            console.error("Error:", error);
            alert("전체 검색 중 오류가 발생했습니다.");
        }
    });
}

function showCustomerDetail(cust_sn) {
	$(".newCustomerForm").hide();
	   $.ajax({
	        url: "/customer/detail/" + cust_sn,
	        type: "GET",
	        success: function(response) {
	        	$(".newCustomer").hide(); // 폼 숨기기
	            // 고객 상세 정보를 받아와서 페이지에 업데이트
	            $(".details-container").html($(response).find(".details-container").html());
	            $(".consult").html($(response).find(".consult").html());
	        },
	        error: function(xhr, status, error) {
	            console.error("Error:", error);
	            alert("고객 상세 정보를 불러오는 중 오류가 발생했습니다.");
	        }
	    });
}
function updateCustomerInfo() {
    var form = $("#updateCustomerInfoForm");
    var cust_sn = form.find('input[name="cust_sn"]').val();
    var updatedName = form.find('input[name="cust_nm"]').val();

    // 확인 창을 띄우고 사용자가 확인을 선택한 경우에만 정보를 변경
    if (confirm("정말로 사용자 정보를 변경하시겠습니까?")) {
        $.ajax({
            url: form.attr('action'),
            type: form.attr('method'),
            data: form.serialize(),
            success: function(response) {
                alert("사용자 정보가 성공적으로 변경되었습니다.");
                
                // 해당 사용자의 라디오 버튼 텍스트 업데이트
                $('input[name="customerRadio"][value="' + cust_sn + '"]').siblings('span').text(updatedName);

                // 검색 결과 목록에서도 변경된 이름 업데이트
                $('.customerList input[value="' + cust_sn + '"]').siblings('span').text(updatedName);
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
                alert("사용자 정보 변경 중 오류가 발생했습니다.");
            }
        });
    }
}

function updatePicInfo() {
	  var form = $("#updatePicForm");
	    // 확인 창을 띄우고 관리자가 확인을 선택한 경우에만 정보를 변경
	    if (confirm("정말로 사용자 정보를 변경하시겠습니까?")) {
	        // 폼의 submit 이벤트를 방지합니다.
	        event.preventDefault();
	        
	        $.ajax({
	            url: form.attr('action'),
	            type: form.attr('method'),
	            data: form.serialize(),
	            success: function(response) {
	                alert("관리자 정보가 성공적으로 변경되었습니다.");
	                
	                // 새로운 관리자 이름을 얻어옵니다.
	                var newName = form.find('input[name="pic_name"]').val();
	                // 새로운 관리자 이름을 DOM에서 찾아 업데이트합니다.
	                $(".details-text #pic_name").val(newName);
	            },
	            error: function(xhr, status, error) {
	                console.error("Error:", error);
	                alert("관리자 정보 변경 중 오류가 발생했습니다.");
	            }
	        });
	    }
}
function confirmDelete() {
	 var cust_sn = $('input[type="radio"][name="customerRadio"]:checked').val();
    if (confirm("정말로 삭제하시겠습니까? 고객정보는 삭제 후 복구가 불가합니다.")) {
        window.location.href = "/customer/delete/" + cust_sn;
    }
}

</script>
</head>
<body>
	<div class="topBar">
		<span class="head">고객정보 관리</span> <span><a href="#"
			class="close-button">X</a></span>
	</div>
	<div class="container">
		<div class="section">
			<div class="select_customer">
				<h4 class="font1">고객성명 :</h4>
				<br>
				<form id="searchForm"
					action="<c:url value='/customer/searchCustomerConfirm'></c:url>"
					name="search_customer_confirm" method="get">
					<input id="keywordInput" type="text" name="keyword" value=""
						class="inputtext"><br> <br>
					<button type="button" class="search_btn" onclick="validateSearch()">조건검색</button>
					<span id="errorMessage" style="color: red; display: none;">검색어를
						입력하세요.</span>
				</form>

				<br>
				<form id="fullSearchForm"
					action="<c:url value='/customer/allCustomers'></c:url>"
					method="get">
					<button type="button" class="search_btn"
						onclick="performFullSearch()">전체검색</button>
				</form>


				<c:if test="${not empty customerList}">
					<h4>검색 결과</h4>
					<!-- 각 고객에 대한 라디오 버튼 생성 -->
					<form id="customerRadioForm">
						<div class="customerList">
							<c:forEach var="customer" items="${customerList}">
								<label> <input type="radio" name="customerRadio"
									value="${customer.cust_sn}"
									onclick="showCustomerDetail(${customer.cust_sn})">
									${customer.cust_nm}
								</label>
								<br>
							</c:forEach>
						</div>
					</form>
				</c:if>
			</div>
		</div>
		<div class="section">
			<div class="details-container" id="customerDetailContainer">
				<div class="details">
					<h4>고객 상세 정보</h4>
					<c:if test="${not empty message}">
						<div style="color: green; font-weight: bold;">${message}</div>
					</c:if>
					<br>
					<form id="updateCustomerInfoForm"
						action="<c:url value='/customer/updateCustomerInfo'></c:url>"
						method="post">
						<c:if test="${not empty customer}">
							<div class="details-text">
								<input type="hidden" name="cust_sn" value="${customer.cust_sn}">
								<label for="frst_reg_dt" class="details-text-col">작성일자:</label>
								<input type="text" id="frst_reg_dt" name="frst_reg_dt"
									value="${customer.frst_reg_dt}" readonly disabled>
							</div>
							<div class="details-text">
								<label for="cust_nm" class="details-text-col">이름:</label> <input
									type="text" id="cust_nm" name="cust_nm"
									value="${customer.cust_nm}">
							</div>
							<div class="details-text">
								<label for="pridtf_no" class="details-text-col">주민번호:</label> <input
									type="text" id="pridtf_no" name="pridtf_no"
									value="${customer.pridtf_no}">
							</div>
							<div class="details-text">
								<label for="eml_addr" class="details-text-col">이메일:</label> <input
									type="text" id="eml_addr" name="eml_addr"
									value="${customer.eml_addr}">
							</div>
							<div class="details-text">
								<label for="home_telno" class="details-text-col">전화번호:</label> <input
									type="text" id="home_telno" name="home_telno"
									value="${customer.home_telno}">
							</div>
							<div class="details-text">
								<label for="mbl_telno" class="details-text-col">핸드폰 번호:</label>
								<input type="text" id="mbl_telno" name="mbl_telno"
									value="${customer.mbl_telno}">
							</div>
							<div class="details-text">
								<label for="cr_nm" class="details-text-col">직업:</label> <input
									type="text" id="cr_nm" name="cr_nm" value="${customer.cr_nm}">
							</div>
							<div class="details-text">
								<label for="road_nm_addr" class="details-text-col">주소:</label> <input
									type="text" id="road_nm_addr" name="road_nm_addr"
									value="${customer.road_nm_addr}">
							</div>
							<br>
						</c:if>
					</form>
					<br>
					<div>
						<form action="<c:url value='/customer/updatePicInfo'></c:url>"
							method="post" id="updatePicForm">
							<c:if test="${not empty customer}">
								<input type="hidden" name="cust_sn" value="${customer.cust_sn}">
								<input type="hidden" name="pic_sn_vl"
									value="${customer.pic_sn_vl}">
								<!-- 기존 관리자 정보 -->
								<div class="details-text">
									<label for="pic_name" class="details-text-col"> 관리자 이름:</label>
									<div class="input-with-button">
										<input type="text" id="pic_name" name="pic_name"
											value="${customer.pic_name}">
										<button onclick="updatePicInfo()">변경</button>
										<!-- 										<button type="submit">버튼</button> -->
									</div>
								</div>
								<div class="details-text">
									<label for="tkcg_dept_nm" class="details-text-col">부서:</label>
									<input type="text" id="tkcg_dept_nm" name="tkcg_dept_nm"
										value="${customer.tkcg_dept_nm}" readonly disabled>
								</div>
								<div class="details-text">
									<label for="pic_position" class="details-text-col">직위:</label>
									<input type="text" id="pic_position" name="pic_position"
										value="${customer.pic_position}" readonly disabled>
								</div>
								<div class="details-text">
									<label for="pic_phone" class="details-text-col">연락처:</label> <input
										type="text" id="pic_phone" name="pic_phone"
										value="${customer.pic_phone}" readonly disabled>
								</div>
							</c:if>
							<br>

						</form>
					</div>

					<br>
					<%-- 					<button class="btn_blue" onclick="confirmDelete('${customer.cust_sn}')">삭제</button> --%>
				</div>


			</div>

					<div class="Newsection">
							<div class="newCustomer" id="newCustomer" style="display: none;">
								<div class="newCustomer">
									<h4>신규 고객 등록</h4>
						<form method="post"
							action="<c:url value='/customer/addCustomer'></c:url>">
							<div class="details-text">
								<label for="new_cust_nm" class="details-text-col">이름:</label> <input
									type="text" id="new_cust_nm" name="new_cust_nm">
							</div>
							<div class="details-text">
								<label for="new_pridtf_no" class="details-text-col">주민번호:</label>
								<input type="text" id="new_pridtf_no" name="new_pridtf_no">
							</div>
							<div class="details-text">
								<label for="new_eml_addr" class="details-text-col">이메일:</label>
								<input type="text" id="new_eml_addr" name="new_eml_addr">
							</div>
							<div class="details-text">
								<label for="new_home_telno" class="details-text-col">전화번호:</label>
								<input type="text" id="new_home_telno" name="new_home_telno">
							</div>
							<div class="details-text">
								<label for="new_mbl_telno" class="details-text-col">핸드폰
									번호:</label> <input type="text" id="new_mbl_telno" name="new_mbl_telno">
							</div>
							<div class="details-text">
								<label for="new_cr_nm" class="details-text-col">직업:</label> <input
									type="text" id="new_cr_nm" name="new_cr_nm">
							</div>
							<div class="details-text">
								<label for="new_road_nm_addr" class="details-text-col">주소:</label>
								<input type="text" id="new_road_nm_addr" name="new_road_nm_addr">
							</div>
							<br>
							
						</form>
					</div>
							</div>
						</div>
		</div>
		<div class="section">

			<h4 class="font1">상담 내역 :</h4>
			<div class="consult" id="customerDetailContainer">
				<c:choose>
					<c:when test="${not empty consultList}">
						<ul>
							<c:forEach var="consultation" items="${consultList}">
								<li>${consultation.cons_date}:${consultation.consultation}</li>
							</c:forEach>

						</ul>
					</c:when>
					<c:otherwise>
						<!-- 상담 내역이 없는 경우 -->
						<p>상담 내역이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
			<br>

			<div class="buttons">
<!-- 				<button class="btn_blue"  onclick="submitNewCustomerForm()" disabled="disabled">등록</button> -->
				 <button class="btn_blue" id="disableRegisterButton"  style="display: inline;" disabled>등록</button>
				  <button class="btn_blue" id="ableRegisterButton"  onclick="submitNewCustomerForm()" style="display: none;">등록</button>
				<button class="btn_blue" onclick="updateCustomerInfo()">변경</button>
				<button class="btn_blue"onclick="confirmDelete()">삭제</button>
				<button class="btn_blue new" id="insertNewCustomer"onclick="toggleNewCustomerForm()">신규</button>
				<br><br>
				<button class="btn_yellow">고객조회</button>
				<button class="nones"></button>
				<button class="nones"></button>
				<button class="btn_blue">종료</button>
			</div>
		</div>
	</div>
</body>
</html>
