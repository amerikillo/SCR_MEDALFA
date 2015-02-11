<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ConectionDB con = new ConectionDB();
    ConectionDB2 con2 = new ConectionDB2();
    HttpSession sesion = request.getSession();
    String id_usu = "";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        //response.sendRedirect("index.jsp");
    }

    try {
        con2.conectar();
        con.conectar();
        try {
            int id_reg = 0;
            ResultSet rset = con.consulta("select MAX(id) from pisounidosis");
            while (rset.next()) {
                id_reg = rset.getInt(1);
            }
            id_reg = id_reg + 1;
            ResultSet rset2 = con2.consulta("select * from pisounidosis where id>='" + id_reg + "'");
            while (rset2.next()) {
                con.insertar("insert into pisounidosis values ('"+rset2.getString(1)+"', '"+rset2.getString(2)+"', '"+rset2.getString(3)+"', '"+rset2.getString(4)+"', '"+rset2.getString(5)+"', '"+rset2.getString(6)+"', '"+rset2.getString(7)+"', '"+rset2.getString(8)+"', '"+rset2.getString(9)+"', '"+rset2.getString(10)+"')");
            }
        } catch (Exception e) {
        }
        con.cierraConexion();
        con2.cierraConexion();
    } catch (Exception e) {

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
                <a class="navbar-brand" href="main_menu.jsp">SCR</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <%
                        try {
                            if (((String) sesion.getAttribute("tipo")).equals("FARMACIA")) {
                    %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Receta Electronica <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="receta/receta_farmacia.jsp">Captura de Receta</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <%
                    } else {
                    %>
                    <li>
                        <a href="#rc">Receta Colectiva</a>
                    </li>
                    <%
                            }
                        } catch (Exception e) {

                        }
                    %>


                    <li><a href="#ap">Alta de Pacientes</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>

        <div class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                Búsqueda de Folios
                            </div>
                            <div class="panel-body">
                                <form>
                                    Por Folio:
                                    <input type="text" class="form-control" name="fol_rec" />
                                    Por Nombre de Derechohabiente:
                                    <input type="text" class="form-control" name="nom_pac" />
                                    <button class="btn btn-success btn-block" type="submit">Buscar</button>
                                    <button class="btn btn-warning btn-block" type="submit">Todas</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8">
                        <%
                            try {
                                con2.conectar();
                                con.conectar();
                                ResultSet rset2 = con2.consulta("select piso, clave, cama, fec_receta from pisounidosis");
                                while (rset2.next()) {
                                    int banpiso = 0;
                        %>
                        <!----------------------------------------->
                        <form>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-sm-5">
                                            <h4>PISO: <%=rset2.getString(1)%> </h4>
                                        </div>
                                        <div class="col-sm-1">
                                            <input class="hidden" value="" name="fol_rec" />
                                            <input class="hidden" value="" name="id_rec" />


                                            <input class="hidden" name="fol_det" value="" />
                                        </div>
                                        <div class="col-sm-3">
                                            <button target="_blank" class="btn btn-block btn-default" type="submit" name="accion" value="surtir" onclick="return confirm('Seguro que desea surtir esta receta?')">Surtir</button>
                                        </div>
                                        <div class="col-sm-3">
                                            <button class="btn btn-block btn-danger" type="submit" name="accion" value="cancelar" onclick="return confirm('Seguro que desea cancelar esta receta?')">Cancelar</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">

                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-sm-5">
                                                    <h4>Cama: 1 - Folio: 110 </h4>
                                                </div>
                                                <div class="col-sm-1">
                                                    <input class="hidden" value="" name="fol_rec" />
                                                    <input class="hidden" value="" name="id_rec" />


                                                    <input class="hidden" name="fol_det" value="" />
                                                </div>

                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <div class="col-lg-4">
                                                <b>Paciente:</b><br />  <br>
                                                <b>Fecha y hora:</b><br />
                                                <br />
                                            </div>
                                            <div class="col-lg-8">
                                                <table class="table table-bordered">
                                                    <tr>

                                                        <td>Clave:</td>
                                                        <td>Descripcion:</td>
                                                        <td>Solicitado:</td>
                                                        <td>Surtido:</td>
                                                        <td>Indicaciones</td>
                                                    </tr>

                                                    <tr>

                                                        <td></td>
                                                        <td></td>
                                                        <td><input type="text" class="form-control" value="" readonly="true" /></td>
                                                        <td><input type="text" class="form-control" value="" name="sur_" readonly="true" /></td>
                                                        <td></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-sm-5">
                                                    <h4>Cama: 2 - Folio: 12745 </h4>
                                                </div>
                                                <div class="col-sm-1">
                                                    <input class="hidden" value="" name="fol_rec" />
                                                    <input class="hidden" value="" name="id_rec" />


                                                    <input class="hidden" name="fol_det" value="" />
                                                </div>

                                            </div>
                                        </div>
                                        <div class="panel-body">
                                            <div class="col-lg-4">
                                                <b>Paciente:</b><br />  <br>
                                                <b>Fecha y hora:</b><br />
                                                <br />
                                            </div>
                                            <div class="col-lg-8">
                                                <table class="table table-bordered">
                                                    <tr>

                                                        <td>Clave:</td>
                                                        <td>Descripcion:</td>
                                                        <td>Solicitado:</td>
                                                        <td>Surtido:</td>
                                                        <td>Indicaciones</td>
                                                    </tr>

                                                    <tr>

                                                        <td></td>
                                                        <td></td>
                                                        <td><input type="text" class="form-control" value="" readonly="true" /></td>
                                                        <td><input type="text" class="form-control" value="" name="sur_" readonly="true" /></td>
                                                        <td></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </form>

                        <!----------------------------------------->
                        <%
                                }
                                con.cierraConexion();
                                con2.cierraConexion();
                            } catch (Exception e) {

                            }
                        %>


                    </div>
                </div>

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
</html>

