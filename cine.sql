-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-06-2018 a las 09:09:45
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cine`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_insertarlis` (IN `nom` VARCHAR(30), IN `gen` INT, IN `dur` TIME, IN `cla` INT)  BEGIN
insert into pelicula (nom_pel,id_gen,dur_pel,id_cla) values (nom,gen,dur,cla);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_listadopel` ()  BEGIN
SELECT p.id_pel, p.nom_pel, g.nom_gen, p.dur_pel, c.nom_cla FROM pelicula p INNER JOIN clasificacion c ON p.id_cla=c.id_cla INNER JOIN genero g ON p.id_gen=g.id_gen
order by p.id_pel;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_adm` int(11) NOT NULL,
  `nom_adm` varchar(50) NOT NULL,
  `ape_adm` varchar(50) NOT NULL,
  `usu_adm` varchar(15) NOT NULL,
  `cla_adm` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_adm`, `nom_adm`, `ape_adm`, `usu_adm`, `cla_adm`) VALUES
(1, 'John Jaime', 'Chunqui Almeyda', 'john', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `boleta`
--

CREATE TABLE `boleta` (
  `id_bol` int(11) NOT NULL,
  `id_prog` int(11) NOT NULL,
  `fec_bol` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_cli` int(11) NOT NULL,
  `imp_bol` int(11) NOT NULL,
  `est_bol` char(1) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion`
--

CREATE TABLE `clasificacion` (
  `id_cla` int(11) NOT NULL,
  `nom_cla` char(3) COLLATE utf8mb4_spanish_ci NOT NULL,
  `des_cla` varchar(60) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `clasificacion`
--

INSERT INTO `clasificacion` (`id_cla`, `nom_cla`, `des_cla`) VALUES
(1, 'APT', 'Apto para todo publico'),
(2, '+14', 'Mayores de 14 años'),
(3, '+18', 'Mayores de 18 años');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cli` int(11) NOT NULL,
  `nom_cli` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `ape_cli` varchar(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `dni_cli` char(8) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `usu_cli` int(11) NOT NULL,
  `cla_cli` int(11) NOT NULL,
  `corr_cli` varchar(30) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fecna_cli` date NOT NULL,
  `gen_cli` char(11) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `dis_cli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_boleta`
--

CREATE TABLE `detalle_boleta` (
  `id_bol` int(11) NOT NULL,
  `id_pre` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `subtot_det` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE `distrito` (
  `id_dis` int(11) NOT NULL,
  `nom_dis` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genero`
--

CREATE TABLE `genero` (
  `id_gen` int(11) NOT NULL,
  `nom_gen` varchar(15) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `genero`
--

INSERT INTO `genero` (`id_gen`, `nom_gen`) VALUES
(1, 'Acción'),
(2, 'Comedia'),
(3, 'Terror'),
(4, 'Ciencia Ficción');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pelicula`
--

CREATE TABLE `pelicula` (
  `id_pel` int(11) NOT NULL,
  `nom_pel` varchar(40) COLLATE utf8mb4_spanish_ci NOT NULL,
  `id_gen` int(11) NOT NULL,
  `dur_pel` time NOT NULL,
  `id_cla` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precio`
--

CREATE TABLE `precio` (
  `id_pre` int(11) NOT NULL,
  `des_pre` varchar(40) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `precio`
--

INSERT INTO `precio` (`id_pre`, `des_pre`, `precio`) VALUES
(1, 'General', 16),
(2, 'Niños menores a 12 y mayores de 60 años', 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programacion`
--

CREATE TABLE `programacion` (
  `id_prog` int(11) NOT NULL,
  `fec_prog` date NOT NULL,
  `id_pel` int(11) NOT NULL,
  `id_sala` int(11) NOT NULL,
  `hor_ini` time NOT NULL,
  `tipo` char(2) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `audio` char(3) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sala`
--

CREATE TABLE `sala` (
  `id_sala` int(11) NOT NULL,
  `asi_sala` tinyint(4) NOT NULL,
  `pis_sal` tinyint(6) NOT NULL,
  `afo_sala` smallint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Volcado de datos para la tabla `sala`
--

INSERT INTO `sala` (`id_sala`, `asi_sala`, `pis_sal`, `afo_sala`) VALUES
(1, 120, 1, 220),
(2, 100, 1, 200),
(3, 110, 1, 200),
(4, 120, 1, 220),
(5, 120, 1, 220),
(6, 120, 1, 220),
(7, 100, 2, 200),
(8, 100, 2, 200),
(9, 100, 2, 200),
(10, 100, 2, 200),
(11, 100, 2, 200),
(12, 100, 2, 200);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_adm`);

--
-- Indices de la tabla `boleta`
--
ALTER TABLE `boleta`
  ADD PRIMARY KEY (`id_bol`),
  ADD KEY `id_prog` (`id_prog`),
  ADD KEY `id_usu` (`id_cli`);

--
-- Indices de la tabla `clasificacion`
--
ALTER TABLE `clasificacion`
  ADD PRIMARY KEY (`id_cla`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cli`),
  ADD KEY `dis_usu` (`dis_cli`);

--
-- Indices de la tabla `detalle_boleta`
--
ALTER TABLE `detalle_boleta`
  ADD KEY `id_bol` (`id_bol`),
  ADD KEY `id_pre` (`id_pre`);

--
-- Indices de la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD PRIMARY KEY (`id_dis`);

--
-- Indices de la tabla `genero`
--
ALTER TABLE `genero`
  ADD PRIMARY KEY (`id_gen`);

--
-- Indices de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD PRIMARY KEY (`id_pel`),
  ADD KEY `gen_pel` (`id_gen`),
  ADD KEY `cla_pel` (`id_cla`);

--
-- Indices de la tabla `precio`
--
ALTER TABLE `precio`
  ADD PRIMARY KEY (`id_pre`);

--
-- Indices de la tabla `programacion`
--
ALTER TABLE `programacion`
  ADD PRIMARY KEY (`id_prog`),
  ADD KEY `pel_prog` (`id_pel`),
  ADD KEY `sala_prog` (`id_sala`);

--
-- Indices de la tabla `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`id_sala`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_adm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `boleta`
--
ALTER TABLE `boleta`
  MODIFY `id_bol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clasificacion`
--
ALTER TABLE `clasificacion`
  MODIFY `id_cla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cli` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `distrito`
--
ALTER TABLE `distrito`
  MODIFY `id_dis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `genero`
--
ALTER TABLE `genero`
  MODIFY `id_gen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pelicula`
--
ALTER TABLE `pelicula`
  MODIFY `id_pel` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `precio`
--
ALTER TABLE `precio`
  MODIFY `id_pre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `programacion`
--
ALTER TABLE `programacion`
  MODIFY `id_prog` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sala`
--
ALTER TABLE `sala`
  MODIFY `id_sala` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `boleta`
--
ALTER TABLE `boleta`
  ADD CONSTRAINT `boleta_ibfk_1` FOREIGN KEY (`id_prog`) REFERENCES `programacion` (`id_prog`),
  ADD CONSTRAINT `boleta_ibfk_2` FOREIGN KEY (`id_cli`) REFERENCES `cliente` (`id_cli`);

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`dis_cli`) REFERENCES `distrito` (`id_dis`);

--
-- Filtros para la tabla `detalle_boleta`
--
ALTER TABLE `detalle_boleta`
  ADD CONSTRAINT `detalle_boleta_ibfk_1` FOREIGN KEY (`id_bol`) REFERENCES `boleta` (`id_bol`),
  ADD CONSTRAINT `detalle_boleta_ibfk_2` FOREIGN KEY (`id_pre`) REFERENCES `precio` (`id_pre`);

--
-- Filtros para la tabla `pelicula`
--
ALTER TABLE `pelicula`
  ADD CONSTRAINT `pelicula_ibfk_1` FOREIGN KEY (`id_gen`) REFERENCES `genero` (`id_gen`),
  ADD CONSTRAINT `pelicula_ibfk_2` FOREIGN KEY (`id_cla`) REFERENCES `clasificacion` (`id_cla`);

--
-- Filtros para la tabla `programacion`
--
ALTER TABLE `programacion`
  ADD CONSTRAINT `programacion_ibfk_1` FOREIGN KEY (`id_pel`) REFERENCES `pelicula` (`id_pel`),
  ADD CONSTRAINT `programacion_ibfk_3` FOREIGN KEY (`id_sala`) REFERENCES `sala` (`id_sala`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
