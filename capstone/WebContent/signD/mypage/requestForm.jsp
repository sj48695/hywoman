<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.BookmarkDataBean"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%!DecimalFormat decimal = new DecimalFormat("#,###");%>
<%
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat sd = new SimpleDateFormat("yyyy. MM. dd (E)");
	SimpleDateFormat ed = new SimpleDateFormat("MM. dd (E)");

   request.setCharacterEncoding("utf-8");
   String id = (String) session.getAttribute("id");
   String pageNum = request.getParameter("pageNum");
   if (pageNum == null) {
      pageNum = "1";
   }

   String tab2 = request.getParameter("tab2");
   if(tab2==null){
      tab2="";
   }
   LogonDBBean Logon = LogonDBBean.getInstance();
   LogonDataBean member = Logon.getMember(id);

   RequestDBBean rqdb = RequestDBBean.getInstance();
   List<RequestDataBean> rqs = null;
   RequestDataBean rq = null;

   ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
   BookmarkDBBean bmdb = BookmarkDBBean.getInstance();

   int count = 0;
   int currentPage = 0;
   int startRow = 0;
   int ppcount = 0;//콘테스트 참여자수
   String Dday = "";
   String filenames[]=null;
   
   if (id != null) {
      %>
      
<nav class="navbar row justify-content-end">
    <div class="btn-group btn-group-toggle col-sm-2 text-center" data-toggle="buttons">
       <ul class="nav nav-tabs nav-pills" id="msgType" role="tablist">
          <li class="nav-item">
             <a class="nav-link btn-outline-dark active" data-toggle="tab" href="#ingRequest" role="tab" id="ing"
                aria-controls="ingRequest" aria-selected="true" onclick="tab2Change('request','ing');">진행중</a>
          </li>
          <li class="nav-item">
             <a class="nav-link btn-outline-dark" data-toggle="tab" href="#endRequest" role="tab" id="end"
                aria-controls="endRequest" aria-selected="false" onclick="tab2Change('request','end');">종료된</a>
          </li>
       </ul>
    </div>
</nav>
<div class="tab-content">
	<div class="tab-pane fade show active" id="ingRequest" role="tabpanel">
		<%
		count = rqdb.getMyRequestCount(id, "ing");
		currentPage = Integer.parseInt(pageNum);
		if (!tab2.equals("ing")) {
			currentPage = 1;
		}
		/* if ((count / 10) + 1 < currentPage) {
		   currentPage = count / 10 + 1;
		} */
		startRow = (currentPage - 1) * pageSize + 1;

		if (count == 0) {

			if (member.getType().equals("의뢰인")) {
	%>
		<table class="table table-borderless py-5 my-5">
			<tr><th class="text-center">진행중인 콘테스트가 없습니다. 콘테스트를 개최해 주세요.</th></tr>
			<tr><td class="text-center"><a class="btn btn-outline-dark" href="../contest/designrequest/step1.jsp">개최하기</a></td></tr>
		</table>
		<%
			} else if (member.getType().equals("디자이너")) {
		%>
		<table class="table table-borderless py-5 my-5">
			<tr><th class="text-center">진행중인 콘테스트가 없습니다. 콘테스트에 참여해 보세요.</th></tr>
			<tr><td class="text-center"><a class="btn btn-outline-dark" href="../contest/contestIngList.jsp">참여하기</a></td></tr>
		</table>
		<%
			}
		} else {
			rqs = rqdb.getMyRequests(id, startRow, pageSize, "ing");
			for (int i = 0; i < rqs.size(); i++) {
				rq = (RequestDataBean) rqs.get(i);
				ppcount = rqdb.getPPRequestCount(rq.getRequestcode());//콘테스트 참여자수
				Dday = rqdb.getDday(rq.getRequestcode());
		%>
		<div style="position: relative; overflow: hidden;">
	      <div class="new_list_icon">
	            <%if (bmdb.getBookmarkCheck(id, rq.getRequestcode(), null) == 1) {%>
	            <div class="star" data-toggle="button" aria-pressed="true" data-rqcode="<%=rq.getRequestcode()%>">
	               <font size="5"><i class="fas fa-star"></i></font>
	            </div>
	            <%} else {%>
	            <div class="star" data-toggle="button" aria-pressed="false" data-rqcode="<%=rq.getRequestcode()%>">
	               <font size="5"><i class="far fa-star"></i></font>
	            </div>
	            <%}%>
	      </div>
	      <div class="new_list_item m-2 media row justify-content-between bgcolor0<%=i%>">
	         <div class="col-sm-8 pr-0 row align-self-center"
	            onclick="location.href='/capstone/signD/contest/detail.jsp?requestcode=<%=rq.getRequestcode()%>'">
	            <div class="new_list_img align-self-center">
	               <img src="/capstone/signD/module/images/<%=rq.getCategory()%>.jpg"
	                  alt="<%=rq.getCategory()%>">
	            </div>
	          	<div class="inline col-sm-9 align-self-center">
	               <div class="new_list_sub_top">
	                  <div class="row col-sm-12">
	                     <div class="new_list_cate align-top"><%=rq.getCategory()%>&nbsp;|&nbsp;</div>
	                     <div class="new_list_title pl-0"> <%=rq.getTitle()%>
	                       	<%if(rq.getOp_main()==1){ %><img src="/capstone/signD/module/images/like.png" width="25"><%} %>
	                     </div>
	                  </div>
	               </div>
	               <div class="row col-sm-12">
	                  <div class="mr-3"><%=rq.getCompany_name()%></div>
	                  <div class="new_list_count">
	                     <strong>&nbsp;&nbsp;조회수&nbsp;</strong><%=decimal.format(rq.getViewcount())%>명&nbsp;&nbsp;
	                  </div>
	               </div>
	            </div>
	         </div>
	         <div class="new_list_right col-sm-4 align-self-center">
	            <div class="new_list_pay">상금 : <%=decimal.format(rq.getCost() / 10000)%>만원</div>
	            <div class="new_list_day"><strong>남은기간 : </strong> <span><%=Dday%>일</span>(~<%=sdf.format(rq.getEnd_date())%>)</div>
	            <div class="new_list_day"><div class="new_iconBox inline"><strong>참여자 : </strong><%=ppcount%>명</div></div>
	         </div>
	      </div>
	   </div>
	   <script type="text/javascript">
	      $(document).ready(function() {
	         if(<%=rq.getOp_bgcolor()%>==1){
	            $(".bgcolor0<%=i%>").attr("style","background: antiquewhite");
	         }else{
	            $(".bgcolor0<%=i%>").attr("style","");
	         }
	      });
	   </script>
		<%
			}
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
				<a
					href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=request&tab2=ing"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%for (int i = startPage; i <= endPage; i++) {%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=request&tab2=ing"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%}%>
				<a
					href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=request&tab2=ing"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%}%>
			</div>
		</nav>
	</div>
	<div class="tab-pane fade" id="endRequest" role="tabpanel">
		<%
		count = rqdb.getMyRequestCount(id, "end");
			currentPage = Integer.parseInt(pageNum);
			if (!tab2.equals("end")) {
				currentPage = 1;
			}
			/* if ((count / 10) + 1 < currentPage) {
			   currentPage = count / 10 + 1;
			} */
			startRow = (currentPage - 1) * pageSize + 1;
			if (count == 0) {

				if (member.getType().equals("의뢰인")) {
	%>
		<table class="table table-borderless py-5 my-5">
			<tr><th class="text-center">마감된 콘테스트가 없습니다. 콘테스트를 개최해 주세요.</th></tr>
			<tr><td class="text-center"><a class="btn btn-outline-dark" href="../contest/designrequest/step1.jsp">개최하기</a></td></tr>
		</table>
		<%
				} else if (member.getType().equals("디자이너")) {
			%>
		<table class="table table-borderless py-5 my-5">
			<tr><th class="text-center">마감된 콘테스트가 없습니다. 콘테스트에 참여해 보세요.</th></tr>
			<tr><td class="text-center"><a class="btn btn-outline-dark" href="../contest/contestIngList.jsp">참여하기</a></td></tr>
		</table>
		<%
				}
			} else {
				rqs = rqdb.getMyRequests(id, startRow, pageSize, "end");
				for (int i = 0; i < rqs.size(); i++) {
					rq = (RequestDataBean) rqs.get(i);
					ppcount = rqdb.getPPRequestCount(rq.getRequestcode());//콘테스트 참여자수
					Dday = rqdb.getDday(rq.getRequestcode());
		%>
		<div style="position: relative; overflow: hidden;">
	      <div class="new_list_icon">
	            <%if (bmdb.getBookmarkCheck(id, rq.getRequestcode(), null) == 1) {%>
	            <div class="star" data-toggle="button" aria-pressed="true" data-rqcode="<%=rq.getRequestcode()%>">
	               <font size="5"><i class="fas fa-star"></i></font>
	            </div>
	            <%} else {%>
	            <div class="star" data-toggle="button" aria-pressed="false" data-rqcode="<%=rq.getRequestcode()%>">
	               <font size="5"><i class="far fa-star"></i></font>
	            </div>
	            <%}%>
	      </div>
	      <div class="new_list_item m-2 media row justify-content-between bgcolor1<%=i%>">
	         <div class="col-sm-8 pr-0 row align-self-center"
	            onclick="location.href='/capstone/signD/contest/detail.jsp?requestcode=<%=rq.getRequestcode()%>'">
	            <div class="new_list_img align-self-center">
	              <img <%if (rq.getPpcode() > 0) {//채택한 작품이 있다면
	                  filenames = ppdb.getParticipation(rq.getPpcode()).getFile().split(",");%>
	                  src="/capstone/fileSave/participationFile/<%=rq.getCategory() %>/<%=filenames[0] %>"
	                  <%} else {%>
	                     src="/capstone/signD/module/images/<%=rq.getCategory()%>.jpg"
	                  <%}%> alt="<%=rq.getCategory()%>">
	            </div>
	          	<div class="inline col-sm-9 align-self-center">
	               <div class="new_list_sub_top">
	                  <div class="row col-sm-12">
	                     <div class="new_list_cate align-top"><%=rq.getCategory()%>&nbsp;|&nbsp;</div>
	                     <div class="new_list_title pl-0"> <%=rq.getTitle()%>
	                       	<%if(rq.getOp_main()==1){ %><img src="/capstone/signD/module/images/like.png" width="25"><%} %>
	                     </div>
	                  </div>
	               </div>
	               <div class="row col-sm-12">
	                  <div class="mr-3"><%=rq.getCompany_name()%></div>
	                  <div class="new_list_count">
	                     <strong>&nbsp;&nbsp;조회수&nbsp;</strong><%=decimal.format(rq.getViewcount())%>명&nbsp;&nbsp;
	                  </div>
	               </div>
	            </div>
	         </div>
	         <div class="new_list_right col-sm-4 align-self-center">
	            <div class="new_list_pay"><b>상금 : </b><%=decimal.format(rq.getCost() / 10000)%>만원</div>
	            <div class="new_list_day"><b>참여기간 : </b> <%=sd.format(rq.getReg_date()) %> ~ <%=ed.format(rq.getEnd_date())%></div>
	            <div class="new_list_day"><div class="new_iconBox inline"><b>참여자 : </b><%=ppcount%>명</div></div>
	         </div>
	      </div>
	   </div>
	   <script>
	       $(document).ready(function(){	          
	            if(<%=rq.getOp_bgcolor()%>==1){
	               $(".bgcolor1<%=i%>").attr("style","background: antiquewhite");
	            }else{
	               $(".bgcolor1<%=i%>").attr("style","");
	            }
	         });
	    </script>
		<%
				}
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
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=request&tab2=end"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%for (int i = startPage; i <= endPage; i++) {%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=request&tab2=end"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%}%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=request&tab2=end"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%}%>
			</div>
		</nav>
	</div>
</div>
<%
   } else {
%>
<script type="text/javascript">
<!--
   alert('권한이 없습니다.');
   document.location.href = "/capstone/signD/main.jsp";
//-->
</script>
<%
   }
%>
