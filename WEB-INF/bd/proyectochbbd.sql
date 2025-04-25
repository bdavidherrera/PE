-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-04-2025 a las 00:40:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectochbbd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id` int(11) NOT NULL,
  `identificacion` int(100) NOT NULL,
  `usuario` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  `nombreCompleto` text NOT NULL,
  `fk_id_rol_admi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id`, `identificacion`, `usuario`, `password`, `nombreCompleto`, `fk_id_rol_admi`) VALUES
(1, 1095052112, 'Juan@gmail.com', '1234567', 'Juan Manuel Gonzales Farfas', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anteproyecto`
--

CREATE TABLE `anteproyecto` (
  `id` int(11) NOT NULL,
  `nombreidea` varchar(200) DEFAULT NULL,
  `nombrees` varchar(120) DEFAULT NULL,
  `apellidoes` varchar(120) DEFAULT NULL,
  `semestrees` varchar(120) DEFAULT NULL,
  `anteproyecto` text DEFAULT NULL,
  `identificaciondir` varchar(120) DEFAULT NULL,
  `nombredir` varchar(200) DEFAULT NULL,
  `calificaciondir` varchar(120) DEFAULT NULL,
  `radicadoant` text DEFAULT NULL,
  `nombreeva` varchar(120) DEFAULT NULL,
  `calificacioneva` varchar(120) DEFAULT NULL,
  `estadofinalcor` varchar(120) DEFAULT NULL,
  `radicaante` text DEFAULT NULL,
  `fk_id_profesor` int(120) DEFAULT NULL,
  `fk_id_estudiante` int(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `anteproyecto`
--

INSERT INTO `anteproyecto` (`id`, `nombreidea`, `nombrees`, `apellidoes`, `semestrees`, `anteproyecto`, `identificaciondir`, `nombredir`, `calificaciondir`, `radicadoant`, `nombreeva`, `calificacioneva`, `estadofinalcor`, `radicaante`, `fk_id_profesor`, `fk_id_estudiante`) VALUES
(7, 'IA APP', 'Juan Camilo', 'Fabian Perez', 'Quinto', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', '1096063688', 'Milena Juan Camila', 'correciones', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', 'Juan Manuel Gomez Ortiz', 'sin revisar', 'sin revisar', 'Sin adjuntar', 1000006991, 1096055577),
(10, 'WEB EXPRESS', 'Maria Fernanda', 'Lizara Magali', 'Quinto', 'https://docs.google.com/document/d/1ruJPYQnbsvF3f0EU9yfrNappUx3OJgpg/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', '0', 'Sin seleccionar', 'sin revisar', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', 'Sin seleccionar', 'sin revisar', 'sin revisar', 'Sin adjuntar', 0, 1096063600),
(13, 'IOT SUBMARINO', 'Yudisa', 'Hernesta', 'Quinto', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', '1096063688', 'Laura  Juan Camila', 'aprobado', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', 'Juan Gustavo Jaimes albarado', 'aprobado', 'aprobado', 'https://docs.google.com/document/d/1p9QZ4RL44CrQTkuoXaXOK2OJYMc08Ee3/edit?usp=sharing&ouid=102862212499024534963&rtpof=true&sd=true', 1022222211, 1095052777);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coordinador`
--

CREATE TABLE `coordinador` (
  `noidentificacionc` int(100) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellidos` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  `fk_id_rolc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `coordinador`
--

INSERT INTO `coordinador` (`noidentificacionc`, `nombre`, `apellidos`, `password`, `fk_id_rolc`) VALUES
(1096063678, 'Juan Perez', 'Hernando Perez', '1', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudianteuts`
--

CREATE TABLE `estudianteuts` (
  `noidentificacion` int(100) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellidos` varchar(120) NOT NULL,
  `carrera` varchar(120) NOT NULL,
  `semestre` varchar(120) NOT NULL,
  `correo` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  `fk_id_rol` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estudianteuts`
--

INSERT INTO `estudianteuts` (`noidentificacion`, `nombre`, `apellidos`, `carrera`, `semestre`, `correo`, `password`, `fk_id_rol`) VALUES
(0, '0', '0', '0', '0', '0', '0', 6),
(1026055577, 'Juan Prada', 'Guan Maquil', 'Tecnologia en desarrollo de sistemas informaticos', 'Quinto', 'Juan102@uts.edu.co', '1026055577Guan', 6),
(1095052777, 'Yudisa', 'Hernesta', 'Tecnologia en desarrollo de sistemas informaticos', 'Quinto', 'Yudisa@uts.edu.co', '1095052777Yudisa', 6),
(1096055577, 'Juan Camilo', 'Fabian Perez', 'Tecnología en Desarrollo de Sistemas Informáticos', 'Quinto', 'JuanCamilo@uts.edu.co', 'juancamilo777', 6),
(1096063600, 'Maria Fernanda', 'Lizara Magali', 'Tecnologia en desarrollo de sistemas informaticos', 'Quinto', 'MariaFernanda@uts.edu.co', '1096063600Maria ', 6),
(1096063699, 'Juan Camilo', 'Fabian Gimenes', 'TecnologÃ­a en desarrollo de sistemas informaticos', 'Quinto', 'Fabian@uts.edu.co', 'juancamilo', 6),
(1096065511, 'Camilo Hernandez', 'Perres Alvichara', 'Tecnologia en desarrollo de sistemas informaticos', 'Quinto', 'CamiloHernandez@uts.edu.co', 'CamiloHernandez04', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historialversiones`
--

CREATE TABLE `historialversiones` (
  `id` int(11) NOT NULL,
  `id_anteproyecto` int(11) DEFAULT NULL,
  `nombreidea` varchar(200) NOT NULL,
  `autor_rol` text NOT NULL,
  `autor_id` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `AnteproyectoUrl` text NOT NULL,
  `numero_version` int(111) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `idea`
--

CREATE TABLE `idea` (
  `id` int(11) NOT NULL,
  `nombre` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `idea`
--

INSERT INTO `idea` (`id`, `nombre`) VALUES
(2, 'APP IA empresa'),
(3, 'IA APP'),
(4, 'WEB EXPRESS'),
(6, '3D PLATAFORMA'),
(7, 'IOT SUBMARINO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesoruts`
--

CREATE TABLE `profesoruts` (
  `identificacionp` int(100) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellidos` varchar(120) NOT NULL,
  `correo` varchar(120) NOT NULL,
  `password` varchar(120) NOT NULL,
  `titulos` text NOT NULL,
  `fk_id_rolp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesoruts`
--

INSERT INTO `profesoruts` (`identificacionp`, `nombre`, `apellidos`, `correo`, `password`, `titulos`, `fk_id_rolp`) VALUES
(0, '0', '0', '0', '0', '0', 4),
(1000006991, 'Juan Manuel', 'Gomez Ortiz', 'Juan@uts.edu.co', '488888448848', 'Ingeniero Civil,Maestria en Matematica, Maestria En sistemas, Maestria en ciencias especiales.', 5),
(1022222211, 'Juan Gustavo', 'Jaimes albarado', 'JuanGustavo@uts.edu.co', '123456', 'Ingeniero en servidores', 5),
(1096063688, 'Laura ', 'Juan Camila', 'LauraMilena@uts.edu.co', '123458', 'Ingeniera en sistemas', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'administrador'),
(2, 'coordinador'),
(4, 'director'),
(5, 'evaluador'),
(6, 'estudiante');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_rol_admi` (`fk_id_rol_admi`);

--
-- Indices de la tabla `anteproyecto`
--
ALTER TABLE `anteproyecto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_id_evaluador` (`fk_id_profesor`),
  ADD KEY `fk_id_estudiante` (`fk_id_estudiante`);

--
-- Indices de la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD PRIMARY KEY (`noidentificacionc`),
  ADD KEY `fk_coordinador_rol` (`fk_id_rolc`);

--
-- Indices de la tabla `estudianteuts`
--
ALTER TABLE `estudianteuts`
  ADD PRIMARY KEY (`noidentificacion`),
  ADD KEY `fk_estudiante_rol` (`fk_id_rol`);

--
-- Indices de la tabla `historialversiones`
--
ALTER TABLE `historialversiones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_anteproyecto` (`id_anteproyecto`);

--
-- Indices de la tabla `idea`
--
ALTER TABLE `idea`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profesoruts`
--
ALTER TABLE `profesoruts`
  ADD PRIMARY KEY (`identificacionp`),
  ADD KEY `fk_profesor_rol` (`fk_id_rolp`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `anteproyecto`
--
ALTER TABLE `anteproyecto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `historialversiones`
--
ALTER TABLE `historialversiones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `idea`
--
ALTER TABLE `idea`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `fk_id_rol_admi` FOREIGN KEY (`fk_id_rol_admi`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `anteproyecto`
--
ALTER TABLE `anteproyecto`
  ADD CONSTRAINT `fk_id_estudiante` FOREIGN KEY (`fk_id_estudiante`) REFERENCES `estudianteuts` (`noidentificacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_evaluador` FOREIGN KEY (`fk_id_profesor`) REFERENCES `profesoruts` (`identificacionp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `coordinador`
--
ALTER TABLE `coordinador`
  ADD CONSTRAINT `fk_coordinador_rol` FOREIGN KEY (`fk_id_rolc`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estudianteuts`
--
ALTER TABLE `estudianteuts`
  ADD CONSTRAINT `fk_estudiante_rol` FOREIGN KEY (`fk_id_rol`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historialversiones`
--
ALTER TABLE `historialversiones`
  ADD CONSTRAINT `historialversiones_ibfk_1` FOREIGN KEY (`id_anteproyecto`) REFERENCES `anteproyecto` (`id`);

--
-- Filtros para la tabla `profesoruts`
--
ALTER TABLE `profesoruts`
  ADD CONSTRAINT `fk_profesor_rol` FOREIGN KEY (`fk_id_rolp`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
