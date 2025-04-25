<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../WEB-INF/jspConexion/conexion.jsp" %>

<%
    String identificaciondir = request.getParameter("identificaciondir");
    String password = request.getParameter("password");
    String evaluar = request.getParameter("evaluar");

%>

<sql:query var="login" dataSource="${anteproyecto}">

    SELECT profesoruts.*
    FROM anteproyecto
    JOIN profesoruts ON anteproyecto.identificaciondir = profesoruts.identificacionp
    WHERE anteproyecto.identificaciondir = ? AND profesoruts.password=?;

    <sql:param value="<%= identificaciondir %>" />
    <sql:param value="<%= password %>" />
</sql:query>


<c:if test="${not empty login.rows}">
    <c:set var="director" value="${login.rows[0]}" />
    <c:set var="identificacionDirector" value="${director.identificacionp}" scope="session" />
    <c:set var="nombreDir" value="${director.nombre}" scope="session" />
    <c:set var="apellidosDir" value="${director.apellidos}" scope="session" />
</c:if>

<c:if test="${not empty login.rows}">
    <c:set var="rol" value="${login.rows[0]}" />
    <c:set var="roles" value="${rol.fk_id_rolp}" scope="session" />
</c:if>



<sql:query var="admins" dataSource="${anteproyecto}">
    SELECT DISTINCT profesoruts.*
    FROM anteproyecto
    JOIN profesoruts ON anteproyecto.identificaciondir = profesoruts.identificacionp
    WHERE anteproyecto.identificaciondir > 0
</sql:query>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/styleLogins.css">
    <title>Login-Director</title>

</head>
<body>
<div class="container main-container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header text-center">
                    <img src="img/Logo_Uts.png" alt="Logo UTS" class="logo">
                    <h2>Panel de Director</h2>
                    <p class="mb-0">Acceso exclusivo para Directores asignados del sistema</p>
                </div>
                <div class="card-body">
                    <form method="post">
                        <input type="hidden" name="tipo" value="administrador">

                        <div class="form-group">
                            <label for="identificaciondir">Numero de identificación:</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control" id="identificaciondir" name="identificaciondir" placeholder="Ingrese su numero de identificación" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="password">password:</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                                </div>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Ingrese su password" >
                            </div>
                        </div>

                        <div class="form-group text-center mt-4">
                            <button type="submit" class="btn btn-primary btn-block" name="evaluar" value="1" >Iniciar Sesión</button>
                        </div>

                        <div class="form-group text-center">
                            <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalAdmins">Ver Directores Registrados</button>
                        </div>

                        <div class="card-footer text-center">
                            <a href="index.jsp" class="btn btn-outline-secondary btn-sm"><i class="fa fa-arrow-left"></i> Volver al inicio</a>
                        </div>
                            <c:choose>
                                <c:when test="${param.evaluar=='1' && (empty param.identificaciondir || empty param.password)}">
                                            <div class="alert alert-warning alert-dismissible fade show mt-3">
                                                    Datos faltantes, por favor ingrésar.
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:when>
                                            <c:when test="${not empty param.identificaciondir && not empty param.password}">
                                    <c:choose>
                                        <c:when test="${not empty login.rows}">
                                            <c:redirect url="jsp/director/directorMenu.jsp"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                                Verique datos ingresados y verificar si fuistes asignado como Director por el coordinador/a
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        <div class="footer-spacer">
                            <p>© 2025 Panel de Director. Todos los derechos reservados.</p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
    <!-- MODAL: director Registrados -->
        <div class="modal fade" id="modalAdmins" tabindex="-1" role="dialog" aria-labelledby="modalAdminsLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAdminsLabel">Directores Registrados</h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Cerrar">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        </div>
                            <div class="modal-body">
                                <table class="table table-bordered table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>numero de identificación</th>
                                            <th>nombre</th>
                                            <th>apellidos</th>
                                            <th>password</th>
                                        </tr>
                                    </thead>
                                <tbody>
                                    <c:forEach var="admin" items="${admins.rows}">
                                        <tr>
                                            <td>${admin.identificacionp}</td>
                                            <td>${admin.nombre}</td>
                                            <td>${admin.apellidos}</td>
                                            <td>${admin.password}</td>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>

</body>
</html>
