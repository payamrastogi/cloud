<!doctype html>
<!--[if lt IE 7]><html lang="en" class="no-js ie6"><![endif]-->
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
<meta charset="UTF-8">
<title>Oleose App Landing Page | Bootstrap Theme</title>
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


<script type="text/javascript" src="js/modernizr.custom.32033.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


<script>

	window.onload = function() 
	{
		
		openSocket();
		  var startPos;
	
		  if (navigator.geolocation) 
		  {
		    	navigator.geolocation.getCurrentPosition(function(position) 
		    	{
		      		startPos = position;
		     		openSocket();
		     		
		    	}, function(error) 
		    	{
		      		alert("Error occurred. Error code: " + error.code);
		      		// error.code can be:
		      		//   0: unknown error
		      		//   1: permission denied
		     		//   2: position unavailable (error response from locaton provider)
		      		//   3: timed out
		    	});
	
		    	navigator.geolocation.watchPosition(function(position) 
		    	{
		    		webSocket.send(startPos.coords.latitude+","+startPos.coords.longitude);
		    	});
		  }
	};
	
	var webSocket;
    var target = 'ws://' + window.location.host + "/CloudProject/websocket";
     
    function openSocket()
    {
     	if(webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED)
        {
         	writeResponse("WebSocket is already opened.");
            return;
        }
        
        webSocket = new WebSocket(target);
         
        webSocket.onopen = function(event)
        {
            if(event.data === undefined)
                return;
            writeResponse(event.data);
        };
        
        webSocket.onerror = function(event) 
        {
            onError(event)
        };

        webSocket.onmessage = function(event)
        {
        	 alert("hello");
        	 var str = event.data;
        	 var temp = new Array();
        	 temp = str.split("#"); 
         	// writeResponse(temp[0]);
         	// writeResponse(temp[1]);
         	//var rowNum = 0;
         	var html = $('.boxed').html();
         	for(i=0;i<2;i++)
         		{
         	//alert(rowNum);
         	 
		      $('.boxed').append(html);
		      $('.box').attr('id', 'box' + i);
		      $("#setbox").append("<br/>" +temp[i]);	
		      rowNum++;
         		}         	
        };

        webSocket.onclose = function(event)
        {
            writeResponse("Connection closed");
        };
     }
    

     function writeResponse(text)
     {
         //setbox.innerHTML += "<br/>" + text;
         		
 		       
     }
     
   // function forResponse(text)
   // {
    	
			// alert("clicked");
		//	for(i=0;i<2;i++)
		//		{
		      
		      
		//		}
  //  }
    
     
     function onError(event) 
     {
         alert(event.data);
     }
     
</script>
</head>

<body>
	</div>
	<div class="pre-loader">
		<div class="load-con">
			<img src="img/eco/logo.png" class="animated fadeInDown" alt="">
			<div class="spinner">
				<div class="bounce1"></div>
				<div class="bounce2"></div>
				<div class="bounce3"></div>
			</div>
		</div>
	</div>

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
						<li><a href="#about">about</a></li>
						<li><a href="#features">features</a></li>
						<li><a href="#reviews">reviews</a></li>
						<li><a href="#screens">screens</a></li>
						<li><a href="#demo">demo</a></li>
						<li><a class="getApp" href="#getApp">get app</a></li>
						<li><a href="#support">support</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-->
		</nav>
	</header>

	<div class="container">
		<div class="row boxed">
			<div class="col-lg-4" >
				<div class="box" onclick="location.href=''" id="box" size="20">
					<div class="box-title" >
						<h1>Lorem Ipsum</h1>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div id="setbox"></div>
							<h6>Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</h6>
						</div>
					</div>
				</div>
			</div>
			  
		</div>
		
	</div>
	<script src="js/jquery-1.11.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/slick.min.js"></script>
	<script src="js/placeholdem.min.js"></script>
	<script src="js/rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
	<script src="js/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
	<script src="js/waypoints.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="js/script.js"></script>

	<script>
        $(document).ready(function() {
            appMaster.preLoader();
        });
    </script>

</body>

</html>
