<%@page import="signD.member.AlarmDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String url = request.getParameter("url");
	//int alarmcode = Integer.parseInt(request.getParameter("alarmcode"));

	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
	
	String list = request.getParameter("list");
	String[] lists = list.split(",");
	int check = 0;
	
	for (int i = 0; i < lists.length; i++) {
		check = alarmdb.deleteAlarm(Integer.parseInt(lists[i]));
	}
	if (check == 1) {
%>
<script>
	alert("알림을 삭제하였습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=/capstone/signD/mypage/myPage.jsp?tab=alarm">
<%
	} else {
%>
<script>
	alert("알림을 삭제하지 못하였습니다. 다시 시도해주세요.");
	history.go(-1);
</script>
<%
	}
%>