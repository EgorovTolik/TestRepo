<%-- 
    Document   : category
    Created on : 09.05.2012, 18:21:27
    Author     : User
--%>

<%@page import="funpack.misc"%>
<%@page import="java.sql.Connection"%>
<%@page import="funpack.category"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Категории</title>
    </head>
    <body>
        <center>
            <%!
            List list; Iterator<String> it;
            String Mode,cat_id,pName;
Connection con = null;
%><%con = misc.openCon();%>
            <%
            Mode = request.getParameter("mode"); if(Mode==null)Mode="new";
            cat_id = request.getParameter("cat_id");
            if(cat_id==null)cat_id = category.getFirstID(con);
            if(Mode.equals("upd")){
                pName = request.getParameter("pName");
                if(pName!=null&&cat_id!=null)category.upd(cat_id, pName, con);
                Mode="new";
            }
            if(Mode.equals("new")){
                pName = category.getNameFoID(cat_id,con);
                if(!pName.equals("-1")){
                    out.print("<form action=\"category.jsp\">");
                    out.print("Текущая должность ");
                    out.print("<input type=\"hidden\" name=\"mode\" value=\"upd\"></input>");
                    out.print("<input type=\"hidden\" name=\"cat_id\" value=\""+cat_id+"\"></input>");
                    out.print("<input type=\"text\" name=\"pName\" value=\""+pName+"\"></input>");
                    out.print("<input type=\"submit\" value=\"Изменить\"></input>");
                    out.print("</form>");
                }
                else out.print("<H1>В списке нет ни одной категории</H1>");
            }
            %>
        </center>
        <br><a href="add_cat.jsp?mode=new" id="NewEXZ">Добавить</a><br><br>
            <%
            out.print("<a href=\"del_cat.jsp?cat_id="+cat_id+"\" id=\"NewEXZ\">Удалить</a><br><br>");%>
        <a href="index.jsp">На главную</a><hr><%
            list = category.get(con); it = list.iterator();
            while(it.hasNext())out.print("<a href=\"category.jsp?cat_id="+it.next()+"\">"+it.next()+"</a><br><br>");
            misc.closeCon(con);
            %>
</html>
