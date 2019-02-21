<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id=(String)session.getAttribute("id");
	
%>

<div class="container">
	<button type="button" id="btn" class="btn btn-secondary">json가져오기</button>
	<hr>
	<div id="pocket"></div>
	 <c:if test="${isExistsFavoriteData}">
	 	<span id="star">♥</span>
	 </c:if>
	  <c:if test="${!isExistsFavoriteData}">
	 	<span id="star">♥</span>
	 </c:if>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script>
$("#star").click(function(){
	 $.post(
			"/capstone/연습/NewFile.jsp"
			,{"articleId":"${selectedArticle.articleId}"}
			,function(data){
				var text=$("#star").text();
				if(text=="!"){<%
				
				%>
					$("#star").text("♥");
				}else if(text=="♥"){
					$("#star").text("!");
				}
				console.log("sss");
			}
	); 
	/* $.getJSON('bookmark.json', function(data) {
		var ui=[];
		var items = data.results;
		 $.each(items, function(key,value){
		 	var city = value.cityname + ' (' + value.citycode + ')';
		 	ui.push('<div class="card">');
		 	ui.push('<div class="card-hearder">'+city+'</div>');
			ui.push('<ul class="list-group list-group-flush">');

			$.each(value.node, function(k, v){
				ui.push(' <li class="list-group-item">'+v.nodename+'</li>');
		 	});
		 	ui.push('</ul></div>');
		 });
		 $('#star').html(ui.join(''));
	}); */
	
});
</script>
<script>
$(document).on('click', '#btn', function(){
	$.getJSON('rail.station.json', function(data) {
		var ui=[];
		var items = data.results;
		 $.each(items, function(key,value){
		 	var city = value.cityname + ' (' + value.citycode + ')';
		 	ui.push('<div class="card">');
		 	ui.push('<div class="card-hearder">'+city+'</div>');
			ui.push('<ul class="list-group list-group-flush">');

			$.each(value.node, function(k, v){
				ui.push(' <li class="list-group-item">'+v.nodename+'</li>');
		 	});
		 	ui.push('</ul></div>');
		 });
		 $('#pocket').html(ui.join(''));
	});
});
</script>
