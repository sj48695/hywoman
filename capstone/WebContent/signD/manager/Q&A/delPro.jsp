<%@page import="signD.help.QnADBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");

	if (managerId != null) {
		int qnacode = Integer.parseInt(request.getParameter("qnacode"));
%>

<jsp:useBean id="qna" class="signD.help.QnADataBean">
	<jsp:setProperty name="qna" property="*" />
</jsp:useBean>
<%
		QnADBBean qnadb = QnADBBean.getInstance();
		int check=qnadb.deleteQnA(qnacode);

		if(check==1){
			%>
			<script>
				alert("문의사항 답변을 삭제하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/Q&A.jsp">
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("문의사항 답변을 삭제하지 못하였습니다. 다시 시도해주세요.");
				history.go(-1);
			</script>
			<%
		}
	} else {
%>
<script type="text/javascript">
<!--
	alert("관리자만 접근할 수 있습니다.");
//-->
</script>
<%
	}
%>