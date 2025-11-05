-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-11-2025 a las 15:54:32
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
-- Base de datos: `perfumeria`
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
(30, 14, 14, '739187398179832', 'Asad', 10, '100ml\r\nAmbar para hombres', '1759766556.jpeg', 1, 'Mezcla energética de pimienta negra, tabaco y piña, ofreciendo un inicio intenso', 100, '8 horas'),
(31, 15, 8, '918309280381023', 'One Million', 15, 'moderada', '1759766744.jpeg', 1, 'Canela, notas especiadas y rosa, ámbar, cuero y notas amaderadas.', 100, '10 horas'),
(32, 15, 8, '798379827923', 'Invictus', 17, 'Fuerte, luedo moderada.', '1760458960.jpeg', 1, 'Fresca amaderada acuática', 50, '6 a 8 horas'),
(33, 17, 9, '371928391231', 'Good Girl', 10, '50 ml', '1759766997.jpeg', 1, NULL, 0, ''),
(34, 14, 15, '12632836218', 'Club De Nuit', 15, '95 ml', '1759770716.jpeg', 1, NULL, 0, ''),
(35, 15, 10, '', 'The Icon', 17, '100 ml\r\nBien de Macho!', '1759770824.jpeg', 1, '', 0, ''),
(36, 15, 12, '79567327686', 'Sauvage', 12, '200 ml', '1759770914.jpeg', 1, NULL, 0, ''),
(37, 15, 7, '2398719871982', 'Paco', 20, '50 ml\r\nNunca falla', '1759771005.jpeg', 1, NULL, 0, ''),
(38, 15, 12, '29738127391283', 'Homme', 10, '100 ml', '1759851755.jpeg', 1, 'Notas amaderadas de cedro del Atlas, de pachuli y de vetiver.', 0, ''),
(39, 15, 16, '1837982379182731', 'Le Male Elixir', 10, 'alta', '1761584051.jpg', 1, 'Ámbar aromático amaderado.', 125, '10 horas');

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
(11, 3, 30, 10, 30000.00, 50000.00),
(12, 3, 32, 7, 60000.00, 70000.00),
(13, 3, 33, 10, 80000.00, 100000.00),
(14, 3, 31, 15, 90000.00, 110000.00),
(15, 4, 34, 10, 82000.00, 10500.00),
(16, 4, 35, 17, 35000.00, 55000.00),
(17, 4, 36, 12, 115000.00, 130000.00),
(18, 4, 37, 20, 8000.00, 12000.00),
(19, 5, 34, 5, 85000.00, 105000.00),
(20, 6, 39, 10, 190000.00, 220000.00),
(21, 7, 32, 10, 40000.00, 76000.00),
(22, 7, 38, 10, 200000.00, 250000.00);

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
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(3, 3, 3, 'Boleta', '000001', '00001', '2025-10-06 00:00:00', 0.00, 2870000.00, 'Aceptado'),
(4, 3, 3, 'Factura', '00002', '000002', '2025-10-06 00:00:00', 0.00, 2955000.00, 'Aceptado'),
(5, 10, 3, 'Ticket', '000003', '000003', '2025-10-14 00:00:00', 0.00, 425000.00, 'Aceptado'),
(6, 11, 3, 'Ticket', '000004', '000004', '2025-10-27 00:00:00', 0.00, 1900000.00, 'Aceptado'),
(7, 12, 3, 'Factura', '0005', '000005', '2025-10-27 00:00:00', 21.00, 2400000.00, 'Aceptado');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(7, 'Consulta Ventas'),
(8, 'Landing');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Cliente', 'Pedro Almacigo', 'DNI', '43437698', 'Mariano Moreno 123', '3644987889', 'pedritoalmidon@gmail.com'),
(2, 'Cliente', 'Lautaro Varga', 'DNI', '43437698', 'calle 7 entre 4 y 6', '3644657649', 'lautaroev2015@hotmail.com'),
(3, 'Proveedor', 'Empresa Distrbuidora', 'CUIT', '33465987891', 'Santa Fe', '3644987889', 'lautaro@hotmail.com'),
(4, '', 'Exequiel', 'DNI', '43437698', '7 e 4 y 6', '3644657649', 'lautaroev@hotmail.com'),
(5, 'Proveedor', 'Jere', 'DNI', '44258987', 'mantovani', '644566556', 'd.19jere@gmail.com'),
(6, 'Cliente', 'Diego Maradona', 'DNI', '43615413', 'Napoli', '3737151431', 'diego@gmail.com'),
(7, 'Cliente', 'Carlos Tevez', 'DNI', '43615411', 'Fuerte Apache', '3625123123', 'carlitos@gmail.com'),
(8, 'Cliente', 'Polaco Bastia', 'DNI', '43615427', 'Polonia', '3366762255', ''),
(9, 'Cliente', 'Huevo Acuña', 'DNI', '43615498', 'Nuñez', '3378980123', 'huevito@gmail.com'),
(10, 'Proveedor', 'Cristiano Ronaldo', 'DNI', '43615465', 'Arabia', '3644757575', 'cr7@gmail.com'),
(11, 'Proveedor', 'Neymar Jr', 'DNI', '43615400', 'Brasil', '3644010101', 'ney11@gmail.com'),
(12, 'Proveedor', 'Kun Agüero', 'DNI', '43615401', 'Buenos Aires', '3644776655', 'kun@gmail.com'),
(13, 'Proveedor', 'Pipa Higuain', 'DNI', '43615615', 'Desconocida', '3644123111', 'pipa@gmail.com'),
(14, 'Cliente', 'Gonzalo Gonzalez', 'DNI', '43.999.999', 'sp', '3644999999', 'gonza@gmail.com'),
(15, 'Cliente', '', '', '', '', '', 'gonza@gmail.com'),
(16, 'Cliente', '', '', '', '', '', 'gonza@gmail.com'),
(17, 'Cliente', '', '', '', '', '', 'gonza@gmail.com'),
(18, 'Cliente', '', '', '', '', '', 'gonza@gmail.com'),
(19, 'Cliente', '', '', '', '', '', 'gonza@gmail.com');

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
  `condicion` tinyint NOT NULL DEFAULT '1',
  `imagen` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `condicion`, `imagen`) VALUES
