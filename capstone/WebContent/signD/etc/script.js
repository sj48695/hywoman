// 로그인 체크
function idCheck(id) {
	if (id == null || id.equals("")) {
		alert("권한이 없습니다. 로그인을 해주세요!");
		history.go(0);
		return false;
	}
};
//아이디 포커스
$('#member').on('shown.bs.modal', function () {
	  $('input[name=id]').trigger('focus');
	});

//비밀번호 확인
function checkPw(passwd) {
	var pw = document.getElementById("chPw");
	if(pw.type == "password" && passwd==pw.value){//비밀번호 확인
		tabChange("settings")
	}else{
		alert("비밀번호가 맞지 않습니다.");
		pw.setfocus;
		pw.value="";
	}
}

//마이페이지 tab변경
function tabChange(target){
	$(".nav-tabs li a").removeClass("active show");
	$(".nav-tabs li a").attr("aria-selected","false");
	$(".tab-pane").attr("class","tab-pane fade");
	//모두해제

	$("#contest").addClass("active show");
	//$("#toMsg").addClass("active show");
	$("#"+target).addClass("show active");
	$("#"+target+"-tab").addClass("active show");
	$("#"+target+"-tab").attr("aria-selected","true");
}

function tab2Change(tab1,tab2){
	//tab1
	$(".nav-tabs li a").removeClass("active show");
	$(".nav-tabs li a").attr("aria-selected","false");
	$(".tab-pane").attr("class","tab-pane fade");
	//모두해제

	$("#"+tab1).addClass("show active");
	$("#"+tab1+"-tab").addClass("active show");
	$("#"+tab1+"-tab").attr("aria-selected","true");
	
	//tab2
	$("#"+tab2).addClass("active show");
	$("#"+tab2+"Msg").addClass("active show");
	$("#"+tab2+"Msg").attr("aria-selected","true");

	$("#"+tab2+"Request").addClass("active show");
	$("#"+tab2+"Request").attr("aria-selected","true");
	
	$("#"+tab2+"BM").addClass("active show");
	$("#"+tab2+"BM").attr("aria-selected","true");
	
	$("#"+tab2+"OTORequest").addClass("active show");
	$("#"+tab2+"OTORequest").attr("aria-selected","true");
}
/*$(document).ready(function(){
	$(document).load(function(){
		return tabChange("message");
	})
})*/
/*function selectMsg(type){
	if(type=="받은쪽지함"){
		type="보낸쪽지함";
	}else if(type=="보낸쪽지함"){
		type="받은쪽지함";
	}
	alert(type);
	return type;
}*/

//모두선택
function setCheckAll(checked,type) {
	
	var objs = document.getElementsByTagName("input");
	
	for (var i = 0; i < objs.length; i++) {
		if(objs[i].type == "checkbox" && objs[i].className==type){//체크박스이면 상태를 바꿔라
			objs[i].checked = checked;
		}
	}
}
// 쪽지 삭제의사 결정
function delCheck(del,type){
	if(confirm("삭제하시겠습니까?")) {
		del.action="msgDelPro.jsp?type="+type;
		del.submit();
	}
}

//삭제의사 결정
function deleteCheck(url){
   if(confirm("정말 삭제하시겠습니까?")){
	   document.location.href=url;
   }
}
//즐겨찾기 추가/삭제
function bmCheck(i,rqcode,dID,userId){
	var action = null;
	if(userId=="null" ||userId==""){
		alert("권한이 없습니다. 로그인을 해주세요.");
	}else{
		if($("#star"+i).attr("aria-pressed")=="true"){//즐겨찾기가 되어있는 경우(찬별-->빈별)
			$("#star"+i).attr("aria-pressed","false");
			$("#star"+i).html('<font size="5"><i class="far fa-star"></i></font>');//즐겨찾기 취소상태
				
			action="/capstone/signD/mypage/bookMarkDelPro.jsp"
		}else{//즐겨찾기가 안되어 있는 경우(빈별-->찬별)
			$("#star"+i).attr("aria-pressed","true");
			$("#star"+i).html('<font size="5"><i class="fas fa-star"></i></font>');//즐겨찾기 추가상태
				
			action="/capstone/signD/mypage/bookMarkInsertPro.jsp"
		
		}
		var form_data = {
				requestcode: rqcode,
				designer_id: dID
		};
		$.ajax({
			type : "POST",
			url : action,
			data : form_data,
			success : function(response) {},
			error : function() {}
		});
	}
}
//댓글contentid
function replyName(i) {
	$("#reply" + i).attr("name", "reply");
	return true;
}




