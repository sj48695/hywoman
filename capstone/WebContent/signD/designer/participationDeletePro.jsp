<%@page import="signD.contest.ParticipationDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	int ppcode = Integer.parseInt(request.getParameter("ppcode"));
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	ParticipationDBBean pfdb = ParticipationDBBean.getInstance();
	int check = pfdb.deleteParticipation(ppcode);
	if(check==1){
	%>
		<script type="text/javascript">
			alert("참여작을 삭제하였습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=../contest/requestDetail.jsp?requestcode=<%=rqcode%>">
<%
	}else{
	%>
		<script type="text/javascript">
			alert("참여작을 삭제하지 못했습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
	<%
	}
%>