<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../WEB-INF/jspConexion/conexion.jsp" %>

<%
    String noidentificacionc = request.getParameter("noidentificacionc");
    String password = request.getParameter("password");
    String evaluar = request.getParameter("evaluar");

%>

<sql:query var="login" dataSource="${anteproyecto}">
    SELECT * FROM coordinador 
    WHERE noidentificacionc = ? AND password = ? AND fk_id_rolc = 2
    <sql:param value="<%= noidentificacionc %>" />
    <sql:param value="<%= password %>" />
</sql:query>


<c:if test="${not empty login.rows}">
    <c:set var="coordinador" value="${login.rows[0]}" />
    <c:set var="noidentificacionc" value="${coordinador.noidentificacionc}" scope="session" />
    <c:set var="nombreCoor" value="${coordinador.nombre}" scope="session" />
    <c:set var="apellidosCoor" value="${coordinador.apellidos}" scope="session" />
</c:if>

<c:if test="${not empty login.rows}">
    <c:set var="rol" value="${login.rows[0]}" />
    <c:set var="roles" value="${rol.fk_id_rolc}" scope="session" />
</c:if>


<sql:query var="admins" dataSource="${anteproyecto}">
    SELECT noidentificacionc, nombre, apellidos, password FROM coordinador
</sql:query>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login-Estudiante</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/styleLogins.css">
</head>
<body>
<div class="container main-container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header text-center">
                    <img src="img/Logo_Uts.png" alt="Logo UTS" class="logo">
                    <h2>Panel de Coordinadores/as</h2>
                    <p class="mb-0">Acceso exclusivo para coordinadores/as del sistema</p>
                </div>
                <div class="card-body">
                    <form method="post">
                        <input type="hidden" name="tipo" value="administrador">

                        <div class="form-group">
                            <label for="noidentificacionc">Numero de identificación:</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control" id="noidentificacionc" name="noidentificacionc" placeholder="Ingrese su numero de identificación" >
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
                            <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalAdmins">Ver Coordinadores/as Registrados</button>
                        </div>

                        <div class="card-footer text-center">
                            <a href="index.jsp" class="btn btn-outline-secondary btn-sm"><i class="fa fa-arrow-left"></i> Volver al inicio</a>
                        </div>
                            <c:choose>
                                <c:when test="${param.evaluar=='1' && (empty param.noidentificacionc || empty param.password)}">
                                            <div class="alert alert-warning alert-dismissible fade show mt-3">
                                                    Datos faltantes, por favor ingrésar.
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:when>
                                            <c:when test="${not empty param.noidentificacionc && not empty param.password}">
                                    <c:choose>
                                        <c:when test="${not empty login.rows}">
                                            <c:redirect url="jsp/coordinador/coordinadorMenu.jsp"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                                Número de identificación o password incorrectos.
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        <div class="footer-spacer">
                            <p>© 2025 Panel de Coordinadores/as. Todos los derechos reservados.</p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
    <!-- MODAL: Coordinadores/as Registrados -->
        <div class="modal fade" id="modalAdmins" tabindex="-1" role="dialog" aria-labelledby="modalAdminsLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAdminsLabel">Coordinadores/as Registrados</h5>
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
                                            <td>${admin.noidentificacionc}</td>
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
