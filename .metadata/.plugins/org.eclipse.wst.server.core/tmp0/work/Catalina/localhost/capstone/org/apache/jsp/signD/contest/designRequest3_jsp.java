/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.37
 * Generated at: 2019-02-21 14:23:32 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.signD.contest;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import java.io.IOException;
import java.util.Enumeration;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.MultipartRequest;
import java.text.DecimalFormat;
import signD.member.LogonDataBean;
import signD.member.LogonDBBean;

public final class designRequest3_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

DecimalFormat price = new DecimalFormat("#,###");
	DecimalFormat decimal = new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
    _jspx_imports_classes.add("java.util.Enumeration");
    _jspx_imports_classes.add("com.oreilly.servlet.multipart.DefaultFileRenamePolicy");
    _jspx_imports_classes.add("java.text.DecimalFormat");
    _jspx_imports_classes.add("signD.member.LogonDataBean");
    _jspx_imports_classes.add("java.text.SimpleDateFormat");
    _jspx_imports_classes.add("java.io.IOException");
    _jspx_imports_classes.add("signD.member.LogonDBBean");
    _jspx_imports_classes.add("com.oreilly.servlet.MultipartRequest");
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
	response.setContentType("text/html;charset=UTF-8");
	String title = "step3 | DO";
	String id = (String) session.getAttribute("id");
	String category=request.getParameter("category");

	LogonDBBean Logon = LogonDBBean.getInstance();
	LogonDataBean member = Logon.getMember(id);

      out.write('\r');
      out.write('\n');
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

	String realFolder = "";//웹 어플리케이션상의 절대 경로
	String saveFolder = "/fileSave/referenceFile/"+category;//파일이 업로드되는 폴더를 지정한다.
	String encType = "utf-8"; //엔코딩타입
	int maxSize = 5 * 1024 * 1024; //최대 업로될 파일크기 5Mb

	ServletContext context = getServletContext();
	//현재 jsp페이지의 웹 어플리케이션상의 절대 경로를 구한다
	realFolder = context.getRealPath(saveFolder);
	
	if (id != null && member.getType().equals("의뢰인")) {

      out.write("\r\n");
      out.write("\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/header.inc.jsp" + "?" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode("title", request.getCharacterEncoding())+ "=" + org.apache.jasper.runtime.JspRuntimeLibrary.URLEncode(String.valueOf(title), request.getCharacterEncoding()), out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/menubar.jsp", out, false);
      out.write("\r\n");
      out.write("<div class=\"bgi2\">\r\n");
      out.write("\t<section class=\"jumbotron text-center img-cover\">\r\n");
      out.write("\t\t<div class=\"container py-4\">\r\n");
      out.write("\t\t\t<h1 class=\"jumbotron-heading jumbotitle\"><strong>디자인 공모하기-3단계</strong></h1>\r\n");
      out.write("\t\t\t<p class=\"lead\"><strong>공모할 디자인의 상금 및 추가옵션을 선택하세요.</strong></p>\r\n");
      out.write("\t\t\t<div class=\"pt-3\">\r\n");
      out.write("\t\t\t\t<div class=\"row bs2\">\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">1단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">2단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 dan\">3단계</div>\r\n");
      out.write("\t\t\t\t\t<div class=\"col-sm-3 nodan\">4단계</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"prog\">\r\n");
      out.write("\t\t\t\t\t<div class=\"progress-bar\" style=\"width: 75%; background-color: tomato;\"></div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</section>\r\n");
      out.write("</div>\r\n");

	try {
			MultipartRequest multi = null;

			//전송을 담당할 콤포넌트를 생성하고 파일을 전송한다.
			//전송할 파일명을 가지고 있는 객체, 서버상의 절대경로,최대 업로드될 파일크기, 문자코드, 기본 보안 적용
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

			//Form의 파라미터 목록을 가져온다
			Enumeration<?> params = multi.getParameterNames();

			//파라미터를 출력한다
			while (params.hasMoreElements()) {
				String name = (String) params.nextElement(); //전송되는 파라미터이름
				String value = multi.getParameter(name); //전송되는 파라미터값  
				if (name.equals("category")) {
					rq.setCategory(value);
				} else if (name.equals("title")) {
					rq.setTitle(value);
				} else if (name.equals("service")) {
					rq.setService(value.replace("\r\n", "<br>"));
				} else if (name.equals("company_name")) {
					rq.setCompany_name(value);
				} else if (name.equals("job_kind")) {
					rq.setJob_kind(value);
				} else if (name.equals("color")) {
					String color_detail = multi.getParameter("color_detail");
					if (color_detail == null || color_detail.equals("")) {
						rq.setColor(value);
					} else {
						rq.setColor(value + "," + color_detail);
					}
				} else if (name.equals("plan")) {
					String plans = multi.getParameter("plans");
					if (plans == null || plans.equals("")) {
						rq.setPlan(value.replace("\r\n", "<br>"));
					} else {
						rq.setPlan(plans + value.replace("\r\n", "<br>") );
					}
				} else if (name.equals("pages")) {
					rq.setPages(value);
				} else if (name.equals("website")) {
					rq.setPages(value);
				} else if (name.equals("slogan")) {
					rq.setSlogan(value);
				} else if (name.equals("request")) {
					rq.setRequest(value.replace("\r\n", "<br>"));
				}
			}

			//전송한 파일 정보를 가져와 출력한다
			Enumeration<?> files = multi.getFileNames();

			//파일 정보가 있다면
			while (files.hasMoreElements()) {
				//input 태그의 속성이 file인 태그의 name 속성값 :파라미터이름
				String name = (String) files.nextElement();

				//서버에 저장된 파일 이름
				String filename = multi.getFilesystemName(name);
				rq.setFile(filename);

				if (rq.getCategory().equals("logo")) {
					rq.setCost(300000);
				} else if (rq.getCategory().equals("package")) {
					rq.setCost(400000);
				} else if (rq.getCategory().equals("web")) {
					rq.setCost(500000);
				} else {
					rq.setCost(100000);
				}

      out.write("\r\n");
      out.write("\r\n");
      out.write("<div class=\"container requestbg footerbottom\">\r\n");
      out.write("\t<div class=\"content\">\r\n");
      out.write("\t\t<form method=\"post\" action=\"designRequest4.jsp\" class=\"m-0\">\r\n");
      out.write("\t\t\t<input name=\"category\" value=\"");
      out.print(rq.getCategory());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"title\" value=\"");
      out.print(rq.getTitle());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"company_name\" value=\"");
      out.print(rq.getCompany_name());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t\t<input name=\"service\" value=\"");
      out.print(rq.getService());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t\t<input name=\"job_kind\" value=\"");
      out.print(rq.getJob_kind());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"pages\" value=\"");
      out.print(rq.getPages());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"website\" value=\"");
      out.print(rq.getWebsite());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"color\" value=\"");
      out.print(rq.getColor());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<input name=\"plan\" value=\"");
      out.print(rq.getPlan());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t\t<input name=\"file\" value=\"");
      out.print(rq.getFile());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t\t<input name=\"slogan\" value=\"");
      out.print(rq.getSlogan());
      out.write("\" hidden=\"true\"> \r\n");
      out.write("\t\t\t<input name=\"request\" value=\"");
      out.print(rq.getRequest());
      out.write("\" hidden=\"true\">\r\n");
      out.write("\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t<label class=\"lbr\">1.상금 직접 입력</label> \r\n");
      out.write("\t\t\t\t<input class=\"inp mx-5\" type=\"text\" name=\"cost\" id=\"cost\" value=\"");
      out.print(rq.getCost());
      out.write("\" \r\n");
      out.write("\t\t\t\t\tplaceholder=\"최소 ");
      out.print(price.format(rq.getCost()/10000));
      out.write("만원 이상\" required onchange=\"costChange(");
      out.print(rq.getCost());
      out.write(',');
      out.write('\'');
      out.print(price.format(rq.getCost()/10000));
      out.write("')\">\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t<label class=\"lbr\">2.상금 수수료 부담</label>\r\n");
      out.write("\t\t\t\t<div class=\"input_chk mx-5\">\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"self_tax\" id=\"self_tax\" value=\"1\"> \r\n");
      out.write("\t\t\t\t\t<label for=\"self_tax\">본인이 부담(디자이너에게 상금 100% 지급, 선택시 상금액의 20%를 부담하게 됩니다.)</label>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t<div class=\"mb-3\">\r\n");
      out.write("\t\t\t\t<label class=\"lbr\">3.추가 옵션사항</label>\r\n");
      out.write("\t\t\t\t<div class=\"input_chk mx-5\">\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"op_main\" id=\"op_main\" value=\"1\" onchange=\"optionCheck()\">\r\n");
      out.write("\t\t\t\t\t<label for=\"op_main\">상단노출 옵션(50,000원)</label>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"input_chk mx-5\">\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"op_bgcolor\" id=\"op_bgcolor\" value=\"1\" onchange=\"optionCheck()\">\r\n");
      out.write("\t\t\t\t\t<label for=\"op_bgcolor\">배경색 특수(30,000원)</label>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t<div class=\"input_chk mx-5\">\r\n");
      out.write("\t\t\t\t\t<input type=\"checkbox\" name=\"op_week\" id=\"op_week\" value=\"1\" onchange=\"optionCheck()\">\r\n");
      out.write("\t\t\t\t\t<label for=\"op_week\" >일주일 연장(70,000원)</label>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\t\t\r\n");
      out.write("\t\t\t<div class=\"mb-5\" style=\"position: relative; overflow: hidden;\">\r\n");
      out.write("\t\t      <div class=\"new_list_icon\">\r\n");
      out.write("\t            <div data-toggle=\"button\" aria-pressed=\"false\" id=\"star\">\r\n");
      out.write("\t               <font size=\"5\"><i class=\"far fa-star\"></i></font>\r\n");
      out.write("\t            </div>\r\n");
      out.write("\t\t      </div>\r\n");
      out.write("\t\t      <div class=\"new_list_item m-2 media row justify-content-between bgcolor\">\r\n");
      out.write("\t\t         <div class=\"col-sm-8 pr-0 row align-self-center\"\r\n");
      out.write("\t\t            onclick=\"location.href='requestDetail.jsp?requestcode=");
      out.print(rq.getRequestcode());
      out.write("'\">\r\n");
      out.write("\t\t            <div class=\"new_list_img align-self-center\">\r\n");
      out.write("\t\t               <img src=\"/capstone/signD/module/images/");
      out.print(rq.getCategory());
      out.write(".jpg\"\r\n");
      out.write("\t\t                  alt=\"");
      out.print(rq.getCategory());
      out.write("\">\r\n");
      out.write("\t\t            </div>\r\n");
      out.write("\t\t          \t<div class=\"inline col-sm-9 align-self-center\">\r\n");
      out.write("\t\t               <div class=\"new_list_sub_top\">\r\n");
      out.write("\t\t                  <div class=\"row col-sm-12\">\r\n");
      out.write("\t\t                     <div class=\"new_list_cate align-top\">");
      out.print(rq.getCategory());
      out.write("&nbsp;|&nbsp;</div>\r\n");
      out.write("\t\t                     <div class=\"new_list_title pl-0\"> ");
      out.print(rq.getTitle());
      out.write("</div>\r\n");
      out.write("\t\t                  </div>\r\n");
      out.write("\t\t               </div>\r\n");
      out.write("\t\t               <div class=\"row col-sm-12\">\r\n");
      out.write("\t\t                  <div class=\"mr-3\">");
      out.print(rq.getCompany_name());
      out.write("</div>\r\n");
      out.write("\t\t                  <div class=\"new_list_count\">\r\n");
      out.write("\t\t                     <strong>&nbsp;&nbsp;조회수&nbsp;</strong>");
      out.print(decimal.format(rq.getViewcount()));
      out.write("명&nbsp;&nbsp;\r\n");
      out.write("\t\t                  </div>\r\n");
      out.write("\t\t               </div>\r\n");
      out.write("\t\t            </div>\r\n");
      out.write("\t\t         </div>\r\n");
      out.write("\t\t         <div class=\"new_list_right col-sm-4 align-self-center\">\r\n");
      out.write("\t\t            <div class=\"new_list_pay\">상금 : ");
      out.print(decimal.format(rq.getCost() / 10000));
      out.write("만원</div>\r\n");
      out.write("\t\t            <div class=\"new_list_day\"><strong>남은기간 : </strong>\r\n");
      out.write("\t\t\t\t\t\t<span class=\"week\">7일(~");
      out.print(sdf.format(System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000)));
      out.write(")</span>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t            <div class=\"new_list_day\"><div class=\"new_iconBox inline\"><strong>참여자 : </strong>0명</div></div>\r\n");
      out.write("\t\t         </div>\r\n");
      out.write("\t\t      </div>\r\n");
      out.write("\t\t   </div>\r\n");
      out.write("\t\t\t<div class=\"text-center\"><button type=\"submit\" class=\"btn btnOr btn-lg\">확인</button></div>\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("//designerRequest3.jsp 옵션 선택시\r\n");
      out.write("function optionCheck(){\r\n");
      out.write("\tif(document.getElementById(\"op_main\").checked){\r\n");
      out.write("\t\t $(\".new_list_title\").html('");
      out.print(rq.getTitle());
      out.write("   <img src=\"/capstone/signD/module/images/like.png\" width=\"25\">');\r\n");
      out.write("\t}else{\r\n");
      out.write("\t\t $(\".new_list_title\").html('");
      out.print(rq.getTitle());
      out.write("');\r\n");
      out.write("\t}\r\n");
      out.write("\tif(document.getElementById(\"op_bgcolor\").checked){\r\n");
      out.write("\t\t$(\".bgcolor\").attr(\"style\",\"background: antiquewhite\");\r\n");
      out.write("\t}else {\r\n");
      out.write("\t\t$(\".bgcolor\").attr(\"style\",\"\");\r\n");
      out.write("\t}\r\n");
      out.write("\tif (document.getElementById(\"op_week\").checked) {\r\n");
      out.write("\t\t$(\".week\").html(\"14일(~");
      out.print(sdf.format(System.currentTimeMillis() + (14 * 60 * 60 * 24 * 1000)));
      out.write(")\");//2주 후 (일주일 연장)\r\n");
      out.write("\t} else {\r\n");
      out.write("\t\t$(\".week\").html(\"7일(~");
      out.print(sdf.format(System.currentTimeMillis() + (7 * 60 * 60 * 24 * 1000)));
      out.write(")\");//1주 후\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../module/bottom.jsp", out, false);
      out.write('\r');
      out.write('\n');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/_layout/footer.inc.jsp", out, false);
      out.write('\r');
      out.write('\n');

			}
		} catch (IOException ioe) {
			System.out.println(ioe);
		} catch (Exception ex) {
			System.out.println(ex);
		}
	} else {

      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\talert('권한이 없습니다.');\r\n");
      out.write("\tdocument.location.href = \"/capstone/signD/main.jsp\";\r\n");
      out.write("</script>\r\n");

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
