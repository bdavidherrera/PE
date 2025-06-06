<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<%
   String evaluar = request.getParameter("evaluar");
%>

<%
    if (session != null && session.getAttribute("usuarioAdmin") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<c:if test="${not empty param.identificacionp}">
   
   <sql:query var="verificacion" dataSource="${anteproyecto}">
    SELECT 1 WHERE
    EXISTS (SELECT 1 FROM administrador WHERE identificacion = ? OR password = ?  OR usuario= ? ) OR
    EXISTS (SELECT 1 FROM coordinador WHERE noidentificacionc = ? OR password = ?  ) OR
    EXISTS (SELECT 1 FROM estudianteuts WHERE noidentificacion = ? OR password = ? OR correo= ?) OR
    EXISTS (SELECT 1 FROM profesoruts WHERE identificacionp = ? OR password = ? OR correo= ?) OR
    EXISTS (SELECT 1 FROM anteproyecto WHERE identificaciondir = ?);
    <sql:param value="${param.identificacionp}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.correo}"/>
    <sql:param value="${param.identificacionp}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.identificacionp}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.correo}"/>
    <sql:param value="${param.identificacionp}" />
    <sql:param value="${param.password}" />
    <sql:param value="${param.correo}"/>
    <sql:param value="${param.identificacionp}" />
    </sql:query>
    
    <c:choose>
        <c:when test="${verificacion.rowCount == 0}">
            <sql:update var="result" dataSource="${anteproyecto}">
                INSERT INTO profesoruts (identificacionp, nombre, apellidos, correo, password, titulos, fk_id_rolp)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                <sql:param value="${param.identificacionp}" />
                <sql:param value="${param.nombre}" />
                <sql:param value="${param.apellidos}" />
                <sql:param value="${param.correo}"/>
                <sql:param value="${param.password}" />
                <sql:param value="${param.titulos}" />
                <sql:param value="${param.fk_id_rolp}" />
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
<title>InsertarDoncetes</title>
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

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-lg border-0 rounded-4">
                <div class="card-body p-5">
                    <h3 class="text-center mb-4 text-primary">Insertar Docente</h3>
                    <form method="post">
                        <div class="mb-3">
                            <label for="identificacionp" class="form-label">Identificación</label>
                            <input type="number" class="form-control" name="identificacionp" required>
                        </div>
                        <div class="mb-3">
                            <label for="nombre" class="form-label">Nombre</label>
                            <input type="text" class="form-control" name="nombre" required>
                        </div>
                        <div class="mb-3">
                            <label for="apellidos" class="form-label">Apellidos</label>
                            <input type="text" class="form-control" name="apellidos" required>
                        </div>
                        <div class="mb-3">
                            <label for="correo" class="form-label">Correo</label>
                            <input type="email" class="form-control" name="correo" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>

                        <div class="mb-3">
                            <label for="titulos" class="form-label">Titulos</label>
                            <textarea class="form-control" name="titulos" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="fk_id_rolp" class="form-label">Rol del docente</label>
                             <sql:query var="rolesDocente" dataSource="${anteproyecto}">
                                            SELECT * FROM roles WHERE roles.id IN (4,5);
                            </sql:query>
                            <select class="custom-select form-control-lg rounded-pill" name="fk_id_rolp" required>
                                            <option value="">-- Seleccione --</option>
                                            <c:forEach var="item" items="${rolesDocente.rows}">
                                                <option value="${item.id}">
                                                    <c:out value="${item.nombre}" />
                                                </option>
                                            </c:forEach>
                            </select>
                            <div class="invalid-feedback">Por favor seleccione un rol.</div>                       
                        </div>

                        <div class="button-group">
                        <button type="submit" class="btn btn-primary w-100" value="1" name="evaluar">Registrar Docente</button>
                        </div>
                    </form>
                            <div class="button-group">
                            <a href="mostrarDocente.jsp" class="btn btn-primary w-100">Mostrar Docente</a>
                            </div>

                            <div class="button-group">
                            <a href="administradorMenu.jsp" class="btn btn-primary w-100">Regresar</a>
                            </div>
                            
                    <c:if test="${result >= 1}">
                        <div class="alert alert-success mt-4 text-center">
                            ¡Docente registrado exitosamente!
                            <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${param.evaluar=='1' && (not empty param.identificacionp && registroDuplicado)}">
                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                <i class="fas fa-exclamation-circle mr-2"></i> Datos en uso.
                                Ingresar otro numero de identificación, contraseña o correo.
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




<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>