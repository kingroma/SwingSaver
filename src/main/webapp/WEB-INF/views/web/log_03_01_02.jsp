<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>



    <div class="form-page">
        <h1 class="text-center">메일전송 완료</h1>
        <div class="success">
        <img src="/image/log-03-img-01.png">
            <p>비밀번호 재설정 메일을 발송하였습니다.<br/>입력하신 메일을 확인해주세요.</p>
        </div>    
        <button class="form-btn" onclick="location.href='/';" type="button">확인</button>
    </div>

    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>

</html>
