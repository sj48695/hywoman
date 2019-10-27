<%@ page import="java.sql.Timestamp"%>
<%@ page import="signD.member.BookmarkDBBean"%>
<%@ page import="signD.member.BookmarkDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bm" class="signD.member.BookmarkDataBean">
	<jsp:setProperty name="bm" property="*" />
</jsp:useBean>
<%
	String id = (String) session.getAttribute("id");
	String designer_id = request.getParameter("designer_id");
	Integer rqcode = Integer.parseInt(request.getParameter("requestcode"));
	int check = 0;

	BookmarkDBBean bmdb = BookmarkDBBean.getInstance();

	if (id != null) {
		bm.setRequestcode(rqcode);
		bm.setId(id);
		bm.setDesigner_id(designer_id);
		bm.setReg_date(new Timestamp(System.currentTimeMillis()));
		check = bmdb.bookmark(bm);
		%><%=check%><%
	} else {
		%><%=id %><%
	}
%>