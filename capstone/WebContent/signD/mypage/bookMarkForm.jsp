<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.BookmarkDataBean"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%!DecimalFormat decimal = new DecimalFormat("#,###");
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	SimpleDateFormat sd = new SimpleDateFormat("yyyy. MM. dd (E)");
	SimpleDateFormat ed = new SimpleDateFormat("MM. dd (E)");
	%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum="1";
	}
	String tab2 = request.getParameter("tab2");
	if(tab2==null){
		tab2="";
	}
	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);
	LogonDataBean designer;

	RequestDBBean rqdb=RequestDBBean.getInstance();
	RequestDataBean rq;
	
	BookmarkDBBean bmdb = BookmarkDBBean.getInstance();
	List<RequestDataBean> rqlist = null;
	List<LogonDataBean> designerlist = null;
	
	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();

	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	List<PortfolioDataBean> pflist = null;
	PortfolioDataBean pf=null;
	int pfcount=0;	
	String filenames[]=null;

	int count = 0;
	int number = 0;
	int ppcount = 0;
	int startRow=0;
	int check = 0;
	int currentPage = Integer.parseInt(pageNum);
	String Dday = "";


	if (id != null) {
		
%>

<nav class="navbar row justify-content-end">
	<div class="btn-group btn-group-toggle col-sm-3" data-toggle="buttons">
		<ul class="nav nav-tabs nav-pills" id="pills-tab" role="tablist">
			<li class="nav-item">
				<a class="nav-link btn-outline-dark active" data-toggle="tab" href="#contestBM" role="tab" id="contest"
					aria-controls="contestBM" aria-selected="true" onclick="tab2Change('bookmark','contest');">콘테스트</a>
			</li>
			<li class="nav-item">
				<a class="nav-link btn-outline-dark" data-toggle="tab" href="#designerBM" role="tab" id="designer"
					aria-controls="designerBM" aria-selected="false" onclick="tab2Change('bookmark','designer');">디자이너</a>
			</li>
		</ul>
	</div>
</nav>

<div class="tab-content" id="pills-tabContent">
	<div class="tab-pane fade show active" id="contestBM" role="tabpanel" aria-labelledby="contest-tab">
		<%
		count = bmdb.getRequestBmCount(id);
		currentPage = Integer.parseInt(pageNum);
		if(!tab2.equals("contest")){
			currentPage=1;
		}/* if ((count / 10) + 1 < currentPage) {
			currentPage = count / 10 + 1;
		} */
		 startRow = (currentPage - 1) * pageSize + 1;
		if (count==0) {
		%>
		<table class="table ">
			<tr class="text-center">
				<th colspan="5" class="py-5">즐겨찾기한 콘테스트가 없습니다.</th>
			</tr>
		</table>
		<%
		} else {
			rqlist = bmdb.getRequestBm(id);
			for (int i = 0; i < rqlist.size(); i++) {
				rq=rqlist.get(i);
				ppcount=rqdb.getPPRequestCount(rq.getRequestcode());//콘테스트 참여자수
				Dday=rqdb.getDday(rq.getRequestcode());

		%>
		<div style="position: relative; overflow: hidden;">
	      <div class="new_list_icon">
	            <%if (bmdb.getBookmarkCheck(id, rq.getRequestcode(), null) == 1) {%>
	            <div data-toggle="button" aria-pressed="true" id="star<%=i%>">
	               <font size="5"><i class="fas fa-star"></i></font>
	            </div>
	            <%} else {%>
	            <div data-toggle="button" aria-pressed="false" id="star<%=i%>">
	               <font size="5"><i class="far fa-star"></i></font>
	            </div>
	            <%}%>
	      </div>
	      <div class="new_list_item m-2 media row justify-content-between bgcolor<%=i%>">
	         <div class="col-sm-8 pr-0 row align-self-center"
	            onclick="location.href='/capstone/signD/contest/requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
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
	            <div class="new_list_pay">상금 : <%=decimal.format(rq.getCost() / 10000)%>만원</div>
				<div class="new_list_day"><b>참여기간 : </b> <%=sd.format(rq.getReg_date()) %> ~ <%=ed.format(rq.getEnd_date())%></div>
				<div class="new_list_day"><div class="new_iconBox inline"><strong>참여자 : </strong><%=ppcount%>명</div></div>
	         </div>
	      </div>
	   </div>
	   <script type="text/javascript">
	      $(document).ready(function() {
	         $("#star<%=i%>").click(function(){
	            bmCheck("<%=i%>",<%=rq.getRequestcode()%>,null,"<%=id%>");
	          });
	         
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
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=bookmark&tab2=contest"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=bookmark&tab2=contest"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=bookmark&tab2=contest"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
			</div>
		</nav>
	</div>
	<div class="tab-pane fade" id="designerBM" role="tabpanel" aria-labelledby="designer-tab">
	<%
		count = bmdb.getDesignerBmCount(id);
		currentPage = Integer.parseInt(pageNum);
		if(!tab2.equals("designer")){
			currentPage=1;
		}
		/* if ((count / 10) + 1 < currentPage) {
			currentPage = count / 10 + 1;
		} */
		 startRow = (currentPage - 1) * pageSize + 1;
		if (count==0) {
	%>
		<table class="table">
			<tr class="text-center">
				<th colspan="5" class="py-5">즐겨찾기한 디자이너가 없습니다.</th>
			</tr>
		</table>
	<%
		} else {
			designerlist = bmdb.getDesignerBm(id);
			for (int i = 0; i < designerlist.size(); i++) {
				designer=designerlist.get(i);
				pfcount=pfdb.getPortfolioCount(designer.getId());
	%>
		<div style="position: relative; overflow: hidden;">
			<div class="new_list_icon">
				<%if (bmdb.getBookmarkCheck(id, null, designer.getId()) == 1) {%>
				<div class="offset-2 col-1" data-toggle="button" aria-pressed="true" id="star<%=i%>">
					<font size="5"><i class="fas fa-star"></i></font>
				</div>
				<%} else {%>
				<div class="offset-2 col-1" data-toggle="button" aria-pressed="false" id="star<%=i%>">
					<font size="5"><i class="far fa-star"></i></font>
				</div>
				<%}%>
				<script>
	                  $("#star<%=i%>").click(function(){
	                     bmCheck("<%=i%>",null,"<%=designer.getId()%>","<%=id%>");
					});
				</script>
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
							<div class="w3-col s6 text-right"><%=decimal.format(logon.getPrize_money(designer.getId()))%>원</div>
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
							<img class="wlrWinImgs" src="../../fileSave/portfolioFile/<%if (pf.getRequestcode() != 0) {%><%=rq.getCategory()%>/<%}%><%=filenames[filenames.length - 1]%>">
						</div>
						<div class="modal fade" id="portfolio<%=i + 1%><%=j%>" tabindex="-1" role="dialog" aria-hidden="true">
							<jsp:include page="../designer/portfolioModal.jsp">
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
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=bookmark&tab2=designer"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=bookmark&tab2=designer"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=bookmark&tab2=designer"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
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