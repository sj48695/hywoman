<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="signD.member.OneToOneRequestDataBean"%>
<%@ page import="signD.member.OneToOneRequestDBBean"%>
<%@ page import="signD.member.OneToOneAnswerDataBean"%>
<%@ page import="signD.member.OneToOneAnswerDBBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
	String title = "콘테스트 참여하기 | DO";
	String id = (String) session.getAttribute("id");
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	int answercode = Integer.parseInt(request.getParameter("answercode"));
	//String category = request.getParameter("category");

	OneToOneAnswerDBBean answerdb = OneToOneAnswerDBBean.getInstance();
	OneToOneAnswerDataBean answer = answerdb.getOneToOneAnswer(answercode);

	OneToOneRequestDBBean rqdb=OneToOneRequestDBBean.getInstance();
	OneToOneRequestDataBean rq = rqdb.getOneToOneRequest(rqcode);
	
	String filenames[]=answer.getFile().split(",");
	
	if (id != null) {
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
<div style="padding-bottom:50px;">
	<jsp:include page="../../module/menubar.jsp" flush="false" />
</div>
<section class="jumbotron text-center">
	<div class="container">
		<h1 class="jumbotron-heading">콘테스트 참여하기</h1>
		<p class="lead text-muted">콘테스트에 참여해보세요!</p>
		<div class="input-group input-group-lgs col-md-8 offset-md-2">
			<input type="text" class="form-control" aria-label="Sizing input" aria-describedby="inputGroup-sizing-lg">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" type="button" id="button-addon2">검색</button>
			</div>
		</div>
	</div>
</section>
<div class="py-4 row justify-content-center">
	<div class="card col-sm-8">
 		<h4 class="card-title text-center py-4">참여작 등록</h4>
		<form method="post" action="OTOAnswerUpdatePro.jsp?category=<%=rq.getCategory()%>&answercode=<%=answercode %>&rqcode=<%=rqcode %>" class="card-body" enctype="multipart/form-data">
			<div class="form-group row">
				<label class="col-form-label col-sm-2">내용</label>
				<div class="col-sm-9">
					<textarea class="form-control" name="contents" placeholder="참여작에 대한 내용을 적어주세요" rows="15" required><%=answer.getContents()%></textarea>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-form-label col-sm-2">파일첨부</label>
				<div class="col-sm-7" id="filelist">
					<table id="filelist">
						<tr>
							<td >
								<input type="file" class="form-control" name="file" id="file" placeholder="file" multiple>
							</td>
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
					<%
						for (int i = 0; i < filenames.length; i++) {
					%>
				<div class="col-sm-2 pl-1 pr-0">
					<img class="w-100 h-100" src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[i]%>">
					<span onclick="delImg(this)" class="w3-display-topright w3-button w3-transparent w3-text-white">&times;</span>
					<input type="hidden" name="file<%=i%>" value="<%=filenames[i]%>">
				</div>
				
					<%
						}
					%>
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


<jsp:include page="../../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
<%
	} else {
%>
<script type="text/javascript">
	alert("권한이 없습니다. 로그인해주세요.");
	history.go(-1);
</script>
<%
	}
%>