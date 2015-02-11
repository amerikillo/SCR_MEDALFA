/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function focoInicial(){
    if (document.getElementById('encargado').value !== ""){
        document.getElementById('cla_pro').focus();
    }
}


function isNumberKey(evt, obj)
{
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode === 13 || charCode > 31 && (charCode < 48 || charCode > 57)) {
        if (charCode === 13) {
            frm = obj.form;
            for (i = 0; i < frm.elements.length; i++)
                if (frm.elements[i] === obj)
                {
                    if (i === frm.elements.length - 1)
                        i = -1;
                    break
                }
            /*ACA ESTA EL CAMBIO*/
            if (frm.elements[i + 1].disabled === true)
                tabular(e, frm.elements[i + 1]);
            else
                frm.elements[i + 1].focus();
            return false;
        }
        return false;
    }
    return true;

}

function tabular(e, obj)
{
    tecla = (document.all) ? e.keyCode : e.which;
    if (tecla !== 13)
        return;
    frm = obj.form;
    for (i = 0; i < frm.elements.length; i++)
        if (frm.elements[i] === obj)
        {
            if (i === frm.elements.length - 1)
                i = -1;
            break
        }
    /*ACA ESTA EL CAMBIO*/
    if (frm.elements[i + 1].disabled === true)
        tabular(e, frm.elements[i + 1]);
    else
        frm.elements[i + 1].focus();
    return false;
}

function calculaCajas() {
    var total = document.formulario_receta.piezas_sol.value;
    var cajas = parseInt(total) / parseInt(document.formulario_receta.amp.value);
    document.formulario_receta.can_sol.value = Math.ceil(cajas);
}

$(function() {


    $("#Caducidad").datepicker('option', {dateFormat: 'dd/mm/yy'});

    var form = $('#formulario_receta');
    $.ajax({
        type: form.attr('method'),
        url: '../MuestraInsumosReceta',
        data: form.serialize(),
        success: function(data) {
            limpiaCampos();
            hacerTabla(data);
        },
        error: function() {
            alert("Ha ocurrido un error - insumo receta");
        }
    });

    function limpiaCampos() {
        $("#cla_pro").val("");
        $("#des_pro").val("");
        $("#ori1").attr("value", "");
        $("#ori2").attr("value", "");
        $("#existencias").attr("value", "");
        $("#indica").val("");
        $("#causes").val("");
        $("#can_sol").val("");
    }

    function hacerTabla(data) {
        var json = JSON.parse(data);
        $("#tablaMedicamentos").empty();
        $("#tablaMedicamentos").append(
                $("<tr>")
                .append($("<td>").append("Clave"))
                .append($("<td>").append("Descripción"))
                .append($("<td>").append("Lote"))
                .append($("<td>").append("Caducidad"))
                .append($("<td>").append("Cant. Sol."))
                .append($("<td>").append("Cant. Sur."))
                .append($("<td>").append(""))
                );
        for (var i = 0; i < json.length; i++) {
            var cla_pro = json[i].cla_pro;
            var des_pro = json[i].des_pro;
            var lot_pro = json[i].lot_pro;
            var cad_pro = json[i].cad_pro;
            var fol_det = json[i].fol_det;
            var can_sol = json[i].can_sol;
            var cant_sur = json[i].cant_sur;
            var btn_modi = "<a class='btn btn-warning' id='btn_modi' value = '" + fol_det + "' name = 'btn_modi'  data-toggle=\'modal\'  href=\'#edita_clave_" + fol_det + "\'><span class='glyphicon glyphicon-pencil' ></span></a>";
            var btn_eliminar = "<a class='btn btn-danger' id='btn_eli' value = '" + fol_det + "' name = 'btn_eli' data-toggle=\'modal\'  href=\'#elimina_clave_" + fol_det + "\'><span class='glyphicon glyphicon-remove' ></span></a>";
            $("#tablaMedicamentos").append(
                    $("<tr>")
                    .append($("<td>").append(cla_pro))
                    .append($("<td>").append(des_pro))
                    .append($("<td>").append(lot_pro))
                    .append($("<td>").append(cad_pro))
                    .append($("<td>").append(can_sol))
                    .append($("<td>").append(cant_sur))
                    .append($("<td>").append(btn_modi).append(btn_eliminar))
                    );
        }
    }
});

