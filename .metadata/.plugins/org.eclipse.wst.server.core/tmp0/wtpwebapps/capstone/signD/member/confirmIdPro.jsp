<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page import="signD.member.LogonDataBean"%>

<%
	request.setCharacterEncoding("utf-8");
	String userId = request.getParameter("userId");
	LogonDBBean logon = LogonDBBean.getInstance();
	int check = logon.confirmId(userId);
%>
<%=check %>