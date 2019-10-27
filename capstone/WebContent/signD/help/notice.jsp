<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@page import="signD.help.NoticeDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	request.setCharacterEncoding("utf-8");
	String managerId = (String) session.getAttribute("managerId");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	String title = "공지사항  | DO";
	int count = 0;
	int number = 0;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;

	LogonDBBean manager = LogonDBBean.getInstance();

	NoticeDBBean noticedb = NoticeDBBean.getInstance();
	List<NoticeDataBean> noticelist = noticedb.getNotice(startRow, pageSize);
	NoticeDataBean notice=null;

	count = noticedb.getNoticeCount();
	number = count - (currentPage - 1) * pageSize;
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="bgi4">
	<section class="jumbotron text-center img-cover">
		<div class="container py-4 jumbotitle">
			<h1 class="jumbotron-heading jumbotitle"><strong>고객센터</strong></h1>
			<p class="lead"><strong>공지사항을 확인하세요!</strong></p>
		</div>
	</section>
</div>
<div class="container">
   <div class="w3-border w3-light-white w3-row">
      <a href="/capstone/signD/help/notice.jsp" class="w3-button w3-col s3 w3-brown"><strong>공지사항</strong></a> 
      <a href="/capstone/signD/help/FAQ.jsp" class="w3-button w3-col s3">FAQ</a> 
      <a href="/capstone/signD/help/Q&A.jsp" class="w3-button w3-col s3">Q&A</a> 
      <a href="/capstone/signD/help/rule.jsp" class="w3-button w3-col s3">이용방법</a>
   </div>
	<div class="accordion py-4" id="accordion">
		<table class="table table-hover">
			<colgroup>
				<col width="10%">
				<col width="*%">
				<col width="65px">
				<col width="20%">
				<%if (managerId != null) {%><col width="15%"><%} %>
			</colgroup>
			<thead>
				<tr>
					<th>No.</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<%if (managerId != null) {%><th class="text-center">수정/삭제</th><%} %>
				</tr>
			</thead>
			<tbody>
			<%
				if (count == 0) {
			%>
				<tr><th class="text-center" colspan="4">공지사항에 저장된 글이 없습니다.</th></tr>
			<%
				} else {
					for (int i = 0; i < noticelist.size(); i++) {
						notice=noticelist.get(i);
				%>
				<tr>
					<th><%=number--%></th>
					<td>
						<div data-toggle="collapse" data-target="#notice<%=i%>" aria-expanded="true" aria-controls="notice<%=i%>">
							<%=notice.getTitle()%>
						</div>
						<div id="notice<%=i%>" class="collapse py-3" aria-labelledby="notice<%=i%>" data-parent="#accordion">
							<%=notice.getContents()%>
						</div>
					</td>
					<td><%=manager.selectName(notice.getId())%></td>
					<td><%=sdf.format(notice.getReg_date())%></td>
					<%if (managerId != null) {%>
					<td class="text-center">
						<a class="btn btn-outline-dark" role="button"
						href="../manager/notice/updateForm.jsp?noticecode=<%=notice.getNoticecode()%>">수정</a>
						<a class="btn btn-outline-dark" role="button"
						href="../manager/notice/delPro.jsp?noticecode=<%=notice.getNoticecode()%>"> 삭제</a>
					</td>
					<%}%>
				</tr>
				<%
					}	
				}
				%>
			</tbody>
		</table>
	</div>
		<%
			if (managerId != null) {
		%>
	<a class="btn btn-outline-dark offset-10" href="../manager/notice/writeForm.jsp" role="button"><i class="far fa-edit"></i>글쓰기</a>
		<%
			}
		%>
	<nav aria-label="Page navigation">
		<div class="w3-bar w3-large pagination justify-content-center py-3">
			<%
				if (count > 0) {
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//1+1(2)
					int startPage = 1;
	
					if (currentPage % 10 != 0)//1의자리 숫자가 0이 아니면
						startPage = (int) (currentPage / 10) * 10 + 1;//1,11,21
					else
						startPage = ((int) (currentPage / 10) - 1) * 10 + 1;//1,11,21
	
					int pageBlock = 10;
					int endPage = startPage + pageBlock - 1;//1+10-1
					if (endPage > pageCount)
						endPage = pageCount;//2
			%>
			<a href="notice.jsp?pageNum=<%=startPage - 10%>"
				class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
			<%
					for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="notice.jsp?pageNum=<%=i%>"
				class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
			<%
					}
			%>
			<a href="notice.jsp?pageNum=<%=startPage + 10%>"
				class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
			<%
				}
			%>
		</div>
	</nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
