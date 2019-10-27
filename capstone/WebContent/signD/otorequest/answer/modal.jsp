<%@page import="signD.member.OneToOneRequestDataBean"%>
<%@page import="signD.member.OneToOneRequestDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.OneToOneAnswerDataBean"%>
<%@page import="signD.member.OneToOneAnswerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	if (id == null) {
		id = "";
	}
	int rqcode = Integer.parseInt(request.getParameter("requestcode"));

	LogonDBBean logon = LogonDBBean.getInstance();

	OneToOneRequestDBBean rqdb = OneToOneRequestDBBean.getInstance();
	OneToOneRequestDataBean rq = rqdb.getOneToOneRequest(rqcode);
	
	OneToOneAnswerDBBean answerdb = OneToOneAnswerDBBean.getInstance();
	OneToOneAnswerDataBean answer = answerdb.getOneToOneAnswer(rqcode,id);

	String Dday = rqdb.getDday(rqcode);
	String filenames[] = answer.getFile().split(",");
%>
<style>
.middle>* {
	vertical-align: middle;
}
</style>

<div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width:1000px">
	<div class="modal-content">
		<div class="modal-body p-0">
			<div class="media row">
				<div id="carousel<%=answer.getAnswercode() %>" class="carousel slide pr-0 carousel-fade col-md-8 align-self-center" data-ride="carousel">
					<ol class="carousel-indicators">
				<%
					if(filenames.length>1){
						for (int j = 0; j < filenames.length ; j++) {
				%>
						<li data-target="#carousel<%=answer.getAnswercode()%>" data-slide-to="<%=j %>" <%if(j==0){%>class="active"<%} %>></li>
				<%
						}
					}
				%>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[filenames.length-1]%>">
						</div>
				<%
					for (int j = filenames.length - 1; j > 0; j--) {
				%>
						<div class="carousel-item">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[j - 1]%>">
						</div>
				<%
					}
				%>
					</div>
				<%
					if (filenames.length > 1) {
				%>
					<a class="carousel-control-prev" href="#carousel<%=answer.getAnswercode()%>" role="button" data-slide="prev"> 
						<i class="fas fa-angle-left"></i>
						<span class="sr-only">Previous</span>
					</a> 
					<a class="carousel-control-next" href="#carousel<%=answer.getAnswercode()%>" role="button" data-slide="next"> 
						<i class="fas fa-angle-right"></i>
						<span class="sr-only">Next</span>
					</a>
				<%
					}
				%>
				</div>
				<div class="col-md-4 pl-3" id="content<%=answer.getAnswercode()%>" style="background-color: #e9ecef;">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="py-4 m-0"><a href="/capstone/signD/contest/detail.jsp?requestcode=<%=rqcode%>"></a></h4>
					<div class="row pl-4 pb-2">
						<img src="../../imageFile/profileImg/<%=logon.getMember(answer.getId()).getProfileimg()%>" 
							class="rounded-circle" style="width: 50px; height: 50px">
						<div class="col-md-8">
							<a href="../designer/profile.jsp?designerId=<%=answer.getId() %>"><%=answer.getId() %></a><br>
							<div class="py-1"><strong>우승횟수 <%=logon.getMember(answer.getId()).getChoosecount() %>회</strong></div>
						</div>
					</div>
					<div class="mr-3 mt-2 mb-5" style="height: 430px; border-top:1px solid #BDBDBD;">
						<textarea class="form-control p-2 p-0" cols="20" rows="15" disabled="disabled"
						 style="border:none; background-color: #e9ecef;"><%=answer.getContents()%></textarea>
					</div>
					<div class="pr-4 p-3">
					<%
						if (id.equals(answer.getId()) && !Dday.equals("0")) {//마감 전 수정, 삭제 가능
					%>
						<button onclick="location.href='/capstone/signD/otorequest/answer/updateForm.jsp?answercode=<%=answer.getAnswercode()%>&rqcode=<%=rqcode%>'"
							class="btn btn btnOr offset-1 col-md-5">수정하기</button> 
						<button onclick="deleteCheck('/capstone/signD/otorequest/answer/delPro.jsp?answercode=<%=answer.getAnswercode()%>&rqcode=<%=rqcode%>')"
							class="btn col-md-5" style="background-color: darkgray; color: white;">삭제하기</button>
					<%
						}
					%></div>
				</div>
			</div>
		</div>
	</div>
</div>