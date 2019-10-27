<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
   request.setCharacterEncoding("utf-8");
   response.setContentType("text/html;charset=UTF-8");
   String title = "step2 | DO";
   String id = (String) session.getAttribute("id");
   String designerId = request.getParameter("designerId");
   String category = request.getParameter("category");

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
      <p class="lead">로고 디자인의 세부사항을 입력하세요.</p>
      <div class="pt-3">
         <div class="row bs2">
            <div class="col-sm-3 tdan">1단계</div>
            <div class="col-sm-3 tdan">2단계</div>
            <div class="col-sm-3 nodan">3단계</div>
            <div class="col-sm-3 nodan">4단계</div>
         </div>
         <div class="prog">
            <div class="progress-bar" role="progressbar" 
               style="width: 50%;background-color:tomato;" aria-valuenow="50" aria-valuemin="0"
               aria-valuemax="100"></div>
            </div>
      </div>
   </div>
</section>
</div>
<div class="container requestbg footerbottom">
   <div class="content">
      <form method="post" action="step3.jsp?category=<%=category %>&designerId=<%=designerId%>" enctype="multipart/form-data">
         <!-- get방식으로 보내면 한글 안깨짐 -->
         <input name="category" value="<%=category%>" hidden="true">
         <div class="mb-4">
            <label class="lbr">1. 제목<font color="darksalmon">＊</font></label> 
            <input class="inp inpp mx-5" type="text" name="title" placeholder="ex) DO 웹사이트 디자인 의뢰" required>
         </div>
         <div class="mb-4">
            <label class="lbr">2. 회사명<font color="darksalmon">＊</font></label> 
            <input class="inp mx-5" type="text" name="company_name" placeholder="ex) DO(DesignOutsourcing)" required>
         </div>
         <div class="mb-4">
            <label class="lbr">3. 회사 서비스 설명</label>
            <textarea class="inparea mx-5" name="service" rows="6" placeholder="ex) DO는 디자인을 필요로 하는 사람들이 다양한 디자인(로고, 패키지, 웹 디자인 등)에 대한 콘테스트를 개최하고 
      콘테스트에 참여한 사람들의 디자인을 채택 합니다."></textarea>
         </div>
         <div class="mb-3 w3-row">
            <label class="lbr">4. 업종</label>
            <div class="w3-col s5 pl-5 mr-4">

               <div class="input_chk">
                  <input type="radio" id="cf" class="ipn" name="job_kind_group"
                     value="식당/카페 " onchange="otherChange('job_kind',this.id)">
                  <label for="cf">식당/카페 </label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="fo" class="ipn" name="job_kind_group"
                     value="식품/건강" onchange="otherChange('job_kind',this.id)">
                  <label for="fo">식품/건강</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="it" class="ipn" name="job_kind_group"
                     value="IT/미디어" onchange="otherChange('job_kind',this.id)"> 
                  <label for="it">IT/미디어</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="bu" class="ipn" name="job_kind_group"
                     value="뷰티/패션" onchange="otherChange('job_kind',this.id)">
                  <label for="bu">뷰티/패션</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="ho" class="ipn" name="job_kind_group"
                     value="병원" onchange="otherChange('job_kind',this.id)">
                  <label for="ho">병원</label>
               </div>
            </div>
            <div class="w3-col s6 ml-5 pr-5">
               <div class="input_chk">
                  <input type="radio" id="pe" class="ipn" name="job_kind_group"
                     value="애완동물" onchange="otherChange('job_kind',this.id)"> 
                  <label for="pe">애완동물</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="ed" class="ipn" name="job_kind_group"
                     value="교육/육아" onchange="otherChange('job_kind',this.id)"> 
                  <label for="ed">교육/육아</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="go" class="ipn" name="job_kind_group"
                     value="공공기관" onchange="otherChange('job_kind',this.id)">
                  <label for="go">공공기관</label>
               </div>
               <div class="input_chk w3-row">
                  <input type="radio" id="ot" class="ipn" name="job_kind_group"
                     value="일반/기타" onchange="otherChange('job_kind',this.id)">
                  <label for="ot" class="w3-col s4">일반/기타</label> 
                  <input class="inp w3-col s8 m-0 job_kind_other" type="text"
                     name="job_kind" placeholder="job_kind" style="visibility: hidden;">
               </div>
            </div>
         </div>
        <div class="mb-4 w3-row">
            <label class="lbr">5. 페이지 갯수</label> 
         <div class="w3-col s5 pl-5 mr-4">
               <div class="input_chk">
                  <input type="radio" id="1 ~ 2 page" class="ipn" name="pages" value="1 ~ 2 페이지" onchange="page('job_kind',this.id)"> 
                  <label for="1 ~ 2 page">1 ~ 2 페이지 </label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="3 ~ 4 page" class="ipn" name="pages" value="3 ~ 4 페이지"> 
                  <label for="3 ~ 4 page">3 ~ 4 페이지</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="5 ~ 6 page" class="ipn" name="pages" value="5 ~ 6 페이지"> 
                  <label for="5 ~ 6 page">5 ~ 6 페이지</label>
               </div>
         </div>
         <div class="w3-col s6 ml-5 pr-5">
               <div class="input_chk">
                  <input type="radio" id="7 ~ 8 page" class="ipn" name="pages" value="7 ~ 8 페이지"> 
                  <label for="7 ~ 8 page">7 ~ 8 페이지</label>
               </div>
               <div class="input_chk">
                  <input type="radio" id="9 ~ 10 page" class="ipn" name="pages" value="9 ~ 10 페이지"> 
                  <label for="9 ~ 10 page">9 ~ 10 페이지</label>
               </div>
                <div class="input_chk">
                  <input type="radio" id="free" class="ipn" name="pages" value="자유롭게"> 
                  <label for="free">자유롭게</label>
               </div>
            </div>
         </div>
         <div class="mb-4">
            <label class="lbr">6. 참고 웹사이트</label> 
            <input class="inp mx-5" name="website" placeholder="ex) do.kr - 상단 메뉴구성과 전체적인 색깔이나 분위기가 심플하고 세련되서 좋아요.">
         </div>
         <div class="mb-4">
            <label class="lbr">7. 참고파일 </label> 
            <input class="inp mx-5" type="file" name="file" placeholder="File" style="padding: 5px">
         </div>
         <div class="mb-4">
            <label class="lbr">8. 상세적인 디자인 요구사항<font color="darksalmon">＊(각 페이지별로 필요한 내용을 적어주세요.)</font></label>
            <textarea class="inparea mx-5" name="request" rows="15" placeholder="ex) 
            1) main : 방문자가 만나는 첫 페이지 입니다. 방문자의 특성은 불특정 고객이 아닌 이미 당사에 대한 내용을 어느 정도는 알고 유입되
               는 고객을 대상으로 합니다. 상담신청 바로가기가 눈에 띄도록 디자인 되었으면 합니다.
            2) Service : 당사가 보유한 3가지 핵심 강점입니다. 잘 부각되도록 부탁드립니다." required></textarea>
         </div>
         <p class="text-center">
            <button type="submit" class="btn btnOr btn-lg">확인</button>
         </p>
      </form>
   </div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
<%
   } else {
%>
<script type="text/javascript">
   alert('권한이 없습니다.');
   document.location.href = "/capstone/signD/main.jsp";
</script>

<%
   }
%>