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
    SET fk_id_profesor = CASE WHEN fk_id_profesor = ? THEN '00000000' ELSE fk_id_profesor END,
        identificaciondir = CASE WHEN identificaciondir = ? THEN '00000000' ELSE identificaciondir END
    WHERE fk_id_profesor = ? OR identificaciondir = ?
    <sql:param value="${param.id}" />
    <sql:param value="${param.id}" />
    <sql:param value="${param.id}" />
    <sql:param value="${param.id}" />
</sql:update>

<sql:update var="resultado" dataSource="${anteproyecto}">
    DELETE FROM profesoruts
    WHERE identificacionp = ?
    <sql:param value="${param.id}" />
</sql:update>

<script>
    alert("Se actualizaron los registros del anteproyecto y se eliminó al profesor.");
    window.location.href = "mostrarDocente.jsp";
</script>
