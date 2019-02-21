<%@page import="java.util.List"%>
<%@page import="signD.member.AlarmDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.member.LogonDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String managerId = (String) session.getAttribute("managerId");

	LogonDBBean member = LogonDBBean.getInstance();
	String name = "";
	
	AlarmDBBean alarmdb=AlarmDBBean.getInstance();
	int alarmcount=alarmdb.getUnReadAlarmCount(id);
	List<AlarmDataBean> alarmList=null;
	AlarmDataBean alarm=null;
%>
<script>
$(function(){
  $(".zeta-menu li").hover(function(){
    $('ul:first',this).show();
  }, function(){
    $('ul:first',this).hide();
  });
  $(".zeta-menu>li:has(ul)>a").each( function() {
    /* $(this).html( $(this).html()+' &or;' ); */
  });
  $(".zeta-menu ul li:has(ul)").find("a:first")
/*     .append("<p style='float:right;margin:-3px'></p>"); */
});

$(window).scroll(function() {    
    var scroll = $(window).scrollTop();
     //console.log(scroll);
    if (scroll >= 400) {//스크롤 내려가면
        //console.log('a');
        $(".main-menu-bar").addClass("change-menubar");
        $(".main-menu-bar a").css('color','#495161');
        $(".main-menu-bar img").attr('src','/capstone/signD/module/do.png'); 
    } else {//스크롤 올라가면
        //console.log('a');
        $(".main-menu-bar").removeClass("change-menubar");
        $(".main-menu-bar a").css('color','');
        $(".main-menu-bar img").attr('src','/capstone/signD/module/do_white.png'); 

    }
});
</script>

<nav class="navbar navbar-expand-lg navbar-dark main-menu-bar" id="fixed-menu">
	<div class="container">
	  <a class="navbar-brand" href="/capstone/signD/main.jsp">
	  
	  	<img src="/capstone/signD/module/do_white.png" style="width:70px;"> 
	  </a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarText">
		<ul class="navbar-nav mr-auto zeta-menu">
			<li>
			<%
				if(id != null) {
			%>  <a href="/capstone/signD/contest/designRequest1.jsp">디자인 의뢰</a>
				<ul>
					<li><a href="/capstone/signD/contest/designRequest1.jsp">공모전 개최하기</a></li>
				</ul>
			<%	
				}else{
			%>  <a data-toggle="modal" href="#" data-target="#member">디자인 의뢰</a>
				<ul>
					<li><a data-toggle="modal" href="#" data-target="#member">공모전 개최하기</a></li>
				</ul>
			<% 
				}
			%>
			</li>
			<li><a href="/capstone/signD/contest/contestList.jsp">공모전 리스트</a>
				<ul>
					<li><a href="/capstone/signD/contest/contestList.jsp">진행중인 공모전</a></li>
					<li><a href="/capstone/signD/contest/contestEndList.jsp">종료된 공모전</a></li>
				</ul>
			</li>
			<li><a href="/capstone/signD/designer/designerList.jsp">디자이너</a>
				<ul>
					<li><a href="/capstone/signD/designer/designerList.jsp">디자이너 리스트</a></li>
					<li><a href="/capstone/signD/designer/winningwork.jsp">포트폴리오</a>
						<ul>
							<li><a href="/capstone/signD/designer/winningwork.jsp">콘테스트 우승작</a></li>
							<li><a href="/capstone/signD/designer/designerportfolio.jsp">디자이너 포트폴리오</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li><a href="/capstone/signD/help/notice.jsp">고객센터</a>
				<ul>
					<li><a href="/capstone/signD/help/notice.jsp">공지사항</a></li>
					<li><a href="/capstone/signD/help/FAQ.jsp">FAQ</a></li>
					<li><a href="/capstone/signD/help/Q&A.jsp">Q&A</a></li>
					<li><a href="/capstone/signD/help/rule.jsp">이용방법</a></li>
				</ul>
			</li>
	    </ul>
	    <ul class="navbar-nav zeta-menu">
		<%
			if (id == null || id.equals("")) {
				if (managerId == null || managerId.equals("")) {
		%>
			<li><a data-toggle="modal" href="#" data-target="#member">로그인</a></li>
			<li><a href="/capstone/signD/member/insertMember1.jsp">회원가입</a></li>
			<%
				} else {
						name = member.selectName(managerId);
			%>
			<li>
				<a href="/capstone/signD/main.jsp"><%=name%>(<%=managerId%>)님</a>
				<ul>
					<li><a href="/capstone/signD/manager/memberManagementForm.jsp">회원관리</a></li>
					<li><a href="/capstone/signD/manager/prize_moneyDeliveryForm.jsp">상금전달</a></li>
					<li><a href="/capstone/signD/member/logout.jsp">로그아웃</a></li>
				</ul>
			</li>
		<%
				}
			} else {
				name = member.selectName(id);
		%>
			<li>
				<a href="#"><%=name%>(<%=id%>)님</a>
				<ul>
					<li><a href="/capstone/signD/mypage/myPage.jsp?pageNum=1">마이페이지</a></li>
					<li><a href="/capstone/signD/member/logout.jsp">로그아웃</a></li>
				</ul>
			</li>
			<li>
				<div class="offset-6">
					<%if (alarmcount != 0) {%><span class="badge badge-pill badge-danger mt-2" 
						style="padding-top: 4px;padding-bottom: 4px;position: absolute;"><%=alarmcount %></span>
						<%} %>
            	</div>
            	<a class="nav-link menu_link" data-toggle="tooltip" data-html = "true"
					data-placement="bottom"
					title='<%if (alarmcount == 0) {%>새로운 알람이 없습니다.
	            		<%} else {
							alarmList = alarmdb.getUnAlarm(id, 1, 5);
							for (int i = 0; i < alarmList.size(); i++) {
								alarm = alarmList.get(i);
								%><a href="<%=alarm.getUrl()%>" class="p-2"
								style="overflow: hidden;
									    height: 28px;
									    display: -webkit-box;
									    -webkit-line-clamp: 1;
									    -webkit-box-orient: vertical;"
								><%=alarm.getContents() %></a><hr class="my-1"><% 
							}if(alarmList.size()>=5){%>
							<a class="p-2" href="/capstone/signD/mypage/myPage.jsp?tab=alarm">더보기</a>
							<%} 
						}%>'> <i class="fas fa-bell"></i>
				</a>
			</li>
		<%
			}
		%>
		</ul>
	  </div>
  </div>
</nav>
<%
	if (id == null) {
%>
<div class="modal fade" id="member" tabindex="-1" role="dialog" aria-hidden="true">
	<jsp:include page="../member/loginForm.jsp" flush="false"/>
</div>
<%
	}
%>