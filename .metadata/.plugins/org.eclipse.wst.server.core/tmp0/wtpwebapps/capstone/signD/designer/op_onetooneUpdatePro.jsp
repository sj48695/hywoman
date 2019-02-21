<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	int op_onetoone = Integer.parseInt(request.getParameter("op_onetoone"));
	int check=-1;

	LogonDBBean logon =LogonDBBean.getInstance();
	check=logon.updateOneToOne(op_onetoone,id);
%><%=check%>