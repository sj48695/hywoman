<%@page import="java.sql.Timestamp"%>
<%@page import="signD.help.FAQDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	
	if(managerId!=null){
		%>
		<jsp:useBean id="FAQ" class="signD.help.FAQDataBean">
			<jsp:setProperty name="FAQ" property="*" />
		</jsp:useBean>
		<%
		FAQDBBean FAQdb = FAQDBBean.getInstance();
	
		FAQ.setId(managerId);
		//FAQ.setReg_date(new Timestamp(System.currentTimeMillis()));
		int check=FAQdb.updateFAQ(FAQ);
	
		if(check==1){
			%>
			<script>
				alert("FAQ를 수정하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/FAQ.jsp">
			<%
		}else{
			%>
			<script type="text/javascript">
				alert("FAQ를 수정하지 못하였습니다. 다시 시도해주세요.");
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