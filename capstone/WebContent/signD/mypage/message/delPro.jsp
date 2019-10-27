<%@page import="signD.member.MessageDataBean"%>
<%@page import="signD.member.MessageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String type = request.getParameter("type");
	String list = request.getParameter("list");
	String[] lists = list.split(",");
	int check = 0;
	MessageDBBean msgdb = MessageDBBean.getInstance();

	for (int i = 0; i < lists.length; i++) {
		check = msgdb.deleteMessage(Integer.parseInt(lists[i]));
	}
	if (check == 1) {
%>
<script>
	alert("삭제되었습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=myPage.jsp?tab=messages">
<%
	} else {
%>
<script>
	alert("삭제되지 않았습니다. 다시 시도해 주십시오.");
	history.go(-1);
</script>
<%
	}
%>