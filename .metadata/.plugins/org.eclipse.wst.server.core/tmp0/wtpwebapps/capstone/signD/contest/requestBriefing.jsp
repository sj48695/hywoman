<%@page import="signD.member.OneToOneRequestDataBean"%>
<%@page import="signD.member.OneToOneRequestDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int pageSize = 10;
	SimpleDateFormat sd = new SimpleDateFormat("yyyy. MM. dd (E)");
	SimpleDateFormat ed = new SimpleDateFormat("MM. dd (E)");

	String id = (String) session.getAttribute("id");
	int rqcode = 0;

	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = null;

	if (request.getParameter("requestcode") == null) {
		rqcode = Integer.parseInt(request.getParameter("OTOrequestcode"));

		OneToOneRequestDBBean rqdb = OneToOneRequestDBBean.getInstance();

		OneToOneRequestDataBean rq = rqdb.getOneToOneRequest(rqcode);

		member = logon.getMember(rq.getRequester_id());
%>
<!-- <h2 class="w3-text-grey"><i class="fas fa-clipboard-list fa-fw mr-3 w3-xxlarge"></i>브리핑보기</h2> -->
<div class="w3-container w3-text-grey px-1 py-4">
	<h5><i class="fas fa-angle-right fa-fw mr-1 w3-large w3-text-orange"></i><b>의뢰자 정보</b></h5>
	<div class="ml-4 pt-2">
		<p><i class="fas fa-building fa-fw mr-3 w3-large "></i><%=rq.getCompany_name()%></p>
		<p><i class="fa fa-envelope fa-fw mr-3 w3-large"></i><%=member.getEmail()%></p>
	</div>
	<hr>
	<h5><i class="fas fa-angle-right fa-fw mr-1 w3-large w3-text-orange"></i><b>기업 소개</b></h5>
	<p class="ml-4"><%=rq.getService()%></p>
	<hr>
	<h5><i class="fas fa-angle-right fa-fw mr-1 w3-large w3-text-orange"></i><b>브리핑 보기</b></h5>
	<div class="ml-4">
		<%
			if (rq.getJob_kind() != null && !rq.getJob_kind().equals("null")) {
		%>
		<p><i class="fas fa-circle fa-fw mr-2 w3-small"></i>업종:<%=rq.getJob_kind()%></p>
		<%}if (rq.getColor() != null && !rq.getColor().equals("null")) {
			String colors[] = rq.getColor().split(",");
			String color = colors[0];
			String colordetail = "";
			if(color.length()>1){
				for (int i = 1; i < colors.length; i++) {
					colordetail = colordetail + colors[i];
					if(i!=colors.length-1){
						colordetail +=",";
					}
				}
			}
		%>
		<p id="color<%=rqcode%>">
			<i class="fas fa-circle fa-fw mr-2 w3-small"></i>색상 : 
			<%if (color.equals("자유롭게") || color.equals("free")) {%>자유롭게<%} else {%>
			<input class="form-control btn btn-outline-light" type="color" id="html5colorpicker<%=rqcode%>" onchange="clickColor(0, -1, -1, 5)"
				value="<%=color%>" placeholder="Color value" style="width: 70px; height: 70px; padding: 0;">
			<script> 
			$(document).ready(function (){
				var cObj = w3color("<%=color%>");
				//console.log("<%=color%>"+","+cObj.toHexString()+","+cObj.toName());
				if("<%=colordetail%>"==""){
					$("#color<%=rqcode%>").append(cObj.toName()+"("+cObj.toHexString()+")");
				}else{
					$("#color<%=rqcode%>").append(cObj.toName()+"("+cObj.toHexString()+"),<%=colordetail%>");
				}
				$("#html5colorpicker<%=rqcode%>").val(cObj.toHexString());
			});
			</script>
			<%} %>
		</p>
		<%}if (rq.getPlan() != null && !rq.getPlan().equals("null")) {%>
		<p><i class="fas fa-circle fa-fw mr-2 w3-small"></i>사용계획:<%=rq.getPlan()%></p>
		<%}if (rq.getSlogan() != null && !rq.getSlogan().equals("null")) {%>
		<p><i class="fas fa-circle fa-fw mr-2 w3-small"></i>사용 할 상호명/슬로건 : <%=rq.getSlogan()%></p>
		<%}%>
	</div>
	<hr>
	<%if (rq.getFile() != null && !rq.getFile().equals("") && !rq.getFile().equals("null")) {%>
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>참고파일</b></h5>
	<div class="card">
		<div class="w3-row">
			<p class="w3-col s10"><%=rq.getFile()%> </p>
			<a href='/capstone/signD/contest/fileDownloadPro.jsp?filename=<%=rq.getFile()%>&category=<%=rq.getCategory()%>'
				class="btn btn-outline-dark w3-col s2" >저장</a>
		</div>
	</div><hr>
	<%}%>
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>디자인 요구사항</b></h5>
	<p class="ml-4"><%=rq.getRequest()%></p>
</div>
<%
	} else {
		rqcode = Integer.parseInt(request.getParameter("requestcode"));
		RequestDBBean rqdb = RequestDBBean.getInstance();
		RequestDataBean rq = rqdb.getRequest(rqcode);
		member = logon.getMember(rq.getId());
%>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>의뢰자 정보</b></h5><br>
	<p class="mx-5"><i class="fas fa-building fa-fw mr-3 w3-large "></i> <%=rq.getCompany_name() %></p>
	<p class="mx-5"><i class="fa fa-envelope fa-fw mr-3 w3-large"></i><%=member.getEmail() %></p><hr>
</div>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>기업 소개</b></h5>
	<p class="mx-5"><%=rq.getService()%></p><hr>
</div>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw w3-margin-right w3-large w3-text-orange"></i><b>제출기간</b></h5><br>
	<p class="mx-5"><i class="fas fa-calendar fa-fw w3-margin-right w3-large"></i><%=sd.format(rq.getReg_date())%> ~ <%=ed.format(rq.getEnd_date())%></p><hr>
</div>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>브리핑 상세보기</b></h5>
	<%
		if (rq.getJob_kind() != null && !rq.getJob_kind().equals("null")) {
	%>
	<p class="mx-5"><i class="fas fa-circle fa-fw mr-3 w3-small"></i>업종:<%=rq.getJob_kind()%></p>
	<%	}if (rq.getColor() != null && !rq.getColor().equals("null")) {
			String colors[] = rq.getColor().split(",");
			String color = colors[0];
			String colordetail = "";
			if(colors.length>1){
				for (int i = 1; i < colors.length; i++) {
					colordetail = colordetail + colors[i];
					if(i!=colors.length-1){colordetail +=",";}
				}
			}
	%>
	<p  class="mx-5" id="color">
		<i class="fas fa-circle fa-fw mr-3 w3-small"></i>색상 :
			<%if (color.equals("자유롭게") || color.equals("free")) {%>자유롭게<%} else {%>
		<input class="form-control btn btn-outline-light" type="color" id="html5colorpicker" onchange="clickColor(0, -1, -1, 5)"
			value="<%=color%>" placeholder="Color value" style="width: 70px; height: 70px; padding: 0;">
		<script> 
		$(document).ready(function (){
			var cObj = w3color("<%=color%>");
			//console.log("<%=color%>"+","+cObj.toHexString()+","+cObj.toName());
			if("<%=colordetail%>"==""){
				$("#color").append(cObj.toName()+"("+cObj.toHexString()+")");
			}else{
				$("#color").append(cObj.toName()+"("+cObj.toHexString()+"),<%=colordetail%>");
			}
			$("#html5colorpicker").val(cObj.toHexString());
		});
		</script>
			<%}%>
	</p>
	<%	}if (rq.getPlan() != null && !rq.getPlan().equals("null")) {%>
	<p class="mx-5"><i class="fas fa-circle fa-fw mr-3 w3-small"></i>사용계획 : <%=rq.getPlan()%></p>
	<%	}if (rq.getSlogan() != null && !rq.getSlogan().equals("null")) {%>
	<p class="mx-5"><i class="fas fa-circle fa-fw mr-3 w3-small"></i>사용 할 상호명/슬로건 : <%=rq.getSlogan()%></p>
	<%	}if(rq.getCategory().equals("web")){
			if (rq.getPages()!=null && !rq.getPages().equals("null")) {%>
	<p class="mx-5"><i class="fas fa-circle fa-fw mr-3 w3-small"></i>페이지 수 : <%=rq.getPages()%></p>
		<%	} if (rq.getWebsite()!=null && !rq.getWebsite().equals("null")) {%>
	<p class="mx-5"><i class="fas fa-circle fa-fw mr-3 w3-small"></i>참고 웹사이트 : <%=rq.getWebsite()%></p>
	<% 		}
		}
	%>
	<hr>
</div>
	<%if (rq.getFile() != null && !rq.getFile().equals("") && !rq.getFile().equals("null")) {%>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>참고파일</b></h5>
	<div class="card mx-5">
		<div class="w3-row">
	        <p class="w3-col s10"><%=rq.getFile()%> </p>
			<a href='/capstone/signD/contest/fileDownloadPro.jsp?filename=<%=rq.getFile()%>&category=<%=rq.getCategory()%>'
	      		class="btn btn-outline-dark w3-col s2">저장</a>
		</div>
	</div><hr>
</div>
	<%}%>
<div class="w3-container w3-text-grey py-2">
	<h5><i class="fas fa-angle-right fa-fw mr-3 w3-large w3-text-orange"></i><b>디자인 요구사항</b></h5>
	<p class="mx-5"><%=rq.getRequest()%></p>
</div>
<%
	}
%>