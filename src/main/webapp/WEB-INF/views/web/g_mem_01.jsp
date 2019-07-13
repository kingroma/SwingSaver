<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>
	<input type="hidden" id="selgrpuserId">
	<input type='hidden' id='membertype'>
	
    <section class="container no-padding">
        <article class="col-xs-12" style="padding: 0;">
            <div class="content-nav col-xs-3">
                <div class="side-menu">
                    <div class="user-info">
                        <p class="side-user">ID : <span>${groupInfo.id}</span></p>
                        <p class="meter-l meter-ti">현재회원 <span>${groupInfo.membercount}</span></p>
                        <p class="meter-r meter-ti">등록가능회원 <span>${groupInfo.quota-groupInfo.membercount}</span></p>

                        <div class="meter info_color">
                            <c:set var="rating" value="${(groupInfo.membercount+0.0)/(groupInfo.quota+0.0)}"/>
                            <c:choose>
                                <c:when test="${groupInfo.membercount == 0 || rating == 'NaN'}">
                                    <span style="width: 0%"></span>
                                </c:when>
                                <c:otherwise>
                                    <span style="width:<fmt:formatNumber value="${rating}" type="percent"/>"></span>
                                </c:otherwise>
                            </c:choose>
                        </div>



                        <p class="side-info">${groupInfo.groupname} |
                            <c:choose>
                                <c:when test="${groupInfo.grouptype eq 'A'}">
                                    Academy
                                </c:when>
                                <c:otherwise>
                                    Range
                                </c:otherwise>
                            </c:choose>
                            <br/>할당회원:${groupInfo.quota} | 1인당 스토리지:${groupInfo.storagespace}M</p>
                    </div>
                    <ul>
                        <li><a href="/group/mygroup">그룹정보수정</a></li>
                        <li><a class="active" href="/group/groupmember">그룹멤버관리</a></li>
                        <li><a href="/group/subgroup">소그룹관리</a></li>
                        <li><a href="#">월 이용 결제</a></li>
                        <li><a href="#">결제내역 조회</a></li>
                        <li><a href="#">서비스 변경 요청</a></li>
                    </ul>
                </div>

            </div>
            <div class="content col-xs-9" style="padding: 0;">
            <div class="col-xs-12 no-padding">                
                <h2 class="right-tit">그룹멤버관리</h2>
                
