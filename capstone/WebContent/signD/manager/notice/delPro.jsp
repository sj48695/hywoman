<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	
	if(managerId!=null){
		int noticecode = Integer.parseInt(request.getParameter("noticecode"));
		
		NoticeDBBean noticedb = NoticeDBBean.getInstance();
		int check=noticedb.deleteNotice(noticecode);
	
		if(check==1){
			%>
			<script>
				alert("공지사항을 삭제하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/notice.jsp">
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("공지사항을 삭제하지 못하였습니다. 다시 시도해주세요.");
				history.go(-1);
			</script>
			<%
		}
	}else{
		%>
<script type="text/javascript">
<!--
	alert("관리자만 접근할 수 있습니다.");
//-->
</script>
		<%
	}
%>