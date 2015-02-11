
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>
<%@page import="Calendario.LugaresDisp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    LugaresDisp lugar = new LugaresDisp();
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
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='../css/fullcalendar.css' rel='stylesheet' />
        <link href='../css/bootstrap.css' rel='stylesheet' />
        <link href="../css/pie-pagina.css" rel="stylesheet" media="screen">
        <link href="../css/topPadding.css" rel="stylesheet">
        <link href='../css/fullcalendar.print.css' rel='stylesheet' media='print' />
        <link href="../css/datepicker3.css" rel="stylesheet">
        <link href="../css/cupertino/jquery-ui-1.10.3.custom.css" rel="stylesheet">

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
                <a class="navbar-brand" href="../admin/main_menu.jsp">SCR</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Médicos<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/medicos/adminMedicos.jsp">Alta de Médicos</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <!--a href="#rc">Receta Colectiva</a-->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Administración de Pacientes<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/pacientes/alta_pacientes.jsp">Alta de Pacientes</a></li>
                            <li><a href="../admin/pacientes/editar_paciente.jsp">Edición de Pacientes</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                    <!--a href="#rc">Receta Colectiva</a-->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Agenda<b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="administrar.jsp">Administración de Citas</a></li>
                            <li><a href="consulta.jsp">Consulta de Citas</a></li>
                            <!--li class="divider"></li>
                            <li><a href="#rf">Reimpresión de Comprobantes</a></li-->
                        </ul>
                    </li>
                </ul>
                <div class="navbar-form navbar-right">
                    <a class="btn btn-default" href="../index_admin.jsp">Salir</a>
                </div>
            </div><!--/.nav-collapse -->
        </div>
        <div class="container-fluid">
            <div class="container" style="padding-top: 20px">
                <form class="form-horizontal" role="form">
                    <div class="form-group col-lg-12">
                        <label for="selectMedico" class="col-lg-2 control-label">Filtrar por Médico</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="selectMedico" id="selectMedico">
                                <option value="">TODOS</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select url from eventos group by url order by url");
                                        while (rset.next()) {
                                            out.println("<option value='" + rset.getString(1) + "'>" + rset.getString(1) + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {

                                    }
                                %>
                            </select>
                        </div>
                    </div>
                </form>

                <br/>
                <div class="row">
                    <div class="col-lg-8">
                        <div id='calendar'></div>
                    </div>
                    <div class="col-lg-4">
                        <form class="form-horizontal" id="formFecha" name="formFecha">
                            <h4>Espacio para cita disponible</h4>
                            <div class="row">
                                <label for="fecha" class="col-lg-2 control-label">Fecha:</label>
                                <div class="col-lg-6">
                                    <input class="form-control" id="fecha" name="fecha" data-date-format="dd/mm/yyyy"  value="<%=df.format(new Date())%>" readonly />
                                </div>
                                <div class="col-lg-4">
                                    <button class="btn btn-block btn-primary" id="btn_buscar" type="submit">Buscar</button>
                                </div>
                            </div>
                        </form>
                        <br/>
                        <table class="table table-bordered table-striped" id="tablaFechas">
                            <tr>
                                <td>Consultorio</td>
                                <td>Fecha</td>
                                <td>Hora</td>
                            </tr>

                        </table>

                    </div>
                </div>
            </div>
        </div>


        <button data-toggle="modal" href="#myModal2" id="boton" class="hidden">Instrucciones</button>
        <!-- 
                                                               Mensaje de Acerca de...
        -->
        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="z-index:2000;">
                <div class="modal-content">
                    <form method="post">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">Detalles de la Cita</h4>
                        </div>
                        <div class="modal-body">
                            Consultorio:
                            <select class="form-control" name="medico" id="medico">
                                <option value="">--Seleccione un Consultorio--</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select consultorio from consultorios group by consultorio order by id");
                                        while (rset.next()) {
                                            out.println("<option value='" + rset.getString(1) + "'>" + rset.getString(1) + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {

                                    }
                                %>

                            </select>
                            Médico:
                            <select class="form-control" name="titulo1" id="titulo1">
                                <option value="">--Seleccione un médico--</option>
                                <%
                                    try {
                                        con.conectar();
                                        ResultSet rset = con.consulta("select nom_com from medicos group by nom_com order by nom_com");
                                        while (rset.next()) {
                                            out.println("<option value='" + rset.getString(1) + "'>" + rset.getString(1) + "</option>");
                                        }
                                        con.cierraConexion();
                                    } catch (Exception e) {

                                    }
                                %>

                            </select>
                            Paciente:
                            <div class="row">
                                <div class="col-lg-12">
                                    <input type="text" class="form-control" id="titulo2" name="titulo2" placeholder="Nombre" value="">
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" class="btn btn-primary" value="Guardar" id="btn_guardar" />
                            <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_cancelar">Cerrar</button>
                            <!--button type="button" class="btn btn-primary">Guardar Info</button-->
                        </div>
                    </form>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->


        <!-- 
     fin Mensaje de Acerca de...
        --> 
    </body>
    <script src='../js/jquery-1.9.1.js'></script>
    <script src='../js/jquery-ui.js'></script>
    <script src='../js/fullcalendar.js'></script>
    <script src='../js/bootstrap.js'></script>
    <script src="../js/bootstrap-datepicker.js"></script>
    <script >

        $('#formFecha').submit(function() {
            //alert("Ingresó");
            return false;
        });

        $('#btn_buscar').click(function() {
            var fecha = $('#fecha').val();
            var dir = '../LugaresDisponibles';
            var form = $('#formFecha');
            $.ajax({
                type: form.attr('method'),
                url: dir,
                data: form.serialize(),
                success: function(data) {
                    hacerTabla(data);
                }

            });
            function hacerTabla(data) {
                var json = JSON.parse(data);
                $("#tablaFechas").empty();
                $("#tablaFechas").append(
                        $("<tr>")
                        .append($("<td>").append("Consultorio"))
                        .append($("<td>").append("Fecha"))
                        .append($("<td>").append("Hora"))
                        );
                for (var i = 0; i < json.length; i++) {
                    var consul = json[i].consul;
                    var hora = json[i].hora;
                    $("#tablaFechas").append(
                            $("<tr>")
                            .append($("<td>").append(consul))
                            .append($("<td>").append(fecha))
                            .append($("<td>").append(hora))
                            );
                }
            }
        });

        $("#fecha").datepicker({minDate: 0});
        $(function() {

            var fecha = $('#fecha').val();
            var dir = '../LugaresDisponibles';
            var form = $('#formFecha');
            $.ajax({
                type: form.attr('method'),
                url: dir,
                data: form.serialize(),
                success: function(data) {
                    hacerTabla(data);
                }

            });
            function hacerTabla(data) {
                var json = JSON.parse(data);
                $("#tablaFechas").empty();
                $("#tablaFechas").append(
                        $("<tr>")
                        .append($("<td>").append("Consultorio"))
                        .append($("<td>").append("Fecha"))
                        .append($("<td>").append("Hora"))
                        );
                for (var i = 0; i < json.length; i++) {
                    var consul = json[i].consul;
                    var hora = json[i].hora;
                    $("#tablaFechas").append(
                            $("<tr>")
                            .append($("<td>").append(consul))
                            .append($("<td>").append(fecha))
                            .append($("<td>").append(hora))
                            );
                }
            }
        });
        $(document).ready(function() {


            var date = new Date();

            var calendar = $('#calendar').fullCalendar({
                editable: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                events: "../Events?ban=1",
                // Convert the allDay from string to boolean
                eventRender: function(event, element, view) {
                    if (event.allDay === 'true') {
                        event.allDay = true;
                    } else {
                        event.allDay = false;
                    }
                },
                eventClick: function(event) {
                    var decision = confirm("¿Seguro que desea eliminarlo?");
                    if (decision) {
                        $.ajax({
                            type: "POST",
                            url: "../Events?ban=4",
                            data: "&id=" + event.id,
                            success: function(json) {
                                alert('Evento eliminado correctamente');
                            }
                        });
                        $('#calendar').fullCalendar('unselect', event.id);
                    } else {
                    }
                    location.reload();
                    return false;
                },
                selectable: true,
                selectHelper: true,
                select: function(start, end, allDay) {
                    $('#boton').click();
                    function getStart() {
                        return start;
                    }
                    function getEnd() {
                        return end;
                    }
                    $("#btn_guardar").click(function() {
                        if ($("#medico").val() === "" || $("#titulo1").val() === "" || $("#titulo2").val() === "") {
                            alert("Complete los datos");
                            return false;
                        } else {
                            var titulo1 = $("#titulo1").val();// prompt('Agendar Cita:');
                            var titulo2 = $("#titulo2").val();// prompt('Agendar Cita:');
                            var url = $("#medico").val();// prompt('Type Event url, if exits:');
                            var id = null;
                            var start = $.fullCalendar.formatDate(getStart(), "yyyy-MM-dd HH:mm:ss");
                            var end = $.fullCalendar.formatDate(getEnd(), "yyyy-MM-dd HH:mm:ss");
                            if (titulo1 && start !== "") {
                                $.ajax({
                                    url: '../Events?ban=3',
                                    data: 'titulo1=' + titulo1 + '&titulo2=' + titulo2 + '&start=' + start + '&end=' + end + '&url=' + url,
                                    type: "POST",
                                    async: false,
                                    success: function(json) {
                                        id = dameID(json);
                                        set_id(id);
                                        alert('Evento agregado correctamente');
                                    }
                                });
                                function dameID(json) {
                                    var json = JSON.parse(json);
                                    for (var i = 0; i < json.length; i++) {
                                        id = json[i].id;
                                    }
                                    return id;
                                }
                                function set_id(id_aj) {
                                    id = id_aj;
                                }
                                calendar.fullCalendar('renderEvent',
                                        {
                                            id: id,
                                            title: title,
                                            start: start,
                                            end: end,
                                            allDay: allDay
                                        },
                                true // make the event "stick"
                                        );
                            }
                            calendar.fullCalendar('unselect');
                        }
                    });

                    $("#btn_cancelar").click(function() {
                        start = "";
                        end = "";
                        allDay = "";
                        title = null;
                    });
                }
                ,
                editable: true,
                        eventDrop: function(event, delta) {
                            var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
                            var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
                            $.ajax({
                                url: '../Events?ban=2',
                                data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                                type: "POST",
                                success: function(json) {
                                    alert("Evento actualizado correctamente");
                                }
                            });
                        },
                eventResize: function(event) {
                    var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
                    var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
                    $.ajax({
                        url: '../Events?ban=2',
                        data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                        type: "POST",
                        success: function(json) {
                            alert("Evento actualizado correctamente");
                        }
                    });

                }



            });

            $('#btn_eliminar').click(function() {
                var dir = '../EliminaClave';
                var form = $('#form_eliminaInsumo');
                $.ajax({
                    type: form.attr('method'),
                    url: dir,
                    data: form.serialize(),
                    success: function(data) {
                    },
                    error: function() {
                        //alert("Ha ocurrido un error");
                    }
                });
                location.reload();
            });

            $("#selectMedico").change(function() {
                $("#calendar").empty();
                var medico = $("#selectMedico").val();
                var calendar = $('#calendar').fullCalendar({
                    editable: true,
                    header: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'month,agendaWeek,agendaDay'
                    },
                    events: "../Events?ban=5&medico=" + medico,
                    // Convert the allDay from string to boolean
                    eventRender: function(event, element, view) {
                        if (event.allDay === 'true') {
                            event.allDay = true;
                        } else {
                            event.allDay = false;
                        }
                    },
                    eventClick: function(event) {
                        var decision = confirm("¿Seguro que desea eliminarlo?");
                        if (decision) {
                            $.ajax({
                                type: "POST",
                                url: "../Events?ban=4",
                                data: "&id=" + event.id,
                                success: function(json) {
                                    alert('Evento eliminado correctamente');
                                }
                            });
                            $('#calendar').fullCalendar('removeEvents', event.id);
                        } else {
                        }
                        location.reload();
                        return false;
                    },
                    selectable: true,
                    selectHelper: true,
                    select: function(start, end, allDay) {
                        function getStart() {
                            return start;
                        }
                        function getEnd() {
                            return end;
                        }
                        $('#boton').click();

                        $("#btn_guardar").click(function(start, end, allDay) {
                            if ($("#medico").val() === "" || $("#nom_evento").val() === "") {
                                alert("Complete los datos");
                                return false;
                            } else {
                                var title = $("#nom_evento").val();// prompt('Agendar Cita:');
                                var url = $("#medico").val();// prompt('Type Event url, if exits:');
                                var id = null;
                                if (title) {
                                    var start = $.fullCalendar.formatDate(getStart(), "yyyy-MM-dd HH:mm:ss");
                                    var end = $.fullCalendar.formatDate(getEnd(), "yyyy-MM-dd HH:mm:ss");
                                    $.ajax({
                                        url: '../Events?ban=3',
                                        data: 'title=' + title + '&start=' + start + '&end=' + end + '&url=' + url,
                                        type: "POST",
                                        async: false,
                                        success: function(json) {
                                            id = dameID(json);
                                            set_id(id);
                                            alert('Evento agregado correctamente');
                                        }
                                    });
                                    function dameID(json) {
                                        var json = JSON.parse(json);
                                        for (var i = 0; i < json.length; i++) {
                                            id = json[i].id;
                                        }
                                        return id;
                                    }
                                    function set_id(id_aj) {
                                        id = id_aj;
                                    }
                                    calendar.fullCalendar('renderEvent',
                                            {
                                                id: id,
                                                title: title,
                                                start: start,
                                                end: end,
                                                allDay: allDay
                                            },
                                    true // make the event "stick"
                                            );
                                }
                                calendar.fullCalendar('unselect');
                            }
                        });

                        return false;
                    }
                    ,
                    editable: true,
                            eventDrop: function(event, delta) {
                                var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
                                var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
                                $.ajax({
                                    url: '../Events?ban=2',
                                    data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                                    type: "POST",
                                    success: function(json) {
                                        alert("Evento actualizado correctamente");
                                    }
                                });
                            },
                    eventResize: function(event) {
                        var start = $.fullCalendar.formatDate(event.start, "yyyy-MM-dd HH:mm:ss");
                        var end = $.fullCalendar.formatDate(event.end, "yyyy-MM-dd HH:mm:ss");
                        $.ajax({
                            url: '../Events?ban=2',
                            data: 'title=' + event.title + '&start=' + start + '&end=' + end + '&id=' + event.id,
                            type: "POST",
                            success: function(json) {
                                alert("Evento actualizado correctamente");
                            }
                        });

                    }
                })
            });

        });


        $(function() {
            var availableTags = [
        <%
            try {
                con.conectar();
                try {
                    ResultSet rset = con.consulta("select id_pac, nom_com from pacientes");
                    while (rset.next()) {
                        out.println("'" + rset.getString(2) + "',");
                    }
                } catch (Exception e) {

                }
                con.cierraConexion();
            } catch (Exception e) {

            }
        %>
            ];
            $("#titulo2").autocomplete({
                source: availableTags
            });
            $("#titulo2").css("zIndex","20000");
        });
    </script>
</html>