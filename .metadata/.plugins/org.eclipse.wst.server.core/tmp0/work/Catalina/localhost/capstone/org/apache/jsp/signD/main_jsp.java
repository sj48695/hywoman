/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2019-02-21 13:22:16 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.signD;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import signD.contest.RequestDataBean;
import signD.contest.RequestDBBean;
import java.text.DecimalFormat;
import signD.member.PortfolioDataBean;
import signD.member.PortfolioDBBean;
import java.util.List;
import signD.member.LogonDBBean;
import signD.member.LogonDataBean;

public final class main_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

DecimalFormat price = new DecimalFormat("#,###");
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
    _jspx_imports_classes.add("signD.member.PortfolioDataBean");
    _jspx_imports_classes.add("signD.contest.RequestDBBean");
    _jspx_imports_classes.add("java.text.DecimalFormat");
    _jspx_imports_classes.add("signD.member.LogonDataBean");
    _jspx_imports_classes.add("signD.contest.RequestDataBean");
    _jspx_imports_classes.add("signD.member.PortfolioDBBean");
    _jspx_imports_classes.add("signD.member.LogonDBBean");
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
      out.write('\r');
      out.write('\n');

   request.setCharacterEncoding("utf-8");
   String title = "DO";
   String id=(String)session.getAttribute("id");
   String keyword=request.getParameter("keyword");
   if (keyword==null){
      keyword="";
   }
   
   LogonDBBean logon=LogonDBBean.getInstance();
   /* List<LogonDataBean> designerlist=logon.getDesignerList(1, 5, keyword,""); */
   List<LogonDataBean> designerlist=null;
   LogonDataBean designer=null;

   PortfolioDBBean pfdb = PortfolioDBBean.getInstance();
   List<PortfolioDataBean> pflist = pfdb.getPortfolios(1,8,"");
   PortfolioDataBean portfolio = null;
   int pfcount=pfdb.getPortfoliosCount("");
   
   RequestDBBean rqdb = RequestDBBean.getInstance();
   List<RequestDataBean> rqlist=null;
   RequestDataBean rq=null;
   String dday=null;

      out.write("\r\n");
      out.write("\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/header.inc.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("title", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(title ), request.getCharacterEncoding()), out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "module/menubar.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("id", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(id ), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("<style>\r\n");
      out.write("   .carousel-item {\r\n");
      out.write("      height: 33rem;\r\n");
      out.write("      background-color: #fff;\r\n");
      out.write("   }\r\n");
      out.write("</style>\r\n");
      out.write("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js\"></script>\r\n");
      out.write("<script>\r\n");
      out.write("        jQuery(document).ready(function($) {\r\n");
      out.write("            $('.counter').counterUp({\r\n");
      out.write("                delay: 10,\r\n");
      out.write("                time: 1000\r\n");
      out.write("            });\r\n");
      out.write("        });\r\n");
      out.write("</script> \r\n");
      out.write("   <div id=\"myCarousel\" class=\"carousel slide\" data-ride=\"carousel\">\r\n");
      out.write("        <ol class=\"carousel-indicators\">\r\n");
      out.write("          <li data-target=\"#myCarousel\" data-slide-to=\"0\" class=\"active\"></li>\r\n");
      out.write("          <li data-target=\"#myCarousel\" data-slide-to=\"1\"></li>\r\n");
      out.write("          <li data-target=\"#myCarousel\" data-slide-to=\"2\"></li>\r\n");
      out.write("        </ol>\r\n");
      out.write("        <div class=\"carousel-inner\">\r\n");
      out.write("          <div class=\"carousel-item active text-center\">\r\n");
      out.write("            <img class=\"first-slide carousel_img\" src=\"module/images/phon.png\" alt=\"First slide\">\r\n");
      out.write("            <!-- <div class=\"container\">\r\n");
      out.write("              <div class=\"carousel-caption text-left\">\r\n");
      out.write("                <h1>Example headline.</h1>\r\n");
      out.write("                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\r\n");
      out.write("                <p><a class=\"btn btn-lg btn-primary\" href=\"#\" role=\"button\">Sign up today</a></p>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div> -->\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"carousel-item text-center\">\r\n");
      out.write("            <img class=\"second-slide carousel_img\" src=\"module/images/mh.png\" \" alt=\"Second slide\">\r\n");
      out.write("            <!-- <div class=\"container\">\r\n");
      out.write("              <div class=\"carousel-caption\">\r\n");
      out.write("                <h1>Another example headline.</h1>\r\n");
      out.write("                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>\r\n");
      out.write("                <p><a class=\"btn btn-lg btn-primary\" href=\"#\" role=\"button\">Learn more</a></p>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div> -->\r\n");
      out.write("          </div>\r\n");
      out.write("          <div class=\"carousel-item text-center\">\r\n");
      out.write("            <img class=\"third-slide carousel_img\" src=\"module/images/carousel3.png\" alt=\"Third slide\">\r\n");
      out.write("            <!-- <div class=\"container\">\r\n");
      out.write("              <div class=\"carousel-caption text-right\" style=\"color:#000;\">\r\n");
      out.write("                <h2>SK 텔레콤</h2>\r\n");
      out.write("                <p>상금: 200만원</p>\r\n");
      out.write("                <p><a class=\"btn btn-lg btn-dark\" href=\"#\" role=\"button\">우승작 보기</a></p>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div> -->\r\n");
      out.write("          </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <a class=\"carousel-control-prev \" href=\"#myCarousel\" role=\"button\" data-slide=\"prev\">\r\n");
      out.write("          <span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>\r\n");
      out.write("          <span class=\"sr-only\">Previous</span>\r\n");
      out.write("        </a>\r\n");
      out.write("        <a class=\"carousel-control-next\" href=\"#myCarousel\" role=\"button\" data-slide=\"next\">\r\n");
      out.write("          <span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>\r\n");
      out.write("          <span class=\"sr-only\">Next</span>\r\n");
      out.write("        </a>\r\n");
      out.write("      </div>\r\n");
      out.write("      \r\n");
      out.write("      <div style=\"background-color: #eee;\">\r\n");
      out.write("   <div class=\"container\">\r\n");
      out.write("      <div class=\"middle_box py-5\">\r\n");
      out.write("         <p><span style=\"font-size: 25px;\"><img src=\"module/images/prize-trophy.png\" style=\"width:40px;\"> \r\n");
      out.write("             콘테스트 누적상금액<span class=\"counter\">");
      out.print(price.format(logon.getTotalPrize_money()) );
      out.write("</span></p>\r\n");
      out.write("         </span>\r\n");
      out.write("      </div>\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      out.write("<script src=\"//cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js\"></script>\r\n");
      out.write("<script src=\"/capstone/assets/Counter-Up-master/jquery.counterup.min.js\"></script>\r\n");
      out.write("<div class=\"top_contest\">\r\n");
      out.write("<div class=\"container\">\r\n");
      out.write("<div><p class=\"top_contest_font\">인기 콘테스트</p></div>\r\n");
      out.write("<div class=\"container py-5\">\r\n");
      out.write("   <div class=\"row\" style=\"/* flex-wrap: inherit; */\">\r\n");
      out.write("      ");

         rqlist = rqdb.contestMain4();
         if (rqdb.contestMain4Count() != 0) {
            for (int i = 0; i < rqlist.size(); i++) {
               rq = rqlist.get(i);
      
      out.write("\r\n");
      out.write("      <div class=\"col-md-3 pointer\" onclick=\"location.href='/capstone/signD/contest/requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("         <div class=\"card mb-4 shadow-sm\">\r\n");
      out.write("            <div class=\"card_effect\">\r\n");
      out.write("               <img class=\"card-img-top\" src=\"/capstone/signD/module/images/");
      out.print(rq.getCategory() );
      out.write(".jpg\" alt=\"Card image cap\">\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"card-body\">\r\n");
      out.write("               <h6 class=\"ellipsis\"><span class=\"badge badge-secondary\">");
      out.print(rq.getCategory() );
      out.write("</span>");
      out.print(rq.getTitle() );
      out.write("</h6>\r\n");
      out.write("               <p class=\"card-text ellipsis3\">");
      out.print(rq.getRequest() );
      out.write("</p>\r\n");
      out.write("            </div>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      ");

            }
            for(int i=0;i<4-rqlist.size();i++){
      
      out.write("\r\n");
      out.write("      <div class=\"col-md-3 pointer\"  onclick=\"location.href='/capstone/signD/contest/designRequest1.jsp'\">\r\n");
      out.write("         <div class=\"card mb-4 shadow-sm\">\r\n");
      out.write("            <div class=\"card_effect\">\r\n");
      out.write("               <img class=\"card-img-top\" src=\"/capstone/signD/module/images/+.png\" alt=\"Card image cap\">\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"card-body\">\r\n");
      out.write("               <p class=\"card-text ellipsis3\">콘테스트 의뢰하러가기</p>\r\n");
      out.write("            </div>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      ");

            }
         } else {
            for (int i = 0; i < 4; i++) {
      
      out.write("\r\n");
      out.write("      <div class=\"col-md-3 pointer\"  onclick=\"location.href='/capstone/signD/contest/designRequest1.jsp'\">\r\n");
      out.write("         <div class=\"card mb-4 shadow-sm\">\r\n");
      out.write("            <div class=\"card_effect\">\r\n");
      out.write("               <img class=\"card-img-top\" src=\"/capstone/signD/module/images/1.jpg\" alt=\"Card image cap\">\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"card-body\">\r\n");
      out.write("               <h6><span class=\"badge badge-secondary\">");
      out.print(i);
      out.write("</span>");
      out.print(i );
      out.write("</h6>\r\n");
      out.write("               <p class=\"card-text ellipsis3\">");
      out.print(i );
      out.write("</p>\r\n");
      out.write("            </div>\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("      ");

            }
         }
      
      out.write("\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("</div>\r\n");
      out.write("      \r\n");
      out.write("      \r\n");
      out.write("<div class=\"client_box\" style=\"background-color: #eee;\">\r\n");
      out.write("   <div class=\"container\">\r\n");
      out.write("      <div><p class=\"client_font\">콘테스트 진행중</p></div>\r\n");
      out.write("      <div class=\"contest_content row py-2\">\r\n");
      out.write("         <div class=\"col-sm-6\">\r\n");
      out.write("            <div class=\"contest_category\">\r\n");
      out.write("               <span style=\"text-align: center;\"><img src=\"module/images/stopwatch.png\" style=\"width:20px;\"> 마감임박 콘테스트 리스트</span>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");
    
               rqlist=rqdb.getRequests(1, 5, "deadline imminent");
               if(rqdb.getRequestCount("deadline imminent")!=0){
                  for (int i = 0; i < rqlist.size(); i++) {
                     rq = rqlist.get(i);
                     dday = rqdb.getDday(rq.getRequestcode());
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row\" \r\n");
      out.write("               onclick=\"location.href='contest/requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("               <img src=\"module/images/angle-right.png\" class=\"w3-col s1\"\r\n");
      out.write("                  style=\"width: 15px; height: 15px; margin: 17px; margin-right: 10px;\">\r\n");
      out.write("               <div class=\"contest_item_content w3-col s5 text-left\" style=\"font-weight: bold;\">");
      out.print(rq.getTitle());
      out.write("</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\">");
      out.print(rq.getCategory());
      out.write("</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\">");
      out.print(price.format(rq.getCost() / 10000));
      out.write("만원</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\" style=\"font-weight: 800;\">D-");
      out.print(dday);
      out.write("</div>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

               }
                  for (int i = 0; i < 5 - rqlist.size(); i++) {
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row justify-content-center\" \r\n");
      out.write("               onclick=\"location.href='contest/designRequest1.jsp'\">\r\n");
      out.write("               <img src=\"module/images/+2.png\" style=\"width: 15px; height: 15px\">\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

                  }
               }else{
                  for (int i = 0; i < 5 ; i++) {
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row justify-content-center\" \r\n");
      out.write("               onclick=\"location.href='contest/designRequest1.jsp'\">\r\n");
      out.write("               <img src=\"module/images/+2.png\" style=\"width: 15px; height: 15px\">\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

                  }
               }
            
      out.write("\r\n");
      out.write("         </div>\r\n");
      out.write("\r\n");
      out.write("         <div class=\"col-sm-6\">\r\n");
      out.write("            <div class=\"contest_category\">\r\n");
      out.write("               <span><img src=\"module/images/new.png\" style=\"width:30px;\"> 최신등록 콘테스트 리스트</span>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

               rqlist = rqdb.getRequests(1, 5, "ing");
               if (rqdb.getRequestCount("ing","","") != 0) {
                  for (int i = 0; i < rqlist.size(); i++) {
                     rq = rqlist.get(i);
                     dday = rqdb.getDday(rq.getRequestcode());
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row\"\r\n");
      out.write("               onclick=\"location.href='contest/requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("               <img src=\"module/images/angle-right.png\" class=\"w3-col s1\"\r\n");
      out.write("                  style=\"width: 15px; height: 15px; margin: 17px; margin-right: 10px;\">\r\n");
      out.write("               <div class=\"contest_item_content w3-col s5 text-left\" style=\"font-weight: bold;\">");
      out.print(rq.getTitle());
      out.write("</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\">");
      out.print(rq.getCategory());
      out.write("</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\">");
      out.print(price.format(rq.getCost() / 10000));
      out.write("만원</div>\r\n");
      out.write("               <div class=\"contest_item_content w3-col s2\" style=\"font-weight: 800;\">D-");
      out.print(dday);
      out.write("</div>\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

                  }
                  for (int i = 0; i < 5 - rqlist.size(); i++) {
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row justify-content-center\" \r\n");
      out.write("               onclick=\"location.href='contest/designRequest1.jsp'\">\r\n");
      out.write("               <img src=\"module/images/+2.png\" style=\"width: 15px; height: 15px\">\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

                  }
               }else{
                  for (int i = 0; i < 5 ; i++) {
            
      out.write("\r\n");
      out.write("            <div class=\"contest_item w3-row justify-content-center\" \r\n");
      out.write("               onclick=\"location.href='contest/designRequest1.jsp'\">\r\n");
      out.write("               <img src=\"module/images/+2.png\" style=\"width: 15px; height: 15px\">\r\n");
      out.write("            </div>\r\n");
      out.write("            ");

                  }
               }
            
      out.write("\r\n");
      out.write("         </div>\r\n");
      out.write("      </div>\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      out.write("<!-- 디자이너 배너 -->\r\n");
      out.write("<div class=\"top_designer container\">\r\n");
      out.write("   <div><p class=\"top_designer_font\">TOP 디자이너</p></div>\r\n");
      out.write("   <div class=\"row text-center\" style=\"margin: 50px 0 25px 0\">\r\n");
      out.write("      ");
if(logon.getDesignerCount("")!=0){
         designerlist=logon.designerListTop(1,5);
         for (int i = 0; i < designerlist.size(); i++) {
            designer=designerlist.get(i);
      
      out.write("\r\n");
      out.write("      <div style=\"width: 20%; height: 20%\">\r\n");
      out.write("         <a href=\"designer/profile.jsp?designerId=");
      out.print(designer.getId());
      out.write("\"> \r\n");
      out.write("            <img src=\"../imageFile/profileImg/");
      out.print(designer.getProfileimg() );
      out.write("\" class=\"designer_img\">\r\n");
      out.write("            <p style=\"text-align: center;\">");
      out.print(designer.getId() );
      out.write("</p>\r\n");
      out.write("         </a>\r\n");
      out.write("      </div>\r\n");
      out.write("      ");

         }
         }
      
      out.write("\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      out.write("<section id=\"mainmenu\">   \r\n");
      out.write("   <div class=\"container\">\r\n");
      out.write("        <div class=\"row\">\r\n");
      out.write("        ");

         if (pflist.size() == 0) {
      
      out.write("\r\n");
      out.write("         <div class=\"container\">등록된 포트폴리오가 없습니다.</div>\r\n");
      out.write("      ");

         } else {
            if(pfcount>=8){pfcount=8;}else{pfcount=pflist.size();}
            for (int i = 0; i < pfcount; i++) {
				portfolio = (PortfolioDataBean) pflist.get(i);
				String filenames[]=portfolio.getFile().split(",");
				rq=rqdb.getRequest(portfolio.getRequestcode());
	
      out.write("\r\n");
      out.write("\t\t<div class=\"col-md-3\">\r\n");
      out.write("\t\t\t<div class=\"mb-4 shadow-sm\">\r\n");
      out.write("\t\t\t\t<div class=\"mainmenu-thumb\" data-toggle=\"modal\" data-target=\"#portfolio");
      out.print(i+1);
      out.write("\" onclick=\"viewCount(0,");
      out.print(portfolio.getPortfoliocode() );
      out.write(")\">\r\n");
      out.write("\t\t\t\t\t<img class=\"img-responsive\" style=\"height:255px\"\r\n");
      out.write("\t\t\t\t\t\t  src=\"../fileSave/portfolioFile/");
if(portfolio.getRequestcode()!=0){
      out.print(rq.getCategory() );
      out.write('/');
} 
      out.print(filenames[filenames.length-1]);
      out.write("\">\r\n");
      out.write("\t\t\t\t   <div class=\"mainmenu-overlay\">\r\n");
      out.write("\t                  <div class=\"mainmenu-item\">\r\n");
      out.write("\t                     <h5>");
      out.print(portfolio.getTitle() );
      out.write("</h5>\r\n");
      out.write("\t                     <small class=\"ellipsis3\">");
      out.print(portfolio.getContents() );
      out.write("</small>\r\n");
      out.write("\t                  </div>\r\n");
      out.write("\t               </div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"modal fade\" id=\"portfolio");
      out.print(i+1);
      out.write("\" tabindex=\"-1\" role=\"dialog\" aria-hidden=\"true\">\r\n");
      out.write("\t\t\t\t\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "designer/portfolioModal.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("portfoliocode", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(portfolio.getPortfoliocode() ), request.getCharacterEncoding()) + "&" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("requestcode", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(portfolio.getRequestcode() ), request.getCharacterEncoding()), out, false);
      out.write("\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<script>\r\n");
      out.write("\t\t$(document).ready(function(){\r\n");
      out.write("\t\t\t$('#portfolio");
      out.print(i+1);
      out.write("').on('shown.bs.modal', function () {\r\n");
      out.write("\t\t\t\tvar minheight=$(\"#carouselFade");
      out.print(portfolio.getPortfoliocode());
      out.write("\").height();\r\n");
      out.write("\t\t\t\tconsole.log(minheight);\r\n");
      out.write("\t\t\t\tdocument.getElementById(\"content");
      out.print(portfolio.getPortfoliocode());
      out.write("\").style.minHeight=minheight+\"px\";\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t</script>\r\n");
      out.write("\t");

			}
         }
      
      out.write("\r\n");
      out.write("      </div>\r\n");
      out.write("   </div>\r\n");
      out.write("</section>\r\n");
      out.write("<!-- 클라이언트 로고 -->\r\n");
      out.write("<div class=\"client_box\" style=\"background-color: #eee;\">\r\n");
      out.write("   <div><p class=\"client_font\">함께한 고객사</p></div>\r\n");
      out.write("   <div class=\"container\">\r\n");
      out.write("      <ul class=\"clientlogo_box\">\r\n");
      out.write("         ");

            for (int i = 1; i < 16; i++) {
         
      out.write("\r\n");
      out.write("         <li class=\"clientlogo\"><img src=\"module/clientlogo/logo");
      out.print(i);
      out.write(".png\"></li>\r\n");
      out.write("         ");

            }
         
      out.write("\r\n");
      out.write("      </ul>\r\n");
      out.write("   </div>\r\n");
      out.write("</div>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "module/bottom.jsp", out, false);
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
