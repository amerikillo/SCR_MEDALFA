<%-- 
    Document   : reimpresion_ticket
    Created on : 12/02/2015, 08:08:09 AM
    Author     : linux9
--%>

<%@page import="java.util.Date"%>
<%@page import="Clases.ConectionDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    ConectionDB con = new ConectionDB();
    HttpSession sesion = request.getSession();
    String id_usu = "";
    String uni_ate = "", cedula = "", medico = "",ocultar="hidden",NombreUsu="";
    try {
        id_usu = (String) session.getAttribute("id_usu");
        uni_ate = (String) session.getAttribute("cla_uni");
        cedula = (String) session.getAttribute("cedula");
        medico = (String) session.getAttribute("id_usu");

        con.conectar();
        try {
            ResultSet rset = con.consulta("select us.nombre, un.des_uni from usuarios us, unidades un where us.cla_uni = un.cla_uni and us.id_usu = '" + id_usu + "' ");
            while (rset.next()) {
                medico = rset.getString(1);
                uni_ate = rset.getString(2);
            }
        } catch (Exception e) {
            e.getMessage();
        }
        con.cierraConexion();
    } catch (Exception e) {
    }
    try {
        if (id_usu == null) {
            response.sendRedirect("../index.jsp");
        }
    } catch (Exception e) {
    }
    String fol_rec = "", nom_pac = "";
    try {
        fol_rec = request.getParameter("folio");
        nom_pac = request.getParameter("nom_pac");
    } catch (Exception e) {

    }
    if(fol_rec==null || fol_rec=="0")
        fol_rec="";
    else
        ocultar="";
    if(nom_pac==null)
        nom_pac="";
    try {
        con.conectar();
        ResultSet RsetUsu = con.consulta("SELECT nombre FROM usuarios WHERE id_usu='"+id_usu+"'");
        if(RsetUsu.next()){
            NombreUsu = RsetUsu.getString(1);
        }
        con.cierraConexion();
    }catch(Exception ex){
    }
    
    
    %>
