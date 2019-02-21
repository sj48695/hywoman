<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.manager.ManagerDataBean"%>
<%@page import="signD.manager.ManagerDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%!DecimalFormat decimal = new DecimalFormat("#,###");%>
<%
	request.setCharacterEncoding("utf-8");
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

	String title = "회원관리  | DO";

	String managerId = (String) session.getAttribute("managerId");
	String pageNum = request.getParameter("pageNum");
	String keyword = request.getParameter("keyword");
	String tab = request.getParameter("tab");
	if (keyword == null) {
		keyword = "";
	}
	if (tab == null) {
		tab = "requester";
	}
	if (pageNum == null) {
		pageNum = "1";
	}
	int currentPage = 0;
	int startRow = 0;
	int endRow = 0;
	int count = 0;
	int number = 0;
	int ppcount = 0;
	String type = "의뢰인";

	ManagerDBBean managerdb = ManagerDBBean.getInstance();
	LogonDBBean memberdb = LogonDBBean.getInstance();
	List<LogonDataBean> memberList = null;
	LogonDataBean member = null;
%>
<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param name="title" value="<%=title%>" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />


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
		<!-- Page Container -->
		<div class="w3-content w3-margin-top" style="max-width: 1400px;">
			<div class="w3-row-padding">
				<div class="w3-third" style="width: 22%">
					<div class="w3-white w3-text-grey w3-card-4">
						<div class="w3-display-container">
							<img class="mbox" src="/capstone/signD/module/manager.png" style="width: 80%">
							<div class="w3-display-bottomleft w3-container w3-text-black">
							</div>
						</div>
						<div class="w3-container">
							<div class="w3-bar-block">
								<a href="#memberManagementForm.jsp"
									class="w3-bar-item w3-button w3-padding w3-text-teal"> 
									<i class="fa fa-user fa-fw w3-margin-right w3-large"></i><strong>회원관리</strong>
								</a>
								<a href="#about" class="w3-bar-item w3-button w3-padding"> 
									<i class="fas fa-money-bill-alt fa-fw w3-margin-right w3-large"></i>상금관리
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
							<br>
						</div>
					</div>
				</div>
				<!-- Right Column -->
				<div class="w3-twothird" style="width: 78%">
					<div class="w3-container w3-card w3-white w3-margin-bottom">
						<div class="btn-group btn-group-toggle col-sm-12 row justify-content-end py-2"
							data-toggle="buttons">
							<ul class="nav navs nav-pills col-sm-3" role="tablist">
								<li class="nav-item">
									<a class="nav-link btn-outline-dark active" data-toggle="tab" href="#requester-tab" role="tab" id="requester"
										aria-controls="requester-tab" aria-selected="true">의뢰인</a>
								</li>
								<li class="nav-item">
									<a class="nav-link btn-outline-dark" data-toggle="tab" href="#designer-tab" role="tab" id="designer"
										aria-controls="designer-tab" aria-selected="false">디자이너</a>
								</li>
							</ul>
						</div>
						<div class="tab-content" id="pills-tabContent">
							<div class="tab-pane fade show active" id="requester-tab"
								role="tabpanel">
								<table class="table">
									<colgroup>
										<col width="8%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="*">
									</colgroup>
									<thead>
										<tr class="w3-dark-grey">
											<th>번호</th>
											<th>아이디</th>
											<th>비밀번호</th>
											<th>이름</th>
											<th>E-mail</th>
											<th>전화번호</th>
											<th>가입일자</th>
										</tr>
									</thead>
									<tbody>
	
										<%
											type = "의뢰인";
											count = managerdb.getMemberCount(type);
											currentPage = Integer.parseInt(pageNum);
											if (tab.equals("designer")) {
												currentPage = 1;
											} /* else{
												  if (count / 10 + 1 < currentPage) {
												     currentPage = count / 10 + 1;
												  }
												} */
											startRow = (currentPage - 1) * pageSize + 1;
											endRow = currentPage * pageSize;
											number = count - (currentPage - 1) * pageSize;
											memberList = managerdb.getMember(type, startRow, pageSize);
	
											for (int i = 0; i < memberList.size(); i++) {
												member = memberList.get(i);
										%>
										<tr>
											<td><%=number--%></td>
											<td><%=member.getId()%></td>
											<td><%=member.getPasswd()%></td>
											<td><%=member.getName()%></td>
											<td><%=member.getEmail()%></td>
											<td><%=member.getTel()%></td>
											<td><%=sdf.format(member.getReg_date())%></td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
								<nav aria-label="Page navigation">
									<div
										class="w3-bar w3-large pagination justify-content-center py-3">
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
										<a href="memberManagementForm.jsp?pageNum=<%=startPage - 10%>&tab=requester"
											class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
										<%
											for (int i = startPage; i <= endPage; i++) {
										%>
										<a href="memberManagementForm.jsp?pageNum=<%=i%>&tab=requester"
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
							</div>
							<div class="tab-pane fade show" id="designer-tab" role="tabpanel">
								<table class="table">
									<colgroup>
										<col width="8%">
										<col width="10%">
										<col width="10%">
										<col width="8%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="*">
									</colgroup>
									<thead>
										<tr class="w3-dark-grey">
											<th>번호</th>
											<th>아이디</th>
											<th>비밀번호</th>
											<th>채택수</th>
											<th>우승상금</th>
											<th>이름</th>
											<th>E-mail</th>
											<th>전화번호</th>
											<th>가입일자</th>
										</tr>
									</thead>
									<tbody>
										<%
											type = "디자이너";
											count = managerdb.getMemberCount(type);
											currentPage = Integer.parseInt(pageNum);
											if (tab.equals("requester")) {
												currentPage = 1;
											} /*  else{
												  if (count / 10 + 1 < currentPage) {
												     currentPage = count / 10 + 1;
												  }
												}  */
											startRow = (currentPage - 1) * pageSize + 1;
											endRow = currentPage * pageSize;
											number = count - (currentPage - 1) * pageSize;
											memberList = managerdb.getMember(type, startRow, pageSize);
											for (int i = 0; i < memberList.size(); i++) {
												member = memberList.get(i);
										%>
										<tr>
											<td><%=number--%></td>
											<td><%=member.getId()%></td>
											<td><%=member.getPasswd()%></td>
											<td><%=member.getChoosecount()%></td>
											<td><%=memberdb.getPrize_money(member.getId())%></td>
											<td><%=member.getName()%></td>
											<td><%=member.getEmail()%></td>
											<td><%=member.getTel()%></td>
											<td><%=sdf.format(member.getReg_date())%></td>
										</tr>
										<%
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
										<a
											href="memberManagementForm.jsp?pageNum=<%=startPage - 10%>&tab=designer"
											class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
										<%
											for (int i = startPage; i <= endPage; i++) {
										%>
										<a href="memberManagementForm.jsp?pageNum=<%=i%>&tab=designer"
											class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
										<%
											}
										%>
										<a href="memberManagementForm.jsp?pageNum=<%=startPage + 10%>&tab=designer"
											class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
										<%
											}
										%>
									</div>
								</nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
   $(document).ready(function(){
      tabChange('<%=tab%>');
	});
</script>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />