<%-- 
    Document   : alta_pacientes
    Created on : 10-mar-2014, 9:14:09
    Author     : Americo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="../../css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="../../css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="../../css/topPadding.css" rel="stylesheet">
        <link href="../../css/datepicker3.css" rel="stylesheet">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>JSP Page</title>
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
                <div class="row">
                    <div class="col-lg-10">
                        <h3>Alta de Médico</h3>
                    </div>
                    <div class="col-lg-2">
                        <!--a class="btn btn-block btn-danger" href="pacientes.jsp">Regresar</a-->
                    </div>
                </div>
                <div class="panel panel-default">
                    <form class="form-horizontal" role="form" name="formulario_pacientes" id="formulario_pacientes" method="get" action="../../Medicos">
                        <div class="panel-body">                            
                            <div class="row">
                                <label for="ape_pat" class="col-sm-2 control-label">Apellido Paterno</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="ape_pat" name="ape_pat" placeholder="" onkeyup="upperCase(this.id)"  value=""/>
                                </div>
                                <label for="ape_mat" class="col-sm-2 control-label">Apellido Materno</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="ape_mat" name="ape_mat" placeholder="" onkeyup="upperCase(this.id)" value=""/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="nombre" class="col-sm-2 control-label">Nombre(s)</label>
                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="" onkeyup="upperCase(this.id)" value=""/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="fec_nac" class="col-sm-2 control-label">Cédula</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="cedula" name="cedula" placeholder="" onkeyup="upperCase(this.id)" value=""/>
                                </div>
                                <label for="sexo" class="col-sm-1 control-label">R.F.C.</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="rfc" name="rfc" placeholder="" onkeyup="upperCase(this.id)" value=""/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="fec_nac" class="col-sm-2 control-label">Usuario</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="usuario" name="usuario" placeholder="" value=""/>
                                </div>
                                <label for="sexo" class="col-sm-1 control-label">Password</label>
                                <div class="col-sm-2">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="" value=""/>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-lg-6">
                                <button class="btn btn-block btn-primary" id="Guardar" onclick="return validaGuardar();">Guardar</button>
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
</html>
<!-- 
================================================== -->
<!-- Se coloca al final del documento para que cargue mas rapido -->
<!-- Se debe de seguir ese orden al momento de llamar los JS -->
<script src="../../js/jquery-1.9.1.js"></script>
<script src="../../js/bootstrap.js"></script>
<script src="../../js/jquery-ui-1.10.3.custom.js"></script>

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
function anade(esto) {
    if (esto.value.length > otro) {
        if (esto.value.length == 2) {
            esto.value += "/";
        }
    }
    if (esto.value.length > otro) {
        if (esto.value.length == 5) {
            esto.value += "/";
        }
    }
    if (esto.value.length < otro) {
        if (esto.value.length == 2 || esto.value.length == 5) {
            esto.value = esto.value.substring(0, esto.value.length - 1);
        }
    }
    otro = esto.value.length
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
    $('#formulario_pacientes').submit(function() {
        //alert("Ingresó");
        return false;
    });
    $('#Guardar').click(function() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{4,4}$/;
        
        var ape_pat = $('#ape_pat').val();
        var ape_mat = $('#ape_mat').val();
        var nombre = $('#nombre').val();
        var cedula = $('#cedula').val();
        var rfc = $('#rfc').val();
        
        var form = $('#formulario_pacientes');
        if (ape_pat === "" || ape_mat === "" || nombre === "" || cedula === "" || rfc === "") {
            alert("Tiene campos vacíos, verifique.");
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
                    $('#cedula').val("");
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