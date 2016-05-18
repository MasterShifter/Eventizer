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
		int idUsuario=0;

		int idCuenta = 0; //id de la cuenta logueada
		String cuentaApodo = "";
		try {
			idCuenta = Integer.parseInt(session.getAttribute("logueado").toString());
			cuentaApodo = session.getAttribute("apodo").toString();
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
			response.setHeader("Location", "error.jsp");
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

<title>Planizator - Planes</title>

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
	
	<div class="row text-center">
	
		<a class="btn btn-default" href="mandarmensaje.jsp?">Redactar nuevo mensaje</a>
		
		<h1>Mensajes que han llegado: </h1>

		<%
		if (idCuenta != 0){
		tablares = basededatos.resConsultaSelectA3("SELECT nickname, title, content, dateSent FROM messages JOIN userHasMessages ON (userHasMessages.idMessage = messages.idMessage) JOIN users ON (emisor_idUser = users.idUser) JOIN accounts ON (accounts.idAccount = users.idAccount) WHERE receiver_idUser = "+idUsuario);
		
		if (tablares!=null){
			%> 
			<h6>(Hay <%=tablares.length%> mensajes)</h6>
			<ul class="list-group"> 
			<%
			for (int i=0; i<tablares.length; i++){
			    %>
				<li class="list-group-item text-left">
					<h6><b>Emisor:</b> <%=tablares[i][0]%></h6>
					<span class="text-muted"><span class="list-group-item-heading"><%=tablares[i][1]%></span> (<%=tablares[i][3]%>)</span>
					<p class="list-group-item-text bg-info"><%=tablares[i][2]%></p><br>
					<a href="mandarmensaje.jsp?destinatario=<%=tablares[i][0]%>" class="btn btn-default btn-sm">Responder</a>
				</li>
				<%
			}
			%> </ul> <%
		} else {
			%><h6>(Hay 0 mensajes)</h6><%
		}
		}%>

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
