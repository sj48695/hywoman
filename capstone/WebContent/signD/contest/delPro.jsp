<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	int ppcode = Integer.parseInt(request.getParameter("ppcode"));

	RequestDBBean rqdb = RequestDBBean.getInstance();
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	int check = rqdb.deleteRequest(rqcode);
	if (check == 1) {
%>
<script>
	alert("삭제되었습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=contestIngList.jsp">
<%
	} else {
%>
<script>
	alert("다시한번 시도해주세요.");
	history.go(-1);
</script>
<%
	}
%>