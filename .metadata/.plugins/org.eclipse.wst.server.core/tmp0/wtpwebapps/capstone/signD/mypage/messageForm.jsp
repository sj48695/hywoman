<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="signD.member.MessageDataBean"%>
<%@page import="signD.member.MessageDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   request.setCharacterEncoding("utf-8");
   String id = (String) session.getAttribute("id");
   String pageNum = request.getParameter("pageNum");
   if (pageNum == null) {
      pageNum="1";
   }

   LogonDBBean Logon = LogonDBBean.getInstance();
   LogonDataBean member = Logon.getMember(id);

   MessageDBBean msgdb = MessageDBBean.getInstance();
   List<MessageDataBean> msgs;
   MessageDataBean msg;
   String tab2 =request.getParameter("tab2");
   String keyfield=request.getParameter("keyfield");
   String keyword=request.getParameter("keyword");
   if(tab2==null){
      tab2 = "";
   }
   if(keyfield==null){
      keyfield = "all";
   }

   if(keyword==null){
      keyword = "";
   }

   int count = 0;
   int number=0;
   int startRow =0;
   int currentPage = 0;
   String type="to";
   
   
   if (id != null) {

%>
<nav class="navbar row justify-content-end">
   <div class="btn-group btn-group-toggle col-sm-3" data-toggle="buttons">
      <ul class="nav nav-tabs nav-pills" id="msgType" role="tablist">
         <li class="nav-item">
            <a class="nav-link btn-outline-dark active" data-toggle="tab" href="#toMsg" role="tab" id="to"
               aria-controls="toMsg" aria-selected="true" onclick="tab2Change('messages','to');">받은쪽지함</a>
         </li>
         <li class="nav-item">
            <a class="nav-link btn-outline-dark" data-toggle="tab" href="#fromMsg" role="tab" id="from"
               aria-controls="fromMsg" aria-selected="false" onclick="tab2Change('messages','from');">보낸쪽지함</a>
         </li>
      </ul>
   </div>
</nav>
<div class="tab-content" id="pills-tabContent">
   <div class="tab-pane fade show active" id="toMsg" role="tabpanel">
   
      <form method="get" class="row justify-content-between w-100" action="myPage.jsp">
         <input type="hidden" name="tab" value="messages">
         <input type="hidden" name="tab2" value="to">
         
         <div class="row col-sm-5">
            <select class="form-control mr-sm-2 col-sm-3" name="keyfield" >
               <option value="all" <%if(tab2.equals("to") && keyfield.equals("all")){%> selected<%} %>>전체</option>
               <option value="contents" <%if(tab2.equals("to") && keyfield.equals("contents")){%> selected<%} %>>내용</option>
               <option value="id" <%if(tab2.equals("to") && keyfield.equals("id")){%> selected<%} %>>아이디</option>
            </select> <input class="form-control mr-sm-2 col-sm-5" type="search" placeholder="Search" aria-label="Search" name="keyword" 
               <%if(!tab2.equals("from")){%> value="<%=keyword%>"<%} %>>
            <button class="form-control btn btn-outline-dark col-sm-3" type="submit">검색</button>
         </div>
      </form>
      <table class="table fixed">
         <colgroup>
            <col width="30px">
            <col width="65px">
            <col width="*%">
            <col width="65px">
            <col width="20%">
         </colgroup>
         <thead>
            <tr>
               <th class="input_chk p-0" style="border-bottom: none;">   
                  <input type="checkbox" id="00" class="chk to" onclick="setCheckAll(this.checked,'to');" value="0">
                  <label for="00"></label>
               </th>
               <th>글번호</th>
               <th>내용</th>
               <th>아이디</th>
               <th>날짜</th>
            </tr>
         </thead>
         <tbody>
            <%
               type="to";
               count = msgdb.getMessageCount(id, type,keyfield,keyword);
               currentPage = Integer.parseInt(pageNum);
               if(!tab2.equals("to")){
                  currentPage=1;
                  count = msgdb.getMessageCount(id, type,"all","");
               }
               startRow = (currentPage - 1) * pageSize + 1;
               number = count - (currentPage - 1) * pageSize;
               msgs = msgdb.getMessages(id, type, startRow, pageSize,keyfield,keyword);
               if(!tab2.equals("to")){
                  msgs = msgdb.getMessages(id, type, startRow, pageSize,"all","");
               }
               if (msgs == null) {
            %>
            <tr><td colspan="5" class="text-center">받은쪽지가 없습니다.</td></tr>
            <%
               } else {
                  for (int i = 0; i < msgs.size(); i++) {
                     msg = (MessageDataBean) msgs.get(i);
            %>
            <tr>
               <td class="input_chk p-0">
                  <input type="checkbox" id="<%=msg.getMsgcode()%>" class="to" name="seq" value="<%=msg.getMsgcode()%>">
                  <label for="<%=msg.getMsgcode()%>"></label>
               </td>
               <td><%=number--%></td>
               <td class="title">
            <%
               if (msg.getRead_check() == 1) {//알람을 확인 했다면
            %> 
                  <a data-toggle="modal" href="#" data-target="#from<%=i%>"><%=msg.getContents()%></a>
            <%
               } else {
            %>
                  <a data-toggle="modal" data-target="#from<%=i%>" id="readupdate<%=i%>"><b><%=msg.getContents()%></b></a>
            <script type="text/javascript">
            $("#readupdate<%=i%>").click(function(){
               
               $("#readupdate<%=i%>").html($("#readupdate<%=i%>").text());
               var form_data={msgcode:<%=msg.getMsgcode() %>};
               
               $.ajax({
                  type : "POST",
                  url : "messageRead.jsp",
                  data : form_data,
                  success : function(response) {
                     <%-- console.log(response+$("#readupdate<%=i%>").text()); --%>
                     $("#from<%=i%>").modal('show');
                  },
                  error : function() {
                     alert("Error!");
                  }
               });
            });
            </script>
            <%
               }
            %>
               </td>
               <td><%=msg.getFrom_id()%></td>
               <td><%=sdf.format(msg.getReg_date())%></td>
            </tr>

				<div class="modal fade" id="from<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content ">
							<div class="modal-header py-2" style="background-color: #FF9436">
								<div class="row col-12">
									<h4 class="col col-sm-5" style="color: white;"><strong>받은 쪽지</strong></h4>
								</div>
								<button type="button" class="close" data-dismiss="modal"aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body mr-5">
								<form method="post">
									<input hidden="true" name="msgcode" value="<%=msg.getMsgcode()%>"> 
									<input hidden="true"name="from_id" value="<%=msg.getFrom_id()%>">
									<div class="form-group row">
										<div class="col-sm-2 text-right"><strong>From.</strong></div>
										<div class="col-sm-3"><%=msg.getFrom_id()%></div>
										<div class="col-sm-7 text-right"><%=sdf.format(msg.getReg_date())%></div>
									</div>
									<div class="form-group row">
										<div class="col-sm-2 text-right"><strong>내용</strong></div>
										<div class="col-sm-10">
											<textarea class="form-control" rows="10" disabled="disabled"><%=msg.getContents()%></textarea>
										</div>
									</div>
									<div class="form-group row justify-content-end">
										<button type="button" class="btn btnOr col-2 mr-1" data-toggle="modal" data-target="#response<%=i%>">답장</button>
										<button type="button" data-dismiss="modal" class="btn col-2" 
											onclick="return delCheck(this.form,'받은쪽지')" style="background:darkgray; color: white;">삭제</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="response<%=i %>" tabindex="-1" role="dialog" aria-hidden="true">
					<jsp:include page="msgSendForm.jsp" flush="false">
						<jsp:param value="<%=msg.getFrom_id()%>" name="to_id"/>
					</jsp:include>
				</div>
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
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=messages&tab2=to"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=messages&tab2=to"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=messages&tab2=to"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
			</div>
		</nav>
	</div>
	<div class="tab-pane fade" id="fromMsg" role="tabpanel" aria-labelledby="fromMsg">
		<form method="get" class="row justify-content-between w-100" action="myPage.jsp">
         <input type="hidden" name="tab" value="messages">
         <input type="hidden" name="tab2" value="from">
         
         <div class="row col-sm-5">
            <select class="form-control mr-sm-2 col-sm-3" name="keyfield">
               <option value="all" <%if(tab2.equals("from") && keyfield.equals("all")){%> selected<%} %>>전체</option>
               <option value="contents" <%if(tab2.equals("from") && keyfield.equals("contents")){%> selected<%} %>>내용</option>
               <option value="id" <%if(tab2.equals("from") && keyfield.equals("id")){%> selected<%} %>>아이디</option>
            </select> <input class="form-control mr-sm-2 col-sm-5" type="search" placeholder="Search" aria-label="Search" name="keyword"
               <%if(!tab2.equals("to")){%>  value="<%=keyword%>" <%} %>>
            <button class="form-control btn btn-outline-dark col-sm-3" type="submit">검색</button>
         </div>
      </form>
      <table class="table fixed">
         <colgroup>
            <col width="30px">
            <col width="65px">
            <col width="*%">
            <col width="65px">
            <col width="20%">
         </colgroup>
         <thead>
            <tr>
               <th class="input_chk p-0" style="border-bottom: none;">   
                  <input type="checkbox" id="01" class="chk from" onclick="setCheckAll(this.checked,'from');" value="0">
                  <label for="01"></label>
               </th>
               <th>글번호</th>
               <th>내용</th>
               <th>아이디</th>
               <th>날짜</th>
            </tr>
         </thead>
         <tbody>
            <%
               type="from";
               count = msgdb.getMessageCount(id, type,keyfield,keyword);
               currentPage = Integer.parseInt(pageNum);
               if(!tab2.equals("from")){
                  currentPage=1;
                  count = msgdb.getMessageCount(id, type,"all","");
               }
               /* if(count/10+1<currentPage){
                  currentPage=count/10+1;
               } */
            
               startRow = (currentPage - 1) * pageSize + 1;
               number = count - (currentPage - 1) * pageSize;
               msgs = msgdb.getMessages(id, type, startRow, pageSize,keyfield,keyword);
               if(!tab2.equals("from")){
                  msgs = msgdb.getMessages(id, type, startRow, pageSize,"all","");
               }
               if (msgs == null) {
            %>
            <tr><td colspan="5" class="text-center">보낸쪽지가 없습니다.</td></tr>
            <%
               } else {
                  for (int i = 0; i < msgs.size(); i++) {
                     msg = (MessageDataBean) msgs.get(i);
            %>
            <tr>
               <td class="input_chk p-0">
                  <input type="checkbox" id="<%=msg.getMsgcode()%>" class="from" name="seq" value="<%=msg.getMsgcode()%>">
                  <label for="<%=msg.getMsgcode()%>"></label>
               </td>
               <td><%=number--%></td>
               <td class="title">
                  <a data-toggle="modal" href="#" data-target="#to<%=i%>"><%=msg.getContents()%></a>
               </td>
               <td><%=msg.getTo_id()%></td>
               <td><%=sdf.format(msg.getReg_date())%></td>
            </tr>

						
				<div class="modal fade" id="to<%=i%>" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered" role="document">
						<div class="modal-content ">
							<div class="modal-header py-2" style="background-color: #FF9436">
								<div class="row col-12">
									<h4 class="col col-sm-5" style="color: white;">
										<strong>보낸 쪽지</strong>
									</h4>
								</div>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body mr-5">
								<form method="post">
									<input hidden="true" name="msgcode" value="<%=msg.getMsgcode()%>"> 
									<input hidden="true" name="to_id" value="<%=msg.getTo_id()%>">
									<div class="form-group row">
										<div class="col-sm-2 text-right"><strong>To.</strong></div>
										<div class="col-sm-3 p-0 pr-3"><%=msg.getTo_id()%></div>
										<div class="col-sm-7 text-right"><%=sdf.format(msg.getReg_date())%></div> 
									</div>
									<div class="form-group row">
										<div class="col-sm-2 text-right"><strong>내용</strong></div>
										<div class="col-sm-10 p-0">
											<textarea class="form-control" rows="10" disabled="disabled"><%=msg.getContents()%></textarea>
										</div>
									</div>
									<div class="form-group row justify-content-end">
										<button type="button" class="btn col-2" onclick="return delCheck(this.form,'보낸쪽지')"
											style="background:darkgray; color: white;">삭제</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
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
				<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=messages&tab2=from"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
						for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="myPage.jsp?pageNum=<%=i%>&tab=messages&tab2=from"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
						}
				%>
				<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=messages&tab2=from"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
				<%
					}
				%>
			</div>
		</nav>
	</div>
</div>

<div class="row justify-content-end">
	<a class="btn btn-outline-dark mr-2" href="#" onclick="msgDel()">선택삭제</a>
	<a class="btn btn-outline-dark" data-toggle="modal" href="#" data-target="#send">보내기</a>
</div>
<div class="modal fade" id="send" tabindex="-1" role="dialog" aria-hidden="true">
	<jsp:include page="msgSendForm.jsp" flush="false"/>
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