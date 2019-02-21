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

<jsp:useBean id="rq" class="signD.contest.RequestDataBean">
	<jsp:setProperty property="*" name="rq" />
</jsp:useBean>
<%
	String title = "step4 | DO";
	String id = (String) session.getAttribute("id");
	int op_main=0;
	int op_bgcolor=0;
	int op_week=0;
	double self_tax=0.0;
	int addtax=0;
	int total=0;
	 
	if (request.getParameter("self_tax") != null) {
		self_tax = 0.2;
	} else {
		rq.setSelf_tax(0);
	}
	if (request.getParameter("op_main") != null) {
		op_main = 50000;
	} else {
		rq.setOp_main(0);
	}
	if (request.getParameter("op_bgcolor") != null) {
		op_bgcolor = 30000;
	} else {
		rq.setOp_bgcolor(0);
	}
	if (request.getParameter("op_week") != null) {
		op_week = 70000;
	} else {
		rq.setOp_week(0);
	}

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
			<h1 class="jumbotron-heading jumbotitle"><strong>디자인 공모하기-4단계</strong></h1>
			<p class="lead"><strong>공모할 디자인의 결제수단을 선택하세요.</strong></p>
			<div class="pt-3">
				<div class="row bs2">
					<div class="col-sm-3 dan">1단계</div>
					<div class="col-sm-3 dan">2단계</div>
					<div class="col-sm-3 dan">3단계</div>
					<div class="col-sm-3 dan">4단계</div>
				</div>
				<div class="prog">
					<div class="progress-bar" style="width: 100%; background-color: tomato;"></div>
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
					<div class="receipt">
						<span class="priceText"><%=price.format(rq.getCost()) %></span>원
					</div>
				</div>
				<div>
					<span>공모전 등록비</span>
					<div class="receipt">
						<span class="priceText">100,000</span>원
					</div>
				</div>
				<div>
					<span>상금수수료</span>
					<div class="receipt">
						<span class="priceText"><%=price.format((int)(rq.getCost()*self_tax)) %></span>원
					</div>
				</div>
			</li>
			<li class="lii">
				<div>
					<span>상단노출 옵션</span>
					<div class="receipt">
						<span class="priceText"><%=price.format(op_main) %></span>원
					</div>
				</div>
				<div>
					<span>배경색 특수</span>
					<div class="receipt">
						<span class="priceText"><%=price.format(op_bgcolor)%></span>원
					</div>
				</div>
				<div>
					<span>일주일 연장</span>
					<div class="receipt">
						<span class="priceText"><%=price.format(op_week)%></span>원
					</div>
				</div>
			</li>
			<%
				addtax=(int)((rq.getCost() + 100000 + (int)(rq.getCost()*self_tax) + op_main + op_bgcolor + op_week)*0.1);
			%>
			<li class="lii"><span>부가세(10%)</span>
				<div class="receipt">
					<span class="priceText"><%=price.format(addtax) %></span>원
				</div>
			</li>
			<%
				total = rq.getCost() + 100000 + (int)(rq.getCost()*self_tax) + op_main + op_bgcolor + op_week + addtax;
			%>
			<li style="border-bottom: 0;" class="lii"><span>합계</span>
				<div class="receipt" style="color: #f00;">
					<span class="priceText" id="totalAmount"><%=price.format(total) %></span>원
				</div>
			</li>
		</ul>
	</div>

	<hr>
	<form method="post" action="requestInsertPro.jsp">
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
		<input name="cost" value="<%=rq.getCost()%>" hidden="true">
		<input name="total" value="<%=total%>" hidden="true">
		<input name="self_tax" value="<%=rq.getSelf_tax()%>" hidden="true">
		<input name="op_main" value="<%=rq.getOp_main()%>" hidden="true">
		<input name="op_bgcolor" value="<%=rq.getOp_bgcolor()%>" hidden="true">
		<input name="op_week" value="<%=rq.getOp_week()%>" hidden="true">
		
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
			<button type="submit" class="btn btnOr btn-lg">콘테스트 개최하기</button>
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