(1, 'Varga Acosta Lautaro', 'DNI', '43437698', 'Calle 7 entre 4 y 6', '3644657649', 'Lautaroev2015@hotmail.com', 'Admin', 'Lautaro', '123', 1, NULL),
(2, 'Varga Lautaro', 'DNI', '43437698', 'Calle 7 entre 4 y 6 Barrio Lamadrid', '3644657649', 'lautaroevfac@gmail.com', 'Administrador', 'lautaro123', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, ''),
(3, 'Messi', 'DNI', '43437699', 'Calle 7 entre 4 y 6 B Lamadrid', '3644989878', 'Lautaroev2015@hotmail.com', 'Administrador', 'messi', '173af653133d964edfc16cafe0aba33c8f500a07f3ba3f81943916910c257705', 1, '1762271526.jpeg'),
(4, 'Carlos Alberto', 'DNI', '43567765', 'Presidencia Roque Saenz Peña', '3644767676', 'carlos@gmail.com', 'Vendedor', 'carlos', '7b85175b455060e3237e925f023053ca9515e8682a83c8b09911c724a1f8b75f', 1, ''),
(5, 'Gonzalo Gonzalez', 'DNI', '43.999.999', 'sp', '3644999999', 'gonza@gmail.com', 'Cliente', 'gonza@gmail.com', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 1, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int NOT NULL,
  `idusuario` int NOT NULL,
  `idpermiso` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(15, 4, 1),
(16, 4, 4),
(17, 4, 7),
(18, 5, 8),
(19, 3, 1),
(20, 3, 2),
(21, 3, 3),
(22, 3, 4),
(23, 3, 5),
(24, 3, 6),
(25, 3, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `idventa` int NOT NULL,
  `idcliente` int NOT NULL,
  `idusuario` int NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) NOT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`);

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
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `idmarca` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
