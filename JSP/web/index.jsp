<%-- 
    Document   : index
    Created on : 19.03.2012, 20:06:09
    Author     : User
--%>

<%@page import="funpack.misc"%>
<%@page import="funpack.misc"%>
<%@page import="java.sql.Connection"%>
<%@page import="funpack.category"%>
<%@page import="funpack.magazine"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="funpack.release"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="false" errorPage="errorHandler.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Журналы</title>
    </head>
    <body>
<%!
int I,Kolvo,CountRel,Way;
List list;
Iterator<String> it;
String sID,sRelName,sComm,sMagName,sDate,sImgName,sTemp,sch;
Connection con = null;
%><%con = misc.openCon();%>
        <div class="PageBackgroundGradient"></div>
        <div class="PageBackgroundGlare">
            <div class="PageBackgroundGlareImage"></div>
        </div>
        <div class="Main">
            <div class="Sheet">
                <div class="Sheet-body">
    <div class="nav">
      <ul class="menu">
        <li><a href="index.jsp" class="ActiveItem"><span><span>Главная</span></span></a></li>
        <li><a href="#"><span><span>Категории</span></span></a>
          <ul>
            <li><a href="#">Photos</a>
              <ul>
                <li><a href="#">2008</a></li>
                <li><a href="#">2007</a></li>
                <li><a href="#">2006</a></li>
              </ul>
            </li>
            <li><a href="#">Gadgets</a></li>
            <li><a href="#">News</a></li>
            <li><a href="#">Posts</a></li>
          </ul>
        </li>
        <li><a href="#"><span><span>Арихивы</span></span></a>
          <ul>
            <li><a href="#">2008</a>
              <ul>
                <li><a href="#">January</a></li>
                <li><a href="#">February</a></li>
                <li><a href="#">March</a></li>
              </ul>
            </li>
            <li><a href="#">2007</a> 
              <ul>
                <li><a href="#">January</a></li>
                <li><a href="#">February</a></li>
                <li><a href="#">March</a></li>
              </ul>
            </li>
            <li><a href="#">2006</a>
              <ul>
                <li><a href="#">January</a></li>
                <li><a href="#">February</a></li>
                <li><a href="#">March</a></li>
              </ul>
            </li>
          </ul>
        </li>
        <li><a href="about.jsp"><span><span>О сайте</span></span></a></li>
      </ul>
      <div class="l"></div>
      <div class="r"><div></div></div>
    </div>


    <div class="contentLayout">
          <div class="content">
              <div class="Block">
                  <div class="Block-body">
                      <div class="BlockContent">
                          <div class="BlockContent-body">
                              <%
                              sTemp = request.getParameter("way");
                              sch = request.getParameter("sch");
                              if(sTemp!=null){
                                  Way = Integer.parseInt(sTemp);
                                  sTemp = request.getParameter("id");
                              }else Way = 0;
                              if(Way == 3)sTemp = request.getParameter("findname");
                              list = release.get(Way,sTemp,con); it = list.iterator();
                              int Iter = 0;
                              while(it.hasNext()){
                                  sID = it.next(); sRelName = it.next();
                                  sComm = it.next(); sMagName = magazine.getNameFoID(it.next(),con);
                                  sDate = it.next(); sImgName = it.next();
                              out.print("<div class=\"post\" id=\"post-9\">");
                                  out.print("<h2>"+sRelName+"</h2>");
                                  out.print("<small>"+sID+" | "+sDate+" | "+sMagName+"</small>");
                                  out.print("<div class=\"entry\">");
                                  out.print("<p><img src=\""+sImgName+"\" alt=\""+sRelName+"\" style=\"float: left; margin-right: 1em;width:165px; height:220px\"/>");
                                  out.print(sComm+"</p>");
                                  out.print("<div style=\"clear: left;\"></div>");
                                  out.print("</div>");
                                  out.print("<p class=\"postmetadata\">Posted in"+
                                      "<a href=\"#\" title=\"View all posts in Uncategorized\" rel=\"category tag\">Uncategorized</a> |   "+
                                      "<a href=\"#\" title=\"Comment on An image in a post\">5 Comments &#187;</a>"+
                                  "</p>");
                              out.print("</div><hr>");Iter++;
                              }
                              if(Way==3 && Iter==0)out.print("<center><H2>По вашему запросу ничего не найдено</H2></center>");
                          out.print("</div>");
                          out.print("<div class=\"BlockContent-tl\"></div>"+
                          "<div class=\"BlockContent-tr\"><div></div></div>"+
                          "<div class=\"BlockContent-bl\"><div></div></div>"+
                          "<div class=\"BlockContent-br\"><div></div></div>"+
                          "<div class=\"BlockContent-tc\"><div></div></div>"+
                          "<div class=\"BlockContent-bc\"><div></div></div>"+
                          "<div class=\"BlockContent-cl\"><div></div></div>"+
                          "<div class=\"BlockContent-cr\"><div></div></div>"+
                          "<div class=\"BlockContent-cc\"></div>");
                              %>
                      </div>
                  </div>
              </div>
          </div>

          <div class="sidebar1">
              <div class="Block">
                  <div class="Block-body">
                      <div class="BlockHeader">
                          Журналы <small><a href="magazine.jsp" target="_blank" > [ Добавить ]</a></small>
                          <div class="l"></div>
                          <div class="r"><div></div></div>
                      </div>
                      <div class="BlockContent">
                          <div class="BlockContent-body">
                              <ul>
                                  <%
                                  out.print("<li><a href=\"index.jsp\"> [ Все журналы ]</a> ("+release.getCountRow(null,con)+")</li>");
                                  list = magazine.getForCBox(con); it = list.iterator();
                                  while(it.hasNext()){sID = it.next(); sMagName = it.next();
                                  out.print("<li><a href=\"index.jsp?way=1&id="+sID+"\" title=\""+
                                          sMagName+"\">"+sMagName+"</a> ("+/*it.next()*/release.getCountRow(sID,con)+")</li>");
                                  }
                                  %>
                              </ul>
                          </div>
                          <div class="BlockContent-tl"></div>
                          <div class="BlockContent-tr"><div></div></div>
                          <div class="BlockContent-bl"><div></div></div>
                          <div class="BlockContent-br"><div></div></div>
                          <div class="BlockContent-tc"><div></div></div>
                          <div class="BlockContent-bc"><div></div></div>
                          <div class="BlockContent-cl"><div></div></div>
                          <div class="BlockContent-cr"><div></div></div>
                          <div class="BlockContent-cc"></div>
                      </div>
                  </div>
              </div>
              
              <div class="Block">
                  <div class="Block-body">
                      <div class="BlockHeader">
                          Категории <small><a href="category.jsp" target="_blank" > [ Добавить ]</a></small>
                          <div class="l"></div>
                          <div class="r"><div></div></div>
                      </div>
                      <div class="BlockContent">
                          <div class="BlockContent-body">
                              <ul>
                                  <%
                                  list = category.get(con); it = list.iterator();
                                  while(it.hasNext()){sID = it.next(); sMagName = it.next();
                                  out.print("<li><a href=\"index.jsp?way=2&id="+sID+"\" title=\""+
                                          sMagName+"\">"+sMagName+"</a> ("+category.getCountRow(sID,con)+")</li>");
                                  }
                                  %>
                              </ul>
                          </div>
                          <div class="BlockContent-tl"></div>
                          <div class="BlockContent-tr"><div></div></div>
                          <div class="BlockContent-bl"><div></div></div>
                          <div class="BlockContent-br"><div></div></div>
                          <div class="BlockContent-tc"><div></div></div>
                          <div class="BlockContent-bc"><div></div></div>
                          <div class="BlockContent-cl"><div></div></div>
                          <div class="BlockContent-cr"><div></div></div>
                          <div class="BlockContent-cc"></div>
                      </div>
                  </div>
              </div>
              
              <div class="Block">
                  <div class="Block-body">
                      <div class="BlockHeader">
                          Поиск
                          <div class="l"></div>
                          <div class="r"><div></div></div>
                      </div>
                      <div class="BlockContent">
                          <div class="BlockContent-body">
                              <form method="get" id="searchform" action="index.jsp">
                                  <input type="hidden" value="3" name="way" />
                                  <input type="text" value="" name="findname" id="s" style="width: 95%;" />
                                  <button class="Button" type="submit" name="search">
                                      <span class="btn">
                                          <span class="t">Search</span>
                                          <span class="r"><span></span></span>
                                          <span class="l"></span>
                                      </span>
                                  </button>
                              </form>
                          </div>
                          <div class="BlockContent-tl"></div>
                          <div class="BlockContent-tr"><div></div></div>
                          <div class="BlockContent-bl"><div></div></div>
                          <div class="BlockContent-br"><div></div></div>
                          <div class="BlockContent-tc"><div></div></div>
                          <div class="BlockContent-bc"><div></div></div>
                          <div class="BlockContent-cl"><div></div></div>
                          <div class="BlockContent-cr"><div></div></div>
                          <div class="BlockContent-cc"></div>
                      </div>
                  </div>
              </div>
              
              <!--<div class="Block">
                  <div class="Block-body">
                      <div class="BlockHeader">
                          Архивы
                          <div class="l"></div>
                          <div class="r"><div></div></div>
                      </div>
                      <div class="BlockContent">
                          <div class="BlockContent-body">
                              <ul>
                                  <li><a href="#" title="October 2007">October 2007</a></li>
                                  <li><a href="#" title="November 2007">November 2007</a></li>
                                  <li><a href="#" title="December 2007">December 2007</a></li>
                                  <li><a href="#" title="January 2008">January 2008</a></li>
                              </ul>
                          </div>
                          <div class="BlockContent-tl"></div>
                          <div class="BlockContent-tr"><div></div></div>
                          <div class="BlockContent-bl"><div></div></div>
                          <div class="BlockContent-br"><div></div></div>
                          <div class="BlockContent-tc"><div></div></div>
                          <div class="BlockContent-bc"><div></div></div>
                          <div class="BlockContent-cl"><div></div></div>
                          <div class="BlockContent-cr"><div></div></div>
                          <div class="BlockContent-cc"></div>
                      </div>
                  </div>
              </div>-->
          </div>                    
    </div>              
                </div>
                              <div class="Sheet-tl"></div>
                              <div class="Sheet-tr"><div></div></div>
                              <div class="Sheet-bl"><div></div></div>
                              <div class="Sheet-br"><div></div></div>
                              <div class="Sheet-tc"><div></div></div>
                              <div class="Sheet-bc"><div></div></div>
                              <div class="Sheet-cl"><div></div></div>
                              <div class="Sheet-cr"><div></div></div>
                              <div class="Sheet-cc"></div>
            </div>
                              <div id="footer">
                                  <%
                                  CountRel = release.getCountRow(null,con);
