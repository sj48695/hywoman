<%@page import="signD.member.MessageDataBean"%>
<%@page import="signD.member.MessageDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	DecimalFormat price = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	String title = "마이페이지 | DO";
	String id = (String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	String tab=request.getParameter("tab");
	String tab2=request.getParameter("tab2");
	
	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);
	
	MessageDBBean msgdb=MessageDBBean.getInstance();
	int unmsg=msgdb.getUnreadMessageCount(id);

	if (pageNum == null) {
		pageNum = "1";
	}

	if (id != null) {
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<div style="padding-bottom: 50px">
	<jsp:include page="../module/menubar.jsp" flush="false"/>
</div>
<div class="container">
	<div class="row py-5 media">
		<div class="align-self-center">
			<div class="offset-9">
				<a data-toggle="modal" href="#" data-target="#updateimg" class="rounded-circle btn btn-outline-light px-2 py-1 mt-3" 
					style="position: absolute;background-color: darkgray;"><i class="fas fa-cog"></i></a>
			</div>
			<img src="../../imageFile/profileImg/<%=member.getProfileimg()%>" class="rounded-circle m-3" style="width: 100px;height: 100px">
		</div>
		<div class="row w-75 pl-5 align-self-center">
			<div class="w3-col <%if (member.getType().equals("디자이너")) {%>s5<%}else{%>s3<%} %> align-self-center">
				<b><%=member.getName()%>(<%=member.getId()%>)</b>님	|	<%=member.getType()%>
				<%if (member.getType().equals("디자이너")) {%>
				<br>우승횟수 <%=member.getChoosecount() %>회 | 우승상금 <%=price.format(logon.getPrize_money(member.getId()))%>원
				<%}%>
			</div>
			<div class="w3-col s7 align-self-center">
				<%if(unmsg>1){ %><span class="badge badge-pill badge-danger ml-3" 
					style="padding-top: 4px;padding-bottom: 4px;position: absolute;"><%=unmsg %></span><%} %>
				<font size="5"><i class="far fa-envelope" onclick="tab2Change('messages','to')"></i></font>
			</div>
			<div class="w3-col"><br><%=member.getIntroduction()%></div>
		</div>
	</div>	
	<ul class="nav nav-tabs text-center row" id="myTab" role="tablist">
		<%if (member.getType().equals("디자이너")) {if (tab == null) {tab = "profile";}%>
		<li class="nav-item col">
			<a class="nav-link active" id="profile-tab" data-toggle="tab" href="#profile" role="tab"
			aria-controls="profile" aria-selected="true">포트폴리오</a>
		</li>
		<li class="nav-item col">
			<a class="nav-link" id="request-tab" data-toggle="tab" href="#request" role="tab"
				aria-controls="request" aria-selected="false" onclick="tab2Change('request','ing')">콘테스트</a>
		</li>
		<%} else if (member.getType().equals("의뢰인")) {if (tab == null) {tab = "request";tab2 = "ing";}%>
		<li class="nav-item col">
			<a class="nav-link active" id="request-tab" data-toggle="tab" href="#request" role="tab"
				aria-controls="request" aria-selected="true" onclick="tab2Change('request','ing')">콘테스트</a>
		</li>
		<%}%>
		<li class="nav-item col">
			<a class="nav-link" id="alarm-tab" data-toggle="tab" href="#alarm" role="tab" aria-selected="false">알림</a>
		</li>
		<li class="nav-item col">
			<a class="nav-link" id="messages-tab" data-toggle="tab" href="#messages" role="tab" 
				aria-selected="false" onclick="tab2Change('messages','to')">쪽지</a>
		</li>
		<li class="nav-item col">
			<a class="nav-link" id="bookmark-tab" data-toggle="tab" href="#bookmark" role="tab" 
				aria-selected="false" onclick="tab2Change('bookmark','contest')">즐겨찾기</a>
		</li>
		<li class="nav-item col">
			<a class="nav-link" id="OTOrequest-tab" data-toggle="tab" href="#OTOrequest" role="tab" 
				aria-selected="false" onclick="tab2Change('OTOrequest','ing');">1:1의뢰</a>
		</li>
		<li class="nav-item col">
			<a class="nav-link" id="settings-tab" data-toggle="modal" href="#settings"
				data-target="#passwd" role="tab" aria-selected="false">회원정보 수정</a>
		</li>
	</ul>
	<div class="tab-content py-3" id="myTabContent">
		<%
			if (member.getType().equals("디자이너")) {
		%>
		<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
			<jsp:include page="profileForm.jsp">
				<jsp:param value="<%=pageNum %>" name="pageNum"/>
			</jsp:include>
		</div>
		<div class="tab-pane fade" id="request" role="tabpanel" aria-labelledby="request-tab">
			<jsp:include page="requestForm.jsp">
				<jsp:param value="<%=pageNum %>" name="pageNum"/>
			</jsp:include>
		</div>
		<%
			} else if (member.getType().equals("의뢰인")) {
		%>
		<div class="tab-pane fade show active" id="request" role="tabpanel" aria-labelledby="request-tab">
			<jsp:include page="requestForm.jsp">
				<jsp:param value="<%=pageNum %>" name="pageNum"/>
			</jsp:include>
		</div>
		<%
			}
		%>
		<div class="tab-pane fade" id="alarm" role="tabpanel" aria-labelledby="alarm-tab">
			<jsp:include page="alarmForm.jsp" />
		</div>
		<div class="tab-pane fade" id="messages" role="tabpanel" aria-labelledby="messages-tab">
			<jsp:include page="messageForm.jsp">
				<jsp:param value="<%=pageNum %>" name="pageNum"/>
			</jsp:include>
		</div>
		<div class="tab-pane fade" id="bookmark" role="tabpanel" aria-labelledby="bookmark-tab">
			<jsp:include page="bookMarkForm.jsp" />
		</div>
		<div class="tab-pane fade" id="OTOrequest" role="tabpanel" aria-labelledby="OTOrequest-tab">
			<jsp:include page="OTORequestForm.jsp" />
		</div>
		<div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings-tab">
			<jsp:include page="../member/updateMemberForm.jsp" />
		</div>
	</div> 
	<div class="modal fade" id="passwd" tabindex="-1" role="dialog" aria-hidden="true">
		<jsp:include page="../member/passwdForm.jsp" flush="false" />
	</div>
	<hr>
</div>
<div class="modal fade" id="updateimg" tabindex="-1" role="dialog" aria-hidden="true">
	<jsp:include page="../member/imgUpdateForm.jsp" flush="false">
		<jsp:param value="<%=member.getProfileimg()%>" name="profileimg" />
	</jsp:include>
</div>
<%
	if (tab2 == null) {
		if (tab.equals("request")) {
			tab2 = "ing";
		} else if (tab.equals("messages")) {
			tab2 = "to";
		} else if (tab.equals("bookmark")) {
			tab2 = "contest";
		} else if (tab.equals("OTOrequest")){
			tab2 = "ing";
		}
	}
%>
<script type="text/javascript">
	$(document).ready(function(){
		tab2Change('<%=tab%>','<%=tab2%>')
	})
</script>
<jsp:include page="../module/bottom.jsp" flush="false"/>
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