<!--                멤버삭제팝업은 경우에 따라 g_mem_01_01, g_mem_01_02  -->
                <button type="button" id="memberdelete" class="sea-btn del-btn">멤버삭제</button>
                <div class="rig-btn-wrap">
                    <button type="button" id='memberacceptcancel' class="sea-btn add-btn">승인/취소</button>
                </div>

                <div class="col-xs-12 table-box">
                    <div class="table-responsive">
                        <table summary="This table shows how to create responsive tables using Bootstrap's default functionality" class="table table-bordered table-hover">
                            <colgroup>
                                <col width="3%">
                                <col width="15%">
                                <col width="23%">
                                <col width="10%">
                                <col width="7%">
                                <col width="15%">
                                <col width="10%">
                                <col width="10%">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="all" class="check-all"></th>
                                    <th>이름</th>
                                    <th>이메일</th>
                                    <th>생년월일</th>
                                    <th>성별</th>
                                    <th>전화번호</th>
                                    <th>등급</th>   
                                    <th>승인여부</th>                                
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="userVo" items="${memberList}" varStatus="status">
                                    <tr>
                                        <td><input type="checkbox" id="userid" membertype='${userVo.membertype }' class="userid" value="${userVo.userid},${userVo.lastname}${userVo.firstname}"></td>
                                        <td>${userVo.lastname}${userVo.firstname}</td>
                                        <td>${userVo.email}</td>
                                        <td>${userVo.dob}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${userVo.gender eq 'M'}">
                                                    남자
                                                </c:when>
                                                <c:when test="${userVo.gender eq 'F'}">
                                                    여자
                                                </c:when>
                                                <c:otherwise>
                                                    -
                                                </c:otherwise>
                                            </c:choose></td>
                                        <td>${userVo.phone}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${userVo.membertype eq 'A'}">
                                                    Administrator
                                                </c:when>
                                                <c:when test="${userVo.membertype eq 'P'}">
                                                    Professional
                                                </c:when>
                                                <c:otherwise>
                                                    Student
                                                </c:otherwise>
                                            </c:choose></td>
                                        <td class="con-blue">
                                            <c:choose>
                                                <c:when test="${userVo.status eq 'Y'}">
                                                    승인
                                                </c:when>
                                                <c:when test="${userVo.status eq 'N'}">
                                                    취소
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="sea-btn add-btn" id="" onclick="javascript:fn_accept('${userVo.userid}','${userVo.membertype}')">승인</button> /
                                                    <button type="button" class="sea-btn add-btn" id="" onclick="javascript:fn_cancel('${userVo.userid}','${userVo.membertype}')">취소</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            </div> 
        </article>
    </section>


    <!--    그룹멤버삭제 g-mem-01-01 -->
    
    <div class="modal fade" id="grpmemberdel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog add-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- 모달 이름 -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="exampleModalLabel">그룹멤버 삭제</h4>

                </div>
                <div class="modal-body text-center">
                    <div id="delgrp">

                    </div>
                    <form id="modalFrm">
                        
                    </form>
                    <p>해당 멤버를 정말로 삭제하시겠습니까?</p>
                    <!-- 모달 내용 -->
                </div>
                <div class="modal-footer">
                    <!-- data-dismiss="modal"를 통해 모달을 닫을수 있다. -->
                    <div class="col-md-12">
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn btn-secondary" id="delete" >삭제</button>
                        </div>  
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn" data-dismiss="modal">취소</button>
                        </div>    
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!-- 승인 취소 처리 MODAL -->
	<div class="modal fade" id="grpmemberacptcnl" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog add-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- 모달 이름 -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="exampleModalLabel">그룹멤버 삭제</h4>

                </div>
                <div class="modal-body text-center">
                    <div id="acptcnlgrp">

                    </div>
                    <form id="modalFrm">
                        
                    </form>
                    <p>승인 / 취소를 하시겠습니까?</p>
                    <!-- 모달 내용 -->
                </div>
                <div class="modal-footer">
                    <!-- data-dismiss="modal"를 통해 모달을 닫을수 있다. -->
                    <div class="col-md-12">
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn btn-secondary" style='padding:2px;' id="accept" >승인</button>
                        </div>
                        <div class="mo-pa col-md-6 " style=''>
                            <button type="button" class="modal-btn btn-secondary" style='padding:2px' id="cancel">취소</button>
                        </div>  
                        <div class="mo-pa col-md-12 ">
                            <button type="button" class="modal-btn" data-dismiss="modal">닫기</button>
                        </div>    
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
<script>
    $(document).ready(function(){
        $( '.check-all' ).click( function() {
            $( '.userid' ).prop( 'checked', this.checked );
        } );

        $('#memberdelete').click(function() {
            var chklen = $("input[id=userid]:checkbox:checked").length;
            var _text = "";
            var _idtext = "";
            if(chklen == 0){
                alert("삭제할 그룹 멤버를 선택해주세요");
                return;
            }else{
                var i = 1;
                $('#userid:checked').each(function() {
                    _idtext = _idtext+$(this).val().split(",")[0];
                    _text= _text+$(this).val().split(",")[1];
                    if(i<chklen){
                        _idtext =_idtext+",";
                        _text= _text+"</br>";
                    }
                    i++;
                });
                $("#grpmemberdel").modal("show");
                $("#delgrp").html(_text);
                $("#selgrpuserId").val(_idtext);
            }
        });
        $("#delete").click(function(){
            var groupid = ${sessionScope.login.groupid};
            var userid = $("#selgrpuserId").val();


            var obj = new Object();
            obj.groupid = groupid;
            obj.userid = userid;

            var jsonData = JSON.stringify(obj);
            AjaxCall("/group/groupMemberDelete","POST",jsonData);

        });

        
        $('#memberacceptcancel').click(function() {
            var chklen = $("input[id=userid]:checkbox:checked").length;
            var _text = "";
            var _idtext = "";
           	var _membertype = ""; 
           
            if(chklen == 0){
                alert("승인/취소할 그룹 멤버를 선택해주세요");
                return;
            }else{
                var i = 1;
                $('#userid:checked').each(function() {
                    _idtext = _idtext+$(this).val().split(",")[0];
                    _text= _text+$(this).val().split(",")[1];
                    _membertype = _membertype + $(this).attr("membertype")
                    if(i<chklen){
                        _idtext =_idtext+",";
                        _text= _text+"</br>";
                        _membertype = _membertype + ",";
                    }
                    i++;
                });
                $("#grpmemberacptcnl").modal("show");
                $("#acptcnlgrp").html(_text);
                $('#membertype').val(_membertype);
                $("#selgrpuserId").val(_idtext);
            }
        });
        
        $("#accept").click(function(){
            var groupid = ${sessionScope.login.groupid};
            var userid = $("#selgrpuserId").val();
			var membertype = $('#membertype').val();

            var obj = new Object();
            obj.groupid = groupid;
            obj.userid = userid;
            obj.status = 'Y';
			obj.membertype = membertype;
            
            var jsonData = JSON.stringify(obj);
            
            console.dir(obj);
            AjaxCall("/group/groupMemberAcceptCancel","POST",jsonData);

        });
        
        $("#cancel").click(function(){
            var groupid = ${sessionScope.login.groupid};
            var userid = $("#selgrpuserId").val();
            var membertype = $('#membertype').val();

            var obj = new Object();
            obj.groupid = groupid;
            obj.userid = userid;
            obj.status = 'N';
            obj.membertype = membertype;
            var jsonData = JSON.stringify(obj);
            
            console.dir(obj);
            AjaxCall("/group/groupMemberAcceptCancel","POST",jsonData);

        });
    });
    
    function fn_accept(userid,membertype){
    	var msg = '승인하시겠습니까?' 
    	var groupid = ${sessionScope.login.groupid};

        var obj = new Object();
        obj.groupid = groupid;
        obj.userid = userid;
        obj.membertype = membertype;
        obj.status = 'Y'

        var jsonData = JSON.stringify(obj);
        if ( confirm (msg) ){
        	console.dir(obj);
        	AjaxCall("/group/groupMemberAcceptCancel","POST",jsonData);	
        }
        
    }
    function fn_cancel(userid,membertype){
    	var msg = '취소하시겠습니까?'
    	
    	var groupid = ${sessionScope.login.groupid};

        var obj = new Object();
        obj.groupid = groupid;
        obj.userid = userid;
        obj.membertype = membertype;
        obj.status = 'N'
	
        
        
        var jsonData = JSON.stringify(obj);

        
        if ( confirm (msg) ){
        	console.dir(obj);
        	if ( AjaxCall("/group/groupMemberAcceptCancel","POST",jsonData) ) {
        		location.reload();	
        	}
        	
        }
    }
</script>
</html>
