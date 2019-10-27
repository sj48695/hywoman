<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String saveFolder = "/imageFile/Q&A";//파일이 업로드되는 폴더를 지정한다.
	String uploadPath = "";//업로드된 파일 경로
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 5 * 1024 * 1024; //최대 업로될 파일크기 5Mb

	ServletContext context = getServletContext();
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	realFolder = context.getRealPath(saveFolder);

	try {
		MultipartRequest multi = null;

		//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
		//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
		multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

		//전송한 파일 정보를 가져와 출력한다
		Enumeration<?> files = multi.getFileNames();

		//파일 정보가 있다면
		while (files.hasMoreElements()) {
			//input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
			String name = (String) files.nextElement();

			//서버에 저장된 파일 이름
			String filename = multi.getFilesystemName(name);
			
			// 업로드된 경로와 파일명을 통해 이미지의 경로를 생성
			uploadPath = "/capstone/imageFile/Q&A/" + filename;

			// 생성된 경로를 JSON 형식으로 보내주기 위한 설정
			JSONObject jobj = new JSONObject();
			jobj.put("url", uploadPath);

			response.setContentType("application/json"); // 데이터 타입을 json으로 설정하기 위한 세팅
			out.print(jobj.toJSONString());
		}
	} catch (IOException ioe) {
		System.out.println(ioe);
	} catch (Exception ex) {
		System.out.println(ex);
	}
%>