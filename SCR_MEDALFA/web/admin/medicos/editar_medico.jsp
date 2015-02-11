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

String id="",cedula="",ape_pat="",ape_mat="",nom_pac="",rfc="",cedulap="",f_status="",usuario="",password="";
try {
id = request.getParameter("id");


} catch (Exception e) {
    }

try {
    con.conectar();                                                   
    rset = con.consulta("SELECT m.cedula,ape_pat,ape_mat,nom_med,rfc,cedulapro,f_status,u.user,u.pass FROM medicos m INNER JOIN usuarios u on m.cedula=u.cedula WHERE u.cedula='"+id+"'");
    if (rset.next()) {
        cedula=rset.getString(1);       
        ape_pat=rset.getString(2);
        ape_mat=rset.getString(3);
        nom_pac=rset.getString(4);
        rfc=rset.getString(5);
        cedulap=rset.getString(6);
        f_status=rset.getString(7);
        usuario = rset.getString(8);
        password = rset.getString(9);
    }                                                   
    con.cierraConexion();
} catch (Exception e) {
    System.out.println(e.getMessage());
}


System.out.println(id);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../../css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="../../css/topPadding.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>Edición Médico</title>
    </head>
    <body onload="focoInicial();">
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
                            <li><a href="medico.jsp">Médicos</a></li>
                            
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Usuarios<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../usuario/usuario.jsp">Usuarios</a></li>
                           
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
                <h3>Navegación y Edición de Médicos</h3>
                <div class="panel panel-default">
                    <form class="form-horizontal" role="form" name="formulario_pacientes" id="formulario_pacientes" method="get" action="../../ModiMedico">
                        <div class="panel-body">                                                        
                            <div class="row">
                                <label for="clave" class="col-sm-2 control-label">Clave</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="clave" name="clave" placeholder=""  value="<%=id%>" readonly=""/>
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
                                <label for="ape_pat" class="col-sm-2 control-label">Apellido Paterno</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="ape_pat" name="ape_pat" placeholder="" onkeyup="upperCase(this.id)" value="<%=ape_pat%>"/>
                                </div>
                                <label for="ape_mat" class="col-sm-2 control-label">Apellido Materno</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="ape_mat" name="ape_mat" placeholder="" onkeyup="upperCase(this.id)" value="<%=ape_mat%>"/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="nombre" class="col-sm-2 control-label">Nombre(s)</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="" onkeyup="upperCase(this.id)" value="<%=nom_pac%>"/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="cedu" class="col-sm-2 control-label">Cédula</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="cedula" name="cedula" placeholder=""  value="<%=cedulap%>"/>
                                </div>    
                                <label for="rfc" class="col-sm-2 control-label">R.F.C.</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="rfc" name="rfc" placeholder=""  value="<%=rfc%>"/>
                                </div>                                
                            </div>                           
                            <br />
                            <div class="row">
                                <label for="cedu" class="col-sm-2 control-label">Usuario</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="usuario" name="usuario" placeholder="" readonly=""  value="<%=usuario%>"/>
                                </div>    
                                <label for="rfc" class="col-sm-2 control-label">Password</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="password" name="password" placeholder=""  value="<%=password%>"/>
                                </div>                                
                            </div>                           
                            <br />
                            <div class="row">                                
                                <div class="col-lg-6">
                                <button class="btn btn-block btn-primary" id="Guardar" onclick="return validaGuardar();">Actualizar</button>
                                </div>
                                <div class="col-lg-6">
                                <button class="btn btn-block btn-success" id="Regresar" >Regresar</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <!-- 
    ================================================== -->
    <!-- Se coloca al final del documento para que cargue mas rapido -->
    <!-- Se debe de seguir ese orden al momento de llamar los JS -->
    <script src="../../js/jquery-1.9.1.js"></script>
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/jquery-ui-1.10.3.custom.js"></script>
    <script src="../../js/bootstrap-datepicker.js"></script>    
    <script>
        
       
    function tabular(e, obj)
{
    tecla = (document.all) ? e.keyCode : e.which;
    if (tecla != 13)
        return;
    frm = obj.form;
    for (i = 0; i < frm.elements.length; i++)
        if (frm.elements[i] == obj)
        {
            if (i == frm.elements.length - 1)
                i = -1;
            break
        }
    /*ACA ESTA EL CAMBIO*/
    if (frm.elements[i + 1].disabled == true)
        tabular(e, frm.elements[i + 1]);
    else
        frm.elements[i + 1].focus();
    return false;
}

otro = 0;
function LP_data() {
    var key = window.event.keyCode;//codigo de tecla. 
    if (key < 48 || key > 57) {//si no es numero 
        window.event.keyCode = 0;//anula la entrada de texto. 
    }
}


function isNumberKey(evt)
{
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function upperCase(x)
{
    var y = document.getElementById(x).value;
    document.getElementById(x).value = y.toUpperCase();
    document.getElementById("mySpan").value = y.toUpperCase();

}




$(document).ready(function() {
    $('#selectsts').change(function(){
              var valor = $('#selectsts').val();
              $('#estatus').val(valor);
          });
    $('#formulario_pacientes').submit(function() {
        //alert("Ingresó");
        return false;
    });
    $('#Guardar').click(function() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{4,4}$/;
       
        var ape_pat = $('#ape_pat').val();
        var ape_mat = $('#ape_mat').val();
        var nombre = $('#nombre').val();        
        var rfc = $('#rfc').val();
        var estatus = $('#estatus').val();
        var password = $('#password').val();
        var form = $('#formulario_pacientes');
        if (ape_pat === "" || ape_mat === "" || nombre === "" || rfc === "" || password==="") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
        if(estatus == "--Estatus--"){
            alert("Favor verifique el ESTATUS del Paciente");
            return false;
        }
        
       $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function(data) {
                devuelveFolio(data);
            },
            error: function() {
                alert("Ha ocurrido un error");
            }
        });

        function devuelveFolio(data) {
            var json = JSON.parse(data);
            for (var i = 0; i < json.length; i++) {
                var mensaje = json[i].mensaje;                                                    
                var ban = json[i].ban;

                if (ban == 1){                    
                    $('#ape_pat').val("");
                    $('#ape_mat').val("");
                    $('#nombre').val("");                    
                    $('#rfc').val("");
                    
                    self.location='medico.jsp';
                }
                alert(mensaje);
                
            }
        }


    });
    $('#Regresar').click(function() {
        self.location='medico.jsp';
    });

});

    
    </script>
</html>