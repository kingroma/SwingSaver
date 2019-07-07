<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <%@include file="/WEB-INF/views/web/inc/header.jsp"%>
</head>

<body>
    <%@include file="/WEB-INF/views/web/inc/navi.jsp"%>

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
                        <li><a href="/group/groupmember">그룹멤버관리</a></li>
                        <li><a class="active" href="/group/subgroup">소그룹관리</a></li>
                        <li><a href="#">월 이용 결제</a></li>
                        <li><a href="#">결제내역 조회</a></li>
                        <li><a href="#">서비스 변경 요청</a></li>
                    </ul>
                </div>

            </div>
            <div class="content col-xs-9" style="padding: 0;">
                <div class="col-xs-12 no-padding">
                    <h2 class="right-tit">소그룹상세</h2>
                    <div class="sub-mem-list">
                    <h4 class="sub-tit">소그룹정보</h4>
                    <div class="sub-g-btn">
                        <button type="button" class="edit-btn" id="modify" >수정</button>
                        <%--<button type="button" class="edit-btn"  onclick="fnSubGroupModify()">수정</button>--%>
                        <button type="button" class="edit-btn" id="subgroupdel">삭제</button>
                        <button type="button" class="sea-btn add-btn" data-target="#" onClick="location.href='/group/subgroup'">
                        <img src="/image/back-list.png" cwidth="100%" >
                            소그룹목록</button>
                    </div>
                    <div class="col-xs-12 table-box">
                        <div class="table-responsive">
                            <table summary="This table shows how to create responsive tables using Bootstrap's default functionality" class="table table-bordered table-hover">
                                <colgroup>
                                    <col width="30%">
                                    <col width="70%">

                                </colgroup>

                                <tbody>
                                    <tr>
                                        <td><strong>소그룹아이디</strong></td>
                                        <td>${subGroupInfo.subgroupid}</td>
                                    </tr>                                    
                                    <tr>
                                        <td><strong>소그룹이름</strong></td>
                                        <td>${subGroupInfo.groupname}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>소그룹관리자</strong></td>
                                        <td>${subGroupInfo.lastname}${subGroupInfo.firstname}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>최대 멤버 수</strong></td>
                                        <td>${subGroupInfo.membercount}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>시작날짜</strong></td>
                                        <td>
                                            <fmt:parseDate value="${subGroupInfo.startdate}" var="sDate" pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${sDate}" pattern="yyyy-MM-dd"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>종료날짜</strong></td>
                                        <td><fmt:parseDate value="${subGroupInfo.enddate}" var="eDate" pattern="yyyyMMdd"/>
                                            <fmt:formatDate value="${eDate}" pattern="yyyy-MM-dd"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    </div>

                    <div class="sub-mem-list">
                    <h4 class="sub-tit">소그룹멤버</h4>
                    <div class="sub-g-btn">
                        <button type="button"  class="edit-btn" id="subgrpmove">이동</button>
                        <button type="button"  class="edit-btn" id="memberdelete">삭제</button>
                    </div>
                    <div class="col-xs-12 table-box">
                        <div class="table-responsive">
                            <table summary="This table shows how to create responsive tables using Bootstrap's default functionality" class="table table-bordered table-hover">
                                <colgroup>
                                    <col width="3%">
                                    <col width="27%">
                                    <col width="50%">
                                    <col width="20%">

                                </colgroup>
                                <thead>
                                    <tr>
                                        <th><input type="checkbox" name="all" class="check-all"></th>
                                        <th>이름</th>
                                        <th>이메일</th>
                                        <th>등급</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="list" items="${subGroupInfo.subgroupmembers}" varStatus="status">
                                    <tr>
                                        <td><input type="checkbox" id="userid" class="userid" value="${list.userid},${list.lastname}${list.firstname}"></td>
                                        <td>${list.lastname}${list.firstname}</td>
                                        <td>${list.email}</td>
                                        <td><c:set var="mtype" value="${list.membertype}"/>
                                            <c:choose>
                                                <c:when test="${mtype eq 'A'}">
                                                    Administrator
                                                </c:when>
                                                <c:when test="${mtype eq 'P'}">
                                                    Professional
                                                </c:when>
                                                <c:otherwise>
                                                    Student
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
            </div>
        </article>
    </section>

    <!--    소그룹멤버삭제 g_sub_02_01_02 -->

    <div class="modal fade" id="subgrpmember" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog add-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- 모달 이름 -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="exampleModalLabel">소그룹멤버 삭제</h4>

                </div>
                <div class="modal-body text-center">
                    <div id="delsubgrpmember">

                    </div>
                    <form id="modalFrm">
                        <input type="hidden" id="seluserId">
                    </form>
                    <p>해당 소그룹멤버를 정말로 삭제하시겠습니까?</p>
                    <!-- 모달 내용 -->
                </div>
                <div class="modal-footer">
                    <!-- data-dismiss="modal"를 통해 모달을 닫을수 있다. -->
                    <div class="col-md-12">
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn btn-secondary" id="delete">삭제</button>
                        </div>
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    
   <!--    소그룹멤버이동 g_sub_02_01_01 -->

    <div class="modal fade" id="subgroupmove" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog add-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- 모달 이름 -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="exampleModalLabel1">소그룹멤버 이동</h4>

                </div>
                <div class="modal-move">
                        <input type="hidden" id="selmvuserId">
                        <c:forEach var="subGroupVo" items="${subGroupList}" varStatus="status">
                            <c:choose>
                                <c:when test="${subGroupVo.id eq subGroupInfo.subgroupid}">
                                    <p><input type="radio" name="targetgrp" value="${subGroupVo.id}" disabled >${subGroupVo.groupname}<font color="red">(현재 그룹)</font> </p>
                                </c:when>
                                <c:otherwise>
                                    <p><input type="radio" name="targetgrp" value="${subGroupVo.id}">${subGroupVo.groupname}</p>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    <!-- 모달 내용 -->
                </div>
                <div class="modal-footer">
                    <!-- data-dismiss="modal"를 통해 모달을 닫을수 있다. -->
                    <div class="col-md-12">
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn" id="move">이동</button>
                        </div>
                        <div class="mo-pa col-md-6 ">
                            <button type="button" class="modal-btn btn-secondary" data-dismiss="modal">취소</button>
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
        $("#subgroupdel").click(function(){
            var obj = new Object();
            obj.subgroupid = ${subGroupInfo.subgroupid};

            var jsonData = JSON.stringify(obj);
            if(confirm("소그룹을 정말 삭제 하시겠습니까?")){
                AjaxCall("/group/subgroup/subGroupDelete","POST",jsonData,'/group/subgroup');
            }else{
                return;
            }
        });
        $('#memberdelete').click(function() {
            var chklen = $("input[id=userid]:checkbox:checked").length;
            var _text = "";
            var _idtext = "";
            if(chklen == 0){
                alert("삭제할 소그룹 멤버를 선택해주세요");
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
                $("#subgrpmember").modal("show");
                $("#delsubgrpmember").html(_text);
                $("#seluserId").val(_idtext);
            }
        });
        $("#delete").click(function(){
            var subgroupid = '${subGroupInfo.subgroupid}';
            var userid = $("#seluserId").val();

            if(userid== ""){
                alert("삭제할 소그룹 멤버가 없습니다.");
                return;
            }

            var obj = new Object();
            obj.subgroupid = subgroupid;
            obj.userid = userid;

            var jsonData = JSON.stringify(obj);
			// alert(jsonData);
            AjaxCall("/group/subgroup/subGroupUserDelete","POST",jsonData);
            $("#subgrpmember").modal("hide");
        });
        $('#subgrpmove').click(function() {
            var chklen = $("input[id=userid]:checkbox:checked").length;
            var _text = "";
            var _idtext = "";
            if(chklen == 0){
                alert("이동할 소그룹 멤버를 선택해주세요");
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
                $("#subgroupmove").modal("show");
                $("#selmvuserId").val(_idtext);
            }
        });
        $("#move").click(function(){
            var sourceid = ${subGroupInfo.subgroupid};
            var userid = $("#selmvuserId").val();
            var targetid = $(":input:radio[name=targetgrp]:checked").val();

            if(userid== ""){
                alert("이동할 소그룹 멤버가 없습니다.");
                return;
            }

            var obj = new Object();
            obj.sourceid = sourceid;
            obj.targetid = targetid;
            obj.userid = userid;

            var jsonData = JSON.stringify(obj);

            AjaxCall("/group/subgroup/subGroupMove","POST",jsonData);
            $("#subgroupmove").modal("hide");
        });
        $('#modify').click( function() {
            var $form = $('<form></form>');
            $form.attr('action', '/group/subgroup/subGroupModify');
            $form.attr('method', 'post');
            $form.appendTo('body');

            var subgroupid = $('<input type="hidden" value="${subGroupInfo.subgroupid}" name="subgroupid">');
            var groupname = $('<input type="hidden" value="${subGroupInfo.groupname}" name="groupname">');
            var quota = $('<input type="hidden" value="${subGroupInfo.quota}" name="quota">');
            var userid = $('<input type="hidden" value="${subGroupInfo.userid}" name="userid">');
            var startdate = $('<input type="hidden" value="${subGroupInfo.startdate}" name="startdate">');
            var enddate = $('<input type="hidden" value="${subGroupInfo.enddate}" name="enddate">');
            var lastname = $('<input type="hidden" value="${subGroupInfo.lastname}" name="lastname">');
            var firstname = $('<input type="hidden" value="${subGroupInfo.firstname}" name="firstname">');

            $form.append(subgroupid)
                .append(groupname)
                .append(quota)
                .append(userid)
                .append(startdate)
                .append(enddate)
                .append(lastname)
                .append(firstname)
            $form.submit();
        });
    });
</script>

</html>
