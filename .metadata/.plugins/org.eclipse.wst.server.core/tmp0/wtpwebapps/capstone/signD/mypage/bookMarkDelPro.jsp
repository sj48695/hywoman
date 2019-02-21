<%@page import="java.sql.Timestamp"%>
<%@page import="signD.member.BookmarkDataBean"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:useBean id="bm" class="signD.member.BookmarkDataBean">
	<jsp:setProperty name="bm" property="*"/>
</jsp:useBean>
<%
	String id = (String) session.getAttribute("id");
	String designer_id=request.getParameter("designer_id");
	String requestcode=request.getParameter("requestcode");
	if(requestcode.equals("")){
		requestcode="0";
	}
	int rqcode = Integer.parseInt(requestcode);
	int check = 0;

	BookmarkDBBean bmdb = BookmarkDBBean.getInstance();
	
	if (id != null) {

		bm.setRequestcode(rqcode);
		bm.setId(id);
		bm.setDesigner_id(designer_id);
		bm.setReg_date(new Timestamp(System.currentTimeMillis()));
		check=bmdb.deleteBookmark(bm);
		if (check == 0) {
%>	
		<script type="text/javascript">
			alert("즐겨찾기가 취소되었습니다.");
		</script>
	<%
			response.sendRedirect(request.getHeader("referer")); 
		} else {
	%>
		<script type="text/javascript">
			alert("즐겨찾기가 취소되지 않았습니다.");
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