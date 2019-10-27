<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	if(id==null){id="";}
    int pfcode=Integer.parseInt(request.getParameter("portfoliocode"));
    int rqcode=Integer.parseInt(request.getParameter("requestcode"));
	//String requesterId=request.getParameter("requesterId");
	
	LogonDBBean logon= LogonDBBean.getInstance();
	
    PortfolioDBBean pfdb=PortfolioDBBean.getInstance();
	PortfolioDataBean pf=pfdb.getPortfolio(pfcode);
	
	RequestDBBean rqdb=RequestDBBean.getInstance();
	RequestDataBean rq = rqdb.getRequest(rqcode);
	

	String Dday=rqdb.getDday(rqcode);
	String filenames[]=pf.getFile().split(",");
    
    %>
<div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width:1000px">
	<div class="modal-content">
		<div class="modal-body p-0">
			<div class="media row">
				<div id="carouselFade<%=pfcode %>" class="carousel slide pr-0 carousel-fade col-md-8 align-self-center" data-ride="carousel">
					<ol class="carousel-indicators">
				<%
					if(filenames.length>1){
						for (int j = 0; j < filenames.length ; j++) {
				%>
						<li data-target="#carouselFade<%=pfcode%>" data-slide-to="<%=j %>" <%if(j==0){%>class="active"<%} %>></li>
				<%
						}
					}
				%>
					</ol>
					<div class="carousel-inner" >
						<div class="carousel-item active">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%if(rqcode!=0){%><%=rq.getCategory() %>/<%} %><%=filenames[filenames.length-1]%>">
						</div>
				<%
					for (int j = filenames.length - 1; j > 0; j--) {
				%>
						<div class="carousel-item middle">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%if(rqcode!=0){%><%=rq.getCategory() %>/<%} %><%=filenames[j - 1]%>">
						</div>
				<%
					}
				%>
					</div>
				<%
					if (filenames.length > 1) {
				%>
					<a class="carousel-control-prev" href="#carouselFade<%=pfcode%>" role="button" data-slide="prev"> 
						<i class="fas fa-angle-left"></i>
						<span class="sr-only">Previous</span>
					</a> 
					<a class="carousel-control-next" href="#carouselFade<%=pfcode%>" role="button" data-slide="next"> 
						<i class="fas fa-angle-right"></i>
						<span class="sr-only">Next</span>
					</a>
				<%
					}
				%>
				</div>
				<div class="col-md-4 pl-3" id="content<%=pfcode%>" style="background-color: #e9ecef;">
					<h4 class="py-4 m-0">
						<%
							if (rqcode == 0) {
						%><%=pf.getTitle()%>
						<%
							} else {
						%>
						<a href="/capstone/signD/contest/detail.jsp?requestcode=<%=rqcode%>"><%=pf.getTitle()%></a>
						<%	} %>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</h4>
					<div class="row pl-4 pb-2">
						<img src="/capstone/imageFile/profileImg/<%=logon.getMember(pf.getId()).getProfileimg()%>" class="rounded-circle" style="width: 50px; height: 50px">
						<div class="col-md-8">
							<strong><a href="/capstone/signD/designer/profile.jsp?designerId=<%=pf.getId() %>"><%=pf.getId() %></a></strong>
							<br><div class="py-1"><strong>우승횟수 <%=logon.getMember(pf.getId()).getChoosecount() %>회	|	조회수 <%=pf.getViewcount() %>회</strong></div>
						</div>
					</div>
					<div class="mr-3 mt-2 mb-5" style="height: 430px; border-top:1px solid #BDBDBD;">
						<textarea class="form-control p-2 p-0" cols="20" rows="15" disabled="disabled"
							style="border:none; background-color: #e9ecef;"><%=pf.getContents()%></textarea>
					</div>
					<div class="pr-4 p-3" aria-pressed="false">
						<%
							if (id.equals(pf.getId())) {//마감 전 수정, 삭제 가능
						%>
						<button onclick="location.href='/capstone/signD/designer/portfolio/updateForm.jsp?pfcode=<%=pf.getPortfoliocode()%>&rqcode=<%=rqcode%>'"
							class="btn btnOr offset-1 col-md-5">수정하기</button> 
						<button onclick="deleteCheck('/capstone/signD/designer/portfolio/delPro.jsp?pfcode=<%=pf.getPortfoliocode()%>&rqcode=<%=rqcode%>')"
							class="btn col-md-5" style="background-color: darkgray; color: white;">삭제하기</button>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>