<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mipk.beanDB"%>

<!-- Pantalla de Query -->
<%
	String query;
	beanDB basededatos = new beanDB();
	String[][] tablares; // = basededatos.resConsultaSelectA3(query);

	//Cuenta
	String apodo = ""; //Parametro que se podrá recibir de un campo
	String contrasena = ""; //Parametro que se podrá recibir de un campo

	int idCuenta = 0; //id de la cuenta logueada
	String cuentaApodo = "";
	try {
		idCuenta = Integer.parseInt(session.getAttribute("logueado").toString());
		cuentaApodo = session.getAttribute("apodo").toString();
	} catch (Exception e) {
	}
	
	try {
		apodo = request.getParameter("apodo").toString();
		contrasena = request.getParameter("contrasena").toString();
	} catch (Exception e) {
	}
%>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Pagina para BBDD">
<meta name="author" content="Jose Maria">

<title>Planizator - Iniciar sesión</title>

<link rel="icon" type="image/png" href="img/favicon.ico">

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/clean-blog.min.css" rel="stylesheet">

<!-- Lista Queries CSS -->
<link href="css/botones.css" rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href='http://fonts.googleapis.com/css?family=Lora:400,700,400italic,700italic'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800'
	rel='stylesheet' type='text/css'>

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

	<!-- Page Header -->
	<!-- Set your background image for this header on the line below. -->
	<header class="intro-header"
		style="background-image: url('img/front.jpg')">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
					<div class="site-heading">
						<a href="index.jsp"><span class="titulo sombraTexto">Planizator</span></a>
						<h2 class="sombraTexto">Tus planes mas cerca</h2>
					</div>
				</div>
			</div>
		</div>

		<div class="btn-group btn-group-justified" role="group"
			aria-label="...">
			<%
				if (idCuenta == 0) {
			%>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="registrarse.jsp">Registrarse</a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="iniciarsesion.jsp">Iniciar
					sesion</a>
			</div>
			<%
				} else {
			%>

			<div class="btn-group" role="group">
				<a class="btn btn-default" href="perfil.jsp">Mi perfil - <%=cuentaApodo%></a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="mensajes.jsp">Mensajes</a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="planes.jsp">Planes</a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="cerrarsesion.jsp">Cerrar sesion</a>
			</div>
			<%
				}
			%>
		</div>

	</header>

	<!-- Lista de Queries -->
	<div class="container">

		<%
			if (!apodo.equals("") && !contrasena.equals("")) {

				tablares = basededatos
						.resConsultaSelectA3("SELECT idAccount, nickname from accounts WHERE nickname LIKE '" + apodo
								+ "' AND password LIKE '" + contrasena + "'");
				if (tablares == null) {
		%>
		<div class="alert alert-danger" role="alert">
			<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>Usuario
			contraseña incorrectos
		</div>
		<%
			} else {
					session.setAttribute("logueado", tablares[0][0].toString());
					session.setAttribute("apodo", tablares[0][1].toString());
					response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
					response.setHeader("Location", "index.jsp");
		%>
		<div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Es
			correcto
		</div>
		<%
			}
			}
		%>

		<form role="form" name="loguearUsuario" method="post" action="#">
			<fieldset>
				<legend>Datos de usuario:</legend>
				<label for="apodo">Apodo</label><input class="form-control"
					type="text" name="apodo"
					placeholder="Introduce el apodo de tu cuenta" value="<%=apodo%>"
					required><br> <label for="contrasena">Contraseña</label><input
					class="form-control" type="password" name="contrasena"
					placeholder="Introduce tu contraseña" value="<%=contrasena%>"
					required><br>
			</fieldset>
				<button type="submit" class="btn btn-default">Iniciar
					sesión</button>
		</form>
	</div>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
					<p class="copyright text-muted">Copyright &copy; Planizator
						2016</p>
				</div>
			</div>
		</div>
	</footer>

	<!-- jQuery -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="js/clean-blog.min.js"></script>

</body>

</html>
