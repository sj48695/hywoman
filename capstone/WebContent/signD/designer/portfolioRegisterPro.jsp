<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@ page import="com.oreilly.servlet.multipart.Part"%>
<%@ page import="com.oreilly.servlet.multipart.FilePart"%>
<%@page import="com.oreilly.servlet.multipart.ParamPart"%>
<%@page import="signD.member.PortfolioDBBean"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");	
	//String category="";
	

	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename = "";
	String filenames = "";
	String paramName = "";
	String title = "";
	String contents = "";
	int requestcode=Integer.parseInt(request.getParameter("requestcode"));
	String saveFolder ="";

	saveFolder = "/fileSave/portfolioFile";//파일이 업로드되는 폴더
	/* if (request.getParameter("category") != null && !request.getParameter("category").equals("null")) {
		category = request.getParameter("category");

		saveFolder = "/fileSave/portfolioFile/"+category;//파일이 업로드되는 폴더
	} */
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 2 * 1024 * 1024; //최대 업로될 파일크기 5Mb

	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	ServletContext context = getServletContext();
	realFolder = context.getRealPath(saveFolder);

	try {
		/* file limit size of 1GB*/
		MultipartParser parser = new MultipartParser(request, 1024 * 1024 * 1024);
		Part _part;

		while ((_part = parser.readNextPart()) != null) {
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
			} else if (_part.isParam()) {
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
			// end while
		}

	} catch (IOException ioe) {
		System.out.println(ioe);
	} catch (Exception ex) {
		System.out.println(ex);
	}
%>
<jsp:useBean id="pf" scope="page" class="signD.member.PortfolioDataBean" />
<%
	PortfolioDBBean pfdb = PortfolioDBBean.getInstance();

	pf.setId(id);
	pf.setTitle(title);
	pf.setFile(filenames);
	pf.setContents(contents);
	pf.setRequestcode(requestcode);
	pf.setReg_date(new Timestamp(System.currentTimeMillis()));
	int check=pfdb.insertPortfolio(pf);
	
	if (check == 1) {
		%>
		<script type="text/javascript">
			alert("포트폴리오를 등록하였습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=/capstone/signD/mypage/myPage.jsp?tab=profile">
		<%
	} else {
		%>
		<script type="text/javascript">
			alert("포트폴리오를 등록하지 못하였습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
		<%
	}
%>