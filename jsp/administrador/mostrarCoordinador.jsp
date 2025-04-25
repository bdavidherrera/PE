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
<link rel="stylesheet" href="../../css/mostrarUsuarios.css">
<title>MostrarCoordinador</title>
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
                        <a class="nav-link" href="administradorMenu.jsp"><i class="fas fa-home mr-1"></i> Regresar </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1" ></i> Cerrar Sesión</a>
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
                            <h2 class="title-with-underline">Mostrar Coordinadores</h2>
                            <p class="text-muted mt-3">Actualización y elimininación de Coordinadores</p>
                        </div>
                        
                        <div id="tabla-contenido" class="mt-4">
                            <div class="table-responsive">
                                <table class="table table-custom table-hover">
                                    <thead>
                                        <tr>
                                            <th>Cédula</th>
                                            <th>Nombre Completo</th>
                                            <th>Contraseña</th>
                                            <th>Numero de su rol</th>
                                            <th class="text-center">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="result" scope="request" dataSource="${anteproyecto}">
                                            SELECT * FROM coordinador 
                                        </sql:query>
                                        
                                        <c:forEach var="fila" items="${result.rows}">
                                            <tr>
                                                <td><c:out value="${fila.noidentificacionc}" /></td>
                                                <td><c:out value="${fila.nombre}" /> <c:out value="${fila.apellidos}" /> </td>
                                                <td><c:out value="${fila.password}" /></td>
                                                <td><c:out value="${fila.fk_id_rolc}" /></td>
                                                <td class="text-center">
                                                    <a href="updateCoordinador.jsp?id=<c:out value='${fila.noidentificacionc}' />" class="btn action-btn edit-btn">
                                                        <i class="fas fa-edit"></i> Editar
                                                    </a>
                                                    <a href="vorrarCoordinador.jsp?id=<c:out value='${fila.noidentificacionc}' />" class="btn action-btn delete-btn">
                                                        <i class="fas fa-trash-alt"></i> Eliminar
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="text-center mt-4">
                                        <a href="insertarCoordinador.jsp" class="btn new-btn">
                                            <i class="fas fa-home mr-1"></i>Regresar
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