<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	int qnacode=Integer.parseInt(request.getParameter("qnacode"));
	
	QnADBBean qnadb = QnADBBean.getInstance();
	int check=qnadb.deleteQnA(qnacode);	
	if(check==1){
		%>
		<script>
			alert("삭제 되었습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/Q&A.jsp">
		<%
	}else{
		%>
		<script>
			alert("삭제 되지 않았습니다. 다시 시도해 주세요.");
			history.go(-1);
		</script>
		<%
	}
%>