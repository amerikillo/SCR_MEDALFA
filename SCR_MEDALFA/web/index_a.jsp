<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession();
    String info = "";
    try {
        info = (String) session.getAttribute("mensaje");
    } catch (Exception e) {
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Bootstrap -->
        <link href="css/bootstrap.css" rel="stylesheet" media="screen">
        <link href="css/singnin.css" rel="stylesheet" media="screen">
        <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <title>Sistema de Captura de Receta</title>
    </head>
    <body>
        <div class="container">
            <div class="text-right">
                <!--a class="btn btn-primary" href="index_admin.jsp" target="_black">Si eres Administrador da Click Aquí</a-->
            </div>
            
            <form class="form-signin" action="Login" method="GET">
                
                <div class="row">
                    <div class="col-md-3"><h2 style="color: white">Administraci&oacute;n de Usuarios</h2   > </div>
                    <div class="col-md-3"></div>
                    <div class="col-md-3"><img src="imagenes/medalfalogo2.png" width=80 heigth=80></div> 
                </div>
                <div class="panel panel-body">
                    <h3>SIALSS</h3>
                    <h4 class="form-signin-heading">Admitraci&oacute;n de Sistema</h4>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <label class="glyphicon glyphicon-user"></label>
                        </span>
                        <input type="text" name="user" id="user" class="form-control" placeholder="Introduzca Nombre de Usuario">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon">
                            <label class="glyphicon glyphicon-lock"></label>
                        </span>
                        <input type="password" name="pass" id="pass" class="form-control"  placeholder="Introduzca Contrase&ntilde;a V&aacute;lida">
                    </div>
                    <%
                        if (info!=null) {
                    %>
                    <div class="input-group">
                        <div>Datos inv&aacute;lidos, intente otra vez...</div>
                    </div>
                    <%
                        }
                    %>
                    <button class="btn btn-lg btn-primary btn-block" type="submit" name="accion" value="3">Entrar</button>
                </div>
            </form>
                    <div class="row" >
                        <div class="col-md-4"></div>
                        <div class="col-md-4"><h4 class="left"><a href="index.jsp"><font color="#FFFFFF">Regresar a Men&uacute;</font></a></h4></div>                        
                        <div class="col-md-4"></div>
                    </div>
        </div>
    </body>
</html>
<%
    sesion.invalidate();
%>