<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
   request.setCharacterEncoding("utf-8");
   String title = "step1 | DO";
   String id = (String) session.getAttribute("id");
   String designerId = request.getParameter("designerId");

   LogonDBBean Logon = LogonDBBean.getInstance();
   LogonDataBean member = Logon.getMember(id);

   if (id != null && member.getType().equals("의뢰인")) {
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param value="<%=title%>" name="title" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="bgi3">
   <section class="jumbotron text-center img-cover">
   <div class="container py-4">
   <div class="jumbotron-heading jumbotitle">
      <b style="font-size:60px;">"<%=designerId%>"</b><b style="font-size:36px;">님께 1:1 의뢰하기</b></div>
      <p class="lead">의뢰할 디자인의 종류를 선택하세요.</p>
      <div class="pt-3">
         <div class="row bs2">
            <div class="col-sm-3 tdan">1단계</div>
            <div class="col-sm-3 nodan">2단계</div>
            <div class="col-sm-3 nodan">3단계</div>
            <div class="col-sm-3 nodan">4단계</div>
         </div>
         <div class="prog">
            <div class="progress-bar" role="progressbar" 
               style="width: 25%;background-color:tomato;" aria-valuenow="25" aria-valuemin="0"
               aria-valuemax="100"></div>
            </div>
      </div>
   </div>
</section>
</div>
<div class="container footerbottom">
   <div class="w3-row-padding w3-center w3-margin-top">
      <div class="w3-quarter">
         <a class="w3-button paddingz" href="step2_logo.jsp?category=logo&designerId=<%=designerId%>">
            <div class="w3-card w3-container" style="min-height: 460px">
               <br>
               <h3>LOGO</h3>
               <p>로고</p>
               <img src="../module/images1/logogogo.png" class="ilg" style="width: 50%">
               <div style="text-align: left">
                  <ol class="listnon" style="padding-left: 10%;">
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">30만원 부터</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">로고 디자인</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">간판 디자인</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">서식류 디자인</li>
                  </ol>
               </div>
            </div>
         </a>
      </div>
      <div class="w3-quarter">
         <a class="w3-button paddingz" href="step2_package.jsp?category=package&designerId=<%=designerId%>">
            <div class="w3-card w3-container" style="min-height: 460px">
               <br>
               <h3>PACKAGE</h3>
               <p>패키지</p>
               <img src="../module/images/box.png" class="ilg" style="width: 50%">
               <div style="text-align: left">
                  <ol class="listnon" style="padding-left: 10%;">
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">50만원 부터</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">패키지 디자인</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">라벨 디자인</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">제품 디자인</li>
                  </ol>
               </div>
            </div>
         </a>
      </div>
      <div class="w3-quarter">
            <a class="w3-button paddingz" href="step2_web.jsp?category=web&designerId=<%=designerId%>">
            <div class="w3-card w3-container" style="min-height: 460px">
               <br>
               <h3>WEB</h3>
               <p>웹</p>
               <img src="../module/images/website.png" class="ilg" style="width: 50%"> <br>
               <div style="text-align: left">
                  <ol class="listnon" style="padding-left: 10%;">
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">50만원 부터</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">웹 사이트</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">모바일 앱</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">광고용 웹페이지</li>
                  </ol>
               </div>
            </div>
         </a>
      </div>
      <div class="w3-quarter">
         <a class="w3-button paddingz" href="step2_other.jsp?category=other&designerId=<%=designerId%>">
            <div class="w3-card w3-container" style="min-height: 460px">
               <br>
               <h3>OTHER</h3>
               <p>그 외</p>
               <img src="../module/images/question.png" class="ilg" style="width: 50%"> <br>
               <div style="text-align: left">
                  <ol class="listnon" style="padding-left: 10%;">
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">30만원 부터</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">일러스트</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">캐릭터 디자인</li>
                     <li class="paddingb">
                     <img src="../module/images1/tick.png" style="width: 15px;" class="marginr">명함 디자인</li>
                  </ol>
               </div>
            </div>
         </a>
      </div>
   </div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
<%
   } else {
%>
<script type="text/javascript">
   alert('권한이 없습니다.');
   document.location.href = "../main.jsp";
</script>
<%
   }
%>