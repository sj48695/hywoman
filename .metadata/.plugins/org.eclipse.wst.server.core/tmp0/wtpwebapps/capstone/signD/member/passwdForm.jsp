<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);
%>
<div class="modal-dialog modal-dialog-centered" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h2 class="modal-title">비밀번호 확인</h2>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body text-center">
			<form method="post">
				<div class="form-group row">
					<input class="form-control col-sm-6 offset-2" type="password" name="passwd" id="chPw"> 
					<button role="button" class="btn btn-outline-dark col-sm-2" id="checkpw"
						data-dismiss="modal" aria-controls="settings"
						onclick="checkPw('<%=member.getPasswd()%>')">확인</button>
				</div>
			</form>
		</div>
	</div>
</div>
