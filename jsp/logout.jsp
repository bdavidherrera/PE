<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    session.invalidate(); 
    response.sendRedirect("../index.jsp"); 
%>


