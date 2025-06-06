<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>


<%
    if (session != null && session.getAttribute("usuarioAdmin") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Enter your description here"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="../../css/insertarUsuarios.css">
<title>ActualizarEstudiante</title>
</head>
<body>

<!-- Barra de navegación -->
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand">
            <img src="../../img/Logo_Uts.png" alt="Logo UTS" class="mr-2">
        </a>
        
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="administradorMenu.jsp"><i class="fas fa-home mr-1"></i> Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1" ></i> Cerrar Sesión</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <h3 class="text-center mb-4 text-primary">Actualizar Estudiantes </h3>
                    
                    <c:if test="${param.modifica != null}">
                        <c:choose>
                            <c:when test="${param.noidentificacion != param.noidentificacion_originales}">
                                <sql:query var="verificacion" dataSource="${anteproyecto}">
                                    SELECT 1 WHERE
                                    EXISTS (SELECT 1 FROM administrador WHERE identificacion = ? OR password = ?) OR
                                    EXISTS (SELECT 1 FROM estudianteuts WHERE noidentificacion = ? AND noidentificacion != ? OR password = ?) OR 
                                    EXISTS (SELECT 1 FROM coordinador WHERE noidentificacionc = ? OR password = ?) OR
                                    EXISTS (SELECT 1 FROM profesoruts WHERE identificacionp = ? OR password = ?) OR
                                    EXISTS (SELECT 1 FROM anteproyecto WHERE identificaciondir = ?);
                                    <sql:param value="${param.noidentificacion}" />
                                    <sql:param value="${param.password}" />
                                    <sql:param value="${param.noidentificacion}" />
                                    <sql:param value="${param.noidentificacion_originales}" />
                                    <sql:param value="${param.password}" />
                                    <sql:param value="${param.noidentificacion}" />
                                    <sql:param value="${param.password}" />
                                    <sql:param value="${param.noidentificacion}" />
                                    <sql:param value="${param.password}" />
                                    <sql:param value="${param.noidentificacion}" />
                                </sql:query>
                                
                                <c:choose>
                                    <c:when test="${verificacion.rowCount > 0}">
                                        <c:set var="mostrarError" value="true" scope="request"/>
                                    </c:when>
                                    <c:otherwise>
                                        <sql:update var="result" dataSource="${anteproyecto}">
                                            UPDATE estudianteuts
                                            SET noidentificacion = ?,
                                                nombre = ?,
                                                apellidos = ?,
                                                carrera = ?,
                                                semestre = ?,
                                                correo= ?,
                                                password = ?
                                            WHERE noidentificacion = ?
                                            <sql:param value="${param.noidentificacion}" />
                                            <sql:param value="${param.nombre}" />
                                            <sql:param value="${param.apellidos}" />
                                            <sql:param value="${param.carrera}" />
                                            <sql:param value="${param.semestre}" />
                                            <sql:param value="${param.correo}" />
                                            <sql:param value="${param.password}" />
                                            <sql:param value="${param.noidentificacion_originales}" />
                                        </sql:update>
                                        
                                        <c:if test="${result >= 1}">
                                            <div class="alert alert-success mt-4 text-center">
                                                ¡estudiante actualizado exitosamente!
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="button-group mt-3">
                                                <a href="mostrarEstudiante.jsp" class="btn btn-primary w-100">Regresar a la lista</a>
                                            </div>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <sql:update var="result" dataSource="${anteproyecto}">
                                    UPDATE estudianteuts
                                    SET nombre = ?,
                                        apellidos = ?,
                                        carrera = ?,
                                        semestre = ?,
                                        correo= ?,
                                        password = ?
                                    WHERE noidentificacion = ?
                                    <sql:param value="${param.nombre}" />
                                    <sql:param value="${param.apellidos}" />
                                    <sql:param value="${param.carrera}" />
                                    <sql:param value="${param.semestre}" />
                                    <sql:param value="${param.correo}" />
                                    <sql:param value="${param.password}" />
                                    <sql:param value="${param.noidentificacion_originales}" />
                                </sql:update>
                                
                                <c:if test="${result >= 1}">
                                    <div class="alert alert-success mt-4 text-center">
                                        !estudiante actualizado exitosamente!
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="button-group mt-3">
                                        <a href="mostrarEstudiante.jsp" class="btn btn-primary w-100">Regresar a la lista</a>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                    
                    <c:if test="${mostrarError == true || param.modifica == null}">
                        <sql:query var="estudiante" dataSource="${anteproyecto}">
                            SELECT * FROM estudianteuts WHERE noidentificacion = ?
                            <sql:param value="${param.id != null ? param.id : param.noidentificacion_originales}"/>
                        </sql:query>
                        
                        <form method="post" class="needs-validation">
                            <c:forEach var="item" items="${estudiante.rows}">
                                <input type="hidden" name="noidentificacion_originales" value="${item.noidentificacion}"/>
                                
                                <div class="mb-3">
                                    <label for="noidentificacion" class="form-label">Identificación</label>
                                    <input type="number" class="form-control" name="noidentificacion" value="${param.noidentificacion != null ? param.noidentificacion : item.noidentificacion}" readonly required>
                                </div>
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre</label>
                                    <input type="text" class="form-control" name="nombre" value="${param.nombre != null ? param.nombre : item.nombre}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="apellidos" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" name="apellidos" value="${param.apellidos != null ? param.apellidos : item.apellidos}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="carrera" class="form-label">carrera</label>
                                    <textarea class="form-control" name="carrera" rows="2" required>${param.carrera != null ? param.carrera : item.carrera}</textarea>
                                </div>
                                 <div class="mb-3">
                                    <label for="semestre" class="form-label">Semestre</label>
                                    <input type="text" class="form-control" name="semestre" value="${param.semestre != null ? param.semestre : item.semestre}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="correo" class="form-label">Correo</label>
                                    <input type="text" class="form-control" name="correo" value="${param.correo != null ? param.correo : item.correo}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" name="password" value="${param.password != null ? param.password : item.password}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="fk_id_rol" class="form-label">Rol</label>
                                    <input type="number" class="form-control" name="fk_id_rol" value="${item.fk_id_rol}" readonly>
                                    <small class="form-text text-muted">El rol no puede ser modificado</small>
                                </div>
                                
                                <div class="button-group">
                                    <button type="submit" class="btn btn-primary w-100">Actualizar estudiante</button>
                                    <input type="hidden" name="modifica" value="SI"/>
                                </div>
                            </c:forEach>
                        </form>
                        
                        
                        
                        <div class="button-group mt-3">
                            <a href="mostrarEstudiante.jsp" class="btn btn-primary w-100">Regresar</a>
                        </div>
                        
                        <div class="button-group mt-3">
                            <a href="administradorMenu.jsp" class="btn btn-primary w-100">Inicio</a>
                        </div>

                        <c:if test="${mostrarError == true}">
                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                <i class="fas fa-exclamation-circle mr-2"></i> Datos en uso. La identificación o contraseña ya está registrada.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>