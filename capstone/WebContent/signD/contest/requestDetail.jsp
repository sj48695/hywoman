<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="signD.member.BookmarkDBBean"%>
<%@page import="signD.member.LogonDataBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="java.util.List"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.contest.RequestDataBean"%>
<%@page import="signD.member.ReplyDataBean"%>
<%@page import="signD.member.ReplyDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%!int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
   DecimalFormat price = new DecimalFormat("#,###");%>
<% 
   request.setCharacterEncoding("utf-8");
   String title = "콘테스트 상세내용 | DO";
   String pageNum = request.getParameter("pageNum");
   if (pageNum == null) {
      pageNum = "1";
   }

   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
   int number = 0;
   String filenames[]=null;
   
   int recount=0;
   int ref =0;
   int re_step=0;
   int re_level=0;
   List<ReplyDataBean> replys=null;
   ReplyDataBean reply =null;
   
   int rqcode=Integer.parseInt(request.getParameter("requestcode"));
   String id=(String)session.getAttribute("id");
   

   ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
   List<ParticipationDataBean> pplist=null;
   ParticipationDataBean pp=null;
   
   LogonDBBean logon=LogonDBBean.getInstance();
   
   RequestDBBean rqdb=RequestDBBean.getInstance();
   RequestDataBean rq=rqdb.getRequest(rqcode);
   int ppcount=rqdb.getPPRequestCount(rq.getRequestcode());//콘테스트 참여자수
   String Dday=rqdb.getDday(rq.getRequestcode());
   rqdb.updateViewcount(rqcode, id);
   
   ReplyDBBean replydb=ReplyDBBean.getInstance();
   recount=replydb.getReplyCount("requestcode",rqcode);
   
   ref = rqcode;
   
   BookmarkDBBean bmdb=BookmarkDBBean.getInstance();
   int bmcheck=bmdb.getBookmarkCheck(id,rqcode, null);
   
%>

<jsp:include page="/_layout/header.inc.jsp" flush="false">
   <jsp:param name="title" value="<%=title%>" />
