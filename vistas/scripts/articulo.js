var tabla;

// Función que se ejecuta al inicio
function init() {
    mostrarform(false);
    listar();

    // Manejo del formulario
    $("#formulario").on("submit", function (e) {
        guardaryeditar(e);
    });

    // Cargar categorías al select de categorías
    cargarCategorias();
    cargarMarcas();

    // Manejar cambios en la categoría
    $("#idcategoria").change(function () {
        manejarCambioCategoria();
    });
        // Manejar cambios en la Marca
    $("#idmarca").change(function () {
        manejarCambioMarca();
    });

    // Desencadenar el evento de cambio en la categoría al cargar la página
    $("#idcategoria").trigger("change");
    // Desencadenar el evento de cambio en la categoría al cargar la página
    $("#idmarca").trigger("change");
    // Ocultar la imagen
    $("#imagenmuestra").hide();
}

$(document).ready(function () {
    // Cargar categorías
    $.post("../ajax/articulo.php?op=selectCategoria", function (data) {
        // Limpia las opciones actuales y agrega la opción por defecto
        $("#idcategoria").html('<option value="">Seleccione una categoría</option>' + data).selectpicker('refresh');
        
    });

  });
$(document).ready(function () {
    // Cargar categorías
    $.post("../ajax/articulo.php?op=selectMarca", function (data) {
        // Limpia las opciones actuales y agrega la opción por defecto
        $("#idmarca").html('<option value="">Seleccione una marca</option>' + data).selectpicker('refresh');
        
    });

  });
// Función limpiar
function limpiar() {
  $("#codigo").val("");
  $("#nombre").val("");
  $("#descripcion").val("");
  $("#combinacion").val("");
  $("#tamaño").val("");
  $("#duracion").val("");
  $("#stock").val("");
  $("#imagenmuestra").attr("src", "");
  $("#imagenactual").val("");
  $("#print").hide();
  $("#idarticulo").val("");
}


// Función mostrar formulario
function mostrarform(flag) {
    limpiar();
    if (flag) {
        $("#listadoregistros").hide();
        $("#formularioregistros").show();
        $("#btnGuardar").prop("disabled", false);
        $("#btnagregar").hide();
    } else {
        $("#listadoregistros").show();
        $("#formularioregistros").hide();
        $("#btnagregar").show();
    }
}

// Función cancelarform
function cancelarform() {
    limpiar();
    mostrarform(false);
}

// Función Listar
function listar() {
    tabla = $('#tbllistado').dataTable({
        "aProcessing": true, // Activamos el procesamiento del datatables
        "aServerSide": true, // Paginación y filtrado realizados por el servidor
        dom: 'Bfrtip', // Definimos los elementos del control de tabla
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdf'
        ],
        "ajax": {
            url: '../ajax/articulo.php?op=listar',
            type: "get",
            dataType: "json",
            error: function (e) {
                console.log(e.responseText);
            }
        },
        "bDestroy": true,
        "iDisplayLength": 5, // Paginación
        "order": [[0, "desc"]] // Ordenar (columna, orden)
    }).DataTable();
}

// Función para guardar o editar
function guardaryeditar(e) {
    e.preventDefault(); // No se activará la acción predeterminada del evento
    $("#btnGuardar").prop("disabled", true);
    var formData = new FormData($("#formulario")[0]);

    $.ajax({
      url: "../ajax/articulo.php?op=guardaryeditar",
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
      success: function (datos) {
        bootbox.alert(datos);
        mostrarform(false);
        tabla.ajax.reload();
      }
    });
    limpiar();
}

function mostrar(idarticulo) {
  $.post("../ajax/articulo.php?op=mostrar", { idarticulo: idarticulo }, function (data, status) {
    console.log("Respuesta del servidor:", data);
    data = JSON.parse(data);

    if (data.error) {
      console.error("Error al obtener los datos:", data.error);
      return;
    }

    mostrarform(true);
    $("#idcategoria").val(data.idcategoria).selectpicker('refresh');
    mostrarform(true);
    $("#idmarca").val(data.idmarca).selectpicker('refresh');


    // Resto de datos comunes del artículo
    $("#nombre").val(data.nombre);
    $("#descripcion").val(data.descripcion);
    $("#combinacion").val(data.combinacion);
    $("#duracion").val(data.duracion);
    $("#tamaño").val(data.tamaño);
    $("#stock").val(data.stock);
    $("#imagenmuestra").attr("src", "../files/articulos/" + data.imagen).show();
    $("#imagenactual").val(data.imagen);
    $("#idarticulo").val(data.idarticulo);
  });
}




// Función para desactivar registros
function desactivar(idarticulo) {
    bootbox.confirm("¿Está Seguro de desactivar el artículo?", function (result) {
        if (result) {
            $.post("../ajax/articulo.php?op=desactivar", { idarticulo: idarticulo }, function (e) {
                bootbox.alert(e);
                tabla.ajax.reload();
            });
        }
    });
}

// Función para activar registros
function activar(idarticulo) {
    bootbox.confirm("¿Está Seguro de activar el Artículo?", function (result) {
        if (result) {
            $.post("../ajax/articulo.php?op=activar", { idarticulo: idarticulo }, function (e) {
                bootbox.alert(e);
                tabla.ajax.reload();
            });
        }
    });
}

// Función para generar el código de barras
function generarbarcode() {
  codigo = $("#codigo").val();
  JsBarcode("#barcode", codigo);
  $("#print").show();
}

// Función para imprimir el Código de barras
function imprimir() {
  $("#print").printArea();
}

init();
