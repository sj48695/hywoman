/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2019-02-21 14:23:57 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.signD.contest;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.DecimalFormat;
import signD.member.LogonDataBean;
import signD.member.LogonDBBean;
import java.util.List;
import java.text.SimpleDateFormat;

public final class designRequest4_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
    _jspx_imports_classes.add("java.text.DecimalFormat");
    _jspx_imports_classes.add("signD.member.LogonDataBean");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
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
      out.write('\r');
      out.write('\n');

	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=UTF-8");

      out.write("\r\n");
      out.write("\r\n");
      signD.contest.RequestDataBean rq = null;
      rq = (signD.contest.RequestDataBean) _jspx_page_context.getAttribute("rq", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (rq == null){
        rq = new signD.contest.RequestDataBean();
        _jspx_page_context.setAttribute("rq", rq, javax.servlet.jsp.PageContext.PAGE_SCOPE);
        out.write('\r');
        out.write('\n');
        out.write('	');
        org.apache.jasper.runtime.JspRuntimeLibrary.introspect(_jspx_page_context.findAttribute("rq"), request);
        out.write('\r');
        out.write('\n');
      }
      out.write('\r');
      out.write('\n');

	String title = "step4 | DO";
	String id = (String) session.getAttribute("id");
	int op_main=0;
	int op_bgcolor=0;
	int op_week=0;
	double self_tax=0.0;
	int addtax=0;
	int total=0;
	 
	if (request.getParameter("self_tax") != null) {
		self_tax = 0.2;
	} else {
		rq.setSelf_tax(0);
	}
	if (request.getParameter("op_main") != null) {
		op_main = 50000;
	} else {
		rq.setOp_main(0);
	}
	if (request.getParameter("op_bgcolor") != null) {
		op_bgcolor = 30000;
	} else {
		rq.setOp_bgcolor(0);
	}
	if (request.getParameter("op_week") != null) {
		op_week = 70000;
	} else {
		rq.setOp_week(0);
	}

	LogonDBBean Logon = LogonDBBean.getInstance();
	LogonDataBean member = Logon.getMember(id);

	if (id != null && member.getType().equals("의뢰인")) {

      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/header.inc.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("title", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(title), request.getCharacterEncoding()), out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/menubar.jsp", out, false);
      out.write("\r\n");
      out.write("<div class=\"bgi2\">\r\n");
      out.write("\t<section class=\"jumbotron text-center img-cover\">\r\n");
      out.write("\t\t<div class=\"container py-4\">\r\n");
      out.write("\t\t\t<h1 class=\"jumbotron-heading jumbotitle\"><strong>디자인 공모하기-4단계</strong></h1>\r\n");
      out.write("\t\t\t<p class=\"lead\"><strong>공모할 디자인의 결제수단을 선택하세요.</strong></p>\r\n");
      out.write("\t\t\t<div class=\"pt-3\">\r\n");
      out.write("\t\t\t\t<div class=\"row bs2\">\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">1단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">2단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">3단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">4단계</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"prog\">\r\n");
      out.write("\t\t\t\t\t<div class=\"progress-bar\" style=\"width: 100%; background-color: tomato;\"></div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</section>\r\n");
      out.write("</div>\r\n");
      out.write("<div class=\"container requestbg footerbottom\">\r\n");
      out.write("\t<div class=\"text-center\">\r\n");
      out.write("\t\t<img src=\"/capstone/signD/module/process.png\" class=\"w-50\">\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<h1 class=\"text-center\">Total</h1>\r\n");
      out.write("\t<p class=\"lead text-center\">영수증</p>\r\n");
      out.write("\t<div class=\"col-md-8 offset-md-2 insertsigns w-100\">\r\n");
      out.write("\t\t<ul class=\"ull\">\r\n");
      out.write("\t\t\t<li class=\"lii\">\r\n");
      out.write("\t\t\t\t<div class=\"fontb\">콘테스트 항목</div><!-- \r\n");
      out.write("\t\t\t\t<div>로고 디자인 &nbsp;&nbsp;|&nbsp;&nbsp;플래티넘패키지</div> -->\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t");
if (rq.getCategory().equals("logo")) {
					
      out.write('로');
      out.write('고');
 
				} else if (rq.getCategory().equals("package")) {
					
      out.write('패');
      out.write('키');
      out.write('지');

				} else if (rq.getCategory().equals("web")) {
					
      out.write('웹');

				} else {
					
      out.write('기');
      out.write('타');

				} 
      out.write(" 디자인</div>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"lii\">\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>상금 1등</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format(rq.getCost()) );
      out.write("</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>공모전 등록비</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">100,000</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>상금수수료</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format((int)(rq.getCost()*self_tax)) );
      out.write("</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t<li class=\"lii\">\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>상단노출 옵션</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format(op_main) );
      out.write("</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>배경색 특수</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format(op_bgcolor));
      out.write("</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div>\r\n");
      out.write("\t\t\t\t\t<span>일주일 연장</span>\r\n");
      out.write("\t\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format(op_week));
      out.write("</span>원\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t");

				addtax=(int)((rq.getCost() + 100000 + (int)(rq.getCost()*self_tax) + op_main + op_bgcolor + op_week)*0.1);
			
      out.write("\r\n");
      out.write("\t\t\t<li class=\"lii\"><span>부가세(10%)</span>\r\n");
      out.write("\t\t\t\t<div class=\"receipt\">\r\n");
      out.write("\t\t\t\t\t<span class=\"priceText\">");
      out.print(price.format(addtax) );
      out.write("</span>원\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t\t");

				total = rq.getCost() + 100000 + (int)(rq.getCost()*self_tax) + op_main + op_bgcolor + op_week + addtax;
			
      out.write("\r\n");
      out.write("\t\t\t<li style=\"border-bottom: 0;\" class=\"lii\"><span>합계</span>\r\n");
      out.write("\t\t\t\t<div class=\"receipt\" style=\"color: #f00;\">\r\n");
      out.write("\t\t\t\t\t<span class=\"priceText\" id=\"totalAmount\">");
      out.print(price.format(total) );
      out.write("</span>원\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</li>\r\n");
      out.write("\t\t</ul>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t<hr>\r\n");
      out.write("\t<form method=\"post\" action=\"requestInsertPro.jsp\">\r\n");
      out.write("\t\t<input name=\"category\" value=\"");
      out.print(rq.getCategory());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"title\" value=\"");
      out.print(rq.getTitle());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"company_name\" value=\"");
      out.print(rq.getCompany_name());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t<input name=\"service\" value=\"");
      out.print(rq.getService());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t<input name=\"job_kind\" value=\"");
      out.print(rq.getJob_kind());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"pages\" value=\"");
      out.print(rq.getPages());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"website\" value=\"");
      out.print(rq.getWebsite());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"color\" value=\"");
      out.print(rq.getColor());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"plan\" value=\"");
      out.print(rq.getPlan());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t<input name=\"file\" value=\"");
      out.print(rq.getFile());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"slogan\" value=\"");
      out.print(rq.getSlogan());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t<input name=\"request\" value=\"");
      out.print(rq.getRequest());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t<input name=\"cost\" value=\"");
      out.print(rq.getCost());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"total\" value=\"");
      out.print(total);
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"self_tax\" value=\"");
      out.print(rq.getSelf_tax());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"op_main\" value=\"");
      out.print(rq.getOp_main());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"op_bgcolor\" value=\"");
      out.print(rq.getOp_bgcolor());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t<input name=\"op_week\" value=\"");
      out.print(rq.getOp_week());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<h1 class=\"text-center\">PAY</h1>\r\n");
      out.write("\t\t<p class=\"lead text-center\">결제수단</p>\r\n");
      out.write("\t\t<div class=\"col-md-8 offset-md-2 text-center pd-0 w-100\">\r\n");
      out.write("\t\t\t<select class=\"insertsignss w-100 text-center\" name=\"dept\" id=\"dept\">\r\n");
      out.write("\t\t\t\t<option>- 결제수단 -</option>\r\n");
      out.write("\t\t\t\t<option value=\"신용\">신용카드</option>\r\n");
      out.write("\t\t\t\t<option value=\"무통장\">무통장 입금</option>\r\n");
      out.write("\t\t\t\t<option value=\"핸드폰\">핸드폰 결제</option>\r\n");
      out.write("\t\t\t</select>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<p class=\"text-center py-5\">\r\n");
      out.write("\t\t\t<button type=\"submit\" class=\"btn btnOr btn-lg\">콘테스트 개최하기</button>\r\n");
      out.write("\t\t</p>\r\n");
      out.write("\t</form>\r\n");
      out.write("</div>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/bottom.jsp", out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/footer.inc.jsp", out, false);
      out.write('\r');
      out.write('\n');

	} else {

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\talert('권한이 없습니다.');\r\n");
      out.write("\tdocument.location.href = \"/capstone/signD/main.jsp\";\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");

	}

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
