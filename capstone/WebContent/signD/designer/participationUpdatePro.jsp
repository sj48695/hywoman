<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.Part"%>
<%@page import="com.oreilly.servlet.multipart.FilePart"%>
<%@page import="com.oreilly.servlet.multipart.ParamPart"%>
<%@page import="com.oreilly.servlet.multipart.MultipartParser"%>
<%@page import="signD.contest.ParticipationDataBean"%>
<%@page import="signD.member.AlarmDBBean"%>
<%@page import="signD.contest.RequestDBBean"%>
<%@page import="signD.contest.ParticipationDBBean"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>


<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	String category = request.getParameter("category");
	int ppcode = Integer.parseInt(request.getParameter("ppcode"));
	int rqcode = Integer.parseInt(request.getParameter("rqcode"));
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String filename = "";
	String filenames = "";
	String paramName = "";
	String title = "";
	String contents = "";

	RequestDBBean rqdb = RequestDBBean.getInstance();
	ParticipationDBBean ppdb = ParticipationDBBean.getInstance();
	ParticipationDataBean pp = ppdb.getParticipation(ppcode);
	AlarmDBBean alarmdb = AlarmDBBean.getInstance();

	String saveFolder = "/fileSave/participationFile/" + category;//파일이 업로드되는 폴더
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
				} else if (paramName.equals("rqcode")) {
					rqcode = Integer.parseInt(pPart.getStringValue());
				} else {
					filenames = filenames + new String(pPart.getStringValue().getBytes("8859_1"), "utf-8")
							+ ",";
				}

			}
			if (_part.isFile()) {
				FilePart fPart = (FilePart) _part; // get some info about the file
				//filename = new String(fPart.getFileName().getBytes("8859_1"), "utf-8");
				filename = fPart.getFileName();
				if (filename == null || filename.equals("")) {
				} else if (filename != null) {
					FileRenamePolicy policy = new DefaultFileRenamePolicy();
					fPart.setRenamePolicy(policy);
					fPart.writeTo(new File(realFolder));
					filenames = filenames + filename + ",";
				}

			}
			// end while
		}

		//	rqcode = Integer.parseInt(multi.getParameter("requestcode"));
	} catch (IOException ioe) {
		System.out.println(ioe);
	} catch (Exception ex) {
		System.out.println(ex);
	}

	pp.setTitle(title);
	pp.setFile(filenames);
	pp.setContents(contents);
	int check=ppdb.updateParticipation(pp);
	
	if(check==1){
		%>
		<jsp:useBean id="alarm" class="signD.member.AlarmDataBean" />
		<%
			alarm.setTo_id(rqdb.getRequest(rqcode).getId());
			alarm.setFrom_id(id);
			alarm.setNoticedate(new Timestamp(System.currentTimeMillis()));
			alarm.setUrl("/capstone/signD/contest/requestDetail.jsp?requestcode=" + rqcode);
			alarm.setContents(id + "님이 참여작을 수정하였습니다.");
			alarm.setType("참여작 수정");
			alarmdb.insertAlarm(alarm);
		%>
		<script type="text/javascript">
			alert("콘테스트 참여작을 수정하였습니다.");
		</script>
		<meta http-equiv="Refresh" content="0;url=/capstone/signD/contest/requestDetail.jsp?requestcode=<%=rqcode%>">
<%	}else{
	%>
		<script type="text/javascript">
			alert("참여작을 수정하지 못하였습니다. 다시 시도해주세요.");
			history.go(-1);
		</script>
	<%
	}
%>