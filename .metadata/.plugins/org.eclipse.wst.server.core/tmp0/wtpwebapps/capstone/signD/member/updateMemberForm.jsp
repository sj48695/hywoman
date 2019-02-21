<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);
	
	String tab = request.getParameter("tab");
	if (tab == null) {
		tab = "settings";
	}
%>

<!-- <style>
#mpb {
	border-bottom: 1px solid #e8e9ed;
	padding-bottom: 10px;
}
</style> -->
<h3 class="m-3 pb-3 text-center"><strong>회원정보수정</strong></h3>
<div class="container col-sm-6">
	<form method="post" name="updatememberform" action="/capstone/signD/member/updateMemberPro.jsp">
		<div class="form-group row">
			<label class="col-sm-2 col-form-label"><strong>비밀번호</strong></label>
			<div class="col-sm-10">
				<input type="password" class="form-control" name="passwd" placeholder="Password" required="required">
			</div>
		</div>
		<hr>
		<div class="form-group row">
			<label class="col-sm-2 col-form-label"><strong>이름</strong></label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="name" placeholder="Name" required="required" value="<%=member.getName()%>">
			</div>
		</div>
		<hr>
		<div class="form-group row">
			<label class="col-sm-2 col-form-label"><strong>Email</strong></label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="email" placeholder="Email" required="required" value="<%=member.getEmail()%>">
			</div>
		</div>
		<hr>
		<div class="form-group row">
			<label class="col-sm-2 col-form-label"><strong>전화번호</strong></label>
			<div class="col-sm-10">
				<input type="text" class="form-control" name="tel" placeholder="Tel" required="required" value="<%=member.getTel()%>">
			</div>
		</div>
		<hr>
		<div class="form-group row">
			<label class="col-sm-2 col-form-label"><strong>한줄소개</strong></label>
			<div class="col-sm-10">
				<textarea class="form-control" name="introduction" rows="5"
					 placeholder="introduction"><%=member.getIntroduction()%></textarea>
			</div>
		</div>
		<hr>
		<div class="form-group row justify-content-center">
			<div class="col-sm-12 text-center">
				<button type="submit" class="btn btnOr col-sm-3">정보수정</button>
				<button type="reset" class="btn col-sm-3 offset-sm-1" style="background: darkgray;color:white">원래대로</button>
				<button type="button" class="btn col-sm-3 offset-sm-1" style="background: darkgray;color:white" id="delMember">회원탈퇴</button>
			</div>
		</div>
	</form>
</div>
<script>
$("#delMember").click(function(){
	if(confirm("정말 탈퇴하시겠습니까?")){
		/* var passwd=$("#passwd").modal("show");
		console.log(passwd); */
		document.location.href="/capstone/signD/member/deleteMemberPro.jsp";
	}
});
</script>