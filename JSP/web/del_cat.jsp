<%-- 
    Document   : del_cat
    Created on : 09.05.2012, 18:21:45
    Author     : User
--%>

<%@page import="funpack.category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Удаление категории</title>
    </head>
    <body>
        <%! String cat_id;%><%
        cat_id = request.getParameter("cat_id");
        if(cat_id!=null && cat_id!=""){category.del(cat_id); cat_id = "yes";}
        if(cat_id.equals("yes")){
            out.print("<center><H1>Категория удалена успешно</H1><br>");
            out.print("<a href=\"category.jsp\">Вернуться к списку категрий</a></center>");
        }
        else{
            out.print("<center><H1>При удалении вознилка ошибка</H1><br>");
            out.print("<a href=\"category.jsp\">Вернуться к списку категрий</a></center>");
        }
        %>
    </body>
</html>
