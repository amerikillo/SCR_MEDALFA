<%-- 
    Document   : alta_pacientes
    Created on : 10-mar-2014, 9:14:09
    Author     : Americo
--%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMddhhmmss"); %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%
    DecimalFormat formatter = new DecimalFormat("#,###,###");
    DecimalFormat formatter2 = new DecimalFormat("#,###,###.##");
    DecimalFormatSymbols custom = new DecimalFormatSymbols();
    ResultSet rset ;
    ConectionDB con = new ConectionDB();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../../css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="../../css/topPadding.css" rel="stylesheet">
        <link href="../../css/datepicker3.css" rel="stylesheet">
        <link href="../../css/dataTables.bootStrap.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>Usuarios</title>
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
                <a class="navbar-brand" href="../../main_menu.jsp">SIALSS</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Médicos<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../medicos/medico.jsp">Médicos</a></li>
                            
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Usuarios<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="usuario.jsp">Usuarios</a></li>                            
                        </ul>
                    </li>
                </ul>
                <div class="navbar-form navbar-right">
                    <a class="btn btn-default" href="../../index.jsp">Salir</a>
                </div>
            </div><!--/.nav-collapse -->
        </div>
        <div class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10">
                        
                        <div class="row">
                            <div class="col-md-8"><h2>Usuarios Registrados</h2></div>
                            <div class="col-md-1"></div>
                            <div class="col-md-3"><img src="../../imagenes/medalfalogo2.png" width=100 heigth=100></div>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <!--a class="btn btn-block btn-danger" href="../receta/receta_farmacia.jsp">Regresar</a-->
                    </div>
                </div>
                <br />
                <div class="panel panel-default">
                    <form class="form-horizontal" role="form" name="formulario_pacientes" id="formulario_pacientes" method="get" action="">
                        <div class="panel-body">
                            <div class="col-lg-3">
                                <a class="btn btn-block btn-primary" href="alta_usuario.jsp">Alta Usuarios</a>
                            </div>                            
                            <br />
                            <div class="panel-footer">
                                <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="datosPacientes">
                                    <thead>
                                        <tr>
                                            <td>Clave</td>
                                            <td>Nombre Completo</td>                                            
                                            <!--td>Modificación</td-->
                                        </tr>
                                    </thead>
                                    <tbody>
                                            <%
                                                try {
                                                    con.conectar();                                                   
                                                    rset = con.consulta("select id_usu,nombre from  usuarios");
                                                  
                                                    while (rset.next()) {
                                            %>
                                            <tr>
                                                <td><%=rset.getString(1)%></td>
                                                <td><%=rset.getString(2)%></td>                                                                                                                    
                                                <!--td><a class="btn btn-sm btn-success" href="editar_usuario.jsp?id=<%=rset.getString(1)%>">Modificar Usuario</a></td-->                                                                      
                                            </tr>
                                            <%
                                                    }                                                   
                                                    con.cierraConexion();
                                                } catch (Exception e) {
                                                    System.out.println(e.getMessage());
                                                }
                                            %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>

                </div>

            </div>
        </div>
    </body>
</html>
<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/bootstrap.js"></script>
<script src="../../js/jquery-ui-1.10.3.custom.js"></script>
<script src="../../js/bootstrap-datepicker.js"></script>
<script src="../../js/moment.js"></script>
<script src="../../js/jquery.dataTables.js"></script>
<script src="../../js/dataTables.bootstrap.js"></script>
<script>
        $(document).ready(function() {
            $('#datosPacientes').dataTable();
        });
</script>