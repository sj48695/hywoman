<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%!DecimalFormat decimal = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	int pageSize = 20;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	String title = "자주하는 질문 등록  | DO";

	RequestDBBean rqdb = RequestDBBean.getInstance();
	List<RequestDataBean> rqlist = null;
	RequestDataBean rq = null;

	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	ParticipationDataBean pp = null;

	String managerId = (String) session.getAttribute("managerId");
	String keyfield = request.getParameter("keyfield");
	String keyword = request.getParameter("keyword");
	String pageNum = request.getParameter("pageNum");
	if (keyword == null) {
		keyword = "";
	}
	if (pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = rqdb.getRequestCount("end");
	int number = count - (currentPage - 1) * pageSize;
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />

<style>
.table td, .table th {
	padding: 0rem;
	padding-top: 10px;
	vertical-align: top;
	border-top: 1px solid #dee2e6;
}
</style>

<div class="py-1 w3-light-grey">
	<div class="w3-content w3-margin-top" style="max-width: 1400px; padding-top: 3.5rem;">
		<div class="row justify-content-end">
			<div style="width: 78%; padding-left: 21px; padding-right: 30px;">
				<form class="form-inline p-0 py-3 " name="search" method="get" action="memberManagementForm.jsp">
					<select name="keyfield" class="col-sm-2" id="keyfield">
						<option value="all">전체</option>
						<option value="title">디자이너명</option>
						<option value="title">의뢰자명</option>
					</select>
					<input type="text" class="form-control col-md-8" placeholder="검색어를 입력하세요" name="keyword" value="<%=keyword%>">
					<button type="submit" class="btn btn-dark col-md-2">검색</button>
				</form>
			</div>
		</div>
		<div class="w3-row-padding">
			<div class="w3-third" style="width: 22%">
				<div class="w3-white w3-text-grey w3-card-4">
					<div class="w3-display-container">
						<img class="mbox" src="/capstone/signD/module/manager.png" style="width: 80%">
					</div>
					<div class="w3-container">
						<div class="w3-bar-block">
							<a href="/capstone/signD/manager/memberManagementForm.jsp" class="w3-bar-item w3-button w3-padding"> 
								<i class="fa fa-user fa-fw w3-margin-right w3-large"></i>회원관리
							</a> 
							<a href="/capstone/signD/manager/prize_moneyDeliveryForm.jsp" class="w3-bar-item w3-button w3-padding  w3-text-teal"> 
								<i class="fas fa-money-bill-alt fa-fw w3-margin-right w3-large"></i>
								<strong>상금관리</strong>
							</a>
						</div>
						<hr>
						<p class="w3-large"><b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-grey"></i>회원</b></p>
						<p>의뢰자</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-grey" style="width: 90%">90%</div>
						</div>
						<br>
						<p>디자이너</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 80%">
								<div class="w3-center w3-text-white">80%</div>
							</div>
						</div>
						<hr>
						<p class="w3-large">
							<b><i class="fa fa-asterisk fa-fw w3-margin-right w3-text-grey"></i>오늘의 방문자수</b>
						</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-grey" style="width: 90%">90%</div>
						</div>
						<br>
						<p>누적 방문자수</p>
						<div class="w3-light-grey w3-round-xlarge w3-small">
							<div class="w3-container w3-center w3-round-xlarge w3-teal" style="width: 80%">
								<div class="w3-center w3-text-white">80%</div>
							</div>
						</div>
						<br>
					</div>
				</div>
			</div>

			<!-- Right Column -->
			<div class="w3-twothird" style="width: 78%">
				<div class="w3-container w3-card w3-white w3-margin-bottom">
					<h4 class="card-title text-center py-4">
						<strong>상금 지급 현황</strong>
					</h4>
					<form method="post" action="prize_moneyDeliveryPro.jsp">
						<table class="table">
							<colgroup>
								<col width="8%">
								<col width="10%">
								<col width="10%">
								<col width="15%">
								<col width="15%">
								<col width="15%">
								<col width="*">
								<col width="8%">
							</colgroup>
							<thead>
								<tr>
									<th style="padding-bottom: 10px;">번호</th>
									<th style="padding-bottom: 10px;">의뢰인</th>
									<th style="padding-bottom: 10px;">채택상황</th>
									<th style="padding-bottom: 10px;">채택된 디자이너</th>
									<th style="padding-bottom: 10px;">상금</th>
									<th style="padding-bottom: 10px;">상금수수료</th>
									<th style="padding-bottom: 10px;">실수령액</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<%
								if (count == 0) {
							%>
								<tr>
									<td colspan="9">종료된 콘테스트가 없습니다.</td>
								</tr>
							<%
								} else {
									rqlist = rqdb.getRequests(startRow, pageSize, "end");
									for (int i = 0; i < rqlist.size(); i++) {
										rq = rqlist.get(i);
										pp = ppdb.getParticipation(rq.getPpcode());
							%>
								<tr>
									<td><%=number--%></td>
									<td><%=rq.getId()%></td>
									<%
										if (rq.getPpcode() > 0) {//채택완료
									%>
									<th>채택완료</th>
									<td><%=pp.getId()%></td>
									<%
										} else {
									%>
									<th>채택중</th>
									<td></td>
									<%
										}
									%>
									<td><%=decimal.format(rq.getCost())%>원</td>
									<%
										if (rq.getSelf_tax() == 1) {//의뢰인 부담
									%>
									<td>0</td>
									<td><%=decimal.format(rq.getCost())%>원 
										<input type="hidden" id="prize_money<%=i%>" value="<%=rq.getCost()%>">
									</td>
									<%
										} else {
									%>
									<td><%=decimal.format((int) (rq.getCost() * (0.2)))%>원</td>
									<td><%=decimal.format((int) (rq.getCost() * (0.8)))%>원 
										<input type="hidden" id="prize_money<%=i%>" value="<%=(int) (rq.getCost() * (0.8))%>">
									</td>
									<%
										}
									
										if (rq.getPpcode() > 0 && pp.getPrize_money() > 0) {//지급완료
									%>
									<td style="padding-top: 0;">
										<button type="button" class="deliveryBtn btn btn-outline-dark active m-1"
											onclick="selecteddelivery(this,'<%=i%>',<%=rq.getPpcode()%>,<%if (rq.getSelf_tax() == 1) {//의뢰인 부담%><%=rq.getCost()%><%} else {%><%=(int) (rq.getCost() * (0.8))%><%}%>)">지급취소</button>
									</td>
									<th class="deliveryStatus<%=i%>">지급완료</th>
									<%
										} else {
									%>
									<td style="padding-top: 0;">
										<button type="button" class="deliveryBtn btn btn-outline-dark m-1"
											onclick="selecteddelivery(this,'<%=i%>',<%=rq.getPpcode()%>,<%if (rq.getSelf_tax() == 1) {//의뢰인 부담%><%=rq.getCost()%><%} else {%><%=(int) (rq.getCost() * (0.8))%><%}%>)">지급</button>
									</td>
									<th class="deliveryStatus<%=i%>">지급전</th>
									<%
										}
									%>
								</tr>
							<%
									}
								}
							%>
							</tbody>
						</table>
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
								<a href="prize_moneyDeliveryForm.jsp?pageNum=<%=startPage - 10%>"
									class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
								<%
									for (int i = startPage; i <= endPage; i++) {
								%>
								<a href="prize_moneyDeliveryForm.jsp?pageNum=<%=i%>"
									class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
								<%
									}
								%>
								<a href="memberManagementForm.jsp?pageNum=<%=startPage + 10%>&tab=requester"
									class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
								<%
									}
								%>
							</div>
						</nav>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />