<%@page import="signD.member.AlarmDBBean"%>
<%@page import="java.time.DayOfWeek"%>
<%@page import="java.time.Month"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.OneToOneRequestDataBean"%>
<%@page import="signD.member.OneToOneRequestDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String designerId = request.getParameter("designerId");
	%>
<jsp:useBean id="rq" class="signD.member.OneToOneRequestDataBean">
	<jsp:setProperty property="*" name="rq" />
</jsp:useBean>
<% 
	//long endDay = System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000);//1주 후 
	

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);

	OneToOneRequestDBBean rqdb = OneToOneRequestDBBean.getInstance();
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();

	rq.setRequester_id(id);
	rq.setDesigner_id(designerId);
	rq.setReg_date(new Timestamp(System.currentTimeMillis()));
	//rq.setEnd_date(new Timestamp(endDay));
	int check=rqdb.insertOneToOneRequest(rq);
	
	if (check == 1) {
%>
<script>
	alert("<%=designerId%>님에게 의뢰하였습니다.");
</script>
	<jsp:useBean id="alarm" class="signD.member.AlarmDataBean"/>
		<%
		alarm.setTo_id(designerId); 
		alarm.setFrom_id(id);
		alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
		alarm.setUrl("/capstone/signD/mypage/myPage.jsp?tab=OTOrequest");
		alarm.setContents(id+"님에게 1:1의뢰가 도착하였습니다.");
		alarm.setType("1:1의뢰 도착");
		alarmdb.insertAlarm(alarm);
	} else {
%>
<script>
	alert("다시한번 시도해주세요.");
</script>
<%
	}
%>
<meta http-equiv="Refresh" content="0;url=/capstone/signD/designer/profile.jsp?designerId=<%=designerId%>">