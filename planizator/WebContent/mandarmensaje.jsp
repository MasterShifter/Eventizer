<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mipk.beanDB"%>

	<!-- Pantalla de Query -->
	<%
		String query;
			beanDB basededatos = new beanDB();
			String[][] tablares = null; // = basededatos.resConsultaSelectA3(query);

			//Cuenta
			int idUsuario=0; //id de mi cuenta
			String destinatario="";
			int idDestinatario=0;
			String titulo="";
			String contenido="";
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
		destinatario = request.getParameter("destinatario").toString();
		titulo = request.getParameter("titulo").toString();
		contenido = request.getParameter("contenido").toString();
		verificar = true;
			} catch (Exception e) {
			}
			
		if (idCuenta != 0) {

			tablares = basededatos.resConsultaSelectA3("SELECT idUser FROM users WHERE idAccount = " + idCuenta);
			idUsuario = Integer.parseInt(tablares[0][0]);

			tablares = basededatos.resConsultaSelectA3(
					"SELECT idUser FROM users JOIN accounts ON (users.idAccount = accounts.idAccount) WHERE nickname LIKE '"
							+ destinatario + "'");
		}
	%>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Pagina para BBDD">
<meta name="author" content="Jose Maria">

<title>Planizator - Mandar un mensaje</title>

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
		<%if (idCuenta == 0){%>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="registrarse.jsp">Registrarse</a>
			</div>
			<div class="btn-group" role="group">
				<a class="btn btn-default" href="iniciarsesion.jsp">Iniciar sesion</a>
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
	<div class="container">

		<%
		if (idCuenta != 0){
	if (tablares != null){
		idDestinatario = Integer.parseInt(tablares[0][0]);
		if (!titulo.equals("") && !contenido.equals("")){
		basededatos.insert("INSERT INTO messages (title, content, dateSent) VALUES ('"+titulo+"', '"+contenido+"', now())");
		
		int idMensaje = Integer.parseInt(basededatos.resConsultaSelectA3("SELECT idMessage FROM messages WHERE title LIKE '"+titulo+"' AND content LIKE '"+contenido+"'")[0][0]);
		
		basededatos.insert("INSERT INTO userHasMessages (emisor_idUser, receiver_idUser, idMessage) VALUES ("+idUsuario+", "+idDestinatario+", "+idMensaje+")");
		
		%>
		<div class="alert alert-success" role="alert">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
			<span class="sr-only">Exito:</span> Mensaje mandado
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
	} else if (verificar) {
		%>
		<div class="alert alert-danger" role="alert">
			<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			<span class="sr-only">Error:</span> El usuario no existe
		</div>
		<%
	}
	
	%>

		<form role="form" name="mandarmensaje" method="get" action="#">
			<div class="form-group">
				<fieldset>
					<legend>Rellena el siguiente formulario:</legend>
					<label for="apodo">Destinatario (apodo):</label><input
						class="form-control" type="text" name="destinatario"
						placeholder="Introduce el apodo del destinatario"
						value="<%=destinatario%>" required><br>
					<label for="apodo">Titulo:</label><input
						class="form-control" type="text" name="titulo"
						placeholder="Titulo del mensaje"
						value="<%=titulo%>" required><br>

					<div class="form-group">
						<label for="Contenido">Contenido:</label>
						<textarea class="form-control" rows="5" name="contenido" required><%=contenido%></textarea>
					</div>
				</fieldset>
				<button type="submit" class="btn btn-default">Mandar mensaje</button>
			</div>
		</form>
	</div>
	<% } %>

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
