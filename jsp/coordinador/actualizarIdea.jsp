<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>
<%
    if (session != null && session.getAttribute("noidentificacionc") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<sql:query var="ideaSeleccionada" dataSource="${anteproyecto}">
    SELECT * FROM idea WHERE id = ?
    <sql:param value="${param.id}" />
</sql:query>

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
<title>ActualizarIdea</title>
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
                    <a class="nav-link" href="AnteProyectoCoor.jsp"><i class="fas fa-home mr-1"></i> Inicio</a>
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
                    <h3 class="text-center mb-4 text-primary">Actualizar Idea</h3>
                    <form method="post">
                        <input type="hidden" name="id" value="${param.id}">
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre de la idea</label>
                            <input type="text" class="form-control" name="nombre" value="${ideaSeleccionada.rows[0].nombre}" required>
                        </div>
                        <div class="button-group">
                            <button type="submit" class="btn btn-primary w-100" value="1" name="evaluar">Actualizar idea</button>
                        </div>
                    </form>
                    
                    <div class="button-group mt-3">
                        <a href="ideaAnteproyecto.jsp" class="btn btn-primary w-100">Regresar</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${param.evaluar == '1'}">
    <sql:query var="verificarNombre" dataSource="${anteproyecto}">
        SELECT COUNT(*) AS total FROM idea WHERE nombre = ? AND id != ?
        <sql:param value="${param.nombre}" />
        <sql:param value="${param.id}" />
    </sql:query>

    <c:set var="repetido" value="${verificarNombre.rows[0].total}" />

    <c:choose>
        <c:when test="${repetido == 0}">
            <sql:update var="resultado" dataSource="${anteproyecto}">
                UPDATE idea SET nombre = ? WHERE id = ?
                <sql:param value="${param.nombre}" />
                <sql:param value="${param.id}" />
            </sql:update>

            <c:if test="${resultado == 1}">
                <script>
                    alert("¡Idea actualizada correctamente!");
                    window.location.href = "ideaAnteproyecto.jsp";
                </script>
            </c:if>
        </c:when>

        <c:otherwise>
            <script>
                alert("El nombre ya existe. Intenta con otro.");
                window.history.back();
            </script>
        </c:otherwise>
    </c:choose>
</c:if>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>