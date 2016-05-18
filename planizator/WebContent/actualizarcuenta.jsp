<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mipk.beanDB"%>

<!-- Pantalla de Query -->
<%
	String query;
	beanDB basededatos = new beanDB();
	String[][] tablares; // = basededatos.resConsultaSelectA3(query);

	//Cuenta
	String nombre = ""; //Parametro que se podrá recibir de un campo
	String apellidos = ""; //Parametro que se podrá recibir de un campo
	String contrasena = ""; //Parametro que se podrá recibir de un campo
	String contrasena2 = ""; //Parametro que se podrá recibir de un campo
	String fechaNacimiento = ""; //Parametro que se podrá recibir de un campo
	int idCuentaDestino = 0; //id de la cuenta a actualizar
	int idUsuarioDestino = 0; //id de la cuenta a actualizar
	String imagen = "";

	String apodo = "";
	boolean autorizado = false; //es mi cuenta o soy admin
	int miRol = 0; //mi rol
	int destinoRol = 0; //su rol
	int destinoNuevoRol = 0; //su rol
	boolean rolValido = false;

	int idCuenta = 0; //id de la cuenta logueada
	String cuentaApodo = "";
	try {
		idCuenta = Integer.parseInt(session.getAttribute("logueado").toString());
		cuentaApodo = session.getAttribute("apodo").toString();
	} catch (Exception e) {
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", "error.jsp");
	}
	
	try {
		apodo = request.getParameter("apodo").toString();
	} catch (Exception e) {
	}
	
	try {
		nombre = request.getParameter("nombre").toString();
	} catch (Exception e) {
	}

	try {
		apellidos = request.getParameter("apellidos").toString();
	} catch (Exception e) {
	}

	try {
		contrasena = request.getParameter("contrasena").toString();
	} catch (Exception e) {
	}

	try {
		fechaNacimiento = request.getParameter("fechaNacimiento").toString();
	} catch (Exception e) {
	}

	try {
		destinoNuevoRol = Integer.parseInt(request.getParameter("nuevoRol").toString());
	} catch (Exception e) {
	}

	try {
		imagen = request.getParameter("imagen").toString();
	} catch (Exception e) {
	}

	if (apodo.equals("")) {
		try {
	apodo = session.getAttribute("apodo").toString();
		} catch (Exception e) {
		}
	}
	
	if (idCuenta != 0) {

		idCuentaDestino = Integer.parseInt(basededatos.resConsultaSelectA3(
				"SELECT idAccount FROM accounts WHERE nickname LIKE '" + apodo + "'")[0][0]);
		idUsuarioDestino = Integer.parseInt(basededatos
				.resConsultaSelectA3("SELECT idUser FROM users WHERE idAccount = " + idCuentaDestino)[0][0]);
		miRol = Integer.parseInt(basededatos
				.resConsultaSelectA3("SELECT idRole FROM accounts WHERE idAccount = " + idCuenta)[0][0]);
		destinoRol = Integer.parseInt(basededatos
				.resConsultaSelectA3("SELECT idRole FROM accounts WHERE idAccount = " + idCuentaDestino)[0][0]);
		if (destinoNuevoRol == 0) {
			destinoNuevoRol = destinoRol;
		}

		if (idCuentaDestino != idCuenta && miRol > 3) {
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
			response.setHeader("Location", "error.jsp");
		}
	}
%>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Pagina para BBDD">
<meta name="author" content="Jose Maria">

