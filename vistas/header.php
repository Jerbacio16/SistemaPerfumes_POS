<?php
if (strlen(session_id()) < 1) 
  session_start();
?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Esencia Real Stock</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../public/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../public/css/font-awesome.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../public/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../public/css/_all-skins.min.css">
    <link rel="apple-touch-icon" href="../public/img/apple-touch-icon.png">
    <link rel="shortcut icon" href="../files/logo5.ico" type="image/x-icon">
    <link rel="icon" href="../files/logo5.ico" type="image/x-icon">

    <link rel="stylesheet" href="../public/css/header.css">


    <!-- DATATABLES -->
    <link rel="stylesheet" type="text/css" href="../public/datatables/jquery.dataTables.min.css">    
    <link href="../public/datatables/buttons.dataTables.min.css" rel="stylesheet"/>
    <link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet"/>

    <link rel="stylesheet" type="text/css" href="../public/css/bootstrap-select.min.css">

  </head>
  <body class="hold-transition skin-blue-light sidebar-mini">
    <div class="wrapper">

      <header class="main-header">

        <!-- Logo -->
        <a href="index2.html" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          <span class="logo-mini"><b>Esencia</b>Real</span>
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>Esencia Real</b></span>
        </a>

        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
            <span class="sr-only">Navegación</span>
          </a>
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->
              
              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="../files/usuarios/<?php echo $_SESSION['imagen']; ?>" class="user-image" alt="User Image">
                  <span class="hidden-xs"><?php echo $_SESSION['nombre']; ?></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header">
                    <img src="../files/usuarios/<?php echo $_SESSION['imagen']; ?>" class="img-circle" alt="User Image">
                    <p>
                      Perfumería
                      <small>www.esenciareal.com.ar</small>
                    </p>
                  </li>
                  
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    
                    <div class="pull-right">
                      <a href="../ajax/usuario.php?op=salir" class="btn btn-default btn-flat">Cerrar</a>
                    </div>
                  </li>
                </ul>
              </li>
              
            </ul>
          </div>

        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">       
          <!-- sidebar menu: : style can be found in sidebar.less -->
          <ul class="sidebar-menu">
            <li class="header"></li>
            <?php 
            if ($_SESSION['escritorio']==1)
            {
              echo '<li id="mEscritorio">
              <a href="escritorio.php">
                <i class="fa fa-tasks" style="color:#00bcd4;"></i> <span>Escritorio</span>
              </a>
            </li>';
            }
            ?>

            <?php 
            if ($_SESSION['almacen']==1)
            {
              echo '<li id="mAlmacen" class="treeview">
              <a href="#">
                <i class="fa fa-laptop" style="color:#9c27b0;"></i>
                <span>Almacén</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lArticulos"><a href="articulo.php"><i class="fa fa-cube" style="color:#ff9800;"></i> Artículos</a></li>
                <li id="lMarca"><a href="marca.php"><i class="fa fa-tag" style="color:#9c27b0;"></i> Marca</a></li>
                <li id="lCategorias"><a href="categoria.php"><i class="fa fa-folder-open" style="color:#03a9f4;"></i> Categorías</a></li>
              </ul>
            </li>';
            }
            ?>

            <?php 
            if ($_SESSION['compras']==1)
            {
              echo '<li id="mCompras" class="treeview">
              <a href="#">
                <i class="fa fa-th" style="color:#ff9800;"></i>
                <span>Compras</span>
                 <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lIngresos"><a href="ingreso.php"><i class="fa fa-truck" style="color:#4CAF50;"></i> Ingresos</a></li>
                <li id="lProveedores"><a href="proveedor.php"><i class="fa fa-user" style="color:#00BCD4;"></i> Proveedores</a></li>
              </ul>
            </li>';
            }
            ?>

            <?php 
            if ($_SESSION['ventas']==1)
            {
              echo '<li id="mVentas" class="treeview">
              <a href="#">
                <i class="fa fa-shopping-cart" style="color:#4caf50;"></i>
                <span>Ventas</span>
                 <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lVentas"><a href="venta.php"><i class="fa fa-shopping-cart" style="color:#4caf50;"></i> Ventas</a></li>
                <li id="lBanco"><a href="banco.php"><i class="fa fa-circle-o"></i> Banco</a></li>
                <li id="lClientes"><a href="cliente.php"><i class="fa fa-users" style="color:#00bcd4;"></i> Clientes</a></li>
              </ul>
            </li>';
            }
            ?>
                        
            <?php 
            if ($_SESSION['acceso']==1)
            {
              echo '<li id="mAcceso" class="treeview">
              <a href="#">
                <i class="fa fa-folder" style="color:#00bcd4;"></i> <span>Acceso</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lUsuarios"><a href="usuario.php"><i class="fa fa-user" style="color:#8bc34a;"></i> Usuarios</a></li>
                <li id="lPermisos"><a href="permiso.php"><i class="fa fa-key" style="color:#ff5722;"></i> Permisos</a></li>
                
              </ul>
            </li>';
            }
            ?>

            <?php 
            if ($_SESSION['consultac']==1)
            {
              echo '<li id="mConsultaC" class="treeview">
              <a href="#">
                <i class="fa fa-bar-chart" style="color:#4caf50;"></i> <span>Consulta Compras</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lConsulasC"><a href="comprasfecha.php"><i class="fa fa-pie-chart" style="color:#03a9f4;"></i> Consulta Compras</a></li>                
              </ul>
            </li>';
            }
            ?>

             <?php 
            if ($_SESSION['consultav']==1)
            {
              echo '<li id="mConsultaV" class="treeview">
              <a href="#">
                <i class="fa fa-bar-chart" style="color:#00bcd4;"></i> <span>Consulta Ventas</span>
                <i class="fa fa-angle-left pull-right"></i>
              </a>
              <ul class="treeview-menu">
                <li id="lConsulasV"><a href="ventasfechacliente.php"><i class="fa fa-pie-chart" style="color:#2196f3;"></i> Consulta Ventas</a></li>                
              </ul>
            </li>';
            }
            ?>

            <li>
              <a href="ayuda.php">
                <i class="fa fa-plus-square" style="color:#e91e63;"></i> <span>Ayuda</span>
                <small class="label pull-right bg-red">PDF</small>
              </a>
            </li>
            <li>
              <a href="acerca.php">
                <i class="fa fa-info-circle" style="color:#ffeb3b;"></i> <span>Acerca De...</span>
                <small class="label pull-right bg-yellow">Esencia Real</small>
              </a>
            </li>
                        
          </ul>
        </section>
        <!-- /.sidebar -->
      </aside>
