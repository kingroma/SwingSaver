
<%--
  Created by IntelliJ IDEA.
  User: mycom
  Date: 2019-06-04
  Time: 오전 1:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="/image/favicon.ico" rel="icon" type="image/x-icon" />
    <link href="/image/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <title>스윙세이버</title>

    <!-- 부트스트랩 -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles.css">


    <!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> -->
    <script src="/js/jquery-latest.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jsUtil.js"></script>
    <!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
    <!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <![endif]-->
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <c:set var="reqUri" value="${pageContext.request.requestURI}"></c:set>
    <script>var currUri ='<c:out value="${reqUri}"/>'</script>



