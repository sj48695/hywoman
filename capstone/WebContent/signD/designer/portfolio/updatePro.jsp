<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.Part"%>
<%@page import="com.oreilly.servlet.multipart.FilePart"%>
<%@page import="com.oreilly.servlet.multipart.ParamPart"%>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@page import="signD.member.PortfolioDataBean"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%-- <jsp:useBean id="pf" scope="page" class="signD.member.PortfolioDataBean"/> --%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");
	String id = (String) session.getAttribute("id");
	//String category = request.getParameter("category");
	int pfcode = Integer.parseInt(request.getParameter("portfoliocode"));
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename = "";
	String filenames = "";
	String paramName = "";
	String title = "";
	String contents = "";
	int rqcode = 0;
	int check = 0;

	RequestDBBean rqdb = RequestDBBean.getInstance();
	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
	PortfolioDataBean pf = pfdb.getPortfolio(pfcode);
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();

	String saveFolder = "/fileSave/participationFile";//파일이 업로드되는 폴더
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 5 * 1024 * 1024; //최대 업로될 파일크기 5Mb

	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);

	try {
		//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
		MultipartParser parser = new MultipartParser(request, 1024 * 1024 * 1024);
		Part _part;

		while ((_part = parser.readNextPart()) != null) {
			if (_part.isParam()) {
				ParamPart pPart = (ParamPart) _part;
				paramName = pPart.getName();
				if (paramName.equals("title")) {
					title = new String(pPart.getStringValue().getBytes("8859_1"), "utf-8");
				} else if (paramName.equals("contents")) {
					contents = new String(pPart.getStringValue().getBytes("8859_1"), "utf-8");
				} else {
					filenames = filenames + new String(pPart.getStringValue().getBytes("8859_1"), "utf-8")
							+ ",";
				}
			}
			if (_part.isFile()) {
				FilePart fPart = (FilePart) _part; // get some info about the file
				filename = fPart.getFileName();
				if (filename == null || filename.equals("")) {
				} else if (filename != null) {
					FileRenamePolicy policy = new DefaultFileRenamePolicy();
					fPart.setRenamePolicy(policy);
					fPart.writeTo(new File(realFolder));
					filenames = filenames + fPart.getFileName() + ",";
				}

			}
			// end while
		}

	} catch (IOException ioe) {
		System.out.println(ioe);
	} catch (Exception ex) {
		System.out.println(ex);
	}

	pf.setTitle(title);
	pf.setFile(filenames);
	pf.setContents(contents);
	pf.setPortfoliocode(pfcode);
	check = pfdb.updatePortfolio(pf);
	if (check == 1) {
%>
<jsp:useBean id="alarm" class="signD.member.AlarmDataBean" />
<%
		alarm.setTo_id(id);
		alarm.setFrom_id(id);
		alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
		alarm.setUrl("/capstone/signD/designer/profile?portfoliocode=" + pfcode);
		alarm.setContents("포트폴리오를 수정하였습니다.");
		alarm.setType("포트폴리오 수정");
		alarmdb.insertAlarm(alarm);
%>
<script type="text/javascript">
	alert("포트폴리오를 수정하였습니다.");
	location.href="/capstone/signD/mypage/myPage.jsp?tab=profile";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("수정하지 못하였습니다. 다시한번 시도해주세요.");
	history.go(-1);
</script>
<%
	}
%>