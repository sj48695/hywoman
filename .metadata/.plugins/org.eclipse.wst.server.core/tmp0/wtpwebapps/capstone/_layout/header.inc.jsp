<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pageTitle = request.getParameter("title");
%>
<!doctype html>
<html lang="ko">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/capstone/assets/bootstrap-4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- <link rel="stylesheet" href="/capstone/assets/fontawesome-free-5.5.0/css/all.css"> -->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.10/css/all.css" >
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css"> 
	
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	
	<!--  style  -->
	<link rel="stylesheet" href="/capstone/signD/etc/style.css" type="text/css">
	<link rel="stylesheet" href="/capstone/signD/etc/main.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/style1.css" /> 
	<link rel="stylesheet" href="/capstone/signD/etc/mypage.css" type="text/css">
	<link rel="stylesheet" href="/capstone/signD/etc/contest.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/member.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/designer.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/help.css" />
	<link rel="stylesheet" href="/capstone/signD/etc/manager.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
	<script src="//code.jquery.com/jquery.min.js"></script>
	<script>
    $(document).ready(function() {
	   if( $('body').on('change')){
	    	$(".tooltip-inner").attr("style","max-width:300px");
	   }
		$('[data-toggle="tooltip"]').tooltip({
			delay: { "show": 0, "hide": 1000*3 }
		});
		$('.tooltip-bottom').tooltip({
			placement: 'bottom',
			viewport: {selector: 'body', padding: 2}
		});
		$('.tooltip-viewport-bottom').tooltip({
			placement: 'bottom',
			viewport: {selector: '.container-viewport', padding: 2}
		});
   });
</script>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<title><%=pageTitle%></title>
</head>
<body>