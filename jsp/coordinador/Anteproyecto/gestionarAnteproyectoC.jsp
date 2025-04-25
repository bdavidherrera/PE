<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../../WEB-INF/jspConexion/conexion.jsp" %>
<%
    if (session != null && session.getAttribute("noidentificacionc") != null) {

    } else {

        response.sendRedirect("../../../index.jsp");
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
<link rel="stylesheet" href="../../../css/gestionarAnteproyectos.css">
<title>GetionarAnteproyecto</title>
</head>
<body>

<sql:query var="abilitarEnlace"  dataSource="${anteproyecto}">
SELECT radicaante FROM anteproyecto WHERE calificaciondir="aprobado" AND calificacioneva="aprobado" AND estadofinalcor="aprobado" AND id=?
<sql:param value="${param.id}" />
</sql:query>


<!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand">
                <img src="../../../img/Logo_Uts.png" alt="Logo UTS" class="mr-2">
            </a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="mostrarAnteproyecto.jsp"><i class="fas fa-home mr-1"></i> Regresar </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1" ></i> Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>



<!-- Contenido principal -->

     <div class="container mt-4">
        <h2 class="mb-4">Gestión de Anteproyecto</h2>
        
       
        <sql:query dataSource="${anteproyecto}" var="ante">
            SELECT * FROM anteproyecto WHERE id = ?
            <sql:param value="${param.id}" />
        </sql:query>
        
        <sql:query dataSource="${anteproyecto}" var="directores">
            SELECT p.* FROM profesoruts p 
            WHERE p.identificacionp > 0 AND p.fk_id_rolp = 4
            ORDER BY p.nombre
        </sql:query>
        
        <sql:query dataSource="${anteproyecto}" var="evaluadores">
            SELECT p.* FROM profesoruts p 
            WHERE p.identificacionp > 0 AND p.fk_id_rolp = 5
            ORDER BY p.nombre
        </sql:query>
        
        <c:forEach var="proyectoInfo" items="${ante.rows}">
            <form action="actualizarAnteproyecto.jsp" method="post">
                <input type="hidden" name="id" value="${proyectoInfo.id}">
                
                <!-- Información básica del anteproyecto -->
                <div class="card">
                    <div class="card-header section-header">
                        <h5>Información del Anteproyecto</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label"><strong>ID:</strong></label>
                                <span>${proyectoInfo.id}</span>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label"><strong>Nombre de la Idea:</strong></label>
                                <span>${proyectoInfo.nombreidea}</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Nombres de Estudiantes:</strong></label>
                                <span>${proyectoInfo.nombrees}</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Apellidos de Estudiantes:</strong></label>
                                <span>${proyectoInfo.apellidoes}</span>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Semestres:</strong></label>
                                <span>${proyectoInfo.semestrees}</span>
                            </div>
                        </div>
                    </div>
                </div>

                
                
                <!-- Selección de Director -->
                <div class="card">
                    <div class="card-header section-header">
                        <h5>Asignación de Director</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="director" class="form-label">Seleccione Director:</label>
                                <select class="form-select" id="director" name="directorId">
                                    <option value="">-- Seleccione un director --</option>
                                    <c:forEach var="director" items="${directores.rows}">
                                        <option value="${director.identificacionp}" 
                                            data-nombre="${director.nombre} ${director.apellidos}"
                                            ${proyectoInfo.identificaciondir == director.identificacionp ? 'selected' : ''}>
                                            ${director.nombre} ${director.apellidos}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Director Actual:</strong></label>
                                <span id="directorActual">${empty proyectoInfo.nombredir ? 'Sin asignar' : proyectoInfo.nombredir}</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Selección de Evaluador -->
                <div class="card">
                    <div class="card-header section-header">
                        <h5>Asignación de Evaluador</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="evaluador" class="form-label">Seleccione Evaluador:</label>
                                <select class="form-select" id="evaluador" name="evaluadorId">
                                    <option value="">-- Seleccione un evaluador --</option>
                                    <c:forEach var="evaluador" items="${evaluadores.rows}">
                                        <option value="${evaluador.identificacionp}" 
                                            data-nombre="${evaluador.nombre} ${evaluador.apellidos}"
                                            ${proyectoInfo.fk_id_profesor == evaluador.identificacionp ? 'selected' : ''}>
                                            ${evaluador.nombre} ${evaluador.apellidos}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Evaluador Actual:</strong></label>
                                <span id="evaluadorActual">${empty proyectoInfo.nombreeva ? 'Sin asignar' : proyectoInfo.nombreeva}</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Cambio de Estado del Anteproyecto -->
                <div class="card">
                    <div class="card-header section-header">
                        <h5>Estado del Anteproyecto</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="estado" class="form-label">Seleccione Estado:</label>
                                <select class="form-select" id="estado" name="estadoFinal">
                                    <option value="sin revisar" ${proyectoInfo.estadofinalcor == 'sin revisar' ? 'selected' : ''}>sin revisar</option>
                                    <option value="correciones" ${proyectoInfo.estadofinalcor == 'correciones' ? 'selected' : ''}>correciones</option>
                                    <option value="aprobado" ${proyectoInfo.estadofinalcor == 'aprobado' ? 'selected' : ''}>aprobado</option>
                                    <option value="no aprobado" ${proyectoInfo.estadofinalcor == 'no aprobado' ? 'selected' : ''}>no aprobado</option>
                                </select>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label class="form-label"><strong>Estado Actual:</strong></label>
                                <span id="estadoActual">${empty proyectoInfo.estadofinalcor ? 'Sin definir' : proyectoInfo.estadofinalcor}</span>
                            </div>
                        </div>
                    </div>
                </div>

                   <!--Enlaces del Coordinador-->
                 <div class="card">
                    <div class="card-header section-header">
                        <h5>Enlaces anteproyecto</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label"><strong>Radicado Anteproyecto Aceptado:</strong></label>
                                <input type="text" class="form-control" id="radicadoAnteproyecto" value="${proyectoInfo.radicadoant}" name="radicadoAnteproyecto">

                                <c:if test="${not empty abilitarEnlace.rows}">
                                    <label class="form-label"><strong>Radicado del comite:</strong></label>
                                    <input type="text" class="form-control" id="radicadoComite" value="${proyectoInfo.radicaante}" name="radicadoComite">
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>

             
                
                <!-- Botones de acción -->
                <div class="d-flex justify-content-between mt-4">
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <c:if test="${proyectoInfo.estadofinalcor == 'correciones'}">
                    <a href="historialVersiones.jsp?id=${proyectoInfo.id} &nombreAnteproyecto=<c:out value='${proyectoInfo.nombreidea}' />&urlproyecto=<c:out value='${proyectoInfo.anteproyecto}'/>" class="btn btn-secondary">Agregar Una Observación al Anteproyecto del estudiante</a>
                    </c:if>
                    <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary">Regresar</a>
                </div>
            </form>
        </c:forEach>
    </div>

  
    


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('form').submit(function(event) {
                var anteproyectoUrl = $('#radicadoAnteproyecto').val().trim();
                
                if (!anteproyectoUrl) {
                    alert('El enlace del anteproyecto es obligatorio.');
                    event.preventDefault();
                    return false;
                }
                
                function isValidUrl(url) {
                    if (!url) return true; 
                    try {
                        new URL(url);
                        return true;
                    } catch (_) {
                        return false;
                    }
                }
                
                if (!isValidUrl(anteproyectoUrl)) {
                    alert('El enlace del anteproyecto no es una URL válida.');
                    event.preventDefault();
                    return false;
                }
                
                var radicadoAntUrl = $('#radicadoComite').val().trim();
                if (radicadoAntUrl && !isValidUrl(radicadoAntUrl)) {
                    alert('El enlace del radicado no es una URL válida.');
                    event.preventDefault();
                    return false;
                }
            });
        });
    </script>
</body>
</html>