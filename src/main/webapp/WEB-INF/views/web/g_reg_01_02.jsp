<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>

    <div class="form-page">
        <h1 class="text-center">그룹신청 완료</h1>
        <div class="success">
        <img src="/image/log-02-img.png">
            <p>그룹신청이 완료되었습니다.<br/>그룹멤버 등록 후 소그룹관리를 이용해주세요.
            <br/>그룹아이디는 <strong>${groupCode}</strong>입니다.</p>
        </div>    
        <button class="form-btn" onclick="location.href='/group/mygroup'">확인</button>
    </div>
    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
</html>
