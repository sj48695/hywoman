<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="java.util.List"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String managerId = (String) session.getAttribute("managerId");
	if (managerId == null) {
		managerId = "";
	}
	int rqcode = Integer.parseInt(request.getParameter("requestcode"));
	String requesterId = request.getParameter("requesterId");

	int count = 0;

	LogonDBBean logon = LogonDBBean.getInstance();

	RequestDBBean rqdb = RequestDBBean.getInstance();
	RequestDataBean rq = rqdb.getRequest(rqcode);

	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	List<ParticipationDataBean> pplist = null;
	count = ppdb.getParticipationCount(rqcode);
	ParticipationDataBean pp = null;
	//ParticipationDataBean pp=ppdb.getParticipation(id,rqcode);
%>

<div class="w3-container row py-5">
	<div class="container row justify-content-end pb-2"><font color="darksalmon">※개최한 의뢰자, 참여한 디자이너만 볼 수 있습니다.</font></div>
<%
	if (count == 0) {
%>
 	<img class="row my-5"style="width: auto; height: auto; max-width: 200px; max-height: 200px; 
  		margin-left: auto; margin-right: auto; display: block;" src="../module/images/hmm.png" /> 
	<h5 class="container py-5">등록된 참여작이 없습니다.</h5>
	<script>
		$(document).ready(function(){
			$("#participationBtn").click(function(){
				document.location.href="../designer/participationForm.jsp?requestcode=<%=rq.getRequestcode()%>&category=<%=rq.getCategory()%>";
			});
		});
	</script>
<%
	} else {
		if (id != null) {
			pplist = ppdb.getParticipations(rqcode);
			for (int i = 0; i < pplist.size(); i++) {
				pp = (ParticipationDataBean) pplist.get(i);
				String filenames[] = pp.getFile().split(",");
				if (id.equals(rq.getId()) || managerId.equals("manager") || id.equals(pp.getId())) {//의뢰자이거나,매니저,참여자
%>
	<div class="contest-portfolio-item col-md-3">
		<div class="contest-portfolio-thumb">
			<div data-toggle="modal" data-target="#portfolioDetail<%=i+1%>" onclick="viewCount(<%=pp.getPpcode()%>,0)">
				<img src="../../fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[0]%>" style="height: 200px;">
				<div class="contest-portfolio-overlay">
					<h3><%=pp.getTitle() %></h3>
					<p class="a"><%=pp.getContents() %></p>
					<!-- <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand"> -->
					<!-- <i class="fa fa-search"></i> -->
				</div>
			</div>
			<div class="modal fade" id="portfolioDetail<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
				<jsp:include page="../designer/participationModal.jsp">
					<jsp:param value="<%=pp.getPpcode() %>" name="participationcode"/>
					<jsp:param value="<%=rqcode %>" name="requestcode"/>
					<jsp:param value="<%=requesterId %>" name="requesterId"/>
				</jsp:include>
			</div>
		</div>
		<div class="con_title"><b><%=pp.getTitle()%></b></div>
	</div>
	<script>
		$(document).ready(function(){
			$('#portfolioDetail<%=i+1%>').on('shown.bs.modal', function () {
				var minheight=$("#carouselFade<%=pp.getPpcode()%>").height();
				console.log(minheight);
				document.getElementById("content<%=pp.getPpcode()%>").style.minHeight=minheight+"px";
			});
		});
	</script>
	<%
				}
				%>
	<script>
	$("#participationBtn").click(function(){
		<%if (pp.getId().equals(id)) {//참여자 아이디==세션%>
			alert("이미 참여하신 콘테스트입니다.");
		<%} else if(logon.getMember(id).getType().equals("의뢰인")){%>
			alert("디자이너만 참여 가능합니다.");
		<%} else {%>
			document.location.href="../designer/participationForm.jsp?requestcode=<%=rq.getRequestcode()%>&category=<%=rq.getCategory()%>";
		<%}%>
		});
	</script><% 
				if(!id.equals(rq.getId()) && !managerId.equals("manager") && !id.equals(pp.getId())){
			%>
	<div class="contest-portfolio-item col-md-3">
		<div class="contest-portfolio-thumb">
			<img class="px-1" src="../module/images/rock.png" style="height: 200px;">
			<div class="contest-portfolio-overlay">
				<h3><%=pp.getTitle() %></h3>
				<p class="a"><%=pp.getContents() %></p>
				<!-- <a href="images/gallery/p1.jpg" data-rel="lightbox" class="expand"> -->
				<!-- <i class="fa fa-search"></i> -->
			</div>
		</div>
		<div class="con_title"><b><%=pp.getTitle()%></b></div>
	</div>
			<%
				}
			}
		} else {
	%>
	<div class="container">로그인 후 확인 가능합니다.</div>
<%
		}
	}
%>
</div>