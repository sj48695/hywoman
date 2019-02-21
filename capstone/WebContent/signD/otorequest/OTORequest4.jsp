<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%!int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	DecimalFormat price = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");
%>

<jsp:useBean id="rq" class="signD.member.OneToOneRequestDataBean">
	<jsp:setProperty property="*" name="rq" />
</jsp:useBean>
<%
	String title = "step4 | DO";
	String id = (String) session.getAttribute("id");
	String designerId = request.getParameter("designerId");
	double self_tax=0.0;
	int addtax=0;
	int total=0;
	 
	if (request.getParameter("self_tax") != null) {
		self_tax = 0.2;
	} else {
		rq.setSelf_tax(0);
	}
	

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
      <p class="lead">영수증을 확인하세요.</p>
      <div class="pt-3">
         <div class="row bs2">
            <div class="col-sm-3 tdan">1단계</div>
            <div class="col-sm-3 tdan">2단계</div>
            <div class="col-sm-3 tdan">3단계</div>
            <div class="col-sm-3 tdan">4단계</div>
         </div>
         <div class="prog">
            <div class="progress-bar" role="progressbar" 
               style="width: 100%;background-color:tomato;" aria-valuenow="25" aria-valuemin="0"
               aria-valuemax="100"></div>
            </div>
      </div>
   </div>
</section>
</div>
<div class="container requestbg footerbottom">
	<div class="text-center">
		<img src="/capstone/signD/module/process.png" class="w-50">
	</div>
	<h1 class="text-center">Total</h1>
	<p class="lead text-center">영수증</p>
	<div class="col-md-8 offset-md-2 insertsigns w-100">
		<ul class="ull">
			<li class="lii">
				<div class="fontb">콘테스트 항목</div><!-- 
				<div>로고 디자인 &nbsp;&nbsp;|&nbsp;&nbsp;플래티넘패키지</div> -->
				<div>
				<%if (rq.getCategory().equals("logo")) {
					%>로고<% 
				} else if (rq.getCategory().equals("package")) {
					%>패키지<%
				} else if (rq.getCategory().equals("web")) {
					%>웹<%
				} else {
					%>기타<%
				} %> 디자인</div>
			</li>
			<li class="lii">
				<div>
					<span>상금 1등</span>
					<div style="float: right; text-align: right;">
						<span class="priceText"><%=price.format(rq.getCost()) %></span>원
					</div>
				</div>
				<div>
					<span>공모전 등록비</span>
					<div style="float: right; text-align: right;">
						<span class="priceText">100,000</span>원
					</div>
				</div>
				<div>
					<span>상금수수료</span>
					<div style="float: right; text-align: right;">
						<span class="priceText"><%=price.format((int)(rq.getCost()*self_tax)) %></span>원
					</div>
				</div>
			</li>
			<%
				addtax=(int)((rq.getCost() + 100000 + (int)(rq.getCost()*self_tax))*0.1);
			%>
			<li class="lii"><span>부가세(10%)</span>
				<div style="float: right; text-align: right;">
					<span class="priceText"><%=price.format(addtax) %></span>원
				</div>
			</li>
			<%
				total = rq.getCost() + 100000 + (int)(rq.getCost()*self_tax) + addtax;
			%>
			<li style="border-bottom: 0;" class="lii"><span>합계</span>
				<div style="float: right; text-align: right; color: #f00;">
					<span class="priceText" id="totalAmount"><%=price.format(total) %></span>원
				</div>
			</li>
		</ul>
	</div>

	<hr>
	<form method="post" action="OTORequestInsertPro.jsp">
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
		<input name="cost" value="<%=rq.getCost()%>" hidden="true">
		<input name="total" value="<%=total%>" hidden="true">
		<input name="self_tax" value="<%=rq.getSelf_tax()%>" hidden="true">
		
		<h1 class="text-center">PAY</h1>
		<p class="lead text-center">결제수단</p>
		<div class="col-md-8 offset-md-2 text-center pd-0 w-100">
			<select class="insertsignss w-100 text-center" name="dept" id="dept">
				<option>- 결제수단 -</option>
				<option value="신용">신용카드</option>
				<option value="무통장">무통장 입금</option>
				<option value="핸드폰">핸드폰 결제</option>
			</select>
		</div>
		<p class="text-center py-5">
			<button type="submit" class="btn btnOr btn-lg">1:1 의뢰하기</button>
		</p>
	</form>
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