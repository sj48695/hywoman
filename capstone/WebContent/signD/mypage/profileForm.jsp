<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum="1";
	}
	int count = 0;
	int number=0;
	int currentPage = Integer.parseInt(pageNum);

	LogonDBBean Logon = LogonDBBean.getInstance();
	LogonDataBean member = Logon.getMember(id);

	RequestDBBean rqdb = RequestDBBean.getInstance();
	List<RequestDataBean> rqs;
	RequestDataBean rq;
	
	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	List<PortfolioDataBean> pflist = null;
	PortfolioDataBean pf = null;
	count = pfdb.getPortfolioCount(id);
	
	if((count/10)+1<currentPage){
		currentPage=count/10+1;
	}
	int startRow = (currentPage - 1) * pageSize + 1;
	
	pflist = pfdb.getPortfolio(id,startRow,pageSize);
	
	if (id != null) {
%>
<div>
	<h4><label class="col-sm-3 col-form-label"><i class="fas fa-angle-right fa-fw mr-1 w3-xlarge w3-text-orange"></i>프로필</label></h4>
	<p class="mx-5"><i class="fas fa-address-card fa-fw mr-3 w3-large"></i>한줄소개 : <%=member.getIntroduction()%></p>
	<p class="mx-5"><i class="fa fa-envelope fa-fw mr-3 w3-large"></i>email : <%=member.getEmail()%></p>
</div>
<div>
	<h4><label class="col-sm-3 col-form-label"><i class="fas fa-angle-right fa-fw mr-1 w3-xlarge w3-text-orange"></i>포트폴리오</label></h4>
	<div class="row">
		<%if(count==0){%>
		<div class="container">등록된 포트폴리오가 없습니다.
			<a class="btn btn-outline-dark" href="../designer/portfolioRegisterForm.jsp">등록하기</a>
		</div>		
		<%}else{
				for (int i = 0; i < pflist.size(); i++) {
					pf=(PortfolioDataBean)pflist.get(i);
					String filenames[]=pf.getFile().split(",");
					rq=rqdb.getRequest(pf.getRequestcode());
		%>
		<div class="contest-portfolio-item col-md-3">
			<div class="contest-portfolio-thumb">
				<div data-toggle="modal" data-target="#portfolio<%=i+1%>">
					<img src="../../fileSave/portfolioFile/<%if(pf.getRequestcode()!=0){%><%=rq.getCategory() %>/<%} %><%=filenames[filenames.length-1]%>" style="height: 200px">
					<div class="contest-portfolio-overlay">
						<h3><%=pf.getTitle() %></h3>
						<p class="a"><%=pf.getContents() %></p>
					</div>
				</div>
				<div class="modal fade" id="portfolio<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
					<jsp:include page="../designer/portfolioModal.jsp">
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
				}%>
		<a class="btn btn-outline-dark offset-10" href="../designer/portfolioRegisterForm.jsp">등록하기</a>
		<%
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
		<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=profile"
			class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
		<%
				for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="myPage.jsp?pageNum=<%=i%>&tab=profile"
			class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
		<%
				}
		%>
		<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=profile"
			class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
		<%
			}
		%>
	</div>
</nav>
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