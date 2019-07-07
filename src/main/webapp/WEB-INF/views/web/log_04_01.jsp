<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>

    <div class="form-page joinus-page">
        <form name="searchForm" method ="POST">
            <h1 class="text-center">이메일 찾기</h1>

            <div class="question02">
                <p><span></span>이름</p>
                <input class="tex-01" type="text" id="lastname" name="lastname" placeholder="성" required />
                <input class="tex-02" type="text" id="firstname" name="firstname" placeholder="이름" required />
                
            </div>
            <div class="question02">
                <p>생년월일</p>
                <input class="tex-01" type="text" id="year" name="year" placeholder="년도(4글자)" required />
                <input class="tex-03" type="text" id="month" name="month" placeholder="월" required />
                <input class="tex-03" type="text" id="day" name="day" placeholder="일" required />
            </div>
            <input type="hidden" name="dob" id="dob">
            <p class="alert-p">이름이나 생년월일을 확인해주세요.</p>
            <button class="form-btn" type="button" id="search">찾기</button>
            <div class="id-find">
                    <a href="/web/search/pw">비밀번호 찾기</a>
            </div>
        </form>
    </div>

    <!-- Footer -->

    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
<script>

    $(document).ready(function(){
        $("#year").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만
        $("#month").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만
        $("#day").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만

        $("#search").click(function(){
            var dob = "";
            var firstname = $("#firstname").val();
            var lastname=$("#lastname").val();
            var year=$("#year").val();
            var month=$("#month").val();
            var day=$("#day").val();

            if(lastname == ""){
                alert("성을 입력 하세요");
                $("#lastname").focus();
                return;
            }
            if( firstname== ""){
                alert("이름을 입력 하세요");
                $("#firstname").focus();
                return;
            }
            if(year == "" || month == ""  || day == "" ){
                alert("생년월일을 입력 하세요");
                return;
            }
            if(year.length != 4 || month.length != 2 || month.length != 2){
                alert("생년월일을 확인 하세요");
                return;
            }
            dob = year+month+day;
            $("#dob").val(dob);

            document.searchForm.action = "/web/emailSearch";
            document.searchForm.submit();
        });
    });
</script>
</html>
