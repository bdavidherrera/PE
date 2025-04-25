<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../../WEB-INF/jspConexion/conexion.jsp" %>

<%
   String registrar = request.getParameter("registrar");
%>

<%
    if (session != null && session.getAttribute("noidentificacion") != null) {

    } else {

        response.sendRedirect("../../../index.jsp");
    }
%>
<sql:query var="mostrarIdea"  dataSource="${anteproyecto}">
SELECT * FROM anteproyecto WHERE fk_id_estudiante=${sessionScope.noidentificacion};
</sql:query>

<c:if test="${not empty param.nombreidea && not empty param.fk_id_estudiante}">
    
    <sql:query var="verificarEstudiante" dataSource="${anteproyecto}">
        SELECT * FROM anteproyecto WHERE fk_id_estudiante = ?
        <sql:param value="${param.fk_id_estudiante}" />
    </sql:query>
    
    <sql:query var="verificarIdea" dataSource="${anteproyecto}">
        SELECT * FROM anteproyecto WHERE nombreidea = ?
        <sql:param value="${param.nombreidea}" />
    </sql:query>
    
    <c:choose>
        <c:when test="${verificarEstudiante.rowCount > 0}">
            <c:set var="estudianteYaRegistrado" value="true" />
        </c:when>
        <c:when test="${verificarIdea.rowCount > 0}">
            <c:set var="ideaYaRegistrada" value="true" />
        </c:when>
        <c:otherwise>
            <sql:update var="result" dataSource="${anteproyecto}">
                INSERT INTO anteproyecto (nombreidea,
                 nombrees, apellidoes, semestrees, 
                 anteproyecto, identificaciondir, nombredir, 
                 calificaciondir, radicadoant, 
                nombreeva, calificacioneva, estadofinalcor, 
                radicaante, fk_id_profesor, fk_id_estudiante)
                VALUES (?, ?, ?, ?, 'Sin adjuntar', '0', 'Sin seleccionar','sin revisar', 
                'Sin adjuntar', 'Sin seleccionar', 'sin revisar', 'sin revisar', 'Sin adjuntar', 0, ?)
                <sql:param value="${param.nombreidea}" />
                <sql:param value="${param.nombrees}" />
                <sql:param value="${param.apellidoes}" />
                <sql:param value="${param.semestrees}" />
                <sql:param value="${param.fk_id_estudiante}" />
            </sql:update>
            <c:set var="registroExitoso" value="true" />
        </c:otherwise>
    </c:choose>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="Description" content="Formulario para selección de idea de anteproyecto"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="../../../css/insertarUsuarios.css">
    <title>Selección de Idea </title>
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
                        <a class="nav-link" href="../estudianteMenu.jsp"><i class="fas fa-home mr-1"></i> Regresar </a>
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
            <div class="col-lg-6 col-md-8">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-body p-5">
                        <h3 class="text-center mb-4 text-primary">Selección de Idea para Anteproyecto</h3>
                        
                        <form method="post">
                            <!-- Selección de Idea -->
                            <div class="mb-3">
                                <label for="nombreidea" class="form-label">Idea para Anteproyecto</label>
                                <sql:query var="listaIdeas" dataSource="${anteproyecto}">
                                    SELECT id.nombre FROM idea id
                                    WHERE id.nombre NOT IN (SELECT nombreidea FROM anteproyecto WHERE nombreidea IS NOT NULL)
                                </sql:query>
                                
                                <select class="custom-select form-control-lg rounded-pill" name="nombreidea" required>
                                    <option value="">-- Seleccione una idea --</option>
                                    <c:forEach var="item" items="${listaIdeas.rows}">
                                        <option value="${item.nombre}">
                                            <c:out value="${item.nombre}" />
                                        </option>
                                    </c:forEach>
                                </select>
                                <div class="invalid-feedback">Por favor seleccione una idea.</div>
                                
                                <div id="otraIdeaDiv" class="mt-2" style="display:none;">
                                    <input type="text" class="form-control" id="otraIdea" placeholder="Ingrese su idea">
                                </div>
                            </div>
                            
                            <!-- Datos del Estudiante -->
                            <div class="mb-3">
                                <label for="fk_id_estudiante" class="form-label">Identificación del Estudiante</label>
                                <sql:query var="listaEstudiantes" dataSource="${anteproyecto}">
                                    SELECT noidentificacion, nombre, apellidos FROM estudianteuts
                                    WHERE noidentificacion = ${sessionScope.noidentificacion}
                                </sql:query>
                                
                                <select class="custom-select form-control-lg rounded-pill" name="fk_id_estudiante" id="estudiante" required>
                                    <option value="">-- Seleccione --</option>
                                    <c:forEach var="est" items="${listaEstudiantes.rows}">
                                        <option value="${est.noidentificacion}" data-nombre="${est.nombre}" data-apellidos="${est.apellidos}">
                                            <c:out value="${est.noidentificacion} - ${est.nombre} ${est.apellidos}" />
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="nombrees" class="form-label">Nombre del Estudiante</label>
                                <input type="text" class="form-control" name="nombrees" id="nombrees" readonly required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="apellidoes" class="form-label">Apellidos del Estudiante</label>
                                <input type="text" class="form-control" name="apellidoes" id="apellidoes" readonly required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="semestrees" class="form-label">Semestre</label>
                                <select class="custom-select form-control-lg rounded-pill" name="semestrees" required>
                                    <option value="">-- Seleccione --</option>
                                    
                                    <option value="Quinto">Quinto</option>
                                    
                                </select>
                            </div>
                            
                            <div class="button-group mt-4">
                                <button type="submit" class="btn btn-primary w-100" value="1" name="registrar">Registrar Idea</button>
                            </div>
                        </form>
                        
                        <div class="button-group mt-3">
                            <a href="../AnteproyectoEs.jsp" class="btn btn-secondary w-100">Regresar</a>
                        </div>


                        <c:if test="${not empty mostrarIdea.rows}">
                             <div class="button-group mt-3">
                            <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary w-100">Mostrar Anteproyecto Registrado</a>
                        </div>
                        
                        </c:if>

                       
                        <!-- Mensajes de alerta -->
                        <c:if test="${registroExitoso}">
                            <div class="alert alert-success mt-4 text-center">
                                ¡Idea registrada exitosamente!
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                             <div class="button-group mt-3">
                            <a href="mostrarAnteproyecto.jsp" class="btn btn-secondary w-100">Mostrar Anteproyecto Registrado</a>
                        </div>
                        </c:if>
                        
                        <c:if test="${estudianteYaRegistrado}">
                            <div class="alert alert-danger alert-dismissible fade show mt-3">
                                <i class="fas fa-exclamation-circle mr-2"></i> 
                                <strong>Error:</strong> Solo puedes seleccionar una idea. Ya tienes una idea registrada.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        
                        <c:if test="${ideaYaRegistrada}">
                            <div class="alert alert-warning alert-dismissible fade show mt-3">
                                <i class="fas fa-exclamation-triangle mr-2"></i> 
                                <strong>Aviso:</strong> Esta idea ya está registrada en el sistema. Por favor, seleccione otra.
                                <button type="button" class="close" data-dismiss="alert" aria-label="Cerrar">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
    
    <script>
        $(document).ready(function() { 
            $('#estudiante').change(function() {
                var selectedOption = $(this).find(':selected');
                var nombre = selectedOption.data('nombre');
                var apellidos = selectedOption.data('apellidos');
                
                $('#nombrees').val(nombre);
                $('#apellidoes').val(apellidos);
            });
        });
    </script>
</body>
</html>