<%-- 
    Document   : add_cat
    Created on : 09.05.2012, 18:21:36
    Author     : User
--%>

<%@page import="funpack.misc"%>
<%@page import="java.sql.Connection"%>
<%@page import="funpack.category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Добавление должности</title>
    </head>
    <body>
        <center>
        <%! String Mode,pName;
Connection con = null;
%><%con = misc.openCon();%> <%
        Mode=request.getParameter("mode"); if(Mode==null)Mode="new";
        if(Mode.equals("add")){
            pName=request.getParameter("mName");//out.print("["+pName+"]");
            if(pName!=""){category.add(pName,con);Mode="exe";}
            else {out.print("<H1>Ошибка при создании записи</H1><br><H1>Повторите ввод</H1>");Mode="new";}
        }
        if(Mode.equals("new")){
            out.print("<form action=\"add_cat.jsp\">");
                out.print("<input type=\"hidden\" name=\"mode\" value=\"add\">");
                out.print("<table>");
                    out.print("<tr>");
                        out.print("<td>Название</td>");
                        out.print("<td><input type=\"text\" name=\"mName\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Название
                    out.print("<tr><td colspan=\"2\"><input type=\"submit\" value=\"Добавить\"></input></td></tr>");
                out.print("</table>");
            out.print("</form>");
            out.print("<br><a href=\"category.jsp\" >Вернуться к списку категорий</a>");
        }
        if(Mode.equals("exe")){
            out.print("<H1>Запись добавлена успешно</H1>");
            out.print("<br><a href=\"category.jsp?cat_id="+category.getLastID(con)+"\" >Вернуться к списку категорий</a>");
        }
        misc.closeCon(con);
        %>
        </center>
    </body>
</html>
