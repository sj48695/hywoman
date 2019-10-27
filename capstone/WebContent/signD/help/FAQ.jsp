<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.help.FAQDBBean"%>
<%@page import="signD.help.FAQDataBean"%>

<%   
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   request.setCharacterEncoding("utf-8");
   
   String title = "자주하는 질문 | DO";
   String managerId = (String) session.getAttribute("managerId");
   String pageNum = request.getParameter("pageNum");
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
   
   LogonDBBean manager = LogonDBBean.getInstance();
   
   FAQDBBean FAQdb = FAQDBBean.getInstance();
   List<FAQDataBean> FAQlist = FAQdb.getFAQ(startRow, pageSize,keyword);
   FAQDataBean FAQ=null;
   count=FAQdb.getFAQCount(keyword);
   
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
			<p class="lead"><strong>자주 묻는 질문을 확인하세요!</strong></p>
		</div>
	</section>
</div>
<div class="container">
   <div class="w3-bar w3-border w3-light-white w3-center">
      <a href="/capstone/signD/help/notice.jsp" class="w3-button w3-col s3">공지사항</a> 
      <a href="/capstone/signD/help/FAQ.jsp" class="w3-button w3-col s3 w3-brown"><strong>FAQ</strong></a> 
      <a href="/capstone/signD/help/Q&A.jsp" class="w3-button w3-col s3">Q&A</a> 
      <a href="/capstone/signD/help/rule.jsp" class="w3-button w3-col s3 ">이용방법</a>
   </div>
   <div class="search-wrap" style="width: 1110px; height: 100px; border: 5px solid #DEDEDE;">
      <dl style="margin-left: 20px; margin-top: 18px;">
         <dt style="margin: 0; padding: 0; width: 250px; float: left; line-height: 21px; height: 22px; padding-top: 14px;">
            <h4 style="font-weight: 450; color: #625f5f !important; text-align: center;">자주하는 질문 검색</h4>
         </dt>
         <dd style="margin: 0; padding: 0; margin-left: 280px; padding-top: 8px;">
         <form name="search" method="get" action="FAQ.jsp">
            <input type="text"
               style="width: 540px; height: 30px; line-height: 30px; vertical-align: top; background: none; border: 1px solid #DEDEDE; padding-left: 10px;"
               name="keyword" placeholder="이곳에 질문을 입력해주세요." value="<%=keyword%>">
            <button type="submit" class="btn btn-primary mb-2 col-md-2">검색</button>
            <br>
            <p style="color: #e54419; font-size: 10px; font-weight: 700; padding-top: 4px;">TOP &gt; 
               <span> 
                  <a style="margin-left: 10px; padding-right: 10px; border-right: 1px solid #dedede;"
                     href="/customer/index/type-2/searchKey-브리핑/searchField-S/">브리핑</a>
                  <a style="margin-left: 10px; padding-right: 10px; border-right: 1px solid #dedede;"
                     href="/customer/index/type-2/searchKey-공모전/searchField-S/">공모전</a>
                  <a style="margin-left: 10px; padding-right: 10px; border-right: 1px solid #dedede;"
                     href="/customer/index/type-2/searchKey-심사/searchField-S/">심사</a> 
                  <a style="margin-left: 10px; padding-right: 10px;"
                     href="/customer/index/type-2/searchKey-상금/searchField-S/">상금</a>
               </span>
            </p>
            </form>
         </dd>
      </dl>
      <script>
         function schForm() {
            location.href = "/customer/index/searchField-S/searchKey-"
                  + $("[name=searchKey]").val();
         }
         $("[name=searchKey]").keypress(function(event) {
            if (event.keyCode == 13) {
               schForm();
            }
         })
      </script>
   </div>
   
   <div class="accordion py-4" id="accordion">
      <table class="table table-hover">
         <colgroup>
            <col width="10%">
            <col width="*%">
            <%if (managerId != null) {%><col width="15%"><%} %>
         </colgroup>
		<thead>
			<tr>
				<th>No.</th>
				<th>제목</th>
				<%if (managerId != null) {%><th>수정/삭제</th><%} %>
			</tr>
		</thead>
		<tbody>
         <%
            if (count == 0) {
         %>
            <tr><th class="text-center" colspan="4">FAQ에 저장된 글이 없습니다.</th></tr>
         <%
            } else {
               for (int i = 0; i < FAQlist.size(); i++) {
                  FAQ=FAQlist.get(i);
            %>
			<tr>
				<th><%=number--%></th>
				<td>
					<div data-toggle="collapse" data-target="#faq<%=i%>" aria-expanded="true" aria-controls="faq<%=i%>">
						<%=FAQ.getTitle()%>
					</div>
					<div id="faq<%=i%>" class="collapse py-3" aria-labelledby="faq<%=i%>" data-parent="#accordion">
						<%=FAQ.getContents()%>
					</div>
				</td>
				<%
					if (managerId != null) {
				%>
				<td>
					<a class="btn btn-outline-dark" href="../manager/FAQ/updateForm.jsp?faqcode=<%=FAQ.getFAQcode() %>" role="button">
					수정</a>
					<a class="btn btn-outline-dark" href="../manager/FAQ/delPro.jsp?faqcode=<%=FAQ.getFAQcode() %>" role="button">
					삭제</a>
				</td>
				<%
					}
				%>
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
   <a class="btn btn-outline-dark offset-10" href="../manager/FAQ/writeForm.jsp" role="button"><i class="far fa-edit"></i>글쓰기</a>
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
         <a href="FAQ.jsp?pageNum=<%=startPage - 10%>"
            class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
         <%
            for (int i = startPage; i <= endPage; i++) {
         %>
         <a href="FAQ.jsp?pageNum=<%=i%>"
            class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
         <%
            }
         %>
         <a href="FAQ.jsp?pageNum=<%=startPage + 10%>"
            class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
         <%
            }
         %>
      </div>
   </nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />