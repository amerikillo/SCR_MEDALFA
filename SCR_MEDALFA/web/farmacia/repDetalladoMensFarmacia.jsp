<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

%>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df1 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../css/topPadding.css" rel="stylesheet">
        <link href="../css/datepicker3.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>Sistema de Captura de Receta</title>
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
                <a class="navbar-brand" href="../main_menu.jsp">SIALSS</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Mod. Farmacias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="modSurteFarmacia.jsp">Surtido Receta</a></li>
                            <li><a href="modSurteFarmaciaCol.jsp">Surtido Recetas Colectivas</a></li>
                            <li><a href="modRecetasSurtidas.jsp">Consultas</a></li>
                            <li><a href="../receta/receta_colectiva.jsp">Receta Coléctiva</a></li>
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
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Pacientes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/pacientes/pacientes.jsp">Pacientes</a></li>
                            <!--li><a href="pacientes/alta_pacientes.jsp">Alta de Pacientes</a></li>
                            <li><a href="pacientes/editar_paciente.jsp">Edición de Pacientes</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Médicos<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/medicos/medico.jsp">Médicos</a></li>
                            <!--li><a href="pacientes/alta_pacientes.jsp">Alta de Pacientes</a></li>
                            <li><a href="pacientes/editar_paciente.jsp">Edición de Pacientes</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Usuarios<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/usuario/usuario.jsp">Usuarios</a></li>
                            <!--li><a href="pacientes/alta_pacientes.jsp">Alta de Pacientes</a></li>
                            <li><a href="pacientes/editar_paciente.jsp">Edición de Pacientes</a></li>
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
        <br />
        <div class="container-fluid">
            <div class="container">
                <form class="form-horizontal" action="../reportes/repMensualDetallado.jsp">
                    <div class="row">
                        <h3>Reporte Detallado Mensual Farmacia</h3>
                        Tipo de Reporte: 

                        <label class="" for="tipo1">Farmacia</label>
                        <input type="radio" name="id_tip" id="tipo1" value="1" checked>

                        <!--label class="" for="tipo2">Colectivo</label>
                        <input type="radio" name="id_tip" id="tipo2" value="2" -->

                        <br/><br/>
                        <label class="control-label col-lg-1" for="unidad">Unidad</label>
                        <div class="col-lg-5">
                            <select id="unidad" class="form-control form-inline" name="unidad" id="unidad">
                                <option>-Elija una unidad-</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select cla_uni, des_uni from unidadesreceta");
                                        while (rset.next()) {
                                            out.println("<option value='" + rset.getString("des_uni") + "' >" + rset.getString("des_uni") + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {

                                    }
                                %>
                            </select>
                        </div>
                        <label class="control-label col-lg-1" for="unidad">Origen</label>
                        <div class="col-lg-2">
                            <select id="id_origen" name="id_origen" class="form-control form-inline">
                                <option value="">-Elija Origen-</option>
                                <option value="1">SSD</option>
                                <option value="2">SORIANA</option>
                            </select>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <label class="control-label col-lg-1" for="hora_ini">Inicio</label>
                        <div class="col-lg-2">
                            <input class="form-control" id="hora_ini" name="hora_ini" data-date-format="dd/mm/yyyy"  value="" readonly />
                        </div>
                        <label class="control-label col-lg-1" for="hora_fin">Fin</label>
                        <div class="col-lg-2">
                            <input class="form-control" id="hora_fin" name="hora_fin" data-date-format="dd/mm/yyyy"  value="" readonly />
                        </div>
                        <div class="col-lg-1">
                        </div>
                        <div class="col-lg-2">
                            <button class="btn btn-primary btn-block" onclick="return validaReporte();">Generar Reporte</button>
                        </div>
                    </div>

                </form>
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
    <script src="../js/bootstrap-datepicker.js"></script>
    <script>

        $("#hora_ini").datepicker({minDate: 0});
        $("#hora_fin").datepicker({minDate: 0});
        
        function validaReporte(){
            var unidad = document.getElementById("unidad").value;
            var origen = document.getElementById("id_origen").value;
            var hora_ini = document.getElementById("hora_ini").value;
            var hora_fin = document.getElementById("hora_fin").value;
            
            if(unidad===""||origen===""||hora_ini===""||hora_fin===""){
                alert("Seleccione todos los parametros");
                return false;
            }
            return true;
        }
    </script>
</html>