<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); %>
<%java.text.DateFormat df1 = new java.text.SimpleDateFormat("HH:mm:ss"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy");%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="../css/topPadding.css" rel="stylesheet">
        <!--link href="../css/datepicker3.css" rel="stylesheet"-->
        <link href="../css/cupertino/jquery-ui-1.10.3.custom.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>SIALSS</title>
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
                    <%
                        try {
                            if (((String) sesion.getAttribute("tipo")).equals("FARMACIA")) {
                    %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Receta Electronica <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="receta_farmacia.jsp">Captura de Receta</a></li>
                            <li><a href="receta/reimpresion_ticket.jsp">Reimpresión Ticket</a></li>
                            <!--li class="dividr"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <!--li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Agenda<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="verAgenda.jsp">Ver Agenda</a></li>
                    <!--li class="divider"></li>
                    <li><a href="#rf">Reimpresión de Comprobantes</a></li>
                </ul>
            </li-->
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

                </ul>
                <div class="navbar-form navbar-right">
                    <a class="btn btn-default" href="../index.jsp">Salir</a>
                </div>
            </div><!--/.nav-collapse -->
        </div>
        <div class="container-fluid">
            <div class="container">
                <div class="row">
                    <div class="col-md-5"><h3>Receta Electr&oacute;nica-Reimpresión de Ticket</h3> </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-3"><img src="../imagenes/medalfalogo2.png" width=60 heigth=60></div> 
                </div><br/><br>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                           <form class="form-horizontal" role="form" name="frmBuscar" id="frmBuscar" method="post" action=""> 
                            <label for="fecha" class="col-sm-2 control-label">Ingrese Folio:</label>
                            <div class="col-sm-2">
                                <input name="folio" type="text" class="form-control" id="folio" placeholder="Folio">
                            </div>
                            <div class="col-sm-2">
                                <button class="btn btn-block btn-primary" name="buscar" id="buscar">Buscar</button>
                            </div>
                           </form>
                        </div><hr/>
                        <div class="row <%=ocultar%>">
                            <div class="panel-heading">
                                <%
                                    ResultSet rset;
                                    int fol=0,id_rec=0;
                                    String paciente="",fecha="",sexo="",carnet="",num_afi="";
                                    try {
                                        con.conectar();     
                                         rset= con.consulta("SELECT DISTINCT(fol_rec), nom_com, fecha_hora, id_rec, sexo, afi, expe, medico, cedula, uni from recetas where fol_rec like '%" + fol_rec + "%' and nom_com like '%" + nom_pac + "%'  and baja=0 and id_tip='1' order by id_rec asc;");
                                         //rset= con.consulta("SELECT DISTINCT(fol_rec), nom_com, fecha_hora, id_rec from recetas where fol_rec like '%" + fol_rec + "%' and nom_com like '%" + nom_pac + "%'  and baja=0 and id_tip='1' order by id_rec asc ;");
                                        while (rset.next()) {
                                            fol=rset.getInt(1);
                                            id_rec=rset.getInt(4);
                                            paciente=rset.getString(2);
                                            fecha=rset.getString(3);
                                            uni_ate=rset.getString(10);
                                            medico=rset.getString(8);
                                            cedula=rset.getString(9);
                                            sexo=rset.getString(5);
                                            //fec_nac=rset.getString()
                                            carnet=rset.getString(7);
                                            num_afi=rset.getString(6);
                                        }
                                        
                                    }catch(Exception ex){
                                        
                                    }String msg="";
                                    if(fol==0){
                                        ocultar="hidden";msg="Folio no Encontrado";
                                    }
                                %>
                                <div class="row <%=ocultar%> " id="pnBus">
                                    <div class="panel-body">
                            <div class="row">
                                <label for="fecha" class="col-sm-2 control-label"> Unidad de Salud:</label>
                                <div class="col-md-10">
                                    <input type="text" class="form-control" id="uni_ate" readonly name="uni_ate" placeholder="" value="<%=uni_ate%>"/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="fecha" class="col-sm-1 control-label"> Médico:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="medico" readonly name="medico" placeholder="" value="<%=medico%>"/>
                                </div>
                                <label for="fecha" class="col-sm-1 control-label"> Cédula:</label>
                                <div class="col-md-2">
                                    <input type="text" class="form-control" id="cedula" readonly name="cedula" placeholder="" value="<%=cedula%>"/>
                                </div>
                            </div><hr/>
                        <div class="row">
                            <br/>
                            <label for="nom_pac" class="col-sm-1 control-label">Paciente</label>
                            <div class="col-sm-4">
                                <input name="nom_pac" type="text" class="form-control" id="nom_pac" placeholder="Paciente"  value="<%=paciente%>" readonly/>
                            </div>
                            <label for="sexo" class="col-sm-1 control-label">Sexo</label>
                            <div class="col-sm-1">
                                <input name="sexo" type="text" class="form-control" id="sexo" placeholder="Sexo"  value="<%=sexo%>" readonly/>
                            </div>
                            
                        </div>
                        <br>
                        <div class="row">
                            <label for="fol_sp" class="col-sm-1 control-label">Folio SP.</label>
                            <div class="col-sm-3">
                                <input name="fol_sp" type="text" class="form-control" id="fol_sp" placeholder="Folio SP."  value="<%=num_afi%>" readonly/>
                            </div>
                            <label for="carnet" class="col-sm-1 control-label">Expediente</label>
                            <div class="col-sm-2">
                                <input type="text" class="form-control" id="carnet" name="carnet" onkeypress="return tabular(event, this);" placeholder="Expediente"  value="<%=carnet%>" readonly=""/>
                            </div>
                        </div>
                        </div>
                                    <div class="col-sm-3">
                                        <h4 class="control-label ">Folio: <%=fol%></h4>
                                    </div>
                                    <div class="col-sm-3">
                                        <input class="hidden" value="<%=fol%>" name="fol_rec" />
                                        <input class="hidden" value="<%=id_rec%>" name="id_rec" />
                                        <%
                                            String fol_det = "";
                                            try {
                                                ResultSet rset2 = con.consulta("select fol_det from detreceta where id_rec = '" + id_rec+ "' ");
                                                while (rset2.next()) {
                                                    fol_det = fol_det + rset2.getString(1) + ",";
                                                }
                                            } catch (Exception e) {

                                            }
                                            if(fecha.equals(""))
                                                fecha="2015-01-01 00:00:00";
                                        %>

                                        <input class="hidden" name="fol_det" value="<%=fol_det%>" />
                                    </div>

                                </div>
                            </div>
                            <div class="panel-body <%=ocultar%>">
                                <div class="col-lg-4">
                                    <strong><h4>Detalle de la receta: </h4></strong>
                                    <b>Fecha y hora:</b><br /><%=df3.format(df2.parse(fecha))%>
                                    <br /><%=df1.format(df2.parse(fecha))%>
                                </div>
                                <div class="col-lg-8">
                                    <table class="table table-bordered table">
                                        <tr>

                                            <td>Clave:</td>
                                            <td>Descripcion:</td>
                                            <td>Solicitado:</td>
                                            <td>Surtido:</td>
                                            <td>Lote/Caducidad</td>
                                        </tr>
                                        <%
                                            int F_sur=0;
                                            //ResultSet rset2 = con.consulta("select cla_pro, des_pro, can_sol, cant_sur, fol_det, lote,DATE_FORMAT(caducidad,'%d/%m/%Y') AS caducidad from recetas where fol_rec = '" + rset.getString(1) + "' and cant_sur!=0 ");
                                            ResultSet rset2 = con.consulta("select cla_pro, des_pro, can_sol, cant_sur, fol_det, lote,DATE_FORMAT(caducidad,'%d/%m/%Y') AS caducidad from recetas where fol_rec = '" + fol + "'  ");
                                            while (rset2.next()) {
                                                F_sur = rset2.getInt("cant_sur");
                                        %>
                                        <tr>
                                            <td><%=rset2.getString(1)%></td>
                                            <td><%=rset2.getString(2)%></td>                                                        
                                            <td><input type="text" class="form-control" value="<%=rset2.getString(3)%>" name="sol_<%=rset2.getString(5)%>" readonly="true" /></td>
                                            <%if(F_sur>0){%>
                                            <td><input type="text" class="form-control" value="<%=rset2.getString(4)%>" name="sur_<%=rset2.getString(5)%>"readonly /></td>
                                            <%}else{%>
                                            <td><input type="text" class="form-control" value="<%=rset2.getString(4)%>" name="sur_<%=rset2.getString(5)%>" readonly="true" /></td>
                                            <%}%>
                                            <td>Lote:&nbsp;<%=rset2.getString(6)%><br />Cadu:&nbsp;<%=rset2.getString(7)%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </table>
                                    <button class="btn-block btn btn-success" type="button" onclick="window.open('../reportes/RecetaFarm.jsp?fol_rec=<%=fol%>&tipo=4&usuario=<%=NombreUsu%>', '', 'width=1200,height=800,left=50,top=50,toolbar=no');" name="accion" value="modificar" >Imprimir</button>
                                </div>
                            </div>
                                <%=msg%>
                        </div>
                    </div>
                </div>
            </div>
        </div>                             
    </body>
    <script src="../js/jquery-1.9.1.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/jquery-ui.js"></script>
</html>
