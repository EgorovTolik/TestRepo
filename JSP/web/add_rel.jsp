<%-- 
    Document   : add_rel
    Created on : 08.05.2012, 15:40:00
    Author     : User
--%>

<%@page import="java.sql.Connection"%>
<%@page import="funpack.misc"%>
<%@page import="funpack.magazine"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="funpack.release"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Добавление выпуска</title>
    </head>
    <body>
        <center>
        <%!
            List list; Iterator<String> it;
            String Mode,mag_id,pName,pMag,pImg,pComm;
Connection con = null;
%><%con = misc.openCon();%>
        <%
        Mode=request.getParameter("mode"); if(Mode==null)Mode="new";
        mag_id=request.getParameter("mag_id");
        if(Mode.equals("add")){
            pName=request.getParameter("mName");//out.print("["+pName+"]");
            pMag=request.getParameter("mMag");//out.print("["+pCount+"]");
            pImg=request.getParameter("mImg");//out.print("["+pCat+"]");
            pComm=request.getParameter("mComm");//out.print("["+pComm+"]");
            if(pName!="" && pMag!=""){release.add(pName, pComm, pMag, "img\\Covers\\"+pImg);Mode="exe";}
            else {out.print("<H1>Ошибка при создании записи</H1><br><H1>Повторите ввод</H1>");Mode="new";}
        }
        if(Mode.equals("new")){
            out.print("<H1>Журнал: \""+magazine.getNameFoID(mag_id,con)+"\"</H1>");
            out.print("<form action=\"add_rel.jsp\">");
                out.print("<input type=\"hidden\" name=\"mode\" value=\"add\">");
                out.print("<table>");
                    out.print("<tr>");
                        out.print("<td>Название</td>");
                        out.print("<td><input type=\"text\" name=\"mName\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Название
                    out.print("<input type=\"hidden\" name=\"mMag\" value=\""+mag_id+"\">");
                    out.print("<tr>");
                        out.print("<td>Обложка</td>");
                        out.print("<td><input type=\"file\" name=\"mImg\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Количество страниц
                    out.print("<tr>");
                        out.print("<td>Комментарий</td>");
                        out.print("<td><textarea name=\"mComm\">Комментарий</textarea></td>");
                    out.print("</tr>");//Комментарий
                    out.print("<tr><td colspan=\"2\"><input type=\"submit\" value=\"Добавить\"></input></td></tr>");
                out.print("</table>");
            out.print("</form>");
            out.print("<br><a href=\"magazine.jsp\" >Вернуться к списку журналов</a>");
        }
        if(Mode.equals("exe")){
            out.print("<H1>Запись добавлена успешно</H1>");
            out.print("<br><a href=\"magazine.jsp?id="+release.getLastID()+"\" >Вернуться к списку журналов</a>");
        }
        misc.closeCon(con);
        %>
        </center>
    </body>
</html>
