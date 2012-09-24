<%-- 
    Document   : add_wor
    Created on : 10.05.2012, 9:47:07
    Author     : User
--%>

<%@page import="funpack.post"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="funpack.worker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Добавление работника</title>
    </head>
    <body>
        <center>
        <%!
            List list; Iterator<String> it;
            String Mode,pName,post_id;
        %> <%
        Mode=request.getParameter("mode"); if(Mode==null)Mode="new";
        if(Mode.equals("add")){
            pName=request.getParameter("mName");//out.print("["+pName+"]");
            post_id=request.getParameter("post_id");//out.print("["+pName+"]");
            if(pName!=""&&post_id!=""){worker.add(pName,post_id); Mode="exe";}
            else {out.print("<H1>Ошибка при создании записи</H1><br><H1>Повторите ввод</H1>");Mode="new";}
        }
        if(Mode.equals("new")){
            out.print("<form action=\"add_wrk.jsp\">");
                out.print("<input type=\"hidden\" name=\"mode\" value=\"add\">");
                out.print("<table>");
                    out.print("<tr>");
                        out.print("<td>Имя:</td>");
                        out.print("<td><input type=\"text\" name=\"mName\" width=\"100%\" value=\"\"></input></td>");
                    out.print("</tr>");//Название
                    out.print("<tr><td>Должность:</td><td>");
                        list = post.get(); it = list.iterator();
                        out.print("<select type=\"combobox\" name=\"post_id\" style=\"width:100%\">");
                        while(it.hasNext())out.print("<option value=\""+it.next()+"\">"+it.next()+"</option>");
                        out.print("</select>");
                    out.print("</td></tr>");//Категория
                    out.print("<tr><td colspan=\"2\"><input type=\"submit\" value=\"Добавить\"></input></td></tr>");
                out.print("</table>");
            out.print("</form>");
            out.print("<br><a href=\"worker.jsp\" >Вернуться к списку работников</a>");
        }
        if(Mode.equals("exe")){
            out.print("<H1>Запись добавлена успешно</H1>");
            out.print("<br><a href=\"worker.jsp?wrk_id="+worker.getLastID()+"\" >Вернуться к списку работников</a>");
        }
        %>
        </center>
    </body>
</html>
