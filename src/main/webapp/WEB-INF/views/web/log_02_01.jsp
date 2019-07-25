<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>

    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>


    <div class="form-page joinus-page">
        <form name="forms1">
            <h1 class="text-center">회원가입</h1>

            <div class="email-q-01">
                <p><span></span>이메일</p>
                <input type="text" id="email01" placeholder="이메일"  />@
                <input type="text" class="email-input-02" name="stremail02" id="stremail02" readonly value="">
                <select class="que-val" id="selemail02" name="grouptype" onChange="selemail(this)">
                    <option value="" selected>선택하세요</option>
                    <option value="naver.com">naver.com</option>
                    <option value="hanmail.net">hanmail.net</option>
                    <option value="hotmail.com">hotmail.com</option>
                    <option value="nate.com">nate.com</option>
                    <option value="yahoo.co.kr">yahoo.co.kr</option>
                    <option value="empas.com">empas.com</option>
                    <option value="dreamwiz.com">dreamwiz.com</option>
                    <option value="freechal.com">freechal.com</option>
                    <option value="lycos.co.kr">lycos.co.kr</option>
                    <option value="korea.com">korea.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="hanmir.com">hanmir.com</option>
                    <option value="paran.com">paran.com</option>
                    <option value="1">직접입력</option>
                </select>
            </div>
            <div class="question02">
                <p><span></span>이름</p>
                <input class="tex-01" type="text" id="lastname" placeholder="성"  />
                <input class="tex-02" type="text" id="firstname" placeholder="이름"  />
                
            </div>
            <div class="question02">
                <p><span></span>생년월일</p>
                <input class="tex-01" type="text" id="year" name="year" placeholder="년도(4글자)"  />
                <input class="tex-03" type="text" id="month" name="month" placeholder="월"  />
                <input class="tex-03 tex-04" type="text" id="day" name="day" placeholder="일"  />
            </div>
            <%--<div class="question">
                <p>전화번호</p>
                <input type="text" id="phone" placeholder="전화번호(-)빼고 입력"   class="phone-number-check"  />
            </div>
            <div class="question">
                <p>성별</p>
                <div class="rad-fir"><input type="radio" name="gender" value="M" checked="checked"/> 남자</div>
                <div class="rad-fir"><input type="radio" name="gender" value="F" /> 여자</div>
            </div>--%>

            <div class="question">
                <p><span></span>비밀번호</p>
                <input type="password" id="pwd" placeholder="영문/숫자/특수문자 6자리 이상 조합"  />
            </div>
            <div class="question">
                <p><span></span>재확인</p>
                <input type="password" id="pwdConfirm" placeholder="비밀번호 재확인"  />
            </div>

<!--
            <div class="question">
                <p>그룹아이디</p>
                <input type="text" placeholder="멤버요청할 그룹/소그룹아이디 입력" required />
            </div>            
            <div class="question">
                <p>직책</p>
                <select class="que-val" name="grade">
                  <option value="grade" selected="selected">직책선택</option>
                  <option value="pro">Pro</option>
                  <option value="student">Student</option>
                </select>
            </div>              
-->
            <button class="form-btn" type="button" id="member">등록</button>
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


        $("#member").click(function(){

            var email01 = $("#email01").val();
            var selemail02 = $("#stremail02").val();
            var firstname = $("#firstname").val();
            var lastname=$("#lastname").val();
            var year=$("#year").val();
            var month=$("#month").val();
            var day=$("#day").val();
            /*var phone=$("#phone").val();
            var gender = $(':input:radio[name="gender"]:checked').val();*/

            var pwd = $("#pwd").val();
            var pwdConfirm = $("#pwdConfirm").val();

            if(email01 =="" || selemail02 == ""){
                alert("이메일 정보를 확인 하세요");
                return;
            }
            if(firstname == ""){
                alert("성을 입력 하세요");
                $("#firstname").focus();
                return;
            }
            if(lastname == ""){
                alert("이름을 입력 하세요");
                $("#lastname").focus();
                return;
            }
            if(year == "" || month == ""  || day == "" ){
                alert("생년월일을 입력 하세요");
                return;
            }
            if(!birthChk(year+month+day)){
                alert("생년월일을 다시 입력해주세요.");
                return;
            }


            /*if(phone.length == ""){
                alert("전화번호를 입력 하세요");
                return;
            }*/
            if(!checkPassword(pwd,"pwd") || !checkPassword(pwdConfirm,"pwdConfirm")){
                return;
            }
            if(pwd != pwdConfirm){
                alert("비밀번호가 틀립니다. 다시 입력하세요");
                $('#pwdConfirm').val('').focus();
                return;
            }

            var email = email01+"@"+selemail02;
            if(!validateEmail(email)){
                alert("올바른 이메일 주소를 입력하세요");
                return;
            }
            var obj = new Object();
            obj.email = email;
            obj.firstname = firstname;
            obj.lastname = lastname;
            obj.dob = year+month+day;
            /*obj.phone = phone;
            obj.gender = gender;*/
            obj.userpassword = pwd;
            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/web/user/join","POST",jsonData);

        });
    });

</script>
</html>

