/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2019-02-21 14:24:03 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.signD.contest;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import signD.member.ReplyDBBean;
import jdk.nashorn.internal.ir.RuntimeNode.Request;
import java.text.DecimalFormat;
import signD.member.BookmarkDBBean;
import signD.contest.RequestDBBean;
import signD.contest.RequestDataBean;
import java.util.List;
import java.text.SimpleDateFormat;

public final class contestList_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

DecimalFormat decimal = new DecimalFormat("#,###");
  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("java.util.List");
    _jspx_imports_classes.add("signD.contest.RequestDBBean");
    _jspx_imports_classes.add("java.text.DecimalFormat");
    _jspx_imports_classes.add("jdk.nashorn.internal.ir.RuntimeNode.Request");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
    _jspx_imports_classes.add("signD.member.BookmarkDBBean");
    _jspx_imports_classes.add("signD.contest.RequestDataBean");
    _jspx_imports_classes.add("signD.member.ReplyDBBean");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write('\r');
      out.write('\n');

   int pageSize = 10;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

   request.setCharacterEncoding("utf-8");
   String title = "랭킹-공모전";

   String id = (String) session.getAttribute("id");
   String pageNum = request.getParameter("pageNum");
   String category = request.getParameter("category");
   String keyword = request.getParameter("keyword");
   if (category == null) {
         category = "";
   }
   
   if (keyword == null) {
      keyword = "";
   }
   if (pageNum == null) {
      pageNum = "1";
   }

   int currentPage = Integer.parseInt(pageNum);
   int startRow = (currentPage - 1) * pageSize + 1;
   int endRow = currentPage * pageSize;
   int count = 0;
   int number = 0;
   int ppcount = 0;
   String Dday = "";

   RequestDBBean rqdb = RequestDBBean.getInstance();
   List<RequestDataBean> rqlist = null;
   RequestDataBean rq = null;
   count = rqdb.getRequestCount("ing",keyword,category);

   BookmarkDBBean bmdb = BookmarkDBBean.getInstance();

   ReplyDBBean replydb = ReplyDBBean.getInstance();
   int recount = 0;

   number = count - (currentPage - 1) * pageSize;

      out.write("\r\n");
      out.write("\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/header.inc.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("title", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(title), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("   ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/menubar.jsp", out, false);
      out.write("\r\n");
      out.write("<div class=\"bgi8\">\r\n");
      out.write("   <section class=\"jumbotron text-center img-cover\">\r\n");
      out.write("      <div class=\"container py-4\">\r\n");
      out.write("         <h1 class=\"jumbotron-heading jumbotitle\"><strong>랭킹 - 진행 중인 공모전 보기</strong></h1>\r\n");
      out.write("         <p class=\"lead\"><strong>진행중인 공모전의 정보를 확인하세요!</strong></p>\r\n");
      out.write("         <p>\r\n");
      out.write("            <a href=\"contestList.jsp\" class=\"btn btn-light btn-lg my-2\">진행중</a>\r\n");
      out.write("            <a href=\"contestEndList.jsp\" class=\"btn btn-outline-light btn-lg my-2\">종료된</a>\r\n");
      out.write("         </p>\r\n");
      out.write("         <div class=\"d3 offset-2 col-8\">\r\n");
      out.write("            <form class=\"m-0\" name=\"search\" method=\"get\" action=\"contestList.jsp\">\r\n");
      out.write("               <div class=\"input-group input-group-lgs col-12\">\r\n");
      out.write("                  <input type=\"text\" class=\"form-control m-0\" aria-label=\"Sizing input\"\r\n");
      out.write("                     aria-describedby=\"inputGroup-sizing-lg\" name=\"keyword\" value=\"");
      out.print(keyword);
      out.write("\">\r\n");
      out.write("                  <div class=\"input-group-prepend\">\r\n");
      out.write("                     <button class=\"btn\" type=\"submit\" id=\"button-addon2\"></button>\r\n");
      out.write("                  </div>\r\n");
      out.write("               </div>\r\n");
      out.write("            </form>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("   </section>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"container\">\r\n");
      out.write("\t<div class=\"row\">\r\n");
      out.write("\t\t");

			rqlist = rqdb.contestListTop3("ing");
			for (int i = 0; i < rqlist.size(); i++) {
				rq = rqlist.get(i);
				recount = replydb.getReplyCount("requestcode", rq.getRequestcode());
		
      out.write("\r\n");
      out.write("\t\t<div class=\"col-lg-4\">\r\n");
      out.write("\t\t\t<div class=\"row justify-content-center\">\r\n");
      out.write("\t\t\t\t<div class=\"col-sm-12 pb-4 row justify-content-center\">\r\n");
      out.write("\t\t\t\t\t<img alt=\"BEST ");
      out.print(i);
      out.write("\" class=\"col-sm-3\"\r\n");
      out.write("\t\t\t\t\t\tsrc=\"http://fiximage.10x10.co.kr/web2015/shopping/ico_best");
      out.print(i + 1);
      out.write(".png\">\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<img alt=\"");
      out.print(rq.getCategory());
      out.write("\" class=\"col-sm-8 p-0 h-100 pointer\"\r\n");
      out.write("\t\t\t\t\tsrc=\"/capstone/signD/module/images/");
      out.print(rq.getCategory());
      out.write(".jpg\"\r\n");
      out.write("\t\t\t\t\tonclick=\"location.href='requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("\t\t\t\t<div onclick=\"location.href='requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("\t\t\t\t\t<div class=\"new_list_sub_top p-0\">\r\n");
      out.write("\t\t\t\t\t\t<div class=\"new_list_cate inline\">\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(rq.getCategory());
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t&nbsp;|&nbsp;\r\n");
      out.write("\t\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t\t<h1 class=\"new_list_title inline\" style=\"font-size: 14px;\">\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(rq.getTitle());
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</h1>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<hr class=\"my-3\">\r\n");
      out.write("\t\t\t<div class=\"articleMeta py-2\" onclick=\"location.href='requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("\t\t\t\t<img src=\"/capstone/signD/module/images/view.png\"/>");
      out.print(rq.getViewcount());
      out.write("&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t<img src=\"/capstone/signD/module/images/talk.png\"/>");
      out.print(recount);
      out.write("\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t");

			}
		
      out.write("\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"container nationbottom\">\r\n");
      out.write("   <div class=\"border-bottom p-2 row justify-content-between\" style=\"line-height: 49px;\">\r\n");
      out.write("      <b>진행중인 공모전</b>\r\n");
      out.write("      <div class=\"dropdown\">\r\n");
      out.write("         <button class=\"btn btn-secondary dropdown-toggle\" type=\"button\"\r\n");
      out.write("            data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">\r\n");
      out.write("            ");
if(category.equals("")){
      out.write("전체\r\n");
      out.write("               ");
}else if(category.equals("logo")){ 
      out.write('로');
      out.write('고');

               }else if(category.equals("package")){ 
      out.write('패');
      out.write('키');
      out.write('지');

               }else if(category.equals("web")){ 
      out.write('웹');

               }else if(category.equals("other")){ 
      out.write('기');
      out.write('타');
 }
      out.write("\r\n");
      out.write("          </button>\r\n");
      out.write("         <div class=\"dropdown-menu dropdown-menu-right\">\r\n");
      out.write("            <a class=\"dropdown-item\" href=\"contestList.jsp\">전체</a>\r\n");
      out.write("            <a class=\"dropdown-item\" href=\"contestList.jsp?category=logo\">로고</a> \r\n");
      out.write("            <a class=\"dropdown-item\" href=\"contestList.jsp?category=package\">패키지</a>      \r\n");
      out.write("            <a class=\"dropdown-item\" href=\"contestList.jsp?category=web\">웹</a>\r\n");
      out.write("            <a class=\"dropdown-item\" href=\"contestList.jsp?category=other\">기타</a>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("   </div>\r\n");
      out.write("   ");

      if (count == 0) {
   
      out.write("\r\n");
      out.write("   <div class=\"alert alert-danger\" role=\"alert\">등록된 콘테스트가 없습니다.</div>\r\n");
      out.write("   ");

      } else {
         
         rqlist = rqdb.getSearchRequests(startRow, pageSize, "ing", keyword,category);
         
         for (int i = 0; i < rqlist.size(); i++) {
            rq = rqlist.get(i);
            ppcount = rqdb.getPPRequestCount(rq.getRequestcode());//콘테스트 참여자수
            Dday = rqdb.getDday(rq.getRequestcode());
   
      out.write("\r\n");
      out.write("   <div style=\"position: relative; overflow: hidden;\">\r\n");
      out.write("      <div class=\"new_list_icon\">\r\n");
      out.write("            ");
if (bmdb.getBookmarkCheck(id, rq.getRequestcode(), null) == 1) {
      out.write("\r\n");
      out.write("            <div data-toggle=\"button\" aria-pressed=\"true\" id=\"star");
      out.print(i);
      out.write("\">\r\n");
      out.write("               <font size=\"5\"><i class=\"fas fa-star\"></i></font>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");
} else {
      out.write("\r\n");
      out.write("            <div data-toggle=\"button\" aria-pressed=\"false\" id=\"star");
      out.print(i);
      out.write("\">\r\n");
      out.write("               <font size=\"5\"><i class=\"far fa-star\"></i></font>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");
}
      out.write("\r\n");
      out.write("      </div>\r\n");
      out.write("      <div class=\"new_list_item m-2 media row justify-content-between bgcolor");
      out.print(i);
      out.write("\">\r\n");
      out.write("         <div class=\"col-sm-8 pr-0 row align-self-center\"\r\n");
      out.write("            onclick=\"location.href='requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("            <div class=\"new_list_img align-self-center\">\r\n");
      out.write("               <img src=\"/capstone/signD/module/images/");
      out.print(rq.getCategory());
      out.write(".jpg\"\r\n");
      out.write("                  alt=\"");
      out.print(rq.getCategory());
      out.write("\">\r\n");
      out.write("            </div>\r\n");
      out.write("          \t<div class=\"inline col-sm-9 align-self-center\">\r\n");
      out.write("               <div class=\"new_list_sub_top\">\r\n");
      out.write("                  <div class=\"row col-sm-12\">\r\n");
      out.write("                     <div class=\"new_list_cate align-top\">");
      out.print(rq.getCategory());
      out.write("&nbsp;|&nbsp;</div>\r\n");
      out.write("                     <div class=\"new_list_title col-sm-9 pl-0\"> ");
      out.print(rq.getTitle());
      out.write("\r\n");
      out.write("                     \t");
if(rq.getOp_main()==1){ 
      out.write("<img src=\"/capstone/signD/module/images/like.png\" width=\"25\">");
} 
      out.write("\r\n");
      out.write("                     </div>\r\n");
      out.write("                  </div>\r\n");
      out.write("               </div>\r\n");
      out.write("               <div class=\"row col-sm-12\">\r\n");
      out.write("                  <div class=\"mr-3\">");
      out.print(rq.getCompany_name());
      out.write("</div>\r\n");
      out.write("                  <div class=\"new_list_count\">\r\n");
      out.write("                     <strong>&nbsp;&nbsp;조회수&nbsp;</strong>");
      out.print(decimal.format(rq.getViewcount()));
      out.write("명&nbsp;&nbsp;\r\n");
      out.write("                  </div>\r\n");
      out.write("               </div>\r\n");
      out.write("            </div>\r\n");
      out.write("         </div>\r\n");
      out.write("         <div class=\"new_list_right col-sm-4 align-self-center\">\r\n");
      out.write("            <div class=\"new_list_pay\">상금 : ");
      out.print(decimal.format(rq.getCost() / 10000));
      out.write("만원</div>\r\n");
      out.write("            <div class=\"new_list_day\"><strong>남은기간 : </strong> <span>");
      out.print(Dday);
      out.write("일</span>(~");
      out.print(sdf.format(rq.getEnd_date()));
      out.write(")</div>\r\n");
      out.write("            <div class=\"new_list_day\"><div class=\"new_iconBox inline\"><strong>참여자 : </strong>");
      out.print(ppcount);
      out.write("명</div></div>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("   </div>\r\n");
      out.write("   <script type=\"text/javascript\">\r\n");
      out.write("      $(document).ready(function() {\r\n");
      out.write("         $(\"#star");
      out.print(i);
      out.write("\").click(function(){\r\n");
      out.write("            bmCheck(\"");
      out.print(i);
      out.write('"');
      out.write(',');
      out.print(rq.getRequestcode());
      out.write(",null,\"");
      out.print(id);
      out.write("\");\r\n");
      out.write("          });\r\n");
      out.write("         \r\n");
      out.write("         if(");
      out.print(rq.getOp_bgcolor());
      out.write("==1){\r\n");
      out.write("            $(\".bgcolor");
      out.print(i);
      out.write("\").attr(\"style\",\"background: antiquewhite\");\r\n");
      out.write("         }else{\r\n");
      out.write("            $(\".bgcolor");
      out.print(i);
      out.write("\").attr(\"style\",\"\");\r\n");
      out.write("         }\r\n");
      out.write("      });\r\n");
      out.write("   </script>\r\n");
      out.write("   ");

         }
      }
   
      out.write("\r\n");
      out.write("   <nav aria-label=\"Page navigation\">\r\n");
      out.write("      <div class=\"w3-bar w3-large pagination justify-content-center py-3\">\r\n");
      out.write("         ");

            if (count > 0) {
               int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);//1+1(2)
               int startPage = 1;

               if (currentPage % 10 != 0)//1의자리 숫자가 0이 아니면
                  startPage = (int) (currentPage / 10) * 10 + 1;//1,11,21
               else
                  startPage = ((int) (currentPage / 10) - 1) * 10 + 1;//1,11,21

               int pageBlock = 10;
               int endPage = startPage + pageBlock - 1;//1+10-1
               if (endPage > pageCount)
                  endPage = pageCount;//2
         
      out.write("\r\n");
      out.write("         <a href=\"contestList.jsp?pageNum=");
      out.print(startPage - 10);
      out.write("&keyword=");
      out.print(keyword );
      out.write("\"\r\n");
      out.write("            class=\"w3-button w3-hover-black");
if (startPage > 10) {} else {
      out.write(" disabled");
}
      out.write("\"><<</a>\r\n");
      out.write("         ");

               for (int i = startPage; i <= endPage; i++) {
                  if(!category.equals("")){
      out.write("\r\n");
      out.write("                  <a href=\"contestList.jsp?category=");
      out.print(rq.getCategory());
      out.write("&pageNum=");
      out.print(i);
      out.write("&keyword=");
      out.print(keyword );
      out.write("\"\r\n");
      out.write("                  class=\"w3-button ");
if (currentPage == i) {
      out.write("w3-black");
} else {
      out.write("w3-hover-black");
}
      out.write('"');
      out.write('>');
      out.print(i);
      out.write("</a>\r\n");
      out.write("              ");
}else{ 
      out.write("\r\n");
      out.write("                 <a href=\"contestList.jsp?pageNum=");
      out.print(i);
      out.write("&keyword=");
      out.print(keyword );
      out.write("\"\r\n");
      out.write("                  class=\"w3-button ");
if (currentPage == i) {
      out.write("w3-black");
} else {
      out.write("w3-hover-black");
}
      out.write('"');
      out.write('>');
      out.print(i);
      out.write("</a>\r\n");
      out.write("             ");
}
            }
         
      out.write("\r\n");
      out.write("         <a href=\"contestList.jsp?pageNum=");
      out.print(startPage + 10);
      out.write("&keyword=");
      out.print(keyword );
      out.write("\"\r\n");
      out.write("            class=\"w3-button w3-hover-black");
if (endPage < pageCount) {} else {
      out.write(" disabled");
}
      out.write("\">>></a>\r\n");
      out.write("         ");

            }
         
      out.write("\r\n");
      out.write("      </div>\r\n");
      out.write("   </nav>\r\n");
      out.write("</div>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/bottom.jsp", out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/footer.inc.jsp", out, false);
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}