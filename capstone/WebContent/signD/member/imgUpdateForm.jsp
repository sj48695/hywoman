<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
	String profileimg= request.getParameter("profileimg");
%>
<div class="modal-dialog modal-dialog-centered" role="document">
	<div class="modal-content">
		<div class="modal-header py-2" style="background-color: #FF9436">
			<div class="row col-12">
				<h4 class="col col-sm-5" style="color: white;">
					<strong>이미지 수정하기</strong>
				</h4>
			</div>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<div class="container text-center">
				<form method="post" action="/capstone/signD/member/imgUpdatePro.jsp"
					class="form-signin" enctype="multipart/form-data">
					<div class="form-group row justify-content-center imgs_wrap">
						<img src="../../imageFile/profileImg/<%=profileimg%>"
							style="width: 200px; height: 200px">
					</div>
					<div class="fotm-group row input-block" style="height: 2.75rem;">
						<div class="input-form col-sm-10 offset-1">
							<input type="file" class="form-control pl-1 pt-1"
								name="profileimg" id="profileimg">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-10 offset-1 pt-3 row justify-content-end">
							<button type="submit" class="btn btnOr col-3">확인</button>
							<button type="button" class="btn btn-outline-dark col-sm-3 ml-3"
								data-dismiss="modal" aria-label="Close"
								style="background: darkgray; color: white;;border:darkgrey;">취소</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
var sel_files=[];
$(document).ready(function(){
	 $("#profileimg").on("change",profileimg);
})

function profileimg(e){//프로필 이미지 미리보기
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
			var img_tag="<img src=\""+e.target.result+"\" style=\"width:200px; height:200px\" />";
			
			$(".imgs_wrap").html(img_tag);
		}
		reader.readAsDataURL(f);
	});
}
</script>