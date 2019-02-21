<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.OneToOneRequestDBBean"%>
<%@page import="signD.member.OneToOneRequestDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<jsp:useBean id="rq" class="signD.member.OneToOneRequestDataBean">
	<jsp:setProperty name="rq" property="*" />
</jsp:useBean>
<%
	String id=(String)session.getAttribute("id");
	int rqcode=Integer.parseInt(request.getParameter("rqcode"));
	
	int check=0;
	
	OneToOneRequestDBBean rqdb=OneToOneRequestDBBean.getInstance();	
	
	if (id != null) {
		check=rqdb.deleteOneToOneRequest(rqcode);
		 if(check==1){
			 %><%-- <%=accept%> --%>
			<script type="text/javascript">
				alert("삭제되었습니다.");
				document.location.href = "/capstone/signD/mypage/myPage.jsp?tab=OTOrequest";
			</script>
<%
		 }else{
			 %>
			<script type="text/javascript">
				alert("다시한번 시도해주세요.");
				history.go(-1);
			</script>
<%
		 }
	} else {
%>
<script type="text/javascript">
	alert('권한이 없습니다.');
	document.location.href = "/capstone/signD/main.jsp";
</script>
<%
	}
%>