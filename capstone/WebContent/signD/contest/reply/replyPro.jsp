<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.member.ReplyDBBean"%>
<%@page import="signD.member.ReplyDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>
<%@page import="com.mysql.fabric.Response"%>
<%@page import="sun.security.provider.certpath.ResponderId"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	ReplyDBBean replydb = ReplyDBBean.getInstance();

	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
%>

<jsp:useBean id="reply" scope="page" class="signD.member.ReplyDataBean">
	<jsp:setProperty name="reply" property="*" />
</jsp:useBean>

<%
	reply.setReg_date(new Timestamp(System.currentTimeMillis()));
	reply.setDivision("의뢰글");
	replydb.insertReply(reply);

	RequestDBBean rqdb = RequestDBBean.getInstance();
	RequestDataBean rq = rqdb.getRequest(reply.getRequestcode());
%>
<jsp:useBean id="alarm" class="signD.member.AlarmDataBean" />
<%
	if (!id.equals(rq.getId())) {//자기댓글은 알람 안오도록
		alarm.setTo_id(rq.getId());
		alarm.setFrom_id(id);
		alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
		alarm.setUrl("/capstone/signD/contest/detail.jsp?requestcode=" + reply.getRequestcode());
		alarm.setContents(id + "님이 개최한 콘테스트에 댓글을 달았습니다.");
		alarm.setType("댓글 등록");
		alarmdb.insertAlarm(alarm);
	}
%>

<meta http-equiv="Refresh" content="0;url=detail.jsp?requestcode=<%=reply.getRequestcode()%>">