<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ include file="../../../WEB-INF/jspConexion/conexion.jsp" %>
<%
    if (session != null && session.getAttribute("noidentificacionc") != null) {

    } else {

        response.sendRedirect("../../../index.jsp");
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="../../../css/gestionarAnteproyectos.css">
<title>Historial-Versiones-Coordinador</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark mb-4">
    <div class="container">
        <a class="navbar-brand"><img src="../../../img/Logo_Uts.png" alt="Logo UTS" class="mr-2"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active"><a class="nav-link" href="mostrarAnteproyecto.jsp"><i class="fas fa-home mr-1"></i>Mostrar Anteproyecto</a></li>
                <li class="nav-item"><a class="nav-link" href="../../logout.jsp" id="salir"><i class="fas fa-sign-out-alt mr-1" ></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </div>
</nav>

<%

    String evaluar = request.getParameter("evaluar");

%>

    

       <c:if test="${param.evaluar== '1' && (pageContext.request.method == 'POST') }">
        <sql:query dataSource="${anteproyecto}" var="ultimaVersion">
            SELECT MAX(numero_version) as ultima_version 
            FROM historialversiones 
            WHERE id_anteproyecto = ?
            <sql:param value="${param.id_anteproyecto}" />
        </sql:query>
        
        <c:set var="nuevaVersion" value="1" />
        <c:forEach var="row" items="${ultimaVersion.rows}">
            <c:choose>
                <c:when test="${row.ultima_version != null}">
                    <c:set var="nuevaVersion" value="${row.ultima_version + 1}" />
                </c:when>
            </c:choose>
        </c:forEach>
        
        <sql:update dataSource="${anteproyecto}" var="result">
            INSERT INTO historialversiones (id_anteproyecto, nombreidea, autor_rol, autor_id, comentario, fecha, AnteproyectoUrl, numero_version)
            VALUES (?, ?, ?, ?, ?, current_timestamp(), ?, ?)
            <sql:param value="${param.id_anteproyecto}" />
            <sql:param value="${param.nombreAnteproyecto}" />
            <sql:param value="${param.autor_rol}" />
            <sql:param value="${param.autor_id}" />
            <sql:param value="${param.comentario}" />
            <sql:param value="${param.urlproyecto}" />
            <sql:param value="${nuevaVersion}" />
        </sql:update>

        <c:choose>
            <c:when test="${result >= 1 }">
                <div class="success">
                    <script>
                        alert("Observación registrada correctamente. Versión #${nuevaVersion}");
                        window.location.href = "../../mostrarhistorialversiones.jsp"; 
                    </script>                
                </div>
            </c:when>
            <c:otherwise>
                <div class="error">
                    <p>Error al guardar la observación.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

    <div class="container">
    <div class="card">
        <div class="card-header">
            <h2 class="mb-4">Agregar Observaciónes al anteproyecto ${param.nombreAnteproyecto}</h2>
        </div>

        <div class="card-body">
            <div class="info-coordinador">
                <p><strong>Coordinador:</strong> ${sessionScope.nombreCoor} ${sessionScope.apellidosCoor}</p>
                <p><strong>CC:</strong> ${sessionScope.noidentificacionc}</p>
            </div>

            <form id="formObservacion" method="POST">
                <input type="hidden" name="id_anteproyecto" value="${param.id}" />
                <input type="hidden" name="nombreAnteproyecto" value="${param.nombreAnteproyecto}" />
                <input type="hidden" name="autor_id" value="${sessionScope.noidentificacionc}" />
                <input type="hidden" name="autor_rol" value="Coordinador" />
                <input type="hidden" name="urlproyecto" value="${param.urlproyecto}" />

                <div class="form-group">
                    <label for="comentario" class="form-label">Observación:</label>
                    <textarea id="comentario" name="comentario" required class="form-control" rows="4" style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #ccc;" placeholder="Ingresar en comentarios la versión de la observación primero"></textarea>
                </div>

                <div class="form-group" style="margin-top: 1.5rem;">
                    <button type="submit" class="btn btn-primary" value="1" name="evaluar">Guardar Observación</button>
                    <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary">Regresar a la tabla anteproyecto</a>
                </div>
            </form>
        </div>
    </div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>
