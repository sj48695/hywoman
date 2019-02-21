<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	request.setCharacterEncoding("utf-8");
	String id=(String)session.getAttribute("id");
	if(id==null){id="";}
    int ppcode=Integer.parseInt(request.getParameter("participationcode"));
    int rqcode=Integer.parseInt(request.getParameter("requestcode"));
	String requesterId=request.getParameter("requesterId");
	
	LogonDBBean logon= LogonDBBean.getInstance();
	
    ParticipationDBBean ppdb=ParticipationDBBean.getInstance();
	ParticipationDataBean pp=ppdb.getParticipation(ppcode);
	
	RequestDBBean rqdb=RequestDBBean.getInstance();
	RequestDataBean rq = rqdb.getRequest(rqcode);
	

	String Dday=rqdb.getDday(rq.getRequestcode());
	String filenames[]=pp.getFile().split(",");
    
    %>
<style>
.middle>* {
	vertical-align: middle;
}
</style>

<div class="modal-dialog modal-dialog-centered modal-lg" role="document" style="max-width:1000px">
	<div class="modal-content">
		<div class="modal-body p-0">
			<div class="media row">
				<div id="carouselFade<%=ppcode %>" class="carousel slide pr-0 carousel-fade col-md-8 align-self-center" data-ride="carousel">
					<ol class="carousel-indicators">
				<%
					if(filenames.length>1){
						for (int j = 0; j < filenames.length ; j++) {
				%>
						<li data-target="#carouselFade<%=ppcode%>" data-slide-to="<%=j %>" <%if(j==0){%>class="active"<%} %>></li>
				<%
						}
					}
				%>
					</ol>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[filenames.length-1]%>">
						</div>
				<%
					for (int j = filenames.length - 1; j > 0; j--) {
				%>
						<div class="carousel-item">
							<img class="d-block w-100" src="/capstone/fileSave/participationFile/<%=rq.getCategory()%>/<%=filenames[j - 1]%>">
						</div>
				<%
					}
				%>
					</div>
				<%
					if (filenames.length > 1) {
				%>
					<a class="carousel-control-prev" href="#carouselFade<%=ppcode%>" role="button" data-slide="prev"> 
						<i class="fas fa-angle-left"></i>
						<span class="sr-only">Previous</span>
					</a> 
					<a class="carousel-control-next" href="#carouselFade<%=ppcode%>" role="button" data-slide="next"> 
						<i class="fas fa-angle-right"></i>
						<span class="sr-only">Next</span>
					</a>
				<%
					}
				%>
				</div>
				<div class="col-md-4 pl-3" id="content<%=ppcode %>" style="background-color: #e9ecef;">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="py-4 m-0"><a href="/capstone/signD/contest/requestDetail.jsp?requestcode=<%=rqcode%>"><%=pp.getTitle() %></a></h4>
					<div class="row pl-4 pb-2">
						<img src="../../imageFile/profileImg/<%=logon.getMember(pp.getId()).getProfileimg()%>" class="rounded-circle" style="width: 50px; height: 50px">
						<div class="col-md-8">
							<a href="../designer/profile.jsp?designerId=<%=pp.getId() %>"><%=pp.getId() %></a>
							<br><div class="py-1"><strong>우승횟수 <%=logon.getMember(pp.getId()).getChoosecount() %>회
								<%if (Dday.equals("0")) { %>|	조회수 <%=pp.getViewcount() %>회<%} %>
							</strong></div>
						</div>
					</div>
					<div class="mr-3 mt-2 mb-5" style="height: 430px; border-top:1px solid #BDBDBD;">
						<textarea class="form-control p-2 p-0" cols="20" rows="15" style="border:none; background-color: #e9ecef;" disabled="disabled"><%=pp.getContents()%></textarea>
					</div>
					<div class="pr-4 p-3">
					<%
						if (id.equals(requesterId) && Dday.equals("0")) {//의뢰자 아이디랑 현재 접속 아이디랑 같으면
							if (pp.getPpcode() == rq.getPpcode()) {//의뢰글 채택코드와 현재 참여작코드가 같으면
						%>
						<button class="choose<%=rqcode%> btn btn-dark col-md-12" onclick="choose(<%=rqcode%>,0,true);">채택취소</button>
						<%
							} else if(rq.getPpcode()==0){
						%>
						<button class="choose<%=rqcode%> btn btnOrO col-md-12" onclick="choose(<%=rqcode%>,<%=pp.getPpcode()%>,false);">채택하기</button>
						<%
							}
						} else if (id.equals(pp.getId())) {
							if(!Dday.equals("0")){//마감 전 수정, 삭제 가능
					%> 
						<button onclick="location.href='/capstone/signD/designer/participationUpdateForm.jsp?ppcode=<%=pp.getPpcode()%>&rqcode=<%=rqcode%>'"
							class="btn btnOr offset-1 col-md-5">수정하기</button> 
						<button onclick="deleteCheck('/capstone/signD/designer/participationDeletePro.jsp?ppcode=<%=pp.getPpcode()%>&rqcode=<%=rqcode%>')"
							class="btn col-md-5" style="background-color: darkgray; color: white;">삭제하기</button>
					<%
							} else {//마감후 포트폴리오
					%> 
						<button onclick="portfolioInsert('/capstone/signD/designer/portfolioRegisterForm.jsp?ppcode=<%=pp.getPpcode()%>&rqcode=<%=rqcode%>&category=<%=rq.getCategory()%>')"
							class="btn col-md-12" style="background-color: darkgray; color: white;">포트폴리오 등록</button>
						<script type="text/javascript">
							function portfolioInsert(url){
								if(confirm("포트폴리오에 등록하시겠습니까?")){
									document.location.href=url;
								}
							}
						</script>
					<%
							}
						}
					%></div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