</jsp:include>
<div style="height:80px">
<jsp:include page="../module/menubar.jsp" flush="false" />
</div>
<div class="container">
   <table class="table table-borderless table-b">
      <colgroup>
         <col width="10%">
         <col width="*">
         <col width="20%">
      </colgroup>
      <tbody>
         <tr>
            <td rowspan="3">
               <img <%if (rq.getPpcode() > 0) {//채택한 작품이 있다면
               filenames = ppdb.getParticipation(rq.getPpcode()).getFile().split(",");%>
               src="/capstone/fileSave/participationFile/<%=rq.getCategory() %>/<%=filenames[0] %>"
               <%} else {%>
               src="/capstone/signD/module/images/<%=rq.getCategory()%>.jpg"
               <%}%> width="200" height="200" class="rounded" id="detailImg" style="border: 1px solid #ced4da;">
         	</td>
            <td class="pb-0">
               <div class="new_list_sub_top">
					<div class="new_list_cate inline"><%=rq.getCategory()%>&nbsp;|&nbsp;</div>
					<h1 class="new_list_title inline" style="font-size: 16px; font-weight: bold;">
						<%=rq.getTitle()%>
					</h1>
					<div class="new_list_sub_bot">
						<div class="new_list_id inline"> <strong><%=rq.getId()%></strong>	|	</div>
						<div class="new_list_id inline"> <strong><%=rq.getCompany_name()%></strong>	|	</div>
						<div class="new_list_count inline"><strong>조회수</strong><%=rq.getViewcount()%></div>
					</div>
				</div>
			</td>
            <td rowspan="2">
            <% if (bmcheck == 1) {  %>
               <div class="star offset-10" data-toggle="button" aria-pressed="true" data-rqcode="<%=rq.getRequestcode()%>">
                  <font size="5"><i class="fas fa-star"></i></font>
               </div>
            <%} else {%>
               <div class="star offset-10" data-toggle="button" aria-pressed="false" data-rqcode="<%=rq.getRequestcode()%>">
                  <font size="5"><i class="far fa-star"></i></font>
               </div>
          	<%}%>
            </td>
         </tr>
         <tr>
            <td class="py-0">
               <div style="float: left;border: 3px solid #f8f9fa00;">
	               <table style="text-align: center; color: #666; font-weight: bold;">
	                  <tbody>
	                     <tr>
	                        <td><i class="fas fa-money-bill-alt"></i>상금</td>
	                        <td><i class="fas fa-user"></i>참여자</td>
	                        <td><i class="fas fa-calendar"></i>남은기간</td>
	                     </tr>
	                     <tr>
	                        <td width="120px" style="min-height: 58px; padding-bottom: 10px; padding-top: 10px; border-right: 1px solid #e9ecef;">
	                           <font style="font-size: 10pt;"><%=price.format(rq.getCost()/10000)%>만원</font><br>
	                        </td>
	                        <td width="95px" style="min-height: 58px; padding-top: 10px;
	                            padding-bottom: 10px; border-right: 1px solid #e9ecef;"> 
	                            <%-- <a data-toggle="tooltip" data-html = "true"
									data-placement="bottom"
									title='<%if (ppcount == 0) {%>새로운 알람이 없습니다.
					            		<%} else {
					            			 pplist=ppdb.getParticipations(rqcode,1,5);
											for (int i = 0; i < pplist.size(); i++) {
												pp = pplist.get(i);
												%><%=pp.getContents() %><br/><% 
											}if(pplist.size()>5){%>…<%} 
										}%>'> --%> <%=ppcount%> 명
								<!-- </a> -->
	                        </td>
	                        <td width="95px" style="min-height: 58px; padding-top: 10px; padding-bottom: 10px;"><%=Dday%> 일</td>
	                     </tr>
	                  </tbody>
	               </table>
	            </div>
            </td>
         </tr>
         <tr>
            <td>
            	<h4 id="chooseText"><%if (rq.getPpcode() > 0) {%><font color="darksalmon">채택완료된 작품입니다.</font> <%}%></h4>
            </td>
            <td class="row align-items-end">
               <% if (rq.getId().equals(id) && Dday.equals("0")) { %>
                <button type="button" class="btn btnOr"
                	onclick="deleteCheck('/capstone/signD/contest/requestDelPro.jsp?requestcode=<%=rq.getRequestcode()%>')">삭제하기</button> 
               <% } else if (!rq.getId().equals(id) && !Dday.equals("0")) { %>
               <button type="button" class="btn btnOr" id="participationBtn">참여하기</button> 
               <% }  %>
			</td>
         </tr>
      </tbody>
   </table>
   <nav class="text-center">
      <div class="btn-group btn-group-toggle rq_nav_wrap" data-toggle="buttons">
         <ul class="nav col-md-12 rq_nav" role="tablist">
            <li class="nav-item col-md-6">
               <a class="nav-link" data-toggle="tab" href="#requestParticipation"
                  role="tab" aria-controls="requestParticipation" aria-selected="true">참여작보기</a>
            </li>
            <li class="nav-item col-md-6">
               <a class="nav-link active" data-toggle="tab" href="#requestBriefing" 
                   role="tab" aria-controls="requestBriefing" aria-selected="false">브리핑보기</a>
            </li>
         </ul>
      </div>
   </nav> 
   <div class="tab-content" id="pills-tabContent">
      <div class="tab-pane fade show" id="requestParticipation" role="tabpanel">
         <jsp:include page="requestParticipation.jsp" flush="false">
            <jsp:param value="<%=rqcode%>" name="requestcode"/>
            <jsp:param value="<%=rq.getId()%>" name="requesterId"/>
         </jsp:include>
      </div>
      <div class="tab-pane fade show active" id="requestBriefing" role="tabpanel">
         <jsp:include page="requestBriefing.jsp" flush="false">
            <jsp:param value="<%=rqcode%>" name="requestcode"/>
         </jsp:include>
      </div>
   </div>
   <div>
     <h2 class="w3-text-grey  pt-5"><i class="fas fa-angle-right fa-fw w3-margin-right w3-xxlarge w3-text-orange"></i>콘테스트 문의사항(<%=recount%>)</h2>
      <div class="w3-container">
         <table class="table">
            <%-- <thead>
               <tr>
                  <td><a class="w3-opacity"><font size="+1"><i class="fas fa-angle-right fa-fw w3-margin-right w3-xlarge w3-text-orange"></i><b>문의사항 (<%=recount%>)</b></font></a></td>
               </tr>
            </thead> --%>
            <tbody>
				<tr>
                  <td colspan="2">
                       <div class="card card-body" style="border:0;">
                          <form method="post" action="replyPro.jsp" class="row justify-content-center">
                             <input type="hidden" name="id" value="<%=id%>"> 
                             <input type="hidden" name="recount" value="<%=recount%>"> 
                             <input type="hidden" name="ref" value="<%=ref%>"> 
                             <input type="hidden" name="re_step" value="<%=re_step-1%>"> 
                             <input type="hidden" name="re_level" value="<%=re_level-1%>">
                             <input type="hidden" name="requestcode" value="<%=rqcode%>">
                             <textarea class="form-control form-group col-sm-9 mb-0 mr-2" placeholder="문의사항을 남겨주세요." rows="3"
                                 id="reply0" onfocus="return replyName(0);"></textarea>
                             <button class="btn btn-outline-dark col-sm-2" type="submit" onclick="return idCheck(<%=id%>);">문의하기</button>
                          </form>
                       </div>
                    <%
                       if (recount > 0) {// 댓글이 하나라도 있다면 
                          replys=replydb.getReplys("requestcode",rqcode);//글넘버에 해당하는 댓글의 리스트(re_level>0)
                    %>
                       <div>
                          <ul class="cmlist">
                       <%
                          for (int i = 0; i < replys.size(); i++) {//댓글리스트
                             reply = replys.get(i);
                             re_step=reply.getRe_step();
                             re_level=reply.getRe_level();
                             LogonDataBean writer = logon.getMember(reply.getId());
                             int wid = 0;

                             if (reply.getRe_level() > 0) {//댓글의 댓글이면
                                wid = 10 * (reply.getRe_level());
                       %>
                             <li style="text-indent:<%=wid%>px;">└ 
                          <%
                             } else {//댓글(re_level=1/0)
                          %>
                             <li style="text-indent:<%=wid%>px;">
                          <%
                             }
                          %>       
                                <a href="../desigener/profile.jsp?designerId=<%=reply.getId()%>">
                                   <img src="../../imageFile/profileImg/<%=writer.getProfileimg()%>" class="rounded-circle m-3" style="width: 60px;height: 60px">
                                   <b><%=writer.getName()%>(<%=reply.getId()%>)</b>
                                </a> <%=sdf.format(reply.getReg_date())%>
                                <a class="pointer" data-toggle="collapse" data-target="#rere<%=i + 1%>"><img src="../module/images/chat.jpg"></a> 
                          <%
                              if (reply.getId().equals(id)) {
                          %>
                                <button type="button" class="close" name="replydelete"
                                   onclick="location.href='replydeletePro.jsp?replycode=<%=reply.getReplycode()%>&requestcode=<%=reply.getRequestcode()%>'">
                                   <!-- <span aria-hidden="true">&times;</span> -->
                                   <img alt="" src="../module/images/Cross.png">
                                </button> 
                          <%
                             }
                          %>
                                <p><%=reply.getReply()%></p>
                                <div class="card card-body collapse" id="rere<%=i + 1%>" style="border:0">
                                   <form method="post" action="replyPro.jsp" class="row justify-content-center">
                                      <input type="hidden" name="id" value="<%=id%>"> 
                                      <input type="hidden" name="recount" value="<%=recount%>">
                                      <input type="hidden" name="ref" value="<%=ref%>">
                                      <input type="hidden" name="re_step" value="<%=re_step%>"> 
                                      <input type="hidden" name="re_level" value="<%=re_level%>">
                                      <input type="hidden" name="requestcode" value="<%=rqcode%>">
                                      <textarea class="form-control form-group col-sm-9 mb-0  mr-2" rows="3" id="reply<%=i + 1%>" 
                                      		onfocus="return replyName(<%=i + 1%>);"></textarea>
                                      <button class="btn btn-outline-dark col-sm-2" type="submit" onclick="return idCheck(<%=id%>);">답글쓰기</button>
                                   </form>
                                </div>
                                <hr>
                             </li>
                       <%
                          }
                       %>
                          </ul>
                       </div>
                    <%
                       }
                    %>
                  </td>
               </tr>
            </tbody>
         </table>
         <nav aria-label="Page navigation">
			<div class="w3-bar w3-large pagination justify-content-center py-3">
			<%
				if (recount > 0) {
					int pageCount = recount / pageSize + (recount % pageSize == 0 ? 0 : 1);//1+1(2)
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
				<a href="requestDetail.jsp?pageNum=<%=startPage - 10%>&requestcode=<%=rqcode%>"
					class="w3-button w3-hover-black<%if (startPage > 10) {} else {%> disabled<%}%>"><<</a>
				<%
					for (int i = startPage; i <= endPage; i++) {
				%>
				<a href="requestDetail.jsp?pageNum=<%=i%>&requestcode=<%=rqcode%>"
					class="w3-button <%if (currentPage == i) {%>w3-black<%} else {%>w3-hover-black<%}%>"><%=i%></a>
				<%
					}
				%>
				<a href="requestDetail.jsp?pageNum=<%=startPage + 10%>&requestcode=<%=rqcode%>"
					class="w3-button w3-hover-black<%if (endPage < pageCount) {} else {%> disabled<%}%>">>></a>
			<%
				}
			%>
				</div>
			</nav>
		</div>
	</div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />