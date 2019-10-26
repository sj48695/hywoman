<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="java.util.List"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%!DecimalFormat price = new DecimalFormat("#,###");%>
<%
   request.setCharacterEncoding("utf-8");
   String title = "DO";
   String id=(String)session.getAttribute("id");
   String keyword=request.getParameter("keyword");
   if (keyword==null){
      keyword="";
   }
   
   LogonDBBean logon=LogonDBBean.getInstance();
   /* List<LogonDataBean> designerlist=logon.getDesignerList(1, 5, keyword,""); */
   List<LogonDataBean> designerlist=null;
   LogonDataBean designer=null;

   PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
   List<PortfolioDataBean> pflist = pfdb.getPortfolios(1,8,"");
   PortfolioDataBean portfolio = null;
   int pfcount=pfdb.getPortfoliosCount("");
   
   RequestDBBean rqdb = RequestDBBean.getInstance();
   List<RequestDataBean> rqlist=null;
   RequestDataBean rq=null;
   String dday=null;
%>

<jsp:include page="/_layout/header.inc.jsp"  flush="false">
   <jsp:param  name="title" value="<%=title %>"/>
</jsp:include>
<jsp:include page="module/menubar.jsp" flush="false">
   <jsp:param value="<%=id %>" name="id"/>
</jsp:include>
<style>
   .carousel-item {
      height: 33rem;
      background-color: #fff;
   }
</style>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script>
        jQuery(document).ready(function($) {
            $('.counter').counterUp({
                delay: 10,
                time: 1000
            });
        });
</script> 
   <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
          <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
          <li data-target="#myCarousel" data-slide-to="1"></li>
          <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
          <div class="carousel-item active text-center">
            <img class="first-slide carousel_img" src="module/images/phon.png" alt="First slide">
            <!-- <div class="container">
              <div class="carousel-caption text-left">
                <h1>Example headline.</h1>
                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
              </div>
            </div> -->
          </div>
          <div class="carousel-item text-center">
            <img class="second-slide carousel_img" src="module/images/mh.png" " alt="Second slide">
            <!-- <div class="container">
              <div class="carousel-caption">
                <h1>Another example headline.</h1>
                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
              </div>
            </div> -->
          </div>
          <div class="carousel-item text-center">
            <img class="third-slide carousel_img" src="module/images/carousel3.png" alt="Third slide">
            <!-- <div class="container">
              <div class="carousel-caption text-right" style="color:#000;">
                <h2>SK 텔레콤</h2>
                <p>상금: 200만원</p>
                <p><a class="btn btn-lg btn-dark" href="#" role="button">우승작 보기</a></p>
              </div>
            </div> -->
          </div>
        </div>
        <a class="carousel-control-prev " href="#myCarousel" role="button" data-slide="prev">
          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
          <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
          <span class="carousel-control-next-icon" aria-hidden="true"></span>
          <span class="sr-only">Next</span>
        </a>
      </div>
      
      <div style="background-color: #eee;">
   <div class="container">
      <div class="middle_box py-5">
         <p><span style="font-size: 25px;"><img src="module/images/prize-trophy.png" style="width:40px;"> 
             콘테스트 누적상금액<span class="counter"><%=price.format(logon.getTotalPrize_money()) %></span></p>
         </span>
      </div>
   </div>
</div>
<script src="//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
<script src="/capstone/assets/Counter-Up-master/jquery.counterup.min.js"></script>
<div class="top_contest">
<div class="container">
<div><p class="top_contest_font">인기 콘테스트</p></div>
<div class="container py-5">
   <div class="row" style="/* flex-wrap: inherit; */">
      <%
         rqlist = rqdb.contestMain4();
         if (rqdb.contestMain4Count() != 0) {
            for (int i = 0; i < rqlist.size(); i++) {
               rq = rqlist.get(i);
      %>
      <div class="col-md-3 pointer" onclick="location.href='/capstone/signD/contest/requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
         <div class="card mb-4 shadow-sm">
            <div class="card_effect">
               <img class="card-img-top" src="/capstone/signD/module/images/<%=rq.getCategory() %>.jpg" alt="Card image cap">
            </div>
            <div class="card-body">
               <h6 class="ellipsis"><span class="badge badge-secondary"><%=rq.getCategory() %></span><%=rq.getTitle() %></h6>
               <p class="card-text ellipsis3"><%=rq.getRequest() %></p>
            </div>
         </div>
      </div>
      <%
            }
            for(int i = 0; i < 4-rqlist.size(); i++){
      %>
      <div class="col-md-3 pointer"  onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
         <div class="card mb-4 shadow-sm">
            <div class="card_effect">
               <img class="card-img-top" src="/capstone/signD/module/images/+.png" alt="Card image cap">
            </div>
            <div class="card-body">
               <p class="card-text ellipsis3">콘테스트 의뢰하러가기</p>
            </div>
         </div>
      </div>
      <%
            }
         } else {
            for (int i = 0; i < 4; i++) {
      %>
      <div class="col-md-3 pointer"  onclick="location.href='/capstone/signD/contest/designRequest1.jsp'">
         <div class="card mb-4 shadow-sm">
            <div class="card_effect">
               <img class="card-img-top" src="/capstone/signD/module/images/sample.jpg" alt="Card image cap">
            </div>
            <div class="card-body">
               <p class="card-text ellipsis3">콘테스트 의뢰하러가기</p>
            </div>
         </div>
      </div>
      <%
            }
         }
      %>
   </div>
</div>
</div>
</div>
      
      
<div class="client_box" style="background-color: #eee;">
   <div class="container">
      <div><p class="client_font">콘테스트 진행중</p></div>
      <div class="contest_content row py-2">
         <div class="col-sm-6">
            <div class="contest_category">
               <span style="text-align: center;"><img src="module/images/stopwatch.png" style="width:20px;"> 마감임박 콘테스트 리스트</span>
            </div>
            <%    
               rqlist=rqdb.getRequests(1, 5, "deadline imminent");
               if(rqdb.getRequestCount("deadline imminent")!=0){
                  for (int i = 0; i < rqlist.size(); i++) {
                     rq = rqlist.get(i);
                     dday = rqdb.getDday(rq.getRequestcode());
            %>
            <div class="contest_item w3-row" 
               onclick="location.href='contest/requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
               <img src="module/images/angle-right.png" class="w3-col s1"
                  style="width: 15px; height: 15px; margin: 17px; margin-right: 10px;">
               <div class="contest_item_content w3-col s5 text-left" style="font-weight: bold;"><%=rq.getTitle()%></div>
               <div class="contest_item_content w3-col s2"><%=rq.getCategory()%></div>
               <div class="contest_item_content w3-col s2"><%=price.format(rq.getCost() / 10000)%>만원</div>
               <div class="contest_item_content w3-col s2" style="font-weight: 800;">D-<%=dday%></div>
            </div>
            <%
               }
                  for (int i = 0; i < 5 - rqlist.size(); i++) {
            %>
            <div class="contest_item w3-row justify-content-center" 
               onclick="location.href='contest/designRequest1.jsp'">
               <img src="module/images/+2.png" style="width: 15px; height: 15px">
            </div>
            <%
                  }
               }else{
                  for (int i = 0; i < 5 ; i++) {
            %>
            <div class="contest_item w3-row justify-content-center" 
               onclick="location.href='contest/designRequest1.jsp'">
               <img src="module/images/+2.png" style="width: 15px; height: 15px">
            </div>
            <%
                  }
               }
            %>
         </div>

         <div class="col-sm-6">
            <div class="contest_category">
               <span><img src="module/images/new.png" style="width:30px;"> 최신등록 콘테스트 리스트</span>
            </div>
            <%
               rqlist = rqdb.getRequests(1, 5, "ing");
               if (rqdb.getRequestCount("ing","","") != 0) {
                  for (int i = 0; i < rqlist.size(); i++) {
                     rq = rqlist.get(i);
                     dday = rqdb.getDday(rq.getRequestcode());
            %>
            <div class="contest_item w3-row"
               onclick="location.href='contest/requestDetail.jsp?requestcode=<%=rq.getRequestcode()%>'">
               <img src="module/images/angle-right.png" class="w3-col s1"
                  style="width: 15px; height: 15px; margin: 17px; margin-right: 10px;">
               <div class="contest_item_content w3-col s5 text-left" style="font-weight: bold;"><%=rq.getTitle()%></div>
               <div class="contest_item_content w3-col s2"><%=rq.getCategory()%></div>
               <div class="contest_item_content w3-col s2"><%=price.format(rq.getCost() / 10000)%>만원</div>
               <div class="contest_item_content w3-col s2" style="font-weight: 800;">D-<%=dday%></div>
            </div>
            <%
                  }
                  for (int i = 0; i < 5 - rqlist.size(); i++) {
            %>
            <div class="contest_item w3-row justify-content-center" 
               onclick="location.href='contest/designRequest1.jsp'">
               <img src="module/images/+2.png" style="width: 15px; height: 15px">
            </div>
            <%
                  }
               }else{
                  for (int i = 0; i < 5 ; i++) {
            %>
            <div class="contest_item w3-row justify-content-center" 
               onclick="location.href='contest/designRequest1.jsp'">
               <img src="module/images/+2.png" style="width: 15px; height: 15px">
            </div>
            <%
                  }
               }
            %>
         </div>
      </div>
   </div>
</div>
<!-- 디자이너 배너 -->
<div class="top_designer container">
   <div><p class="top_designer_font">TOP 디자이너</p></div>
   <div class="row text-center" style="margin: 50px 0 25px 0">
      <%if(logon.getDesignerCount("")!=0){
         designerlist=logon.designerListTop(1,5);
         for (int i = 0; i < designerlist.size(); i++) {
            designer=designerlist.get(i);
      %>
      <div style="width: 20%; height: 20%">
         <a href="designer/profile.jsp?designerId=<%=designer.getId()%>"> 
            <img src="../imageFile/profileImg/<%=designer.getProfileimg() %>" class="designer_img">
            <p style="text-align: center;"><%=designer.getId() %></p>
         </a>
      </div>
      <%
         }
         }
      %>
   </div>
</div>
<section id="mainmenu">   
   <div class="container">
        <div class="row">
        <%
         if (pflist.size() == 0) {
      %>
         <div class="container">등록된 포트폴리오가 없습니다.</div>
      <%
         } else {
            if(pfcount>=8){pfcount=8;}else{pfcount=pflist.size();}
            for (int i = 0; i < pfcount; i++) {
				portfolio = (PortfolioDataBean) pflist.get(i);
				String filenames[]=portfolio.getFile().split(",");
				rq=rqdb.getRequest(portfolio.getRequestcode());
	%>
		<div class="col-md-3">
			<div class="mb-4 shadow-sm">
				<div class="mainmenu-thumb" data-toggle="modal" data-target="#portfolio<%=i+1%>" onclick="viewCount(0,<%=portfolio.getPortfoliocode() %>)">
					<img class="img-responsive" style="height:255px"
						  src="../fileSave/portfolioFile/<%if(portfolio.getRequestcode()!=0){%><%=rq.getCategory() %>/<%} %><%=filenames[filenames.length-1]%>">
				   <div class="mainmenu-overlay">
	                  <div class="mainmenu-item">
	                     <h5><%=portfolio.getTitle() %></h5>
	                     <small class="ellipsis3"><%=portfolio.getContents() %></small>
	                  </div>
	               </div>
				</div>
				<div class="modal fade" id="portfolio<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
					<jsp:include page="designer/portfolioModal.jsp">
						<jsp:param value="<%=portfolio.getPortfoliocode() %>" name="portfoliocode"/>
						<jsp:param value="<%=portfolio.getRequestcode() %>" name="requestcode"/>
					</jsp:include>
				</div>
			</div>
		</div>
		<script>
		$(document).ready(function(){
			$('#portfolio<%=i+1%>').on('shown.bs.modal', function () {
				var minheight=$("#carouselFade<%=portfolio.getPortfoliocode()%>").height();
				console.log(minheight);
				document.getElementById("content<%=portfolio.getPortfoliocode()%>").style.minHeight=minheight+"px";
			});
		});
		</script>
	<%
			}
         }
      %>
      </div>
   </div>
</section>
<!-- 클라이언트 로고 -->
<div class="client_box" style="background-color: #eee;">
   <div><p class="client_font">함께한 고객사</p></div>
   <div class="container">
      <ul class="clientlogo_box">
         <%
            for (int i = 1; i < 16; i++) {
         %>
         <li class="clientlogo"><img src="module/clientlogo/logo<%=i%>.png"></li>
         <%
            }
         %>
      </ul>
   </div>
</div>
<jsp:include page="module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />