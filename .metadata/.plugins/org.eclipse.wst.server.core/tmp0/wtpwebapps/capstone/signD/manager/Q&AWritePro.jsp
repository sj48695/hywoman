<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");//한글깨짐 방지
	String managerId = (String) session.getAttribute("managerId");
%>
<jsp:useBean id="qna" class="signD.help.QnADataBean">
	<jsp:setProperty name="qna" property="*"/>
</jsp:useBean>
<%
	if(managerId!=null){
	
		QnADBBean qnadb = QnADBBean.getInstance();
	
		qna.setId(managerId);
		qna.setReg_date(new Timestamp(System.currentTimeMillis()));
		int check=qnadb.insertManagerQnA(qna);
		
		if(check==1){
			%>
			<script>
				alert("문의사항 답변을 등록하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/Q&A.jsp">
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("문의사항 답변을 등록하지 못하였습니다. 다시 시도해주세요.");
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