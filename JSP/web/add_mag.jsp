<%-- 
    Document   : add_mag
    Created on : 08.05.2012, 13:07:37
    Author     : User
Страница для создания записи о журнале
--%>

<%@page import="java.sql.Connection"%>
<%@page import="funpack.misc"%>
<%@page import="funpack.magazine"%>
<%@page import="funpack.category"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Добавление журнала</title>
    </head>
    <body>
        <center>
        <%!
            List list; Iterator<String> it;
            String Mode,pName,pCount,pCat,pComm;
Connection con = null;
%><%con = misc.openCon();%>
        <%
        Mode=request.getParameter("mode"); if(Mode==null)Mode="new";
        if(Mode.equals("add")){
            pName=request.getParameter("mName");//out.print("["+pName+"]");
            pCount=request.getParameter("mCount");//out.print("["+pCount+"]");
            pCat=request.getParameter("mCat");//out.print("["+pCat+"]");
            pComm=request.getParameter("mComm");//out.print("["+pComm+"]");
            if(pName!="" && pCount!="" && pCat!=""){magazine.add(pName, pCount, pComm, pCat, con);Mode="exe";}
            else {out.print("<H1>Ошибка при создании записи</H1><br><H1>Повторите ввод</H1>");Mode="new";}
        }
        if(Mode.equals("new")){
            out.print("<form action=\"add_mag.jsp\">");
                out.print("<input type=\"hidden\" name=\"mode\" value=\"add\">");
                out.print("<table>");
                    out.print("<tr>");
                        out.print("<td>Название</td>");
                        out.print("<td><input type=\"text\" name=\"mName\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Название
                    out.print("<tr>");
                        out.print("<td>Количество страниц</td>");
                        out.print("<td><input type=\"text\" name=\"mCount\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Количество страниц
                    out.print("<tr><td>Категория:</td><td>");
                        list = category.get(con); it = list.iterator();
                        out.print("<select type=\"combobox\" name=\"mCat\" style=\"width:100%\">");
                        while(it.hasNext())out.print("<option value=\""+it.next()+"\">"+it.next()+"</option>");
                        out.print("</select>");
                    out.print("</td></tr>");//Категория
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
            out.print("<br><a href=\"magazine.jsp?id="+magazine.getLastID(con)+"\" >Вернуться к списку журналов</a>");
        }
        misc.closeCon(con);
        %>
        </center>
    </body>
</html>
