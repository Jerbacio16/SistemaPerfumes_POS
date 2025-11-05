<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";

Class Marca
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}

	//Implementamos un método para insertar registros
	public function insertar($nombre,$descripcion,$imagen)
	{
		$sql="INSERT INTO marca (nombre,descripcion,condicion, imagen)
		VALUES ('$nombre','$descripcion','1','$imagen')";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para editar registros
	public function editar($idmarca,$nombre,$descripcion,$imagen)
	{
		$sql="UPDATE marca SET nombre='$nombre',descripcion='$descripcion', imagen='$imagen' WHERE idmarca ='$idmarca'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para desactivar categorías
	public function desactivar($idmarca)
	{
		$sql="UPDATE marca SET condicion='0' WHERE idmarca='$idmarca'";
		return ejecutarConsulta($sql);
	}

	//Implementamos un método para activar categorías
	public function activar($idmarca)
	{
		$sql="UPDATE marca SET condicion='1' WHERE idmarca='$idmarca'";
		return ejecutarConsulta($sql);
	}

	//Implementar un método para mostrar los datos de un registro a modificar
	public function mostrar($idmarca)
	{
		$sql="SELECT * FROM marca WHERE idmarca='$idmarca'";
		return ejecutarConsultaSimpleFila($sql);
	}

	//Implementar un método para listar los registros
	public function listar()
	{
		$sql="SELECT * FROM marca";
		return ejecutarConsulta($sql);		
	}
	public function select()
	{
		$sql="SELECT * FROM marca where condicion=1";
		return ejecutarConsulta($sql);		
	}
	public function listarActivas() {
        $sql = "SELECT * FROM marca WHERE condicion = 1";
        return ejecutarConsulta($sql);
    }
}

?>