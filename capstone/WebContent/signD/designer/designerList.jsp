<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%!int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   DecimalFormat price = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "디자이너 랭킹";

	String id = (String) session.getAttribute("id");
	String order = request.getParameter("order");
	if (order == null) {
		order = "";
	}
	String keyword = request.getParameter("keyword");
	if (keyword == null) {
		keyword = "";
	}
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int pfcount = 0;
	int number = 0;

	LogonDBBean logon = LogonDBBean.getInstance();
	List<LogonDataBean> designerlist = null;
	LogonDataBean designer = null;

	RequestDBBean rqdb = RequestDBBean.getInstance();
	RequestDataBean rq = null;

	BookmarkDBBean bmdb = BookmarkDBBean.getInstance();

	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	List<PortfolioDataBean> pflist = null;
	PortfolioDataBean pf = null;
	String filenames[] = null;

	count = logon.getDesignerCount(keyword);
	number = count - (currentPage - 1) * pageSize;
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param value="<%=title%>" name="title" />
</jsp:include>
   <jsp:include page="../module/menubar.jsp" flush="false" />
<div class="mbgi5">
   <section class="jumbotron text-center img-cover">
      <div class="container py-4">
         <h1 class="jumbotron-heading jumbotitle mt-5"><strong>랭킹-디자이너 보기</strong></h1>
         <p class="lead mb-5"><strong>실력있는 디자이너를 만나보세요!</strong></p>
            <div class="d3 offset-2 col-8">
            <form class="m-0" name="search" method="get" action="designerList.jsp">
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
   <div class="row dranking">
		<%
			designerlist = logon.designerListTop(1, 3);
			for (int i = 0; i < designerlist.size(); i++) {
				designer = designerlist.get(i);
		%>
		<div class="col-lg-4 text-center">
			<div class="offset-1 col-10 dsnhot">
				<img class="ranking" src="http://fiximage.10x10.co.kr/web2015/shopping/ico_best<%=i + 1%>.png" alt="BEST <%=i + 1%>"> <br>
				<img class="rounded-circle pranking" src="../../imageFile/profileImg/<%=designer.getProfileimg()%>" alt="Generic placeholder image" width="140" height="140">
				<h3><%=designer.getId()%></h3>
				<div class="new_list_right inline col-10 py-3">
					<div class="designerRanked row">
						<strong class="col-5">우승 횟수</strong>
						<div class="col-7"><%=designer.getChoosecount()%>회</div>
					</div>
					<div class="designerRanked row">
						<strong class="col-5">획득 상금</strong>
						<div class="col-7">
							<%=price.format(logon.getPrize_money(designer.getId()))%>원
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
			}
		%>
	</div>
   <div class="border-bottom p-2 row justify-content-between" style="line-height: 49px">
      <strong>디자이너 리스트</strong>
      <div class="dropdown">
         <button class="btn btn-secondary dropdown-toggle" type="button"
            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <%if(order.equals("")){%>분류<%
            }else if(order.equals("wincount")){ %>우승횟수순<%
            }else if(order.equals("prize")){%>상금순<%}%>
         </button>
         <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuButton">
            <a class="dropdown-item" href="designerList.jsp">가나다순</a>
            <a class="dropdown-item" href="designerList.jsp?order=wincount">우승 횟수순</a> 
            <a class="dropdown-item" href="designerList.jsp?order=prize">상금순</a>
         </div>
      </div>
   </div>
	<%
		if (count == 0) {
	%>
	<div class="alert alert-danger" role="alert">등록된 디자이너 리스트가 없습니다.</div>
	<%
		} else {
			designerlist = logon.getDesignerList(startRow, pageSize, keyword, order);
			for (int i = 0; i < designerlist.size(); i++) {
				designer = designerlist.get(i);
				pflist = pfdb.getPortfolio(designer.getId(), 1, 3);
				pfcount = pfdb.getPortfolioCount(designer.getId());
	%>
	<div style="position: relative; overflow: hidden;">
		<div class="new_list_icon">
			<%if (bmdb.getBookmarkCheck(id, null, designer.getId()) == 1) {%>
			<div class="star" data-toggle="button" aria-pressed="true" data-designer="<%=designer.getId()%>">
				<font size="5"><i class="fas fa-star"></i></font>
			</div>
			<%} else {%>
			<div class="star" data-toggle="button" aria-pressed="false" data-designer="<%=designer.getId()%>">
				<font size="5"><i class="far fa-star"></i></font>
			</div>
			<%}%>
		</div>
		<div class="wlItem m-2 w3-row media">
			<div class="w3-col s8 row align-self-center">
				<div class="wlImg rounded-circle align-self-center">
					<img src="../../imageFile/profileImg/<%=designer.getProfileimg()%>">
				</div>
				<div class="col-sm-9 align-self-center">
					<div class="wlpId">
						<a href="profile.jsp?designerId=<%=designer.getId()%>"><%=designer.getId()%></a>
					</div>
					<p class="title"><%=designer.getIntroduction()%></p>
					<!-- <div class="wlpCity cl_inline v_mid">
					<div class="icon cl_inline v_mid">
						<div class="onlineicon tipunder" title="1:1 의뢰 수신중"></div>
					</div>
				</div> -->
				</div>
			</div>
			<div class="w3-col s4">
				<div class="wlrTotal w3-row text-center">
					<div class="w3-col s6 w3-row">
						<strong class="w3-col s6">우승 횟수</strong>
						<div class="w3-col s6 text-right"><%=designer.getChoosecount()%>회 |	</div>
					</div>
					<div class="w3-col s6 w3-row">
						<strong class="w3-col s6">획득 상금</strong>
						<div class="w3-col s6 text-right"><%=price.format(logon.getPrize_money(designer.getId()))%>원</div>
					</div>
				</div>
				<div class="w3-row pt-4">
					<%
					if (pfcount != 0) {
						pflist = pfdb.getPortfolio(designer.getId(), 1, 3);
						for (int j = 0; j < pflist.size(); j++) {
							pf = pflist.get(j);
							filenames = pf.getFile().split(",");
							rq=rqdb.getRequest(pf.getRequestcode());
					%>
					<div class="w3-col s4" data-toggle="modal" data-target="#portfolio<%=i + 1%><%=j%>" onclick="viewCount(0,<%=pf.getPortfoliocode()%>)">
						<img class="wlrWinImgs" src="../../fileSave/participationFile/<%if (pf.getRequestcode() != 0) {%><%=rq.getCategory()%>/<%}%><%=filenames[filenames.length - 1]%>">
					</div>
					<div class="modal fade" id="portfolio<%=i + 1%><%=j%>" tabindex="-1" role="dialog" aria-hidden="true">
						<jsp:include page="portfolio/modal.jsp">
							<jsp:param value="<%=pf.getPortfoliocode()%>" name="portfoliocode" />
							<jsp:param value="<%=pf.getRequestcode()%>" name="requestcode" />
						</jsp:include>
					</div>
					<script>
					$(document).ready(function(){
						$('#portfolio<%=i+1%><%=j%>').on('shown.bs.modal', function () {
							var minheight=$("#carouselFade<%=pf.getPortfoliocode()%>").height();
							console.log(minheight);
							document.getElementById("content<%=pf.getPortfoliocode()%>").style.minHeight=minheight+"px";
						});
					});
					</script>
					<%
							}
						}
					%>
				</div>
			</div>
		</div>
	</div>
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
         <a href="designerList.jsp?pageNum=<%=startPage - 10%>&order=<%=order %>"
            class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
         <%
            for (int i = startPage; i <= endPage; i++) {
         %>
         <a href="designerList.jsp?pageNum=<%=i%>&order=<%=order %>"
            class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
         <%
            }
         %>
         <a href="designerList.jsp?pageNum=<%=startPage + 10%>&order=<%=order %>"
            class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
         <%
            }
         %>
      </div>
   </nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />