
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<%
    if (session != null && session.getAttribute("noidentificacion") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<sql:query var="mostrarIdeaEstudiante"  dataSource="${anteproyecto}">
SELECT * FROM anteproyecto WHERE fk_id_estudiante=${sessionScope.noidentificacion};
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
<link rel="stylesheet" href="../../css/styleMenuGCD.css">
<title>Estudiante</title>
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
                        <a class="nav-link" href="estudianteMenu.jsp"><i class="fas fa-home mr-1"></i> Inicio</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1"></i> Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="welcome-banner">
            <h2><i class="fas fa-graduation-cap mr-2"></i>Sistema de Gestión Académica de anteproyectos - Estudiante</h2>
            <p>${sessionScope.nombreEstudiante} ${sessionScope.apellidosEstudiante}, CC: ${sessionScope.noidentificacion}</p> 
        </div>
        
        <h2 class="page-title">Panel de Control</h2>
        <div class="row">

            <!-- Card 1: Gestión de anteProyectos -->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-project-diagram mr-2"></i>Gestion de anteproyectos
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-project-diagram"></i>
                        </div>
                        <h5 class="card-title"> idea de anteproyecto</h5>
                        <p class="card-text">En esta sección selecciona la idea de tu anteproyecto y completa tu informacion</p>
                        <a href="Anteproyecto/gestionarAnteproyectoE.jsp" class="btn btn-primary"><i class="fas fa-clipboard-list mr-2"></i>Acceder</a>
                    </div>
                </div>
            </div>
            

            <c:if test="${not empty mostrarIdeaEstudiante.rows}">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-tasks mr-2"></i>Historial de Tu anteProyecto
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-tasks"></i>
                        </div>
                        <h5 class="card-title">Consulta el Historial del anteproyecto </h5>
                        <p class="card-text">En esta sección puedes ver las diferentes recomendaciones que se hicieron de tu anteproyecto</p>
                        <a href="../mostrarhistorialversiones.jsp"  class="btn btn-primary"><i class="fas fa-search mr-2"></i>Consultar</a>
                    </div>
                </div>
            </div>
            </c:if>


                <c:if test="${not empty mostrarIdeaEstudiante.rows}">
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-header">
                                <i class="fas fa-tasks mr-2"></i>Mostrar de tu anteProyecto
                            </div>
                            <div class="card-body text-center">
                                <div class="card-icon">
                                    <i class="fas fa-tasks"></i>
                                </div>
                                <h5 class="card-title">Consulta el Anteproyecto</h5>
                                <p class="card-text">Ver como va tu ante proyecto</p>
                                <a href="Anteproyecto/mostrarAnteproyecto.jsp"  class="btn btn-primary"><i class="fas fa-search mr-2"></i>Consultar</a>
                            </div>
                        </div>
                    </div>
                </c:if>


        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer mt-auto py-3">
        <div class="container text-center">
            <small>&copy; 2025 Unidades Tecnológicas de Santander. Todos los derechos reservados</small>
        </div>
    </footer>




<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>