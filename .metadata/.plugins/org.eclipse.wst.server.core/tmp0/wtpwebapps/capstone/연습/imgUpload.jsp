<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.imgs_wrap {
	width: 600px;
	margin-top: 50px;
}

.imgs_wrap img {
	max-width: 200px
}
</style>
<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
  <script type="text/javascript">
var sel_files=[];
$(document).ready(function(){
	$("#input_imgs").on("change",handleImgsFilesSelect);
});

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
			var img_html="<img src=\""+e.target.result+"\" />";
			$(".imgs_wrap").append(img_html);
		}
		reader.readAsDataURL(f);
	});
}

</script>
</head>
<body>
	<div>
		<h2>
			<b>다중 이미지 미리보기</b>
		</h2>
		<p class="title">다중 이미지 업로드</p>
		<input type="file" id="input_imgs" multiple>

	</div>
	<div>
		<div class="imgs_wrap">
		</div>

	</div>

</body>
</html>