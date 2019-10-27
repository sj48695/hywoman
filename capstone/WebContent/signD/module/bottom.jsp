<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
%>
<div class="main_footer">
	<div class="main_sector">
		<div class="ft_top container">
			<div class="ft_inline">
				<div class="ft_page_rows">
					<div class="ft_page_sub ft_inline">디자인의뢰</div>
					<ul class="ft_inline ft_ul">
						<li class="ft_li">
							<a 
							<%if (id != null) {%>
								href="/capstone/signD/contest/designrequest/step1.jsp"
							<%} else {%> 
								data-toggle="modal" href="#" data-target="#member" 
							<%}%>>공모전 개최하기 </a>
						</li>
					</ul>
				</div>
				<div class="ft_page_rows">
					<div class="ft_page_sub ft_inline">공모전리스트</div>
					<ul class="ft_inline ft_ul">
						<li class="ft_li"><a href="/capstone/signD/contest/contestIngList.jsp">진행중인 공모전</a></li>
						<li class="ft_li"><a href="/capstone/signD/contest/contestEndList.jsp">종료된 공모전</a></li>
					</ul>
				</div>
				<div class="ft_page_rows">
					<div class="ft_page_sub ft_inline">디자이너</div>
					<ul class="ft_inline ft_ul">
						<li class="ft_li"><a href="/capstone/signD/designer/designerList.jsp">디자이너 리스트</a></li>
						<li class="ft_li"><a href="/capstone/signD/designer/winningwork.jsp">포트폴리오</a></li>
					</ul>
				</div>
				<div class="ft_page_rows">
					<div class="ft_page_sub ft_inline">고객센터</div>
					<ul class="ft_inline ft_ul">
						<li class="ft_li"><a href="/capstone/signD/help/notice.jsp">공지사항</a></li>
						<li class="ft_li"><a href="/capstone/signD/help/FAQ.jsp">자주하는 질문</a></li>
						<li class="ft_li"><a href="/capstone/signD/help/Q&A.jsp">Q&A</a></li>
						<li class="ft_li"><a href="/capstone/signD/help/rule.jsp">이용방법</a></li>
					</ul>
				</div>
			</div>
			<div class="ft_right">
				<div class="ft_tel">
					<img src="/capstone/signD/module/images/tel.png">
				</div>
			</div>

		</div>
		<div class="ft_bottom container">
			<div class="ft_page_rows ft_inline">
				<div class="ft_inline">
					<a href="#"> 
						<img src="/capstone/signD/module/do_white.png" style="width:70px;">
					</a>
				</div>
			</div>
			<div class="ft_right">
                 <div class="ft_text">
                    
                (주)의뢰하시조 | 대표:밥먹고하조 | 사업자번호:120-87-69298 | 통신판매:제2018-서울성동-01577 | 서울시 성동구 사근동 살곳이길 200, 정보문화관 5층(행당동)<br>
                사이트명:DO | Tel:1533-1234 | Fax:02-2018-1108 | E-mail:help@do.com | 고객센터 운영시간: 오전 9시부터 오후 6시까지(공휴일 제외) | 졸작입니다'_'  
                
                 </div>
              </div>
		</div>
	</div>
</div>