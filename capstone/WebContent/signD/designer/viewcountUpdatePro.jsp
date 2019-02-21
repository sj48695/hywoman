<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	int ppcode = Integer.parseInt(request.getParameter("ppcode"));
	int pfcode = Integer.parseInt(request.getParameter("pfcode"));
	int check=-1;

	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	if (ppcode!=0) {//참여작 조회수가 올라갈 때
		check=ppdb.updateViewcount(ppcode, id);
	} else if (pfcode!=0){//포트폴리오 조회수가 올라갈 때
		check=pfdb.updateViewcount(pfcode, id);
	}
%><%=check%>