<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String uploadPath = "/imageFile/notice";//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 5 * 1024 * 1024; //최대 업로될 파일크기 5Mb
	
	ServletContext context = getServletContext();
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	realFolder = context.getRealPath(uploadPath);
	String fileName=null;
		
	try{
        // 파일업로드 및 업로드 후 파일명 가져옴
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, "utf-8", new DefaultFileRenamePolicy());
		Enumeration files = multi.getFileNames();
		String file = (String)files.nextElement(); 
		fileName = multi.getFilesystemName(file);  
		
		// 업로드된 경로와 파일명을 통해 이미지의 경로를 생성
		 uploadPath = "/capstone/imageFile/notice/" + fileName;
			
  
    // 생성된 경로를 JSON 형식으로 보내주기 위한 설정
	JSONObject jobj = new JSONObject();
	jobj.put("url", uploadPath);
	
	response.setContentType("application/json"); // 데이터 타입을 json으로 설정하기 위한 세팅
	out.print(jobj.toJSONString());

	
	}catch(Exception e){
		e.printStackTrace();
	}
	
%>