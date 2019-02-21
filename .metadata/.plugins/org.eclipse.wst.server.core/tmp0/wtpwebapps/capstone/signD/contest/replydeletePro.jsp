<%@page import="signD.member.ReplyDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	int rpcode = Integer.parseInt(request.getParameter("replycode"));
	int rqcode = Integer.parseInt(request.getParameter("requestcode"));
	ReplyDBBean replydb = ReplyDBBean.getInstance();
	int check = replydb.deleteReply(rpcode);

	if (check == 1){
%>
<script>
alert("댓글이 삭제되었습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=requestDetail.jsp?requestcode=<%=rqcode%>">
<%
	} else {
%>
<script>
alert("댓글이 삭제되지 않았습니다.");
</script>
<meta http-equiv="Refresh" content="0;url=requestDetail.jsp?requestcode=<%=rqcode%>">

<%
	}
%>