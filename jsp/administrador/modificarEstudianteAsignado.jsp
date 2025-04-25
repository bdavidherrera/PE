<%@ page import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    if (session != null && session.getAttribute("usuarioAdmin") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<sql:update dataSource="${anteproyecto}">
    UPDATE anteproyecto
    SET fk_id_estudiante = CASE 
        WHEN fk_id_estudiante = ? THEN '00000000' 
        ELSE fk_id_estudiante 
    END
    WHERE fk_id_estudiante = ?
    <sql:param value="${param.id}" />
    <sql:param value="${param.id}" />
</sql:update>

<sql:update var="resultado" dataSource="${anteproyecto}">
    DELETE FROM estudianteuts
    WHERE noidentificacion = ?
    <sql:param value="${param.id}" />
</sql:update>

<script>
    alert("Se actualizó el anteproyecto y se eliminó al estudiante.");
    window.location.href = "mostrarEstudiante.jsp";
</script>
