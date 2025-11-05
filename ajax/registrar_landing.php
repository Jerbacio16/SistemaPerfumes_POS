<?php
require_once "../config/Conexion.php";
session_start();

if (isset($_POST['nombre'])) {
    // ========= REGISTRO =========
    $nombre = $_POST['nombre'] ?? '';
    $tipo_documento = $_POST['tipoDoc'] ?? '';
    $num_documento = $_POST['numDoc'] ?? '';
    $direccion = $_POST['direccion'] ?? '';
    $telefono = $_POST['telefono'] ?? '';
    $email = $_POST['email'] ?? '';
    $clave = hash("SHA256", $_POST['clave'] ?? '');

    // Verificar si ya existe el usuario
    $check = ejecutarConsultaSimpleFila("SELECT idusuario FROM usuario WHERE login = '$email'");
    if ($check) {
        echo "El correo ya está registrado.";
        exit;
    }

    // Insertar persona
    $sql1 = "INSERT INTO persona (tipo_persona, nombre, tipo_documento, num_documento, direccion, telefono, email)
             VALUES ('Cliente', '$nombre', '$tipo_documento', '$num_documento', '$direccion', '$telefono', '$email')";
    $ok1 = ejecutarConsulta($sql1);

    if ($ok1) {
        // Insertar usuario
        $sql2 = "INSERT INTO usuario (nombre, tipo_documento, num_documento, direccion, telefono, email, cargo, login, clave, condicion, imagen)
                 VALUES ('$nombre', '$tipo_documento', '$num_documento', '$direccion', '$telefono', '$email', 'Cliente', '$email', '$clave', 1, '')";
        $idusuario = ejecutarConsulta_retornarID($sql2);

        if ($idusuario > 0) {
            // Permiso “landing”
            $idpermisoLanding = 8; 
            ejecutarConsulta("INSERT INTO usuario_permiso (idusuario, idpermiso) VALUES ($idusuario, $idpermisoLanding)");
            echo "ok";
        } else {
            echo "Error al registrar usuario.";
        }
    } else {
        echo "Error al registrar persona.";
    }

} elseif (isset($_POST['email']) && isset($_POST['password'])) {
    // ========= LOGIN =========
    $email = $_POST['email'];
    $clave = hash("SHA256", $_POST['password']);

    $sql = "SELECT idusuario, nombre, email, cargo, telefono, direccion
            FROM usuario WHERE login = '$email' AND clave = '$clave' AND condicion = 1";
    $result = ejecutarConsultaSimpleFila($sql);

    if ($result) {
        $_SESSION['idusuario'] = $result['idusuario'];
        $_SESSION['nombre'] = $result['nombre'];
        $_SESSION['email'] = $result['email'];
        $_SESSION['cargo'] = $result['cargo'];

        echo json_encode([
            "success" => true,
            "data" => [
                "idcliente" => $result['idusuario'],
                "nombre" => $result['nombre'],
                "email" => $result['email'],
                "telefono" => $result['telefono'],
                "direccion" => $result['direccion'],
                "cargo" => $result['cargo']
            ]
        ]);
    } else {
        echo json_encode(["success" => false, "message" => "Usuario o contraseña incorrectos."]);
    }

} else {
    echo "Sin datos válidos.";
}
?>
