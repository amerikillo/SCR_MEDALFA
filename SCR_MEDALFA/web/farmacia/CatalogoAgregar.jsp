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

    String clave="",des_pro="",tip_pro="",cos_pro="",f_status="";
    int cont=0;
    try {
        clave = request.getParameter("clave"); 
        des_pro = request.getParameter("descrip");
        tip_pro = request.getParameter("tipo");
        cos_pro = request.getParameter("costo");
        f_status = request.getParameter("estatus");
    } catch (Exception e) {
    }
    if (clave == null){
        clave="";
    }
    if (des_pro == null){
        des_pro="";
    }
    if (tip_pro == null){
        tip_pro="";
    }
    if (cos_pro == null){
        cos_pro="";
    }
    if (f_status == null){
        f_status="";
    }
    
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
                    <form action="CatalogoAgregar.jsp" method="post">                    
                            <div class="row">
                                <label for="Clave" class="col-sm-1 control-label"> Clave:</label>
                                <div class="col-md-4">
                                    <input type="text" class="form-control" id="clave" name="clave" placeholder="" value="<%=clave%>"/>
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
                                    <button class="btn btn-block btn-primary" type="submit" onclick="return confirm('¿Esta Ud. Seguro de Actualizar?')">Actualizar</button>                                    
                                </div>
                                
                            </div>
                        </div>
                    </form>
                          <div class="col-sm-12">                                    
                                    <button class="btn btn-block btn-success" id="btn_salir" name="btn_salir">Regresar</button>
                                </div>      
                         <%
                         try{
                             con.conectar();
                             if (clave == "" || des_pro == "" || tip_pro == "" || cos_pro == "" || f_status == ""){
                                 %>
                                 <script>
                                     alert("Campos Vacíos");
                                 </script>
                                 <%
                             }else{
                             rset = con.consulta("select * from productos where cla_pro='"+clave+"'");
                             while(rset.next()){
                                 cont++;
                             }
                             if (cont > 0){
                                 %>
                                 <script>
                                     alert("Clave Existente");
                                 </script>
                                 <%
                             }else{
                                 con.actualizar("insert into productos values ('"+clave+"','"+des_pro+"','"+tip_pro+"','"+cos_pro+"','-','1','"+f_status+"')");
                             out.println("<script>window.location='CatalogoMedica.jsp'</script>");
                             }
                             
                             }
                             con.cierraConexion();
                             
                         }catch(Exception e){
                             
                         }
                         %>       
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
          $("#btn_salir").click(function(){
              window.location='CatalogoMedica.jsp'
          });
       });
    </script>
</html>

