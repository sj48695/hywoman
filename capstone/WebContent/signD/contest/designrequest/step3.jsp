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
	String category=request.getParameter("category");

	LogonDBBean Logon = LogonDBBean.getInstance();
	LogonDataBean member = Logon.getMember(id);
%>
<jsp:useBean id="rq" class="signD.contest.RequestDataBean">
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
<jsp:include page="../../module/menubar.jsp" flush="false" />
<div class="bgi2">
	<section class="jumbotron text-center img-cover">
		<div class="container py-4">
			<h1 class="jumbotron-heading jumbotitle"><strong>디자인 공모하기-3단계</strong></h1>
			<p class="lead"><strong>공모할 디자인의 상금 및 추가옵션을 선택하세요.</strong></p>
			<div class="pt-3">
				<div class="row bs2">
					<div class="col-sm-3 dan">1단계</div>
					<div class="col-sm-3 dan">2단계</div>
					<div class="col-sm-3 dan">3단계</div>
					<div class="col-sm-3 nodan">4단계</div>
				</div>
				<div class="prog">
					<div class="progress-bar" style="width: 75%; background-color: tomato;"></div>
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
				} else if (name.equals("pages")) {
					rq.setPages(value);
				} else if (name.equals("website")) {
					rq.setPages(value);
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
		<form method="post" action="designRequest4.jsp" class="m-0">
			<input name="category" value="<%=rq.getCategory()%>" hidden="true">
			<input name="title" value="<%=rq.getTitle()%>" hidden="true">
			<input name="company_name" value="<%=rq.getCompany_name()%>" hidden="true"> 
			<input name="service" value="<%=rq.getService()%>" hidden="true"> 
			<input name="job_kind" value="<%=rq.getJob_kind()%>" hidden="true">
			<input name="pages" value="<%=rq.getPages()%>" hidden="true">
			<input name="website" value="<%=rq.getWebsite()%>" hidden="true">
			<input name="color" value="<%=rq.getColor()%>" hidden="true">
			<input name="plan" value="<%=rq.getPlan()%>" hidden="true"> 
			<input name="file" value="<%=rq.getFile()%>" hidden="true"> 
			<input name="slogan" value="<%=rq.getSlogan()%>" hidden="true"> 
			<input name="request" value="<%=rq.getRequest()%>" hidden="true">
			<div class="mb-3">
				<label class="lbr">1.상금 직접 입력</label> 
				<input class="inp mx-5" type="text" name="cost" id="cost" value="<%=rq.getCost()%>" 
					placeholder="최소 <%=price.format(rq.getCost()/10000)%>만원 이상" required onchange="costChange(<%=rq.getCost()%>,'<%=price.format(rq.getCost()/10000)%>')">
			</div>
			<div class="mb-3">
				<label class="lbr">2.상금 수수료 부담</label>
				<div class="input_chk mx-5">
					<input type="checkbox" name="self_tax" id="self_tax" value="1"> 
					<label for="self_tax">본인이 부담(디자이너에게 상금 100% 지급, 선택시 상금액의 20%를 부담하게 됩니다.)</label>
				</div>
			</div>
			<div class="mb-3">
				<label class="lbr">3.추가 옵션사항</label>
				<div class="input_chk mx-5">
					<input type="checkbox" name="op_main" id="op_main" value="1" onchange="optionCheck()">
					<label for="op_main">상단노출 옵션(50,000원)</label>
				</div>
				<div class="input_chk mx-5">
					<input type="checkbox" name="op_bgcolor" id="op_bgcolor" value="1" onchange="optionCheck()">
					<label for="op_bgcolor">배경색 특수(30,000원)</label>
				</div>
				<div class="input_chk mx-5">
					<input type="checkbox" name="op_week" id="op_week" value="1" onchange="optionCheck()">
					<label for="op_week" >일주일 연장(70,000원)</label>
				</div>
			</div>		
			<div class="mb-5" style="position: relative; overflow: hidden;">
		      <div class="new_list_icon">
	            <div data-toggle="button" aria-pressed="false" id="star">
	               <font size="5"><i class="far fa-star"></i></font>
	            </div>
		      </div>
		      <div class="new_list_item m-2 media row justify-content-between bgcolor">
		         <div class="col-sm-8 pr-0 row align-self-center" >
		            <div class="new_list_img align-self-center">
		               <img src="/capstone/signD/module/images/<%=rq.getCategory()%>.jpg"
		                  alt="<%=rq.getCategory()%>">
		            </div>
		          	<div class="inline col-sm-9 align-self-center">
		               <div class="new_list_sub_top">
		                  <div class="row col-sm-12">
		                     <div class="new_list_cate align-top"><%=rq.getCategory()%>&nbsp;|&nbsp;</div>
		                     <div class="new_list_title pl-0"> <%=rq.getTitle()%></div>
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
		            <div class="new_list_day"><strong>남은기간 : </strong>
						<span class="week">7일(~<%=sdf.format(System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000))%>)</span>
					</div>
		            <div class="new_list_day"><div class="new_iconBox inline"><strong>참여자 : </strong>0명</div></div>
		         </div>
		      </div>
		   </div>
			<div class="text-center"><button type="submit" class="btn btnOr btn-lg">확인</button></div>
		</form>
	</div>
</div>
<script type="text/javascript">
//designerRequest3.jsp 옵션 선택시
function optionCheck(){
	if(document.getElementById("op_main").checked){
		 $(".new_list_title").html('<%=rq.getTitle()%>   <img src="/capstone/signD/module/images/like.png" width="25">');
	}else{
		 $(".new_list_title").html('<%=rq.getTitle()%>');
	}
	if(document.getElementById("op_bgcolor").checked){
		$(".bgcolor").attr("style","background: antiquewhite");
	}else {
		$(".bgcolor").attr("style","");
	}
	if (document.getElementById("op_week").checked) {
		$(".week").html("14일(~<%=sdf.format(System.currentTimeMillis() + (14 * 60 * 60 * 24 * 1000))%>)");//2주 후 (일주일 연장)
	} else {
		$(".week").html("7일(~<%=sdf.format(System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000))%>)");//1주 후
	}
}
</script>
<jsp:include page="../../module/bottom.jsp" flush="false" />
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