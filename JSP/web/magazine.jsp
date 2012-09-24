<%-- 
    Document   : magazine
    Created on : 23.04.2012, 23:19:42
    Author     : User
Страница для отображения, удаления и редактирования записей о журналах
--%>

<%@page import="java.sql.Connection"%>
<%@page import="funpack.misc"%>
<%@page import="funpack.category"%>
<%@page import="funpack.release"%>
<%@page import="funpack.magazine"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="style.css" type="text/css"></link>
        <title>Жураналы</title>
    </head>
    <body>
        <center>
        <%!
            List list,list2; Iterator<String> it,it2;
            String Mode,sTemp,isTemp,mag_id,pName,pCPages,pCat,pComm;
Connection con = null;
%><%con = misc.openCon();%>
        <%
            Mode = request.getParameter("mode"); if(Mode==null)Mode = "show";
            mag_id = request.getParameter("mag_id"); if(mag_id==null)mag_id = magazine.getFirstID(con);
            
            if(Mode.equals("upd")){
                pName=request.getParameter("mName"); pCPages=request.getParameter("mCPages");
                pCat=request.getParameter("mCat"); pComm=request.getParameter("mComm");
                if(pName!=null && pCPages!=null && pCat!=null && pComm!=null){
                    magazine.upd(mag_id, pName, pCPages, pComm, pCat, con);
                }
            }
        %>
        <table width="75%">
            <tr>
                <td valign="top" ><br>
                    <a href="add_mag.jsp?mode=new" id="NewEXZ">Добавить журнал</a><br><br>
                    <%
                    out.print("<a href=\"del_mag.jsp?mag_id="+mag_id+"\" id=\"NewEXZ\">Удалить журнал</a><br><br>");
                    out.print("<a href=\"release.jsp?mag_id="+mag_id+"\" id=\"NewEXZ\">Показать выпуски</a><br><br>");
                    %>
                    <hr style="color:#000000" >
                    <% list = magazine.getLincs(con); it = list.iterator();
                       while(it.hasNext())out.print("<a href=\""+it.next()+"\">"+it.next()+"</a><br><br>");
                    %>
                </td>
                <td>
                    <%
                    if(!mag_id.equals("-1")){
                        list = magazine.getFoID(mag_id,con); it = list.iterator();
                        out.print("<form action=\"magazine.jsp\">");
                        out.print("<input type=\"hidden\" name=\"mode\" value=\"upd\">");
                        out.print("<input type=\"hidden\" name=\"mag_id\" value=\"");out.print(mag_id);out.print("\">");
                        out.print("<table width=\"100%\">");
                        out.print("<tr><td>Название:</td><td>"+
                                "<input type=\"text\" style=\"width:100%\" name=\"mName\" value=\""+it.next()+
                                "\" width=\"100%\"></td></tr>");
                        out.print("<tr><td>Дата создания:</td><td>"+
                                "<input type=\"text\" style=\"width:100%\" name=\"mDate\" value=\""+it.next()+
                                "\" width=\"100%\" "); out.print("readonly");
                                out.print("></td></tr>");
                        out.print("<tr><td>Выпущено номеров:</td><td>"+
                                "<input type=\"text\" style=\"width:100%\" name=\"mCount\" value=\""+it.next()+
                                "\" width=\"100%\" "); out.print("readonly");
                                out.print("></td></tr>");
                        out.print("<tr><td>Количество страниц:</td><td>"+
                                "<input type=\"text\" style=\"width:100%\" name=\"mCPages\" value=\""+it.next()+
                                "\" width=\"100%\"></td></tr>");
                        out.print("<tr><td>Категория:</td><td>");
                        isTemp = it.next(); list2 = category.get(con); it2 = list2.iterator();
                        out.print("<select type=\"combobox\" name=\"mCat\" style=\"width:100%\">");
                        out.print("<option value=\"\">Нет категории</option>");
                        while(it2.hasNext()){ sTemp = it2.next();
                            if(sTemp.equals(isTemp))out.print("<option value=\""+sTemp+"\" selected>"+it2.next()+"</option>");
                            else out.print("<option value=\""+sTemp+"\">"+it2.next()+"</option>");
                        }
                        out.print("</select></td></tr>");
                        out.print("<tr><td>Комментарий:</td><td>"+
                                "<textarea name=\"mComm\">"+it.next()+
                                "</textarea></td></tr>");
                        out.print("<tr><td colspan=\"2\">");
                        out.print("<input type=\"submit\" value=\"Изменить\"></input></td></tr>");
                        out.print("</table>");
                        out.print("</form>");
                    }
                    else {out.print("<center><H1>Список журналов пуст</H1></center");}
                    %>
                </td>
            </tr>
            <%
                /*if(!mag_id.equals("-1")){
                    out.print("<tr><td colspan=\"2\">");
                    list = release.getLincs(mag_id); it = list.iterator();
                    out.print("<center>Выпущеные релизы</center><hr><br>");
                    out.print("<a href=\"release.jsp?ModeName=0&MagID=");
                        out.print(mag_id);out.print("\" id=\"NewEXZ\">Добавить выпуск</a><br>");
                    while(it.hasNext())out.print("<br><a href=\""+it.next()+"\">"+it.next()+"</a>");
                    out.print("<br><br></td></tr>");
                }*/
            misc.closeCon(con);
            %>
        </table>
        <br><a href="index.jsp">На главную</a>
        </center>
    </body>
</html>
