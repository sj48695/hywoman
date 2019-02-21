
<%@page import="signD.manager.ManagerDataBean"%>
<%@page import="signD.manager.ManagerDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	//int rqcode=Integer.parseInt(request.getParameter("rqcode"));
	int ppcode=Integer.parseInt(request.getParameter("ppcode"));
	int prize_money=Integer.parseInt(request.getParameter("prize_money"));
	
	//RequestDBBean rqdb = RequestDBBean.getInstance();
	AlarmDBBean alarmdb=AlarmDBBean.getInstance();
	//ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	ManagerDBBean managerdb=ManagerDBBean.getInstance();

	//String list = request.getParameter("list");
	//String[] lists = list.split(",");
	//int check = 0;
	//MessageDBBean msgdb = MessageDBBean.getInstance();

	/* for (int i = 0; i < lists.length; i++) {
		check = managerdb.updatePrizeMoney(Integer.parseInt(lists[i]), prize_money);
	} */
	
	
	int check=managerdb.updatePrizeMoney(ppcode, prize_money);
	
	
%>
		<%=check %>