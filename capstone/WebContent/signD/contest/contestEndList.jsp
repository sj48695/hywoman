<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.member.ReplyDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="signD.contest.RequestDBBean"%>
<%@ page import="signD.contest.RequestDataBean"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!DecimalFormat decimal = new DecimalFormat("#,###");%>

<%
   int pageSize = 10;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy. MM. dd (E)");
	SimpleDateFormat ed = new SimpleDateFormat("MM. dd (E)");

   request.setCharacterEncoding("utf-8");
   String title = "랭킹-공모전";

   String id = (String) session.getAttribute("id");
   String pageNum = request.getParameter("pageNum");
   String category = request.getParameter("category");
   String keyword = request.getParameter("keyword");
   if (category == null) {
     category = "";
   }
   
   if (keyword == null) {
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
   int ppcount = 0;
   String Dday = "";
   String filenames[]=null;

   RequestDBBean rqdb = RequestDBBean.getInstance();
   List<RequestDataBean> rqlist = null;
   RequestDataBean rq = null;
   count = rqdb.getRequestCount("end", keyword,category);
   
   ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
   BookmarkDBBean bmdb = BookmarkDBBean.getInstance();
   ReplyDBBean replydb = ReplyDBBean.getInstance();
   int recount = 0;

   if (count > 0) {
      /* requests = rqdb.getRequests(startRow, pageSize,"end"); */
      rqlist = rqdb.getSearchRequests(startRow, pageSize, "end", keyword,category);
   }

   number = count - (currentPage - 1) * pageSize;
%>

<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param value="<%=title%>" name="title" />
</jsp:include>
   <jsp:include page="../module/menubar.jsp" flush="false" />

<div class="bgi8">
   <section class="jumbotron text-center img-cover">
      <div class="container py-4">
         <h1 class="jumbotron-heading jumbotitle"><strong>랭킹 - 종료된 공모전 보기</strong></h1>
         <p class="lead"><strong>종료된 공모전의 정보를 확인하세요!</strong></p>
         <p>
            <a href="contestList.jsp" class="btn btn-outline-light btn-lg my-2">진행중</a>
            <a href="contestEndList.jsp" class="btn  btn-light btn-lg my-2">종료된</a>
         </p>
         <div class="d3 offset-2 col-8">
            <form class="m-0" name="search" method="get" action="contestList.jsp">
               <div class="input-group input-group-lgs col-12">
                  <input type="text" class="form-control m-0" aria-label="Sizing input"
                     aria-describedby="inputGroup-sizing-lg" name="keyword" value="<%=keyword%>">
                  <div class="input-group-prepend">
                     <button class="btn" type="submit" id="button-addon2"></button>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </section>
</div>

<div class="container">
   <div class="row">
		<%
		rqlist = rqdb.contestListTop3("end");
	  	if(rqlist == null){
			for(int i = 0; i < 3; i++){
		%>
		<div class="col-lg-4">
			<div class="row justify-content-center">
				<div class="col-sm-12 pb-4 row justify-content-center">
					<img alt="BEST <%=i%>" class="col-sm-3"
						src="http://fiximage.10x10.co.kr/web2015/shopping/ico_best<%=i + 1%>.png">
				</div>
				<img class="col-sm-8 p-0 h-100 pointer" style="border: 1px solid #f1f1f1;"
					src="/capstone/signD/module/images/sample.jpg"
					onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
				<div class="col-sm-12 row justify-content-center" onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
					<div class="new_list_sub_top p-0">
						<div class="new_list_cate inline">
							Category
							&nbsp;|&nbsp;
						</div>
						<h1 class="new_list_title inline" style="font-size: 14px;">
							콘테스트 등록하러가기
						</h1>
					</div>
				</div>
			</div>
			<hr class="my-3">
			<div class="articleMeta py-2" onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
				<img src="/capstone/signD/module/images/view.png"/>0&nbsp;&nbsp;
				<img src="/capstone/signD/module/images/talk.png"/>0
			</div>
		</div>
	<%
			}
		}else{
	         for (int i = 0; i < rqlist.size(); i++) {
	            rq = rqlist.get(i);
	            recount = replydb.getReplyCount("requestcode", rq.getRequestcode());
	      %>
		<div class="col-lg-4">
			<div class="row justify-content-center">
				<div class="col-sm-12 pb-4 row justify-content-center">
					<img class="col-sm-3" alt="BEST <%=i + 1%>"
						src="http://fiximage.10x10.co.kr/web2015/shopping/ico_best<%=i + 1%>.png">
				</div>
				<img 
				<%if (rq.getPpcode() > 0) {//채택한 작품이 있다면
					filenames = ppdb.getParticipation(rq.getPpcode()).getFile().split(",");%>
					src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[0]%>"
				<%} else {%>
					src="/capstone/signD/module/images/<%=rq.getCategory()%>.jpg" 
				<%}%>
					
					alt="<%=rq.getCategory()%>"
					onclick="location.href='requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'"
					class="col-sm-8 p-0 pointer" style="width:253.33px; height:253.33px; border: 1px solid #f1f1f1;">
				<div class="col-sm-12 row justify-content-center" onclick="location.href='requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
					<div class="new_list_sub_top p-0">
						<div class="new_list_cate inline">
							<%=rq.getCategory()%>
							&nbsp;|&nbsp;
						</div>
						<h1 class="new_list_title inline" style="font-size: 14px;">
							<%=rq.getTitle()%>
						</h1>
					</div>
				</div>
			</div>
			<hr class="my-3">
			<div class="articleMeta" onclick="location.href='requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
				<img src="/capstone/signD/module/images/view.png" /><%=rq.getViewcount()%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
				<img src="/capstone/signD/module/images/talk.png" /><%=recount%>
			</div>
		</div>
			<%
				}
	         	for (int i = 0; i < 3-rqlist.size(); i++) {
     		%>
   		<div class="col-lg-4">
   			<div class="row justify-content-center">
   				<div class="col-sm-12 pb-4 row justify-content-center">
   					<img alt="BEST <%=i%>" class="col-sm-3"
   						src="http://fiximage.10x10.co.kr/web2015/shopping/ico_best<%=i + 1%>.png">
   				</div>
   				<img class="col-sm-8 p-0 h-100 pointer" style=" border: 1px solid #f1f1f1;"
   					src="/capstone/signD/module/images/sample.jpg"
   					onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
   				<div class="col-sm-12 row justify-content-center" onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
   					<div class="new_list_sub_top p-0">
   						<div class="new_list_cate inline">
   							Category
   							&nbsp;|&nbsp;
   						</div>
   						<h1 class="new_list_title inline" style="font-size: 14px;">
   							콘테스트 등록하러가기
   						</h1>
   					</div>
   				</div>
   			</div>
   			<hr class="my-3">
   			<div class="articleMeta py-2" onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
   				<img src="/capstone/signD/module/images/view.png"/>0&nbsp;&nbsp;
   				<img src="/capstone/signD/module/images/talk.png"/>0
   			</div>
   		</div>
	     		<%
   				}
			}
		%>
   </div>
</div>
<br>
<br>

<div class="container footerbottom">
 	<div class="border-bottom p-2 row justify-content-between" style="line-height: 49px;">
      <b>종료된 공모전</b>
      <div class="dropdown">
         <button class="btn btn-secondary dropdown-toggle" type="button"
            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            	<%if(category.equals("")){%>전체<%
            	}else if(category.equals("logo")){%>로고<%
            	}else if(category.equals("package")){ %>패키지<%
                }else if(category.equals("web")){ %>웹<%
                }else if(category.equals("other")){ %>기타<%}%>
            </button>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="contestEndList.jsp">전체</a>
            <a class="dropdown-item" href="contestEndList.jsp?category=logo">로고</a> 
            <a class="dropdown-item" href="contestEndList.jsp?category=package">패키지</a>      
            <a class="dropdown-item" href="contestEndList.jsp?category=web">웹</a>
            <a class="dropdown-item" href="contestEndList.jsp?category=other">기타</a>
         </div>
      </div>
   </div>
   <%
      if (count == 0) {
   %>
	<div class="row justify-content-center py-5" role="alert"><span>등록된 콘테스트가 없습니다.</span></div>
   <%
      } else {
         rqlist = rqdb.getSearchRequests(startRow, pageSize, "end", keyword,category);
         for (int i = 0; i < rqlist.size(); i++) {
            rq = rqlist.get(i);
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
      <div class="new_list_item m-2 media row justify-content-between bgcolor<%=i%>">
         <div class="col-sm-8 pr-0 row align-self-center"
            onclick="location.href='requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
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
                     <div class="new_list_title col-sm-9 pl-0"> <%=rq.getTitle()%>
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
               $(".bgcolor<%=i%>").attr("style","background: antiquewhite");
            }else{
               $(".bgcolor<%=i%>").attr("style","");
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
         <a href="contestEndList.jsp?pageNum=<%=startPage - 10%>&keyword=<%=keyword %>"
            class="w3-button w3-hover-black<%if (startPage > 10) {
            } else {%> disabled<%}%>"><<</a>
         <%
            for (int i = startPage; i <= endPage; i++) {
               if(!category.equals("")){%>
               <a href="contestEndList.jsp?category=<%=rq.getCategory()%>&pageNum=<%=i%>&keyword=<%=keyword %>"
                      class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
            <%}else{ %>
               <a href="contestEndList.jsp?pageNum=<%=i%>&keyword=<%=keyword %>"
                  class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
            <%}
            }
         %>
         <a href="contestEndList.jsp?pageNum=<%=startPage + 10%>&keyword=<%=keyword %>"
            class="w3-button w3-hover-black<%if (endPage < pageCount) {
            } else {%> disabled<%}%>">>></a>
         <%
            }
         %>
      </div>
   </nav>
</div>
<jsp:include page="../module/bottom.jsp" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />