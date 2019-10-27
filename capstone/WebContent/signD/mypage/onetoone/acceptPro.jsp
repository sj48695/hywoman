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
	String designer_id=request.getParameter("designer_id");
	long endDay = System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000);//1주 후 
	int accept=Integer.parseInt(request.getParameter("accept"));
	int rqcode=Integer.parseInt(request.getParameter("rqcode"));
	
	int check=0;
	
	OneToOneRequestDBBean rqdb=OneToOneRequestDBBean.getInstance();	
	
	if (id != null) {
		rq.setStart_date(new Timestamp(System.currentTimeMillis()));
		rq.setEnd_date(new Timestamp(endDay));
		rq.setAccept(accept);
		rq.setRequestcode(rqcode);
		check=rqdb.updateAccept(rq);
		 if(check==1){
			 %><%=accept%><%
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