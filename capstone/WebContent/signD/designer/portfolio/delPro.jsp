<%@page import="signD.member.PortfolioDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	int pfcode = Integer.parseInt(request.getParameter("pfcode"));
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	int check = pfdb.deletePortfolio(pfcode);
	if(check==1){
	%>
		<script type="text/javascript">
			alert("포트폴리오를 삭제하였습니다.");
			location.href="/capstone/signD/mypage/myPage.jsp?tab=profile";
		</script>
	<%
	}else{
	%>
		<script type="text/javascript">
			alert("포트폴리오를 삭제하지 못했습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
	<%
	}
%>