<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String id = (String) session.getAttribute("id");
	String to_id = request.getParameter("to_id");
	if (to_id == null) {
		to_id = "";
	}
%>
<div class="modal-dialog modal-dialog-centered" role="document">
	<div class="modal-content ">
		<div class="modal-header py-2" style="background-color: #FF9436">
			<div class="row col-12">
				<h4 class="col col-sm-5" style="color: white;">
					<strong>쪽지보내기</strong>
				</h4>
			</div>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body text-center">
			<form class="my-4" method="post" action="/capstone/signD/mypage/msgSendPro.jsp">
				<div class="form-group row">
					<div class="col-sm-2 text-right" style="padding-top: 5px;">
						<strong>To.</strong>
					</div>
					<div class="col-sm-10 row">
						<div class="col-12 p-0 pr-3">
							<input class="form-control col-sm-12" name="to_id"
								value="<%=to_id%>" onchange="to_idCheck('<%=id%>',this)">
						</div>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-2 text-right" style="padding-top: 5px;">
						<strong>내용</strong>
					</div>
					<div class="col-sm-10 pr-5 pl-0">
						<textarea class="form-control" rows="10" required="required" name="contents"></textarea>
					</div>
				</div>
				<div class="form-group row">
					<button role="submit" class="btn btnOr offset-9 col-2" aria-controls="settings">보내기</button>
				</div>
			</form>
		</div>
	</div>
</div>