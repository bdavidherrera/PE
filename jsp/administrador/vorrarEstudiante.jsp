<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<%
    if (session != null && session.getAttribute("usuarioAdmin") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<c:if test="${param.id != null}">
    
    <sql:query var="verificar" dataSource="${anteproyecto}">
        SELECT 1 
        FROM anteproyecto 
        WHERE fk_id_estudiante = ?
        <sql:param value="${param.id}" />
    </sql:query>

    <c:if test="${fn:length(verificar.rows) == 0}">
        <sql:update var="result" dataSource="${anteproyecto}">
            DELETE FROM estudianteuts
            WHERE noidentificacion = ?
            <sql:param value="${param.id}" />
        </sql:update>

        <c:if test="${result == 1}">
            <script>
                alert("Eliminación exitosa.");
                window.location.href = "mostrarEstudiante.jsp";
            </script>
        </c:if>
    </c:if>

    <c:if test="${fn:length(verificar.rows) > 0}">
        <script>
            if (confirm("El estudiante está asignado a un anteproyecto. ¿Deseas actualizar su ID a '00000000' para poder eliminarlo?")) {
                window.location.href = "modificarEstudianteAsignado.jsp?id=${param.id}";
            } else {
                window.location.href = "mostrarEstudiante.jsp";
            }
        </script>
    </c:if>

</c:if>
