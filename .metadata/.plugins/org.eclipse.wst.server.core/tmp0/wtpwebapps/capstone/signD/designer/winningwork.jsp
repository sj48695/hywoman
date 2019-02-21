
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	int pageSize=16; 

	request.setCharacterEncoding("utf-8");
	String title = "콘테스트 우승작 | DO";
	
	String id = (String) session.getAttribute("id");
	String category = request.getParameter("category");
	if (category == null) {category = "";}
	String job_kind = request.getParameter("job_kind");
	if (job_kind == null) {job_kind = "";}
	String order = request.getParameter("order");
	if (order == null) {order = "";}
	String keyword = request.getParameter("keyword");
	if (keyword == null) {keyword = "";}
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {pageNum = "1";}

	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;

	RequestDBBean rqdb = RequestDBBean.getInstance();
	RequestDataBean rq = null;

	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();   
	List<ParticipationDataBean> pplist = ppdb.getParticipation(startRow, pageSize, category, keyword, job_kind, order);
	ParticipationDataBean pp = null;
	
	count = ppdb.getParticipationsCount(category,keyword,job_kind,order);
%>
<jsp:include page="/_layout/header.inc.jsp"  flush="false">
   <jsp:param  name="title" value="<%=title %>"/>
</jsp:include>
<div style="padding-bottom: 50px">
	<jsp:include page="../module/menubar.jsp" flush="false" />
</div>

<div class="pf_nav_wrap text-center">
	<ul class="pf_nav">
		<li class="active"><a href="winningwork.jsp">콘테스트 우승작</a></li>
		<li><a href="designerportfolio.jsp">디자이너 포트폴리오</a></li>
	</ul>
</div>
<div class="container py-4">
	<form class="form-inline row justify-content-between" method="post"
		action="winningwork.jsp?category=<%=category%>&job_kind=<%=job_kind%>&order=<%=order%>">
		<div>
			<div class="btn-group">
				<button type="button" class="btn dropdown_pf dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<%if (category.equals("")) {%>전체카테고리<%
					} else if (category.equals("logo")) {%>로고<%
					} else if (category.equals("package")) {%>패키지<%
					} else if (category.equals("web")) {%>웹<%
					} else if (category.equals("other")) {%>기타<%}%>
				</button>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="winningwork.jsp?job_kind=<%=job_kind%>&order=<%=order%>">전체카테고리</a>
					<a class="dropdown-item" href="winningwork.jsp?category=logo&job_kind=<%=job_kind%>&order=<%=order%>">로고</a>
					<a class="dropdown-item" href="winningwork.jsp?category=package&job_kind=<%=job_kind%>&order=<%=order%>">패키지</a>
					<a class="dropdown-item" href="winningwork.jsp?category=web&job_kind=<%=job_kind%>&order=<%=order%>">웹</a>
					<a class="dropdown-item" href="winningwork.jsp?category=other&job_kind=<%=job_kind%>&order=<%=order%>">기타</a>
				</div>
			</div>
			<div class="btn-group">
				<button type="button" class="btn dropdown_pf dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<%if (job_kind.equals("")) {%>전체업종<%
					} else if (job_kind.equals("식당/카페")) {%>식당/카페<%
					} else if (job_kind.equals("식품/건강")) {%>식품/건강<%
					} else if (job_kind.equals("IT/미디어")) {%>IT/미디어<%
					} else if (job_kind.equals("뷰티/패션")) {%>뷰티/패션<%
					} else if (job_kind.equals("병원")) {%>병원<%
					} else if (job_kind.equals("애완동물")) {%>애완동물<%
					} else if (job_kind.equals("교육/육아")) {%>교육/육아<%
					} else if (job_kind.equals("공공기관")) {%>공공기관<%
					} else if (job_kind.equals("일반/기타")) {%>일반/기타<%}%>
				</button>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="winningwork.jsp?category=<%=category%>&order=<%=order%>">전체업종</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=식당/카페&category=<%=category%>&order=<%=order%>">식당/카페</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=식품/건강&category=<%=category%>&order=<%=order%>">식품/건강</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=IT/미디어&category=<%=category%>&order=<%=order%>">IT/미디어</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=뷰티/패션&category=<%=category%>&order=<%=order%>">뷰티/패션</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=병원&category=<%=category%>&order=<%=order%>">병원</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=애완동물&category=<%=category%>&order=<%=order%>">애완동물</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=교육/육아&category=<%=category%>&order=<%=order%>">교육/육아</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=공공기관&category=<%=category%>&order=<%=order%>">공공기관</a>
					<a class="dropdown-item" href="winningwork.jsp?job_kind=일반/기타&category=<%=category%>&order=<%=order%>">일반/기타</a>
				</div>
			</div>
			<div class="btn-group">
				<button type="button" class="btn dropdown_pf dropdown-toggle"
					data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					<% if (order.equals("")) { %>최신순<%
					} else if (order.equals("participant")) { %>참여자순<%
					} else if (order.equals("prize_money")) { %>상금순<%
					} else if (order.equals("viewcount")) { %>조회순<% } %>
				</button>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="winningwork.jsp?job_kind=<%=job_kind%>&category=<%=category%>">최신순</a>
					<a class="dropdown-item" href="winningwork.jsp?order=prize_money&job_kind=<%=job_kind%>&category=<%=category%>">상금순</a>
					<a class="dropdown-item" href="winningwork.jsp?order=viewcount&job_kind=<%=job_kind%>&category=<%=category%>">조회순</a>
				</div>
			</div>
		</div>
		<!-- 검색 -->
		<div class="search_pf">
			<input type="text" name="keyword" placeholder="검색어 입력" value="<%=keyword%>">
			<button type="submit"></button>
		</div>
	</form>
