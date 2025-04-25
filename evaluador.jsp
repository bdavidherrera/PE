<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../WEB-INF/jspConexion/conexion.jsp" %>

<%
    String fk_id_profesor = request.getParameter("fk_id_profesor");
    String password = request.getParameter("password");
    String evaluar = request.getParameter("evaluar");

%>

<sql:query var="login" dataSource="${anteproyecto}">
   
    SELECT profesoruts.* FROM anteproyecto JOIN profesoruts ON anteproyecto.fk_id_profesor = profesoruts.identificacionp
    WHERE anteproyecto.calificaciondir='aprobado' AND anteproyecto.fk_id_profesor=? AND profesoruts.password=?;

    <sql:param value="<%= fk_id_profesor %>" />
    <sql:param value="<%= password %>" />
</sql:query>


<c:if test="${not empty login.rows}">
    <c:set var="evaluador" value="${login.rows[0]}" />
    <c:set var="identificacionpEva" value="${evaluador.identificacionp}" scope="session" />
    <c:set var="nombreEva" value="${evaluador.nombre}" scope="session" />
    <c:set var="apellidosEva" value="${evaluador.apellidos}" scope="session" />
</c:if>

<c:if test="${not empty login.rows}">
    <c:set var="rol" value="${login.rows[0]}" />
    <c:set var="roles" value="${rol.fk_id_rolp}" scope="session" />
</c:if>






<sql:query var="admins" dataSource="${anteproyecto}">
    SELECT DISTINCT profesoruts.* FROM anteproyecto JOIN profesoruts ON anteproyecto.fk_id_profesor = profesoruts.identificacionp WHERE 
    anteproyecto.calificaciondir='aprobado' AND profesoruts.fk_id_rolp='5';
</sql:query>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/styleLogins.css">
    <title>Login-Evaluador</title>
</head>
<body>
<div class="container main-container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow">
                <div class="card-header text-center">
                    <img src="img/Logo_Uts.png" alt="Logo UTS" class="logo">
                    <h2>Panel de Evaluador</h2>
                    <p class="mb-0">Acceso exclusivo para Evaluador del sistema</p>
                </div>
                <div class="card-body">
                    <form method="post">
                        <input type="hidden" name="tipo" value="administrador">

                        <div class="form-group">
                            <label for="fk_id_profesor">Numero de identificación:</label>
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                                </div>
                                <input type="text" class="form-control" id="fk_id_profesor" name="fk_id_profesor" placeholder="Ingrese su numero de identificación" >
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
                            <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#modalAdmins">Ver Evaluadores Registrados</button>
                        </div>

                        <div class="card-footer text-center">
                            <a href="index.jsp" class="btn btn-outline-secondary btn-sm"><i class="fa fa-arrow-left"></i> Volver al inicio</a>
                        </div>
                            <c:choose>
                                <c:when test="${param.evaluar=='1' && (empty param.fk_id_profesor || empty param.password)}">
                                            <div class="alert alert-warning alert-dismissible fade show mt-3">
                                                    Datos faltantes, por favor ingrésar.
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:when>
                                            <c:when test="${not empty param.fk_id_profesor && not empty param.password}">
                                    <c:choose>
                                        <c:when test="${not empty login.rows}">
                                            <c:redirect url="jsp/evaluador/evaluadorMenu.jsp"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                                Verifica los datos ingresados. Asegúrate de haber sido asignado como evaluador(a) 
                                                por el coordinador y de que el anteproyecto de grado ya haya sido aceptado por el director asignado.
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                        <div class="footer-spacer">
                            <p>© 2025 Panel de evaluador . Todos los derechos reservados.</p>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
    <!-- MODAL: Estudiantes Registrados -->
        <div class="modal fade" id="modalAdmins" tabindex="-1" role="dialog" aria-labelledby="modalAdminsLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalAdminsLabel">Evaluadores Registrados</h5>
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

