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
<script src="http://connect.facebook.net/en_US/all.js"></script>
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<script language="javascript" type="text/javascript">
    FB.init({
        appId: '404087249752808',
        status: true, 
        cookie: true, 
        xfbml: true
    }); 
    
    function fb_publish(name, address, direction) 
    {
        FB.ui(
          		{
            		method: 'feed',
            		message: 'Message here.',
            		name: 'Name of the Restaurant',
            		description: 'Adress of the Restaurant',
            		link:'https://maps.google.com/maps?saddr=40.725153500000005,-74.063848&daddr=Guerrero Deli Restaurant,6 Jordan Avenue, Jersey City',
            	 	picture: 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CoQBgAAAAK0YplYnimH7y8TjQcUl3XVEto07Ir-IVlBkuZxz1Z3P51lg-sgv8xa6MMIVPxbLJsMJgU1OmZQOewkkrSafGW-7nqdNqgW3QqoJCQrsal14WO2OvqqCH8S9a6AAwy0ccPPKqBpl3VZnVuRdaLVbtVPMLrvKOOZgzDp1po9MxbL9EhCCVXR7XhHh34fnthh2YXDrGhRtfkghrxCqZtIIlQRI-66ciq-GRg&key=AIzaSyDnxFImus4mQi1h9cicwn4z_z1MkGlT3eA'
          		},
          		function(response) 
          		{
            		if (response && response.post_id)
            		{
              			alert('Post was published.');
            		} 
            		else 
            		{
              			alert('Post was not published.');
           			}
          		}
        	);  
     	}
</script>

<script>
	var currentLat;
	var currentLng;
	window.onload = function() 
	{
		  openSocket();
		  var startPos;
	
		  if (navigator.geolocation) 
		  {
		    	navigator.geolocation.getCurrentPosition(function(position) 
		    	{
		      		startPos = position;
		      		currentLat = startPos.coords.latitude;
		      		currentLng = startPos.coords.longitude;
		     		webSocket.send(startPos.coords.latitude+","+startPos.coords.longitude);
		    	}, 
		    	function(error) 
		    	{
		      		alert("Error occurred. Error code: " + error.code);
		    	});
	
		    	navigator.geolocation.watchPosition(function(position) 
		    	{
		    		startpos = position;
		    		currentLat = startPos.coords.latitude;
		      		currentLng = startPos.coords.longitude;
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
        	 parseJSON(event.data);
        };

        webSocket.onclose = function(event)
        {
            writeResponse("Connection closed");
        };
     }
    
     function writeResponse(text)
     {
         setbox.innerHTML += "<br/>" + text;
     }
     
     function parseJSON(text)
     {
    	 var r = JSON.parse(text);
    	 //var temp=["hello","world","hello","world","hello","world","aslsafn","asfasfaf", "csdfsf","sdsdfsdf"];
    	 $(document).ready(function() 
    	 {
    		var html = $('.boxed').html();
    		for (var i=0;i<r.result.length-1;i++) 
    		{
    			$('div.box').attr('id', 'id'+i);
    			$('.boxed').append(html);
    		}
    		//not inside for loop
    		var ID = 0;
    		$('div.box').each(function() 
    		{
    		 	ID++;
    			$(this).attr('id', 'id'+ID);
    			$(this).attr('onclick', 'location.href="https://maps.google.com/maps?saddr='+currentLat+','+currentLng+'&daddr='+r.result[i].name+','+r.result[i].vicinity+'"');
    		});
    		
    		var id = 0;
    		var i=0;
    		$('div.setbox').each(function() 
    		{
    		 	id++;
    			$(this).attr('id', 'id'+id);				
    			if(i!=r.result.length)
    			{
    				var check=r.result[i];
    				$(this).append("<br/>" + r.result[i].name);
    			}
    			i++;
    		});	
    	}); 
     }
    
     
     function onError(event) 
     {
         alert(event.data);
     }
     
</script>
</head>

<body>
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
	<button name="my_full_name" onclick="fb_publish()" value="My Name"></button>
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
						<li><a href="#about">Home</a></li>
						<li><a href="#search">Search</a></li>
						<li><a href="#profile">Profile</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-->
		</nav>
	</header>

	<div class="container">
	<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img src="..." alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    <div class="item">
      <img src="..." alt="...">
      <div class="carousel-caption">
        ...
      </div>
    </div>
    ...
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
		<div class="row boxed">
			<div class="col-lg-4" >
				<div class="box" onclick="location.href='#'"  size="20">
					<div class="box-title" >
						<h1>Lorem Ipsum</h1>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="setbox"></div>
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
