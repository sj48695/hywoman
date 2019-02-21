<%@page import="signD.member.AlarmDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.MessageDataBean"%>
<%@page import="signD.member.MessageDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");

	LogonDBBean logon = LogonDBBean.getInstance();
	MessageDBBean msgdb=MessageDBBean.getInstance();
	AlarmDBBean alarmdb=AlarmDBBean.getInstance();
	
	LogonDataBean member = logon.getMember(id);
	//AlarmDataBean alarm=null;
	%>
	<jsp:useBean id="message" class="signD.member.MessageDataBean">
		<jsp:setProperty property="*" name="message"/>
	</jsp:useBean>
	<%
	message.setContents(request.getParameter("contents").replaceAll("\r\n", "<br>"));
	message.setFrom_id(id);
	message.setReg_date(new Timestamp(System.currentTimeMillis()));
	msgdb.insertMessage(message);
	
	
	%>
	<jsp:useBean id="alarm" class="signD.member.AlarmDataBean"/>
	<%
	alarm.setTo_id(request.getParameter("to_id")); 
	alarm.setFrom_id(id);
	alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
	alarm.setUrl("/capstone/signD/mypage/myPage.jsp?tab=messages");
	alarm.setContents(id+"님으로부터 쪽지가 도착했습니다.");
	alarm.setType("쪽지");
	alarmdb.insertAlarm(alarm);
	
%>

<meta http-equiv="Refresh" content="0;url=myPage.jsp">