</div>
<div class="container"><!-- 
   <div class="row">
       <div class="heading-section col-md-12 text-center py-3">
           <h2>콘테스트 우승작</h2>
           <p>콘테스트 우승작을 확인해보세요!</p>
       </div>
   </div> -->
   <div class="row">
	<%
		if (count == 0) {
	%>
		<div class="container">등록된 포트폴리오가 없습니다.</div>
	<%
		} else {
			for (int i = 0; i < pplist.size(); i++) {
				pp = (ParticipationDataBean) pplist.get(i);
				rq=rqdb.getRequest(pp.getRequestcode());
				String filenames[]=pp.getFile().split(",");
	%>
		<div class="contest-portfolio-item col-md-3">
			<div class="contest-portfolio-thumb">
				<div data-toggle="modal" data-target="#participationDetail<%=i+1%>" onclick="viewCount(<%=pp.getPpcode()%>,0)">
					<img src="../../fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[filenames.length-1]%>" style="height: 200px;">
					<div class="contest-portfolio-overlay">
						<h3><%=pp.getTitle() %></h3>
						<p class="a"><%=pp.getContents() %></p>
					</div>
				</div>
				<div class="modal fade" id="participationDetail<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
					<jsp:include page="../designer/participationModal.jsp">
						<jsp:param value="<%=pp.getPpcode() %>" name="participationcode"/>
						<jsp:param value="<%=pp.getRequestcode() %>" name="requestcode"/>
						<jsp:param value="<%=rq.getId() %>" name="requesterId"/>
					</jsp:include>
				</div>
			</div>
			<div class="con_title"><b><%=pp.getTitle()%></b> </div>
		</div>
		<script>
		$(document).ready(function(){
			$('#participationDetail<%=i+1%>').on('shown.bs.modal', function () {
				var minheight=$("#carouselFade<%=pp.getPpcode()%>").height();
				console.log(minheight);
				document.getElementById("content<%=pp.getPpcode()%>").style.minHeight=minheight+"px";
			});
		});
		</script>
		<%
			}
		}
		%>
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
			<a href="winningwork.jsp?pageNum=<%=startPage - 10%>&category=<%=category %>&job_kind=<%=job_kind %>&order=<%=order %>"
				class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
			<%
				for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="winningwork.jsp?pageNum=<%=i%>&category=<%=category %>&job_kind=<%=job_kind %>&order=<%=order %>"
				class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
			<%
				}
			%>
			<a href="winningwork.jsp?pageNum=<%=startPage + 10%>&category=<%=category %>&job_kind=<%=job_kind %>&order=<%=order %>"
				class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
			<%
				}
			%>
		</div>
	</nav>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" /> 
<jsp:include page="/_layout/footer.inc.jsp" flush="false"/>