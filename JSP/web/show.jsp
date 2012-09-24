<%-- 
    Document   : show
    Created on : 19.03.2012, 20:29:27
    Author     : User
--%>

<%@page import="funpack.post"%>
<%@page import="funpack.worker"%>
<%@page import="funpack.release"%>
<%@page import="funpack.magazine"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css">
        <title>Просмотр записей</title>
    </head>
    <body>
        <%!List list; Iterator<String> it;%>
        <table border="1" width="100%">
            <tr><td colspan="2" align="center"><h1>Просмотр записей</h1></td></tr>
            <tr>
                <td>
                    <h2 align="center">Журналы</h2>
                    <table border="1" width="100%">
                        <tr><td>ID</td><td>NAME</td></tr>
                        <%
                        list = magazine.get();
                        it = list.iterator();
                        while (it.hasNext()) {
                            out.print("<tr>");
                            for (int i = 0; i < 2; i++) out.print("<td>"+it.next()+"</td>");
                            out.print("</tr>");
                        }
                        %>
                    </table>
                </td>
                <td>
                    <h2 align="center">Релизы</h2>
                    <table border="1" width="100%">
                        <tr><td>ID</td><td>NAME</td><td>COMM</td><td>MAGAZINE_ID</td><td>START_DATE</td><td>IMG_NAME</td></tr>
                        <%
                        list = release.get();
                        it = list.iterator();
                        while (it.hasNext()) {
                            out.print("<tr>");
                            for (int i = 0; i < 6; i++) out.print("<td>"+it.next()+"</td>");
                            out.print("</tr>");
                        }
                        %>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <h2 align="center">Работники</h2>
                    <table border="1" width="100%">
                        <tr><td>ID</td><td>NAME</td><td>POST_ID</td></tr>
                        <%
                        list = worker.get();
                        it = list.iterator();
                        while (it.hasNext()) {
                            out.print("<tr>");
                            for (int i = 0; i < 3; i++) out.print("<td>"+it.next()+"</td>");
                            out.print("</tr>");
                        }
                        %>
                    </table>
                </td>
                <td>
                    <h2 align="center">Должности</h2>
                    <table border="1" width="100%">
                        <tr><td>ID</td><td>NAME</td></tr>
                        <%
                        list = post.get();
                        it = list.iterator();
                        while (it.hasNext()) {
                            out.print("<tr>");
                            for (int i = 0; i < 2; i++) out.print("<td>"+it.next()+"</td>");
                            out.print("</tr>");
                        }
                        %>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <form action="show.jsp">
                        <table width="100%">
                            <tr>
                                <td>
                                    <select type="combobox" name="query2">
                                        <option value="SELECT * FROM RELEASE" selected>RELEASE</option>
                                        <option value="SELECT * FROM MAGAZINE">MAGAZINE</option>
                                        <option value="SELECT * FROM POST">POST</option>
                                        <option value="SELECT * FROM WORKER">WORKER</option>
                                    </select>
                                    <input type="text" name="query1"></input>
                                </td>
                            </tr>
                            <tr><td><input type="submit" value="Сделать запрос"></input></td></tr>
                        </table>
                    </form>
                </td>
            </tr>
            <%
            String QUERY1 = request.getParameter("query2");
            String QUERY2 = request.getParameter("query2");
            if(QUERY1 != null) {
                out.print("<tr><td colspan=\"2\"><table border=\"1\" width=\"100%\">");
                list = myfun.fun1.executeQuery(QUERY1);
                it = list.iterator();
                int iter = Integer.parseInt(it.next());
                while (it.hasNext()) {
                    out.print("<tr>");
                    for(int i=0;i<iter;i++) out.print("<td>"+it.next()+"</td>");
                    out.print("</tr>");
                }
                out.print("</td></tr></table>");
            } else if(QUERY2 != null) {
                out.print("<tr><td colspan=\"2\"><table border=\"1\" width=\"100%\">");
                list = myfun.fun1.executeQuery(QUERY2);
                it = list.iterator();
                int iter = Integer.parseInt(it.next());
                while (it.hasNext()) {
                    out.print("<tr>");
                    for(int i=0;i<iter;i++) out.print("<td>"+it.next()+"</td>");
                    out.print("</tr>");
                }
                out.print("</td></tr></table>");
            }
            %>  
        </table>
        <br><a href="index.jsp">На главную</a>
    </body>
</html>
