<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>
<body>
    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>


    <!-- Modal -->
    <div id="uploadModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">프로필 변경</h4>
                </div>
                <div class="modal-body">
                    <!-- Form -->
                    <form method='post' action='' enctype="multipart/form-data">
                        Select file : <input type='file' name='file' id='file' class='form-control' ><br>
                        <input type='button' class='btn btn-info' value='Upload' id='upload'>
                    </form>

                    <!-- Preview-->
                    <div id='preview'></div>
                </div>

            </div>

        </div>
    </div>
    <section class="container no-padding">
        <article class="col-xs-12" style="padding: 0;">
            <div class="content-nav col-xs-3">
                <div class="side-menu">
                    <div class="user-info">
                        <img class="side-profile" src="<c:url value='${userInfo.photo}'/>">
                        <p class="side-user">${userInfo.email}</p>
                        <p class="meter-l meter-ti">사용 <span>${userInfo.usedspace}M</span></p>
                        <c:set var="remaining" value="${userInfo.storagespace-userInfo.usedspace}"/>
                        <c:set var="rating" value="${(userInfo.usedspace+0.0)/(userInfo.storagespace+0.0)}"/>
                        <p class="meter-r meter-ti">잔여 <span>${remaining}M</span></p>
                        <div class="meter info_color">
                            <c:choose>
                                <c:when test="${userInfo.usedspace == 0 || rating == 'NaN'}">
                                    <span style="width: 0%"></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="width:<fmt:formatNumber value="${rating}" type="percent"/>"></span>
                                </c:otherwise>
                            </c:choose>

                            <%--<span style="width:<fmt:formatNumber value="${(0+0.0)/(0+0.0)}" type="percent"/>"></span>--%>
                        </div>
                        <p class="side-info">등급 1 | 소그룹01 | 총사용량:${userInfo.storagespace}M<br/> 사용가능포인트:${userInfo.availablepoints}p
                            <br/> 서비스 유효일자:19-10-01</p>
                    </div>
                    <ul>
                        <li><a class="active" href="#">개인정보수정</a></li>
                        <li><a href="#">포인트 구매/이용료결제</a></li>
                        <li><a href="#">결제내역 조회</a></li>
                        <li><a href="#">서비스 변경</a></li>
                        <li><a href="#">서비스 해지</a></li>
                    </ul>
                </div>

            </div>
            <div class="content col-xs-9" style="padding: 0;">
                <div class="col-xs-12 no-padding">
                    <h2 class="right-tit">개인정보수정</h2>

                    <div class="form-page joinus-page edit-page">
                        <div class="profile-info">
                            <img class="profile-img" src="<c:url value='${userInfo.photo}'/>">
                            <img class="edit" id='editProfile' src="/image/edit.png" class="btn btn-info">
                            <%--<img class="edit" src="/image/edit.png" class="btn btn-info" data-toggle="modal" data-target="#uploadModal">--%>

                        </div>

                        <form name="forms1">
                            <input type="hidden" id="id" value="${userInfo.id}"/>
                            <input type="hidden" id="email" value="${userInfo.email}"/>

                            <div class="question">
                                <p>이메일</p>
                                <div class="que-info">
                                    <p>${userInfo.email}</p>
                                </div>
                            </div>
                            <div class="question02">
                                <p><span></span>이름</p>
                                <input class="tex-01 que-val" type="text" id="lastname" value= "${userInfo.lastname}" placeholder="홍" required />
                                <input class="tex-02 que-val" type="text" id="firstname" value= "${userInfo.firstname}" placeholder="길동" required />

                            </div>
                            <div class="question02">
                                <p>생년월일</p>
                                <c:set var="dobStr" value="${userInfo.dob}"/>

                                <input class="tex-01 que-val" type="text" id="year" value="${fn:substring(dobStr,0,4) }" required />
                                <input class="tex-03 que-val" type="text" id="month" value="${fn:substring(dobStr,4,6) }" required />
                                <input class="tex-03 que-val" type="text" id="day" value="${fn:substring(dobStr,6,8) }" required />
                            </div>
                            <div class="question">
                                <p>전화번호</p>
                                <input type="text" id="phone" placeholder="전화번호(-)빼고 입력" value="${userInfo.phone}" class="phone-number-check" />
                            </div>
                            <div class="question">
                                <p>성별</p>
                                <div class="rad-fir"><input type="radio" name="gender" value="M" <c:if test="${ userInfo.gender eq 'M'}">checked="checked"</c:if>/> 남자</div>
                                <div class="rad-fir"><input type="radio" name="gender" value="F" <c:if test="${ userInfo.gender eq 'F'}">checked="checked"</c:if>/> 여자</div>
                            </div>

                            <div class="question">
                                <p>비밀번호</p>
                                <input type="password" id="pwd" placeholder="영문/숫자/특수문자 조합" required />
                            </div>
                            <div class="question">
                                <p>재확인</p>
                                <input type="password" id="pwdConfirm" placeholder="비밀번호 재확인" required />
                            </div>
                            <button class="form-btn" type="button"  id="member">수정</button>
                        </form>
                    </div>

                </div>
            </div>
        </article>
    </section>
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
            var id= $("#id").val();
            var email = $("#email").val();
            var firstname = $("#firstname").val();
            var lastname=$("#lastname").val();
            var year=$("#year").val();
            var month=$("#month").val();
            var day=$("#day").val();
            var phone=$("#phone").val();
            var gender = $(':input:radio[name="gender"]:checked').val();
            var pwd = $("#pwd").val();
            var pwdConfirm = $("#pwdConfirm").val();

            if(email ==""){
                alert("이메일 정보를 확인 하세요");
                return;
            }
            if(lastname == ""){
                alert("성을 입력 하세요");
                $("#lastname").focus();
                return;
            }
            if(firstname == ""){
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
            if(phone.length == ""){
                alert("전화번호를 입력 하세요");
                return;
            }
            if(!checkPassword(pwd,"pwd") || !checkPassword(pwdConfirm,"pwdConfirm")){
                return;
            }
            if(pwd != pwdConfirm){
                alert("비밀번호가 틀립니다. 다시 입력하세요");
                $('#pwdConfirm').val('').focus();
                return;
            }

            var obj = new Object();
            obj.id = id;
            obj.email = email;
            obj.firstname = firstname;
            obj.lastname = lastname;
            obj.dob = year+month+day;;
            obj.phone = phone;
            obj.gender = gender;
            obj.password = pwd;
            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/web/user/modify","POST",jsonData)
//            document.forms1.action = "/web/emailSearch";
            //          document.forms1.submit();
        });
        
        // 프로필 변경
        $('#upload').click(function(){

            var fd = new FormData();
            var files = $('#file')[0].files[0];
            fd.append('file',files);
            fd.append('request',1);

            // AJAX request
            $.ajax({
                url: '/upload/uploadAjax',
                type: 'post',
                data: fd,
                contentType: false,
                processData: false,
                success: function(response){
                    if(response != 0){
                        // Show image preview
                        var prefix = '';
                        // $('#preview').append("<img src='"+prefix+response+"' width='100' height='100' style='display: inline-block;'>");
                        
                        var imgUrl = prefix+response;
                        var id = $("#id").val();
                        var ext = imgUrl.substr(imgUrl.lastIndexOf('.')+1,imgUrl.length);
                        
                        var phototype = '';
                        
                        switch(ext){
                        case 'png':
                        	phototype='image/png';
                        	break;
                        case 'jpg':
                        	phototype='image/jpeg';
                        	break;
                        case 'jpeg':
                        	phototype='image/jpeg';
                        	break;
                        }
                        
                        var obj = new Object();
			            obj.userid = id;
			            obj.photo = imgUrl;
			            obj.phototype = phototype;
			            
			            var jsonData = JSON.stringify(obj);
			            console.log(jsonData);
			            if ( ext == 'jpg' || ext == 'png' || ext == 'jpeg'){
			            	AjaxCall("/web/user/profileImgInsert","POST",jsonData,'/web/mypage');	
			            }else{
			            	alert("jpg jpeg png 파일만 가능합니다.");
			            }
			            
                    }else{
                        alert('file not uploaded');
                    }
                }
            });
        });
        // 프로필 변경 modal
        $('#editProfile').click(function(){
        	$('#uploadModal').modal("show");
        });
        
     	
    });

</script>
</html>