%>
                              </div>
        </div>
<% misc.closeCon(con);
                              /*/out.println("<H4><B>Additional Request Informatin:</B></H4>");
//out.print("<B> Request method:</B>"+request.getMedthod()+"<BR>");
out.print("<B> Request URI:</B>"+request.getRequestURI()+"<BR>");
out.print("<B> Request protocol:</B>"+request.getProtocol()+"<BR>");
//out.print("<B> Request Shema:</B>"+request.getShema()+"<BR>");
out.print("<B> Servlet path:</B>"+request.getServletPath()+"<BR>");
//out.print("<B> Servlet name:</B>"+request.getServletName()+"<BR>");
//out.print("<B> Servlet port:</B>"+request.getServletPort()+"<BR>");
out.print("<B> Path info:</B>"+request.getPathInfo()+"<BR>");
out.print("<B> Path translated:</B>"+request.getPathTranslated()+"<BR>");

out.print("<B>Characterencoding:</B>"+request.getCharacterEncoding()+"<BR>");	
out.print("<B>Query string.:</B> " + request.getQueryString()+"<BR>");
out.print("<B>Gonten.t length: </B>" + request.getContentLength() +"<BR>");
out.print("<B>Content type:</B>" + request.getContentType()  +"<BR>");
out.print("<B>Remote user:</B>" + request.getRemoteUser()  +"<BR>");
out.print("<B>Remote address:</B>" + request.getRemoteAddr()  +"<BR>");
out.print("<B>Remotehost:</B>" + request.getRemoteHost()  +"<BR>");
out.print("<B> Authorization scheme: </B>" + request.getAuthType()  +"<BR>");*/
                              %>
    </body>
</html>