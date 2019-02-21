<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="signD.member.LogonDBBean"%>

<%
	request.setCharacterEncoding("utf-8");

	String id=(String)session.getAttribute("id");
	LogonDBBean logon = LogonDBBean.getInstance();
	//int check=logon.deleteMember(id, passwd);
	int check=logon.deleteMember(id);
	
	if(check==1){
		%>
		<script type="text/javascript">
			alert("탈퇴하였습니다.");
			location.href="/capstone/signD/member/logout.jsp";
		</script>
		<%
	}else{
		%>
		<script>
			alert("탈퇴에 실패하였습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
		<%
}%>