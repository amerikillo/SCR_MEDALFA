<%-- 
    Document   : adminMedicos
    Created on : 07-may-2014, 11:08:02
    Author     : Amerikillo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <!---Bootstrap--->
        <link href="../../css/bootstrap.css" rel="stylesheet" media="screen">
        <!---Bootstrap--->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administracion de Usuarios Médicos</title>
    </head>
    <body>
        <div class="container">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Administracion de Usuarios Médicos
                </div>
                <div class="panel-body">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#home" data-toggle="tab">Home</a></li>
                        <li><a href="#profile" data-toggle="tab">Profile</a></li>
                        <li><a href="#messages" data-toggle="tab">Messages</a></li>
                        <li><a href="#settings" data-toggle="tab">Settings</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="home">
                            Pagina 1
                        </div>
                        <div class="tab-pane" id="profile">
                            Pagina 2
                        </div>
                        <div class="tab-pane" id="messages">
                            Pagina 3
                        </div>
                        <div class="tab-pane" id="settings">
                            Pagina 4
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
    <script src="../../js/jquery-1.9.1.js"></script>
    <script src="../../js/bootstrap.js"></script>
    <script src="../../js/jquery-ui.js"></script>
</html>
