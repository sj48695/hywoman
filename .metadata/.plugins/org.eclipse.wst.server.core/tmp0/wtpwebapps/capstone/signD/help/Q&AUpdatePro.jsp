<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");//한글깨짐 방지
	String id=(String)session.getAttribute("id");

	if (id == null) {id="비회원";}
	%>	
<jsp:useBean id="qna" class="signD.help.QnADataBean">
	<jsp:setProperty name="qna" property="*"/>
</jsp:useBean>
	<%
	QnADBBean qnadb = QnADBBean.getInstance();

	qna.setId(id);	
	qna.setReg_date(new Timestamp(System.currentTimeMillis()));
	int check=qnadb.updateQnA(qna);
	
	if(check==1){
		%>
		<script>
			alert("문의사항을 수정하였습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/Q&A.jsp">
		<%
	}else{
		%>
		<script>
			alert("문의사항을 수정하지 못하였습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
		<%
	}
%>