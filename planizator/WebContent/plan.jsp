<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="mipk.beanDB"%>

<!-- Pantalla de Query -->
<%
	String query;
	beanDB basededatos = new beanDB();
	String[][] tablares; // = basededatos.resConsultaSelectA3(query);

	//Cuenta
	int idUsuario = 0; //id del usuario
	int idUsuarioCreador = 0; //id del usuario
	int idCuentaCreador = 0; //id del usuario
	String apodoCreador = "";
	int idPlan = 0; //id del plan
	int rango = 0; //nivel de la cuenta 3 o menos debe tener control administrativo
	boolean autorizado = false; //es mi cuenta o soy admin, en caso de true hay más información

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
		idPlan = Integer.parseInt(request.getParameter("idPlan").toString());
	} catch (Exception e) {
	}
	
	if (idCuenta != 0){
	if (idPlan == 0) {
		response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
		response.setHeader("Location", "error.jsp");
	} else {
		tablares = basededatos.resConsultaSelectA3(
				"SELECT idUser FROM users JOIN events ON (users.idUser = events.creador_idUser) WHERE idEvent = "
						+ idPlan + ";");
		idUsuarioCreador = Integer.parseInt(tablares[0][0]);
		tablares = basededatos
				.resConsultaSelectA3("SELECT idAccount FROM users WHERE idUser = " + idUsuarioCreador + ";");
		idCuentaCreador = Integer.parseInt(tablares[0][0]);
		tablares = basededatos
				.resConsultaSelectA3("SELECT idAccount FROM users WHERE idUser = " + idUsuarioCreador + ";");
		idCuentaCreador = Integer.parseInt(tablares[0][0]);
		tablares = basededatos.resConsultaSelectA3(
				"SELECT nickname FROM accounts WHERE idAccount = " + idCuentaCreador + ";");
		apodoCreador = tablares[0][0];
	}
	tablares = basededatos.resConsultaSelectA3(
			"SELECT idUser FROM users JOIN accounts ON (users.idAccount = accounts.idAccount) WHERE accounts.idAccount = "
					+ idCuenta + ";");
	idUsuario = Integer.parseInt(tablares[0][0]);
	tablares = basededatos
			.resConsultaSelectA3("SELECT idRole FROM accounts WHERE idAccount = " + idCuenta + ";");
	rango = Integer.parseInt(tablares[0][0]);

	//si soy yo o soy admin o mas, informacion completa con edición posible
	if (idUsuario == idUsuarioCreador || rango <= 3) {
		autorizado = true;
	}
	}
	
	String fotoPlan ="";
%>

<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Pagina para BBDD">
<meta name="author" content="Jose Maria">

<title>Planizator - Informacion de plan</title>

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

		<div class="row text-center">

			<h1>Datos del plan:</h1>

			<%
			if (idCuenta != 0){
				tablares = basededatos.resConsultaSelectA3(
						"SELECT title, description, location, place, dateStart, dateEnd, events.photo, ageLimit, name, surname, nickname FROM events JOIN users ON (users.idUser = events.creador_idUser) JOIN accounts ON (users.idAccount = accounts.idAccount) WHERE idEvent = "
								+ idPlan);

				if (tablares != null) {
					if (tablares[0][6] != null && !tablares[0][6].equals("")) {
						fotoPlan = tablares[0][6];
					} else {
						fotoPlan = "img/sevilla.jpg";
					}
			%>
			<p>
				<span class="text-info lead">Titulo:</span>
				<%=tablares[0][0]%></p>
			<p class="bg-info">
				<span class="text-info lead">Descripcion:</span><br>
				<%=tablares[0][1]%></p>
			<p>
				<span class="text-info lead">Lugar:</span>
				<%=tablares[0][2]%></p>
			<p>
				<span class="text-info lead">Lugar concreto de reunión:</span>
				<%=tablares[0][3]%></p>
			<p>
				<span class="text-info lead">Fecha comienzo:</span>
				<%=tablares[0][4]%></p>
			<p>
				<span class="text-info lead">Fecha final:</span>
				<%=tablares[0][5]%></p>
			<p>
				<span class="text-info lead">Limite de edad:</span>
				<%=tablares[0][7]%></p>
			<p>
				<span class="text-info lead">Foto:</span><br>
				<img class="img-thumbnail" src="<%=fotoPlan%>" alt="<%=fotoPlan%>"></p>
			<p>
				<span class="text-info lead">Creado por:</span> <a
					href="perfil.jsp?apodo=<%=apodoCreador%>"><%=tablares[0][8]%> <%=tablares[0][9]%></a>
			</p>
			
				<a href="mandarmensaje.jsp?destinatario=<%=tablares[0][10]%>" class="btn btn-default btn-sm">Mandar un mensaje</a>
			
			
			<hr>
			
				<span class="text-info lead">gente que se ha unido:</span><br>
				<div class="row center-block">
				<%
					tablares = basededatos.resConsultaSelectA3(
								"SELECT nickname, photo FROM accounts JOIN users ON (accounts.idAccount = users.idAccount) JOIN userHasEvents ON (users.idUser = userHasEvents.idUser) WHERE idEvent ="+ idPlan);

						if (tablares != null) {
							for (int i = 0; i<tablares.length; i++) {
								
								if (tablares[i][1] != null && !tablares[i][1].equals("")) {
									fotoPlan = tablares[i][1];
								} else {
									fotoPlan = "img/user.png";
								}
								
				%>
				<div class="thumbnail" style="width:120px; height:140px; float:left;">
				<figure>
				<a href="perfil.jsp?apodo=<%=tablares[i][0]%>">
				<img class="img-bordered" src="<%=fotoPlan%>" style="width:100px;height:100px"/>
				<span class="small"><%=tablares[i][0]%></span>
				</a>
				</figure>
				</div>
				<%
					}
						}
				%>
			</div>

			<p>
				<%
					if (basededatos.resConsultaSelectA3("SELECT idUserHasEvent FROM userHasEvents  WHERE idEvent="
								+ idPlan + " AND idUser=" + idUsuario) == null) {
				%>
				<a
					href="unirseaplan.jsp?idUsuario=<%=idUsuario%>&idPlan=<%=idPlan%>"
					class="btn btn-primary" role="button">Unirse </a>
				<%
					} else {
				%>
				<a
					href="quitarseaplan.jsp?idUsuario=<%=idUsuario%>&idPlan=<%=idPlan%>"
					class="btn btn-danger" role="button">Salirse </a>
				<%
					}
				%>
			</p>


			<%
				}
			}
			%>

		</div>

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
