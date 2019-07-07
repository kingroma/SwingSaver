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
            <h1 class="text-center">그룹신청</h1>

            <div class="question"><p>그룹이름</p>
                <input type="text" id="groupname" placeholder="그룹이름 입력" required />
            </div>
            <div class="question"><p>그룹타입</p>
                <select id="grouptype">
                    <option value="" selected="selected">그룹타입을 선택해주세요.</option>
                    <option value="A">Academy</option>
                    <option value="R">Range</option>
                </select>
            </div>   
            <div class="question"><p>사용인원</p>
                <input type="text" id="quota" placeholder="총 사용인원" required />
            </div>

            <div class="question"><p>1인사용</p>
                <select id="storagespace">
                    <option value="" selected="selected">1인당 사용 용량 선택</option>
                    <option value="100">100M</option>
                    <option value="500">500M</option>
                    <option value="1000">1000M</option>
                </select>
            </div>  
            
            <div class="question"><p>사업자번호</p>
                <input type="text" id="address" placeholder="사업자번호 입력(-빼고 입력)" required />
            </div> 
            
            <div class="question"><p>연락처</p>
                <input type="text" id="phone" placeholder="전화번호(-빼고 입력)" required />
            </div>
                   
            <p class="alert-p">정보를 모두 입력해주세요.</p>
            <button class="form-btn" type="button" id="group">신청</button>
        </form>
    </div>

    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->
</body>
<script>

    $(document).ready(function(){
        $("#quota").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만
        $("#address").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만
        $("#phone").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만


        $("#group").click(function(){
            var groupname = $("#groupname").val();
            var grouptype = $("#grouptype option:selected").val();
            var quota = $("#quota").val();
            var storagespace = $("#storagespace option:selected").val();
            var address=$("#address").val();
            var phone=$("#phone").val();
            var userid=$("#userid").val();


            if(groupname ==""){
                alert("그룹이름을 입력 하세요");
                return;
            }
            if(grouptype == ""){
                alert("그룹타입을 선택 하세요");
                return;
            }
            if(quota == "" || quota >100000){
                alert("총 사용인원을 입력 하세요");
                return;
            }
            if(storagespace == ""){
                alert("1인당 사용 용량을 선택 하세요");
                return;
            }
            if(!checkCorporateRegistrationNumber(address)){
                alert("사업자 번호를 확인해 주세요");
                return
            }
            if(phone == ""){
                alert("전화번호를 입력 하세요");
                return;
            }

            var obj = new Object();
            obj.groupname = groupname;
            obj.grouptype = grouptype;
            obj.quota = quota;
            obj.storagespace = storagespace;
            obj.address = address;
            obj.phone = phone;
            obj.userid = userid;

            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/group/insertGroup","POST",jsonData);

        });
    });

</script>
</html>
