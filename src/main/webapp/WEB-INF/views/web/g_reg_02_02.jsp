<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>



    <div class="form-page">
        <h1 class="text-center">그룹멤버 신청 완료</h1>
        <div class="success">
        <img src="/image/log-02-img.png">
            <p>그룹멤버 신청이 완료되었습니다.<br/>관리자 승인 후에 그룹 사용이 가능합니다.</p>
        </div>    
        <button class="form-btn" onclick="location.href='/web/mypage'">확인</button>
    </div>

    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
</html>
