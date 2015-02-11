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

String id="",num_afi="",tip_cob="",ape_pat="",ape_mat="",nom_pac="",fec_nac="",sexo="",expediente="",ini_vig="",fin_vig="",f_status="";
try {
id = request.getParameter("id");


} catch (Exception e) {
    }

try {
    con.conectar();                                                   
    rset = con.consulta("SELECT num_afi,tip_cob,ape_pat,ape_mat,nom_pac,DATE_FORMAT(fec_nac,'%d/%m/%Y') AS fec_nac,sexo,expediente,DATE_FORMAT(ini_vig,'%d/%m/%Y') AS ini_vig,DATE_FORMAT(fin_vig,'%d/%m/%Y') AS fin_vig,f_status FROM pacientes WHERE id_pac='"+id+"'");
    if (rset.next()) {
        num_afi=rset.getString(1);
        tip_cob=rset.getString(2);
        ape_pat=rset.getString(3);
        ape_mat=rset.getString(4);
        nom_pac=rset.getString(5);
        fec_nac=rset.getString(6);
        sexo=rset.getString(7);
        expediente=rset.getString(8);
        ini_vig=rset.getString(9);
        fin_vig=rset.getString(10);
        f_status=rset.getString(11);
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
        <title>Alta Paciente</title>
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
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Mod. Farmacias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../../farmacia/modSurteFarmacia.jsp">Surtido Receta</a></li>
                            <li><a href="../../farmacia/modSurteFarmaciaP.jsp">Surtido Receta Pendientes</a></li>
                            <li><a href="../../farmacia/modSurteFarmaciaCol.jsp">Surtido Recetas Colectivas</a></li>
                            <li><a href="../../farmacia/modRecetasSurtidas.jsp">Consultas</a></li>
                            <li><a href="../../receta/receta_colectiva.jsp">Receta Coléctiva</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reportes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <!--li><a href="../../farmacia/repDiarioFarmacia.jsp">Reporte Diario por Receta</a></li>
                            <li><a href="../../farmacia/repMensFarmacia.jsp">Reporte Mensual por Receta</a></li>
                            <li><a href="../../farmacia/repConsSemanal.jsp">Consumo Semanal</a></li-->
                            <li><a href="../../farmacia/repSolSur.jsp">Solicitado / Surtido</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Existencias<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../../farmacia/existencias.jsp">Existencias</a></li>
                            <li><a href="../../farmacia/cargaAbasto.jsp">Cargar Abasto</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Pacientes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="pacientes.jsp">Pacientes</a></li>
                            <!--li><a href="pacientes/alta_pacientes.jsp">Alta de Pacientes</a></li>
                            <li><a href="pacientes/editar_paciente.jsp">Edición de Pacientes</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
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
                <h3>Navegación y Edición de Pacientes</h3>
                <div class="panel panel-default">
                    <form class="form-horizontal" role="form" name="formulario_pacientes" id="formulario_pacientes" method="get" action="../../ModiPacientes">
                        <div class="panel-body">                                                        
                            <div class="row">
                                <label for="no_afi" class="col-sm-2 control-label">Número de Paciente</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="no_pac" name="no_pac" placeholder=""  value="<%=id%>" readonly=""/>
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
                                <label for="no_afi" class="col-sm-2 control-label">Número de Afiliación</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="no_afi" name="no_afi" placeholder=""  value="<%=num_afi%>"/>
                                </div>
                                <label for="tip_cob" class="col-sm-2 control-label">Tipo de Cobertura</label>
                                <div class="col-sm-1">
                                    <input type="text" class="form-control" id="afi" name="afi" placeholder=""  value="<%=tip_cob%>" readonly=""/>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control" id="select_afi" name="select_afi" onchange="numAfiPA();">
                                        <option>--Seleccione Cobertura--</option>
                                        <option value="SP">SP</option>
                                        <option value="PR">PR</option>
                                        <option value="PA">PA</option>
                                    </select>
                                </div>
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
                                <label for="fec_nac" class="col-sm-2 control-label">Fecha de Nacimiento</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" id="fec_nac" name="fec_nac" placeholder=""  value="<%=fec_nac%>"/>
                                </div>
                                <label for="sexo" class="col-sm-1 control-label">Sexo</label>
                                <div class="col-sm-1">
                                    <input type="text" class="form-control" id="sexo" name="sexo" placeholder=""  value="<%=sexo%>" readonly=""/>
                                </div>
                                <div class="col-sm-3">
                                    <select class="form-control" id="select_sexo" name="select_sexo">
                                        <option>--Seleccione Sexo--</option>
                                        <option value="H">Hombre</option>
                                        <option value="F">Mujer</option>
                                    </select>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <label for="no_exp" class="col-sm-2 control-label">Número de Expediente</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="no_exp" name="no_exp" placeholder="" onkeyup="upperCase(this.id)"  value="<%=expediente%>"/>
                                </div>                                
                            </div>
                            <br />
                            <h4>Datos de la Poliza</h4>
                            <div class="row">
                                <label for="ini_vig" class="col-sm-2 control-label">Inicio de Vigencia</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="ini_vig" name="ini_vig" placeholder=""  value="<%=ini_vig%>"/>
                                </div>
                                <label for="fin_vig" class="col-sm-2 control-label">Fin de Vigencia</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="fin_vig" name="fin_vig" placeholder=""  value="<%=fin_vig%>"/>
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
    <script src="../../js/moment.js"></script>
    <script>
    $(document).ready(function(){
         $('#selectsts').change(function(){
              var valor = $('#selectsts').val();
              $('#estatus').val(valor);
          });
       $('#select_sexo').change(function(){
           var valor = $('#select_sexo').val();
           $('#sexo').val(valor);
       }); 
       $('#select_afi').change(function(){
           var valor = $('#select_afi').val();
           $('#afi').val(valor);
       }); 
    });
    
    function numAfiPA() {
        var d = new Date();
        //alert(d);
        var now = moment();
        now.format('dddd');
        //alert(now);
        var tipo = "";
        if (document.getElementById('select_afi').value === 'PR') {
            tipo = 'PR';
        } else if (document.getElementById('select_afi').value === 'PA') {
            tipo = 'PA';
        }
        document.getElementById('no_afi').value = tipo + now.format('YYMMDDHHmmss');
        document.getElementById('no_afi').readOnly = true;
        if (document.getElementById('select_afi').value === 'SP') {
            document.getElementById('no_afi').value = "";
            document.getElementById('no_afi').readOnly = false;
        }
    }
    
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

$(function() {
    $("#ini_vig").datepicker();
    $("#fec_nac").datepicker();
    $("#fin_vig").datepicker();
});


$(document).ready(function() {
    $('#formulario_pacientes').submit(function() {
        //alert("Ingresó");
        return false;
    });
    $('#Guardar').click(function() {
        var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{4,4}$/;
        var no_afi = $('#no_afi').val();
        var tip_cob = $('#tip_cob').val();
        var ape_pat = $('#ape_pat').val();
        var ape_mat = $('#ape_mat').val();
        var nombre = $('#nombre').val();
        var fec_nac = $('#fec_nac').val();
        var sexo = $('#sexo').val();
        var no_exp = $('#no_exp').val();
        var ini_vig = $('#ini_vig').val();
        var fin_vig = $('#fin_vig').val();
        var estatus = $('#estatus').val();
        var form = $('#formulario_pacientes');
        if (no_afi === "" || tip_cob === "" || ape_pat === "" || ape_mat === "" || nombre === "" || fec_nac === "" || sexo === "" || no_exp === "" || ini_vig === "" || fin_vig === "") {
            alert("Tiene campos vacíos, verifique.");
            return false;
        }
        if(estatus == "--Estatus--"){
            alert("Favor verifique el ESTATUS del Paciente");
            return false;
        }
        var dtFechaActual = new Date();
        var f_nac = fec_nac.split('/');
        var f_n = f_nac[2] + '-' + f_nac[1] + "-" + f_nac[0]

        var i_vig = ini_vig.split('/');
        var i_v = i_vig[2] + '-' + i_vig[1] + "-" + i_vig[0]

        var f_vig = fin_vig.split('/');
        var f_v = f_vig[2] + '-' + f_vig[1] + "-" + f_vig[0]

        if (Date.parse(dtFechaActual) < Date.parse(f_n)) {
            alert("La fecha de nacimiento no puede ser mayor a la fecha actual");
            return false;
        }
        if (Date.parse(i_v) > Date.parse(f_v)) {
            alert("El inicio de la vigencia no puede ser después del fin de la vigencia");
            return false;
        }

        if ((fec_nac.match(RegExPattern)) && (fec_nac != '')) {
        } else {
            alert("Caducidad Incorrecta, verifique.");
            return false;
        }
        if ((ini_vig.match(RegExPattern)) && (ini_vig != '')) {
        } else {
            alert("Inicio de vigencia incorrecta, verifique.");
            return false;
        }
        if ((fin_vig.match(RegExPattern)) && (fin_vig != '')) {
        } else {
            alert("Fin de vigencia incorrecta, verifique.");
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
                    $('#no_afi').val("");
                    $('#tip_cob').val("");
                    $('#ape_pat').val("");
                    $('#ape_mat').val("");
                    $('#nombre').val("");
                    $('#fec_nac').val("");
                    $('#sexo').val("");
                    $('#no_exp').val("");
                    $('#ini_vig').val("");
                    $('#fin_vig').val("");
                    
                    self.location='pacientes.jsp';
                }
                alert(mensaje);
                
            }
        }


    });
    $('#Regresar').click(function() {
        self.location='pacientes.jsp';
    });

});

    
    </script>
</html>