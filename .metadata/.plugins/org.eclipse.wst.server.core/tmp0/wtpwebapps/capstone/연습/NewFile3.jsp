<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<Html>
<head>
<meta charset='utf-8'>
<title>[bootstrap] 부트스트랩 – 툴팁(Tooltips), 말풍선</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
    $('[data-toggle="popover"]').popover({
		// container: "body",
		delay: { "show": 0, "hide": 111000 }
	});
    
    $('.popover-right').popover({
		placement: 'right',
		viewport: {selector: 'body', padding: 2}
	});
	$('.popover-bottom').popover({
		placement: 'bottom',
		viewport: {selector: 'body', padding: 2}
	});
	$('.popover-viewport-right').popover({
		placement: 'right',
		viewport: {selector: '.container-viewport', padding: 2}
	});
	$('.popover-viewport-bottom').popover({
		placement: 'bottom',
		viewport: {selector: '.container-viewport', padding: 2}
	});
    
	$('[data-toggle="tooltip"]').tooltip({
		// container: "body",
		delay: { "show": 0, "hide": 111000 }
	});
	$('.tooltip-right').tooltip({
		placement: 'right',
		viewport: {selector: 'body', padding: 2}
	});
	$('.tooltip-bottom').tooltip({
		placement: 'bottom',
		viewport: {selector: 'body', padding: 2}
	});
	$('.tooltip-viewport-right').tooltip({
		placement: 'right',
		viewport: {selector: '.container-viewport', padding: 2}
	});
	$('.tooltip-viewport-bottom').tooltip({
		placement: 'bottom',
		viewport: {selector: '.container-viewport', padding: 2}
	});
   });
</script>
</head>
<body>
<div class="container">
<button type="button" class="btn btn-lg btn-danger" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">Click to toggle popover</button>

	<h2>툴팁</h2>
	<a href="#" data-toggle="tooltip" title="" data-original-title="Default tooltip">you probably</a>
	<hr>
	<div class="button-margin">
	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="left" title="Tooltip on left">Tooltip on left</button>
	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="top" title="Tooltip on top">Tooltip on top</button>
	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="bottom" title="Tooltip on bottom">Tooltip on bottom</button>
	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="Tooltip on right">Tooltip on right</button>
	</div>

	<div class="button-margin"   id="fixed-div">
	<button type="button" class="btn btn-default" data-toggle="tooltip" data-placement="right" title="Tooltip on right">Tooltip on left</button>
	</div>

	<div class="checkbox disabled" data-toggle="tooltip" title="Disabled" data-placement="top">
	  <label>
	    <input type="checkbox" value="" disabled>
	    Option two is disabled
	  </label>
	</div>
	<hr>
	<div  data-toggle="tooltip" title="Disabled" data-placement="top">
	<input class="form-control" id="disabledInput" type="text" placeholder="Disabled input here..." disabled>
	</div>
	<hr>
	<div class="dropdown clearfix">
	  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu3" data-toggle="dropdown" aria-expanded="true">
	    Dropdown
	    <span class="caret"></span>
	  </button>
	  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">
	    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Regular link</a></li>
	    <li role="presentation" class="disabled" data-toggle="tooltip" title="Disabled" data-placement="left"><a role="menuitem" tabindex="-1" href="#">Disabled link</a></li>
	    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another link</a></li>
	  </ul>
	</div>
	<hr>
	<!-- HTML to write -->
	<a href="#" data-toggle="tooltip" title="Some tooltip text!">Hover over me</a>

	<!-- Generated markup by the plugin -->
	<div class="tooltip top" role="tooltip">
	  <div class="tooltip-arrow"></div>
	  <div class="tooltip-inner">
	    Some tooltip text!000
	  </div>
	</div>

	<a href="#" data-toggle="tooltip" title="" data-original-title="Default tooltip" style="white-space: nowrap;">Sometimes you want to add a tooltip to a hyperlink that wraps multiple lines. The default behavior of the tooltip plugin is to center it horizontally and vertically. Add white-space: nowrap; to your anchors to avoid this Sometimes you want to add a tooltip to a hyperlink that wraps multiple lines. The default behavior of the tooltip plugin is to center it horizontally and vertically. Add white-space: nowrap; to your anchors to avoid this</a>
	<hr>
	<div class="btn-group" role="group" aria-label="...">
	  <button type="button" class="btn btn-default" data-toggle="tooltip" title="Disabled" data-placement="top">Left</button>
	  <button type="button" class="btn btn-default" data-toggle="tooltip" title="Disabled" data-placement="top">Middle</button>
	  <button type="button" class="btn btn-default" data-toggle="tooltip" title="Disabled" data-placement="top">Right</button>
	</div>


	<div class="input-group">
	  <span class="input-group-addon">@</span>
	  <input type="text" class="form-control" placeholder="Username" data-toggle="tooltip" title="Disabled" data-placement="top" data-delay='{ "show": 500, "hide": 1000 }'>
	</div>

	<div style="margin-top: 30px;">
	<a href="#" data-toggle="tooltip" data-html="true" title="<h1>Default <a href='http://google.com'>tooltip</a></h1>" data-delay='{ "hide": 3000 }'>you probably</a>
	</div>

	<div style="margin-top: 30px;">
	<a href="#" data-toggle="tooltip" data-html="true" >you probably</a>
	</div>
</div>
</body>
</html>
