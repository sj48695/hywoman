<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page import="signD.member.LogonDataBean"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="member" class="signD.member.LogonDataBean">
	<jsp:setProperty name="member" property="*" />
</jsp:useBean>


<%
	member.setReg_date(new Timestamp(System.currentTimeMillis()));
	member.setProfileimg("기본이미지.png");
	LogonDBBean logon = LogonDBBean.getInstance();

	String id = member.getId();
	String name = member.getName();
	
	int check=logon.insertMember(member);
	
	if(check==1){
		
		%>
		
<script type="text/javascript">
	alert("<%=name%>(<%=id%>)님 회원가입을 축하합니다. 로그인을 해주세요");
	location.href="/capstone/signD/main.jsp";
</script>
		<%
	}else{
		%>
		
<script type="text/javascript">
	alert("회원가입에 실패하셨습니다.");
	history.go(-1);
</script>
		<%
	}

%>