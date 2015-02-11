<%-- 
    Document   : index
    Created on : 18-feb-2014, 13:00:45
    Author     : wence
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

    <title>SIALSS CEAPS</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="navbar-fixed-top.css" rel="stylesheet">
    
    <script src ="Scripts/jquery-1.6.1.min.js" type = "text/javascript" ></script>
    <script language="javascript" src="js/codeJs.js"></script>
    
    

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <!-- Fixed navbar -->
    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
            <a class="navbar-brand" href="#"><b>Bienvenidos</b></a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Inicio</a></li>
            <li><a data-toggle="modal" href="#myModal2">Acerca de...</a></li>
            <li><a data-toggle="modal" href="#myModal">Cont&aacute;ctanos</a></li>
            <!--li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">M&oacute;dulos <b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><a href="altaPac/logeoAP.jsp">Administraci&oacute;n de Pacientes</a></li>
                <li><a href="altaMed/logeoAM.jsp">Alta de M&eacute;dicos</a></li>
                <!--li><a href="#">Something else here</a></li-->
                <!--li class="divider"></li>
                <li class="dropdown-header">Recetas</li>
                <li><a href="consultorios/logeoME.jsp">Generar Receta</a></li>
                <li><a href="farmacia/logeoFA.jsp">Farmacia/Dispensar</a></li>
              </ul>
            </li-->
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <!--li><a href="../navbar/">Default</a></li>
            <li><a href="../navbar-static-top/">Static top</a></li>
            <li class="active"><a href="./">Fixed top</a></li-->
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
          <br>
          <div class="row">
            <div class="col-md-8"><h1>SIALSS CEAPS</h1></div>
            <div class="col-md-1"></div>
            <div class="col-md-3"><img src="imagenes/medalfalogo2.png" width=100 heigth=100></div>
          </div>
          
          <p>Bienvenidos al Sistema Integral de Administraci&oacute;n y Log&iacute;stica para Servicios de Salud, en el cual se tendr&aacute; el control de Pacientes, M&eacute;dicos, Creaci&oacute;n de Recetas y Dispensaci&oacute;n de Insumos en Farmacia</p>
          <p>Escoja una de las opciones que se muestran a continuaci&oacute;n:</p>
        <p>
          <!--a class="btn btn-lg btn-primary" href="altaPac/logeoAP.jsp" role="button">Administraci&oacute;n de Pacientes</a>
          <a class="btn btn-lg btn-primary" href="indexMain.jsp" role="button" target="_blank">Administraci&oacute;n de M&eacute;dicos</a-->
          <a class="btn btn-lg btn-primary" href="index_m.jsp" role="button">Generaci&oacute;n de Recetas</a>
          <a class="btn btn-lg btn-primary" href="index_f.jsp" role="button">Farmacia/Dispensaci&oacute;n</a>
          <a class="btn btn-lg btn-primary" href="index_a.jsp" role="button">Administraci&oacute;n de Usuarios</a>
           <button type="button" class="btn btn-default btn-lg">
  <span class="glyphicon glyphicon-star"></span> MEDALFA
</button>

        </p>
      </div>
      
      <!--
      Envío de Correo
      -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Ingresa tus Datos</h4>
        </div>
        <div class="modal-body">
         <form name="form_com" method="post" id="form_com">
         Nombre: <input type="text" class="form-control" autofocus placeholder="Ingrese su Nombre" name="txtf_nom" id="txtf_nom">
         Cuenta de Correo: <input type="text" class="form-control"  placeholder="Ingrese su Cuenta de Correo" name="txtf_cor" id="txtf_cor" onblur="validarEmail(this.form.txtf_cor.value);" >
         Deje su Comentario: <textarea name="txta_com" cols="10" rows="5" class="form-control" id="txta_com"></textarea>
         <div class="modal-footer">
             <div id="contenidoAjax">
              <p></p>
             </div>
          <input type="submit" class="btn btn-primary" value="Enviar" id="btn_com" onClick="return verificaCom(document.forms.form_com);">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
         
         </form>
        </div>
        
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
      <!--
      Fin envío de correo
      -->
      
      <!-- 
    Mensaje de Acerca de...
    -->
    <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Desarrollo WEB</h4>
        </div>
        <div class="modal-body">
            <br>
            <img src="imagenes/GNKL_Small.JPG" >&Aacute;rea de Desarrollo y Aplcaciones WEB<br>
        
        
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
          <!--button type="button" class="btn btn-primary">Guardar Info</button-->
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->

    
    <!-- 
     fin Mensaje de Acerca de...
    -->
      

    </div> <!-- /container -->
<!-- Functions with Ajax/Jquery by W -->
    <script>
$(document).ready(function(){
	$('#form_login').submit(function () {
				alert("Introduzca credenciales válidas");
				return false;
			}); 
	
	
	$('#form_com').submit(function () {
				//alert("huges");
				return false;
			});   
    $("#btn_com").click(function() {
				
				var nom= $('#txtf_nom').val();
				var cor= $('#txtf_cor').val();
				var com= $('#txta_com').val();
				//alert(id+" "+id);
				if(nom=='' || cor=='' || com==''){
					return false;
				}
				else{
                                        var $contenidoAjax = $('div#contenidoAjax').html('<p><img src="imagenes/3.gif" /></p>');
					var dataString = $('#form_com').serialize();
				   	//alert('Datos serializados: '+dataString);
					var dir = '/SCR/servletCorreo';
				
				$.ajax({
					url:  dir,
					type: "POST", 
					data: dataString, 
					success: function(data) {
						alert("Sus datos han sido Enviados");
                                                location.reload(); 
						//$("#form_com").fadeOut("slow");
						/*$('#txtf_nom').value='huge';
				        $('#txtf_cor').value='';
				        $('#txta_com').value='';*/
                                        },
				});
			  }
			});
	
});

</script>
    
    <!-- end Functions with Ajax/Jquery W-->
    

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
