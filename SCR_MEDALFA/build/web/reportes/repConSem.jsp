<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DateFormat df1 = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<%
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-Disposition", "attachment;filename=\"Rep_ConSem_"+request.getParameter("hora_ini")+"-"+request.getParameter("hora_fin")+".xls\"");
%>
<%
    ConectionDB con = new ConectionDB();
    HttpSession sesion = request.getSession();
    String id_usu = "";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        //response.sendRedirect("index.jsp");
    }

    String fecha1 = "", fecha2 = "";

    try {
        fecha1 = df2.format(df1.parse(request.getParameter("hora_ini")));
        fecha2 = df2.format(df1.parse(request.getParameter("hora_fin")));
    } catch (Exception e) {

    }

    if (fecha1.equals("")) {

        try {
            con.conectar();
            ResultSet rset = con.consulta("select min(fecha_hora) from receta_resportes");
            con.cierraConexion();
        } catch (Exception e) {

        }

        fecha1 = df2.format((new Date()));
        fecha2 = df2.format((new Date()));
    }

    System.out.println(fecha1);
    System.out.println(fecha2);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <title>Sistema de Captura de Receta</title>
    </head>
    <body>
        <div class="container-fluid">
            <div class="container">
                <table class="table table-bordered table-striped">
                    <tr>
                        <td>Clave</td>
                        <td>Descripción</td>
                        <td>Cantidad</td>
                    </tr>
                    <%
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select cla_pro, des_pro, cantidad from receta_reportes where fecha_hora between '" + fecha1 + " 00:00:01' and '" + fecha2 + " 23:59:59' and cantidad != 0 ;");
                            while (rset.next()) {
                    %>
                    <tr>
                        <td><%=rset.getString(1)%></td>
                        <td><%=rset.getString(2)%></td>
                        <td><%=rset.getString(3)%></td>
                    </tr>
                    <%                            }
                            con.cierraConexion();
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }
                    %>
                    <%
                        try {
                            con.conectar();
                            ResultSet rset = con.consulta("select sum(cantidad) from receta_reportes where fecha_hora between '" + fecha1 + " 00:00:01' and '" + fecha2 + " 23:59:59' and cantidad != 0 ;");
                            while (rset.next()) {
                    %>
                    <tr>
                        <td colspan="2" class="text-right"><b>Totales</b></td>
                        <td><b><%=rset.getString(1)%><b></td>
                    </tr>
                    <%                            }
                            con.cierraConexion();
                        } catch (Exception e) {
                            System.out.println(e.getMessage());
                        }
                    %>
                </table>
            </div>
        </div>

    </body>
</html>

