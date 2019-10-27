<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.IOException"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%!DecimalFormat price = new DecimalFormat("#,###");
   DecimalFormat decimal = new DecimalFormat("#,###");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
<%
   request.setCharacterEncoding("utf-8");
   response.setContentType("text/html;charset=UTF-8");
   String title = "step3 | DO";
   String id = (String) session.getAttribute("id");
   String designerId = request.getParameter("designerId");
   String category=request.getParameter("category");

   LogonDBBean Logon = LogonDBBean.getInstance();
   LogonDataBean member = Logon.getMember(id);
%>
<jsp:useBean id="rq" class="signD.member.OneToOneRequestDataBean">
   <jsp:setProperty property="*" name="rq" />
</jsp:useBean>
<%
   String realFolder = "";//웹 어플리케이션상의 절대 경로
   String saveFolder = "/fileSave/referenceFile/"+category;//파일이 업로드되는 폴더를 지정한다.
   String encType = "utf-8"; //엔코딩타입
   int maxSize = 5 * 1024 * 1024; //최대 업로될 파일크기 5Mb

   ServletContext context = getServletContext();
   //현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
   realFolder = context.getRealPath(saveFolder);
   
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
      <p class="lead"> 지급할 금액을 입력하세요.</p>
      <div class="pt-3">
         <div class="row bs2">
            <div class="col-sm-3 tdan">1단계</div>
            <div class="col-sm-3 tdan">2단계</div>
            <div class="col-sm-3 tdan">3단계</div>
            <div class="col-sm-3 nodan">4단계</div>
         </div>
         <div class="prog">
            <div class="progress-bar" role="progressbar" 
               style="width: 75%;background-color:tomato;" aria-valuenow="25" aria-valuemin="0"
               aria-valuemax="100"></div>
            </div>
      </div>
   </div>
</section>
</div>
<%
   try {
         MultipartRequest multi = null;

         //전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
         //전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
         multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

         //Form의 파라미터 목록을 가져온다
         Enumeration<?> params = multi.getParameterNames();

         //파라미터를 출력한다
         while (params.hasMoreElements()) {
            String name = (String) params.nextElement(); //전송되는 파라미터이름
            String value = multi.getParameter(name); //전송되는 파라미터값  
            if (name.equals("category")) {
               rq.setCategory(value);
            } else if (name.equals("title")) {
               rq.setTitle(value);
            } else if (name.equals("service")) {
               rq.setService(value.replace("\r\n", "<br>"));
            } else if (name.equals("company_name")) {
               rq.setCompany_name(value);
            } else if (name.equals("job_kind")) {
               rq.setJob_kind(value);
            } else if (name.equals("color")) {
               String color_detail = multi.getParameter("color_detail");
               if (color_detail == null || color_detail.equals("")) {
                  rq.setColor(value);
               } else {
                  rq.setColor(value + "," + color_detail);
               }
            } else if (name.equals("plan")) {
				String plans = multi.getParameter("plans");
				if (plans == null || plans.equals("")) {
					rq.setPlan(value.replace("\r\n", "<br>"));
				} else {
					rq.setPlan(plans + value.replace("\r\n", "<br>") );
				}
			} else if (name.equals("slogan")) {
				rq.setSlogan(value);
			} else if (name.equals("request")) {
				rq.setRequest(value.replace("\r\n", "<br>"));
			}
         }

         //전송한 파일 정보를 가져와 출력한다
         Enumeration<?> files = multi.getFileNames();

         //파일 정보가 있다면
         while (files.hasMoreElements()) {
            //input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
            String name = (String) files.nextElement();

            //서버에 저장된 파일 이름
            String filename = multi.getFilesystemName(name);
            rq.setFile(filename);

            if (rq.getCategory().equals("logo")) {
               rq.setCost(300000);
            } else if (rq.getCategory().equals("package")) {
               rq.setCost(400000);
            } else if (rq.getCategory().equals("web")) {
               rq.setCost(500000);
            } else {
               rq.setCost(100000);
            }
%>

<div class="container requestbg footerbottom">
   <div class="content">
      <form method="post" action="step4.jsp">
         <input name="category" value="<%=rq.getCategory()%>" hidden="true">
         <input name="designerId" value="<%=designerId%>" hidden="true">
         <input name="title" value="<%=rq.getTitle()%>" hidden="true">
         <input name="company_name" value="<%=rq.getCompany_name()%>" hidden="true"> 
         <input name="service" value="<%=rq.getService()%>" hidden="true"> 
         <input name="job_kind" value="<%=rq.getJob_kind()%>" hidden="true">
         <input name="color" value="<%=rq.getColor()%>" hidden="true">
         <input name="plan" value="<%=rq.getPlan()%>" hidden="true"> 
         <input name="file" value="<%=rq.getFile()%>" hidden="true"> 
         <input name="slogan" value="<%=rq.getSlogan()%>" hidden="true"> 
         <input name="request" value="<%=rq.getRequest()%>" hidden="true">
         <div class="mb-3">
            <label class="lbr">1.상금 직접 입력:</label> 
            <input class="inp mx-5" type="text" name="cost" id="cost" value="<%=rq.getCost()%>" 
               placeholder="최소 <%=price.format(rq.getCost()/10000)%>만원 이상" required onchange="costChange(<%=rq.getCost()%>,'<%=price.format(rq.getCost()/10000)%>')">
         </div>
         <div class="mb-3">
            <label class="lbr">2.상금 수수료 부담:</label>
            <div class="input_chk mx-5">
               <input type="checkbox" name="self_tax" id="self_tax" value="1"> 
               <label for="self_tax">본인이 부담(디자이너에게 상금 100% 지급, 선택시 상금액의 20%를 부담하게 됩니다.)</label>
            </div>
         </div>
         <div class="mb-3 text-center">
            <button type="submit" class="btn btnOr btn-lg">확인</button>
         </div>
      </form>
   </div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />
<%
         }
      } catch (IOException ioe) {
         System.out.println(ioe);
      } catch (Exception ex) {
         System.out.println(ex);
      }
   } else {
%>
<script type="text/javascript">
   alert('권한이 없습니다.');
   document.location.href = "/capstone/signD/main.jsp";
</script>
<%
   }
%>