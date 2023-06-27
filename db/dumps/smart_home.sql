-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql-server:3306
-- Tiempo de generación: 27-06-2023 a las 17:12:27
-- Versión del servidor: 5.7.42
-- Versión de PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `smart_home`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Devices`
--

CREATE TABLE `Devices` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(128) NOT NULL,
  `state` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `dimmable` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Devices`
--

INSERT INTO `Devices` (`id`, `name`, `description`, `state`, `type`, `dimmable`) VALUES
(8, 'Lampara 1', 'Lampara de la Sala', 0, 0, 1),
(9, 'Lampara 2', 'Lampara de la Cocina', 0, 0, 0),
(10, 'Lampara 3', 'Lampara del Cuarto Principal', 0, 0, 1),
(11, 'Persiana 1', 'Persiana de la Sala', 0, 1, 1),
(12, 'Persiana 2', 'Persiana de la Sala', 0, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID` int(11) NOT NULL,
  `Usuario` varchar(255) NOT NULL,
  `Contraseña` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`ID`, `Usuario`, `Contraseña`) VALUES
(1, 'Jhonatan Juno', '123456'),
(2, 'Matias Ramos', '123456');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Devices`
--
ALTER TABLE `Devices`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Devices`
--
ALTER TABLE `Devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
