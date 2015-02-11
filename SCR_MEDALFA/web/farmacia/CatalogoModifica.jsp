<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>

<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DecimalFormat formatNumber = new DecimalFormat("#,###,###,###");
    ResultSet rset=null;
    ConectionDB con = new ConectionDB();
    HttpSession sesion = request.getSession();
    String id_usu = "";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        response.sendRedirect("index.jsp");
    }

    String clave="",des_pro="",tip_pro="",cos_pro="",f_status="",des_pro1="",tip_pro1="",cos_pro1="",f_status1="";
    try {
        clave = request.getParameter("clave");        
    } catch (Exception e) {
    }
    
    try {
        con.conectar();
        rset = con.consulta("select des_pro,tip_pro,cos_pro,f_status from productos where cla_pro='"+clave+"'");
        if (rset.next()){
            des_pro=rset.getString(1);
            tip_pro=rset.getString(2);
            cos_pro=rset.getString(3);
            f_status=rset.getString(4);
        }
        
        con.cierraConexion();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../css/topPadding.css" rel="stylesheet">
        <link href="../css/dataTables.bootStrap.css" rel="stylesheet">
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
                <a class="navbar-brand" href="#">SIALSS</a>
            </div>
            
        </div>

        <div class="container-fluid">
            <div class="container">
                <h3>Modifica Medicamento</h3>                
                <br />
                <div class="panel-body">                            
                            <div class="row">
                                <label for="Clave" class="col-sm-1 control-label"> Clave:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="clave" readonly name="clave" placeholder="" value="<%=clave%>"/>
                                </div>                         
                            </div>
                                <br />
                            <div class="row">
                                <label for="Clave" class="col-sm-1 control-label"> Descripción:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="descrip" name="descrip" placeholder="" value="<%=des_pro%>"/>
                                </div>   
                                <label for="Clave" class="col-sm-1 control-label"> Estatus:</label>
                                <div class="col-md-1">
                                    <input type="text" class="form-control" id="estatus" readonly name="estatus" placeholder="" value="<%=f_status%>"/>                                    
                                </div>
                                <select id="selectsts">
                                    <option id="op">--Estatus--</option>
                                    <option value="A">Activo</option>
                                    <option value="S">Suspendido</option>
                                </select>
                            </div>    
                                <br />
                            <div class="row">
                                <label for="Clave" class="col-sm-1 control-label"> Tipo Medicamento:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="tipo" readonly name="tipo" placeholder="" value="<%=tip_pro%>"/>
                                </div>
                                <select id="selectmed">
                                    <option id="op">--Tipo--</option>
                                    <option value="MEDICAMENTO">Medicamento</option>
                                    <option value="MATERIAL DE CURACION">Curación</option>
                                </select>
                                  
                            </div>
                                <br />
                            <div class="row">                                  
                                <label for="Clave" class="col-sm-1 control-label"> Costo:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="costo" name="costo" placeholder="" value="<%=cos_pro%>"/>
                                </div>   
                            </div>         
                              <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-12">
                                    <button class="btn btn-block btn-primary" id="btn_actualizar" name="btn_actualizar" onclick="return confirm('¿Esta Ud. Seguro de Actualizar?')">Actualizar</button>
                                </div>
                            </div>
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
    <script src="../js/jquery.dataTables.js"></script>
    <script src="../js/dataTables.bootstrap.js"></script>
    <script src="../js/jquery-ui-1.10.3.custom.js"></script>
    <script>
       $(document).ready(function(){
          $('#selectsts').change(function(){
              var valor = $('#selectsts').val();
              $('#estatus').val(valor);
          });
          $('#selectmed').change(function(){
              var valor = $('#selectmed').val();
              $('#tipo').val(valor);
          });
          $("#btn_actualizar").click(function(){
              var clapro = $("#clave").val();
              var despro = $("#descrip").val();
              var tippro = $("#tipo").val();
              var cospro = $("#costo").val();
              var fstatus = $("#estatus").val();
              if(despro == "" || tippro == "" || cospro == "" || fstatus == ""){
                  alert("Favor de verificar campos Vacíos");
              }else{
                  //var dir = 'jsp/consultas.jsp?clave='+clapro+'&despro='+despro+'&tipo='+tippro+'&costo='+cospro+'&status='+fstatus+''
                 window.location='CatalogoModifica1.jsp?clave='+clapro+'&despro='+despro+'&tipo='+tippro+'&costo='+cospro+'&status='+fstatus+''
              }
              
                 
          });
       });
    </script>
</html>

