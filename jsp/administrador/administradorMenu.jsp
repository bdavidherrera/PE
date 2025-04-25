
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
<link rel="stylesheet" href="../../css/styleMenuGCD.css">
<title>adminMenuA</title>
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

    <div class="container">
        <div class="welcome-banner">
            <h2><i class="fas fa-graduation-cap mr-2"></i>Sistema de Gestión de Usuarios - Administración</h2>
            <p class="mb-0">Bienvenido al portal de Administración de las Unidades Tecnológicas de Santander.</p>
            <p>${sessionScope.usuarioNombre},  CC: ${sessionScope.usuarioIdentificacionAndmin}</p> 
            <a href="../calendarioAcademico.jsp" class="btn btn-primary"><i class="far fa-calendar-check"></i>Acceder calendario académico</a>
            <a href="https://www.dropbox.com/scl/fo/pudgcaq639agy7t06ahjs/AN084HnuyHffgYL5i--v_Ks/DOCUMENTOS%20DE%20GRADO?rlkey=6s0b9ajweteyx2ang7ywvk6xm&e=1&subfolder_nav_tracking=1&st=xb70051k&dl=0" 
            target="_blank" class="btn btn-primary"><i class="fas fa-file-signature"></i>Acceder Documentos de Grado</a>
        </div>
        
        <h2 class="page-title">Panel de Control</h2>
        
        <div class="row">
            <!-- Card 1: Administración de Docentes -->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-chalkboard-teacher"></i> Docentes
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        <h5 class="card-title">Administración de Docentes</h5>
                        <p class="card-text">Sección para crear docentes con rol de evaluador y director, modificación completa de su información y eliminación del docente de la base de datos.</p>
                        <a href="insertarDocente.jsp" class="btn btn-primary"><i class="fas fa-search mr-2"></i>Acceder</a>
                    </div>
                </div>
            </div>
            
            <!-- Card 2: Administración de Coordinador-->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-user-tie"></i>Coordinación
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h5 class="card-title">Administración de coordinación </h5>
                        <p class="card-text">Sección para crear coordinares/as con rol coordinador, modificación completa de su información y eliminación del coordinares/as de la base de datos.</p>
                        <a href="insertarCoordinador.jsp" class="btn btn-primary"><i class="fas fa-search mr-2"></i>Acceder</a>
                    </div>
                </div>
            </div>
            
            <!-- Card 3: Administración de Estudiante -->
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-user-graduate"></i>Estudiantes
                    </div>
                    <div class="card-body text-center">
                        <div class="card-icon">
                            <i class="fas fa-user-graduate"></i>
                        </div>
                        <h5 class="card-title">Administración de Estudiantes</h5>
                        <p class="card-text">Sección para crear Estudiantes con rol estudiante, modificación completa de su información y eliminación del estudiantes de la base de datos.</p>
                        <a href="insertarEstudiante.jsp"  class="btn btn-primary"><i class="fas fa-search mr-2"></i>Acceder</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer mt-auto py-3">
        <div class="container text-center">
            <small>&copy; 2025 Unidades Tecnológicas de Santander -Brayan David Herrera Barajas B191P- Todos los derechos reservados</small>
        </div>
    </footer>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>