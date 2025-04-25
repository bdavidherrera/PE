<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<c:choose>
    <c:when test="${sessionScope.roles == 1}">
        <c:set var="rol" value="administrador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 2}">
        <c:set var="rol" value="coordinador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 4}">
        <c:set var="rol" value="director" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 5}">
        <c:set var="rol" value="evaluador" scope="session" />
    </c:when>
    <c:when test="${sessionScope.roles == 6}">
        <c:set var="rol" value="estudiante" scope="session" />
    </c:when>
    <c:otherwise>
        <c:set var="rol" value="desconocido" scope="session" />
    </c:otherwise>
</c:choose>

<c:if test="${sessionScope.identificacionDirector!= null}">
    <sql:query var="revisarEliminarDirector" dataSource="${anteproyecto}">
        SELECT * FROM anteproyecto 
        WHERE identificaciondir = ${sessionScope.identificacionDirector}
    </sql:query>

    <c:if test="${not empty revisarEliminarDirector.rows}">
        <c:set var="directorEliminarRevisar" value="${revisarEliminarDirector.rows[0]}" />
        <c:set var="identificacionDirectorE" value="${directorEliminarRevisar.identificaciondir}" />
    </c:if>
</c:if>


<c:if test="${sessionScope.identificacionpEva!= null}">
    <sql:query var="revisarEliminarEvaluador" dataSource="${anteproyecto}">
        SELECT * FROM anteproyecto 
        WHERE fk_id_profesor = ${sessionScope.identificacionpEva}
    </sql:query>

    <c:if test="${not empty revisarEliminarEvaluador.rows}">
        <c:set var="EvaluadorEliminarRevisar" value="${revisarEliminarEvaluador.rows[0]}" />
        <c:set var="identificacionEvlaudorE" value="${EvaluadorEliminarRevisar.fk_id_profesor}" />
    </c:if>
</c:if>


<c:if test="${sessionScope.noidentificacionc!= null}">
    <sql:query var="revisarCoordinador" dataSource="${anteproyecto}">
         SELECT * FROM coordinador 
        WHERE noidentificacionc = ${sessionScope.noidentificacionc}
    </sql:query>

    <c:if test="${not empty revisarCoordinador.rows}">
        <c:set var="CoordinadorEliminarRevisar" value="${revisarCoordinador.rows[0]}" />
        <c:set var="identificacionCoordinadorE" value="${CoordinadorEliminarRevisar.noidentificacionc}" />
    </c:if>
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
<link rel="stylesheet" href="../css/mostrarUsuarios.css">
<title>MostrarHistorialVersiones</title>
</head>
<body>