//채택하기/취소하기(requestDetail.jsp-->requestParticipation.jsp)
function choose(rqcode,ppcode,pressed){
	var action="/capstone/signD/contest/ppChoosePro.jsp";
	var form_data = {
			rqcode:rqcode,
			ppcode:ppcode
	};
	if(pressed==false){
		if(confirm("채택하시겠습니까?")){//채택 안되어 있는 경우(채택하기-->채택취소)
			$.ajax({
				type : "POST",
				url : action,
				data : form_data,
				success : function(response) {
					console.log(response);
					if(parseInt(response)==1){
						$(".choose"+rqcode).attr("class","choose"+rqcode+" btn btn-dark col-md-12"); 
						$(".choose"+rqcode).attr("onclick","choose("+rqcode+","+ppcode+",true);");//채택한상태
						$(".choose"+rqcode).html("채택취소");
						$("#chooseText").html('<font color="darksalmon">채택완료된 작품입니다.</font>');
						$("#detailImg").attr("src","/capstone/fileSave/participationFile/<%=rq.getCategory() %>/<%=filenames[0] %>");
						
						alert("채택하였습니다.");
					}else{
						alert("다시 시도해 주세요.");
					}
				},
				error : function() {
					console.log("error!"+action+"."+form_data.rqcode+"."+form_data.ppcode);
				}
			});
		}
	}else if(pressed==true){
		if(confirm("채택을 취소하시겠습니까?")){//채택 되어있는 경우(채택취소-->채택하기)
			$.ajax({
				type : "POST",
				url : action,
				data : form_data,
				success : function(response) {
					console.log(response);
					if(parseInt(response)==1){
						$(".choose"+rqcode).attr("class","choose"+rqcode+" btn btnOrO col-md-12"); 
						$(".choose"+rqcode).attr("onclick","choose("+rqcode+","+ppcode+",false);");//채택한상태
						$(".choose"+rqcode).html("채택하기");
						$("#chooseText").html("");
						$("#detailImg").attr("src","/capstone/signD/module/images/<%=rq.getCategory()%>.jpg");
						alert("채택취소하였습니다.");
					}else{
						alert("다시 시도해 주세요.");
					}
				},
				error : function() {
					console.log("error!"+action+"."+form_data.rqcode+"."+form_data.ppcode);
				}
			});
		}
	}
}
</script>