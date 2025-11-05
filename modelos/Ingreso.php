<?php 
//Incluímos inicialmente la conexión a la base de datos
require "../config/Conexion.php";
 
Class Ingreso
{
    //Implementamos nuestro constructor
    public function __construct()
    {
 
    }
 
    //Implementamos un método para insertar registros
    //Implementamos un método para insertar registros
    public function insertar($idproveedor,$idusuario,$tipo_comprobante,$serie_comprobante,$num_comprobante,$fecha_hora,$impuesto,$total_compra,$idarticulo,$cantidad,$precio_compra,$precio_venta)
    {
        $sql="INSERT INTO ingreso (idproveedor,idusuario,tipo_comprobante,serie_comprobante,num_comprobante,fecha_hora,impuesto,total_compra,estado)
        VALUES ('$idproveedor','$idusuario','$tipo_comprobante','$serie_comprobante','$num_comprobante','$fecha_hora','$impuesto','$total_compra','Aceptado')";
        
        $idingresonew = ejecutarConsulta_retornarID($sql);

        $num_elementos = 0;
        $sw = true;

        while ($num_elementos < count($idarticulo))
        {
            // Insertar detalle
            $sql_detalle = "INSERT INTO detalle_ingreso(idingreso, idarticulo, cantidad, precio_compra, precio_venta) 
                            VALUES ('$idingresonew', '{$idarticulo[$num_elementos]}', '{$cantidad[$num_elementos]}', '{$precio_compra[$num_elementos]}', '{$precio_venta[$num_elementos]}')";
            ejecutarConsulta($sql_detalle) or $sw = false;

            // Actualizar stock
            $sql_stock = "UPDATE articulo SET stock = stock + {$cantidad[$num_elementos]} WHERE idarticulo = '{$idarticulo[$num_elementos]}'";
            ejecutarConsulta($sql_stock) or $sw = false;

            $num_elementos++;
        }

        return $sw;
    }
 
     
    //Implementamos un método para anular categorías
    public function anular($idingreso)
    {
        $sql="UPDATE ingreso SET estado='Anulado' WHERE idingreso='$idingreso'";
        return ejecutarConsulta($sql);
    }
 
 
    //Implementar un método para mostrar los datos de un registro a modificar
    public function mostrar($idingreso)
    {
        $sql="SELECT i.idingreso,DATE(i.fecha_hora) as fecha,i.idproveedor,p.nombre as proveedor,u.idusuario,u.nombre as usuario,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,i.total_compra,i.impuesto,i.estado FROM ingreso i INNER JOIN persona p ON i.idproveedor=p.idpersona INNER JOIN usuario u ON i.idusuario=u.idusuario WHERE i.idingreso='$idingreso'";
        return ejecutarConsultaSimpleFila($sql);
    }
 
    public function listarDetalle($idingreso)
    {
        $sql="SELECT di.idingreso,di.idarticulo,a.nombre,di.cantidad,di.precio_compra,di.precio_venta FROM detalle_ingreso di inner join articulo a on di.idarticulo=a.idarticulo where di.idingreso='$idingreso'";
        return ejecutarConsulta($sql);
    }
 
    //Implementar un método para listar los registros
    public function listar()
    {
        $sql="SELECT i.idingreso,DATE(i.fecha_hora) as fecha,i.idproveedor,p.nombre as proveedor,u.idusuario,u.nombre as usuario,i.tipo_comprobante,i.serie_comprobante,i.num_comprobante,i.total_compra,i.impuesto,i.estado FROM ingreso i INNER JOIN persona p ON i.idproveedor=p.idpersona INNER JOIN usuario u ON i.idusuario=u.idusuario ORDER BY i.idingreso desc";
        return ejecutarConsulta($sql);      
    }
     
}
 
?>