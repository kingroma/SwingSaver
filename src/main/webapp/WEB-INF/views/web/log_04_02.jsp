<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>

    <div class="form-page joinus-page">
        <form>
            <h1 class="text-center">이메일 찾기</h1>
            <div class="question">
            <c:choose>
                <c:when test="${fn:length(emailList) == 0}">
                    <p class="alert-p">이메일이나 이름을 확인해주세요.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="list" items="${emailList}" varStatus="status">
                        <c:set var="id" value="${fn:split(list.email,'@')[0]}"/>
                        <c:set var="idLen" value="${fn:length(id)}"/>
                        <c:set var="host" value="${fn:split(list.email,'@')[1]}"/>
                        <h4>${fn:substring(id,0,3) }
                        <c:forEach begin="4" end="${idLen}" step="1">
                            *
                        </c:forEach>
                       @${host} </h4>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </div>

            <button class="form-btn" type="button" onclick="location.href='/loginForm'">확인</button>
            <div class="id-find">
                    <a href="/web/search/pw">비밀번호 찾기</a>
            </div>
        </form>
    </div>
    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->
</body>

</html>
