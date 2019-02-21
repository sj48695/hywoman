<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="signD.member.LogonDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<div class="modal-dialog modal-dialog-centered" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<h2 class="modal-title">회원가입</h2>
			<button type="button" class="close" data-dismiss="modal"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<div class="modal-body">
			<div class="container text-center">
				<form method="post" name="insertmemberform" action="/capstone/signD/member/insertMemberPro.jsp">
					<div class="form-group row">
						<label for="id" class="col-sm-3 col-form-label">아이디</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="id"
								placeholder="Id" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">비밀번호</label>
						<div class="col-sm-9">
							<input type="password" class="form-control" name="passwd"
								placeholder="Password" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">이름</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="name"
								placeholder="Name" required="required">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">Email</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="email"
								placeholder="Email" required="required">
						</div>
					<!-- 	<div class="input-group col-sm-5">
							<div class="input-group-prepend">
								<div class="input-group-text">@</div>
								<select class="form-control " name="email_server">
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="nate.com">nate.com</option>
								</select>
							</div>
						</div> -->
					</div>
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">전화번호</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" name="tel"
								placeholder="Tel" required="required">
						</div>
					</div>
					<!-- <div class="form-group row">
						<label class="col-sm-3 col-form-label">주소</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="zip_code" placeholder="우편번호" name="zip_code"> 
						</div>
						<div class="col-sm-4">
							<input type="button" class="form-control btn btn-outline-dark" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
						<br>
						</div>
						<div class="col-sm-9 offset-sm-3"> 
							<input type="text" class="form-control" id="addr" placeholder="주소" name="addr"> 
							<input type="text" class="form-control" id="detail_addr" placeholder="상세주소" name="detail_addr">
						</div>
					</div> -->
					<div class="form-group row">
						<label class="col-sm-3 col-form-label">회원구분</label>
						<div class="col-sm-9 row">
							<div class="form-check col-3 offset-1">
								<input type="radio" class="form-check-input" name="type" value="의뢰인">의뢰인
							</div>
							<div class="form-check">
								<input type="radio" class="form-check-input" name="type" value="디자이너">디자이너
							</div>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-12">
							<button type="submit" class="btn btn-outline-dark col-sm-5">회원가입</button>
							<button type="reset" class="btn btn-outline-dark col-sm-5 offset-sm-1">다시작성</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zip_code').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('detail_addr').focus();
            }
        }).open();
    }
</script>