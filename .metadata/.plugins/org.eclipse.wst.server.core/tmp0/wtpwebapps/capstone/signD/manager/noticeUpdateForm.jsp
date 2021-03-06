<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.manager.ManagerDBBean"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@page import="signD.help.NoticeDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	String title = "공지사항 등록 | DO";
	int noticecode=Integer.parseInt(request.getParameter("noticecode"));

	NoticeDBBean noticedb=NoticeDBBean.getInstance();
	NoticeDataBean notice=noticedb.getNotice(noticecode);
	if(managerId!=null){
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="bgi4">
	<section class="jumbotron text-center img-cover">
		<div class="container py-4 jumbotitle">
			<h1 class="jumbotron-heading jumbotitle"><strong>고객센터</strong></h1>
			<p class="lead"><strong>공지사항을 확인하세요!</strong></p>
		</div>
	</section>
</div>
<div class="container">
	<div class="w3-border w3-light-white w3-row">
      <a href="notice.jsp" class="w3-button w3-col s3 w3-brown"><strong>공지사항</strong></a> 
      <a href="FAQ.jsp" class="w3-button w3-col s3">FAQ</a> 
      <a href="Q&A.jsp" class="w3-button w3-col s3">Q&A</a> 
      <a href="rule.jsp" class="w3-button w3-col s3">이용방법</a>
   </div>
	<div class="py-4 row justify-content-center">
		<div class="card col-sm-10">
   		 	<h4 class="card-title text-center py-4">공지사항 등록</h4>
			<form method="post" action="noticeUpdatePro.jsp" class="card-body">
				<input type="hidden" name="noticecode" value="<%=noticecode%>">
				<div class="form-group row">
					<label class="col-form-label col-sm-1">제목</label>
					<div class="col-sm-6">
						<input class="form-control" type="text" name="title" placeholder="Title" value="<%=notice.getTitle()%>">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-form-label col-sm-1">내용</label>
					<div class="col-sm-10">
						<textarea class="form-control" name="contents" id="summernote" placeholder="공지사항을 적어주세요" rows="15"><%=notice.getContents() %></textarea>
					</div>
				</div>
				<div class="form-group">
					<p class="text-center paddingt">
						<button type="submit" class="btn btnOr btn-lg col-sm-3">등록</button>
						<button type="reset" class="btn btn-lg col-sm-3 offset-sm-1">취소</button>
					</p>
				</div>
			</form>
		</div>
	</div>
</div>

<jsp:include page="../module/bottom.jsp" flush="false" />

	<!-- include libraries(jQuery, bootstrap) -->
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
	<script
		src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
	<!-- include summernote css/js-->
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	<script>
		$(document).ready(function() {
			$('#summernote').summernote({ // summernote를 사용하기 위한 선언
				height : 400,
				callbacks : { // 콜백을 사용
					// 이미지를 업로드할 경우 이벤트를 발생
					onImageUpload : function(files, editor, welEditable) {
						sendFile(files[0], this);
					}
				}
			});
		});
	
		/* summernote에서 이미지 업로드시 실행할 함수 */
		function sendFile(file, editor) {
			// 파일 전송을 위한 폼생성
			data = new FormData();
			data.append("uploadFile", file);
			$.ajax({ // ajax를 통해 파일 업로드 처리
				data : data,
				type : "POST",
				url : "noticeImgUpload.jsp",
				cache : false,
				contentType : false,
				processData : false,
				success : function(data) { // 처리가 성공할 경우
					// 에디터에 이미지 출력
					$(editor).summernote('editor.insertImage', data.url);
				}
			});
		}
	</script>
	<!-- bootstrap -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="/capstone/assets/bootstrap-4.1.3/js/bootstrap.min.js"></script>
	<!-- jquery -->
	<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	  	<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script> -->
	
	<!-- icon -->
	<script
		src="/capstone/assets/fontawesome-free-5.0.9/svg-with-js/js/fontawesome-all.js"></script>
	
	<!-- script -->
	<script src="/capstone/signD/etc/script.js" type="text/javascript"></script>
</body>
</html>
<%
	} else {
%>
<script type="text/javascript">
<!--
	alert("관리자만 접근할 수 있습니다.");
	location.href="/capstone/signD/main.jsp";
//-->
</script>
		<%
	}
%>