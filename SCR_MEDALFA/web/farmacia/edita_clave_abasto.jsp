<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="Clases.ConectionDB2"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("hh:mm:ss"); %>

<%
    //---------------------------------------Modulo de Conexion a la BD
    ConectionDB2 con = new ConectionDB2();
    /*parametros para la conexión*/
//-----------------------------------------------------------------

    String usuario = "", but = "", clave = "", descrip = "", lote = "", cad = "", cant = "", cantent = "", ori = "", id_abasto = "", accion = "", id_ab = "", folio = "";
    String caduc = "", cat = "", desc = "";
    String id_cla = request.getParameter("id_abasto");
    try {
        but = request.getParameter("Submit");
    } catch (Exception e) {
        System.out.print("not");
    }

    if (but != null) {
        if (but.equals("Actualizar")) {
            //out.println(but);

            String lote_up = request.getParameter("Lote");
            String fecha_up = request.getParameter("Caducidad");
            String cant_up = request.getParameter("Cantidad");
            String cantent_up = request.getParameter("Cantidad2");
            String ori_up = request.getParameter("Origen");

            if ((Integer.parseInt(cantent_up)) > (Integer.parseInt(cant_up))) {
%>
<script>alert("La cantidad Entregada NO puede ser mayor a la Solicitada");</script>
<%
            } else {
                try {
                    con.conectar();
                    String qry_lee = "SELECT a.ClaPro, p.DesPro, a.ClaLot, a.FecCad, a.CanReq, a.CanEnt, a.Origen, a.Id, au.folio FROM abastos a INNER JOIN productos p ON a.ClaPro = p.ClaPro INNER JOIN abasto_unidades au ON a.IdAbasto = au.IdAbasto WHERE A.ID = '" + id_cla + "';";
                    ResultSet rset = con.consulta(qry_lee);
                    while (rset.next()) {
                        clave = rset.getString(1);
                        descrip = rset.getString(2);
                        lote = rset.getString(3);
                        cad = rset.getString(4);
                        cant = rset.getString(5);
                        cantent = rset.getString(6);
                        ori = rset.getString(7);
                        id_abasto = rset.getString(8);
                        folio = rset.getString(9);

                        con.insertar("insert into modificacion_abastos values('" + folio + "', '" + clave + "', '" + descrip + "', '" + lote_up + "', '" + fecha_up + "', '" + cant_up + "','" + cantent_up + "', '" + ori_up + "', '" + df.format(new java.util.Date()) + "', '" + df2.format(new java.util.Date()) + "', 'MODIFICACION', '0','" + lote + "','" + cad + "','" + cantent + "','" + ori + "')");

                    }
                    String qry_actualiza = "UPDATE ABASTOS SET CLALOT='" + lote_up + "', FECCAD='" + fecha_up + "', CANREQ='" + cant_up + "', CANENT='" + cantent_up + "', ORIGEN= '" + ori_up + "' WHERE ID='" + id_cla + "'";
//out.print(qry_actualiza);
                    con.insertar(qry_actualiza);
                    con.cierraConexion();
                } catch (Exception e) {

                }

            }
        }
    }

    folio = request.getParameter("folio");
    try {
        con.conectar();
        String qry_medicamento = "SELECT ABASTOS.CLAPRO, ABASTOS.CLALOT, ABASTOS.FECCAD, ABASTOS.CANREQ, ABASTOS.CANent, ABASTOS.ORIGEN, PRODUCTOS.DESPRO FROM ABASTOS, PRODUCTOS WHERE ABASTOS.CLAPRO=PRODUCTOS.CLAPRO AND ABASTOS.ID='" + id_cla + "'";
//out.print(qry_medicamento);

        ResultSet rset = con.consulta(qry_medicamento);
        while (rset.next()) {
            clave = rset.getString(1);
            lote = rset.getString(2);
            caduc = rset.getString(3);
            cat = rset.getString(4);
            cantent = rset.getString(5);
            ori = rset.getString(6);
            desc = rset.getString(7);
        }
        con.cierraConexion();
    } catch (Exception e) {

    }

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>.: Edicion de Medicamento :.</title>
        <link href="../css/bootstrap.css" rel="stylesheet" media="screen"></link>
        <link href="../css/topPadding.css" rel="stylesheet"></link>
    </head>

    <body>
        <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="main_menu.jsp">SCR</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Mod. Farmacias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="modSurteFarmacia.jsp">Surtido</a></li>
                            <li><a href="modRecetasSurtidas.jsp">Consultas</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reportes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="repDiarioFarmacia.jsp">Reporte Diario por Receta</a></li>
                            <li><a href="repMensFarmacia.jsp">Reporte Mensual por Receta</a></li>
                            <li><a href="repConsSemanal.jsp">Consumo Semanal</a></li>
                            <li><a href="repSolSur.jsp">Solicitado / Surtido</a></li>
                            <!--li><a href="#">Pendiente por Cobrar</a></li>
                            <li><a href="#">Reporte de Antibióticos</a></li>
                            <li><a href="#">Reporte Diario</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Existencias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="existencias.jsp">Existencias</a></li>
                            <li><a href="cargaAbasto.jsp">Cargar Abasto</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                </ul>
                <div class="navbar-form navbar-right">
                    <a class="btn btn-default" href="../index.jsp">Salir</a>
                </div>
            </div><!--/.nav-collapse -->
        </div>
        <div class="container">
            <div style="width:800px; margin:auto; background-color:#FFF; padding:20px">
                <table align="center">
                    <tr>
                        <td></td>
                        <td style="text-align:center">
                            <h2>Edición de Medicamento</h2>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <br/>

                <form id="form1" name="form1" method="post" action="">
                    <table width="600" border="0" align="center">
                        <tr>
                            <td width="116"><label for="Clave2">Clave</label></td>
                            <td width="474"><input type="text" name="Clave" id="Clave" value="<%=clave%>" readonly/></td>
                        </tr>
                        <tr>
                            <td>Descripcion</td>
                            <td><input name="Descripcion" type="text" id="Descripcion" size="60" value="<%=desc%>" readonly/></td>
                        </tr>
                        <tr>
                            <td>Lote</td>
                            <td><input type="text" name="Lote" id="Lote" value="<%=lote%>"/></td>
                        </tr>
                        <tr>
                            <td>Caducidad</td>
                            <td><input type="text" name="Caducidad" id="Caducidad" value="<%=caduc%>" readonly/>
                                <span class="style2"><img src="imagenes/cal.jpg" alt="Calendario" width="26" height="27"
                                                          onClick="scwShow(scwID('Caducidad'), event)" border="0"/></span></td>
                        </tr>
                        <tr>
                            <td><label for="Cantidad">Cant. Solicitada</label></td>
                            <td><input type="text" name="Cantidad" id="Cantidad" value="<%=cat%>" readonly/> Cant. Entregada<input
                                    type="text" name="Cantidad2" id="Cantidad2" value="<%=cantent%>"/></td>
                        </tr>
                        <tr>
                            <td>Origen</td>
                            <td><input type="text" name="Origen" id="Origen" value="<%=ori%>"/></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>
                                <input type="submit" name="Submit" id="Submit" value="Actualizar"
                                       onClick="return confirm('Estas Seguro de Actualizar?')"/></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><a href="abasto_web.jsp?folio=<%=folio%>&Submit=Folio">Regresar</a></td>
                        </tr>
                    </table>
                    <p>&nbsp;</p>
                </form>
                <table align="center">
                    <tr>
                        <td><img src="imagenes/nay_ima1.jpg" alt="" width="200" height="95"/></td>
                    </tr>
                </table>
            </div>
        </div>

    </body>
    <!-- 
================================================== -->
    <!-- Se coloca al final del documento para que cargue mas rapido -->
    <!-- Se debe de seguir ese orden al momento de llamar los JS -->
    <script src="../js/jquery-1.9.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jquery-ui-1.10.3.custom.js"></script>
    <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/sha1.js"></script>

</html>