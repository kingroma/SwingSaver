<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>

    <div class="form-page">
        <h1 class="text-center">회원가입 완료</h1>
        <div class="success">
        <img src="/image/log-02-img.png">
            <p>회원가입이 완료되었습니다.<br/>이메일 인증 후 로그인이 가능합니다.<br/>로그인 하시려면 아래 버튼을 클릭해주세요.</p>
        </div>    
        <button class="form-btn" onclick="location.href='/loginForm' ">로그인</button>
    </div>

    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
</html>
