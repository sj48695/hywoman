<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="signD.member.LogonDBBean"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String passwd = request.getParameter("passwd");

	LogonDBBean logon = LogonDBBean.getInstance();
	int check = logon.userCheck(id, passwd);
	
	if (check == 1) {
		
		if(id.equals("manager")){//매니저로그인
			session.setAttribute("managerId", id);
			response.sendRedirect(request.getHeader("referer")); 
		}else{//의뢰인/디자이너 로그인
			session.setAttribute("id", id);
			response.sendRedirect(request.getHeader("referer")); 
		}
	} else if (check == 0) {
%>
<script>
	alert("비밀번호가 맞지 않습니다.");
	history.go(-1);
</script>
<%
	} else {
%>
<script>
	alert("존재하지 않는 아이디입니다.");
	history.go(-1);
</script>
<%
	}
%>