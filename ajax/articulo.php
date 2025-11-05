<?php 
require_once "../modelos/articulo.php";

$articulo = new Articulo();

$idarticulo = isset($_POST["idarticulo"]) ? limpiarCadena($_POST["idarticulo"]) : "";
$idcategoria = isset($_POST["idcategoria"]) ? limpiarCadena($_POST["idcategoria"]) : "";
$idmarca = isset($_POST["idmarca"]) ? limpiarCadena($_POST["idmarca"]) : "";
$codigo = isset($_POST["codigo"]) ? limpiarCadena($_POST["codigo"]) : "";
$nombre = isset($_POST["nombre"]) ? limpiarCadena($_POST["nombre"]) : "";
$stock = isset($_POST["stock"]) && $_POST["stock"] !== "" ? intval(limpiarCadena($_POST["stock"])) : 0;
$descripcion = isset($_POST["descripcion"]) ? limpiarCadena($_POST["descripcion"]) : "";
$combinacion = isset($_POST["combinacion"]) ? limpiarCadena($_POST["combinacion"]) : "";
$tamaño = isset($_POST["tamaño"]) ? limpiarCadena($_POST["tamaño"]) : "";
$duracion = isset($_POST["duracion"]) ? limpiarCadena($_POST["duracion"]) : "";
$imagen = isset($_POST["imagen"]) ? limpiarCadena($_POST["imagen"]) : "";


switch ($_GET["op"]) {
    case 'guardaryeditar':
    // Verificar si la imagen fue subida o si es una imagen ya existente
    if (!file_exists($_FILES['imagen']['tmp_name']) || !is_uploaded_file($_FILES['imagen']['tmp_name'])) {
        $imagen = $_POST["imagenactual"];  // Mantener la imagen actual
    } else {
        // Subir nueva imagen
        $ext = explode(".", $_FILES["imagen"]["name"]);
        if ($_FILES['imagen']['type'] == "image/jpg" || $_FILES['imagen']['type'] == "image/jpeg" || $_FILES['imagen']['type'] == "image/png") {
            $imagen = round(microtime(true)) . '.' . end($ext);
            move_uploaded_file($_FILES["imagen"]["tmp_name"], "../files/articulos/" . $imagen);
        } else {
            echo "Formato de imagen no permitido. Solo JPG, JPEG o PNG.";
            exit;
        }
    }

    if (empty($idarticulo)) {
        $rspta = $articulo->insertar($idcategoria, $idmarca, $codigo, $nombre, $stock, $descripcion,$imagen,$combinacion,$tamaño,$duracion);
        echo $rspta ? "Artículo registrado" : "Artículo no se pudo registrar";
    } else {
        $rspta = $articulo->editar($idarticulo, $idcategoria, $idmarca, $codigo, $nombre, $stock, $descripcion, $imagen, $combinacion,$tamaño,$duracion);
        echo $rspta ? "Artículo actualizado" : "Artículo no se pudo actualizar";
    }
    break;
    

    case 'desactivar':
        $rspta = $articulo->desactivar($idarticulo);
        echo $rspta ? "Artículo Desactivado" : "Artículo no se puede desactivar";
        break;

    case 'activar':
        $rspta = $articulo->activar($idarticulo);
        echo $rspta ? "Artículo activado" : "Artículo no se puede activar";
        break;

    case 'mostrar':
        $rspta = $articulo->mostrar($idarticulo);
        // Codificar el resultado utilizando json
        echo json_encode($rspta);
        break;

    case 'listar':
        $rspta = $articulo->listar();
        // Vamos a declarar un array
        $data = Array();
        while ($reg = $rspta->fetch_object()) {
            $data[] = array(
                "0" => ($reg->condicion) ? '<button class="btn btn-warning" onclick="mostrar(' . $reg->idarticulo . ')"><i class="fa fa-pencil"></i></button>' . 
                    ' <button class="btn btn-danger" onclick="desactivar(' . $reg->idarticulo . ')"><i class="fa fa-close"></i></button>' :  
                    ' <button class="btn btn-primary" onclick="activar(' . $reg->idarticulo . ')"><i class="fa fa-check"></i></button>',
                "1" => $reg->nombre,
                "2" => $reg->categoria,
                "3" => $reg->marca,
                "4" => $reg->codigo,
                "5" => $reg->stock,
                "6" => "<img src='../files/articulos/" . $reg->imagen . "' height='50px' width='50px' >",
                "7" => ($reg->condicion) ? '<span class="label bg-green">Activado</span>' :
                '<span class="label bg-red">Desactivado</span>'
            );
        }
        $results = array(
            "sEcho" => 1, // Información para el datatables
            "iTotalRecords" => count($data), // Enviamos el total de registros al datatable
            "iTotalDisplayRecords" => count($data), // Enviamos el total de registros a visualizar
            "aaData" => $data
        );
        echo json_encode($results);
        break;

    case "selectCategoria":
        require_once "../modelos/Categoria.php";
        $categoria = new Categoria();

        $rspta = $categoria->select();

        while ($reg = $rspta->fetch_object()) {
            echo '<option value=' . $reg->idcategoria . '>' . $reg->nombre . '</option>';
        }
        break;
    case "selectMarca":
        require_once "../modelos/Marca.php";
        $marca = new Marca();

        $rspta = $marca->select();

        while ($reg = $rspta->fetch_object()) {
            echo '<option value=' . $reg->idmarca . '>' . $reg->nombre . '</option>';
        }
        break;
}
?>
