<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>

</head>

<body>

<nav id="topNav" class="navbar navbar-default dropdownmenu">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand page-scroll" href="/"><img src="/image/logo-01.svg" class="header-logo" width="100%"></a>
        </div>
        <div class="navbar-collapse collapse sub-navwrap" id="bs-navbar">
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" onclick="location.href='/#fir'">회사소개</button>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">서비스</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#sec">스윙세이버란?</a>
                    <a class="dropdown-item" href="#fou">서비스소개</a>

                </div>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">제품</button>
            </div>
            <div class="dropdown">
                <button class="menubtn dropdown-toggle" data-toggle="dropdown">레슨마켓</button>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#thi">레슨프로소개</a>
                    <a class="dropdown-item" href="#">레슨마켓소개</a>

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
                    <li><a href="#fir" onclick='fn_smallMenuClick()'>회사소개</a></li>
                    <li><a href="#sec" onclick='fn_smallMenuClick()'>스윙세이버란?</a></li>
                    <li><a href="#thi" onclick='fn_smallMenuClick()'>서비스소개</a></li>
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
<section id="fir">
    <div class="main-bn-1920">
        <img src="./image/mainban1.png" width="100%">
    </div>    
    <div class="main-bn-1300">
        <img src="./image/mainban2.png" width="100%">
        </div>
    <div class="main-bn-750">
        <img src="./image/mainban3.png" width="100%">
    </div>

</section>

<section id="sec">
    <div class="main-ab">
        <h1>What is <strong>Swingsaver?</strong></h1>
        <h3>스윙세이버는 <strong>언제 어디서나 스윙분석</strong>이 가능합니다.</h3>
        <!--
        <p>레슨 전후 빠른 비교분석! 원터치 영상 업로드! 어플리케이션 무료 다운로드!
        <br/>스윙세이버는 가장 스마트한 동작분석 플랫폼입니다.</p>
-->
        <img src="/image/main-img-01.png" width="70%">
    </div>

</section>

<section id="thi">
    <div class="main-gol">
        <div class="gol-tit">
            <h4>Professional Golfer</h4>
            <h1>스윙세이버의 프로골퍼를 소개합니다.</h1>
        </div>

        <div class="gol-profile col-md-12">
            <div class="col-md-4 profile">
                <img src="/image/pro-01.png">
                <h3>Professional Golfer</h3>
                <p>the role of teacher is often forma and ongo-ing, carried out at a school or other place of formal education.</p>
            </div>
            <div class="col-md-4 profile">
                <img src="/image/pro-01.png">
                <h3>Professional Golfer</h3>
                <p>the role of teacher is often forma and ongo-ing, carried out at a school or other place of formal education.</p>
            </div>
            <div class="col-md-4 profile">
                <img src="/image/pro-01.png">
                <h3>Professional Golfer</h3>
                <p>the role of teacher is often forma and ongo-ing, carried out at a school or other place of formal education.</p>
            </div>

        </div>
    </div>

</section>

<section id="fou">
    <div class="main-pro col-md-12">
        <div class="col-md-6 product-01">
                <img src="image/tablet-01.png" width="100%">
        </div>
        <div class="col-md-6 product-info-01">
                <img src="image/icon-01.png">
            <h4>Scientific Analysis</h4>
            <h1>간편하고 정밀한 분석력!</h1>
            <p>Edge Device로부터 생성된 데이터와 영상분석 툴을 연동한 정밀한 동작 분석 플랫폼입니다.<br/>또한 Edge Device는 장비에 쉽게 장착할 수 있어 사용이 간편합니다.
            </p>
            <a href="#"><U>MORE INFO +</U></a>
        </div>
    </div>
    <div class="main-pro col-md-12">
           
            <div class="col-md-6 product-02 mobile-tab">
                <img src="image/tablet-02.png" width="100%">
            </div>           
           
        <div class="col-md-6  product-info-01 product-info-02">
                <img src="image/icon-02.png">
            <h4>Bigdata Analysis</h4>
            <h1>빅데이터를 활용한 정보 제공!</h1>
            <p>생성된 빅데이터를 활용하여 지속가능한 교정교육 및 효과적인 분석이 가능합니다.<br/>스윙세이버는 당신만의 특별한 스윙 분석을 해드립니다.</p>
            <a href="#"><U>MORE INFO +</U></a>
        </div>
            <div class="col-md-6 product-02 pc-tab">
                <img src="image/tablet-02.png" width="100%">
        </div>
    </div>
    <div class="main-pro col-md-12">
            <div class="col-md-6 product-02">
                <img src="image/tablet-03.png" width="100%">
        </div>
        <div class="col-md-6 product-info-01">
                <img src="image/icon-03.png">
            <h4>High Quality Lesson</h4>
            <h1>프로골퍼에게 1:1레슨!</h1>
            <p>다양한 조건을 통해 만족하는 가격과 양질의 교육자에게 원격레슨이 가능합니다.<br/>직관적인 화면을 통한 레슨 및 클라우스 서비스가 제공됩니다.
            </p>
            <a href="#"><U>MORE INFO +</U></a>
        </div>
    </div>

</section>


<section class="fif" style="min-height: 540px;">
    <div class="main-coo col-md-12">
        <div class="col-md-5 coo-img">
            <img src="/image/main-img-04.png" width="100%">
        </div>
        <div class="col-md-7 coo-info">
            <h4>
                <I>Enjoy Education</I>
            </h4>
            <h1>
                <U>골프 전문가들이 선택한 최고의 서비스!<br/>스윙세이버 스윙분석 시스템</U>
            </h1>
            <img src="/image/client.png">
            <p>
                <I>The University has announced the launch of its first free online course as part.<br/>
                    These individuals or groups can more effectively.</I>
            </p>
        </div>
    </div>
</section>
<!-- Footer -->
<%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
<!-- Footer -->
</body>
</html>

