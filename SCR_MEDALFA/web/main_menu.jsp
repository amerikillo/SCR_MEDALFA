<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String id_usu = "";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        response.sendRedirect("index.jsp");
    }
   
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="css/topPadding.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>Sistema de Captura de Recetas</title>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Receta Electr&oacute;nica <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="receta/receta_farmacia.jsp">Captura de Receta</a></li>
                            <li><a href="receta/reimpresion_ticket.jsp">Reimpresión Ticket</a></li>
                            
                        </ul>
                    </li>
                    
                    <%
                    } else if (((String) sesion.getAttribute("tipo")).equals("ADMON")) {
                    %>                    
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Médicos<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="admin/medicos/medico.jsp">Médicos</a></li>
                            
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Usuarios<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="admin/usuario/usuario.jsp">Usuarios</a></li>
                            
                        </ul>
                    </li>
                    <%
                        }else{
                     %>   
                     <!--a href="#rc">Receta Colectiva</a-->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">M&oacute;dulo Farmacias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="farmacia/modSurteFarmacia.jsp">Surtido Receta</a></li>
                            <li><a href="farmacia/modSurteFarmaciaP.jsp">Surtido Receta Pendientes</a></li>
                            <li><a href="farmacia/modSurteFarmaciaCol.jsp">Surtido Recetas Colectivas</a></li>
                            <li><a href="farmacia/modRecetasSurtidas.jsp">Consultas</a></li>
                            <li><a href="receta/receta_colectiva.jsp">Receta Coléctiva</a></li>
                            
                            <li><a href="receta/reimpresion_ticket.jsp">Reimpresión Ticket</a></li>
                            <li><a href="receta/reimpresion_ticket_colec.jsp">Reimpresión Ticket Colectiva</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reportes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            
                            <li><a href="farmacia/repSolSur.jsp">Solicitado / Surtido</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Existencias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="farmacia/existencias.jsp">Existencias</a></li>
                            <li><a href="farmacia/cargaAbasto.jsp">Cargar Abasto</a></li>
                           
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Pacientes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="admin/pacientes/pacientes.jsp">Pacientes</a></li>
                            
                        </ul>
                    </li>
                     
                     
                       <% 
                    }
                        } catch (Exception e) {

                        }
                    %>

                </ul>
                <div class="navbar-form navbar-right">
                    <a class="btn btn-default" href="index.jsp">Salir</a>
                </div>
            </div><!--/.nav-collapse -->
        </div>

        <div class="container-fluid">
            <div class="starter-template">
                <h1>SIALSS</h1>

                <%
                    try {
                        if (((String) sesion.getAttribute("tipo")).equals("FARMACIA")) {
                %>
                <h4>Médico</h4>
                <%
                } else if (((String) sesion.getAttribute("tipo")).equals("ADMON")){
                %>
                <h4>Admonistrador de Usuarios</h4>
                <%
                   }else{
                  %>
                <h4>Farmacia</h4>
                <%  
                }
                    } catch (Exception e) {

                    }
                %>
                <p class="lead">Sistema de Captura de Receta</p>                
            </div>
                
        </div>
                <div class="row">
                    <div class="col-md-5"></div>
                    <div class="col-md-2"><center><img src="imagenes/medalfalogo2.png" width=100 heigth=100></center></div>
                    <div class="col-md-5"></div>
                    
                </div>
    </body>
</html>


<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="js/jquery-1.9.1.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery-ui-1.10.3.custom.js"></script>