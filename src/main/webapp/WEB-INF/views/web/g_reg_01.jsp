<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>
    <div class="form-page two-page">
        <div class="col-md-12">
            <div class="col-md-6">
                <div class="success">
                    <img src="../image/log-03-img-04.png">
                    <p>등록된 그룹이 없습니다.<br/>스윙세이버 그룹을 생성하고<br/>회원들의 레슨을 관리해보세요.</p>
                </div>
                <button class="form-btn" onclick="location.href='/group/grpcreate'">그룹생성 요청</button>
            </div>
            <div class="col-md-6 two-sec">
                <div class="success">
                    <img src="../image/log-03-img-03.png">
                    <p>이미 생성된 그룹이 있으시면,<br/>그룹 멤버를 신청하세요.<br/>관리자가 승인하면 사용가능합니다.</p>
                </div>
                <button class="form-btn" onclick="location.href='/group/grpmember'">그룹멤버 요청</button>
            </div>        
        </div>
    </div>
    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
</html>