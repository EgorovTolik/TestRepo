<%-- 
    Document   : del_wor
    Created on : 10.05.2012, 9:47:21
    Author     : User
--%>

<%@page import="funpack.worker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Удаление работника</title>
    </head>
    <body>
        <%! String wrk_id;%><%
        wrk_id = request.getParameter("wrk_id");
        if(wrk_id!=null && !wrk_id.equals("-1")){worker.del(wrk_id); wrk_id = "yes";}
        if(wrk_id.equals("yes")){
            out.print("<center><H1>Работник удален успешно</H1><br>");
            out.print("<a href=\"worker.jsp\">Вернуться к списку работников</a></center>");
        }
        else{
            out.print("<center><H1>При удалении вознилка ошибка</H1><br>");
            out.print("<a href=\"worker.jsp\">Вернуться к списку работников</a></center>");
        }
        %>
    </body>
</html>