$(document).ready(function() {
    $('#formulario_receta').submit(function() {
        //alert("Ingresó");
        return false;
    });

    $('#select_serv').change(function() {
        $('#encargado').focus();
    });

    $('#btn_clave').click(function() {
        var dir = '../Receta?btn_clave=1';
        var form = $('#formulario_receta');
        $.ajax({
            type: form.attr('method'),
            url: dir,
            data: form.serialize(),
            success: function(data) {
                dameProducto(data);
            },
            error: function() {
                alert("Ha ocurrido un error - clave");
            }
        });
        function dameProducto(data) {
            var json = JSON.parse(data);
            for (var i = 0; i < json.length; i++) {
                var ori1 = json[i].origen1;
                var ori2 = json[i].origen2;
                var total = json[i].total;
                var descripcion = json[i].des_pro;
                var ampuleo = json[i].amp_pro;
                var fol_rec = json[i].fol_rec;

                //$("#carnet").val(json[i].carnet);

                $("#folio").attr("value", fol_rec);
                $("#ori1").attr("value", ori1);
                $("#ori2").attr("value", ori2);
                $("#existencias").attr("value", total);
                $("#des_pro").val(descripcion);
                $("#amp").attr("value", ampuleo);
                $("#piezas_sol").focus();
                if (descripcion === null) {
                    alert('Clave fuera de Catálogo');
                    $("#cla_pro").val("");
                    $("#des_pro").val("");
                    $("#ori1").attr("value", "");
                    $("#ori2").attr("value", "");
                    $("#existencias").attr("value", "");
                    $("#indica").val("");
                    $("#causes").val("");
                    $("#can_sol").val("");
                    $("#cla_pro").focus();
                }
                if (total === null && descripcion !== null) {
                    alert('Clave sin Existencias');
                    $("#cla_pro").val("");
                    $("#des_pro").val("");
                    $("#ori1").attr("value", "");
                    $("#ori2").attr("value", "");
                    $("#existencias").attr("value", "");
                    $("#indica").val("");
                    $("#causes").val("");
                    $("#can_sol").val("");
                    $("#cla_pro").focus();
                }
            }
        }
    });


    $('#btn_descripcion').click(function() {
        var dir = '../Receta?btn_descripcion=1';
        var form = $('#formulario_receta');
        $.ajax({
            type: form.attr('method'),
            url: dir,
            data: form.serialize(),
            success: function(data) {
                dameProducto(data);
            },
            error: function() {
                alert("Ha ocurrido un error - descr");
            }
        });
        function dameProducto(data) {
            var json = JSON.parse(data);
            for (var i = 0; i < json.length; i++) {
                var ori1 = json[i].origen1;
                var ori2 = json[i].origen2;
                var total = json[i].total;
                var cla_pro = json[i].cla_pro;
                var ampuleo = json[i].amp_pro;
                var fol_rec = json[i].fol_rec;

                //$("#carnet").val(json[i].carnet);

                $("#folio").attr("value", fol_rec);
                $("#ori1").attr("value", ori1);
                $("#ori2").attr("value", ori2);
                $("#existencias").attr("value", total);
                $("#cla_pro").val(cla_pro);
                $("#amp").attr("value", ampuleo);
                $("#piezas_sol").focus();
                if (descripcion === null) {
                    alert('Clave fuera de Catálogo');
                    $("#cla_pro").val("");
                    $("#des_pro").val("");
                    $("#ori1").attr("value", "");
                    $("#ori2").attr("value", "");
                    $("#existencias").attr("value", "");
                    $("#indica").val("");
                    $("#causes").val("");
                    $("#can_sol").val("");
                    $("#cla_pro").focus();
                }
                if (total === null && descripcion !== null) {
                    alert('Clave sin Existencias');
                    $("#cla_pro").val("");
                    $("#des_pro").val("");
                    $("#ori1").attr("value", "");
                    $("#ori2").attr("value", "");
                    $("#existencias").attr("value", "");
                    $("#indica").val("");
                    $("#causes").val("");
                    $("#can_sol").val("");
                    $("#cla_pro").focus();
                }
            }
        }
    });


    $('#btn_capturar').click(function() {
        var cla_pro = $('#cla_pro').val();
        var des_pro = $('#des_pro').val();
        var dir = '../CapturaMedicamento?cedula=-';
        var form = $('#formulario_receta');
        if (cla_pro !== "" && des_pro !== "") {
            if ($('#causes').val() === "") {
                alert('Capture las causes');
                $('#causes').focus();
            } else if ($('#can_sol').val() === "") {
                alert('Capture la cantidad a entregar');
            } else {
                $.ajax({
                    type: form.attr('method'),
                    url: dir,
                    data: form.serialize(),
                    success: function(data) {
                    },
                    error: function() {
                        //alert("Ha ocurrido un error - capturar");
                    }
                });
                $.ajax({
                    type: form.attr('method'),
                    url: '../MuestraInsumosReceta',
                    data: form.serialize(),
                    success: function(data) {
                        limpiaCampos();
                        hacerTabla(data);
                    },
                    error: function() {
                        //alert("Ha ocurrido un error - cap insumo");
                    }
                });
                function limpiaCampos() {
                    $("#cla_pro").val("");
                    $("#des_pro").val("");
                    $("#ori1").attr("value", "");
                    $("#ori2").attr("value", "");
                    $("#existencias").attr("value", "");
                    $("#indica").val("");
                    $("#causes").val("");
                    $("#can_sol").val("");
                }

                function hacerTabla(data) {
                    var json = JSON.parse(data);
                    $("#tablaMedicamentos").empty();
                    $("#tablaMedicamentos").append(
                            $("<tr>")
                            .append($("<td>").append("Clave"))
                            .append($("<td>").append("Descripción"))
                            .append($("<td>").append("Lote"))
                            .append($("<td>").append("Caducidad"))
                            .append($("<td>").append("Cant. Sol."))
                            .append($("<td>").append("Cant. Sur."))
                            .append($("<td>").append(""))
                            );
                    for (var i = 0; i < json.length; i++) {
                        var cla_pro = json[i].cla_pro;
                        var des_pro = json[i].des_pro;
                        var lot_pro = json[i].lot_pro;
                        var cad_pro = json[i].cad_pro;
                        var fol_det = json[i].fol_det;
                        var can_sol = json[i].can_sol;
                        var cant_sur = json[i].cant_sur;
                        var btn_modi = "<a class='btn btn-warning' id='btn_modi' value = '" + fol_det + "' name = 'btn_modi'  data-toggle=\'modal\'  href=\'#edita_clave_" + fol_det + "\'><span class='glyphicon glyphicon-pencil' ></span></a>";
                        var btn_eliminar = "<a class='btn btn-danger' id='btn_eli' value = '" + fol_det + "' name = 'btn_eli' data-toggle=\'modal\'  href=\'#elimina_clave_" + fol_det + "\'><span class='glyphicon glyphicon-remove' ></span></a>";
                        $("#tablaMedicamentos").append(
                                $("<tr>")
                                .append($("<td>").append(cla_pro))
                                .append($("<td>").append(des_pro))
                                .append($("<td>").append(lot_pro))
                                .append($("<td>").append(cad_pro))
                                .append($("<td>").append(can_sol))
                                .append($("<td>").append(cant_sur))
                                .append($("<td>").append(btn_modi).append(btn_eliminar))
                                );
                    }
                }
                location.reload();
                $("#cla_pro").focus();
            }
        }
        else {
            alert("Capture primero el medicamento");
        }


    });


});