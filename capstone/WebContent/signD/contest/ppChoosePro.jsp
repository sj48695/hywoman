<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	int rqcode=Integer.parseInt(request.getParameter("rqcode"));
	int ppcode=Integer.parseInt(request.getParameter("ppcode"));
	
	RequestDBBean rqdb = RequestDBBean.getInstance();
	AlarmDBBean alarmdb=AlarmDBBean.getInstance();
	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	
	int prize_money = rqdb.getRequest(rqcode).getCost();
	int check=rqdb.updatePpcode(rqcode, ppcode,prize_money);
	
	if(check==1){
		%><jsp:useBean id="alarm" class="signD.member.AlarmDataBean"/> 
		<%
		alarm.setTo_id(ppdb.getParticipation(ppcode).getId()); 
		alarm.setFrom_id(id);
		alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
		alarm.setUrl("/capstone/signD/contest/requestDetail.jsp?requestcode="+rqcode);
		alarm.setContents(id+"님이 당신의 의뢰글을 채택하였습니다.");
		alarm.setType("참여작 채택");
		alarmdb.insertAlarm(alarm); 
	}else{
	}
%><%=check %>