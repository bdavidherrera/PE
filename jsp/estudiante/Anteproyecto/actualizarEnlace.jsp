<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="../../../WEB-INF/jspConexion/conexion.jsp" %>

<%
   String actualizar = request.getParameter("actualizar");
   String id = request.getParameter("id");
%>
<%
    if (session != null && session.getAttribute("noidentificacion") != null) {

    } else {

        response.sendRedirect("../../../index.jsp");
    }
%>
<sql:query var="anteproyectoData" dataSource="${anteproyecto}">
    SELECT * FROM anteproyecto WHERE id = ?
    <sql:param value="${param.id}" />
</sql:query>


<c:if test="${not empty param.actualizar && not empty param.id}">
    <sql:update var="result" dataSource="${anteproyecto}">
        UPDATE anteproyecto 
        SET anteproyecto = ?, radicadoant = ?
        WHERE id = ?
        <sql:param value="${param.anteproyecto_url}" />
        <sql:param value="${param.radicadoant_url}" />
        <sql:param value="${param.id}" />
    </sql:update>
    
    <c:if test="${result >= 1}">
        <c:set var="actualizacionExitosa" value="true" />
    </c:if>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Formulario para actualizar enlaces de anteproyecto"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="../../../css/gestionarAnteproyectos.css">
    <title>Actualizar Enlaces </title>
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

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-header">
                        <h3 class="text-center text-white mb-0">Actualizar Enlaces de Anteproyecto</h3>
                    </div>
                    <div class="card-body p-5">
                        
                        <c:if test="${actualizacionExitosa}">
                            <div class="alert alert-success alert-dismissible fade show mb-4">
                                <i class="fas fa-check-circle mr-2"></i> ¡Enlaces actualizados exitosamente!
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        
                        <c:forEach var="proyecto" items="${anteproyectoData.rows}">
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="bg-light p-3 rounded mb-3">
                                        <h5 class="mb-3 text-primary-dark">Información del Anteproyecto</h5>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong>ID:</strong> ${proyecto.id}</p>
                                                <p><strong>Nombre de la Idea:</strong> ${proyecto.nombreidea}</p>
                                            </div>
                                            <div class="col-md-6">
                                                <p><strong>Estudiante:</strong> ${proyecto.nombrees} ${proyecto.apellidoes}</p>
                                                <p><strong>Semestre:</strong> ${proyecto.semestrees}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <form method="post" action="">
                                <input type="hidden" name="id" value="${proyecto.id}">
                                
                                <div class="mb-4">
                                    <label for="anteproyecto_url" class="form-label">Enlace de Anteproyecto</label>
                                    <input type="text" class="form-control" id="anteproyecto_url" name="anteproyecto_url" 
                                        value="${proyecto.anteproyecto}" placeholder="Ingrese URL del anteproyecto" required>
                                    <small class="text-muted">Ingrese el enlace completo del documento (Google Drive, OneDrive, etc.)</small>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="radicadoant_url" class="form-label">Enlace de Radicado del Anteproyecto</label>
                                    <input type="text" class="form-control" id="radicadoant_url" name="radicadoant_url" 
                                        value="${proyecto.radicadoant}" placeholder="Ingrese URL del radicado">
                                    <small class="text-muted">Ingrese el enlace completo del documento radicado</small>
                                </div>
                                 
                                <div class="d-flex justify-content-between mt-4">
                                    <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left mr-2"></i>Cancelar
                                    </a>
                                    <button type="submit" name="actualizar" value="1" class="btn btn-primary">
                                        <i class="fas fa-save mr-2"></i>Guardar Cambios
                                    </button>
                                    <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left mr-2"></i>Atras
                                    </a>
                                </div>
                            </form>
                        </c:forEach>
                        
                        <c:if test="${empty anteproyectoData.rows}">
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle mr-2"></i> No se encontró el anteproyecto con el ID especificado.
                            </div>
                            <div class="text-center mt-4">
                                <a href="mostrarAnteproyecto.jsp" class="btn btn-primary">Volver a la lista de anteproyectos</a>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
    
    <script>
        $(document).ready(function() {
            $('form').submit(function(event) {
                var anteproyectoUrl = $('#anteproyecto_url').val().trim();
                
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
                
                var radicadoAntUrl = $('#radicadoant_url').val().trim();
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