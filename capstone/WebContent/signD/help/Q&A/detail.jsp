<%@page import="signD.help.QnADataBean"%>
<%@page import="signD.help.QnADBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   String title = "Q&A | DO";

   String id=(String)session.getAttribute("id");
   String managerId=(String)session.getAttribute("managerId");
   int qnacode=Integer.parseInt(request.getParameter("qnacode"));
   
   if(id==null){
	   id="";
   }
   QnADBBean qnadb=QnADBBean.getInstance();
   QnADataBean qna=qnadb.getQnA(qnacode);
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>
<jsp:include page="../../module/menubar.jsp" flush="false" />
<div class="bgi4">
	<section class="jumbotron text-center img-cover">
		<div class="container py-4 jumbotitle">
			<h1 class="jumbotron-heading jumbotitle"><strong>고객센터</strong></h1>
			<p class="lead"><strong>모르는 사항을 문의하세요!</strong></p>
		</div>
	</section>
</div>
<div class="container">
   <div class="w3-border w3-light-white w3-row">
      <a href="/capstone/signD/help/notice.jsp" class="w3-button w3-col s3">공지사항</a> 
      <a href="/capstone/signD/help/FAQ.jsp" class="w3-button w3-col s3">FAQ</a> 
      <a href="/capstone/signD/help/Q&A.jsp" class="w3-button w3-col s3 w3-brown"><strong>Q&A</strong></a> 
      <a href="/capstone/signD/help/rule.jsp" class="w3-button w3-col s3">이용방법</a>
   </div>
   <div class="container py-4 col-9">
      <table class="table">
         <colgroup>
            <col width="20%">
            <col width="*">
            <col width="20%">
            <col width="25%">
         </colgroup>
         <tr>
            <th>제목</th>
            <td><%=qna.getTitle()%></td>
            <th>등록날짜</th>
            <td><%=sdf.format(qna.getReg_date())%></td>
         </tr>
         <tr>
            <th>아이디</th>
            <td colspan="3"><%=qna.getId()%></td>
         </tr>
         <tr>
            <th>내용</th>
            <td colspan="3"><%=qna.getContents()%></td>
         </tr>
         <tr>
            <td colspan="3"></td>
            <td class="row">
               <%
                  if (managerId != null) {
               %>
               <a class="btn btn-outline-dark col-5" href="../manager/Q&A/writeForm.jsp?qnacode=<%=qnacode%>&re_step=<%=qna.getRe_step() %>" 
                   role="button"><i class="far fa-edit"></i>답변달기</a> 
                <a class="btn btn-outline-dark col-5 offset-1" href="../manager/Q&A/delPro.jsp?qnacode=<%=qnacode%>" role="button">
                  <i class="far fa-edit"></i>삭제</a>
                <%
                   }else{
                      if(id.equals(qna.getId())) {
                %> 
				<a class="btn btn-outline-dark col-5" role="button"
					href="../manager/Q&A/updateForm.jsp?qnacode=<%=qnacode%>">수정</a>
                <a class="btn btn-outline-dark col-5 offset-1" href="Q&A/delPro.jsp?qnacode=<%=qnacode%>" role="button">
                  <i class="far fa-edit"></i>삭제</a>
               <%
                     } 
                   }
               %>
            </td>
         </tr>
      </table>
   </div>
</div>
<jsp:include page="../../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />