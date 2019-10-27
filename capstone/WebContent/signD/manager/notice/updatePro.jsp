<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	
	if(managerId!=null){
		%>
		<jsp:useBean id="notice" class="signD.help.NoticeDataBean">
			<jsp:setProperty name="notice" property="*" />
		</jsp:useBean>
		<%
		NoticeDBBean noticedb = NoticeDBBean.getInstance();
	
		notice.setId(managerId);
		//notice.setReg_date(new Timestamp(System.currentTimeMillis()));
		int check=noticedb.updateNotice(notice);
	
		if(check==1){
			%>
			<script>
				alert("공지사항을 수정하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/notice.jsp">
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("공지사항을 수정하지 못하였습니다. 다시 시도해주세요.");
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