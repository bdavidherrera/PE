<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<c:choose>
    <c:when test="${sessionScope.roles == 1}">
        <c:set var="rol" value="administrador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 2}">
        <c:set var="rol" value="coordinador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 4}">
        <c:set var="rol" value="director" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 5}">
        <c:set var="rol" value="evaluador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 6}">
        <c:set var="rol" value="estudiante" scope="session" />
    </c:when>
    <c:otherwise>
        <c:set var="rol" value="desconocido" scope="session" />
    </c:otherwise>
</c:choose>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Enter your description here"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="../css/styleMenuGCD.css">
<title>CalendarioAcademico</title>
</head>
<body>

<!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand">
                <img src="../img/Logo_Uts.png" alt="Logo UTS" class="mr-2">
            </a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="${sessionScope.rol}/${sessionScope.rol}Menu.jsp"><i class="fas fa-home mr-1"></i> Inicio</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="welcome-banner">
            <h2><i class="fas fa-graduation-cap mr-2"></i> Calendario</h2>
            <p class="mb-0">En esta sección encontras el calendario academico presencial, su modificación y el calendario academico virtual del año 2025</p>
        </div>
        
        <h2 class="page-title">calendario Academico actual</h2>
        
        <div class="row">
            <!-- Card 1: Calendario Academico Virtual -->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="far fa-calendar-alt mr-2"></i>Calendario Virtual
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="far fa-calendar-check"></i>
                        </div>
                        <h5 class="card-title">Calendario Virtual</h5>
                        <p class="card-text">Se encuentra el calendario Virtual del Semestre-1</p>
                        <a href="https://www.uts.edu.co/sitio/acuerdo-03-046-calendario-academico-modalidad-virtual-i-semestre-2025/" class="btn btn-primary" target="_blank">
                        <i class="fas fa-clipboard-list mr-2" ></i>Consultar Calendario Virtual</a>
                    </div>
                </div>
            </div>
            
            <!-- Card 2: Calendario Académico Presencial-->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="far fa-calendar-alt mr-2"></i>Calendario Presencial
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="far fa-calendar-check"></i>
                        </div>
                        <h5 class="card-title">Consulta de Calendario actual</h5>
                        <p class="card-text">Se encuentra el calendario Presencial del Semestre-1 y la modificación</p>
                        <a href="https://www.uts.edu.co/sitio/wp-content/uploads/2019/10/Acuerdo-No.-03-006-Modificación-calendario-académico.pdf" class="btn btn-primary" target="_blank">
                        <i class="fas fa-clipboard-list mr-2" ></i>Consultar modificación I</a>
                        <p></p>
                        <a href="https://www.uts.edu.co/sitio/wp-content/uploads/2025/01/ACUERDO-03-001-MODIFICACION-CALENDARIO-ACADE-PRESENCIAL.pdf" class="btn btn-primary" target="_blank">
                        <i class="fas fa-clipboard-list mr-2" ></i>Consultar calendario</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer mt-auto py-3">
        <div class="container text-center">
            <small>&copy; 2025 Unidades Tecnológicas de Santander- Todos los derechos reservados</small>
        </div>
    </footer>




<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>