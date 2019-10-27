<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="java.util.List"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!int pageSize = 16;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	DecimalFormat price = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "디자이너 프로필 | DO";
	String id = (String) session.getAttribute("id");
	String designerId = request.getParameter("designerId");
	String pageNum = request.getParameter("pageNum");
	String tab = request.getParameter("tab");

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean designer = logon.getMember(designerId);

	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	List<PortfolioDataBean> pflist =null;
	PortfolioDataBean pf = null;
	
	RequestDBBean rqdb = RequestDBBean.getInstance();
	RequestDataBean rq = null;

	BookmarkDBBean bmdb = BookmarkDBBean.getInstance();
	int bmcheck = bmdb.getBookmarkCheck(id, null, designer.getId());

	if (pageNum == null) {
		pageNum = "1";
	}
	int count = 0;
	int number = 0;
	int currentPage = Integer.parseInt(pageNum);

	count = pfdb.getPortfolioCount(designerId);
	if ((count / 10) + 1 < currentPage) {
		currentPage = count / 10 + 1;
	}
	int startRow = (currentPage - 1) * pageSize + 1;

	number = count - (currentPage - 1) * pageSize;
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
<div style="padding-bottom: 80px">
	<jsp:include page="../module/menubar.jsp" flush="false"/>
</div>
<div class="container">
	<div style="position: relative; overflow: hidden;">
		<div class="new_list_icon">
            <%if (bmcheck == 1) {%>
            <div class="star" data-toggle="button" aria-pressed="true" data-designer="<%=designer.getId()%>">
               <font size="5"><i class="fas fa-star"></i></font>
            </div>
            <%} else {%>
            <div class="star" data-toggle="button" aria-pressed="false" data-designer="<%=designer.getId()%>">
               <font size="5"><i class="far fa-star"></i></font>
            </div>
            <%}%>
		</div>
		<div class="wlItem row p-3 m-2 media" >
			<div class="col-md-2 align-self-center">
				<img src="../../imageFile/profileImg/<%=designer.getProfileimg()%>" class="rounded-circle" style="width: 100px; height: 100px">
			</div>
			<div class="col-md-10 align-self-center">
				<div>
					<b><%=designer.getName()%>(<%=designer.getId()%>)</b>님	|	<%=designer.getType()%>
					<font size="5"><i class="far fa-envelope" data-toggle="modal" data-target="#send"></i></font>
					<div class="modal fade" id="send" tabindex="-1" role="dialog" aria-hidden="true">
						<jsp:include page="../mypage/message/sendForm.jsp" flush="false">
							<jsp:param value="<%=designer.getId()%>" name="to_id"/>
						</jsp:include>
					</div>
				<br>
				<%if (designer.getType().equals("디자이너")) {%>
					우승횟수 <%=designer.getChoosecount() %>회 | 우승상금 <%=price.format(logon.getPrize_money(designer.getId()))%>원
				<%}%>
				</div>
				<br>
				<div>
					<%=designer.getIntroduction()%>
					<div class="row justify-content-end always">
					<%
						if (designer.getId().equals(id)) {
							if (designer.getOp_onetoone() == 1) {
					%>
						<button class="btn btnOr" onclick="always(0)">1:1의뢰 항상 수락</button>
						<%} else {%>
						<button class="btn" onclick="always(1)">1:1의뢰 항상 거절</button>
					<%		}
						} else {
							if (designer.getOp_onetoone() == 1) {
					%>
						<button class="btn btnOr" 
							onclick="location.href='/capstone/signD/otorequest/step1.jsp?designerId=<%=designerId%>'">1:1의뢰하기</button>
						<%	}else{%>
						<button class="btn btnOr col-sm-3 disabled">1:1의뢰를 거절한 디자이너 입니다.</button>
					<%
							}
						}
					%>
					</div>
				</div>
			</div>
		</div>
	</div>
	<hr>
	<div class="py-3">
		<h4><label class="col-sm-3 col-form-label"><i class="fas fa-angle-right fa-fw mr-1 w3-xlarge w3-text-orange"></i>프로필</label></h4>
		<p class="mx-5"><i class="fas fa-address-card fa-fw mr-3 w3-large"></i>한줄소개 : <%=designer.getIntroduction()%></p>
		<p class="mx-5"><i class="fa fa-envelope fa-fw mr-3 w3-large"></i>email : <%=designer.getEmail()%></p>
	</div>
	<div class="py-3">
		<h4><label class="col-sm-3 col-form-label"><i class="fas fa-angle-right fa-fw mr-1 w3-xlarge w3-text-orange"></i>포트폴리오</label></h4>
		<div class="row">
			<%
				if(count==0){
					%>
			<div class="container">등록된 포트폴리오가 없습니다.</div>		
					<%
				}else{

					pflist = pfdb.getPortfolio(designerId,startRow,pageSize);
					for (int i = 0; i < pflist.size(); i++) {
						pf=(PortfolioDataBean)pflist.get(i);
						String filenames[]=pf.getFile().split(",");
						rq=rqdb.getRequest(pf.getRequestcode());
			%>
			<div class="contest-portfolio-item col-md-3">
				<div class="contest-portfolio-thumb">
					<div data-toggle="modal" data-target="#portfolio<%=i+1%>" onclick="viewCount(0,<%=pf.getPortfoliocode()%>)">
						<img src="../../fileSave/participationFile/<%if(pf.getRequestcode()!=0){%><%=rq.getCategory() %>/<%} %><%=filenames[filenames.length-1]%>" style="height: 200px">
						<div class="contest-portfolio-overlay">
							<h3><%=pf.getTitle() %></h3>
							<p class="a"><%=pf.getContents() %></p>
							<!-- <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand"> -->
							<!-- <i class="fa fa-search"></i> -->
						</div>
					</div>
					<div class="modal fade" id="portfolio<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
						<jsp:include page="../designer/portfolio/modal.jsp">
							<jsp:param value="<%=pf.getPortfoliocode() %>" name="portfoliocode"/>
							<jsp:param value="<%=pf.getRequestcode() %>" name="requestcode"/>
						</jsp:include>
					</div>
				</div>
				<div class="con_title"><b><%=pf.getTitle()%></b></div>
			</div>
			<script>
			$(document).ready(function(){
				$('#portfolio<%=i+1%>').on('shown.bs.modal', function () {
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
			<a href="profile.jsp?pageNum=<%=startPage - 10%>"
				class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="profile.jsp?pageNum=<%=i%>"
				class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
			<%
				}
			%>
			<a href="profile.jsp?pageNum=<%=startPage + 10%>"
				class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
			<%
				}
			%>
		</div>
	</nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false"/>
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />