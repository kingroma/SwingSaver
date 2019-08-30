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
                    <h2 class="right-tit">소그룹 수정</h2>

                    <div class="form-page joinus-page edit-page">
                        <form>
                            <input type="hidden" id="groupid" value="${groupInfo.id}"/>
                            <input type="hidden" id="subgroupid" value="${subGroupInfo.subgroupid}"/>
                            <%--<div class="question">
                                <p>소그룹아이디</p>
                                <div class="que-info">
                                    <p>abcd</p>
                                </div>
                                
                            </div>--%>
                            <div class="question">
                                <p>소그룹이름</p>
                                <input type="text" class="que-val" id="groupname" value="${subGroupInfo.groupname}" required />
                            </div>
                            <div class="question">
                                <p>소그룹관리자</p>
                                <c:set var="sname" value="${subGroupInfo.lastname}${subGroupInfo.firstname}"/>
                                <select class="que-val" id="userid">
                                    <option value="" selected>관리자를 선택하세요</option>
                                    <c:forEach var="grpmembers" items="${memberList}" varStatus="status" >
                                    	<c:if test='${grpmembers.status == "Y" }'>
	                                        <c:set var="name" value="${grpmembers.lastname}${grpmembers.firstname}"/>
	                                        <c:choose>
	                                            <c:when test="${sname eq  name}">
	                                                <option value="${grpmembers.userid}" selected>${name}(${grpmembers.dob})</option>
	                                            </c:when>
	                                            <c:otherwise>
	                                                <option value="${grpmembers.userid}">${name}(${grpmembers.dob})</option>
	                                            </c:otherwise>
	                                        </c:choose>
										</c:if>
                                    </c:forEach>
                                </select>
                                <%--<div class="inquiry-box">

                                    <p> </p>
                                    <p> </p>

                                    <p class="con-blue">*그룹멤버만 조회가능합니다.</p>
                                </div> --%>
                            </div>
                            

                            <div class="question">
                                <p>멤버 수</p>
                                
                                <input type="text" class="que-val"  id="quota" value="${subGroupInfo.quota}" required />
                            </div>
                            <div class="question">
                                <p>시작 날짜</p>
                                <input type="text" class="que-val" id="startdate" value="${subGroupInfo.startdate}" required />
                            </div>
                            <div class="question">
                                <p>종료 날짜</p>
                                <input type="text" class="que-val" id="enddate" value="${subGroupInfo.enddate}" required />
                            </div>
                            <button class="form-btn" type="button" id="subgroup" >수정</button>


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
<script src="/js/jquery.min.js"></script>
<script src="/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="/css/jquery-ui.css" type="text/css" />  
<script>

    $(document).ready(function(){

        $("#quota").keyup(function(){ $(this).val($(this).val().replace(/[^0-9]/gi,"") );  }); //숫자만

        $("#subgroup").click(function(){
            var subgroupid = $("#subgroupid").val();
            var groupid = $("#groupid").val();
            var groupname = $("#groupname").val();
            var quota = $("#quota").val();
            var userid = $("#userid option:selected").val();
            var startdate=$("#startdate").val();
            var enddate=$("#enddate").val();


            if(groupname ==""){
                alert("그룹이름을 입력 하세요");
                return;
            }

            if(userid ==""){
                alert("소그룹 관리자를 선택해 주세요");
                return
            }
            if(quota ==""){
                alert("멤버 수를 입력해 주세요");
                return
            }
            if(startdate == ""){
                alert("소그룹 시작일자를 입력 하세요");
                return;
            }
            if(enddate == ""){
                alert("소그룹 종료일자를 입력 하세요");
                return;
            }

            var obj = new Object();
            obj.subgroupid = subgroupid;
            obj.groupid = groupid;
            obj.groupname = groupname;
            obj.userid = userid;
            obj.quota = quota;
            obj.startdate = replaceAll(startdate,'-','');
            obj.enddate = replaceAll(enddate,'-','');

            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/group/subgroup/subGroupUpdate","POST",jsonData,'/group/subgroup/subGrpDetail/'+$('#subgroupid').val());

        });
        
        fn_datepicker();
    });

    function replaceAll(str, searchStr, replaceStr) {
    	return str.split(searchStr).join(replaceStr);
    }
    
    function fn_datepicker(){
		$( "#startdate,#enddate" ).datepicker({
            
            dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'],
            dateFormat:'yy-mm-dd',
            monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
        });

       $('#startdate').datepicker("option", "maxDate", $("#enddate").val());
       $('#startdate').datepicker("option", "onClose", function (selectedDate){
           $("#enddate").datepicker( "option", "minDate", selectedDate );
           });

       $('#enddate').datepicker();
       $('#enddate').datepicker("option", "minDate", $("#startdate").val());
       $('#enddate').datepicker("option", "onClose", function (selectedDate){
           $("#startdate").datepicker( "option", "maxDate", selectedDate );
          });

    }
</script>
</html>
