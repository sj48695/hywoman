<%@page import="signD.member.AlarmDBBean"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.Month"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
%>
<jsp:useBean id="rq" class="signD.contest.RequestDataBean">
	<jsp:setProperty property="*" name="rq" />
</jsp:useBean>
<%
	long endDay = 0;
	if (rq.getOp_week() == 0) {
		endDay = System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000);//1주 후 
	} else {
		endDay = System.currentTimeMillis() + (14 * 60 * 60 * 24 * 1000);//2주 후 (일주일 연장)
	}

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);

	RequestDBBean rqdb = RequestDBBean.getInstance();
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();

	rq.setId(id);
	rq.setReg_date(new Timestamp(System.currentTimeMillis()));
	rq.setEnd_date(new Timestamp(endDay));
	int check = rqdb.insertRequest(rq);
%>
<%-- <jsp:useBean id="alarm" class="signD.member.AlarmDataBean"/>
	<%
	alarm.setTo_id(id); 
	alarm.setFrom_id(id);
	alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
	alarm.setUrl("/capstone/signD/contest/detail.jsp?requestcode="+rq.getRequestcode());
	alarm.setContents("콘테스트를 개최하였습니다.");
	alarm.setType("의뢰글 등록");
	alarmdb.insertAlarm(alarm);
%> --%>
<%
	if (check == 1) {
%>
<script>
	alert("콘테스트가 개최되었습니다.");
</script>
<%
	} else {
%>
<script>
	alert("다시한번 시도해주세요.");
</script>
<%
	}
%>
<meta http-equiv="Refresh" content="0;url=contestIngList.jsp">