//중복아이디체크(insertMember2.jsp)
$("#confirmId").click(function(){
	
	var form_data = {
			userId : $("#userId").val()
		};
	$.ajax({
		type : "POST",
		url : "confirmIdPro.jsp",
		data : form_data,
		success : function(response) {
			if (response == 1) {
				$("#idMsg").text("이미 사용중이거나 탈퇴한 아이디입니다.");
				$("#idMsg").css("color","red");
				$("#userId").val("");
				$("#userId").setfocus;
			} else {
				$("#idMsg").text("사용 가능한 아이디입니다.");
				$("#idMsg").css("color","blue");
			}
		},
		error : function() {
			alert("Error!");
		}
	});
});

//비밀번호 재확인(insertMemeber2.jsp)
$("#pwCheck").focusout(function(){
	var objs = document.getElementsByTagName("input");
	
	for (var i = 0; i < objs.length; i++) {
		if(objs[i].type == "password" && objs[i+1].type == "password"){//password이면 같은지 확인
			if(objs[i].value == objs[i+1].value){
				console.log(objs[i].value,i, objs[i+1].value);
				$("#pwMsg").text("");
			}else{
				$("#pwMsg").text("비밀번호가 틀립니다. 다시 입력해주세요.");
				$("#pwCheck").setfocus;
				$("#pwCheck").val("");
			}
		}
	}
});

//파일추가/삭제(participationForm.jsp)

var sel_files=[];
$(document).ready(function(){
	/*var count=0;
	
	$("#fileadd").click(function(){
		count+=1;
		if(count<0) count=0;
		var tbody = $('#filelist tbody');
		var td = $('<td />');
		var tr = $('<tr />');
		
		// 파일 input 생성
		var input = $('<input />', {
			type : 'file', 
			class :'form-control',
			name : 'file'+count,
			id:'file'+count,
			placeholder:'file',
			required:true
		});
		
		td.append(input);
		tr.append(td);
		tbody.append(tr);
		 $("#file"+count).on("change",handleImgsFilesSelect);
	 });
	 $("#fileminus").click(function(){
		$('input[name="file'+count+'"]').closest('tr').remove();
		 $("#file"+count).on("change",handleImgsFilesSelect);
		count-=1;
	}); */

	 $("#file").on("change",handleImgsFilesSelect);
})

//participationForm.jsp 이미지파일 미리보기
function handleImgsFilesSelect(e){
	var files=e.target.files;
	var filesArr=Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("확장자는 이미지 확장자만 가능합니다.");
			return;
		}
		
		sel_files.push(f);
		
		var reader=new FileReader();
		reader.onload=function(e){
			var img_html=$('<div class="col-sm-2 pl-1 pr-0"/>');
			var img_tag="<img class=\"w-100 h-100\" src=\""+e.target.result+"\" />"+
						"<span onclick=\"delImg(this)\""+
						" class=\"w3-display-topright w3-button w3-transparent w3-text-white\">&times;</span>";
			
			$(".imgs_wrap").append(img_html.append(img_tag));
		}
		reader.readAsDataURL(f);
	});
}

