var loadingBarWindth = 100;
var loadingBarHeight = 100;

function fn_loadingBarResize(){
	var target = $('#loadingBar');
	var windowHeight = $(window).height();
	var windowWidth = $(window).width();
	
	console.dir(loadingBarWindth +'/'+loadingBarHeight)
	
	var css = {
		'margin-left': (windowWidth/2 - loadingBarWindth/2) + 'px' ,
		'margin-top': (windowHeight/2 - loadingBarHeight/2) + 'px'
	}
	
	target.css(css);
}
function fn_getLodingBar(){
	var divCss = {
		'position': 'fixed',
		'width': '100%',
		'height': '100%',
		'background-color': '#e2e2e2',
		'opacity': '1',
		'z-index': '99',
		'top': '0%',
		'left': '0%',
		'opacity': '0.5',
		'display':'none'
	}
	var imgCss = {
		'opacity': '1.0',
		'width': '100px',
		'height': '100px'
	}

	var div = $('<div id="loadingBarDiv"></div>').css(divCss);
	var img = $('<img id="loadingBar" src="/image/loading.gif"></img>').css(imgCss);
	div.append(img);
	return div;
}

$(document).ready(function(){
	$('body').append(fn_getLodingBar());
	
	fn_loadingBarResize();
	
	$( window ).resize( function() {
		fn_loadingBarResize();
	});
})
.ajaxStart(function(){
	$('#loadingBarDiv').show(); 
})
.ajaxStop(function(){
	setTimeout(function(){
		$('#loadingBarDiv').hide();
	},1000);
});

$(function(){
    $(".phone-number-check").on('keydown', function(e){
        // 숫자만 입력받기
        var trans_num = $(this).val().replace(/-/gi,'');
        var k = e.keyCode;

        if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
        {
            e.preventDefault();
        }
    }).on('blur', function(){ // 포커스를 잃었을때 실행합니다.
        if($(this).val() == '') return;

        // 기존 번호에서 - 를 삭제합니다.
        var trans_num = $(this).val().replace(/-/gi,'');

        // 입력값이 있을때만 실행합니다.
        if(trans_num != null && trans_num != '')
        {
            // 총 핸드폰 자리수는 11글자이거나, 10자여야 합니다.
            if(trans_num.length==11 || trans_num.length==10)
            {
                // 유효성 체크
                var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
                if(regExp_ctn.test(trans_num))
                {
                    // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.$1-$2-$3
                    trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1$2$3");
                    $(this).val(trans_num);
                }
                else
                {
                    alert("유효하지 않은 전화번호 입니다.");
                    $(this).val("");
                    $(this).focus();
                }
            }
            else
            {
                alert("유효하지 않은 전화번호 입니다.");
                $(this).val("");
                $(this).focus();
            }
        }
    });
});
var nextUri ="";
function pageUri() {
    var arrayUri= currUri.split("\/");
    var maxLen = arrayUri.length;

    if("log_02_01.jsp" == arrayUri[maxLen-1]){
        nextUri = "/web/user/joinSuccess";
    }else if("mypage_01.jsp" == arrayUri[maxLen-1]){
        nextUri = "/web/mypage";
    }else if("g_reg_01_01.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/group/groupSuccess";
    }else if("g_reg_02_01.jsp" == arrayUri[maxLen-1]){
        nextUri = "/group/groupMemberSucc";
    }else if("g_info_01.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/group/mygroup";
    }else if("g_sub_01_01.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/group/subgroup";
    }else if("g_sub_02_02.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/group/subgroup/subGrpDetail";
    }else if("log_03_01_01.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/web/search/pwreset";
    }else if("log_03_02_01.jsp" == arrayUri[maxLen-1]) {
        nextUri = "/web/search/pwresetComp";
    }
    //alert(nextUri);
    return nextUri;
}
function AjaxCall(url,method,data,direct) {
    $.ajax({
        type: method,
        url : url,
        data: data,
        dataType:"json",
        async:true,
        contentType:"application/json;charset=UTF-8",
        success : function(rtnData) {

            var reqdata = JSON.parse(rtnData.data);
            var pathuri = "";

            $("#ajax").remove();
            if(reqdata.result == "true"){
                alert("정상적으로 처리가 완료되었습니다.");
                if(!isEmpty(reqdata.groupid)){
                    pathuri = "/"+reqdata.groupid;
                }else if(!isEmpty(reqdata.subgroupid)){
                    pathuri = "/"+reqdata.subgroupid;
                }
                //console.log(data.subgroupid);
                if ( direct != undefined && direct != null && direct != '' ){
                	location.href= direct+pathuri;
                }else {
                	location.href= pageUri()+pathuri;
                }
                
                return true;
            }else{
                if(!isEmpty(reqdata.error)){
                    alert(reqdata.error);
                }else{
                    alert("처리중 오류가 발생했습니다.");
                }

                return false;
            }

        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}
function isEmpty(str){

    if(typeof str == "undefined" || str == null || str == "")
        return true;
    else
        return false ;
}

function checkPassword(password,id){

    if(!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,25}$/.test(password)){
        alert('비밀번호는 영문/숫자/특수문자 조합으로 6자리 이상 사용해야 합니다.');
        if(id == "pwd"){
        }else{
            $('#pwdConfirm').val('').focus();
        }

        return false;
    }
    return true;
}
function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(email);
}
function checkCorporateRegistrationNumber(value) {
    var valueMap = value.replace(/-/gi, '').split('').map(function(item) {
        return parseInt(item, 10);
    });

    if (valueMap.length === 10) {
        var multiply = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5);
        var checkSum = 0;

        for (var i = 0; i < multiply.length; ++i) {
            checkSum += multiply[i] * valueMap[i];
        }

        checkSum += parseInt((multiply[8] * valueMap[8]) / 10, 10);
        return Math.floor(valueMap[9]) === (10 - (checkSum % 10));
    }

    return false;
}
function selemail(email){
    var $ele = $(email);
    var $stremail02 = $('input[name=stremail02]');
    if($ele.val()== '1'){ //직접입력일 경우
        $stremail02.val(''); //값 초기화
        $stremail02.attr("readonly",false); //활성화
    }else{ //직접입력이 아닐경우
        $stremail02.val($ele.val()); //선택값 입력
        $stremail02.attr("readonly",true); //비활성화
    }

}
function birthChk(birth) {
    var format = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
    if(format.test(birth)){
        return true;
    }else{
        return false;
    }
}

