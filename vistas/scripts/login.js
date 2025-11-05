
// Seleccionar el formulario y el modal
const loginForm = document.getElementById('frmAcceso');
const errorModal = document.getElementById('errorModal');

// Función para mostrar el modal
function showModal() {
    errorModal.classList.add('active');
}

// Función para cerrar el modal
function closeModal() {
    errorModal.classList.remove('active');
}

// Realizar la solicitud AJAX para verificar el login
$("#frmAcceso").on('submit', function (e) {
    e.preventDefault(); // Detener el comportamiento predeterminado del formulario

    // Obtener los valores de usuario y contraseña
    var logina = $("#logina").val();
    var clavea = $("#clavea").val();

    // Realizar la solicitud AJAX
    $.post("../ajax/usuario.php?op=verificar", { "logina": logina, "clavea": clavea }, function (data) {
        // Verificar si la respuesta es válida
        if (data != "null") {
            // Si es correcto, redirigir al escritorio
            $(location).attr("href", "categoria.php");
        } else {
            // Deshabilitar los campos y el botón de login
            $("#logina, #clavea, #btnLogin").prop("disabled", true);

            // Mostrar el modal de error
            showModal();

            // Reactivar los campos después de cerrar el modal
            setTimeout(function () {
                $("#logina, #clavea, #btnLogin").prop("disabled", false);
            }, 1000); // Reactivar después de 3 segundos
        }
    });
});
