<%-- 
    Document   : del_rel
    Created on : 08.05.2012, 19:56:16
    Author     : User
--%>

<%@page import="funpack.release"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Удаление выпуска</title>
    </head>
    <body>
        <%
        String DelID = request.getParameter("rel_id");
        if(DelID!=null && DelID!=""){release.del(DelID); DelID = "yes";}
        if(DelID.equals("yes")){
            out.print("<center><H1>Выпуск удален успешно</H1><br>");
            out.print("<a href=\"magazine.jsp\">Вернуться к списку журналов</a></center>");
        }
        else{
            out.print("<center><H1>При удалении вознилка ошибка</H1><br>");
            out.print("<a href=\"magazine.jsp\">Вернуться к списку журналов</a></center>");
        }
        %>
    </body>
</html>