<!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand">
                <img src="../img/Logo_Uts.png" alt="Logo UTS" class="mr-2">
            </a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="${sessionScope.rol}/${sessionScope.rol}Menu.jsp"><i class="fas fa-home mr-1"></i> Inicio</a>
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
                            <h2 class="title-with-underline">Mostrar Historial de versiones</h2>
                            <p class="text-muted mt-3">Puedes ver las diferentes observaciones y versiones del proyecto</p>
                        </div>
                        
                        <div id="tabla-contenido" class="mt-4">
                            <div class="table-responsive">

                            <c:choose>
                            <c:when test="${sessionScope.rol=='coordinador' || sessionScope.rol=='director' || sessionScope.rol=='evaluador'}">

                            <table class="table table-custom table-hover">
                                    <thead>
                                        <tr>
                                            <th>Versión</th>
                                            <th>id</th>
                                            <th>identificación del anteproyecto</th>
                                            <th>Nombre de la idea</th>
                                            <th>Cedula de la persona que lo escribio:</th>
                                            <th>Recomendado por:</th>
                                            <th>Recomendación:</th>
                                            <th>Fecha de modificación</th>
                                            <th>Anteproyecto a corregir:</th>
                                            <th class="text-center">Accion</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="result" scope="request" dataSource="${anteproyecto}">
                                            SELECT * FROM historialversiones ORDER BY numero_version DESC
                                        </sql:query>
                                        
                                        <c:forEach var="fila" items="${result.rows}">
                                            <tr>
                                                <td><span class="badge badge-primary">V${fila.numero_version}</span></td>
                                                <td><c:out value="${fila.id}" /></td>
                                                <td><c:out value="${fila.id_anteproyecto}" /> 
                                                <c:out value="${fila.apellidos}" /> </td>
                                                <td><c:out value="${fila.nombreidea}" /></td>
                                                <td><c:out value="${fila.autor_id}" /></td>
                                                <td><c:out value="${fila.autor_rol}" /></td>
                                                <td><c:out value="${fila.comentario}" /></td>
                                                <td><c:out value="${fila.fecha}" /></td>
                                                <td><a href= "<c:out value="${fila.AnteproyectoUrl}" />" target="_blank">Ver Anteproyecto</a></td>

                                                <c:if test="${identificacionDirectorE == fila.autor_id}">
                                                    <td class="text-center">
                                                        <a href="borrarhistorial.jsp?id=<c:out value='${fila.id}' />" class="btn action-btn delete-btn">
                                                            <i class="fas fa-trash-alt"></i> Eliminar
                                                        </a>
                                                    </td>
                                                </c:if>

                                                <c:if test="${identificacionEvlaudorE == fila.autor_id}">
                                                    <td class="text-center">
                                                        <a href="borrarhistorial.jsp?id=<c:out value='${fila.id}' />" class="btn action-btn delete-btn">
                                                            <i class="fas fa-trash-alt"></i> Eliminar
                                                        </a>
                                                    </td>
                                                </c:if>

                                                <c:if test="${identificacionCoordinadorE == fila.autor_id}">
                                                    <td class="text-center">
                                                        <a href="borrarhistorial.jsp?id=<c:out value='${fila.id}' />" class="btn action-btn delete-btn">
                                                            <i class="fas fa-trash-alt"></i> Eliminar
                                                        </a>
                                                    </td>
                                                </c:if>




                                            </tr>
                                        </c:forEach>
                                    </tbody>



                                </table>
                            
                            </c:when>

                            <c:when test="${sessionScope.rol=='estudiante'}">
                            <table class="table table-custom table-hover">
                                    <thead>
                                        <tr>
                                            <th>Versión</th>
                                            <th>id</th>
                                            <th>identificación del anteproyecto</th>
                                            <th>Nombre de la idea</th>
                                            <th>Cedula de la persona que lo escribio:</th>
                                            <th>Recomendado por:</th>
                                            <th>Recomendación:</th>
                                            <th>Fecha de modificación</th>
                                            <th>Anteproyecto a corregir:</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <sql:query var="result" scope="request" dataSource="${anteproyecto}">
                                                SELECT hv.*
                                                FROM historialversiones hv
                                                JOIN anteproyecto ap ON hv.id_anteproyecto = ap.id
                                                WHERE ap.fk_id_estudiante = ${sessionScope.noidentificacion}
                                                ORDER BY hv.numero_version DESC;
                                        </sql:query>
                                                
                                        <c:forEach var="fila" items="${result.rows}">
                                            <tr>
                                                <td><span class="badge badge-primary">V${fila.numero_version}</span></td>
                                                <td><c:out value="${fila.id}" /></td>
                                                <td><c:out value="${fila.id_anteproyecto}" /> 
                                                <c:out value="${fila.apellidos}" /> </td>
                                                <td><c:out value="${fila.nombreidea}" /></td>
                                                <td><c:out value="${fila.autor_id}" /></td>
                                                <td><c:out value="${fila.autor_rol}" /></td>
                                                <td><c:out value="${fila.comentario}" /></td>
                                                <td><c:out value="${fila.fecha}" /></td>
                                                <td><a href= "<c:out value="${fila.AnteproyectoUrl}" />" target="_blank">Ver Anteproyecto</a></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>


                                
                                <c:otherwise>
                                <script>
                                    alert("ERROR:500");
                                    window.location.href = "${sessionScope.rol}/Anteproyecto/mostrarAnteproyecto.jsp";
                                </c:otherwise>
                            
                            </c:choose>


                                <div class="text-center mt-4">
                                        <a href="${sessionScope.rol}/Anteproyecto/mostrarAnteproyecto.jsp" class="btn new-btn">
                                            <i class="fas fa-home mr-1"></i>Regresar al mostrar anteproyecto
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