//이미지 미리보기 삭제
function delImg(close){
	$(close).parent().attr("style","display:none");
	$(close).parent().html("");
}
/*
//쪽지함(mypage.jsp-->messageForm.jsp)
function msg(form,id){//받은 쪽지함/보낸 쪽지함을 클릭하면
	$('input[name="type"]').attr("value",id);
	form.submit();

	console.log(id);
	if(id=="to"){
		$("#to").addClass("active");
		$("#to").attr("aria-selected","true");

		$("#from").removeClass("active");
		$("#from").attr("aria-selected","false");
	}else{
		$("#to").removeClass("active");
		$("#to").attr("aria-selected","false");
		
		$("#from").addClass("active");
		$("#from").attr("aria-selected","true");
	}
	return false;
}*/
/*
//쪽지함(mypage.jsp-->messageForm.jsp)
function msg(form,id){//받은 쪽지함/보낸 쪽지함을 클릭하면

	var form_data = {
			tab: "messages",
			type: id
	};
	$.ajax({
		type : "GET",
		url : "a.jsp",
		data : form_data,
		success : function(response) {
			if(id=="to"){
				$("#to").addClass("active");
				$("#to").attr("aria-selected","true");

				$("#from").removeClass("active");
				$("#from").attr("aria-selected","false");
			}else{
				$("#to").removeClass("active");
				$("#to").attr("aria-selected","false");
				
				$("#from").addClass("active");
				$("#from").attr("aria-selected","true");
			}
			console.log(form_data.type+" / "+form_data.tab+" / "+response);
			
		},
		error : function() {
			alert("Error!");
		}
	});
	return false;
}*/

//쪽지 보낼때 자기 아이디 사용불가(messageForm.jsp-->msgSendForm.jsp)
function to_idCheck(id,to_id){
	if (id==to_id.value) {
		to_id.value="";
		alert("자신에게 쪽지를 보낼 수 없습니다.");
	}
}
//쪽지리스트에서 선택한 것만 지움(messageForm.jsp)
function alarmDel(){
	var seqs = Array();
	var objs = document.getElementsByTagName("input");
	for (var i = 0; i < objs.length; i++) {
		if(objs[i].type == "checkbox"){// 체크박스이면 배열에 저장
			if(objs[i].checked){seqs.push(objs[i].value);}
		}
	}
	if(seqs.length == 0){// 선택된게 없으면
		alert("삭제할 알림을 선택해 주십시오");
		return;
	}
	
	if(confirm("선택하신 알림을 삭제하시겠습니까?")){
		location.href = "alarmDelPro.jsp?list="+ seqs.join(",");
	}
}
//쪽지리스트에서 선택한 것만 지움(messageForm.jsp)
function msgDel(){
	var seqs = Array();
	var objs = document.getElementsByTagName("input");
	for (var i = 0; i < objs.length; i++) {
		if(objs[i].type == "checkbox"){// 체크박스이면 배열에 저장
			if(objs[i].checked){seqs.push(objs[i].value);}
		}
	}
	if(seqs.length == 0){// 선택된게 없으면
		alert("삭제할 쪽지을 선택해 주십시오");
		return;
	}
	
	if(confirm("선택하신 쪽지를 삭제하시겠습니까?")){
		location.href = "msgDelPro.jsp?list="+ seqs.join(",");
	}
}

//조회수 올리기
function viewCount(ppcode,pfcode){
	var form_data = {
			ppcode : ppcode,
			pfcode : pfcode
	};
	$.ajax({
		type : "POST",
		url : "/capstone/signD/designer/viewcountUpdatePro.jsp",
		data : form_data,
		success : function(response) {
			console.log(form_data.ppcode+" / "+form_data.pfcode+" / "+response);
		},
		error : function() {
			alert("Error!");
		}
	});
}

//의뢰자, 디자이너 선택(isnertMember2)
$(document).ready(function () {
 $('#selCus').click(function () {
   var sel = $('input[name="type"]:checked').val();
   $("#selecMem").text("의뢰자 "); 
   $("#cust").css("background","grey");
   $("#desi").css("background","white");
   $("#mmm").css("color","black"); 
   $("#nnn").css("color","white"); 
 });
 $('#selDes').click(function () {
     var radioVal = $('input[name="type"]:checked').val();
     $("#selecMem").text("디자이너 ");
     $("#desi").css("background","grey");
     $("#cust").css("background","white");
     $("#nnn").css("color","black"); 
     $("#mmm").css("color","white"); 
 });
});

//색상 자유
function colorChk(){
	if(document.getElementById("colorchk").checked==true){
		$("#colorhexDIV").attr("name","");
		$("#colorchk").attr("name","color");
	}else{
		$("#colorhexDIV").attr("name","color");
		$("#colorchk").attr("name","");
	}
}

