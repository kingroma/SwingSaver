<%--
  Created by IntelliJ IDEA.
  User: mycom
  Date: 2019-06-04
  Time: 오전 4:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav id="topNav" class="navbar navbar-default dropdownmenu">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand page-scroll" href="/"><img src="/image/logo.png" class="header-logo" width="100%"></a>
        </div>
        <div class="navbar-collapse collapse sub-navwrap" id="bs-navbar">
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" onclick="location.href='/#first'">회사소개</button>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">서비스</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/#sec">스윙세이버란?</a>
                    <a class="dropdown-item" href="/#fou">서비스소개</a>

                </div>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">제품</button>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">레슨마켓</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="/#thi">레슨프로소개</a>
                    <a class="dropdown-item" href="/#">레슨마켓소개</a>

                </div>
            </div>
            <c:choose>
                <c:when test="${not empty sessionScope.login.userid}">
                    <div class="dropdown">
                        <button class="menubtn dropdown-toggle" data-toggle="dropdown"><p class="my-btn">내정보</p></button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="/web/mypage">마이페이지</a>
                            <a class="dropdown-item" href="/group/grpenter">그룹</a>
                            <a class="dropdown-item" href="/logout">로그아웃</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="dropdown">
                        <button class="menubtn dropdown-toggle" data-toggle="dropdown" onclick="location.href='/loginForm'">로그인</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>
