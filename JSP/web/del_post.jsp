<%-- 
    Document   : del_post
    Created on : 09.05.2012, 16:48:45
    Author     : User
--%>

<%@page import="funpack.post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Удаление должности</title>
    </head>
    <body>
        <%! String post_id;%><%
        post_id = request.getParameter("post_id");
        if(post_id!=null && post_id!="-1"){post.del(post_id); post_id = "yes";}
        if(post_id.equals("yes")){
            out.print("<center><H1>Должность удалена успешно</H1><br>");
            out.print("<a href=\"post.jsp\">Вернуться к списку должностей</a></center>");
        }
        else{
            out.print("<center><H1>При удалении вознилка ошибка</H1><br>");
            out.print("<a href=\"post.jsp\">Вернуться к списку должностей</a></center>");
        }
        %>
    </body>
</html>
