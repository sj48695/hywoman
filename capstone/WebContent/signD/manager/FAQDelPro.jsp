<%@page import="signD.help.FAQDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");

	if (managerId != null) {
		int faqcode = Integer.parseInt(request.getParameter("faqcode"));
%>

<jsp:useBean id="faq" class="signD.help.FAQDataBean">
	<jsp:setProperty name="faq" property="*" />
</jsp:useBean>
<%
		FAQDBBean faqdb = FAQDBBean.getInstance();
		int check=faqdb.deleteFAQ(faqcode);

		if(check==1){
			%>
			<script type="text/javascript">
				alert("FAQ를 삭제하였습니다.");
			</script>
			<meta http-equiv="Refresh" content="0;url=/capstone/signD/help/FAQ.jsp">
			<%
		}else{
			%>
			<script>
				alert("FAQ를 삭제하지 못하였습니다. 다시 시도해주세요.");
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