/*RGB색상표(designRequest2.jsp)*/
var colorhex = "#FF0000";
var color = "#FF0000";
var colorObj = w3color(color);
function mouseOverColor(hex) {
    document.getElementById("divpreview").style.visibility = "visible";
    document.getElementById("divpreview").style.backgroundColor = hex;
    document.body.style.cursor = "pointer";
}
function mouseOutMap() {
    if (hh == 0) {
        document.getElementById("divpreview").style.visibility = "hidden";
    } else {
      hh = 0;
    }
    document.getElementById("divpreview").style.backgroundColor = colorObj.toHexString();
    document.body.style.cursor = "";
}
var hh = 0;
function clickColor(hex, seltop, selleft, html5) {
    var c, cObj, colormap, areas, i, areacolor, cc;
    if (html5 && html5 == 5)  {
        c = document.getElementById("html5colorpicker").value;
    } else {
        if (hex == 0)  {
            c = document.getElementById("entercolor").value;
        } else {
            c = hex;
        }
    }
    cObj = w3color(c);
    colorhex = cObj.toHexString();
    if (cObj.valid) {
        clearWrongInput();
    } else {
        wrongInput();
        return;
    }
    r = cObj.red;
    g = cObj.green;
    b = cObj.blue;
    document.getElementById("colornamDIV").innerHTML = (cObj.toName() || "");
    $("#colorhexDIV").attr("value",cObj.toHexString());
    document.getElementById("colorrgbDIV").innerHTML = cObj.toRgbString();
    document.getElementById("colorhslDIV").innerHTML = cObj.toHslString();    
    if ((!seltop || seltop == -1) && (!selleft || selleft == -1)) {
        colormap = document.getElementById("colormap");
        areas = colormap.getElementsByTagName("AREA");
        for (i = 0; i < areas.length; i++) {
            areacolor = areas[i].getAttribute("onmouseover").replace('mouseOverColor("', '');
            areacolor = areacolor.replace('")', '');
            if (areacolor.toLowerCase() == colorhex) {
                cc = areas[i].getAttribute("onclick").replace(')', '').split(",");
                seltop = Number(cc[1]);
                selleft = Number(cc[2]);
            }
        }
    }
    if ((seltop+200)>-1 && selleft>-1) {
        document.getElementById("selectedhexagon").style.top=seltop + "px";
        document.getElementById("selectedhexagon").style.left=selleft + "px";
        document.getElementById("selectedhexagon").style.visibility="visible";
  } else {
        document.getElementById("divpreview").style.backgroundColor = cObj.toHexString();
        document.getElementById("selectedhexagon").style.visibility = "hidden";
  }
    document.getElementById("html5colorpicker").value = cObj.toHexString();  
  //changeColor();
}
function wrongInput() {
    document.getElementById("entercolorDIV").className = "input-group has-error w3-col s11 py-3";
    document.getElementById("wronginputDIV").style.display = "block";
}
function clearWrongInput() {
    document.getElementById("entercolorDIV").className = "input-group w3-col s11 py-3";
    document.getElementById("wronginputDIV").style.display = "none";
}
function changeRed(value) {
    document.getElementById('valRed').innerHTML = value;
    changeAll();
}
function changeGreen(value) {
    document.getElementById('valGreen').innerHTML = value;
    changeAll();
}
function changeBlue(value) {
    document.getElementById('valBlue').innerHTML = value;
    changeAll();
}
function changeAll() {
    var r = document.getElementById('valRed').innerHTML;
    var g = document.getElementById('valGreen').innerHTML;
    var b = document.getElementById('valBlue').innerHTML;
    document.getElementById('change').style.backgroundColor = "rgb(" + r + "," + g + "," + b + ")";
    document.getElementById('changetxt').innerHTML = "rgb(" + r + ", " + g + ", " + b + ")";
    document.getElementById('changetxthex').innerHTML = w3color("rgb(" + r + "," + g + "," + b + ")").toHexString();
}
window.onload = function() {
    var x = document.createElement("input");
    x.setAttribute("type", "color");
    if (x.type == "text") {
        document.getElementById("html5DIV").style.visibility = "hidden";
    }
}
function submitOnEnter(e) {
    keyboardKey = e.which || e.keyCode;
    if (keyboardKey == 13) {
        clickColor(0,-1,-1);
    }
}

