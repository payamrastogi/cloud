<%@ page import="com.cloudproject.facebook.FBConnection"%>
<%@ page import="com.cloudproject.main.UserDetails" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%><!--[if lt IE 7]><html lang="en" class="no-js ie6"><![endif]-->
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<%
	FBConnection fbConnection = new FBConnection();
	UserDetails userDetails = (UserDetails)request.getAttribute("userDetails");
%>
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta charset="UTF-8">
<title>Appetite</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<link rel="shortcut icon" href="favicon.png">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/slick.css">
<link rel="stylesheet" href="js/rs-plugin/css/settings.css">
<link rel="stylesheet" href="css/eco.css">
<script>
        $(document).ready(function() {
            appMaster.preLoader();
        }); 
        </script>
</head>
<body>
	
	<header>

		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="fa fa-bars fa-lg"></span>
					</button>
					<a class="navbar-brand" href="index.html"> <img
						src="img/eco/logo.png" alt="" class="logo">
					</a>
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">

					<ul class="nav navbar-nav navbar-right">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="<%=fbConnection.getFBAuthUrl()%>">Search</a></li>
						<li><a href="#profile">Profile</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-->
		</nav>
	</header>
	<div class="container">
	<!-- carousal -->
		<div class="row boxed">
			<div class="col-lg-4" >
				<div class="box" size="20" id="hello">
				<div class ="col-lg-12 title-bag">
					<div class="box-title col-lg-8" >
						<h1><%= userDetails.getFirstName() %> <%= userDetails.getLastName() %></h1>
					</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="setbox"></div>
								Email: <%= userDetails.getEmail() %>
								<br/>
								Gender: <%= userDetails.getGender() %>
						</div>
					</div>
				</div>
			</div>
			  
		</div>
		
	</div>
</html>