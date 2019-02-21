<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.AlarmDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
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
		pageNum = "1";
	}

	String tab = request.getParameter("tab");
	if (tab == null) {
		tab = "alarm";
	}
	
	LogonDBBean Logon = LogonDBBean.getInstance();
	LogonDataBean member = Logon.getMember(id);

	AlarmDBBean alarmdb = AlarmDBBean.getInstance();
	List<AlarmDataBean> alarms = null;
	AlarmDataBean alarm = null;

	int count = alarmdb.getAlarmCount(id);
	int number = 0;
	int currentPage = Integer.parseInt(pageNum);
	/* if ((count / 10) + 1 < currentPage) {
		currentPage = count / 10 + 1;
	} */
	if(!tab.equals("alarm")){
		currentPage=1;
	}
	int startRow = (currentPage - 1) * pageSize + 1;
	number = count - (currentPage - 1) * pageSize;
	if (id != null) {
%>
<div class="container">
	<table class="table my-5">
		<colgroup>
			<col width="30px">
			<col width="65px">
			<col width="*%">
			<col width="15%">
			<col width="20%">
			<col width="5%">
		</colgroup>
		<thead>
			<tr> 
				<th class="input_chk p-0" style="border-bottom: none;">   
                	<input type="checkbox" id="alarm00" class="chk alarm" onclick="setCheckAll(this.checked,'alarm');" value="0">
                	<label for="alarm00"></label>
               	</th>
				<th>글번호</th>
				<th>내용</th>
				<th>타입</th>
				<th>날짜</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<%
			if (count == 0) {
		%>
			<tr>
				<td colspan="5" class="text-center">받은 알람이 없습니다.</td>
			</tr>
		<%
			}else{
				alarms = alarmdb.getAlarm(id, startRow, pageSize);
				for (int i = 0; i < alarms.size(); i++) {
					alarm = alarms.get(i);
		%>
			<tr>
               <td class="input_chk p-0">
                  <input type="checkbox" id="<%=alarm.getAlarmcode()%>" class="alarm" name="seq" value="<%=alarm.getAlarmcode()%>">
                  <label for="<%=alarm.getAlarmcode()%>"></label>
               </td>
				<td><%=number--%></td>
				<td>
				<%
					if(alarm.getRead_check() == 1) {//알람을 확인 했다면
				%> <a href="<%=alarm.getUrl()%>"><%=alarm.getContents()%></a> <%
				 	} else {%> 
				 	<a href="alarmRead.jsp?alarmcode=<%=alarm.getAlarmcode() %>&url=<%=alarm.getUrl()%>"><b><%=alarm.getContents()%></b></a> <%
				 	}
				 %>
				</td>
				<td><%=alarm.getType() %></td>
				<td><%=sdf.format(alarm.getNoticedate())%></td>
				<td>
					<button type="button" class="close" name="alarmDelete" onclick="deleteCheck('alarmDelPro.jsp?alarmcode=<%=alarm.getAlarmcode()%>')">
						<!-- <span aria-hidden="true">&times;</span> -->
						<img alt="" src="../module/images/Cross.png">
					</button>
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
		<a href="myPage.jsp?pageNum=<%=startPage - 10%>&tab=alarm"
			class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
		<%
				for (int i = startPage; i <= endPage; i++) {
		%>
		<a href="myPage.jsp?pageNum=<%=i%>&tab=alarm"
			class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
		<%
				}
		%>
		<a href="myPage.jsp?pageNum=<%=startPage + 10%>&tab=alarm"
			class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
		<%
			}
		%>
	</div>
</nav>
<div class="row justify-content-end">
	<a class="btn btn-outline-dark mr-2" href="#" onclick="alarmDel()">선택삭제</a>
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