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
            <h1 class="text-center">비밀번호 재설정</h1>
            <input type="hidden" id="confirmcode" value="${confirmcode}">
            <div class="question">
                <p><span></span>비밀번호</p>
                <input type="password" id="pwd" placeholder="영문/숫자/특수문자 6자리 이상 조합"  />
            </div>
            <div class="question">
                <p><span></span>재확인</p>
                <input type="password" id="pwdConfirm" placeholder="비밀번호 재확인"  />
            </div>

            <button class="form-btn" type="button" id="passwordReset">확인</button>

        </form>


        <!-- Footer -->

        <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
        <!-- Footer -->

</body>
<script>

    $(document).ready(function(){
        $("#passwordReset").click(function(){
            var confirmcode = $("#confirmcode").val();
            var pwd = $("#pwd").val();
            var pwdConfirm = $("#pwdConfirm").val();


            if(!checkPassword(pwd,"pwd") || !checkPassword(pwdConfirm,"pwdConfirm")){
                return;
            }
            if(pwd != pwdConfirm){
                alert("비밀번호가 틀립니다. 다시 입력하세요");
                $('#pwdConfirm').val('').focus();
                return;
            }

            var obj = new Object();
            obj.confirmcode = confirmcode;
            obj.password = pwdConfirm;

			
            //http://localhost:8888/web/user/resetpassword/A1PNC89Q6V5TJWJ
            var jsonData = JSON.stringify(obj);
            AjaxCall("/web/user/passwordProcess","POST",jsonData);
        });
    });
</script>


</html>
