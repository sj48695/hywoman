<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
	String title = "참여작 등록 | DO";
	String id=(String)session.getAttribute("id");
	String rqcode = request.getParameter("requestcode");
	String category=request.getParameter("category");
	
	if(id!=null){
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
	<jsp:include page="../module/menubar.jsp" flush="false" />

<div class="bgi4">
	<section class="jumbotron text-center img-cover">
	<div class="container py-4">
	<h1 class="jumbotron-heading jumbotitle">
		<b><!-- "콘테스트 어찌고 이름" --> 콘테스트 참여하기</b></h1>
		<p class="lead"><b>콘테스트에 참여해보세요!</b></p>
	</div>
</section>
</div>
<div class="row justify-content-center footerbottom">
	<div class="card col-sm-6" style="background-color:#f7f7f7;">
 		<h3 class="card-title text-center py-2 pt-4" style="color:#5D5D5D;"><b>참여작 상세 등록</b></h3>
		<form method="post" action="participationPro.jsp?category=<%=category %>&requestcode=<%=rqcode %>" class="card-body" enctype="multipart/form-data">		
			<input type="hidden" name="requestcode" value="<%=rqcode%>">
			<input type="hidden" name="category" value="<%=category%>">
			<div class="form-group row">
				<label class="col-sm-2 pl-5 lbr">제목</label>
				<div class="col-sm-9">
					<input class="form-control" type="text" name="title" placeholder="Title">
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 pl-5 lbr">내용</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="contents" placeholder="참여작에 대한 내용을 적어주세요" rows="15" required></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 pl-5 lbr">파일첨부</label>
				<div class="col-sm-9" id="filelist">
					<table id="filelist">
						<tr>
							<td><input type="file"
								class="form-control p-0 pl-1 col-12 pt-1" name="file" id="file"
								style="height: 2.75rem;" placeholder="file" multiple></td>
						</tr>
					</table>
				</div>
				<!-- <div class="col-sm-3">
					<button type="button" id="fileadd" class="btn btnOr w-25">+</button>
					<button type="button" id="fileminus" class="btn btnOr w-25">-</button>
				</div> -->
			</div>
			<div class="form-group row imgs_wrap">
				<label class="col-form-label col-sm-2"></label>
			</div>
			<div class="form-group col-9 offset-2 justify-content-end row justify-content-end p-0 mt-5">
				<button type="submit" class="btn btnOr btn-lg col-sm-2">등록</button>
				<button type="reset" class="btn btn-lg col-sm-2 ml-2">취소</button>
			</div>
		</form>
	</div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
<%
	} else {
%>
<script type="text/javascript">
<!--
	alert("권한이 없습니다. 로그인해주세요.");
	history.go(-1);
//-->
</script>
<%
	}
%>