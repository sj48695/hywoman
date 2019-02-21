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
			<input hidden="true" name="category" value="<%=category%>" >
			<input hidden="true" name="plans">
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
				<textarea class="inparea mx-5" name="service" rows="6"
					placeholder="ex) DO는 디자인을 필요로 하는 사람들이 다양한 디자인(로고, 패키지, 웹 디자인 등)에 대한 콘테스트를 개최하고 
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
				<label class="lbr pb-4">5. 색상<font color="darksalmon">＊</font>
					<input type="checkbox" id="colorchk" value="free" onclick="colorChk()">
					<label for="colorchk">색을 정하기 힘드시면 '자유롭게'를 선택해주세요.</label>
				</label>
				<div class="w3-col l4 text-center" >
					<div style="margin:auto;width:236px;">
						<img style="margin-right:2px;" src="https://www.w3schools.com/colors/img_colormap.gif" usemap="#colormap" alt="colormap">
						<map id="colormap" name="colormap" onmouseout="mouseOutMap()"><area style="cursor:pointer" shape="poly" coords="63,0,72,4,72,15,63,19,54,15,54,4" onclick="clickColor(&quot;#003366&quot;,-200,54)" onmouseover="mouseOverColor(&quot;#003366&quot;)" alt="#003366"><area style="cursor:pointer" shape="poly" coords="81,0,90,4,90,15,81,19,72,15,72,4" onclick="clickColor(&quot;#336699&quot;,-200,72)" onmouseover="mouseOverColor(&quot;#336699&quot;)" alt="#336699"><area style="cursor:pointer" shape="poly" coords="99,0,108,4,108,15,99,19,90,15,90,4" onclick="clickColor(&quot;#3366CC&quot;,-200,90)" onmouseover="mouseOverColor(&quot;#3366CC&quot;)" alt="#3366CC"><area style="cursor:pointer" shape="poly" coords="117,0,126,4,126,15,117,19,108,15,108,4" onclick="clickColor(&quot;#003399&quot;,-200,108)" onmouseover="mouseOverColor(&quot;#003399&quot;)" alt="#003399"><area style="cursor:pointer" shape="poly" coords="135,0,144,4,144,15,135,19,126,15,126,4" onclick="clickColor(&quot;#000099&quot;,-200,126)" onmouseover="mouseOverColor(&quot;#000099&quot;)" alt="#000099"><area style="cursor:pointer" shape="poly" coords="153,0,162,4,162,15,153,19,144,15,144,4" onclick="clickColor(&quot;#0000CC&quot;,-200,144)" onmouseover="mouseOverColor(&quot;#0000CC&quot;)" alt="#0000CC"><area style="cursor:pointer" shape="poly" coords="171,0,180,4,180,15,171,19,162,15,162,4" onclick="clickColor(&quot;#000066&quot;,-200,162)" onmouseover="mouseOverColor(&quot;#000066&quot;)" alt="#000066"><area style="cursor:pointer" shape="poly" coords="54,15,63,19,63,30,54,34,45,30,45,19" onclick="clickColor(&quot;#006666&quot;,-185,45)" onmouseover="mouseOverColor(&quot;#006666&quot;)" alt="#006666"><area style="cursor:pointer" shape="poly" coords="72,15,81,19,81,30,72,34,63,30,63,19" onclick="clickColor(&quot;#006699&quot;,-185,63)" onmouseover="mouseOverColor(&quot;#006699&quot;)" alt="#006699"><area style="cursor:pointer" shape="poly" coords="90,15,99,19,99,30,90,34,81,30,81,19" onclick="clickColor(&quot;#0099CC&quot;,-185,81)" onmouseover="mouseOverColor(&quot;#0099CC&quot;)" alt="#0099CC"><area style="cursor:pointer" shape="poly" coords="108,15,117,19,117,30,108,34,99,30,99,19" onclick="clickColor(&quot;#0066CC&quot;,-185,99)" onmouseover="mouseOverColor(&quot;#0066CC&quot;)" alt="#0066CC"><area style="cursor:pointer" shape="poly" coords="126,15,135,19,135,30,126,34,117,30,117,19" onclick="clickColor(&quot;#0033CC&quot;,-185,117)" onmouseover="mouseOverColor(&quot;#0033CC&quot;)" alt="#0033CC"><area style="cursor:pointer" shape="poly" coords="144,15,153,19,153,30,144,34,135,30,135,19" onclick="clickColor(&quot;#0000FF&quot;,-185,135)" onmouseover="mouseOverColor(&quot;#0000FF&quot;)" alt="#0000FF"><area style="cursor:pointer" shape="poly" coords="162,15,171,19,171,30,162,34,153,30,153,19" onclick="clickColor(&quot;#3333FF&quot;,-185,153)" onmouseover="mouseOverColor(&quot;#3333FF&quot;)" alt="#3333FF"><area style="cursor:pointer" shape="poly" coords="180,15,189,19,189,30,180,34,171,30,171,19" onclick="clickColor(&quot;#333399&quot;,-185,171)" onmouseover="mouseOverColor(&quot;#333399&quot;)" alt="#333399"><area style="cursor:pointer" shape="poly" coords="45,30,54,34,54,45,45,49,36,45,36,34" onclick="clickColor(&quot;#669999&quot;,-170,36)" onmouseover="mouseOverColor(&quot;#669999&quot;)" alt="#669999"><area style="cursor:pointer" shape="poly" coords="63,30,72,34,72,45,63,49,54,45,54,34" onclick="clickColor(&quot;#009999&quot;,-170,54)" onmouseover="mouseOverColor(&quot;#009999&quot;)" alt="#009999"><area style="cursor:pointer" shape="poly" coords="81,30,90,34,90,45,81,49,72,45,72,34" onclick="clickColor(&quot;#33CCCC&quot;,-170,72)" onmouseover="mouseOverColor(&quot;#33CCCC&quot;)" alt="#33CCCC"><area style="cursor:pointer" shape="poly" coords="99,30,108,34,108,45,99,49,90,45,90,34" onclick="clickColor(&quot;#00CCFF&quot;,-170,90)" onmouseover="mouseOverColor(&quot;#00CCFF&quot;)" alt="#00CCFF"><area style="cursor:pointer" shape="poly" coords="117,30,126,34,126,45,117,49,108,45,108,34" onclick="clickColor(&quot;#0099FF&quot;,-170,108)" onmouseover="mouseOverColor(&quot;#0099FF&quot;)" alt="#0099FF"><area style="cursor:pointer" shape="poly" coords="135,30,144,34,144,45,135,49,126,45,126,34" onclick="clickColor(&quot;#0066FF&quot;,-170,126)" onmouseover="mouseOverColor(&quot;#0066FF&quot;)" alt="#0066FF"><area style="cursor:pointer" shape="poly" coords="153,30,162,34,162,45,153,49,144,45,144,34" onclick="clickColor(&quot;#3366FF&quot;,-170,144)" onmouseover="mouseOverColor(&quot;#3366FF&quot;)" alt="#3366FF"><area style="cursor:pointer" shape="poly" coords="171,30,180,34,180,45,171,49,162,45,162,34" onclick="clickColor(&quot;#3333CC&quot;,-170,162)" onmouseover="mouseOverColor(&quot;#3333CC&quot;)" alt="#3333CC"><area style="cursor:pointer" shape="poly" coords="189,30,198,34,198,45,189,49,180,45,180,34" onclick="clickColor(&quot;#666699&quot;,-170,180)" onmouseover="mouseOverColor(&quot;#666699&quot;)" alt="#666699"><area style="cursor:pointer" shape="poly" coords="36,45,45,49,45,60,36,64,27,60,27,49" onclick="clickColor(&quot;#339966&quot;,-155,27)" onmouseover="mouseOverColor(&quot;#339966&quot;)" alt="#339966"><area style="cursor:pointer" shape="poly" coords="54,45,63,49,63,60,54,64,45,60,45,49" onclick="clickColor(&quot;#00CC99&quot;,-155,45)" onmouseover="mouseOverColor(&quot;#00CC99&quot;)" alt="#00CC99"><area style="cursor:pointer" shape="poly" coords="72,45,81,49,81,60,72,64,63,60,63,49" onclick="clickColor(&quot;#00FFCC&quot;,-155,63)" onmouseover="mouseOverColor(&quot;#00FFCC&quot;)" alt="#00FFCC"><area style="cursor:pointer" shape="poly" coords="90,45,99,49,99,60,90,64,81,60,81,49" onclick="clickColor(&quot;#00FFFF&quot;,-155,81)" onmouseover="mouseOverColor(&quot;#00FFFF&quot;)" alt="#00FFFF"><area style="cursor:pointer" shape="poly" coords="108,45,117,49,117,60,108,64,99,60,99,49" onclick="clickColor(&quot;#33CCFF&quot;,-155,99)" onmouseover="mouseOverColor(&quot;#33CCFF&quot;)" alt="#33CCFF"><area style="cursor:pointer" shape="poly" coords="126,45,135,49,135,60,126,64,117,60,117,49" onclick="clickColor(&quot;#3399FF&quot;,-155,117)" onmouseover="mouseOverColor(&quot;#3399FF&quot;)" alt="#3399FF"><area style="cursor:pointer" shape="poly" coords="144,45,153,49,153,60,144,64,135,60,135,49" onclick="clickColor(&quot;#6699FF&quot;,-155,135)" onmouseover="mouseOverColor(&quot;#6699FF&quot;)" alt="#6699FF"><area style="cursor:pointer" shape="poly" coords="162,45,171,49,171,60,162,64,153,60,153,49" onclick="clickColor(&quot;#6666FF&quot;,-155,153)" onmouseover="mouseOverColor(&quot;#6666FF&quot;)" alt="#6666FF"><area style="cursor:pointer" shape="poly" coords="180,45,189,49,189,60,180,64,171,60,171,49" onclick="clickColor(&quot;#6600FF&quot;,-155,171)" onmouseover="mouseOverColor(&quot;#6600FF&quot;)" alt="#6600FF"><area style="cursor:pointer" shape="poly" coords="198,45,207,49,207,60,198,64,189,60,189,49" onclick="clickColor(&quot;#6600CC&quot;,-155,189)" onmouseover="mouseOverColor(&quot;#6600CC&quot;)" alt="#6600CC"><area style="cursor:pointer" shape="poly" coords="27,60,36,64,36,75,27,79,18,75,18,64" onclick="clickColor(&quot;#339933&quot;,-140,18)" onmouseover="mouseOverColor(&quot;#339933&quot;)" alt="#339933"><area style="cursor:pointer" shape="poly" coords="45,60,54,64,54,75,45,79,36,75,36,64" onclick="clickColor(&quot;#00CC66&quot;,-140,36)" onmouseover="mouseOverColor(&quot;#00CC66&quot;)" alt="#00CC66"><area style="cursor:pointer" shape="poly" coords="63,60,72,64,72,75,63,79,54,75,54,64" onclick="clickColor(&quot;#00FF99&quot;,-140,54)" onmouseover="mouseOverColor(&quot;#00FF99&quot;)" alt="#00FF99"><area style="cursor:pointer" shape="poly" coords="81,60,90,64,90,75,81,79,72,75,72,64" onclick="clickColor(&quot;#66FFCC&quot;,-140,72)" onmouseover="mouseOverColor(&quot;#66FFCC&quot;)" alt="#66FFCC"><area style="cursor:pointer" shape="poly" coords="99,60,108,64,108,75,99,79,90,75,90,64" onclick="clickColor(&quot;#66FFFF&quot;,-140,90)" onmouseover="mouseOverColor(&quot;#66FFFF&quot;)" alt="#66FFFF"><area style="cursor:pointer" shape="poly" coords="117,60,126,64,126,75,117,79,108,75,108,64" onclick="clickColor(&quot;#66CCFF&quot;,-140,108)" onmouseover="mouseOverColor(&quot;#66CCFF&quot;)" alt="#66CCFF"><area style="cursor:pointer" shape="poly" coords="135,60,144,64,144,75,135,79,126,75,126,64" onclick="clickColor(&quot;#99CCFF&quot;,-140,126)" onmouseover="mouseOverColor(&quot;#99CCFF&quot;)" alt="#99CCFF"><area style="cursor:pointer" shape="poly" coords="153,60,162,64,162,75,153,79,144,75,144,64" onclick="clickColor(&quot;#9999FF&quot;,-140,144)" onmouseover="mouseOverColor(&quot;#9999FF&quot;)" alt="#9999FF"><area style="cursor:pointer" shape="poly" coords="171,60,180,64,180,75,171,79,162,75,162,64" onclick="clickColor(&quot;#9966FF&quot;,-140,162)" onmouseover="mouseOverColor(&quot;#9966FF&quot;)" alt="#9966FF"><area style="cursor:pointer" shape="poly" coords="189,60,198,64,198,75,189,79,180,75,180,64" onclick="clickColor(&quot;#9933FF&quot;,-140,180)" onmouseover="mouseOverColor(&quot;#9933FF&quot;)" alt="#9933FF"><area style="cursor:pointer" shape="poly" coords="207,60,216,64,216,75,207,79,198,75,198,64" onclick="clickColor(&quot;#9900FF&quot;,-140,198)" onmouseover="mouseOverColor(&quot;#9900FF&quot;)" alt="#9900FF"><area style="cursor:pointer" shape="poly" coords="18,75,27,79,27,90,18,94,9,90,9,79" onclick="clickColor(&quot;#006600&quot;,-125,9)" onmouseover="mouseOverColor(&quot;#006600&quot;)" alt="#006600"><area style="cursor:pointer" shape="poly" coords="36,75,45,79,45,90,36,94,27,90,27,79" onclick="clickColor(&quot;#00CC00&quot;,-125,27)" onmouseover="mouseOverColor(&quot;#00CC00&quot;)" alt="#00CC00"><area style="cursor:pointer" shape="poly" coords="54,75,63,79,63,90,54,94,45,90,45,79" onclick="clickColor(&quot;#00FF00&quot;,-125,45)" onmouseover="mouseOverColor(&quot;#00FF00&quot;)" alt="#00FF00"><area style="cursor:pointer" shape="poly" coords="72,75,81,79,81,90,72,94,63,90,63,79" onclick="clickColor(&quot;#66FF99&quot;,-125,63)" onmouseover="mouseOverColor(&quot;#66FF99&quot;)" alt="#66FF99"><area style="cursor:pointer" shape="poly" coords="90,75,99,79,99,90,90,94,81,90,81,79" onclick="clickColor(&quot;#99FFCC&quot;,-125,81)" onmouseover="mouseOverColor(&quot;#99FFCC&quot;)" alt="#99FFCC"><area style="cursor:pointer" shape="poly" coords="108,75,117,79,117,90,108,94,99,90,99,79" onclick="clickColor(&quot;#CCFFFF&quot;,-125,99)" onmouseover="mouseOverColor(&quot;#CCFFFF&quot;)" alt="#CCFFFF"><area style="cursor:pointer" shape="poly" coords="126,75,135,79,135,90,126,94,117,90,117,79" onclick="clickColor(&quot;#CCCCFF&quot;,-125,117)" onmouseover="mouseOverColor(&quot;#CCCCFF&quot;)" alt="#CCCCFF"><area style="cursor:pointer" shape="poly" coords="144,75,153,79,153,90,144,94,135,90,135,79" onclick="clickColor(&quot;#CC99FF&quot;,-125,135)" onmouseover="mouseOverColor(&quot;#CC99FF&quot;)" alt="#CC99FF"><area style="cursor:pointer" shape="poly" coords="162,75,171,79,171,90,162,94,153,90,153,79" onclick="clickColor(&quot;#CC66FF&quot;,-125,153)" onmouseover="mouseOverColor(&quot;#CC66FF&quot;)" alt="#CC66FF"><area style="cursor:pointer" shape="poly" coords="180,75,189,79,189,90,180,94,171,90,171,79" onclick="clickColor(&quot;#CC33FF&quot;,-125,171)" onmouseover="mouseOverColor(&quot;#CC33FF&quot;)" alt="#CC33FF"><area style="cursor:pointer" shape="poly" coords="198,75,207,79,207,90,198,94,189,90,189,79" onclick="clickColor(&quot;#CC00FF&quot;,-125,189)" onmouseover="mouseOverColor(&quot;#CC00FF&quot;)" alt="#CC00FF"><area style="cursor:pointer" shape="poly" coords="216,75,225,79,225,90,216,94,207,90,207,79" onclick="clickColor(&quot;#9900CC&quot;,-125,207)" onmouseover="mouseOverColor(&quot;#9900CC&quot;)" alt="#9900CC"><area style="cursor:pointer" shape="poly" coords="9,90,18,94,18,105,9,109,0,105,0,94" onclick="clickColor(&quot;#003300&quot;,-110,0)" onmouseover="mouseOverColor(&quot;#003300&quot;)" alt="#003300"><area style="cursor:pointer" shape="poly" coords="27,90,36,94,36,105,27,109,18,105,18,94" onclick="clickColor(&quot;#009933&quot;,-110,18)" onmouseover="mouseOverColor(&quot;#009933&quot;)" alt="#009933"><area style="cursor:pointer" shape="poly" coords="45,90,54,94,54,105,45,109,36,105,36,94" onclick="clickColor(&quot;#33CC33&quot;,-110,36)" onmouseover="mouseOverColor(&quot;#33CC33&quot;)" alt="#33CC33"><area style="cursor:pointer" shape="poly" coords="63,90,72,94,72,105,63,109,54,105,54,94" onclick="clickColor(&quot;#66FF66&quot;,-110,54)" onmouseover="mouseOverColor(&quot;#66FF66&quot;)" alt="#66FF66"><area style="cursor:pointer" shape="poly" coords="81,90,90,94,90,105,81,109,72,105,72,94" onclick="clickColor(&quot;#99FF99&quot;,-110,72)" onmouseover="mouseOverColor(&quot;#99FF99&quot;)" alt="#99FF99"><area style="cursor:pointer" shape="poly" coords="99,90,108,94,108,105,99,109,90,105,90,94" onclick="clickColor(&quot;#CCFFCC&quot;,-110,90)" onmouseover="mouseOverColor(&quot;#CCFFCC&quot;)" alt="#CCFFCC"><area style="cursor:pointer" shape="poly" coords="117,90,126,94,126,105,117,109,108,105,108,94" onclick="clickColor(&quot;#FFFFFF&quot;,-110,108)" onmouseover="mouseOverColor(&quot;#FFFFFF&quot;)" alt="#FFFFFF"><area style="cursor:pointer" shape="poly" coords="135,90,144,94,144,105,135,109,126,105,126,94" onclick="clickColor(&quot;#FFCCFF&quot;,-110,126)" onmouseover="mouseOverColor(&quot;#FFCCFF&quot;)" alt="#FFCCFF"><area style="cursor:pointer" shape="poly" coords="153,90,162,94,162,105,153,109,144,105,144,94" onclick="clickColor(&quot;#FF99FF&quot;,-110,144)" onmouseover="mouseOverColor(&quot;#FF99FF&quot;)" alt="#FF99FF"><area style="cursor:pointer" shape="poly" coords="171,90,180,94,180,105,171,109,162,105,162,94" onclick="clickColor(&quot;#FF66FF&quot;,-110,162)" onmouseover="mouseOverColor(&quot;#FF66FF&quot;)" alt="#FF66FF"><area style="cursor:pointer" shape="poly" coords="189,90,198,94,198,105,189,109,180,105,180,94" onclick="clickColor(&quot;#FF00FF&quot;,-110,180)" onmouseover="mouseOverColor(&quot;#FF00FF&quot;)" alt="#FF00FF"><area style="cursor:pointer" shape="poly" coords="207,90,216,94,216,105,207,109,198,105,198,94" onclick="clickColor(&quot;#CC00CC&quot;,-110,198)" onmouseover="mouseOverColor(&quot;#CC00CC&quot;)" alt="#CC00CC"><area style="cursor:pointer" shape="poly" coords="225,90,234,94,234,105,225,109,216,105,216,94" onclick="clickColor(&quot;#660066&quot;,-110,216)" onmouseover="mouseOverColor(&quot;#660066&quot;)" alt="#660066"><area style="cursor:pointer" shape="poly" coords="18,105,27,109,27,120,18,124,9,120,9,109" onclick="clickColor(&quot;#336600&quot;,-95,9)" onmouseover="mouseOverColor(&quot;#336600&quot;)" alt="#336600"><area style="cursor:pointer" shape="poly" coords="36,105,45,109,45,120,36,124,27,120,27,109" onclick="clickColor(&quot;#009900&quot;,-95,27)" onmouseover="mouseOverColor(&quot;#009900&quot;)" alt="#009900"><area style="cursor:pointer" shape="poly" coords="54,105,63,109,63,120,54,124,45,120,45,109" onclick="clickColor(&quot;#66FF33&quot;,-95,45)" onmouseover="mouseOverColor(&quot;#66FF33&quot;)" alt="#66FF33"><area style="cursor:pointer" shape="poly" coords="72,105,81,109,81,120,72,124,63,120,63,109" onclick="clickColor(&quot;#99FF66&quot;,-95,63)" onmouseover="mouseOverColor(&quot;#99FF66&quot;)" alt="#99FF66"><area style="cursor:pointer" shape="poly" coords="90,105,99,109,99,120,90,124,81,120,81,109" onclick="clickColor(&quot;#CCFF99&quot;,-95,81)" onmouseover="mouseOverColor(&quot;#CCFF99&quot;)" alt="#CCFF99"><area style="cursor:pointer" shape="poly" coords="108,105,117,109,117,120,108,124,99,120,99,109" onclick="clickColor(&quot;#FFFFCC&quot;,-95,99)" onmouseover="mouseOverColor(&quot;#FFFFCC&quot;)" alt="#FFFFCC"><area style="cursor:pointer" shape="poly" coords="126,105,135,109,135,120,126,124,117,120,117,109" onclick="clickColor(&quot;#FFCCCC&quot;,-95,117)" onmouseover="mouseOverColor(&quot;#FFCCCC&quot;)" alt="#FFCCCC"><area style="cursor:pointer" shape="poly" coords="144,105,153,109,153,120,144,124,135,120,135,109" onclick="clickColor(&quot;#FF99CC&quot;,-95,135)" onmouseover="mouseOverColor(&quot;#FF99CC&quot;)" alt="#FF99CC"><area style="cursor:pointer" shape="poly" coords="162,105,171,109,171,120,162,124,153,120,153,109" onclick="clickColor(&quot;#FF66CC&quot;,-95,153)" onmouseover="mouseOverColor(&quot;#FF66CC&quot;)" alt="#FF66CC"><area style="cursor:pointer" shape="poly" coords="180,105,189,109,189,120,180,124,171,120,171,109" onclick="clickColor(&quot;#FF33CC&quot;,-95,171)" onmouseover="mouseOverColor(&quot;#FF33CC&quot;)" alt="#FF33CC"><area style="cursor:pointer" shape="poly" coords="198,105,207,109,207,120,198,124,189,120,189,109" onclick="clickColor(&quot;#CC0099&quot;,-95,189)" onmouseover="mouseOverColor(&quot;#CC0099&quot;)" alt="#CC0099"><area style="cursor:pointer" shape="poly" coords="216,105,225,109,225,120,216,124,207,120,207,109" onclick="clickColor(&quot;#993399&quot;,-95,207)" onmouseover="mouseOverColor(&quot;#993399&quot;)" alt="#993399"><area style="cursor:pointer" shape="poly" coords="27,120,36,124,36,135,27,139,18,135,18,124" onclick="clickColor(&quot;#333300&quot;,-80,18)" onmouseover="mouseOverColor(&quot;#333300&quot;)" alt="#333300"><area style="cursor:pointer" shape="poly" coords="45,120,54,124,54,135,45,139,36,135,36,124" onclick="clickColor(&quot;#669900&quot;,-80,36)" onmouseover="mouseOverColor(&quot;#669900&quot;)" alt="#669900"><area style="cursor:pointer" shape="poly" coords="63,120,72,124,72,135,63,139,54,135,54,124" onclick="clickColor(&quot;#99FF33&quot;,-80,54)" onmouseover="mouseOverColor(&quot;#99FF33&quot;)" alt="#99FF33"><area style="cursor:pointer" shape="poly" coords="81,120,90,124,90,135,81,139,72,135,72,124" onclick="clickColor(&quot;#CCFF66&quot;,-80,72)" onmouseover="mouseOverColor(&quot;#CCFF66&quot;)" alt="#CCFF66"><area style="cursor:pointer" shape="poly" coords="99,120,108,124,108,135,99,139,90,135,90,124" onclick="clickColor(&quot;#FFFF99&quot;,-80,90)" onmouseover="mouseOverColor(&quot;#FFFF99&quot;)" alt="#FFFF99"><area style="cursor:pointer" shape="poly" coords="117,120,126,124,126,135,117,139,108,135,108,124" onclick="clickColor(&quot;#FFCC99&quot;,-80,108)" onmouseover="mouseOverColor(&quot;#FFCC99&quot;)" alt="#FFCC99"><area style="cursor:pointer" shape="poly" coords="135,120,144,124,144,135,135,139,126,135,126,124" onclick="clickColor(&quot;#FF9999&quot;,-80,126)" onmouseover="mouseOverColor(&quot;#FF9999&quot;)" alt="#FF9999"><area style="cursor:pointer" shape="poly" coords="153,120,162,124,162,135,153,139,144,135,144,124" onclick="clickColor(&quot;#FF6699&quot;,-80,144)" onmouseover="mouseOverColor(&quot;#FF6699&quot;)" alt="#FF6699"><area style="cursor:pointer" shape="poly" coords="171,120,180,124,180,135,171,139,162,135,162,124" onclick="clickColor(&quot;#FF3399&quot;,-80,162)" onmouseover="mouseOverColor(&quot;#FF3399&quot;)" alt="#FF3399"><area style="cursor:pointer" shape="poly" coords="189,120,198,124,198,135,189,139,180,135,180,124" onclick="clickColor(&quot;#CC3399&quot;,-80,180)" onmouseover="mouseOverColor(&quot;#CC3399&quot;)" alt="#CC3399"><area style="cursor:pointer" shape="poly" coords="207,120,216,124,216,135,207,139,198,135,198,124" onclick="clickColor(&quot;#990099&quot;,-80,198)" onmouseover="mouseOverColor(&quot;#990099&quot;)" alt="#990099"><area style="cursor:pointer" shape="poly" coords="36,135,45,139,45,150,36,154,27,150,27,139" onclick="clickColor(&quot;#666633&quot;,-65,27)" onmouseover="mouseOverColor(&quot;#666633&quot;)" alt="#666633"><area style="cursor:pointer" shape="poly" coords="54,135,63,139,63,150,54,154,45,150,45,139" onclick="clickColor(&quot;#99CC00&quot;,-65,45)" onmouseover="mouseOverColor(&quot;#99CC00&quot;)" alt="#99CC00"><area style="cursor:pointer" shape="poly" coords="72,135,81,139,81,150,72,154,63,150,63,139" onclick="clickColor(&quot;#CCFF33&quot;,-65,63)" onmouseover="mouseOverColor(&quot;#CCFF33&quot;)" alt="#CCFF33"><area style="cursor:pointer" shape="poly" coords="90,135,99,139,99,150,90,154,81,150,81,139" onclick="clickColor(&quot;#FFFF66&quot;,-65,81)" onmouseover="mouseOverColor(&quot;#FFFF66&quot;)" alt="#FFFF66"><area style="cursor:pointer" shape="poly" coords="108,135,117,139,117,150,108,154,99,150,99,139" onclick="clickColor(&quot;#FFCC66&quot;,-65,99)" onmouseover="mouseOverColor(&quot;#FFCC66&quot;)" alt="#FFCC66"><area style="cursor:pointer" shape="poly" coords="126,135,135,139,135,150,126,154,117,150,117,139" onclick="clickColor(&quot;#FF9966&quot;,-65,117)" onmouseover="mouseOverColor(&quot;#FF9966&quot;)" alt="#FF9966"><area style="cursor:pointer" shape="poly" coords="144,135,153,139,153,150,144,154,135,150,135,139" onclick="clickColor(&quot;#FF6666&quot;,-65,135)" onmouseover="mouseOverColor(&quot;#FF6666&quot;)" alt="#FF6666"><area style="cursor:pointer" shape="poly" coords="162,135,171,139,171,150,162,154,153,150,153,139" onclick="clickColor(&quot;#FF0066&quot;,-65,153)" onmouseover="mouseOverColor(&quot;#FF0066&quot;)" alt="#FF0066"><area style="cursor:pointer" shape="poly" coords="180,135,189,139,189,150,180,154,171,150,171,139" onclick="clickColor(&quot;#CC6699&quot;,-65,171)" onmouseover="mouseOverColor(&quot;#CC6699&quot;)" alt="#CC6699"><area style="cursor:pointer" shape="poly" coords="198,135,207,139,207,150,198,154,189,150,189,139" onclick="clickColor(&quot;#993366&quot;,-65,189)" onmouseover="mouseOverColor(&quot;#993366&quot;)" alt="#993366"><area style="cursor:pointer" shape="poly" coords="45,150,54,154,54,165,45,169,36,165,36,154" onclick="clickColor(&quot;#999966&quot;,-50,36)" onmouseover="mouseOverColor(&quot;#999966&quot;)" alt="#999966"><area style="cursor:pointer" shape="poly" coords="63,150,72,154,72,165,63,169,54,165,54,154" onclick="clickColor(&quot;#CCCC00&quot;,-50,54)" onmouseover="mouseOverColor(&quot;#CCCC00&quot;)" alt="#CCCC00"><area style="cursor:pointer" shape="poly" coords="81,150,90,154,90,165,81,169,72,165,72,154" onclick="clickColor(&quot;#FFFF00&quot;,-50,72)" onmouseover="mouseOverColor(&quot;#FFFF00&quot;)" alt="#FFFF00"><area style="cursor:pointer" shape="poly" coords="99,150,108,154,108,165,99,169,90,165,90,154" onclick="clickColor(&quot;#FFCC00&quot;,-50,90)" onmouseover="mouseOverColor(&quot;#FFCC00&quot;)" alt="#FFCC00"><area style="cursor:pointer" shape="poly" coords="117,150,126,154,126,165,117,169,108,165,108,154" onclick="clickColor(&quot;#FF9933&quot;,-50,108)" onmouseover="mouseOverColor(&quot;#FF9933&quot;)" alt="#FF9933"><area style="cursor:pointer" shape="poly" coords="135,150,144,154,144,165,135,169,126,165,126,154" onclick="clickColor(&quot;#FF6600&quot;,-50,126)" onmouseover="mouseOverColor(&quot;#FF6600&quot;)" alt="#FF6600"><area style="cursor:pointer" shape="poly" coords="153,150,162,154,162,165,153,169,144,165,144,154" onclick="clickColor(&quot;#FF5050&quot;,-50,144)" onmouseover="mouseOverColor(&quot;#FF5050&quot;)" alt="#FF5050"><area style="cursor:pointer" shape="poly" coords="171,150,180,154,180,165,171,169,162,165,162,154" onclick="clickColor(&quot;#CC0066&quot;,-50,162)" onmouseover="mouseOverColor(&quot;#CC0066&quot;)" alt="#CC0066"><area style="cursor:pointer" shape="poly" coords="189,150,198,154,198,165,189,169,180,165,180,154" onclick="clickColor(&quot;#660033&quot;,-50,180)" onmouseover="mouseOverColor(&quot;#660033&quot;)" alt="#660033"><area style="cursor:pointer" shape="poly" coords="54,165,63,169,63,180,54,184,45,180,45,169" onclick="clickColor(&quot;#996633&quot;,-35,45)" onmouseover="mouseOverColor(&quot;#996633&quot;)" alt="#996633"><area style="cursor:pointer" shape="poly" coords="72,165,81,169,81,180,72,184,63,180,63,169" onclick="clickColor(&quot;#CC9900&quot;,-35,63)" onmouseover="mouseOverColor(&quot;#CC9900&quot;)" alt="#CC9900"><area style="cursor:pointer" shape="poly" coords="90,165,99,169,99,180,90,184,81,180,81,169" onclick="clickColor(&quot;#FF9900&quot;,-35,81)" onmouseover="mouseOverColor(&quot;#FF9900&quot;)" alt="#FF9900"><area style="cursor:pointer" shape="poly" coords="108,165,117,169,117,180,108,184,99,180,99,169" onclick="clickColor(&quot;#CC6600&quot;,-35,99)" onmouseover="mouseOverColor(&quot;#CC6600&quot;)" alt="#CC6600"><area style="cursor:pointer" shape="poly" coords="126,165,135,169,135,180,126,184,117,180,117,169" onclick="clickColor(&quot;#FF3300&quot;,-35,117)" onmouseover="mouseOverColor(&quot;#FF3300&quot;)" alt="#FF3300"><area style="cursor:pointer" shape="poly" coords="144,165,153,169,153,180,144,184,135,180,135,169" onclick="clickColor(&quot;#FF0000&quot;,-35,135)" onmouseover="mouseOverColor(&quot;#FF0000&quot;)" alt="#FF0000"><area style="cursor:pointer" shape="poly" coords="162,165,171,169,171,180,162,184,153,180,153,169" onclick="clickColor(&quot;#CC0000&quot;,-35,153)" onmouseover="mouseOverColor(&quot;#CC0000&quot;)" alt="#CC0000"><area style="cursor:pointer" shape="poly" coords="180,165,189,169,189,180,180,184,171,180,171,169" onclick="clickColor(&quot;#990033&quot;,-35,171)" onmouseover="mouseOverColor(&quot;#990033&quot;)" alt="#990033"><area style="cursor:pointer" shape="poly" coords="63,180,72,184,72,195,63,199,54,195,54,184" onclick="clickColor(&quot;#663300&quot;,-20,54)" onmouseover="mouseOverColor(&quot;#663300&quot;)" alt="#663300"><area style="cursor:pointer" shape="poly" coords="81,180,90,184,90,195,81,199,72,195,72,184" onclick="clickColor(&quot;#996600&quot;,-20,72)" onmouseover="mouseOverColor(&quot;#996600&quot;)" alt="#996600"><area style="cursor:pointer" shape="poly" coords="99,180,108,184,108,195,99,199,90,195,90,184" onclick="clickColor(&quot;#CC3300&quot;,-20,90)" onmouseover="mouseOverColor(&quot;#CC3300&quot;)" alt="#CC3300"><area style="cursor:pointer" shape="poly" coords="117,180,126,184,126,195,117,199,108,195,108,184" onclick="clickColor(&quot;#993300&quot;,-20,108)" onmouseover="mouseOverColor(&quot;#993300&quot;)" alt="#993300"><area style="cursor:pointer" shape="poly" coords="135,180,144,184,144,195,135,199,126,195,126,184" onclick="clickColor(&quot;#990000&quot;,-20,126)" onmouseover="mouseOverColor(&quot;#990000&quot;)" alt="#990000"><area style="cursor:pointer" shape="poly" coords="153,180,162,184,162,195,153,199,144,195,144,184" onclick="clickColor(&quot;#800000&quot;,-20,144)" onmouseover="mouseOverColor(&quot;#800000&quot;)" alt="#800000"><area style="cursor:pointer" shape="poly" coords="171,180,180,184,180,195,171,199,162,195,162,184" onclick="clickColor(&quot;#993333&quot;,-20,162)" onmouseover="mouseOverColor(&quot;#993333&quot;)" alt="#993333"></map>
						<script>
							var thistop = "-35";
							var thisleft = "135";
						</script>
						<div id="selectedhexagon" style="visibility: visible; position: relative; width: 21px; height: 21px; background-image: url(&quot;https://www.w3schools.com/colors/img_selectedcolor.gif&quot;); top: -110px; left: 108px;"></div>
					    <div id="divpreview" style="visibility: hidden; background-color: rgb(255, 0, 0);">&nbsp;</div>
					</div>
				</div>
				<div class="w3-col l8  w3-row" style="text-align:center;">
					<div id="entercolorDIV" class="input-group w3-col s11 py-3"><h3 class="w3-col s3 mr-3">color select : </h3>
						<input type="text" class="form-control inp" id="entercolor" placeholder="색상을 입력해주세요." onkeydown="submitOnEnter(event)" onfocus="clearWrongInput();" style="z-index: 0;">
						<div class="input-group-append">
							<button class="btn btn-default inpb" type="button" onclick="clickColor(0,-1,-1)" style="z-index: 0;">OK</button>
						</div>
					</div>
					<div id="wronginputDIV" class="w3-col s11" style="display: none;">영어나 RGB코드로 입력해주세요.</div>
					<br>
					<div id="selectedcolor" class="w3-col s3">
						<input class="form-control btn btn-outline-light" type="color" id="html5colorpicker" onchange="clickColor(0, -1, -1, 5)" value="#ff0000" style="width: 120px;height: 120px;padding: 0;">
					</div>
					<div hidden="true" id="colornamDIV" class="w3-margin-top"></div>      
					<input hidden="true" name="color" id="colorhexDIV" value="">
					<div hidden="true" id="colorrgbDIV">rgb(255, 0, 0)</div>
					<div hidden="true" id="colorhslDIV">hsl(260, 100%, 70%)</div>
					<label class="lbr w3-col s8 pt-3">※원하시는 추상적인 색이 있다면 적어주세요.</label>
					<input class="inp w3-col s8" type="text" name="color_detail" placeholder="자세한 설명을 적어주세요.">
				</div>
			</div>
			<div>
				<label class="lbr pb-2">6. 로고사용계획</label>
				<div class="pl-5">
					<div class="input_chk">
						<input type="checkbox" id="product" class="ipn" name="plan-group" value="상품" onchange="otherChange('plan',this.id)"> 
						<label for="product">상품</label>
					</div>
					<div class="input_chk">
						<input type="checkbox" id="business_card" class="ipn" name="plan-group" value="명함" onchange="otherChange('plan',this.id)"> 
						<label for="business_card">명함</label>
					</div>
					<div class="input_chk">
						<input type="checkbox" id="sign" class="ipn" name="plan-group" value="간판" onchange="otherChange('plan',this.id)"> 
						<label for="sign">간판</label>
					</div>
					<div class="input_chk w3-row">
						<input type="checkbox" id="other" class="ipn" name="plan-group" value="other" onchange="otherChange('plan',this.id)"> 
						<label for="other" class="w3-col s2">일반/기타</label> 
						<textarea class="w3-col s9 m-0 inparea plan_other ml-4" rows="3" placeholder="Plan" style="visibility: hidden;" name="plan"></textarea>
					</div>
				</div>
			</div>
			<div class="mb-4">
				<label class="lbr">7. 참고파일 </label> <input class="inp mx-5"
					type="file" name="file" placeholder="File" style="padding: 5px;">
			</div>
			<div class="mb-4">
				<label class="lbr">8. 로고에 표기할 상호명/슬로건<font color="darksalmon">＊</font></label> 
				<input class="inp mx-5" type="text" name="slogan" required
					placeholder="ex1) 영문: DO(Design outsourcing) / 한글: 디자인아웃소싱 별도 제작 요청">
			</div>
			<div class="mb-4">
				<label class="lbr">9. 상세적인 디자인 요구사항<font color="darksalmon">＊</font></label>
				<textarea class="inparea mx-5" name="request" rows="15" required
					placeholder="*의미: 디자인아웃소싱의 의미는 DesignOutsourcing의 줄임말과 누구든 할 수 있다는 do를 합친 단어 입니다.

*활용범위: 웹사이트와 모바일웹,어플로 서비스하는 회사입니다.따라서 사이즈가 작은 어플 아이콘으로도 사용될 수 있게 심플하고 가독성이 좋은 로고를 원합니다."></textarea>
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