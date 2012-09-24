<%-- 
    Document   : post
    Created on : 09.05.2012, 16:47:14
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="funpack.post"%>
<%@page import="funpack.post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Должности</title>
    </head>
    <body>
        <center>
            <%!
            List list; Iterator<String> it;
            String Mode,post_id,pName;
            %>
            <%
            Mode = request.getParameter("mode"); if(Mode==null)Mode="new";
            post_id = request.getParameter("post_id");
            if(post_id==null)post_id = post.getFirstID();
            if(Mode.equals("upd")){
                pName = request.getParameter("pName");
                if(pName!=null&&post_id!=null)post.upd(post_id, pName);
                Mode="new";
            }
            if(Mode.equals("new")){
                pName = post.getNameFoID(post_id);
                if(!pName.equals("-1")){
                    out.print("<form action=\"post.jsp\">");
                    out.print("Текущая должность ");
                    out.print("<input type=\"hidden\" name=\"mode\" value=\"upd\"></input>");
                    out.print("<input type=\"hidden\" name=\"post_id\" value=\""+post_id+"\"></input>");
                    out.print("<input type=\"text\" name=\"pName\" value=\""+pName+"\"></input>");
                    out.print("<input type=\"submit\" value=\"Изменить\"></input>");
                    out.print("</form>");
                }
                else out.print("<H1>В списке нет ни одной должности</H1>");
            }
            %>
        </center>
        <br><a href="add_post.jsp?mode=new" id="NewEXZ">Добавить</a><br><br>
            <%
            out.print("<a href=\"del_post.jsp?post_id="+post_id+"\" id=\"NewEXZ\">Удалить</a><br><br>");%>
        <a href="index.jsp">На главную</a><hr><%
            list = post.get(); it = list.iterator();
            while(it.hasNext())out.print("<a href=\"post.jsp?post_id="+it.next()+"\">"+it.next()+"</a><br><br>");
            %>
    </body>
</html>
