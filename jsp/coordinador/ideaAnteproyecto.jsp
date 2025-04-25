<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<%
   String evaluar = request.getParameter("evaluar");
%>



<%
    if (session != null && session.getAttribute("noidentificacionc") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>


<c:set var="actualizarIdea" value="Registra" />




<c:if test="${not empty param.nombre}">
   
   <sql:query var="verificacion" dataSource="${anteproyecto}">
    SELECT 1 WHERE
    EXISTS (SELECT 1 FROM idea WHERE nombre = ?);
    <sql:param value="${param.nombre}" />
    </sql:query>
    
    <c:choose>
        <c:when test="${verificacion.rowCount == 0}">
            <sql:update var="result" dataSource="${anteproyecto}">
                INSERT INTO idea (nombre)
                VALUES (?)
                <sql:param value="${param.nombre}" />
            </sql:update>
            <c:set var="registroExitoso" value="true" />
        </c:when>
        <c:otherwise>
            <c:set var="registroDuplicado" value="true" />
        </c:otherwise>
    </c:choose>
</c:if>





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
<title>InsertarIdea</title>
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
                    <h3 class="text-center mb-4 text-primary">${actualizarIdea} -- ideas</h3>
                    <p class="text-center text-primary">Bienvenidos al banco de ideas</p>
                    <form method="post">
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre de la idea</label>
                            <input type="text" class="form-control" name="nombre" row='7' required>
                        </div>
                        <div class="button-group">
                        <button type="submit" class="btn btn-primary w-100" value="1" name="evaluar">${actualizarIdea} idea </button>
                        </div>
                    </form>
                            <div class="button-group">
                            <button type="button" class="btn btn-primary w-100" data-toggle="modal" data-target="#modalAdmins">Ver ideas </button>
                            </div>

                            <div class="button-group">
                            <a href="AnteProyectoCoor.jsp" class="btn btn-primary w-100">Regresar</a>
                            </div>
                            
                    <c:if test="${result >= 1}">
                        <div class="alert alert-success mt-4 text-center">
                            ¡idea registrada exitosamente!
                            <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${param.evaluar=='1' && (not empty param.nombre && registroDuplicado)}">
                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                <i class="fas fa-exclamation-circle mr-2"></i> Ya se creo esta idea.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                        <span aria-hidden="true">&times;</span>
                                            <c:set var="registroDuplicado" value="false" />
                                </button>
                            </div>
                        </c:if>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- MODAL: ideas creadas -->
        <div class="modal fade" id="modalAdmins" tabindex="-1" role="dialog" aria-labelledby="modalAdminsLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAdminsLabel">Ideas creadas</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true" >&times;</span>
                        </button>
                        </div>
                            <div class="modal-body">
                                <table class="table table-bordered table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Id</th>
                                            <th>nombre</th>
                                            <th>Aciones</th>
                                        </tr>
                                    </thead>
                                    <sql:query var="ideas" dataSource="${anteproyecto}">
                                        SELECT * FROM idea
                                    </sql:query>
                                <tbody>
                                    <c:forEach var="ideasCreadas" items="${ideas.rows}">
                                        <tr>
                                            <td>${ideasCreadas.id}</td>
                                            <td>${ideasCreadas.nombre}</td>
                                            <td class="text-center">
                                            <form method="post">
                                                <input type="hidden" name="idEliminar" value="${ideasCreadas.id}" />
                                                <button type="submit" class="btn btn-secondary">Eliminar</button>
                                            </form>
                                                <a href="actualizarIdea.jsp?id=<c:out value='${ideasCreadas.id}' />" class="btn btn-secondary accion-btn">
                                                Editar
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        </div>
                        </div>
                    </div>
                </div>



                <c:if test="${not empty param.idEliminar}">
                    <c:set var="idEliminar" value="${param.idEliminar}" />
                        <sql:update var="result" dataSource="${anteproyecto}">
                            DELETE FROM idea WHERE id = ?
                            <sql:param value="${idEliminar}" />
                        </sql:update>

                        <c:if test="${result == 1}">
                            <script>
                                alert("Eliminación exitosa.");
                                window.location.href = "ideaAnteproyecto.jsp";
                            </script>
                        </c:if>
                </c:if>




<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>