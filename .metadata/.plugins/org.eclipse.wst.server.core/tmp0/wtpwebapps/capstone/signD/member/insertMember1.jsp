<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	request.setCharacterEncoding("utf-8");
	String title = "회원가입 | 약관동의 | DO";
%>

<jsp:include page="/_layout/header.inc.jsp" flush="false">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
<jsp:include page="../module/menubar.jsp" flush="false" />
<div class="mbgi">
	<section class="jumbotron text-center img-cover">
	<div class="container py-4">
	<h1 class="jumbotron-heading jumbotitle">
			<strong>회원가입</strong>
		</h1>
		<p class="lead">
			<strong>디자인 콘테스트 사이트 'DO'와 함께하세요!</strong>
		</p>
	
	</div>
</section>
</div>
<div class="container footerbottom ">
	<div class="insertsignn col-md-8 offset-md-2">
		<div class="container col-md-10 join_form">
			<form id="join_form" method="post" action="insertMember2.jsp">
				<input type="hidden" id="token_sjoin" name="token_sjoin" class="ipn"
					value="DTCUbR2E6zCtmdA3">
				<!-- 약관동의 -->
				<div class="terms_p">
					<p class="terms_chk_all">
						<span class="input_chk"> 
						<input type="checkbox" class="ipn" id="chk_all" name="chk_all" onclick="setCheckAll(this.checked,'member');"
							value="0"> <!-- [D] ie7/8에서 checked일때 label에 클래스 on추가해주세요.  -->
							<label for="chk_all"> 
								<span class="chk_all_txt lala">
									이용약관, 개인정보 수집 및 이용, 위치정보 이용약관(선택), 프로모션 안내 메일 수신(선택)에 모두 동의합니다.
								</span>
							</label>
						</span>
					</p>
					<ul class="pdz">
						<li class="terms_bx"><span class="input_chk"> 
							<input type="checkbox" id="termsService" name="termsService" class="member" required> 
							<label for="termsService" class="lala">sign D 이용약관 동의<span class="terms_necessary">(필수)</span></label>
						</span>
							<div class="terms_box" tabindex="0" id="divService">
								<p>(서비스 이용 약관) 제 1 장 총칙 제1조 목적 본 약관은 회사(이하 ‘회사’)가 운영하는 디자인 및
									아이디어 크라우드소싱 플랫폼 라우드소싱(http://www.loud.kr, 이하 ‘라우드소싱’)에서 제공하는 제반
									서비스 이용과 관련하여 회사와 회원의 권리·의무 및 책임사항 등을 규정함을 목적으로 합니다. 제2조 약관의 효력
									및 변경 1) 본 약관은 서비스 화면 및 라우드소싱 홈페이지에 게시하여 공시함으로써 이용자에게 공시하고 이에
									동의한 이용자가 서비스에 가입함으로써 효력이 발생합니다. 2) 본 약관에 동의하는 경우, 회사의 서비스 제공 행위
									및 회원의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다. 3) 회사는 필요하다고 인정하는 경우 관련법을
									저촉하지 않는 범위 내에서 본 약관을 개정할 수 있으며, 변경된 약관은 적용 일자 및 개정 사유를 명시하여 서비스
									화면에 공지합니다. 4) 회원은 변경된 약관에 동의하지 않을 경우 회원등록을 취소(회원탈퇴,해지) 할 수 있으며,
									변경된 약관의 효력 발생일로부터 7일 이내에 거부의사를 표시하지 않고 서비스를 계속 사용할 경우 동의한 것으로
									간주합니다.</p>


								<p>제3조 약관 외 준칙 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신망
									이용촉진 및 정보보호 등에 관한 법률, 정보통신윤리위원회 심의규정, 정보통신 윤리강령, 컴퓨터프로그램보호법 등
									기타 대한민국의 관련법령 및 상관행을 따릅니다. 제4조 용어의 정의 본 약관에서 사용하는 용어의 정의는 다음 각
									호와 같습니다.</p>


								<p>1) 서비스 : 라우드소싱 홈페이지에서 디자인 및 아이디어 콘테스트 관련 서비스를 운영하는 크라우드소싱
									플랫폼 2) 이용자 : 라우드소싱 서비스를 이용하는 모든 회원 및 비회원 3) 회원 : 홈페이지에서 본 약관에
									따라 회원가입 절차를 거친 후, 회사가 제공하는 모든 제반 서비스를 이용하는 자 - 의뢰자 : 회원 중 디자인 및
									아이디어를 의뢰하는 자 - 참여자 : 회원 중 디자인 및 아이디어를 제공하는 자 4) 콘테스트 : 라우드소싱
									홈페이지에 게재되는 디자인 및 아이디어 공모전 5) 콘테스트 참여 : 회원이 특정 콘테스트에 디자인 및 아이디어를
									제안하고 시안을 등록하는 행위 6) 콘테스트 심사 : 참여자의 디자인 및 아이디어를 바탕으로 한 의뢰자의 선정
									과정 7) 1차 통과자 : 콘테스트 심사를 거쳐 선정된 예비 우승자 8) 우승작 : 1차 통과자를 거쳐 선정된
									최후의 디자인 또는 아이디어 본 약관에서 사용하는 용어의 정의는 제1항에서 정하는 것을 제외하고는 관계법령,
									개별서비스에 대한 별도약관 및 이용규정에서 정하는 바에 의합니다. 제 2 장 서비스 이용계약 제5조 이용계약의
									성립 1) 이용계약은 이용자의 약관 내용에 대한 동의와 이용자의 이용신청에 대한 회사의 승낙으로 성립합니다. 2)
									이용계약에 대한 동의는 이용신청 당시 회사 이용약관의 “동의함”을 선택함으로써 의사표시를 합니다. 제6조 이용신청
									및 제한 1) 회사는 신청서 양식에 정확히 기재하여 이용신청하였을 경우 서비스 이용신청을 승낙합니다. 2) 회사는
									다음 각 호에 해당하는 신청에 대해서는 승낙하지 않습니다. ① 타인 동의 없이 타인명의로 서비스를 신청한 경우 ②
									정보를 허위로 기재하였거나 허위의 서류를 제출한 경우 ③ 회사가 정한 이용신청 요건이 미비 되었을 경우(필수항목
									누락, 오기 등)</p>
								<p>④ 법령 또는 약관을 위반하여 이용계약이 해지 된 적이 있는 이용자가 신청한 경우 ⑤ 사회의 안녕질서
									혹은 미풍양속을 저해할 목적으로 신청한 경우 ⑥ 기타 부정한 용도로 본 서비스를 이용하고자 하는 경우 3) 회사는
									다음 각 호의 경우 그 사유가 해소될 때까지 서비스 이용 승인을 유보 또는 제한할 수 있습니다. ① 서비스 관련
									제반 용량이 부족한 경우 ② 회사의 기술상 장애 사유가 있는 경우 제7조 회원ID 부여 및 변경 등 1) 회사는
									이용자에 대하여 약관이 정하는 바에 따라 회원에게 ID를 부여합니다. 2) ID는 원칙적으로 변경이 불가하나,
									다음 각 호와 같이 부득이한 사유로 변경하고자 하는 경우 회원 또는 회사의 요청으로 변경할 수 있습니다. ①
									ID가 회원의 이메일, 전화번호 등으로 등록되어 사생활 침해가 우려되는 경우 ② 타인에게 혐오감을 주거나
									미풍양속에 저해할 목적으로 신청한 경우 ③ 기타 합리적 사유가 있는 경우 3) 회원탈퇴 후 해당 아이디는
									영구적으로 사용이 중지되므로 해당 아이디로는 재가입이 불가능합니다. 4) 회원은 회원정보 변경을 통해 언제든지
									자신의 정보를 열람하고 수정할 수 있습니다. 제8조 회원정보 사용에 대한 동의 홈페이지의 회원정보는 다음과 같이
									수집, 사용, 관리, 보호되며, 회원이 본 약관에 따라 이용신청을 하는 것은 회사가 신청서에 기재된 회원정보를
									수집, 이용하는 것에 동의하는 것으로 간주됩니다. 1) 회원정보의 수집 : 회사는 서비스 가입 시 회원이 제공하는
									정보를 통해서 회원의 정보를 수집합니다. 2) 회원정보의 사용 : 회사는 서비스 제공과 관련해서 수집된 회원의
									신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다. 단, 전기통신기본법 등 법률의 규정에 의해
									국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리위원회의 요청이 있는 경우 또는 기타
									관계법령에서 정한 절차에 따른 요청이 있는 경우, 회원이 홈페이지에 제공한 회원정보를 스스로 공개한 경우는
									제외합니다. 3) 회원정보의 관리 : 회원은 회원정보의 보호 및 관리를 위하여 수시로 귀하의 회원정보를 수정 또는
									삭제할 수 있습니다. 수신되는 정보 중 불필요하다고 생각되는 부분도 변경 또는 조정 할 수 있습니다. 4)
									회원정보의 보호 : 회원정보는 오직 회원만이 열람•수정•삭제 할 수 있으며, 이는 전적으로 회원의 ID와
									비밀번호에 의해 관리되고 있습니다. 따라서 타인에게 회원의 ID와 비밀번호를 알려주어서는 아니 되며, 작업 종료
									시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 합니다. 제 3 장 서비스 제공 및 이용 제9조 서비스의
									개시 및 이용 1) 회사는 회원의 이용신청을 승낙한 때부터 서비스를 개시합니다. 단, 일부 서비스의 경우에는
									지정된 일자부터 서비스를 개시합니다. 2) 회사의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는
									경우에는 사이트에 공시하거나 회원에게 이를 통지합니다. 3) 서비스의 이용은 연중무휴이며 1일 24시간을 원칙으로
									합니다. 다만, 회사의 업무상 또는 기술상의 이유로 서비스가 일시 중지 될 수 있습니다. 이러한 경우 회사는 사전
									또는 사후에 이를 공지합니다. 4) 회원으로 가입한 이후라도 일부 서비스 이용 시 서비스 제공자의 요구에 따라
									특정 회원에게만 서비스를 제공할 수 있습니다. 5) 회사는 서비스를 일정 범위로 분할하여 각 범위별로 이용가능
									시간을 별도로 정할 수 있습니다. 이러한 경우 회사는 사전에 이를 공지합니다. 제10조 서비스의 중지 1) 회원은
									홈페이지에 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 라우드소싱 관리범위
									외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타
									통신 데이터의 손실에 대해 회사는 관련 책임을 부담하지 않습니다. 2) 회사가 정상적인 서비스 제공의 어려움으로
									인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 고지 후 서비스를 중지할 수 있으며,
									이 기간 동안 회원이 고지 내용을 인지하지 못한데 대하여 회사는 책임을 부담하지 않습니다. 상당한 이유가 있을
									경우 위 사전 고지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 본 서비스에 보관되거나
									전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 및 기타
									통신 데이터의 손실이 있을 경우에도 회사는 책임을 부담하지 않습니다.</p>
								<p>3) 회사의 사정으로 서비스를 영구적으로 중단하여야 할 경우에 제2항을 준용합니다. 다만 이 경우 사전
									고지기간은 1개월로 합니다. 4) 천재지변, 국가비상사태 등 정상적인 서비스 제공이 불가능할 경우 일시적으로
									서비스를 제한, 정지시킬 수 있으며 사전 또는 사후 회원에게 중지사유 및 기간을 공지합니다. 5) 회사는 사전
									공지 후 서비스를 일시적으로 중단할 수 있으며, 이에 대하여 회원 또는 제3자에 어떠한 책임도 부담하지 않습니다.
									6) 회사는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할
									수 있으며, 새로운 서비스로의 교체 등 회사가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히
									중단할 수 있습니다.</p>
								<p>7) 회사가 통제할 수 없는 사유로 인한 서비스 중단의 경우(시스템관리자의 고의, 과실 없는 디스크
									장애, 시스템 다운 등)에 사전통지가 불가능 하며, 타인(PC통신회사, 기간통신사업자 등)의 고의, 과실로 인한
									시스템 중단 등의 경우에는 통지하지 않습니다. 8) 1년 이상 장기간 휴면 회원인 경우 안내 메일 또는 공지사항
									발표 후 1주일간의 통지기간을 거쳐 서비스 사용을 중지할 수 있습니다. 제11조 서비스 이용제한 1) 회원이
									제공하는 정보의 내용이 허위인 것으로 판명되거나, 허위가 있다고 의심할 만한 합리적인 사유가 발생할 경우 회원의
									본 서비스 사용을 일부 또는 전부 이용 정지할 수 있으며, 이로 인해 발생하는 불이익에 대해 회사는 책임을
									부담하지 않습니다. 2) 회원이 본 약관 제16조(회원의 의무) 등 본 약관의 내용에 위배되는 행동을 한 경우,
									임의로 서비스 사용을 제한 및 중지할 수 있습니다. 이 경우 회사는 회원의 접속을 금지할 수 있습니다. 제12조
									정보제공 및 광고의 게재 1) 회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보 및 광고에 대해서는
									전자우편이나 서신우편, SMS(핸드폰 문자메시지), DM(Direct Mail), 메신저 등의 방법으로 회원에게
									제공할 수 있으며, 만약 원치 않는 정보를 수신한 경우 회원은 이를 수신거부 할 수 있습니다. 2) 회사는
									서비스의 운용과 관련하여 서비스화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있으며, 서비스를 이용하고자
									하는 회원이 이 광고게재에 대하여 동의하는 것으로 간주합니다. 3) 회사는 서비스 상에 게재되어 있거나 서비스를
									통한 광고주와의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해
									책임을 지지 않습니다. 제13조 게시물의 관리 운영 1) 회원이 게시한 게시물의 저작권은 회원이 소유하며, 회사는
									서비스 내에 이를 게시할 수 있는 권리를 갖습니다. 단, 우승작의 경우 별도의 계약과정을 거쳐 콘테스트를 개최한
									의뢰자에게 저작권이 귀속되며, 그 외 우승하지 못한 참여자가 작성한 게시물에 대한 저작권은 참여자에게 귀속됩니다.
									2) 회사는 다음 각 호에 해당하는 게시물이나 자료를 사전 통지 없이 삭제하거나, 이동 또는 등록 거부를 할 수
									있습니다. ① 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 게시물을 게시한 경우 ②
									다른 회원 또는 제 3자를 비방하거나 중상모략으로 명예를 손상시키는 내용인 경우 ③ 공공질서 및 미풍양속에
									위반되는 내용인 경우 ④ 범죄적 행위에 결부된다고 인정되는 내용일 경우 ⑤ 제3자의 저작권 등 기타 권리를
									침해하는 내용인 경우 ⑥ 서비스 성격에 부합하지 않는 정보의 경우 ⑦ 허위 콘테스트(신분위장, 아이디어 침해 등을
									목적으로 한 콘테스트)를 등록한 경우 ⑧ 기타 관계 법령에 위배되는 경우 3) 회사는 게시된 내용이 일정 기간
									이상 경과되어 게시물로써의 효력을 상실하여 그 존치 목적이 불분명한 경우, 공지 발표 후 2주일간의 통지 기간을
									거쳐 해당 게시물을 삭제할 수 있습니다. 4) 회원의 게시물이 타인의 저작권을 침해함으로써 발생하는 민·형사상의
									책임은 회원에게 있습니다. 5) 회원은 서비스를 이용하여 얻은 정보를 가공, 판매하는 행위 등 서비스에 게재된
									자료를 상업적으로 사용할 수 없습니다. 제14조 회사의 소유권 1) 회사가 제공하는 서비스, 그에 필요한
									소프트웨어, 이미지, 마크, 로고, 디자인, 서비스 명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는
									회사에게 있습니다. 2) 회원은 회사가 명시적으로 승인한 경우를 제외하고는 제1항 소정의 각 재산에 대한 전부
									또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재라이센스, 담보권설정행위, 상업적 이용행위를 할
									수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다. 제 4 장 의무 및 책임 제15조
									회사의 의무 1) 회사는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 지속적·안정적으로
									서비스를 제공하기 위하여 노력할 의무가 있습니다. 2) 회사는 회원의 개인 신상 정보를 본인의 승낙 없이
									제3자에게 누설, 배포하지 않습니다. 다만, 관계법령에 의해 국가 기관의 요구나 전기통신관련법령 및
									정보통신윤리위원회의 요청 등 법률의 규정에 따른 적법한 절차에 의한 경우는 제외합니다. 3) 회사는 계속적이고
									안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 멸실된 때에는 부득이한 사유가 없는 한 지체 없이 이를
									수리 또는 복구합니다. 4) 회사가 제공하는 서비스로 인하여 회원에게 손해가 발생한 경우 그러한 손해가 회사의
									고의나 중과실에 기해 발생한 경우에 한하여 책임을 부담하며, 그 책임의 범위는 통상손해에 한합니다.</p>
								<p>5) 회사는 회원으로부터 제기되는 의견이나 불만이 정당하다고 인정할 경우에는 신속히 처리합니다. 다만,
									신속한 처리가 곤란한 경우에는 회원에게 그 사유와 처리 일정을 통보합니다. 6) 회사는 관련법령이 정하는 바에
									따라서 회원 등록 정보를 포함한 회원의 개인 정보를 보호하기 위하여 노력합니다. 회원의 개인 정보 보호에 관해서는
									관련법령 및 제 16조에 제시된 내용을 지킵니다. 제16조 회원의 의무 1) 회원은 서비스 이용을 위해 가입할
									경우 현재의 사실과 일치하는 완전한 정보(이하 ‘가입정보’)를 제공해야 합니다. 또한 가입정보에 변경이 발생할
									경우 즉시 갱신해야 합니다. 2) 회원에게 부여되는 ID, 비밀번호는 다음 각 호와 같이 관리해야 합니다. ①
									회원의 승인 없이 ID나 비밀번호가 부정하게 사용되었다는 사실을 발견한 경우에는 즉시 회사에 신고해야 합니다. ②
									매 접속 종료 시에는 반드시 로그아웃 하고, 웹 브라우저의 창을 닫아야 합니다. 3) 회원은 서비스를 이용하면서
									다음과 같은 행위를 하지 않기로 동의합니다. ① 타인(소수를 포함)에게 위해를 가하는 행위 - 타인의 ID,
									비밀번호, 명의 도용 및 타인으로 가장하는 행위 - 타인과의 관계를 허위로 명시하는 행위 - 타인을 비방할
									목적으로 사실 또는 허위의 사실을 적시하여 명예를 훼손하는 행위 - 본인 또는 타인에게 재산상의 이익을 주거나
									손해를 가할 목적으로 허위의 정보를 유통시키는 행위 - 수치심이나 혐오감 또는 공포심을 일으키는 말이나 음향,
									글이나 화상 또는 영상을 계속하여 상대방에게 도달하게 해 상대방의 일상적 생활을 방해하는 행위 - 회사의 사전
									승낙 없이 서비스를 이용한 영리 행위 ② 불필요하거나 승인되지 않은 광고, 판촉물을 게재하는 행위 ③ 정크
									메일(junk mail), 스팸(spam), 도배글, 피라미드 조직 등을 권유하거나 게시, 게재 또는 전자우편으로
									보내는 행위 ④ 저속 또는 음란한 데이터, 텍스트, 소프트웨어, 음악, 사진, 그래픽, 비디오 메시지 등(이하
									‘컨텐츠’)을 게시, 게재 또는 전자우편으로 보내는 행위 ⑤ 지적재산권을 포함한 모든 권리가 없는 컨텐츠를 게시,
									게재 또는 전자우편으로 보내는 행위 ⑥ 컴퓨터 소프트웨어, 하드웨어, 전기통신 장비를 파괴, 방해 또는 기능을
									제한하기 위한 소프트웨어 바이러스를 게시, 게재 또는 전자우편으로 보내는 행위 ⑦ 다른 컴퓨터 코드, 파일,
									프로그램을 포함하고 있는 자료를 게시, 게재, 전자우편으로 보내는 행위 등 다른 사용자의 개인정보를 수집 또는
									저장하는 행위 ⑧ 재물을 걸고 도박하거나 사행 행위를 하는 행위 ⑨ 윤락 행위를 알선하거나 음행을 매개하는 내용의
									정보를 유통시키는 행위 ⑩ 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있다고 판단되는 행위 ⑪ 의뢰자 및
									관련인이 거짓으로 위장하여 본인의 콘테스트에 참여하는 행위 ⑫ 기타 불법적이거나 부당한 행위 4) 본 약관 및
									관계법령에서 규정한 사항을 준수하지 않음으로 인해 발생하는 서비스 이용 상의 손해 또는 제3자에 의한 부정 이용
									등에 대한 책임은 회원에게 있으며, 회사는 그에 대해 책임을 지지 않습니다. 제17조 개인정보보호정책 1) 회사는
									이용신청 시 회원이 제공하는 정보를 통하여 회원에 관한 정보를 수집하며, 회원의 개인정보는 본 이용계약의 이행과
									본 이용계약상의 서비스 제공을 위한 목적으로만 이용합니다. 2) 회사는 정보통신망법 등 관계 법령이 정하는 바에
									따라 회원의 개인정보를 보호하기 위해 노력합니다. 개인정보의 보호 및 사용에 대해서는 관련법 및 회사의
									개인정보취급방침이 적용됩니다. 3) 회사는 서비스 제공과 관련하여 취득한 회원의 정보를 본인의 승낙 없이
									제3자에게 누설 또는 배포할 수 없으며 상업적 목적으로 사용할 수 없습니다. 다만, 다음의 각 호의 경우는
									제외합니다. ① 관계 법령에 의하여 수사상의 목적으로 관계기관으로부터 요구가 있는 경우 ② 정보통신윤리위원회의
									요청이 있는 경우 ③ 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우 제18조 부정 콘테스트에 대한 관리
									1) 어떠한 형식으로든지 의뢰자 및 해당 콘테스트 관계인은 본인의 콘테스트에 참여할 수 없습니다. 2) 다음 각
									호에 해당하는 경우 회사는 해당 콘테스트에 대해 검토해볼 권리가 있습니다. ① 브리핑의 내용과 우승작의 내용이
									크게 다른 경우 ② 다른 참여자의 신고가 접수된 경우 ③ 5회 이하 참여자가 우승한 경우 ④ 다른 참여자의
									아이디어 및 디자인을 차용하려는 의구심이 드는 경우 ⑤ 기타 부정 콘테스트로 의심할만한 근거가 발견된 경우 3)
									다음 각 호에 해당하는 경우 부정 콘테스트로 간주됩니다. ① 어떤 형식으로든지 의뢰자가 본인의 콘테스트에 참여하는
									경우 ② 의뢰자의 참여작이 우승작이 된 경우 ③ 본인이 개최한 콘테스트에 등록된 타작품이나 아이디어를 침해하여
									참여한 경우 4) 부정 콘테스트로 적발 시 의뢰자에게 내용 통보 후 해당 콘테스트는 즉시 취소되며, 참여작은
									의뢰자로부터 비활성화 처리 됩니다. 5) 지불된 상금은 일체 반환되지 않으며, 우승자를 제외한 해당 콘테스트
									참여자에게 1/n로 전액 지급됩니다. 제19조 상금의 지급 1) 다음의 각 항을 충족시키는 경우에만 상금을
									지급합니다. ① 브리핑의 내용과 우승작 사이에 연계가 있고, 모든 저작물이 안전하게 전달되었을 경우 ② 우승작에
									대해 아무도 의구심을 품지 않거나, 발생한 문제가 해결된 경우 ③ 부정에 대하여 아무런 근거가 없는 경우 제 5
									장 계약사항 변경 등 제20조 계약해지 및 이용제한 1) 회원이 이용계약을 해지하고자 할 때에는 회원 본인이 직접
									인터넷을 통해 홈페이지에 해지 신청을 해야 합니다. 2) 회사는 보안 및 아이디 정책, 서비스의 원활한 제공 등과
									같은 이유로 회원의 ID 및 비밀번호 변경을 요구하거나 변경 할 수 있습니다. 3) 회사는 회원이 다음 각 호에
									해당하는 행위를 하였을 경우 사전통지 없이 이용계약을 해지할 수 있습니다. ① 회원이 제공한 데이터가 허위임이
									판명된 경우 ② 범죄적 행위에 관련되는 경우 ③ 국익 또는 사회적 공익을 저해할 목적으로 서비스 이용을 계획 또는
									실행할 경우 ④ 타인의 서비스 아이디 및 비밀번호를 도용한 경우 ⑤ 타인의 명예를 손상시키거나 불이익을 주는 경우
									⑥ 같은 사용자가 다른 아이디로 이중 등록을 한 경우 ⑦ 서비스에 위해를 가하는 등 서비스의 건전한 이용을
									저해하는 경우 ⑧ 기타 관련법령이나 회사가 정한 이용조건에 위배되는 경우 4) 제16조 3항에 위배되는 행위 시
									사전 통지 없이 이용계약을 해지하거나 또는 일정 기간 서비스 이용을 제한할 수 있습니다.</p>
								<p>5) 계약해지 시, 누적된 회원의 데이터는 모두 소멸됩니다. 제21조 양도 금지 1) 회원은 서비스의
									이용권한, 기타 이용계약 상, 지위를 타인에게 양도 및 증여할 수 없으며, 이를 담보로 제공할 수 없습니다. 제
									6장 손해배상</p>


								<p>제22조 손해배상 1) 의뢰자와 참여자는 본 계약의 이행과정에서 알게 된 상대방의 업무상·기술상 비밀을
									상대방의 승인이 없는 한 부당하게 이를 이용하거나 제3자에게 누설하여서는 안됩니다. 2) 의뢰자와 참여자는
									계약기간 중, 계약기간의 만료 또는 계약의 해제·해지 후에도 제1항의 이행의무가 있으며, 이에 위반하여 상대방에게
									손해를 입힌 경우에는 이를 배상해야 합니다. 3) 회사는 무료로 제공되는 서비스와 관련하여 귀책사유가 아닌 다른
									사유에 의해 발생된 일체의 손해에 대한 책임을 지지 않습니다. 제23조 면책조항 1) 회사는 천재지변, 전쟁 및
									기타 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스 제공에 대한 책임이 면제됩니다.
									2) 회사는 기간통신 사업자가 전기통신 서비스를 중지하거나 정상적으로 제공하지 아니하여 손해가 발생한 경우 책임이
									면제됩니다.</p>
								<p>3) 회사는 서비스용 설비의 보수, 교체, 정기점검, 공사 등 부득이한 사유로 발생한 손해에 대한
									책임이 면제됩니다. 4) 회사는 이용자의 컴퓨터 오류에 의해 손해가 발생한 경우, 또는 회원이 신상정보 및
									전자우편 주소를 부실하게 기재하여 손해가 발생한 경우 책임을 지지 않습니다. 5) 회사는 회원 간 또는 회원과
									제3자간에 서비스를 매개로 하여 물품거래 혹은 금전적 거래 등과 관련하여 어떠한 책임도 부담하지 아니하고, 회원이
									서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 지지 않습니다. 6) 회사는 회원 또는 기타 유관기관이
									서비스에 게재한 의견이나 정보에 대해 정확도 및 신뢰도를 보장하지 않습니다. 이용자가 위 내용에 의존해 얻은 모든
									종류의 이득이나 손해에 대하여 회사는 책임을 부담하지 않습니다. 7) 회사는 이용자가 서비스 이용과 관련하여
									가입자에게 발생한 손해 중 가입자의 고의, 과실에 의한 손해 및 타 이용자로 인해 입게 되는 정신적 피해에 대하여
									보상할 책임을 지지 않습니다. 제24조 재판관할 1) 서비스 이용과 관련하여 회사와 회원 사이에 분쟁이 발생한
									경우, 회사와 회원은 발생한 분쟁을 원만하게 해결하기 위하여 필요한 모든 노력을 해야 합니다. 2) 제1항의
									규정에도 불구하고 서비스 이용으로 발생한 분쟁에 대하여 소송이 제기될 경우, 회사 소재지를 관할하는 법원을
									관할법원으로 합니다. * 부 칙</p>
								<p>1. 이 약관은 2013년 7월 15일부터 적용됩니다. 1. 2012년 12월 14일부터 시행되던
									종전의 약관은 본 약관으로 대체 됩니다. (서비스 약관 부록) 본 약관은 회원이 회사가 제공하는 크라우드소싱
									기반의 온라인 디자인 마켓 서비스 '라우드소싱'(http://www.loud.kr)을 이용함에 있어 제반 권리
									의무와 관련 절차 등을 규정함을 목적으로 합니다. 1. 서비스 개요 회사가 운영하는 라우드소싱은
									온라인(www.loud.kr)상에서 회원을 대상으로 크라우드소싱 기반의 디자인 콘테스트 관련 서비스를 운영하는
									온라인 디자인 마켓입니다. 로고, 웹, 프린트, 아이디어 등 각종 디자인 또는 아이디어가 필요한 의뢰자가 상금을
									걸고 콘테스트를 개최하면, 다수의 디자이너 회원이 콘테스트에 참여하고, 의뢰자의 채택을 받은 우승자는 상금을 지급
									받습니다. 2. 디자인 및 아이디어의 공급</p>


								<p>1) 라우드소싱의 모든 디자인 및 아이디어 공급은 본 약관에 의거하여 이루어집니다. 2) 콘테스트
									의뢰자가 우승 디자인 및 아이디어를 선정하면 의뢰자와 해당 디자인 및 아이디어의 공급자는 원본 파일 전송과 저작권
									양도를 위한 일종의 계약 상태에 돌입하게 됩니다. 이 과정에서 라우드소싱은 두 당사자 간의 계약에 구속되지
									않습니다. 3) 두 당사자가 저작권 양도에 동의한 후 참여자는 우승 디자인 및 아이디어의 원본 파일을 라우드소싱에
									업로드하고 의뢰자는 이를 다운로드 받습니다. 3. 라우드소싱의 콘테스트 1) 라우드소싱은 회원에게 디자인 및
									아이디어 콘테스트 관련 서비스를 제공하는 것에 동의합니다. 2) 회원은 의뢰자로서 혹은 참여자로서 혹은 의뢰자겸
									참여자로서 라우드소싱의 모든 콘테스트에 참여할 수 있습니다. 4. 콘테스트 개최 본 조항은 회원이 라우드소싱의
									콘테스트 서비스를 의뢰자로서 이용하는 경우에 적용됩니다. 1) 의뢰자는 라우드소싱의 고객으로서 특정 디자인이나
									아이디어를 공급받기 위해 콘테스트를 개최할 수 있습니다. 콘테스트의 모든 과정은 loud.kr 사이트 내에서
									이루어집니다. 2) 라우드소싱을 통해서 콘테스트를 개최하는 방법 ① 공급받고자 하는 디자인 카테고리를 선택합니다.
									미리 정해진 카테고리 내에서 선택을 하거나, 그 외에 의뢰자가 원하는 사항을 직접 기입할 수 있습니다. ②
									콘테스트에 대한 브리핑을 작성합니다.</p>
								<p>③ 상금을 책정하고 콘테스트에 관한 옵션을 선택합니다. 각 카테고리마다 최소 상금과 선택 가능한 옵션이
									다릅니다.</p>
								<p>④ 라우드소싱의 사전 허가를 받은 특별한 경우를 제외한 모든 콘테스트는 사전에 모든 비용이 결제되어야
									합니다. 5. 라우드소싱의 의무 1) 라우드소싱은 의뢰자의 콘테스트를 홈페이지에 가입된 참여자들에게 홍보하여
									참여를 유도합니다.</p>
								<p>2) 라우드소싱은 참여자에게서 받은 디자인 및 아이디어를 홈페이지를 통해 의뢰자에게 전달합니다. 3)
									의뢰자가 최종적으로 우승작을 선정하면 라우드소싱은 홈페이지를 통해 의뢰자에게 우승작의 원본 파일을 전송합니다.
									4) 의뢰자가 원본 파일을 제대로 받은 것이 확인되면 라우드소싱은 우승작으로 선정된 참여자에게 상금을 지급합니다.
									6. 의뢰자의 의무 1) 의뢰자는 특정 참여자에게 라우드소싱을 통한 방법 이외의 다른 방법으로 원본 파일 전송을
									요구하지 않습니다. 2) 의뢰자는 콘테스트에 관한 라우드소싱의 약관 외에 다른 요건이나 조건을 참여자에게 요구하지
									않습니다.</p>
								<p>3) 의뢰자는 최종 우승작 선택 전, 디자인 및 아이디어의 침해 여부를 알아볼 의무가 있습니다.
									라우드소싱은 모든 게시물을 검사 또는 검열할 의무를 갖지 않으며, 저작권 양도 후 발생하는 손해에 대해 책임지지
									않습니다. 4) 모든 콘테스트는 심사중으로 전환된 시점부터 7일 이내에 우승작을 선정해야 합니다. 만약 부득이한
									상황(내부 검토기간 필요, 의뢰자 부재 등)으로 약속된 기간 내에 우승작을 선정할 수 없는 경우, 우승작 발표
									예정일을 라우드소싱 측에 공지해야 합니다. 사전 공지 또는 발표 없이 14일 후에도 우승 작품을 선정하지 않는
									경우: ① 해당 콘테스트의 1차 통과자로 선정된 참여자들에게 상금의 80%가 1/n로 균등하게 지급됩니다. ②
									해당 콘테스트는 환불이 불가하며, 의뢰자는 추후에 콘테스트에 등록된 그 어떤 디자인 시안 및 아이디어도 사용할 수
									없습니다. 5) 우승작이 선정되면 콘테스트 참여자와 의뢰자가 저작권 양도에 동의한 뒤 참여자는 라우드소싱에서
									지정한 방법으로 디자인 원본파일을 의뢰자에게 전송합니다. 저작권 양도에 관한 자세한 내용은 조항8에 명시되어
									있습니다. 6) 의뢰자는 최종 우승자를 선정한 시점부터 1주일 내에 최종 수령 확인을 해야 합니다. 만약 디자인
									원본이 정상적으로 전달되었음에도 불구하고 이러한 조치가 취해지지 않은 경우에는, 우승자 선정 후 1주일 시점에
									자동으로 수령 확인 처리됩니다. 7) 우승작을 제외한 의뢰자가 선정하지 않은 모든 디자인 및 아이디어의 저작권은
									해당 참여자에게 있습니다. 의뢰자는 본인이 우승작으로 선정하지 않은 디자인 및 아이디어를 사용할 수 없습니다.
									8) 의뢰자는 심사를 위해 콘테스트의 종료기간을 1회 연장할 수 있습니다. 9) 의뢰자는 어떠한 방식으로든 본인의
									콘테스트에 참여할 수 없습니다. 10) 개최한 콘테스트가 부정 콘테스트로 판명될 경우 회사는 의뢰자가 지불한
									상금으로 디자이너에게 보상할 수 있는 권리가 있습니다. 7. 참여자의 의무 본 조항은 회원이 라우드소싱의
									콘테스트를 참여자로서 이용하는 경우에 적용됩니다. 1) 콘테스트에 참여하기 위해서는 의뢰자가 개최한 콘테스트에
									디자인 혹은 아이디어를 등록해야 합니다. 등록하는 디자인 및 아이디어는 의뢰자가 요구하는 형식에 맞춰야 하며,
									형식에 맞지 않는 경우 의뢰자 또는 라우드소싱에 의해 삭제될 수 있습니다. 2) 모든 디자인 및 아이디어는
									라우드소싱을 통해 등록되어야 하며, 파일의 포맷이나 업로드 방법 등은 라우드소싱에 명시되어 있는 방법을 따라야
									합니다. 3) 디자인 혹은 아이디어를 등록하는 것은 라우드소싱 정책 checklist에 동의하고, 다른 사람의
									지적재산권을 침해하거나 특정 지적재산의 2차 저작물이 아님을 약속하고 보증한 것을 의미합니다. 4) 라우드소싱에서
									특별히 인정하는 경우가 아닌 이상 제3자의 지적재산권을 침해할 수 없습니다. 만약 부득이하게 제3자의 지적재산권을
									침해하게 되는 경우, 등록 시 내용과 허가증 등을 명확하게 게시해야 합니다. 5) 참여자는 제3자의 지적재산권을
									침해함으로 인한 의뢰자의 손해에 대하여 책임을 부담해야 합니다. 다만, 참여자의 책임 없는 사유로 인하여 발생한
									경우에는 의뢰자가 부담합니다. 6) 우승작으로 선정되면 의뢰자에게 전달될 고해상도의 디자인 원본 파일 또는
									아이디어의 원본파일을 www.loud.kr에 업로드 해야 합니다. 7) 참여자는 해당 콘테스트를 개최한 의뢰자와
									이해관계가 없어야 합니다. 8. 지적재산권 1) 참여자는 제3자의 저작권 등을 침해해서는 안되며, 만일 이를
									위반하여 의뢰자 또는 제3자에게 손해를 끼칠 경우에는 민·형사상의 모든 책임을 지게 됩니다. 이는 콘테스트가
									종료되어 이미 우승작으로 선정된 경우에도 해당되는 것으로 저작권 침해 또는 이와 관련된 문제 발생 시 선정
									후에라도 취소가 가능하며, 이런 경우 회사는 우승작으로 선정된 참여자에게 지급한 상금을 회수할 수 있습니다. 2)
									모든 콘테스트에 등록되는 참여자의 중간인도물, 사전작업물, 최종인도물의 개별구성요소에 대한 지적재산권은 참여자에게
									귀속되며, 참여자의 허락 없이 사용할 수 없습니다. 3) 참여자와 의뢰자 간의 지적재산권 양도 동의가 이루어진
									우승작에 대한 지적재산권은 의뢰자에게 양도되며, 지적재산권의 등록에 소요되는 비용은 의뢰자가 부담합니다. 4)
									양도 후 우승작은 의뢰자의 소유이며, 콘테스트가 종료된 이후 참여자의 승인 없이 사용할 수 있습니다. 5)
									콘테스트에 우승한 참여자와 그 우승작을 선정한 의뢰자는, 온라인 및 오프라인상에서 라우드소싱이 해당 우승작을
									홍보를 위한 수단으로 로열티 없이 자유롭고 지속적으로 사용하는 것을 승인합니다. 6) 우승작은 라우드소싱의 홍보를
									목적으로 타 온라인 사이트 및 오프라인 등을 통해 복사, 배포, 2차 저작물 제작 및 공개될 수 있습니다.</p>
								<p>7) 라우드소싱은 디자인 및 아이디어의 침해와 관련된 그 어떤 요구나 청구에 대하여 중재자 또는
									조정자로 참여하지 않습니다. 8) 라우드소싱은 의뢰자 또는 참여자가 저지른 지적재산권 관련 침해, 위반 등에
									법적인 책임을 지지 않습니다. 9) 라우드소싱은 홈페이지 상에서 제3자의 지적재산권을 침해한 것으로 판단되거나
									침해 가능성이 존재하는 그 어떠한 콘텐츠를 자체적으로 삭제할 수 있습니다. 9. 결제 1) 콘테스트를 개최하기
									위해서 의뢰자는 상금과 등록비가 포함된 총 금액을 라우드소싱에 지불해야 합니다. ① 총 금액에서 상금은 해당
									콘테스트의 참여자에게 지급되는 금액입니다. ② 총 금액에서 등록비는 의뢰자가 라우드소싱에 지불하는 수수료이며, 이
									중에는 각종 프로모션 옵션 등 의뢰자의 선택 사항에 대한 금액이 포함되어 있습니다. 2) 콘테스트가 종료되고
									의뢰자가 우승작을 선정하면 상금의 70%가 우승 참여자에게 지급되며, 상금의 10%는 우승자를 제외한 1차
									통과자들에게 균등하게 지급됩니다. 우승자를 제외한 1차 통과자 수가 0명인 경우, 상금의 10%는 참여중인 모든
									디자이너들에게 별점 기준으로 1만원씩 지급됩니다. 단, 40만원 미만의 콘테스트는 해당되지 않습니다. 3)
									지급상금 중 3.3%는 소득세 명목으로 원천징수 되며, 16.7%는 라우드소싱 서비스 이용에 대한 운영 수수료로
									공제됩니다. 10. 환불 정책 1) 환불 과정은 콘테스트 등록 중의 결제 방법과 동일하게 이루어집니다. 2)
									우승작 선정을 희망하지 않는 경우의 환불 ① 콘테스트 종료 후 마음에 드는 디자인 및 아이디어가 없는 경우
									의뢰자는 등록비를 제외한 상금의 50%를 환불 받을 수 있습니다. 나머지 30%에 해당하는 금액은 1차 통과자로
									선정된 참여자들에게 1/n로 균등하게 지급되며, 만약 1차 통과자가 없는 경우 지급 대상은 해당 콘테스트의 모든
									참여자로 확대됩니다. 단, 50% 환불은 고급패키지 이상에서만 적용됩니다. ② 저가용 패키지, 일반 패키지,
									환불포기 옵션이 포함된 콘테스트의 경우 상금 환불이 불가합니다. 이 경우, 콘테스트 종료 후 총 상금의 80%에
									해당하는 금액이 1차 통과자로 선정된 참여자들에게 1/n로 균등하게 지급됩니다. 1차 통과자가 선정되지 않았다면
									지급 대상은 참여중인 모든 디자이너들로 확대됩니다.</p>

								<p>3) 참여 수 부족으로 인한 환불 콘테스트가 종료된 후 참여자가 0명인 경우, 등록비를 제외한 상금
									전액을 환불 받을 수 있습니다. 4) 카드결제를 통한 구매건의 환불은 원칙적으로 카드결제 취소를 통해서만
									가능합니다. 11. 디자인 및 아이디어의 결함 특정 디자인 및 아이디어에 결함이 있다고 판단되는 경우는 다음과
									같습니다. 1) 의뢰자와 참여자가 해당 디자인 및 아이디어에 결함이 있다고 사전에 동의하는 경우 2) 라우드소싱이
									해당 디자인 및 아이디어에 결함이 있다고 판단하는 경우 3) 제3자가 해당 디자인 및 아이디어에 대한 지적재산권을
									주장하고 라우드소싱이 이를 인정하는 경우 * 부 칙 1. 이 약관은 2013년 7월 29일부터 적용됩니다. 1.
									2012년 12월 14일부터 시행되던 종전의 약관은 본 약관으로 대체됩니다 담당자 e-mail :
									help@loud.kr 전화 : 1599-3413</p>
							</div></li>
						<li class="terms_bx">
							<span class="input_chk"> 
							<input type="checkbox" id="termsPrivacy" name="termsPrivacy" class="member" required> 
							<label for="termsPrivacy" class="lala">개인정보 수집 및 이용에 대한 안내<span class="terms_necessary">(필수)</span></label>
							</span>
							<div class="terms_box" tabindex="0" id="divPrivacy">
								(주)라우더스(이하 '회사')는 회원님의 개인정보를 중요시하며, 개인정보의 보호와 관련하여 정보통신망 이용촉진 및
								정보보호 등에 관한 법률, 개인정보 보호법, 전기통신사업법, 통신비밀보호법 등 개인정보와 관련된 법령 상의 개인정보
								보호 규정 및 방송통신위원회가 제정한 개인정보보호지침을 준수하고 있습니다. 회사는 개인정보취급방침을 통하여
								회원님들의 개인정보가 남용되거나 유출되지 않도록 최선을 다할 것이며, 회원님께서 제공하시는 개인정보가 어떠한 용도와
								방식으로 이용되고 있고, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드리고자 합니다. 단, 본 개인정보
								취급방침은 정부의 법령 및 지침의 변경, 또는 보다 나은 서비스의 제공을 위하여 그 내용이 변경될 수 있으니,
								회원님들께서는 사이트 방문 시 수시로 그 내용을 확인하여 주시기 바라며, 회사는 개인정보취급방침을 개정하는 경우
								웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다. 1. 수집하는 개인정보 항목 및 이용 목적. 2.
								개인정보의 보유, 이용기간 및 파기. 1. 수집하는 개인정보 항목 및 이용 목적 가. 회사가 개인정보를 수집하는
								목적은 이용자의 신분과 서비스 이용의사를 확인하여 최적화되고 맞춤화된 서비스를 제공하기 위함입니다. 회사는 최초
								회원가입 시 서비스 제공을 원활하게 하기 위해 필요한 최소한의 정보만을 수집하고 있으며 회사가 제공하는 서비스
								이용에 따른 대금결제, 물품배송 및 환불 등에 필요한 정보를 추가로 수집할 수 있습니다. 나. 회사는 개인정보를
								수집 및 이용목적 이외에 다른 용도로 이를 이용하거나 이용자의 동의 없이 제3자에게 제공하지 않습니다. 다. 다음과
								같은 목적으로 개인정보를 수집하여 이용할 수 있습니다. ①구매회원 - 성명, 아이디, 비밀번호, 주민등록번호,
								이메일, 연락처(일반전화 또는 휴대전화), 연계정보 : 회사가 제공하는 서비스의 이용에 따르는 본인확인, 연령제한
								서비스 제공, 민원사항처리, 만 14세 미만인 경우 위 항목에 대한 법정대리인의 정보. 다만, 서비스 이용과정에서
								서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 결제기록 등이 생성되어 수집될 수 있습니다. 이메일주소,
								전화번호, 이동전화번호, 주소 : 거래의 원활한 진행, 본인의사의 확인, 불만처리,새로운 상품, 서비스 정보와
								고지사항의 안내 등 수취인 성명, 주소, 전화번호 : 상품과 경품 배송을 위한 배송지 확인 등 신용카드정보,
								은행계좌정보, 이동전화번호정보 : 대금결제서비스의 제공 등 ② 기타 이용과정이나 사업처리 과정에서 아래와 같은
								정보들이 자동으로 생성되어 수집될 수 있습니다. - IP Address, 방문일시, 서비스 이용 기록 : 부정 이용
								방지, 비인가 사용 방지 등 라. 회사는 이용자의 개인정보를 수집할 경우 반드시 이용자의 동의를 얻어 수집하며,
								이용자의 기본적 인권을 침해할 우려가 있는 인종, 출신지, 본적지, 사상, 정치적 성향, 범죄기록, 건강상태 등의
								정보는 이용자의 동의 또는 법령의 규정에 의한 경우 이외에는 수집하지 않습니다. 마. 당사는 회원 가입을 만 14세
								이상인 경우에 가능하도록 하며 개인정보의 수집•이용에 법정대리인의 동의가 필요한 만 14세 미만 아동의 개인정보는
								원칙적으로 수집하지 않습니다. 단, 법정대리인의 동의를 얻은 경우에는 만 14세 미만 이용자의 개인정보를
								수집•이용할 수 있습니다. 바. 회사는 수집된 회원님들의 개인정보를 다음의 목적을 위해 이용하고 있습니다. ①서비스
								제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 - 콘텐츠 및 회원 맞춤형 서비스 제공, 서비스 구매 및
								요금 결제, 금융거래 본인 인증 및 금융 서비스 ②회원관리 -회원제 서비스 이용에 따른 본인확인, 개인 식별,
								불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 가입 및 가입회수 제한, 만 14세 미만 아동
								개인정보 수집 시 법정대리인 동의여부 확인, 추후 법정대리인 동의여부 확인, 분쟁 조정을 위한 기록 보존, 불만처리
								등 민원처리, 고지사항 전달 ③신규서비스 개발 • 마케팅 및 광고에 활용 - 신규 서비스(컨텐츠) 개발 및 특화,
								이벤트 등 광고성 정보 전달, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 접속 빈도 파악, 회원의 서비스
								이용에 대한 통계 ④시행일 이후 "회원"이 "서비스"를 이용할 시 개정약관에 동의한 것으로 간주됩니다. "회원"은
								변경된 약관에 동의하지 않을 경우 이용계약을 해지할 수 있습니다. 사. 회사는 다음과 같은 방법으로 개인정보를
								수집할 수 있습니다. ①홈페이지, 서면, 팩스, 전화, 고객센터 문의하기, 이벤트 응모 ② 생성정보 수집 툴을 통한
								자동 수집. 2. 개인정보의 보유, 이용기간 및 파기 가. 회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된
								후에는 해당 개인정보를 지체 없이 파기합니다. 단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와
								같이 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. ① 상법 등 법령에 따라 보존할 필요성이 있는 경우
								- 계약 또는 청약철회 등에 관한 기록: 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률 제 6조 및 시행령
								제 6조: 보존기간 : 5년 - 대금결제 및 재화 등의 공급에 관한 기록: 보존근거 : 전자상거래 등에서의
								소비자보호에 관한 법률 제 6조 및 시행령 제 6조: 보존기간 : 5년- 소비자의 불만 또는 분쟁처리에 관한 기록
								: 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률 제 6조 및 시행령 제 6조: 보존기간 : 3년
								본인확인에 관한 기록: 보존근거 : 정보통신망 이용촉진 및 정보보호에 관한 법률 제44조의 5 및 시행령 제
								29조: 보존기간 : 6월 - 접속에 관한 기록: 보존근거 : 통신비밀보호법 제 15조의 2 및 시행령 제 41조:
								보존기간 : 3개월– 부정이용기록 : 보존근거 : 부정이용의 배제 등 회사 방침에 의한 보존 : 보존기간 : 1년
								- 신용정보의 수집, 처리 및 이용 등에 관한 기록: 보존근거 : 신용정보의 이용 및 보호에 관한 법률: 보존기간
								: 3년 - 표시•광고에 관한 기록: 보존근거 : 전자상거래 등에서의 소비자보호에 관한 법률: 보존기간 : 6월 ②
								회사가 보유기간을 미리 고지하고 그 보유기간이 경과하지 아니한 경우와 개별적으로 동의를 받은 경우에는 약정한 기간
								동안 보존합니다. ③ 수집된 개인정보의 보유•이용기간은 서비스이용계약체결(회원가입)시부터
								서비스이용계약해지(탈퇴신청, 직권탈퇴 포함)입니다. 또한 동의 해지 시 회사는 이용자의 개인정보를 상기 명시한
								정보보유 사유에 따라 일정 기간 저장하는 자료를 제외하고는 지체 없이 파기하며 개인정보취급이 제3자에게 위탁된
								경우에는 수탁자에게도 파기하도록 지시합니다. ④ 파기방법 - 이용자의 개인정보는 수집 및 이용목적이 달성된 후에는
								지체 없이 파기됩니다. 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각 등을 통하여 파기하고, 전자적 파일형태로
								저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 파기합니다.</div>
						</li>
					</ul>
					<span class="error" id="agreeMsg" style="display: none">sign D 이용약관과 개인정보 수집 및 이용에 대한 안내 모두 동의해주세요.</span>
				</div>
				<p class="text-center paddingt">
					<button type="submit" class="btn btnOr btn-lg">동의</button>
				</p>
			</form>
		</div>
	</div>
</div>
<jsp:include page="../module/bottom.jsp" flush="false" />
<jsp:include page="/_layout/footer.inc.jsp" flush="false" />