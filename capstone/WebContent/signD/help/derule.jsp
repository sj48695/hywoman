<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.help.NoticeDBBean"%>
<%@page import="signD.help.NoticeDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%!int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
<%
   request.setCharacterEncoding("utf-8");
   String pageNum = request.getParameter("pageNum");
   String title = "이용방법 | 디자이너 | DO";
   int count = 0;
   int number = 0;

   NoticeDBBean noticedb = NoticeDBBean.getInstance();
   count = noticedb.getNoticeCount();
   if (pageNum == null) {
      pageNum = "1";
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
      <a href="/capstone/signD/help/notice.jsp" class="w3-button w3-col s3">공지사항</a> 
      <a href="/capstone/signD/help/FAQ.jsp" class="w3-button w3-col s3">FAQ</a> 
      <a href="/capstone/signD/help/Q&A.jsp" class="w3-button w3-col s3">Q&A</a> 
      <a href="/capstone/signD/help/rule.jsp" class="w3-button w3-col s3 w3-brown"><strong>이용방법</strong></a>
   </div>
   <div class="pf_nav_wrap w3-center">
      <ul class="pf_nav">
         <li><a href="rule.jsp">의뢰자</a></li>
         <li class="active"><a href="derule.jsp">디자이너</a></li>
      </ul>
   </div>
   <div class="pf_nav_wrap w3-center">
      <div class="w3-container"><br>
         <h2 class="w3-center w3-text-dark-grey"><b>참여방법</b></h2>
         <div class="w3-content ">
            <div class="d2_content_box">
               <div class="box 1">
                  <img class="box box_content" src="../module/images/1.png" />
                  <h4 class="w3-center w3-text-grey"><b>1.참여 할 콘테스트를 선택</b></h4>
                  <h6 class="w3-center w3-text-grey">원하는 콘테스트를 확인하신 후 선택하고 참여하세요.</h6>
               </div>
               <div class="box 2">
                  <img class="box box_content" src="../module/images/2.png" />
                  <h4 class="w3-center w3-text-grey"><b>2. 디자인 교정작업</b></h4>
                  <h6 class="w3-center w3-text-grey">디자인 피드백을 받으셨다면,의뢰자가 원하는 방향으로 디자인을 수정합니다.</h6>
               </div>
               <div class="box 3">
                  <img class="box box_content" src="../module/images/3.png" />
                  <h4 class="w3-center w3-text-grey"><b>3. 최종우승 후 상금수령</b></h4>
                  <h6 class="w3-center w3-text-grey">디자인이 선정되면 저작권 양도 동의 후,상금을 받아가세요.</h6><br>
               </div>
            </div>
         </div>
      </div>
      <div class="pf_nav_wrap w3-center">
      </div>
      <div class="pf_nav_wrap w3-center">
         <h2 class="w3-center w3-text-dark-grey"><b>유의사항</b></h2><br>
         <div class="w3-content">
            <p style="text-align: center;"><img src="../module/images/ww.png" /></p>
            <p>
               <h6 class="w3-center w3-text-red"><b>※디자이너분들은 반드시 읽어주시기 바랍니다.</b><br><br></h6>
               <h6 class="w3-center w3-text-grey">- 한번에 한 컨셉의 디자인만 올려주시기 바랍니다.</h6>
               <p>
               <h6 class="w3-center w3-text-grey">- 어플리케이션 작업은 의뢰자가 별도로 요청하지 않는 이상 제공하실 필요가 없습니다.</h6>
               <p>
               <h6 class="w3-center w3-text-grey">
                  - 시뮬레이션에 사용되는 이미지는 상업적으로 이용가능한 무료 이미지여야 하며, 저작권법 위반시에 발생하는 모든 법적인 책임은 디자이너 본인에게 있습니다.
               </h6>
               <p>
               <h6 class="w3-center w3-text-grey">- 디자인 도용 및 저작권 침해는 남의 물건을
                  훔치는 행위입니다. 반드시 본인의 창작물만 제출해주시기 바랍니다. 신고가 접수된 디자이너는 경고 없이 바로 회원탈퇴
                  처리되며 법적인 책임을 물게 될 수도 있습니다.
               </h6>
               <p>
               <h6 class="w3-center w3-text-grey">
                  - 불법 다운로드된 프로그램으로 제작한 디자인을 상업적으로 거래하는 경우, 컴퓨터프로그램보호법 46조에 의거하여 5년
                  이하의 징역 또는 5000만원 이하의 벌금을 물게 될 수도 있습니다. 반드시 정품 프로그램을 사용하시기 바랍니다.
               </h6><br><br>
         </div>
      </div>
      <div class="pf_nav_wrap w3-center">
         <h2 class="w3-center w3-text-dark-grey"><b>상금안내</b></h2>
         <br>
         <div class="w3-content">
            <p style="text-align: center;"><img src="../module/images/bank.png" /></p>
            <h3 class="w3-center w3-text-grey"><b>콘테스트가 개최됩니다</b></h3>
            <h6 class="w3-center w3-text-grey">
               콘테스트를 개최하면 77,054명의 디자이너가 활동중인 콘테스트 리스트에 노출됩니다.
               <p>전국 각지에서 활동중인 수많은 프로 디자이너가 당신의 브리핑을 읽고 디자인을 등록합니다.</p>
            </h6><br><br>
         </div>
      </div>
   </div>
   <div class="pf_nav_wrap w3-center">
      <h2 class="w3-center w3-text-dark-grey"><b>TOP 디자이너 랭킹</b></h2><br>
      <div class="w3-content">
         <p style="text-align: center;"><img src="../module/images/rank.png" /></p>
         <h4 class="w3-center w3-text-grey"><b>우승순위 별 디자이너 랭킹입니다.</b></h4>
         <h6 class="w3-center w3-text-grey">signD에서 15번이상 우승경험이 있는 디자이너 입니다.</h6>
         <h6 class="w3-center w3-text-grey">signD에서 10번이상 우승경험이 있는 디자이너 입니다.</h6>
         <h6 class="w3-center w3-text-grey">signD에서 5번이상 우승경험이 있는 디자이너 입니다.</h6>
         <h6 class="w3-center w3-text-grey">signD에서 1번이상 우승경험이 있는 디자이너 입니다.</h6><br>
      </div>
   </div>
</div>
<div class="w3-container w3-padding-64  w3-center w3-wide">
   <h3 class="w3-center w3-text-grey">
      <b>경력이나 학력과 상관없이 오로지 디자인 실력과 센스만으로 디자이너가 제대로 인정받는 곳!
         <p>끊임없이 등록되는 디자인 콘테스트에 참여해서 상금도 획득하고 포트폴리오도 쌓아보세요</p>
      </b>
   </h3>
   <p class="w3-xlarge"><br>
      <button onclick="location.href='../contest/contestIngList.jsp'" style="padding: 8px 60px"
         class="w3-button w3-round w3-brown w3-opacity w3-hover-opacity-off">콘테스트 보러가기</button>
   </p>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />