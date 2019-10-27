<%@page import="signD.member.AlarmDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String url = request.getParameter("url");
	int alarmcode = Integer.parseInt(request.getParameter("alarmcode"));

	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
	int check = alarmdb.updateRead_check(alarmcode);

	if (check == 1) {
%>
<meta http-equiv="Refresh" content="0;url=<%=url%>">
<%
	} else {
%>
<script>
	history.go(-1);
</script>
<%
	}
%>