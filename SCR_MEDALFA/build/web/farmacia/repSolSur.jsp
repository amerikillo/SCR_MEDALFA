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
    ResultSet rset= null;
    String id_usu = "",f1="",f2="";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        //response.sendRedirect("index.jsp");
    }
    try{
        con.conectar();
        
        rset = con.consulta("SELECT DATE_FORMAT(MIN(fec_sur),'%d/%m/%Y') AS f1 ,DATE_FORMAT(MAX(fec_sur),'%d/%m/%Y') AS f2 FROM repsolsur");
        if(rset.next()){
            f1 = rset.getString(1);
            f2 = rset.getString(2);
        }
        if(f1 == null){
            f1="";
        }
        if(f2 == null){
            f2="";
        }
        con.cierraConexion();
    }catch(Exception e){
        e.getMessage();
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
        <title>Solicitado contra Surtido</title>
    </head>
    <body>
        <%@include file="../jspf/mainMenu.jspf"%>
        <br />
        <div class="container-fluid">
            <div class="container">
                <form class="form-horizontal" action="../reportes/repSolSur.jsp">
                   
                    <div class="row">
                        <div class="col-md-5"><h3>Reporte Solicitado Contra Surtido</h3></div>
                        <div class="col-md-1"></div>
                        <div class="col-md-6"></div>
                    </div>
                    
                    <br />
                    <div class="row">
                        <label class="control-label col-lg-1" for="hora_ini">Fecha Inicio:</label>
                        <div class="col-lg-2">
                            <input class="form-control" id="hora_ini" name="hora_ini" type="date" />
                        </div>
                        <label class="control-label col-lg-1" for="hora_fin">Fecha Fin:</label>
                        <div class="col-lg-2">
                            <input class="form-control" id="hora_fin" name="hora_fin" type="date" />
                        </div>                        
                        <div class="col-lg-1">
                        </div>
                        <div class="col-lg-2">
                            <button class="btn btn-primary btn-block" onclick="return validaReporte();">Generar Reporte</button>
                        </div>
                        <div class="col-lg-2">
                            <a class="btn btn-success btn-block" onclick="return generaExcel();" value="excel" name="excel">Generar Excel</a>
                        </div>
                    </div>
                    <br>
                    <br>
                    <br>
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-md-1"><img src="../imagenes/medalfalogo2.png" width=100 heigth=100></div>
                        <div class="col-md-6"></div>
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

                               // $("#hora_ini").datepicker({minDate: 0});
                               // $("#hora_fin").datepicker({minDate: 0});

                                function validaReporte() {
                                    //var unidad = document.getElementById("unidad").value;
                                    //var origen = document.getElementById("id_origen").value;
                                    var hora_ini = document.getElementById("hora_ini").value;
                                    var hora_fin = document.getElementById("hora_fin").value;

                                    //if (unidad === "" || origen === "" || hora_ini === "" || hora_fin === "") {
                                    if (hora_ini === "" || hora_fin === "") {
                                        alert("Seleccione todos los parametros");
                                        return false;
                                    }
                                    return true;
                                }



                                function generaExcel() {
                                    //var unidad = document.getElementById("unidad").value;
                                    //var origen = document.getElementById("id_origen").value;
                                    var hora_ini = document.getElementById("hora_ini").value;
                                    var hora_fin = document.getElementById("hora_fin").value;
                                    //if (unidad === "" || origen === "" || hora_ini === "" || hora_fin === "") {
                                    if (hora_ini === "" || hora_fin === "") {
                                        alert("Seleccione todos los parametros");
                                        return false;
                                    } else {
                                        //window.location = "../reportes/gnrRepSolSur.jsp?unidad=" + unidad + "&id_origen=" + origen + "&hora_ini=" + hora_ini + "&hora_fin=" + hora_fin + "";
                                        window.location = "../reportes/gnrRepSolSur.jsp?hora_ini=" + hora_ini + "&hora_fin=" + hora_fin + "";
                                    }

                                }
    </script>
</html>

