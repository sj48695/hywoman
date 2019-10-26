<%-- <%@page import="signD.member.bookmarkBiz"%> --%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="signD.member.BookmarkDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%-- <%
	String id=(String)session.getAttribute("id");
	int articleId=Integer.parseInt(request.getParameter("articleId"));
	BookmarkDataBean article =articleBiz.getDetailArticle(articleId);
	
	BookmarkDBBean bmdb=BookmarkDBBean.getInstance();
	BookmarkDataBean bm =new BookmarkDataBean();
	bm.setId(id);
	
	boolean isExistsBmData=bookmarkBiz.isExistBookmarkData(id);

	if(article!=null){
		request.setAttribute("selectedArticle", article);
		request.setAttribute("isExistsFavoriteData", isExistsBmData);
		
		RequestDispatcher rd=request.getRequestDispatcher("");
		rd.forward(request, response);
	}else{
		response.sendRedirect("/");
	}
	
	
	if (id != null) {

		
	} else {
%> --%>
<script type="text/javascript">
<!--
	alert('권한이 없습니다.');
	document.location.href = "/capstone/signD/main.jsp";
//-->
</script>
<%
	//}
%>