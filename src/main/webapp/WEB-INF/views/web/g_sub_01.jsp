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
                <h2 class="right-tit">소그룹관리</h2>
                <button type="button" class="sea-btn add-btn" id="subgroupdel">소그룹삭제</button>

                <button type="button" class="sea-btn add-btn" onClick="location.href='/group/subgroup/subGrpCreate'">소그룹생성</button>
                <div class="col-xs-12 table-box">
                    <div class="table-responsive">
                        <table summary="This table shows how to create responsive tables using Bootstrap's default functionality" class="table table-bordered table-hover">
                            <colgroup>
                                <col width="3%">
                                <col width="15%">
                                <col>
                                <col width="17%">
                                <col width="9%">
                                <col width="15%">
                                <col width="15%">                                
                            </colgroup>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" name="all" class="check-all"></th>
                                    <th>소그룹아이디</th>
                                    <th>소그룹이름</th>
                                    <th>소그룹관리자</th>
                                    <th>멤버수</th>
                                    <th>시작일</th>
                                    <th>종료일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="subGroupVo" items="${subGroupList}" varStatus="status">
                                <tr>
                                    <td><input type="checkbox" id="subgroupid" class="subgroup" value="${subGroupVo.id},${subGroupVo.groupname}"></td>
                                    <td><a href="/group/subgroup/subGrpDetail/${subGroupVo.id}" style="cursor:pointer">${subGroupVo.id}</a></td>
                                    <td>${subGroupVo.groupname}</td>
                                    <td>${subGroupVo.lastname}${subGroupVo.firstname}</td>
                                    <td>${subGroupVo.membercount}</td>
                                    <td>
                                        <fmt:parseDate value="${subGroupVo.startdate}" var="startdate" pattern="yyyyMMdd"/>
                                        <fmt:formatDate value="${startdate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td>
                                        <fmt:parseDate value="${subGroupVo.enddate}" var="enddate" pattern="yyyyMMdd"/>
                                        <fmt:formatDate value="${enddate}" pattern="yyyy-MM-dd"/>
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


    <!--    소그룹삭제 g_sub_01_02 -->
    
    <div class="modal fade" id="subgroup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog add-modal" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <!-- 모달 이름 -->
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="exampleModalLabel">소그룹 삭제</h4>

                </div>
                <div class="modal-body text-center">
                    <div id="delsubgrp">

                    </div>
                    <form id="modalFrm">
                        <input type="hidden" id="selSubgrpId">
                    </form>
                    <p>해당 소그룹을 정말로 삭제하시겠습니까?</p>
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

    <!-- Footer -->
    <%@include file="/WEB-INF/views/web/inc/footer.jsp"%>
    <!-- Footer -->

</body>
<script>
    $(document).ready(function(){
        $( '.check-all' ).click( function() {
            $( '.subgroup' ).prop( 'checked', this.checked );
        } );
        $('#subgroupdel').click(function() {
            var chklen = $("input[id=subgroupid]:checkbox:checked").length;
            var _text = "";
            var _idtext = "";
            if(chklen == 0){
                alert("삭제할 소그룹을 선택해주세요");
                return;
            }else{
                var i = 1;
                $('#subgroupid:checked').each(function() {
                    _idtext = _idtext+$(this).val().split(",")[0];
                    _text= _text+$(this).val().split(",")[1];
                    if(i<chklen){
                        _idtext =_idtext+",";
                        _text= _text+"</br>";
                    }
                    i++;
                });
                $("#subgroup").modal("show");
                $("#delsubgrp").html(_text);
                $("#selSubgrpId").val(_idtext);
            }
        });
        $("#delete").click(function(){
            var subgroupid = $("#selSubgrpId").val();

            if(subgroupid== ""){
                alert("삭제할 소그룹이 없습니다.");
                return;
            }

            var obj = new Object();
            obj.subgroupid = subgroupid;

            var jsonData = JSON.stringify(obj);

            AjaxCall("/group/subgroup/subGroupDelete","POST",jsonData,"/group/subgroup");

        });
    });
</script>
</html>
