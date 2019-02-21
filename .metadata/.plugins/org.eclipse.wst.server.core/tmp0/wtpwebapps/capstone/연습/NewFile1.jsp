<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/capstone/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css"> 
	
	<!--  style  -->
	<link rel="stylesheet" href="/capstone/signD/etc/style.css" type="text/css">
	<link rel="stylesheet" href="/capstone/signD/etc/main.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/style1.css" /> 
	<link rel="stylesheet" href="/capstone/signD/etc/mypage.css" type="text/css">
	<link rel="stylesheet" href="/capstone/signD/etc/contest.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/member.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/designer.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/help.css" />
		
	<!-- include libraries(jQuery, bootstrap) -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	
	<script src="//code.jquery.com/jquery.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<title></title>
</head>
<body>
<form id="articleForm" role="form" action="/article" method="post">
  <br style="clear: both">
  <h3 style="margin-bottom: 25px;">Article Form</h3>
  <div class="form-group">
    <input type="text" class="form-control" id="subject" name="subject" placeholder="subject" required>
  </div>
  <div class="form-group">
    <textarea class="form-control" id="summernote" name="content" placeholder="content" maxlength="140" rows="7"></textarea>
  </div>
  <button type="submit" id="submit" name="submit" class="btn btn-primary pull-right">Submit Form</button>
</form>




<!-- include libraries(jQuery, bootstrap) -->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	<!-- include summernote css/js-->
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		$('#summernote').summernote({
			  height: 430,                 
	         minHeight: null,            
	         maxHeight: null,             
	         focus: false,                  
	         lang: 'ko-KR', 
	         placeholder: '내용을 적어주세요.',
	         hint: {
	             match: /:([\-+\w]+)$/,
	             search: function (keyword, callback) {
	                 callback($.grep(emojis, function (item) {
	                     return item.indexOf(keyword) === 0;
	                 }));
	             },
	             template: function (item) {
	                 var content = emojiUrls[item];
	                 return '<img src="' + content + '" width="20" /> :' + item + ':';
	             },
	             content: function (item) {
	                 var url = emojiUrls[item];
	                 if (url) {
	                     return $('<img />').attr('src', url).css('width', 20)[0];
	                 }
	                 return '';
	             }
	         }
		});
	});
</script>
	<!-- bootstrap -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" ></script>
	<script src="/capstone/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
	<!-- jquery -->
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  	<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script> -->
	
	<!-- icon -->
	<script src="/capstone/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
	
	<!-- script -->
	<script src="/capstone/signD/etc/script.js" type="text/javascript"></script>
</body>
</html>