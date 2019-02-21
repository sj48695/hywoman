<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<div class="modal-dialog modal-dialog-centered" role="document">
   <div class="modal-content"  style="border-radius: 8px;">
      <div class="modal-header pb-0">
         <!-- <h2 class="modal-title">로그인</h2> -->
         <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
         </button>
      </div>
      <div class="modal-body pb-5">
         <div class="container text-center">
            <form method="post" action="/capstone/signD/member/loginPro.jsp" class="form-signin">
            <img src="/capstone/signD/module/do.png" class="col-8 py-3 ">
               <!-- <h3 style="color:#474747"><strong>DO에 오신 것을 환영합니다!</strong></h3> -->
               <div class="fotm-group row input-block pt-3">
                  <div class="input-form offset-sm-1 col-sm-10 py-2">
                     <input type="text" class="form-control" name="id" placeholder="id" autofocus="autofocus" style="border-radius: 0;">
                  </div>
                  <div class="input-form brt offset-sm-1 col-sm-10 py-2">
                     <input type="password" class="form-control" name="passwd" placeholder="Password"  style="border-radius: 0;">
                  </div>
               </div>
               <div class="form-group row">
                  <div class="offset-sm-1 col-sm-10 py-2">
                     <button type="submit" id="login" class="btn btn-outline-dark btnOrO col-sm-12"  style="border-radius: 0;">로그인</button>
                     <!-- <button type="button" class="btn btn-outline-dark col-sm-5 offset-sm-1"
                        data-toggle="modal" data-target="#insertmember">회원가입</button> -->
                  </div>
               </div>
                     <a class="my-3" href="/capstone/signD/member/insertMember1.jsp">아직 회원이 아니세요?회원가입하러 가기!</a>
            </form>
         </div>
      </div>
   </div>
</div>