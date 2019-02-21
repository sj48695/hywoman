<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@ page import="signD.member.ReplyDBBean"%>
<%@ page import="signD.member.ReplyDataBean"%>
<%@ page import="com.mysql.fabric.Response"%>
<%@ page import="sun.security.provider.certpath.ResponderId"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String pageNum = request.getParameter("pageNum");
	String id = (String) session.getAttribute("id");

	ReplyDBBean replydb = ReplyDBBean.getInstance();
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
	RequestDBBean rqdb = RequestDBBean.getInstance();
%>

<jsp:useBean id="reply" scope="page" class="signD.member.ReplyDataBean">
	<jsp:setProperty name="reply" property="*" />
</jsp:useBean>

<%
	reply.setReg_date(new Timestamp(System.currentTimeMillis()));
	reply.setDivision("의뢰글");
	replydb.insertReply(reply);

	RequestDataBean rq = rqdb.getRequest(reply.getRequestcode());
%>
<jsp:useBean id="alarm" class="signD.member.AlarmDataBean" />
<%
	if (!id.equals(rq.getId())) {
		alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
		alarm.setUrl("/capstone/signD/contest/requestDetail.jsp?requestcode=" + reply.getRequestcode());
		alarm.setContents(id + "님이 " + request.getParameter("to_id") + "님의 댓글에 답글을 달았습니다.");
		alarm.setType("댓글 등록");
		alarmdb.insertAlarm(alarm);
	}
%>
<!--  
<script type="text/javascript">
	history.go(-1);
</script>

	response.sendRedirect("content.jsp?num=" + num + "&pageNum=" + pageNum);
%-->
<meta http-equiv="Refresh" content="0;url=requestDetail.jsp?requestcode=<%=reply.getRequestcode()%>">