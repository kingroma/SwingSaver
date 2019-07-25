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
            <a class="navbar-brand page-scroll" href="/"><img src="/image/logo-01.svg" class="header-logo" width="100%"></a>
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


<!-- small page -->
<nav class="dg-hd-mo hidden-lg">
    <h1 class="dg-hd-mo-logo-area">
        <a href="/"><img src="/image/logo-01.svg" class="header-logo" width="100%"></a>
    </h1>
    <!--메뉴전체 -->
    <nav class="dg-hd-mo-menu-panel" style=''>
        <b class="dg-hd-mo-menu-btn" title="menu"><span></span></b>
        <div class="mo-menu-title">
        	<c:choose>
        		<c:when test="${not empty sessionScope.login.userid}">
            		<a href="/logout" class="dg-white">로그아웃</a>
        	 	</c:when>
        	 	<c:otherwise>
        	 		<a href="/loginForm" class="dg-white">로그인</a>
            		<a href="/web/user/member" class="dg-white">회원가입</a>
        	 	</c:otherwise>
        	</c:choose>
        </div>
        <ul>
            <li class="menu-label menu-arrow-active-li">
                <a href="/" class="dg-point">HOME</a>
                <span class="dg-hd-mo-menu-arrow menu-arrow-active"></span>
                <ul class="sub-menu sub-menu-on">
                    <li><a href="#fir" onclick="location.href='/#fir'">회사소개</a></li>
                    <li><a href="#sec" onclick="location.href='/#sec'">스윙세이버란?</a></li>
                    <li><a href="#thi" onclick="location.href='/#thi'">서비스소개</a></li>
                    <li><a href="#">제품</a></li>
                    <li><a href="#">레슨마켓</a></li>
                </ul>
            </li>

			<c:choose>
        		<c:when test="${not empty sessionScope.login.userid}">
            		<li class="menu-label menu-arrow-active-li-next-li">
		                <a href="/web/mypage">마이페이지</a>
		                <span class="dg-hd-mo-menu-arrow"></span>
		                <ul class="sub-menu">
		                    <li><a href="/web/mypage">개인정보수정</a></li>
		                    <li><a href="#">포인트 구매/이용료결제</a></li>
		                    <li><a href="#">결제내역 조회</a></li>
		                    <li><a href="#">서비스 변경</a></li>
		                    <li><a href="#">서비스 해지</a></li>
		                </ul>
		            </li>
		            <li class="menu-label">
		                <a href="/group/grpenter">그룹</a>
		                <span class="dg-hd-mo-menu-arrow"></span>
		                <ul class="sub-menu">
		                    <li><a href="/group/mygroup">그룹정보수정</a></li>
		                    <li><a href="/group/groupmember">그룹멤버관리</a></li>
		                    <li><a href="/group/subgroup">소그룹관리</a></li>
		                    <li><a href="#">월 이용 결제</a></li>
		                    <li><a href="#">결제내역 조회</a></li>
		                    <li><a href="#">서비스 변경 요청</a></li>
		                </ul>
		            </li>
        	 	</c:when>
        	 	<c:otherwise>
        	 	</c:otherwise>
        	</c:choose>
            

        </ul>
    </nav>
    <!--어두워지는 부분-->
    <div class="dg-hd-mo-menu-panel-overlay"></div>
</nav>

<script>
    $(".dg-hd-mo-menu-btn, .dg-hd-mo-menu-panel-overlay").click( function() {
        $(".dg-hd-mo-menu-btn, .dg-hd-mo-menu-panel-overlay, .dg-hd-mo-menu-panel").toggleClass("mo-menu-active");
        /* dg-hd-mo-menu-panel-overlay 활성화 체크 */
        if ($(".dg-hd-mo-menu-panel-overlay").hasClass("mo-menu-active")) {
            $(".dg-hd-mo-menu-panel-overlay").fadeIn();
        } else {
            $(".dg-hd-mo-menu-panel-overlay").fadeOut();
        }
    });

    //메뉴의 + 클릭시 닫히고, 열림
    $('.dg-hd-mo-menu-arrow').click(function(){
        $(this).next('ul').toggleClass('sub-menu-on');
        var $curruntArrow = $(this).toggleClass('menu-arrow-active');
        $(this).parents('li').toggleClass('menu-arrow-active-li');
        $(this).prev('a').toggleClass('dg-point');
        $(this).parents('li').next('li').toggleClass('menu-arrow-active-li-next-li');
    });
    
    function fn_smallMenuClick (){
    	$(".dg-hd-mo-menu-btn, .dg-hd-mo-menu-panel-overlay, .dg-hd-mo-menu-panel").toggleClass("mo-menu-active");
    	if ($(".dg-hd-mo-menu-panel-overlay").hasClass("mo-menu-active")) {
            $(".dg-hd-mo-menu-panel-overlay").fadeIn();
        } else {
            $(".dg-hd-mo-menu-panel-overlay").fadeOut();
        }
    }
</script>