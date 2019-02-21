<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page import="signD.member.LogonDataBean"%>

<%
	request.setCharacterEncoding("utf-8");

	String id=(String)session.getAttribute("id");
%>

<jsp:useBean id="member" class="signD.member.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>

<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	LogonDBBean logon = LogonDBBean.getInstance();
	int check=logon.updateMember(member,id);
	
	if(check==1){
%>
<script type="text/javascript">
	alert("<%=member.getName()%>(<%=id%>)님의 회원정보를 수정하였습니다.");
	location.href="/capstone/signD/mypage/myPage.jsp";
</script>
<%}else{
	%>
	<script>
	alert("회원정보 수정에 실패하였습니다. 다시 시도해주세요.");
	history.go(-1);
	</script>
	<%
}%>