//designRequest2.jsp 기타 선택시
function otherChange(input_name,input_id){
	if(input_name=="job_kind"){
		if(document.getElementById("ot").checked){
			$("."+input_name+"_other").attr("style","visibility:visible");
			$("."+input_name+"_other").val("");
			console.log(input_id);
		}else{
			$("."+input_name+"_other").attr("style","visibility:hidden");
			$("."+input_name+"_other").val($("#"+input_id).val());
			console.log(input_id);
		}
	}else if(input_name=="plan" ){
		var objs = document.getElementsByName("plan-group");
		var plan="";
		for (var i = 0; i < objs.length-1; i++) {
			if(objs[i].type == "checkbox" && objs[i].checked){//체크박스이면 상태를 바꿔라
				plan=plan+objs[i].value+",";
			}
		}
		if(document.getElementById("other").checked){
			$("."+input_name+"_other").attr("style","visibility:visible");
		}else{
			$("."+input_name+"_other").attr("style","visibility:hidden");
		}
		$("input[name=plans]").attr("value" , plan);
		console.log(plan);
	}
}

//designRequest3.jsp 상금 입력시
function costChange(cost,default_cost){
	console.log($("#cost").val());
	if($("#cost").val() < cost){//상금최소금액보다 작으면
		alert(default_cost+"만원보다 큰값을 입력해주세요.");
		$("#cost").val("");
	}else if(isNaN($("#cost").val())){//숫자가 아니면
		alert("숫자만 입력 가능합니다.");
		$("#cost").val("");
	}
}


//prize_moneyDeliveryForm.jsp 선택지급
function selecteddelivery(btn,i,ppcode,prize_money){
		if(confirm("지급하시겠습니까?")){
			if(ppcode==0){
				alert("의뢰자가 채택 후 지급할 수 있습니다!");
			}else{
				var form_data = {
						ppcode : ppcode,
						prize_money : prize_money
				};
				$.ajax({
					type : "POST",
					url : "/capstone/signD/manager/prize_moneyDeliveryPro.jsp",
					data : form_data,
					success : function(response) {
						console.log(form_data.ppcode+" / "+form_data.prize_money+" / "+response);
						if(response==1){
							$(btn).addClass("active");
							$(btn).html("지급취소");
							$(".deliveryStatus"+i).html("지급완료");
						}else{
							$(btn).removeClass("active");
							$(btn).html("지급");
							$(".deliveryStatus"+i).html("지급전");
						}
					},
					error : function() {
						alert("Error!");
					}
				});
			}
		}
}

//myPage.jsp-->OTORequestForm.jsp 수락/거절
function accept(rqcode,accept){
	var form_data={
			rqcode:rqcode,
			accept:accept
	}
	if(accept==1 && confirm("수락하시겠습니까?")){
		$.ajax({
			method:"POST",
			url:"/capstone/signD/mypage/OTOAcceptPro.jsp",
			data:form_data,
			success:function(response){
				if(response==1){
					alert("수락하였습니다.");
				}else if(response==2){
					alert("거절하였습니다.");
				}else{
					alert(response);
				}
				document.location.href = "/capstone/signD/mypage/myPage.jsp?tab=OTOrequest";
			},
			error : function() {}
		});
	}else if(accept==2 && confirm("거절하시겠습니까?")){
		$.ajax({
			method:"POST",
			url:"/capstone/signD/mypage/OTOAcceptPro.jsp",
			data:form_data,
			success:function(response){
				if(response==1){
					alert("수락하였습니다.");
				}else if(response==2){
					alert("거절하였습니다.");
				}else{
					alert(response);
				}
				document.location.href = "/capstone/signD/mypage/myPage.jsp?tab=OTOrequest";
			},
			error : function() {}
		});
	}
}

function always(checked){
	form_data={
		op_onetoone:checked
	}
	$.ajax({
		method:"post",
		data:form_data,
		url:"/capstone/signD/designer/op_onetooneUpdatePro.jsp",
		success:function(response){
			if(response==1){
				if(checked==1){//항상 수락으로 바꾸기
					$(".always").html('<button class="btn btnOr" onclick="always(0)">1:1의뢰 항상 수락');
				}else{//항상 거절로 바꾸기
					$(".always").html('<button class="btn" onclick="always(1)">1:1의뢰 항상 거절');
				}
			}
		}
	});
}