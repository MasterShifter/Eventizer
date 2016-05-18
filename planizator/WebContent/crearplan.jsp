<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mipk.beanDB"%>

<!-- Pantalla de Query -->
<%
		String query;
		beanDB basededatos = new beanDB();
		String[][] tablares; // = basededatos.resConsultaSelectA3(query);

		//Cuenta
		int idUsuario=0; //id de mi cuenta
		String titulo="";
		String descripcion="";
		String lugar="";
		String lugarConcreto="";
		String fecha1="";
		String fecha2="";
		String foto="";
		int limiteEdad=0;
		boolean verificar = false; //Solo cuando se han enviado todos los datos se verifican

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
			titulo = request.getParameter("titulo").toString();
			descripcion = request.getParameter("descripcion").toString();
			lugar = request.getParameter("lugar").toString();
			lugarConcreto = request.getParameter("lugarConcreto").toString();
			fecha1 = request.getParameter("fecha1").toString();
			fecha2 = request.getParameter("fecha2").toString();
			verificar = true;
			foto = request.getParameter("foto").toString();
			limiteEdad = Integer.parseInt(request.getParameter("limiteEdad").toString());
		} catch (Exception e) {
		}
		
		if (idCuenta != 0){
		tablares = basededatos.resConsultaSelectA3("SELECT idUser FROM users WHERE idAccount = "+idCuenta);
		idUsuario = Integer.parseInt(tablares[0][0]);
		}
	%>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Pagina para BBDD">
<meta name="author" content="Jose Maria">

<title>Planizator - Crear un plan</title>

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
			<%if (idCuenta == 0){%>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="registrarse.jsp">Registrarse</a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="iniciarsesion.jsp">Iniciar
					sesion</a>
			</div>
			<%} else {%>

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
			<%}%>
		</div>

	</header>

	<!-- Lista de Queries -->
	<%
	if (idCuenta != 0){
	%>
	<div class="container">

		<%
		if (!titulo.equals("") && !descripcion.equals("") && !fecha1.equals("") && !fecha2.equals("") && !lugar.equals("") && !lugarConcreto.equals("")){
		basededatos.insert("INSERT INTO events (title, description, location, place, dateStart, dateEnd, photo, ageLimit, creador_idUser) VALUES ('"+titulo+"', '"+descripcion+"', '"+lugar+"', '"+lugarConcreto+"', '"+fecha1+"', '"+fecha2+"', '"+foto+"', "+limiteEdad+", "+idUsuario+")");
		
		%>
		<div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span> <span
				class="sr-only">Exito:</span> Plan creado
		</div>
		<%	
		
		} else if (verificar) {
			%>
		<div class="alert alert-danger" role="alert">
			<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			<span class="sr-only">Error:</span> Rellena TODOS los campos
		</div>
		<%	
		}
	%>

		<form role="form" name="mandarmensaje" method="get" action="#">
			<div class="form-group">
				<fieldset>
					<legend>Rellena el siguiente formulario:</legend>
					<label for="titulo">Titulo(*):</label><input class="form-control"
						type="text" name="titulo" placeholder="Quedada en casa de Juan"
						value="<%=titulo%>" required><br>

					<div class="form-group">
						<label for="descripcion">Descripcion(*):</label>
						<textarea class="form-control" rows="5" name="descripcion"
							required><%=descripcion%></textarea>
					</div>

					<label for="lugar">Lugar(*):</label><input class="form-control"
						type="text" name="lugar" placeholder="Casa de Juan"
						value="<%=lugar%>" required><br> <label for="lugar">Lugar
						de reunión(*):</label><input class="form-control" type="text"
						name="lugarConcreto" placeholder="La parada del 26"
						value="<%=lugarConcreto%>" required><br> <label
						for="fecha1">Fecha de comienzo(*):</label> Formato: YYYY-MM-DD HH:MM:SS<input
						class="form-control" pattern="([0-9]){4}(-){1}([0-9]){2}(-){1}([0-9]){2}( ){1}([0-9]){2}(:){1}([0-9]){2}(:){1}([0-9]){2}" type="text" name="fecha1"
						placeholder="2013-11-24 17:15:10" value="<%=fecha1%>" required><br>

					<label for="fecha2">Fecha de finalizacion(*):</label> Formato: YYYY-MM-DD HH:MM:SS<input
						class="form-control" pattern="([0-9]){4}(-){1}([0-9]){2}(-){1}([0-9]){2}( ){1}([0-9]){2}(:){1}([0-9]){2}(:){1}([0-9]){2}" type="text" name="fecha2"
						placeholder="2013-11-24 17:15:10" value="<%=fecha2%>" required><br>

					<label for="foto">URL Imagen:</label> <input class="form-control"
						type="text" name="foto" placeholder="URL de la foto"><br>

					<label for="foto">Limite de edad (orientativo):</label> <input
						class="form-control" type="number" name="limiteEdad"
						placeholder="18" min="1" max="120"><br>


				</fieldset>
				<span>Los campos con (*) son obligatorios</span><br>
				<button type="submit" class="btn btn-default">Crear el plan</button>
			</div>
		</form>
	</div>
	<%
		}
	%>

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
