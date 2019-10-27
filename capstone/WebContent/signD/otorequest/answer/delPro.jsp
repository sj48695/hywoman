<%@page import="signD.member.OneToOneAnswerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	int answercode = Integer.parseInt(request.getParameter("answercode"));
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	OneToOneAnswerDBBean pfdb = OneToOneAnswerDBBean.getInstance();
	int check = pfdb.deleteOneToOneAnswer(answercode);
	if(check==1){
	%>
		<script type="text/javascript">
			alert("1:1답변을 삭제하였습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=/capstone/signD/mypage/myPage.jsp?tab=OTOrequest">
	<%
	}else{
	%>
		<script type="text/javascript">
			alert("1:1답변을 삭제하지 못했습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
	<%
	}
%>