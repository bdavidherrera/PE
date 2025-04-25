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
        WHERE fk_id_profesor = ? OR identificaciondir = ?
        <sql:param value="${param.id}" />
        <sql:param value="${param.id}" />
    </sql:query>

    <c:if test="${fn:length(verificar.rows) == 0}">
        <sql:update var="result" dataSource="${anteproyecto}">
            DELETE FROM profesoruts
            WHERE identificacionp = ?
            <sql:param value="${param.id}" />
        </sql:update>

        <c:if test="${result == 1}">
            <script>
                alert("Eliminación exitosa.");
                window.location.href = "mostrarDocente.jsp";
            </script>
        </c:if>
    </c:if>

    <c:if test="${fn:length(verificar.rows) > 0}">
        <script>
            if (confirm("El profesor está asignado como director o evaluador de un anteproyecto de grado. ¿Deseas actualizar los campos a 00000000 para poder eliminarlo?")) {
                window.location.href = "modificarProfesorAsignado.jsp?id=${param.id}";
            } else {
                window.location.href = "mostrarDocente.jsp";
            }
        </script>
    </c:if>

</c:if>

