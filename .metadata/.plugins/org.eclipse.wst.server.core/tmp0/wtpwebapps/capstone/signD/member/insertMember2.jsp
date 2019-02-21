<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
	String title = "회원가입 | 정보입력 | DO";
%>

<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="mbgi">
	<section class="jumbotron text-center img-cover">
	<div class="container py-4">
	<h1 class="jumbotron-heading jumbotitle">
			<strong>회원가입</strong>
		</h1>
		<p class="lead">
			<strong>디자인 콘테스트 사이트 'DO'와 함께하세요!</strong>
		</p>
	
	</div>
</section>
</div>
<div class="container footerbottom">
	<form class="from-horizontal" method="post" name="insertmemberform" id="insertmemberform" action="/capstone/signD/member/insertMemberPro.jsp">
		<h4 class="text-center">회원구분</h4>
		<div class="row justify-content-center btn-group-toggle" style="padding-top: 20px;">
			<div class="pds1">
				<label class="w3-card btn active w3-button" id="cust" style="width: 100%; max-width: 300px;"> 
					<input type="radio" id="selCus" class="inputnone ipn ipnnn" name="type" value="의뢰인" required> 
					<img src="../module/images1/cus.png" alt="Avatar" class="pd10" style="width: 100%; opacity: 0.85;">
					<div class="w3-container" id="nnn">
						<h4><b>의뢰자</b></h4>
						<p>의뢰자는 본인이 원하는 디자인에 관해 <br> 공모할 수 있습니다.</p>
					</div>
				</label>
			</div>
			<div class="pds1">
				<label class="w3-card btn w3-button" id="desi" style="width: 100%; max-width: 300px;"> 
					<input type="radio" id="selDes" class=" ipn ipnnn" name="type" value="디자이너" required> 
					<img src="../module/images1/des.png" alt="Avatar" class="pd10" style="width: 100%; opacity: 0.85;">
					<div class="w3-container" id="mmm">
						<h4><b>디자이너</b></h4>
						<p>디자이너는 자신의 포트폴리오를 보여주고<br> 원하는 공모전에 응모할 수 있습니다.</p>
					</div>
				</label>
			</div>
		</div>
		<div class="row justify-content-center" style="padding-top: 40px;">
			<div class="insertsignn col-md-8">
				<div class="container col-md-9 ">
					<h4 class="text-center paddingb"><span id="selecMem"></span>상세입력</h4>
					<div class="py-3 row">
						<label class="col-sm-3">아이디</label>
						<div class="input-group col-sm-9" style="padding: 0;">
							<input name="id" type="text" placeholder="ID" class="form-control inp" id="userId" required>
							<div class="input-group-append">
								<button type="button" class="btn btn-outline-secondary inpb" id="confirmId">중복아이디 확인</button>
							</div>
							<span class="error_next_box col-9 offset-sm-3" id="idMsg"></span>
						</div>
					</div>
					<div class="py-3 row">
						<label class="col-sm-3">비밀번호</label> 
						<input type="password" placeholder="Password" class="col-sm-9 inp" required>
					</div>
					<div class="py-3 row">
						<label class="col-sm-3">비밀번호 재확인</label>
						<div class="col-sm-9" style="padding: 0;">
							<input name="passwd" type="password" placeholder="Password" required id="pwCheck" class="inp w-100"> 
							<span class="error_next_box col-9 offset-sm-3" id="pwMsg"></span>
						</div>
					</div>
					<div class="py-3 row">
						<label class="col-sm-3">이름</label> 
						<input name="name" type="text" placeholder="Name" class="col-sm-9 inp" required>
					</div>
					<div class="py-3 row">
						<label class="col-sm-3">Email</label> 
						<input name="email" type="text" placeholder="Email" class="col-sm-9 inp">
					</div>
					<div class="py-3 row">
						<label class="col-sm-3">전화번호</label> 
						<input name="tel" type="text" placeholder="Tel" class="col-sm-9 inp">
					</div>
				</div>
				<p class="text-center py-5">
					<button class="btn btnOr btn-lg" id="join">회원가입</button>
				</p>
			</div>
		</div>
	</form>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />