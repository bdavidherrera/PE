
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
<title>ActualizarAnteproyectoCor</title>
</head>
<body>


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

<div class="container mt-5">
       
            
        <sql:query dataSource="${anteproyecto}" var="anteproyectoActual">
            SELECT * FROM anteproyecto WHERE id = ?
            <sql:param value="${param.id}" />
        </sql:query>
        
        <c:forEach var="ante" items="${anteproyectoActual.rows}">
            <c:set var="directorChanged" value="${ante.identificaciondir != param.directorId}" />
            <c:set var="evaluadorChanged" value="${ante.fk_id_profesor != param.evaluadorId}" />
            <c:set var="estadoChanged" value="${ante.estadofinalcor != param.estadoFinal}" />
            <c:set var="radicadoAnte" value="${ante.radicadoant != param.radicadoAnteproyecto}"/>
            <c:set var="radicadoCom" value="${ante.radicaante != param.radicadoComite}" />
        </c:forEach>
        
        <c:if test="${not empty param.directorId && param.directorId != ''}">
            <sql:query dataSource="${anteproyecto}" var="directorData">
                SELECT * FROM profesoruts WHERE identificacionp = ?
                <sql:param value="${param.directorId}" />
            </sql:query>
            
            <c:forEach var="director" items="${directorData.rows}">
                <c:set var="nombreDirCompleto" value="${director.nombre} ${director.apellidos}" />
            </c:forEach>
        </c:if>
        
        <c:if test="${not empty param.evaluadorId && param.evaluadorId != ''}">
            <sql:query dataSource="${anteproyecto}" var="evaluadorData">
                SELECT * FROM profesoruts WHERE identificacionp = ?
                <sql:param value="${param.evaluadorId}" />
            </sql:query>
            
            <c:forEach var="evaluador" items="${evaluadorData.rows}">
                <c:set var="nombreEvaCompleto" value="${evaluador.nombre} ${evaluador.apellidos}" />
            </c:forEach>
        </c:if>

        <!----Actualizar la información del anteproyecto con el enlace del radicado del anteproyecto-->
        <c:if test="${not empty param.radicadoAnteproyecto}">
            <sql:update dataSource="${anteproyecto}" var="updateResult">
                UPDATE anteproyecto 
                SET 
                    identificaciondir = ?,
                    nombredir = ?,
                    fk_id_profesor = ?,
                    nombreeva = ?,
                    estadofinalcor = ?,
                    anteproyecto = ?

                WHERE id = ?
                <sql:param value="${empty param.directorId ? null : param.directorId}" />
                <sql:param value="${empty nombreDirCompleto ? anteproyectoActual.rows[0].nombredir : nombreDirCompleto}" />
                <sql:param value="${empty param.evaluadorId ? null : param.evaluadorId}" />
                <sql:param value="${empty nombreEvaCompleto ? anteproyectoActual.rows[0].nombreeva : nombreEvaCompleto}" />
                <sql:param value="${param.estadoFinal}" />
                <sql:param value="${param.radicadoAnteproyecto}" />
                <sql:param value="${param.id}" />
            </sql:update>
        </c:if>

        <!----Actualizar la información del anteproyecto con el enlace del radicado final del anteproyecto-->
        <c:if test="${not empty param.radicadoComite}">
            <sql:update dataSource="${anteproyecto}" var="updateResult">
                UPDATE anteproyecto 
                SET 
                    identificaciondir = ?,
                    nombredir = ?,
                    fk_id_profesor = ?,
                    nombreeva = ?,
                    estadofinalcor = ?,
                    radicaante = ?

                WHERE id = ?
                <sql:param value="${empty param.directorId ? null : param.directorId}" />
                <sql:param value="${empty nombreDirCompleto ? anteproyectoActual.rows[0].nombredir : nombreDirCompleto}" />
                <sql:param value="${empty param.evaluadorId ? null : param.evaluadorId}" />
                <sql:param value="${empty nombreEvaCompleto ? anteproyectoActual.rows[0].nombreeva : nombreEvaCompleto}" />
                <sql:param value="${param.estadoFinal}" />
                <sql:param value="${param.radicadoComite}" />
                <sql:param value="${param.id}" />
            </sql:update>
        </c:if>

      
        <div class="alert alert-success">
            <h4>Anteproyecto actualizado correctamente</h4>
            
            <c:if test="${updateResult >= 1}">
                <p>Los datos del anteproyecto han sido actualizados exitosamente.</p>
                
                <c:if test="${directorChanged}">
                    <p>Se ha actualizado el director del anteproyecto.</p>
                </c:if>
                
                <c:if test="${evaluadorChanged}">
                    <p>Se ha actualizado el evaluador del anteproyecto.</p>
                </c:if>
                
                <c:if test="${estadoChanged}">
                    <p>Se ha actualizado el estado del anteproyecto a: <strong>${param.estadoFinal}</strong></p>
                </c:if>

                
                <c:if test="${radicadoAnte}">
                    <p>Se ha registrado en enlace del radico del anteproyecto.</p>
                </c:if>

                <c:if test="${radicadoCom}">
                    <p>Se ha registrado en enlace del radico del comite del anteproyecto.</p>
                </c:if>

            </c:if>
            
            <div class="mt-4">
                <a href="gestionarAnteproyectoC.jsp?id=${param.id}" class="btn btn-primary">Volver a Gestión del Anteproyecto</a>
            </div>
        </div>
    </div>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>