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
            <input type="hidden" id="userid" value="${sessionScope.login.userid}">
            <h1 class="text-center">그룹멤버 신청</h1>


            <div class="question">
                <p>그룹아이디</p>
                <input type="text" id="groupid" placeholder="멤버요청할 그룹/소그룹아이디 입력" required />
            </div>            
            <div class="question">
                <p>직책</p>
                <select class="que-val" id="membertype">
                  <option value="" selected="selected">직책선택</option>
                  <option value="A">Administrator</option>
                  <option value="P">Professional</option>
                </select>
            </div>
                   
            <p class="alert-p">정보를 모두 입력해주세요.</p>
            <button class="form-btn" type="button" id="member">신청</button>
        </form>
    </div>
    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->
</body>
<script>

    $(document).ready(function(){
        $("#groupid").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만

        $("#member").click(function(){
            var groupid = $("#groupid").val();
            var membertype = $("#membertype option:selected").val();

            var userid=$("#userid").val();


            if(groupid ==""){
                alert("그룹아이디를 입력 하세요");
                return;
            }
            if(membertype == ""){
                alert("직책을 선택 하세요");
                return;
            }


            var obj = new Object();
            obj.groupid = groupid;
            obj.membertype = membertype;
            obj.userid = userid;

            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/group/insertGrpMmeber","POST",jsonData);

        });
    });

</script>
</html>