<title>Planizator - Actualizar cuenta</title>

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
			if (!nombre.equals("")) {
				basededatos.update("UPDATE users SET name='" + nombre + "' WHERE idAccount = " + idCuentaDestino);
		%><div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
			Nombre actualizado
		</div>
		<%
			}

			if (!apellidos.equals("")) {
				basededatos.update("UPDATE users SET surname='" + apellidos + "' WHERE idAccount = " + idCuentaDestino);
		%><div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
			Apellidos actualizados
		</div>
		<%
			}
			
			
			if (!contrasena.equals("")){
				basededatos.update("UPDATE accounts SET password='" + contrasena + "' WHERE idAccount = " + idCuentaDestino);	
				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Contraseña actualizada
				</div><%
			}
			
			
			if (!contrasena.equals("")){
				basededatos.update("UPDATE accounts SET password='" + contrasena + "' WHERE idAccount = " + idCuentaDestino);	
				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Contraseña actualizada
				</div><%
			}
			
			if (!fechaNacimiento.equals("")){
				basededatos.update("UPDATE users SET birthdate='" + fechaNacimiento + "' WHERE idAccount = " + idCuentaDestino);	
				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Fecha de nacimiento actualizada
				</div><%
			}
			
			if (!imagen.equals("")){
				basededatos.update("UPDATE users SET photo='" + imagen + "' WHERE idAccount = " + idCuentaDestino);	
				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Imagen actualizada
				</div><%
			}
			
			if (!contrasena.equals("")){
				basededatos.update("UPDATE accounts SET password='" + contrasena + "' WHERE idAccount = " + idCuentaDestino);	
				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Contraseña actualizada
				</div><%
			}
			
			if (destinoNuevoRol >= miRol && destinoRol > miRol && destinoRol != destinoNuevoRol) {
				rolValido=true;
				basededatos.update("UPDATE accounts SET idRole="+destinoNuevoRol+", roleSetBy_idAccount="+idCuenta+" WHERE idAccount = " + idCuentaDestino);				%><div class="alert alert-success" role="alert">
				<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> Rol actualizado
				</div><%
			}
			
			
			
		%>
		<h4>
			Actualizar informacion de
			<%=apodo%>:
		</h4>

		<form role="form" name="insertarUsuario" method="post" action="#">
			<div class="form-group">
				<fieldset>
					<legend>Campos nuevos:</legend>
					<br> <label>Nombre</label> <input class="form-control"
						type="text" name="nombre" placeholder="Introduce tu nombre"
						value="<%=nombre%>"><br> <label
						for="apellidos">Apellidos</label> <input class="form-control"
						type="text" name="apellidos" placeholder="Introduce tus apellidos"
						value="<%=apellidos%>"><br> <label
						for="contrasena">Nueva Contraseña</label> <input
						class="form-control" type="password" name="contrasena"
						placeholder="Introduce tu contraseña" value="<%=contrasena%>"
						><br>

					<label for="nuevoRol">Nuevo Rol: </label><br> <select
						name="nuevoRol">

						<%
							tablares = basededatos
									.resConsultaSelectA3("SELECT idRole, description FROM roles WHERE idRole >= " + miRol);

							for (int i = 0; i < tablares.length-1; i++) {
						%>
						<option value="<%=tablares[i][0]%>"><%=tablares[i][1]%></option>
						<%
							}
						%>
						<option value="<%=tablares[tablares.length-1][0]%>" selected><%=tablares[tablares.length-1][1]%></option>
					</select><br>
					<br>
					<%
						if (!rolValido && destinoRol != destinoNuevoRol) {
					%>
					<div class="alert alert-danger" role="alert">
						<span class="glyphicon glyphicon-exclamation-sign"
							aria-hidden="true"></span>No tienes permiso para poner este rol o
						para cambiar esta cuenta
					</div>
					<%
						}
					%>

					<label for="fechaNacimiento">Fecha de nacimiento(*)</label> <input
						class="form-control" type="date" name="fechaNacimiento"
						placeholder="1999-12-31" value="<%=fechaNacimiento%>"><br>
					<label for="imagen">URL Imagen</label> <input class="form-control"
						type="text" name="imagen" placeholder="Imagen de perfil"><br>
				</fieldset>
			</div>
			<span>Solo los campos rellenados serán actualizados</span><br>

			<button type="submit" class="btn btn-default">Actualizar</button>

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
