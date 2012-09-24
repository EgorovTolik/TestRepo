<%-- 
    Document   : worker
    Created on : 10.05.2012, 9:46:46
    Author     : User
--%>

<%@page import="funpack.post"%>
<%@page import="funpack.worker"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Работники</title>
    </head>
    <body>
        <center>
            <%!
            List list,list2; Iterator<String> it,it2;
            String Mode,wrk_id,pName,post_id,Temp1,Temp2;
            %>
            <%
            Mode = request.getParameter("mode"); if(Mode==null)Mode="new";
            wrk_id = request.getParameter("wrk_id");
            if(wrk_id==null)wrk_id = worker.getFirstID();
            if(Mode.equals("upd")){
                wrk_id = request.getParameter("wrk_id");
                pName = request.getParameter("pName");
                post_id = request.getParameter("post_id");
                if(pName!=null && wrk_id!=null)worker.upd(wrk_id, pName, post_id);
                Mode="new";
            }
            if(Mode.equals("new")){
                if(!wrk_id.equals("-1")){
                    list = worker.getFoID(wrk_id); it = list.iterator();
                    while(it.hasNext()){
                    out.print("<form action=\"worker.jsp\">");
                    out.print("<table>");
                    out.print("<tr><td>Работник:</td><td>");
                    out.print("<input type=\"hidden\" name=\"mode\" value=\"upd\"></input>");
                    out.print("<input type=\"hidden\" name=\"wrk_id\" value=\""+it.next()+"\"></input>");
                    out.print("<input type=\"text\" name=\"pName\" value=\""+it.next()+"\"></input></td></tr>");
                    Temp1=it.next();
                    out.print("<tr><td>Должность:</td><td>");
                        out.print("<select type=\"combobox\" name=\"post_id\" style=\"width:100%\">");
                        out.print("<option value=\"\">Нет должности</option>");
                        list2 = post.get(); it2 = list2.iterator();
                        while(it2.hasNext()){Temp2=it2.next();
                            if(Temp2.equals(Temp1))out.print("<option value=\""+Temp2+"\" selected>"+it2.next()+"</option>");
                            else out.print("<option value=\""+Temp2+"\">"+it2.next()+"</option>");
                        }
                        out.print("</select>");
                        out.print("</td></tr>");        
                    out.print("<tr><td colspan=\"2\"><input type=\"submit\" value=\"Изменить\"></input></td></tr>");
                    out.print("</table>");
                    out.print("</form>");}
                }
                else out.print("<H1>В списке нет ни одного работника</H1>");
            }
            %>
        </center>
        <br><a href="add_wrk.jsp?mode=new" id="NewEXZ">Добавить</a><br><br>
            <%
            out.print("<a href=\"del_wrk.jsp?wrk_id="+wrk_id+"\" id=\"NewEXZ\">Удалить</a><br><br>");%>
        <a href="index.jsp">На главную</a><hr><%
            list = worker.get(); it = list.iterator();
            while(it.hasNext()){out.print("<a href=\"worker.jsp?wrk_id="+it.next()+"\">"+it.next()+"</a><br><br>");it.next();}
            %>
    </body>
</html>
