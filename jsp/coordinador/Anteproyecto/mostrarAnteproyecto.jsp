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
<link rel="stylesheet" href="../../../css/mostrarUsuarios.css">
<title>MostrarAnteproyectos</title>
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
                        <a class="nav-link" href="../AnteProyectoCoor.jsp"><i class="fas fa-home mr-1"></i> Regresar </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1" ></i> Cerrar Sesión</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

     <main id="ejercicios" class="flex-grow-1 py-5">
        <div class="container">
            <div id="tabla-empleados" class="p-4 p-md-5  shadow-lg">
                <div class="row">
                    <div class="col-12">
                        <div id="tabla-header" class="mb-4">
                            <h2 class="title-with-underline">Mostrar Anteproyectos</h2>
                            <p class="text-muted mt-3">Puedes seleccionar docentes o evaluadores, ver el historial de versiones y dar la calificación final</p>
                        </div>
                        
                        <div id="tabla-contenido" class="mt-4">
                            <div class="table-responsive">
                                <table class="table table-custom table-hover">
                                    <thead>
                                        <tr>
                                            <th>Identificación</th>
                                            <th>Nombre del anteproyecto</th>
                                            <th>Nombre Completo del estudiante</th>
                                            <th>semestre</th>
                                            <th>Anteproyecto (Enlace) </th>

                                            <th>Director asignado</th>
                                            <th>calificación director</th>
                                            <th>Radicado anteproyecto (enlace)</th>
                                            <th>Evaluador asignado</th>
                                            <th>calificacion evaluador</th>
                                            <th>Estado Final del anteproyecto</th>
                                            <th>Radicado comite anteproyecto (enlace)</th>

                                            <th class="text-center">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="result" scope="request" dataSource="${anteproyecto}">
                                            SELECT * FROM anteproyecto 
                                        </sql:query>
                                        
                                        <c:forEach var="fila" items="${result.rows}">
                                            <tr>
                                                <td><c:out value="${fila.id}" /></td>
                                                <td><c:out value="${fila.nombreidea}" /> 
                                                <td><c:out value="${fila.nombrees}" /> <c:out value="${fila.apellidoes}" /> </td>
                                                <td><c:out value="${fila.semestrees}" /> </td>
                                                <td><a href= "<c:out value="${fila.anteproyecto}" />" target="_blank">${fila.anteproyecto}</a></td>
                                                <td><c:out value="${fila.nombredir}" /> 
                                                <td><c:out value="${fila.calificaciondir}"/>
                                                <td><a href="<c:out value="${fila.radicadoant}" />" target = "_blank"> ${fila.radicadoant}</a></td>
                                                <td><c:out value="${fila.nombreeva}" /></td>
                                                <td><c:out value="${fila.calificacioneva}" /></td>
                                                <td><c:out value="${fila.estadofinalcor}" /></td>
                                                <td><a href="<c:out value="${fila.radicaante}" />" target = "_blank">${fila.radicaante}</a></td>

                                            <c:if test="${fila.radicaante == 'Sin adjuntar'}">
                                                <td class="text-center">
                                                    <a href="gestionarAnteproyectoC.jsp?id=<c:out value='${fila.id}' /> " 
                                                    class="btn action-btn edit-btn">
                                                        <i class="fas fa-edit"></i> Gestionar
                                                    </a>
                                                </td>
                                            </c:if>
                                            
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="text-center mt-4">
                                        <a href="../AnteProyectoCoor.jsp" class="btn new-btn">
                                            <i class="fas fa-home mr-1"></i>Regresar
                                        </a>

                                        <a href="../../mostrarhistorialversiones.jsp" class="btn action-btn delete-btn">
                                                        <i class="fas fa-edit"></i> Historial versiones
                                        </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>