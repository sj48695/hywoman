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
   
   String pageNum = request.getParameter("pageNum");
   String id=(String)session.getAttribute("id");
   String managerId=(String)session.getAttribute("managerId");
   String keyfield = request.getParameter("keyfield");
   String keyword = request.getParameter("keyword");
   if (keyword == null){
       keyword = "";
    }
   if (pageNum == null) {
      pageNum = "1";
   }
   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
   int count = 0;
   int number = 0;
   
   QnADBBean qnadb=QnADBBean.getInstance();
   count=qnadb.getQnACount(keyfield,keyword);
   List<QnADataBean> qnas=qnadb.getQnAs(startRow,pageSize,keyfield,keyword);
   QnADataBean qna=null;
   

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
<!-- <div style="text-align:center;"> -->
   <form class="form-inline py-4" style="margin:0 auto;" name="search" method="get" action="/capstone/signD/help/Q&A.jsp">
      <select name="keyfield" class="col-md-1" id="keyfield">
           <option value="all">전체</option>
           <option value="title">제목</option>
           <option value="id">작성자</option>
        </select>
         <input type="text" class="form-control col-md-5" placeholder="검색어를 입력하세요" name="keyword" value="<%=keyword%>">
      <button type="submit" class="btn btn-outline-dark col-md-1">검색</button>
   </form>
<!-- </div> -->
   <%
      if (count == 0) {
   %>
   <div class="alert alert-danger" role="alert">Q&A에 등록된 글이 없습니다.</div>
   <%
   }else {
   %>
   <table class="table table-hover">
      <colgroup>
         <col width="10%">
         <col width="*">
         <col width="10%">
         <col width="20%">
      </colgroup>
      <thead>
         <tr>
            <th>No.</th>
            <th>제목</th>
            <th>작성자</th>
            <th>등록일자</th>
         </tr>
      </thead>
      <tbody>
      <%
         for(int i=0;i<qnas.size();i++){
            qna=qnas.get(i);
      %>
         <tr>
            <td><%=number--%></td>
         <%
            int wid=0; 
            if(qna.getRe_level()>0){
               wid=10*(qna.getRe_level());
         %>
            <td style="text-indent:<%=wid%>px;">
                 <i class="fab fa-replyd"></i>
         <%  }else{%>
            <td style="text-indent:<%=wid%>px;">
         <%  }%>
               <a href="Q&A/detail.jsp?qnacode=<%=qna.getQnAcode()%>"><%=qna.getTitle()%></a>
            </td>
            <td><%=qna.getId()%></td>
            <td><%=sdf.format(qna.getReg_date())%></td>
		</tr>
      <%
      	}
      	}
      %>
      </tbody>
   </table>
   <%
   if(managerId==null){
   %>
   <a class="btn btn-outline-dark offset-10" role="button" href="Q&A/writeForm.jsp"><i class="far fa-edit"></i>글쓰기</a>
   <%} %>
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
         <a href="/capstone/signD/help/Q&A.jsp?pageNum=<%=startPage - 10%>"
            class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
         <%
               for (int i = startPage; i <= endPage; i++) {
         %>
         <a href="/capstone/signD/help/Q&A.jsp?pageNum=<%=i%>"
            class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
         <%
               }
         %>
         <a href="/capstone/signD/help/Q&A.jsp?pageNum=<%=startPage + 10%>"
            class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
         <%
            }
         %>
      </div>
   </nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />