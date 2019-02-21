<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@page import="signD.help.NoticeDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   
<%!   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
<%
   request.setCharacterEncoding("utf-8");
   String pageNum = request.getParameter("pageNum");
   String title = "이용방법 | 의뢰인 | DO";
   int count=0;
   int number=0;
   
   NoticeDBBean noticedb=NoticeDBBean.getInstance();
   count=noticedb.getNoticeCount();
   
   if (pageNum == null) {
      pageNum="1";
   }
   int currentPage = Integer.parseInt(pageNum);
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
			<p class="lead"><strong>이용방법에 대해 알아보세요!</strong></p>
		</div>
	</section>
</div>
<div class="container">
   <div class="w3-border w3-light-white w3-row">
      <a href="notice.jsp" class="w3-button w3-col s3">공지사항</a> 
      <a href="FAQ.jsp" class="w3-button w3-col s3">FAQ</a> 
      <a href="Q&A.jsp" class="w3-button w3-col s3">Q&A</a> 
      <a href="rule.jsp" class="w3-button w3-col s3 w3-brown"><strong>이용방법</strong></a>
   </div>
   <div class="pf_nav_wrap w3-center">
	   <ul class="pf_nav">
	      <li class="active"><a href="rule.jsp">의뢰자</a></li>
	      <li><a href="derule.jsp">디자이너</a></li>
	   </ul>
	</div>
   
	<div class="w3-container"><br>
		<div class="pf_nav_wrap w3-center">
			<h1 class="w3-center w3-text-dark-grey"><b>Step 1</b></h1><br>
		  	<div class="w3-content ">
				<p style="text-align: center;"><img src="../module/images/test.png" /></p>
				<h3 class="w3-center w3-text-grey"><b>의뢰 할 디자인 선택과 설명을 해주세요</b></h3>
				<p>
				<h6 class="w3-center w3-text-grey">
					어떤 디자인이 필요한지 디자이너들에게 설명해주세요. 각 카테고리별로 필요한 정보가 보기 쉽게 나열되어 있습니다.
					<p>고객님의 취향에 가장 잘 맞는 디자인을 얻기 위해서 최대한 자세히 작성해주세요.</p>
				</h6><br><br>
			</div>
		</div>
		<div class="pf_nav_wrap w3-center">
			<h1 class="w3-center w3-text-dark-grey"><b>Step 2</b></h1><br>
			<div class="w3-content">
				<p style="text-align: center;"><img src="../module/images/money.png" /></p>
				<h3 class="w3-center w3-text-grey"><b>상금과 옵션을 선택해주세요</b></h3>
				<p>
				<h6 class="w3-center w3-text-grey">
					예산에 맞추어 상금을 책정해 주세요. 그리고 옵션을 선택하신다면 더 많이 디자이너들이 참가를 할 수 있습니다.
				</h6><br><br>
			</div>
		</div>
		<div class="pf_nav_wrap w3-center">
			<h1 class="w3-center w3-text-dark-grey"><b>Step 3</b></h1><br>
			<div class="w3-content">
				<p style="text-align: center;"><img src="../module/images/computer.png" /></p>
				<h3 class="w3-center w3-text-grey"><b>콘테스트가 개최됩니다</b></h3>
				<p>
				<h6 class="w3-center w3-text-grey">
					콘테스트를 개최하면 77,054명의 디자이너가 활동중인 콘테스트 리스트에 노출됩니다.
					<p>전국 각지에서 활동중인 수많은 프로 디자이너가 당신의 브리핑을 읽고 디자인을 등록합니다.</p>
				</h6><br><br>
			</div>
		</div>
		<div class="pf_nav_wrap w3-center">
			<h1 class="w3-center w3-text-dark-grey"><b>Step 4</b></h1><br>
			<div class="w3-content">
				<p style="text-align: center;"><img src="../module/images/trophy.png" /></p>
				<h3 class="w3-center w3-text-grey"><b>우승작을 선정해주세요</b></h3>
				<p>
				<h6 class="w3-center w3-text-grey">공모기간 종료 후 1주일의 심사기간이 주어집니다.
					반드시 1주일 안에 우승작을 선정해 주세요. 우승작을 선정하면 상금이 디자이너에게 전달되고, 당신은 원본파일을 다운로드해
					어디든 사용할 수 있습니다!</h6><br><br>
			</div>
		</div>
		<!-- RSVP section -->
		<div class="w3-container w3-padding-64  w3-center w3-wide" id="rsvp">
			<h1 class="w3-center w3-text-grey"><b>지금 바로 의뢰해 보세요!</b></h1>
			<p class="w3-large">누구든 의뢰 하실 수 있습니다.</p>
			<p class="w3-xlarge">
				<button onclick="location.href='../contest/designRequest1.jsp'" style="padding: 8px 60px"
					class="btn btnOr">Try!</button>
			</p>
		</div>
	</div>
<!-- <!-- RSVP modal 
	<div id="id01" class="w3-modal">
		<div class="w3-modal-content w3-card-4 w3-animate-zoom" style="padding: 32px; max-width: 600px">
			<div class="w3-container w3-white w3-center">
				<h1 class="w3-wide">CAN YOU COME?</h1>
				<p>We really hope you can make it.</p>
				<form>
					<input class="w3-input w3-border" type="text" placeholder="Name(s)" name="name">
				</form>
				<p><i>Sincerely, John & Jane</i></p>
				<div class="w3-row">
					<div class="w3-half">
						<button onclick="document.getElementById('id01').style.display='none'"
							type="button" class="w3-button w3-block w3-green">Going</button>
					</div>
					<div class="w3-half">
						<button onclick="document.getElementById('id01').style.display='none'"
							type="button" class="w3-button w3-block w3-red">Can't come</button>
					</div>
				</div>
			</div>
		</div>
	</div> -->
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />