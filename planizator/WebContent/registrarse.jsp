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
	String nombre = ""; //Parametro que se podrá recibir de un campo
	String apellidos = ""; //Parametro que se podrá recibir de un campo
	String correo = ""; //Parametro que se podrá recibir de un campo
	String contrasena = ""; //Parametro que se podrá recibir de un campo
	String contrasena2 = ""; //Parametro que se podrá recibir de un campo
	String fechaNacimiento = ""; //Parametro que se podrá recibir de un campo
	String imagen = ""; //Parametro que se podrá recibir de un campo

	boolean apodoValido = false;
	boolean correoValido = false;
	boolean contrasenaValida = false;
	boolean todosLosDatosRecogidos = false;

	int idCuenta = 0; //id de la cuenta logueada
	String cuentaApodo = "";
	try {
		idCuenta = Integer.parseInt(session.getAttribute("logueado").toString());
		cuentaApodo = session.getAttribute("apodo").toString();
	} catch (Exception e) {
	}
	try {
		apodo = request.getParameter("apodo").toString();
		nombre = request.getParameter("nombre").toString();
		apellidos = request.getParameter("apellidos").toString();
		correo = request.getParameter("correo").toString();
		contrasena = request.getParameter("contrasena").toString();
		contrasena2 = request.getParameter("contrasena2").toString();
		fechaNacimiento = request.getParameter("fechaNacimiento").toString();
		todosLosDatosRecogidos = true;
		imagen = request.getParameter("imagen").toString();
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

<title>Planizator - Nuevo usuario</title>

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
						<h2 class="sombraTexto">Tus planes más cerca</h2>
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
				<a class="btn btn-default" href="iniciarsesion.jsp">Iniciar sesion</a>
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
			if (todosLosDatosRecogidos) {
				if (!apodo.equals("")) {
					tablares = basededatos
							.resConsultaSelectA3("SELECT nickname from accounts WHERE nickname LIKE '" + apodo + "'");
					if (tablares == null) {
						apodoValido = true;
					}
				}

				if (!contrasena.equals("") && !contrasena2.equals("")) {
					if (contrasena.equals(contrasena2)) {
						contrasenaValida = true;
					}
				}

				if (!correo.equals("")) {
					tablares = basededatos
							.resConsultaSelectA3("SELECT email from accounts WHERE email LIKE '" + correo + "'");
					if (tablares == null) {
						correoValido = true;
					}
				}

				if (correoValido && apodoValido && contrasenaValida) {
					basededatos.insert("INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('" + apodo
							+ "', '" + contrasena + "', '" + correo + "', now());");
					tablares = basededatos
							.resConsultaSelectA3("SELECT idAccount from accounts WHERE nickname LIKE '" + apodo + "'");
					if (imagen.equals("")) {
						basededatos.insert("INSERT INTO users (name, surname, birthdate, idAccount) VALUES ('" + nombre
								+ "', '" + apellidos + "', '" + fechaNacimiento + "', " + tablares[0][0] + ");");
					} else {
						basededatos.insert("INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('"
								+ nombre + "', '" + apellidos + "', '" + fechaNacimiento + "', " + tablares[0][0]
								+ ", '" + imagen + "');");
					}
		%>
		<div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> El
			usuario se ha registrado satisfactoriamente, ya puedes iniciar sesión
		</div>
		<%
				}
			}
		%>


		<h4>Menú de registro:</h4>

		<form role="form" name="insertarUsuario" method="post" action="#">
			<div class="form-group">
				<fieldset>
					<legend>Datos esenciales:</legend>
					<label for="apodo">Apodo(*)</label><input
						class="form-control" type="text" name="apodo"
						placeholder="Introduce el apodo de tu cuenta" value="<%=apodo%>"
						required>

					<%
						tablares = basededatos
								.resConsultaSelectA3("SELECT nickname from accounts WHERE nickname LIKE '" + apodo + "'");

						if (apodoValido) {
					%>
					<div class="alert alert-success" role="alert">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> El
						apodo está disponible
					</div>
					<%
						} else if (todosLosDatosRecogidos){
					%>
					<div class="alert alert-danger" role="alert">
						<span class="glyphicon glyphicon-exclamation-sign"
							aria-hidden="true"></span> El apodo ya está en uso
					</div>
					<%
						}
					%>

					<br> 
					<label>Nombre(*)</label>
					<input class="form-control" type="text" name="nombre" placeholder="Introduce tu nombre" value="<%=nombre%>" required><br>
					<label for="apellidos">Apellidos(*)</label>
					<input class="form-control" type="text" name="apellidos" placeholder="Introduce tus apellidos" value="<%=apellidos%>" required><br>
					<label for="contrasena">Contraseña(*)</label>
					<input class="form-control" type="password" name="contrasena" placeholder="Introduce tu contraseña" value="<%=contrasena%>" required><br>
					<label for="contrasena2">Repite tu Contraseña(*)</label>
					<input class="form-control" type="password" name="contrasena2" placeholder="Repite tu contraseña" value="<%=contrasena2%>" required><br>
					<%
						if (!contrasenaValida && todosLosDatosRecogidos) {
					%>
					<div class="alert alert-danger" role="alert">
						<span class="glyphicon glyphicon-exclamation-sign"
							aria-hidden="true"></span>Las contraseñas no coinciden
					</div>
					<%
						}
					%>
					<label for="correo">Correo electrónico(*)</label>
					<input class="form-control" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" type="email" name="correo" placeholder="Introduce tu correo electrónico" value="<%=correo%>" required><br>
					<%
						tablares = basededatos.resConsultaSelectA3("SELECT email from accounts WHERE email LIKE '" + correo + "'");

						if (correoValido && todosLosDatosRecogidos) {
					%>
					<div class="alert alert-success" role="alert">
						<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> El
						correo está disponible
					</div>
					<%
						} else if (todosLosDatosRecogidos){
					%>
					<div class="alert alert-danger" role="alert">
						<span class="glyphicon glyphicon-exclamation-sign"
							aria-hidden="true"></span> El correo ya está en uso o es incorrecto
					</div>
					<%
						}
					%>

				</fieldset>
			</div>
			<div class="form-group">
				<fieldset>
					<legend>Sobre el usuario:</legend>
					<label for="fechaNacimiento">Fecha de nacimiento(*)</label>
					<input class="form-control" type="date" name="fechaNacimiento" placeholder="Fecha de nacimiento" value="<%=fechaNacimiento%>" required><br>
					<label for="imagen">URL Imagen</label>
					<input class="form-control" type="text" name="imagen"><br>
				</fieldset>
			</div>
			<span>Los campos con (*) son obligatorios</span><br>
			<div class="checkbox">
				<input class="btn btn-default" type="checkbox" required><label>Acepto los terminos y condiciones</label>
			</div>
			<button type="submit" class="btn btn-default">Submit</button>
		</form>



	</div>

	<!-- Footer -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
					<p class="copyright text-muted">Copyright &copy; Planizator 2016</p>
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
