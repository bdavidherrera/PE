<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta name="Description" content="Enter your description here"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link rel="stylesheet" href="css/style.css">
<title>MenuRol</title>
</head>
<body>
   <body>
    <div class="container main-container">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8">
                <div class="card shadow">
                    <div class="card-header text-center bg-primary text-white">
                        <h2>Sistema de Gestión de anteproyectos</h2>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <img src="img/Logo_Uts.png" alt="Logo UTS" class="logo">
                            <h3 class="mt-3">Unidades Tecnologicas de Santander</h3>
                            <p class="lead">Seleccione su perfil para ingresar al sistema</p>
                        </div>
                        <div class="row justify-content-center botones-acceso">
                            <div class="col-sm-6 col-md-4 mb-3">
                                <a href="administrador.jsp" type="button" class="btn btn-primary btn-block btn-perfil" >Administrador</a>
                            </div>
                            <div class="col-sm-6 col-md-4 mb-3">
                                <a href="cordinacion.jsp" type="button" class="btn btn-success btn-block btn-perfil">Coordinación</a>
                            </div>
                            <div class="col-sm-6 col-md-4 mb-3">
                                <a href="director.jsp" type="button" class="btn btn-info btn-block btn-perfil">Director</a>
                            </div>
                            <div class="col-sm-6 col-md-4 mb-3">
                                <a href="evaluador.jsp" type="button" class="btn btn-warning btn-block btn-perfil">Evaluador</a>
                            </div>
                            <div class="col-sm-6 col-md-4 mb-3">
                                <a href="estudiante.jsp" type="button" class="btn btn-danger btn-block btn-perfil">Estudiante</a>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-center">
                        <p class="mb-0">&copy; 2025 Unidades Tecnologicas de Santander.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.1/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.min.js"></script>
</body>
</html>