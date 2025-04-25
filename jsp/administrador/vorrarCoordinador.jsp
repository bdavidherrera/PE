<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ include file="../../WEB-INF/jspConexion/conexion.jsp" %>

<%
    if (session != null && session.getAttribute("usuarioAdmin") != null) {

    } else {

        response.sendRedirect("../../index.jsp");
    }
%>

<c:if test="${param.id != null}">

    <sql:update var="result" dataSource="${anteproyecto}">
        DELETE FROM coordinador
        WHERE noidentificacionc = ${param.id}
    </sql:update>

    <c:if test="${result == 1}">
        <script>
        alert("Eliminación exitosa.");
        window.location.href = "mostrarCoordinador.jsp";
        </script>
    </c:if>
</c:if>

