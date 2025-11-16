-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-11-2025 a las 17:26:10
-- Versión del servidor: 8.0.34
-- Versión de PHP: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbsistema`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int NOT NULL,
  `idcategoria` int NOT NULL,
  `idmarca` int NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint NOT NULL DEFAULT '1',
  `combinacion` varchar(80) DEFAULT NULL,
  `tamaño` int NOT NULL,
  `duracion` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `idmarca`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`, `combinacion`, `tamaño`, `duracion`) VALUES
(30, 14, 14, '739187398179832', 'Asad', 15, '100ml\r\nAmbar para hombres', '1759766556.jpeg', 1, 'Mezcla energética de pimienta negra, tabaco y piña, ofreciendo un inicio intenso', 100, '8 horas'),
(31, 15, 8, '918309280381023', 'One Million', 10, 'moderada', '1759766744.jpeg', 1, 'Canela, notas especiadas y rosa, ámbar, cuero y notas amaderadas.', 100, '10 horas'),
(32, 15, 8, '798379827923', 'Invictus', 20, 'Fuerte, luedo moderada.', '1760458960.jpeg', 1, 'Fresca amaderada acuática', 50, '6 a 8 horas'),
(33, 17, 9, '371928391231', 'Good Girl', 8, '50 ml', '1759766997.jpeg', 1, NULL, 0, ''),
(34, 14, 15, '12632836218', 'Club De Nuit', 12, '95 ml', '1759770716.jpeg', 1, NULL, 0, ''),
(35, 15, 10, '', 'The Icon', 16, '100 ml\r\nBien de Macho!', '1759770824.jpeg', 1, '', 0, ''),
(36, 15, 12, '79567327686', 'Sauvage', 5, '200 ml', '1759770914.jpeg', 1, NULL, 0, ''),
(37, 15, 7, '2398719871982', 'Paco', 30, '50 ml\r\nNunca falla', '1759771005.jpeg', 1, NULL, 0, ''),
(38, 15, 12, '29738127391283', 'Homme', 25, '100 ml', '1759851755.jpeg', 1, 'Notas amaderadas de cedro del Atlas, de pachuli y de vetiver.', 0, ''),
(39, 15, 16, '1837982379182731', 'Le Male Elixir', 5, 'alta', '1761584051.jpg', 1, 'Ámbar aromático amaderado.', 125, '10 horas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `banco`
--

CREATE TABLE `banco` (
  `idbanco` int NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `condicion` tinyint DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `banco`
--

INSERT INTO `banco` (`idbanco`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Nuevo Banco Del Chaco', 'inverti en este banco', 1),
(2, 'Banco Nación', 'aca no inviertas', 1),
(3, 'Banco Frances', 'primero argentina', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `condicion` tinyint NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(14, 'Arabes', 'rico', 1),
(15, 'Diseñador', 'cheto', 1),
(16, 'Niños', 'nenes', 1),
(17, 'Mujeres', 'girly', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int NOT NULL,
  `idingreso` int NOT NULL,
  `idarticulo` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(23, 12, 30, 15, 50000.00, 65000.00),
(24, 12, 31, 10, 80000.00, 100000.00),
(25, 12, 32, 20, 65000.00, 80000.00),
(26, 12, 33, 8, 70000.00, 90000.00),
(27, 12, 34, 12, 120000.00, 150000.00),
(28, 12, 35, 16, 45000.00, 60000.00),
(29, 12, 36, 5, 150000.00, 180000.00),
(30, 12, 37, 30, 6000.00, 12000.00),
(31, 12, 38, 25, 90000.00, 120000.00),
(32, 12, 39, 5, 200000.00, 220000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int NOT NULL,
  `idventa` int NOT NULL,
  `idarticulo` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(11,2) DEFAULT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int NOT NULL,
  `idproveedor` int NOT NULL,
  `idusuario` int NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(12, 11, 10, 'Boleta', '00001', '00001', '2025-11-11 00:00:00', 0.00, 9750000.00, 'Aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `idmarca` int NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `descripcion` text NOT NULL,
  `condicion` tinyint NOT NULL,
  `imagen` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`idmarca`, `nombre`, `descripcion`, `condicion`, `imagen`) VALUES
(7, 'Paco', 'crack', 1, '1762217005.jpeg'),
(8, 'Paco Rabanne', '--', 1, '1762216811.png'),
(9, 'Carolina Herrera', '', 1, '1762216821.png'),
(10, 'Antonio Banderas', '', 1, '1762192584.jpg'),
(11, 'Chanel', '', 1, '1762216801.jpg'),
(12, 'Dior', '', 1, '1762216792.png'),
(13, 'Dolce &amp; Gabbana', '', 1, '1762216904.png'),
(14, 'Lattafa', '', 1, '1762216865.png'),
(15, 'Armaf', '', 1, '1762216876.jpg'),
(16, 'Jean Paul Gaultier', '', 1, '1762216886.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acceso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` int NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Proveedor', 'Sacci', 'DNI', '26606550', 'San Martín 721', '0365422244', ''),
(2, '', '', NULL, NULL, NULL, NULL, NULL),
(3, '', 'TODOMUSICA SA', '', '26655541', 'KJSDHKASJDHKASJ', '', ''),
(4, '', 'AAAAA', '', '1414114', 'AAAAA', '', ''),
(5, 'Cliente', 'Gustavo Paszco', 'DNI', '26606550', 'San Martín 721', '03644452256', 'gustavo@yahoo.com.ar'),
(6, 'Proveedor', 'Todomusica SA', 'DNI', '26654521', 'Sarmiento 44 - Bs As', '0364451485', 'gustavo@yahoo.com.ar'),
(7, 'Proveedor', 'Import Music', 'DNI', '26541554', 'San Martín 72364', '0311554854', 'import@gmail.com'),
(8, 'Cliente', 'Perez Pedro', 'DNI', '25412448', 'Las Heras 24', '0364578442', ''),
(9, 'Proveedor', 'Fama Music', 'DNI', '2547841', 'Sarmiento 777 - Bs As -Capital', '0354-45214555', ''),
(10, 'Cliente', 'Diego Maradona', 'DNI', '1125487', 'Las Heras 44 - Bs As', '', ''),
(11, 'Proveedor', 'Esencias Mayor S.R.L', 'DNI', '77665544', 'Arabia 1567', '3644364436', 'esenciasmayor@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(1, 'Gustavo Paszco', 'DNI', '26606550', 'San Martín 721', '364420268', 'gustavopaszco@yahoo.com.ar', 'Profesor', 'admin', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '1606694032.jpg', 1),
(2, 'sdfsdfdsf', 'DNI', '32423432', 'wrwerew', '2423432', 'werwerew@erwerwre.com', 'weqweqw', 'vendendor', '7d77d86f7ded63285f39fa6a670274773d589b8647182ecc6ea2bf4b5ca658a3', '1547075569.jpg', 0),
(3, 'Ana Dias', 'DNI', '25444551', '', '', '', '', 'Ana', 'dea210f058b407db5c1b5ea89b2e42a57221c003dba55e2f1776a75a3254d386', '', 1),
(4, 'werewrew', 'DNI', '3423432', '23423432werwer', '23423432', '', '', 'wwww', '6b4a1673b225e8bf5f093b91be8c864427df32ca41b17cc0b82112b8f0185e41', '', 0),
(5, 'sdsds', 'DNI', '32332', 'wqewqewq', '213213', '', '', 'aaa', '9834876dcfb05cb167a5c24953eba58c4ac89b1adf57f28f2f9d09af107ee8f0', '', 0),
(7, 'bbbbbbbbbbbb', 'DNI', '222222', 'bbbbb', '222222', '', '', 'bbb', '3e744b9dc39389baf0c5a0660589b8402f3dbb49b89b3e75f2c9355852a3c677', '', 1),
(8, 'Pedro Pablo Paszco', 'DNI', '26606550', 'Sarmiento  4526', '036444512', 'gustavo@yahoo.com.ar', 'Vendedor', 'pedro', 'ee5cd7d5d96c8874117891b2c92a036f96918e66c102bc698ae77542c186f981', '', 1),
(9, 'Jose Chatruc', 'DNI', '154222548', 'Sarmiento 4457', '0364554478', '', 'Vendedor', 'jose1', '1ae3c0e7bb7cb9264ad5a25739e7dd0ff636285b4ebff42dcde5060478784511', '1606696853.jpg', 1),
(10, 'Aministrador', 'DNI', '12121212', 'admin', '3644121212', 'admin@gmail.com', 'Administrador', 'Administrador', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '1762816469.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int NOT NULL,
  `idusuario` int NOT NULL,
  `idpermiso` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(12, 7, 1),
(13, 7, 2),
(14, 7, 3),
(24, 3, 1),
(25, 3, 2),
(26, 3, 3),
(27, 3, 4),
(28, 3, 5),
(29, 3, 6),
(30, 3, 7),
(64, 8, 1),
(65, 8, 2),
(66, 8, 4),
(67, 8, 7),
(75, 1, 1),
(76, 1, 2),
(77, 1, 3),
(78, 1, 4),
(79, 1, 5),
(80, 1, 6),
(81, 1, 7),
(83, 9, 4),
(84, 10, 1),
(85, 10, 2),
(86, 10, 3),
(87, 10, 4),
(88, 10, 5),
(89, 10, 6),
(90, 10, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int NOT NULL,
  `idcliente` int NOT NULL,
  `idusuario` int NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`),
  ADD KEY `idmarca` (`idmarca`);

--
-- Indices de la tabla `banco`
--
ALTER TABLE `banco`
  ADD PRIMARY KEY (`idbanco`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indices de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indices de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`idmarca`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Indices de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `banco`
--
ALTER TABLE `banco`
  MODIFY `idbanco` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `idmarca` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`),
  ADD CONSTRAINT `fk_articulo_marca` FOREIGN KEY (`idmarca`) REFERENCES `marca` (`idmarca`);

--
-- Filtros para la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`);

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`);

--
-- Filtros para la tabla `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD CONSTRAINT `fk_usuario_permiso_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`),
  ADD CONSTRAINT `fk_usuario_permiso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`),
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
