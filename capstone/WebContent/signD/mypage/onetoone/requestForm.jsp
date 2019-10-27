<%@page import="signD.member.OneToOneAnswerDataBean"%>
<%@page import="signD.member.OneToOneAnswerDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.OneToOneRequestDataBean"%>
<%@page import="signD.member.OneToOneRequestDBBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%!int pageSize = 10;
	DecimalFormat decimal = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	String tab2 = request.getParameter("tab2");
	if (tab2 == null) {
		tab2 = "";
	}
	OneToOneRequestDBBean rqdb = OneToOneRequestDBBean.getInstance();
	List<OneToOneRequestDataBean> rqlist = null;
	OneToOneRequestDataBean rq = null;
	
	OneToOneAnswerDBBean answerdb = OneToOneAnswerDBBean.getInstance();
	OneToOneAnswerDataBean answer=null;
	
	
	LogonDBBean logon = LogonDBBean.getInstance();
	LogonDataBean member = logon.getMember(id);

	int count = 0;
	int number = 0;
	int startRow = 0;
	int currentPage = 0;
	String Dday = "";

	if (id != null) {
%>
<div class="card accordion py-4" id="accordion" style="border: none;">
	<div class="card-title"><h3><b>요청 의뢰글</b></h3></div>
	<table class="table table-hover">
		<colgroup>
			<col width="5%">
			<col width="*%">
			<col width="10%">
			<col width="15%">
		</colgroup>
		<thead>
			<tr style="background: #55555580;color:white">
				<th>No.</th>
				<th>제목</th>
				<th>ID</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
	<%
		count = rqdb.getOneToOneRequestCount(id, "still");
		currentPage = 1;
		startRow = (currentPage - 1) * pageSize + 1;
		number = count - (currentPage - 1) * pageSize;
		if (count == 0) {
	%>
			<tr class="text-center">
            	<th class="py-5" colspan="5">의뢰글이 없습니다.</th>
         	</tr>
	<%
		} else {
			rqlist = rqdb.getOneToOneRequests(id, startRow, pageSize, "still");
			for (int i = 0; i < rqlist.size(); i++) {
				rq = rqlist.get(i);
				Dday = rqdb.getDday(rq.getRequestcode());
	%>		<tr>
            	<th><%=number--%></th>
	            <td id="selOTO">
	            	<span onClick="tableColor();">
	                  <div class="w3-col s10" data-toggle="collapse" data-target="#rq<%=i%>" aria-expanded="true" aria-controls="rq<%=i%>">
	                     <%=rq.getTitle()%>
	                  </div>
	                  <div id="rq<%=i%>" class="collapse py-3" aria-labelledby="rq<%=i%>" data-parent="#accordion">
	                     <jsp:include page="../../contest/briefing.jsp" flush="false">
	                        <jsp:param value="<%=rq.getRequestcode()%>" name="OTOrequestcode" />
	                     </jsp:include>
	                  </div>
	            	</span>
	            </td>
            	<td>
			<%	if (member.getType().equals("디자이너")){ %><%=rq.getRequester_id() %><%}else{%><%=rq.getDesigner_id() %><%} %>
				</td>
				<td class="text-center">
			<%	if (member.getType().equals("디자이너")) {%> 
					<a class="btn btn-outline-dark" role="button" onclick="accept(<%=rq.getRequestcode()%>,1)"> 수락</a> 
					<a class="btn btn-outline-dark offset-1" role="button" onclick="accept(<%=rq.getRequestcode()%>,2)"> 거절</a> 
			<%	} else {
					if (rq.getAccept() == 2) {%>디자이너가 거절한 <br>의뢰입니다.<%}else if(rq.getAccept()==0){%>대기중<%}
			%>
					<button type="button" class="close" name="OTOdelete" onclick="deleteCheck('OTODelPro.jsp?rqcode=<%=rq.getRequestcode()%>')">
						<!-- <span aria-hidden="true">&times;</span> -->
						<img alt="" src="../module/images/Cross.png">
					</button>
			<%	} %>
				</td>
			</tr>
	<%		}
		}%>
		</tbody>
	</table>
</div>
<nav class="navbar navbar-expand-lg navbar-light pt-3 card-title">
	<h3><b>수락된 의뢰글</b></h3>
	<div class="collapse navbar-collapse mr-sm-2"></div>
	<div class="btn-group btn-group-toggle" data-toggle="buttons">
		<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			<li class="nav-item">
				<a class="nav-link btn-outline-dark active" data-toggle="tab" href="#ingOTORequest" role="tab" id="ingOTO"
					aria-controls="ingOTORequest" aria-selected="true" onclick="tab2Change('OTOrequest','ing');">진행중</a>
			</li>
			<li class="nav-item">
				<a class="nav-link btn-outline-dark" data-toggle="tab" href="#endOTORequest" role="tab" id="endOTO"
					aria-controls="endOTORequest" aria-selected="false" onclick="tab2Change('OTOrequest','end');">종료된</a>
			</li>
		</ul>
	</div>
</nav>

<div class="tab-content" id="pills-tabContent">
	<div class="tab-pane fade show active" id="ingOTORequest" role="tabpanel" aria-labelledby="contest-tab">
		<div class="accordion py-4" id="accordion">
			<table class="table table-hover">
				<colgroup>
					<col width="5%">
					<col width="*%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr style="background: #55555580;color:white">
						<th>No.</th>
						<th>제목</th>
						<th>ID</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
		<%
				count = rqdb.getOneToOneRequestCount(id, "ing");
				currentPage = Integer.parseInt(pageNum);
				if (!tab2.equals("ing")) {
					currentPage = 1;
				}
				/* if ((count / 10) + 1 < currentPage) {
					currentPage = count / 10 + 1;
				} */
				startRow = (currentPage - 1) * pageSize + 1;
				number = count - (currentPage - 1) * pageSize;
				
				rqlist = rqdb.getOneToOneRequests(id, startRow, pageSize, "ing");
				if (rqlist == null) {
		%>
					<tr class="text-center">
	                  <th class="py-5"colspan="5">의뢰글이 없습니다.</th>
	               	</tr>
					<%
				} else {
					for (int i = 0; i < rqlist.size(); i++) {
						rq = rqlist.get(i);
						Dday = rqdb.getDday(rq.getRequestcode());
						answer=answerdb.getOneToOneAnswer(rq.getRequestcode(),id);
			%>
					<tr>
						<th><%=number--%></th>
						<td>
							<div data-toggle="collapse" data-target="#ingrq<%=i%>" aria-expanded="true" aria-controls="ingrq<%=i%>">
								<%=rq.getTitle()%>
							</div>
							<div id="ingrq<%=i%>" class="collapse py-3" aria-labelledby="ingrq<%=i%>" data-parent="#accordion">
								<jsp:include page="../../contest/briefing.jsp" flush="false">
									<jsp:param value="<%=rq.getRequestcode()%>" name="OTOrequestcode" />
								</jsp:include>
							</div>
						</td>
						<td>
					<%	if (member.getType().equals("디자이너")){%><%=rq.getRequester_id() %><%}else{%><%=rq.getDesigner_id() %><%} %>
						</td>
						<td>
					<%	if (member.getType().equals("디자이너") && answer==null){%>	
							<button  onclick="location.href='/capstone/signD/otorequest/registerForm.jsp?requestcode=<%=rq.getRequestcode() %>&category=<%=rq.getCategory() %>'"
								class="btn btn-outline-dark">1:1답변</button>
					<%	}else if (answer!=null){%>
							<div data-toggle="modal" data-target="#answer<%=i+1%>">
								<button class="btn btn-outline-dark col-12">1:1답변 보기</button>
							</div>
							<div class="modal fade" id="answer<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
								<jsp:include page="../../otorequest/answer/modal.jsp">
									<jsp:param value="<%=rq.getRequestcode() %>" name="requestcode"/>
								</jsp:include>
							</div>
							<script>
							$(document).ready(function(){
								$('#answer<%=i+1%>').on('shown.bs.modal', function () {
									var minheight=$("#carouselFade<%=answer.getAnswercode()%>").height();
									console.log(minheight);
									document.getElementById("content<%=answer.getAnswercode()%>").style.minHeight=minheight+"px";
								});
							});
							</script> 
					<%	} %>
						</td>
					</tr>
					<%
					}
				}
					%>
				</tbody>
			</table>
		</div>
		<nav aria-label="Page navigation">
			<div class="w3-bar w3-large pagination justify-content-center py-3">
				<%
					if (count > 0) {
							int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//1+1(2)
							int startPage = 1;

							if (currentPage % 10 != 0)//1의자리 숫자가 0이 아니면
								startPage = (int) (currentPage / 10) * 10 + 1;//1,11,21
							else
								startPage = ((int) (currentPage / 10) - 1) * 10 + 1;//1,11,21

							int pageBlock = 10;
							int endPage = startPage + pageBlock - 1;//1+10-1
							if (endPage > pageCount)
								endPage = pageCount;//2
				%>
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=bookmark"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=bookmark"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=bookmark"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
			</div>
		</nav>
	</div>
	<div class="tab-pane fade" id="endOTORequest" role="tabpanel"
		aria-labelledby="designer-tab">
		<div class="accordion py-4" id="accordion">
			<table class="table table-hover">
				<colgroup>
					<col width="5%">
					<col width="*%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr style="background: #55555580;color:white">
						<th>No.</th>
						<th>제목</th>
						<th>ID</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<%
					count = rqdb.getOneToOneRequestCount(id, "end");
					currentPage = Integer.parseInt(pageNum);
					if(!tab2.equals("end")){
						currentPage=1;
					}
					/* if ((count / 10) + 1 < currentPage) {
						currentPage = count / 10 + 1;
					} */
					startRow = (currentPage - 1) * pageSize + 1;
					number = count - (currentPage - 1) * pageSize;
					if (count == 0) {
				%>
					<tr class="text-center">
						<th class="py-5" colspan="5">의뢰글이 없습니다.</th>
					</tr>
					<%
					} else {
						rqlist =  rqdb.getOneToOneRequests(id, startRow, pageSize,"end");
						for (int i = 0; i < rqlist.size(); i++) {
							rq = rqlist.get(i);
							Dday = rqdb.getDday(rq.getRequestcode());
							answer=answerdb.getOneToOneAnswer(rq.getRequestcode(),id);
				%>
					<tr>
						<th><%=number--%></th>
						<td>
							<div data-toggle="collapse" data-target="#endrq<%=i%>" aria-expanded="true" aria-controls="endrq<%=i%>">
								<%=rq.getTitle()%>
							</div>
							<div id="endrq<%=i%>" class="collapse py-3" aria-labelledby="endrq<%=i%>" data-parent="#accordion">
								<jsp:include page="../../contest/briefing.jsp" flush="false">
									<jsp:param value="<%=rq.getRequestcode()%>" name="OTOrequestcode" />
								</jsp:include>
							</div>
						</td>
						<td>
					<%	if (member.getType().equals("디자이너")){%><%=rq.getRequester_id() %><%}else{%><%=rq.getDesigner_id() %><%} %>
						</td>
						<td>
						<%if (answer!=null){%>
							<div class="contest-portfolio-item">
								<div class="contest-portfolio-thumb">
									<div data-toggle="modal" data-target="#answer<%=i+1%>">
										<button class="btn btn-outline-dark">1:1답변 보기</button>
									</div>
									<div class="modal fade" id="answer<%=i+1%>" tabindex="-1" role="dialog" aria-hidden="true">
										<jsp:include page="../../otorequest/answer/modal.jsp">
											<jsp:param value="<%=rq.getRequestcode() %>" name="requestcode"/>
										</jsp:include>
									</div>
								</div>
							</div>
							<script>
							$(document).ready(function(){
								$('#answer<%=i+1%>').on('shown.bs.modal', function () {
									var minheight=$("#carouselFade<%=answer.getAnswercode()%>").height();
									console.log(minheight);
									document.getElementById("content<%=answer.getAnswercode()%>").style.minHeight=minheight+"px";
								});
							});
							</script> 
					<%	} %>
						</td>
					</tr>
					<%
						}
					}
					%>
				</tbody>
			</table>
		</div>
		<nav aria-label="Page navigation">
			<div class="w3-bar w3-large pagination justify-content-center py-3">
				<%
					if (count > 0) {
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//1+1(2)
						int startPage = 1;
		
						if (currentPage % 10 != 0)//1의자리 숫자가 0이 아니면
							startPage = (int) (currentPage / 10) * 10 + 1;//1,11,21
						else
							startPage = ((int) (currentPage / 10) - 1) * 10 + 1;//1,11,21
		
						int pageBlock = 10;
						int endPage = startPage + pageBlock - 1;//1+10-1
						if (endPage > pageCount)
							endPage = pageCount;//2
				%>
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=bookmark"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=bookmark"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=bookmark"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
			</div>
		</nav>
	</div>
</div>

<%
	} else {
%>
<script type="text/javascript">
<!--
	alert('권한이 없습니다.');
	document.location.href = "/capstone/signD/main.jsp";
//-->
</script>
<%
	}
%>