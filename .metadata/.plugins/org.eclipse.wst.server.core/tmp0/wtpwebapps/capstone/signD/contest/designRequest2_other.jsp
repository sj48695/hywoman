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
   String category = request.getParameter("category");

   LogonDBBean Logon = LogonDBBean.getInstance();
   LogonDataBean member = Logon.getMember(id);

   if (id != null && member.getType().equals("의뢰인")) {
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param value="<%=title%>" name="title" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="bgi2">
   <section class="jumbotron text-center img-cover">
      <div class="container py-4">
         <h1 class="jumbotron-heading jumbotitle"><strong>디자인 공모하기</strong></h1>
         <p class="lead"><strong>공모할 로고 디자인의 상세정보를 입력하세요.</strong></p>
         <div class="pt-3">
            <div class="row bs2">
               <div class="col-sm-3 dan">1단계</div>
               <div class="col-sm-3 dan">2단계</div>
               <div class="col-sm-3 nodan">3단계</div>
               <div class="col-sm-3 nodan">4단계</div>
            </div>
            <div class="prog">
               <div class="progress-bar" style="width: 50%; background-color: tomato;"></div>
            </div>
         </div>
      </div>
   </section>
</div>

<div class="container requestbg footerbottom">
   <div class="content">
      <form method="post" action="designRequest3.jsp?category=<%=category %>" enctype="multipart/form-data">
         <!-- get방식으로 보내면 한글 안깨짐 -->
         <input name="category" value="<%=category%>" hidden="true">
         <div class="mb-4">
            <label class="lbr">1. 제목<font color="darksalmon">＊</font></label> 
            <input class="inp inpp mx-5" type="text" name="title" placeholder="ex) DO 로고 디자인 의뢰" required>
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
         <div class="mb-4">
            <label class="lbr">5. 참고파일 </label> 
            <input class="inp mx-5" type="file" name="file" placeholder="File" style="padding: 5px">
         </div>
         <div class="mb-4">
            <label class="lbr">6. 상세적인 디자인 요구사항<font color="darksalmon">＊</font></label>
            <textarea class="inparea mx-5" name="request" rows="15" placeholder="*의미: 디자인아웃소싱의 의미는 DesignOutsourcing의 줄임말과 누구든 할 수 있다는 do를 합친 단어 입니다.

*활용범위: 웹사이트와 모바일웹,어플로 서비스하는 회사입니다.따라서 사이즈가 작은 어플 아이콘으로도 사용될 수 있게 심플하고 가독성이 좋은 로고를 원합니다." required></textarea>
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