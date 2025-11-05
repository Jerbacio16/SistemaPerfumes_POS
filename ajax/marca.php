<?php 
require_once "../modelos/Marca.php";

//Cuando creo la instancia ulitizo en constructor

$marca=new Marca();

// Si existe el parámetro idmarca mediante el méodo post que limpie cadena
$idmarca=isset($_POST["idmarca"])? limpiarCadena($_POST["idmarca"]):"";
$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
$descripcion=isset($_POST["descripcion"])? limpiarCadena($_POST["descripcion"]):"";
$imagen=isset($_POST["imagen"])? limpiarCadena($_POST["imagen"]):"";

switch ($_GET["op"]){
	case 'guardaryeditar':
		// Verificar si la imagen fue subida o si es una imagen ya existente
		if (!file_exists($_FILES['imagen']['tmp_name']) || !is_uploaded_file($_FILES['imagen']['tmp_name'])) {
			$imagen = $_POST["imagenactual"];  // Mantener la imagen actual
		} else {
			// Subir nueva imagen
			$ext = explode(".", $_FILES["imagen"]["name"]);
			if ($_FILES['imagen']['type'] == "image/jpg" || $_FILES['imagen']['type'] == "image/jpeg" || $_FILES['imagen']['type'] == "image/png") {
				$imagen = round(microtime(true)) . '.' . end($ext);
				move_uploaded_file($_FILES["imagen"]["tmp_name"], "../files/marca/" . $imagen);
			} else {
				echo "Formato de imagen no permitido. Solo JPG, JPEG o PNG.";
				exit;
			}
		}
		if (empty($idmarca)){
			$rspta=$marca->insertar($nombre,$descripcion,$imagen);
			echo $rspta ? "Marca registrada" : "Categoría no se pudo registrar";
		}
		else {
			$rspta=$marca->editar($idmarca,$nombre,$descripcion, $imagen);
			echo $rspta ? "Marca actualizada" : "Categoría no se pudo actualizar";
		}
	break;

	case 'desactivar':
		$rspta=$marca->desactivar($idmarca);
 		echo $rspta ? "Categoría Desactivada" : "Categoría no se puede desactivar";
 		break;
	break;

	case 'activar':
		$rspta=$marca->activar($idmarca);
 		echo $rspta ? "Categoría activada" : "Categoría no se puede activar";
 	break;

	case 'mostrar':
		$rspta=$marca->mostrar($idmarca);
 		//Codificar el resultado utilizando json
 		echo json_encode($rspta);
 	break;

	case 'listar':
		$rspta=$marca->listar();
 		//Vamos a declarar un array
 		$data= Array();

 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>($reg->condicion)?'<button class="btn btn-warning" onclick="mostrar('.$reg->idmarca.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-danger" onclick="desactivar('.$reg->idmarca.')"><i class="fa fa-close"></i></button>':
 					'<button class="btn btn-warning" onclick="mostrar('.$reg->idmarca.')"><i class="fa fa-pencil"></i></button>'.
 					' <button class="btn btn-primary" onclick="activar('.$reg->idmarca.')"><i class="fa fa-check"></i></button>',
 				"1"=>$reg->nombre,
 				"2"=>$reg->descripcion,
 				"3"=> "<img src='../files/marca/" . $reg->imagen . "' height='50px' width='50px' >",
 				"4"=>($reg->condicion)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>'
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);

	break;
	
	case 'listar_home':
        $rspta = $marca->listarActivas();
        $data = array();

        while ($reg = $rspta->fetch_object()) {
            $data[] = array(
                "idmarca" => $reg->idmarca,
                "nombre" => $reg->nombre,
                "imagen" => $reg->imagen
            );
        }

        echo json_encode($data);
    break;
}
?>