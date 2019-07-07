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

            <div class="question02">
                <p><span></span>이름</p>
                <input class="tex-01" type="text" id="lastname" placeholder="성" required />
                <input class="tex-02" type="text" id="firstname" placeholder="이름" required />
                
            </div>

            <div class="question">
                <p>이메일</p>
                <input type="text" id="email" required />
            </div>
            <div class="form-guid">*가입하신 이메일로 비밀번호 변경 메일을 발송해 드립니다.</div>

            <button class="form-btn" id="emailSearch" type="button">발송</button>
            <div class="id-find">
                    <a href="/web/search/email">이메일 찾기</a>
            </div>
        </form>
    </div>

    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
<script>

    $(document).ready(function(){
        $("#emailSearch").click(function(){
            var email = $("#email").val();
            var lastname=$("#lastname").val();
            var firstname=$("#firstname").val();

            if(email == ""){
                alert("이메일을 입력하세요");
                return;
            }
            if(lastname == "" || firstname == ""){
                alert("이름 또는 성을 입력하세요");
                return;
            }
            var obj = new Object();
            obj.email = email;
            obj.lastname = lastname;
            obj.firstname = firstname;

            var jsonData = JSON.stringify(obj);
            //alert();
            AjaxCall("/web/passwordReset","POST",jsonData);
        });
    });
</script>
</html>

