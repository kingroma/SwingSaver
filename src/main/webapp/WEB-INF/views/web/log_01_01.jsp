<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>
    <div class="form-page">
        <form class="form-signin" name="forms1" method="POST">
            <h1 class="text-center">LOGIN</h1>
            <div class="question">
                <input type="text" id="email" name="email" required="" onchange="emailChange()" onfocus="$('#emailLabel').css('display','none');" onkeyup="emailChange()"  oninput="emailChange()">
                <label id='emailLabel'><img src="/image/id-icon.png" width="100%">아이디</label>
            </div>
            <div class="question">
                <input type="password" id="password" name="password" required="" onchange="passwordChange" onfocus="$('#passwordLabel').css('display','none');" onkeyup="passwordChange()"  oninput="passwordChange()">
                <label id='passwordLabel'><img src="/image/pw-icon.png" width="100%">비밀번호</label>
            </div>

            <button class="form-btn" type="button" id="login">로그인</button>
            <div class="id-login">
                <%--<label class="auto-log"><input type="checkbox" value="remember-me"> 자동로그인</label>--%>
                <ul class="search-login">
                    <li><a href="/web/search/email">아이디 찾기</a></li>
                    <li><a href="/web/search/pw">비밀번호 찾기</a></li>
                    <li><a href="/web/user/member"><strong>회원가입하기</strong></a></li>
                </ul>
            </div>
        </form>
    </div>
    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>

    <!-- Footer -->

</body>
<script>
    var message = "${returnCode}";
    if(message == "9999"){
        alert("로그인에 실패하였습니다. \n Email 및 비밀번호를 확인해주세요");
    }
    console.log(message);
    $(document).ready(function(){
        $("#login").click(function(){
            var email = $("#email").val();
            var password=$("#password").val();

            if(email == ""){
                alert("이메일 주소를 입력하세요");
                $("#email").focus();
                return;
            }
            if(password == ""){
                alert("비밀번호를 입력하세요");
                $("#password").focus();
                return;
            }
            document.forms1.action = "/login";
            document.forms1.submit();
        });
    });
    
    
    function passwordChange(){
    	if($('#email').val().length > 0 ){
    		$('#emailLabel').css("display","none");
    	}else{
    		$('#emailLabel').css("display","block");
    	}
    }
    
    function emailChange(){
    	if($('#password').val().length > 0 ){
    		$('#passwordLabel').css("display","none");
    	}else{
    		$('#passwordLabel').css("display","block");
    	}
    }
</script>
</html>
