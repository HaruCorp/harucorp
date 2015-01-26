-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-10-2014 a las 18:47:20
-- Versión del servidor: 5.6.20
-- Versión de PHP: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `bd_gestion_talleres`
--


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `coordinadores`
--

CREATE TABLE IF NOT EXISTS `coordinadores` (
`id_coordinador` int(5) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `usuario` varchar(20) NOT NULL,
  `contrasena` blob NOT NULL,
  PRIMARY KEY (`id_coordinador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE IF NOT EXISTS `actividades` (
`id_actividad` int(5) NOT NULL AUTO_INCREMENT,
  `nombre_actividad` varchar(50) NOT NULL,
  `tipo` varchar(15) NOT NULL,
  `inicio` varchar(10) NULL,
  `termino` varchar(10) NULL,
  `duracion` int(3) NOT NULL,
  `modalidad` int(1) NOT NULL,
  `id_coordinador` int(5) NOT NULL,
  PRIMARY KEY (`id_actividad`),
  INDEX (`id_coordinador`),
  FOREIGN KEY (`id_coordinador`) REFERENCES coordinadores(`id_coordinador`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE IF NOT EXISTS `alumnos` (
  `num_boleta` int(10) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `grupo` varchar(5) NOT NULL,
  `carrera` varchar(30) NOT NULL,
  PRIMARY KEY (`num_boleta`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE IF NOT EXISTS `asistencia` (
`id_registro` int(10) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(10) NOT NULL,
  `id_actividad` int(5) NOT NULL,
  `num_boleta` int(10) NOT NULL,
  PRIMARY KEY (`id_registro`),
  INDEX (`num_boleta`),
  FOREIGN KEY (`num_boleta`) REFERENCES alumnos(`num_boleta`),
  INDEX (`id_actividad`),
  FOREIGN KEY (`id_actividad`) REFERENCES actividades(`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------


--
-- Estructura de tabla para la tabla `lista`
--

CREATE TABLE IF NOT EXISTS `listas` (
  `id_lista` int(5) NOT NULL AUTO_INCREMENT,
  `id_actividad` int(5) NOT NULL,
  `num_boleta` int(10) NOT NULL,
  PRIMARY KEY (`id_lista`),
  INDEX (`num_boleta`),
  FOREIGN KEY (`num_boleta`) REFERENCES alumnos(`num_boleta`),
  INDEX (`id_actividad`),
  FOREIGN KEY (`id_actividad`) REFERENCES actividades(`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajos`
--

CREATE TABLE IF NOT EXISTS `trabajos` (
  `id_trabajo` int(10) NOT NULL AUTO_INCREMENT,
  `horas` int(2) NOT NULL,
  `num_boleta` int(10) NOT NULL,
  `id_actividad` int(5) NOT NULL,
  PRIMARY KEY (`id_trabajo`),
  INDEX (`num_boleta`),
  FOREIGN KEY (`num_boleta`) REFERENCES alumnos(`num_boleta`),
  INDEX (`id_actividad`),
  FOREIGN KEY (`id_actividad`) REFERENCES actividades(`id_actividad`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO coordinadores (nombre,usuario,contrasena) VALUES ('Leslie', 'leslycs', AES_ENCRYPT('usot94','upiiz'));
