<%-- 
    Document   : release
    Created on : 23.04.2012, 23:19:59
    Author     : User
--%>

<%@page import="java.sql.Connection"%>
<%@page import="funpack.misc"%>
<%@page import="funpack.magazine"%>
<%@page import="funpack.release"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Выпуски</title>
    </head>
    <body>
    <center>
        <%!
            List list,list2; Iterator<String> it,it2;
            String mag_id,Mode,sTemp,isTemp,rel_id,pName,pCPages,pCat,pComm;
            String sID,sName,sComm,sMagID,sDate,sImgName;
Connection con = null;
%><%con = misc.openCon();%>
        <%
            mag_id = request.getParameter("mag_id"); if(mag_id==null)mag_id = magazine.getFirstID(con);
            Mode = request.getParameter("mode"); if(Mode==null)Mode = "show";
            out.print("<center><H1>Журнал: \""+magazine.getNameFoID(mag_id,con)+"\"</H1></center>");
            rel_id = request.getParameter("rel_id"); if(rel_id==null)rel_id = release.getFirstID(mag_id);
            if(Mode.equals("upd")){
                sID = request.getParameter("rel_id");
                sName = request.getParameter("mName");
                sComm = request.getParameter("mComm");
                sImgName = request.getParameter("mImgName");
                if(sID!=null && sName!=null && sComm!=null && sImgName!=null)
                    release.upd(sID,sName,sComm,sImgName);
            }
        %>
        <table width="75%">
            <tr>
                <td valign="top" ><br>
                    <%
                    out.print("<a href=\"add_rel.jsp?mode=new&mag_id="+mag_id+
                            "\" id=\"NewEXZ\">Добавить выпуск</a><br><br>");
                    out.print("<a href=\"del_rel.jsp?rel_id="+rel_id+
                            "\" id=\"NewEXZ\">Удалить выпуск</a><br><br>");
                    if(!mag_id.equals("-1")){
                        list = release.getLincs(mag_id,con); it = list.iterator();
                        while(it.hasNext())out.print("<a href=\""+it.next()+"\">"+it.next()+"</a><br><br>");
                }
                %>
                </td>
                <td valign="top">
                <%
                    if(!rel_id.equals("-1")){
                        list = release.getFoID(rel_id,con); it = list.iterator();
                        while(it.hasNext()){
                        sID = it.next();
                        sName = it.next();
                        sComm = it.next();
                        sMagID = it.next();
                        sDate = it.next();
                        sImgName = it.next();
                        out.print("<form action=\"release.jsp\">");
                        out.print("<input type=\"hidden\" name=\"mode\" value=\"upd\">");
                        out.print("<input type=\"hidden\" name=\"mag_id\" value=\""+mag_id+"\">");
                        out.print("<input type=\"hidden\" name=\"rel_id\" value=\""+sID+"\">");
                        out.print("<table style=\"width:100%\">"); //
                        out.print("<tr><td>Название:</td><td>");
                        out.print("<input type=\"text\" style=\"width:100%\" name=\"mName\" value=\""+sName+"\"></td></tr>");
                        out.print("<tr><td>Добавлен:</td><td>");
                        out.print("<input type=\"text\" style=\"width:100%\" name=\"mDate\" value=\""+sDate+"\" readonly></td></tr>");
                        out.print("<tr><td>Обложка</td><td>");
                        out.print("<input type=\"text\" style=\"width:100%\" name=\"mImgName\" value=\""+sImgName+"\"></td></tr>");
                        out.print("<tr><td>Комментарий:</td><td>");
                        out.print("<textarea name=\"mComm\">"+sComm+"</textarea></td></tr>");
                        out.print("<td colspan=\"2\"><input type=\"submit\" value=\"Изменить\"></input></td>");
                        out.print("</table>");
                        out.print("</form>");}
                    }
                    misc.closeCon(con);
                %>
                </td>
            </tr>
        </table>
        <br><a href="index.jsp">На главную</a>
    </center>
    </body>
</html>
