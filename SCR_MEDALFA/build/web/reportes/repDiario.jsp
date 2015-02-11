<%-- 
    Document   : Reporte
    Created on : 26/12/2012, 09:05:24 AM
    Author     : Unknown
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<% /*Parametros para realizar la conexión*/

    HttpSession sesion = request.getSession();
    ConectionDB con = new ConectionDB();

    int sumTotal = 0, pendSur = 0, cajAmp = 0;

    /*parameters.put("hora_ini", df2.format(df3.parse(request.getParameter("hora_ini")))+" 00:00:01");
     parameters.put("hora_fin", df2.format(df3.parse(request.getParameter("hora_fin")))+" 23:59:59");
     parameters.put("id_origen", request.getParameter("id_origen"));
     parameters.put("unidad", request.getParameter("unidad"));
     parameters.put("id_tip", request.getParameter("id_tip"));*/
    String origen = "";
    try {
        if (request.getParameter("id_origen").equals("1")) {
            origen = "SSD";
        } else if (request.getParameter("id_origen").equals("2")) {
            origen = "SORIANA";
        }
    } catch (Exception e) {
    }

%>
<html>
    <head>
        <script language="javascript" src="list02.js"></script>
        <style type="text/css">
            .letra{
                font-size: 7px;
            }
        </style>
    </head>
    <body>
        <%            try {

        %>
        <div style="text-align: center; width: 320px;" class="letra">
            GOBIERNO DEL ESTADO DE DURANGO <br/>
            SECRETARIA DE SALUD <br/>
            TIENDAS SORIANA S.A DE C.V <br/>
            REPORTE DETALLADO DE CONSUMO POR RECETA  <br/>
            DE LA UNIDAD: <%=request.getParameter("unidad")%> <br/>
            PERIODO: <%=df2.format(df3.parse(request.getParameter("hora_ini")))%> al <%=df2.format(df3.parse(request.getParameter("hora_fin")))%>  <br/>
            CONSULTA EXTERNA <br/>
            ORIGEN: <%=origen%><br/>
        </div>
        <%} catch (Exception e) {

            }
        %>
        <div class="letra"><a href="../farmacia/repDiarioFarmacia.jsp">Regresar</a></div>
        <%
            try {
                if (request.getParameter("id_tip").equals("1")) {
                    /*
                     Para origen 1
                     */
                    try {
        %>
        <table border="1" width="320px" class="letra">
            <tr>
                <td>Fecha</td>
                <td>Folio</td>
                <td>Nombre del Médico</td>
                <td>Paciente</td>
                <td>Clave Articulo</td>
                <td>Descripción</td>
                <td>Cant Sol</td>
                <td>Cant Sur</td>
                <td>Amp</td>
                <td>Cajas</td>
            </tr>
            <%
                con.conectar();
                ResultSet rset = con.consulta("select * from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                while (rset.next()) {

            %>
            <tr>
                <td><%=df3.format(df.parse(rset.getString("fecha_hora")))%></td>
                <td><%=rset.getString("fol_rec")%></td>
                <td><%=rset.getString("medico")%></td>
                <td><%=rset.getString("nom_com")%></td>
                <td><%=rset.getString("cla_pro")%></td>
                <td><%=rset.getString("des_pro")%></td>
                <td><%=rset.getString("can_sol")%></td>
                <td><%=rset.getString("cant_sur")%></td>
                <%

                    String amp = "-";
                    ResultSet rset2 = con.consulta("select cant from pasti_ampu where clave = '" + rset.getString("cla_pro") + "' ");
                    while (rset2.next()) {
                        amp = rset2.getString("cant");
                    }
                %>
                <td><%=amp%></td>
                <%
                    int cajas = 0;
                    try {
                        cajas = Integer.parseInt(rset.getString("cant_sur")) / Integer.parseInt(amp);
                        pendSur = pendSur + (Integer.parseInt(rset.getString("cant_sur")) % Integer.parseInt(amp));
                        cajAmp = cajAmp + cajas;
                        /*if (cajas == 0) {
                         pendSur = pendSur + Integer.parseInt(rset.getString("cant_sur"));
                         }*/
                    } catch (Exception e) {
                        cajas = Integer.parseInt(rset.getString("cant_sur"));
                    }
                    sumTotal += cajas;
                %>
                <td><%=cajas%></td>
            </tr>

            <%                }
                    con.cierraConexion();
                } catch (Exception e) {
                }
            %>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>Totales</td>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select sum(can_sol) from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                        while (rset.next()) {
                %>
                <td><%=rset.getString(1)%></td>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select sum(cant_sur) from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                        while (rset.next()) {
                %>
                <td><%=rset.getString(1)%></td>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <td></td>
                <td></td>
            </tr>   
            <tr>
                <td></td>
                <td colspan="3">Total de Cajas</td> 
                <td><%=sumTotal%></td>
                <td colspan="3">Pend. por Cobrar</td>
                <td><%=pendSur%></td>
                <td></td>
            </tr>  
            <tr>
                <td></td>
                <td colspan="3">Total de Recetas</td> 
                <%
                    try {
                        int totalReceta = 0;
                        con.conectar();
                        ResultSet rset = con.consulta("select fol_rec from receta_reportes group by fol_rec");
                        while (rset.next()) {
                            totalReceta++;
                        }
                %>
                <td> <%=totalReceta%></td>
                <%
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <td colspan="3">Cajas por Ampuleo</td>
                <td><%=cajAmp%></td>
                <td></td>
            </tr>
        </table>

        <%
            }
            if (request.getParameter("id_tip").equals("2")) {

                /*
                 Para origen 2
                 */
                try {
        %>
        <table border="1" width="320px" class="letra">
            <tr>
                <td>Servicio</td>
                <td>Clave del Artículo</td>
                <td>Descripción</td>
                <td>Total Piezas</td>
                <td>Presentación</td>
                <td>Total a Cobrar</td>
                <td>Piezas próximas a cobrar</td>
            </tr>
            <%
                con.conectar();
                ResultSet rset = con.consulta("select * from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                while (rset.next()) {

            %>
            <tr>
                <td><%=df3.format(df.parse(rset.getString("fecha_hora")))%></td>
                <td><%=rset.getString("fol_rec")%></td>
                <td><%=rset.getString("medico")%></td>
                <td><%=rset.getString("nom_com")%></td>
                <td><%=rset.getString("cla_pro")%></td>
                <td><%=rset.getString("des_pro")%></td>
                <td><%=rset.getString("can_sol")%></td>
                <td><%=rset.getString("cant_sur")%></td>
                <%

                    String amp = "-";
                    ResultSet rset2 = con.consulta("select cant from pasti_ampu where clave = '" + rset.getString("cla_pro") + "' ");
                    while (rset2.next()) {
                        amp = rset2.getString("cant");
                    }
                %>
                <td><%=amp%></td>
                <%
                    int cajas = 0;
                    try {
                        cajas = Integer.parseInt(rset.getString("cant_sur")) / Integer.parseInt(amp);
                        pendSur = pendSur + (Integer.parseInt(rset.getString("cant_sur")) % Integer.parseInt(amp));
                        cajAmp = cajAmp + cajas;
                        /*if (cajas == 0) {
                         pendSur = pendSur + Integer.parseInt(rset.getString("cant_sur"));
                         }*/
                    } catch (Exception e) {
                        cajas = Integer.parseInt(rset.getString("cant_sur"));
                    }
                    sumTotal += cajas;
                %>
                <td><%=cajas%></td>
            </tr>

            <%                }
                    con.cierraConexion();
                } catch (Exception e) {
                }
            %>
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>Totales</td>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select sum(can_sol) from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                        while (rset.next()) {
                %>
                <td><%=rset.getString(1)%></td>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <%
                    try {
                        con.conectar();
                        ResultSet rset = con.consulta("select sum(cant_sur) from receta_reportes where des_uni = '" + request.getParameter("unidad") + "' and id_tip = '" + request.getParameter("id_tip") + "' and fecha_hora between '" + df2.format(df3.parse(request.getParameter("hora_ini"))) + " 00:00:01' and '" + df2.format(df3.parse(request.getParameter("hora_fin"))) + " 23:59:59' ");
                        while (rset.next()) {
                %>
                <td><%=rset.getString(1)%></td>
                <%
                        }
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <td></td>
                <td></td>
            </tr>   
            <tr>
                <td></td>
                <td colspan="3">Total de Cajas</td> 
                <td><%=sumTotal%></td>
                <td colspan="3">Pend. por Cobrar</td>
                <td><%=pendSur%></td>
                <td></td>
            </tr>  
            <tr>
                <td></td>
                <td colspan="3">Total de Recetas</td> 
                <%
                    try {
                        int totalReceta = 0;
                        con.conectar();
                        ResultSet rset = con.consulta("select fol_rec from receta_reportes group by fol_rec");
                        while (rset.next()) {
                            totalReceta++;
                        }
                %>
                <td> <%=totalReceta%></td>
                <%
                        con.cierraConexion();
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                %>
                <td colspan="3">Cajas por Ampuleo</td>
                <td><%=cajAmp%></td>
                <td></td>
            </tr>
        </table>

        <%

                }

            } catch (Exception e) {

            }
        %>

    </body>
</html>
