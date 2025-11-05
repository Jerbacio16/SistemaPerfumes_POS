<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Articulo
{
    //Implementamos nuestro constructor
public function __construct(){
}

//Implementamos un método para insertar registros
public function insertar($idcategoria, $idmarca, $codigo, $nombre, $stock, $descripcion, $imagen , $combinacion, $tamaño, $duracion)
{
    // Verificar si el nombre ya existe
    $sql_check = "SELECT idarticulo FROM articulo WHERE nombre = '$nombre'";
    $existe = ejecutarConsultaSimpleFila($sql_check);

    if ($existe) {
        return "El artículo ya existe"; // Evitamos el error de duplicado
    }

    // Insertar datos en la tabla artículo
    $sql = "INSERT INTO articulo (idcategoria, idmarca,codigo, nombre, stock, descripcion, imagen, condicion, combinacion, tamaño, duracion) 
            VALUES ('$idcategoria', '$idmarca','$codigo', '$nombre', '$stock', '$descripcion', '$imagen', '1', '$combinacion', '$tamaño', '$duracion')";

    $idarticulo = ejecutarConsulta_retornarID($sql); // Obtener el ID del artículo insertado

    if (!$idarticulo) {
        return false; // Si hay un error en la inserción
    }

    return "Artículo registrado correctamente"; // Confirmamos que se insertó bien
}



//Implementamos un método para editar registros
public function editar($idarticulo, $idcategoria, $idmarca,$codigo, $nombre, $stock, $descripcion, $imagen, $combinacion, $tamaño, $duracion)
{
    // Actualizar datos en la tabla artículo
    $sql = "UPDATE articulo 
            SET idcategoria = '$idcategoria',
                idmarca = '$idmarca', 
                codigo = '$codigo', 
                nombre = '$nombre', 
                stock = '$stock', 
                descripcion = '$descripcion', 
                imagen = '$imagen',
                combinacion = '$combinacion',
                tamaño = '$tamaño',
                duracion = '$duracion' 
            WHERE idarticulo = '$idarticulo'";
    ejecutarConsulta($sql);
    return ejecutarConsulta($sql); // Ejecutamos la consulta
}

// Método para eliminar un artículo (desactivarlo)
public function desactivar($idarticulo)
{
    $sql = "UPDATE articulo SET condicion='0' WHERE idarticulo='$idarticulo'";
    return ejecutarConsulta($sql);
}

// Método para activar un artículo
public function activar($idarticulo)
{
    $sql = "UPDATE articulo SET condicion='1' WHERE idarticulo='$idarticulo'";
    return ejecutarConsulta($sql);
}

// Método para mostrar los detalles de un artículo
public function mostrar($idarticulo)
{
    $sql = "SELECT a.idarticulo, a.nombre, a.codigo, a.stock, a.descripcion, a.imagen, a.combinacion, a.tamaño, a.duracion, 
                a.idcategoria, a.idmarca
            FROM articulo a
            WHERE a.idarticulo = '$idarticulo'";

    return ejecutarConsultaSimpleFila($sql);
}


// Método para listar todos los artículos
public function listar()
{
    $sql = "SELECT a.idarticulo, a.nombre, c.nombre as categoria, m.nombre as marca, a.codigo, a.stock, a.imagen, a.condicion from articulo a
        inner join categoria c on c.idcategoria = a.idcategoria
        inner join marca m on m.idmarca = a.idmarca";
    return ejecutarConsulta($sql);
}

// Método para obtener los artículos activos
public function listarActivos()
{
    $sql = "SELECT a.idarticulo, a.nombre, c.nombre as categoria, m.nombre as marca ,a.codigo, a.stock, a.imagen, a.condicion from articulo a
        inner join categoria c on c.idcategoria = a.idcategoria 
        inner join marca m on m.idmarca = a.idmarca 
        WHERE a.condicion='1'";
    return ejecutarConsulta($sql);
}

}
?>
