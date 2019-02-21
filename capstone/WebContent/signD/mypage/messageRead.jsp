<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.MessageDataBean"%>
<%@page import="signD.member.MessageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	int msgcode=Integer.parseInt(request.getParameter("msgcode"));
	
	MessageDBBean msgdb = MessageDBBean.getInstance();
	int check=msgdb.updateRead_check(msgcode);
%>
<%=check %>