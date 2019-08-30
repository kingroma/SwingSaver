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
                    <h2 class="right-tit">소그룹 생성</h2>

                    <div class="form-page joinus-page edit-page">


                        <form>
                            <input type="hidden" id="groupid" value="${groupInfo.id}"/>
                            <div class="que-btn-01">
                                <p>소그룹아이디</p>
                                자동 생성
                                <%--<button class="que-btn-02" id="subgid" type="button">중복확인</button>
                                <input type="text" id="subgroupid" placeholder="영문4글자" required />--%>

                            </div>
                            <div class="question">
                                <p>소그룹이름</p>
                                <input type="text" id="groupname" placeholder="소그룹이름" required />
                            </div>
                            <div class="question">
                                <p>소그룹관리자</p>
                                <select class="que-val" id="userid">
                                    <option value="" selected>관리자를 선택하세요</option>
                                    <c:forEach var="grpmembers" items="${memberList}" varStatus="status" >
                                    	<c:if test='${grpmembers.status == "Y" }'>
                                    		<option value="${grpmembers.userid}">${grpmembers.lastname}${grpmembers.firstname}(${grpmembers.dob})</option>
                                    	</c:if>
                                    </c:forEach>
                                </select>
                                <%--<input type="text" placeholder="관리자 이름입력" required />
                                <div class="inquiry-box">
                                    <p>동명이인(1970-02-14)</p>
                                    <p>동명이인(1981-11-19)</p>

                                </div>--%>
                                <p class="con-blue">*그룹멤버만 조회가능합니다.</p>
                            </div>
                            

                            <div class="question">
                                <p>멤버 수</p>
                                <input type="text" id="quota" placeholder="최대 멤버 수 입력" required />
                            </div>
                            <div class="question">
                                <p>시작 날짜</p>
                                <input type="text" id="startdate" placeholder="소그룹 시작 날짜 입력" required />
                            </div>
                            <div class="question">
                                <p>종료 날짜</p>
                                <input type="text" id="enddate" placeholder="소그룹 종료 날짜 입력" required />
                            </div>
                            <button class="form-btn" id="subgroup" type="button">생성</button>


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
                alert("소그룹 멤버 수를 입력해 주세요");
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
            obj.groupid = groupid;
            obj.groupname = groupname;
            obj.userid = userid;
            obj.quota = quota;
            obj.startdate = replaceAll(startdate,'-','');
            obj.enddate = replaceAll(enddate,'-','');


            var jsonData = JSON.stringify(obj);
            console.log(jsonData);
            AjaxCall("/group/subgroup/subGroupInsert","POST",jsonData,'/group/subgroup/subGrpDetail');

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
