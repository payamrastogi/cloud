<!--[if lt IE 7]><html lang="en" class="no-js ie6"><![endif]-->
<!--[if IE 7]><html lang="en" class="no-js ie7"><![endif]-->
<!--[if IE 8]><html lang="en" class="no-js ie8"><![endif]-->
<!--[if gt IE 8]><!-->
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


<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/modernizr.custom.32033.js"></script>
<script src="http://www.parsecdn.com/js/parse-1.3.5.min.js"></script>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<script type="text/javascript">

Parse.initialize("vwftD52imOBMOLEpUWlTUD52WjoxO8GAlMwIsh63", "uZ0E9tAtgRmWP24stwM78PruTWdlFZGwJz8uFF41");
var CheckingInObject = Parse.Object.extend("CheckingIn");
var sharingObject = Parse.Object.extend("Sharing");
var facebookId = <%= session.getAttribute("facebookId") %>
function saveToParse(name, checkedInAt) {
	var checkingInObject = new CheckingInObject();
	//console.log("2");
	checkingInObject.set("name", name);
	checkingInObject.set("facebookId", facebookId);
	checkingInObject.set("checkedInAt", checkedInAt);
	checkingInObject.save(null, {
		  success: function(checkingInObject) {
		    // Execute any logic that should take place after the object is saved.
		    alert('you are checked in successfully');
		  },
		  error: function(checkingInObject, error) {
		    // Execute any logic that should take place if the save fails.
		    // error is a Parse.Error with an error code and message.
		    alert('Failed to create new object, with error code: ' + error.message);
		  }
		});
}

function getDetails(i,name)
{
	var query = new Parse.Query(CheckingInObject);
	query.equalTo("name", name);
	query.find(
	{
		  success: function(results) 
		  {
			  $("#popOverBox"+i).append('<p># CheckedIn: '+results.length+'</p>');
		    
		  },
		  error: function(error) 
		  {
		    alert("Error: " + error.code + " " + error.message);
		  }
		}
	);
	
	var query2 = new Parse.Query(sharingObject);
	query2.equalTo("name", name);
	query2.find(
	{
		  success: function(results) 
		  {
		    //alert("Successfully retrieved " + results.length + " scores.");
		    // Do something with the returned Parse.Object values
			  $("#popOverBox"+i).append('<p># Shared: '+results.length+'</p>');
		  },
		  error: function(error) 
		  {
		    alert("Error: " + error.code + " " + error.message);
		  }
		}
	);
}
var getd=getDetails(name);
//$(document).ready(function(){ getDetails("21 Club");});
</script>
<script type="text/javascript">

    FB.init({
        appId: '404087249752808',
        status: true, 
        cookie: true, 
        xfbml: true
    }); 
    
    function saveToParseSharing(name) {
    	console.log("print 0");
    	var so = new sharingObject();
    	console.log("1");
    	so.set("name", name);
    	so.set("facebookId", facebookId);
    	so.save(null, {
    		  success: function(so) {
    		    // Execute any logic that should take place after the object is saved.
    		    alert('saved successfully');
    		  },
    		  error: function(checkingInObject, error) {
    		    // Execute any logic that should take place if the save fails.
    		    // error is a Parse.Error with an error code and message.
    		    alert('Failed to create new object, with error code: ' + error.message);
    		  }
    		});
    }
    
    function fb_publish(name, link, picture) 
    {
        FB.ui(
          		{
            		method: 'feed',
            		message: 'Message here.',
            		name:name ,
            		//description:address,
            		link: link,
            	 	picture: picture
          		},
          		function(response) 
          		{
            		if (response && response.post_id)
            		{
              			alert('Post was published.');
              			saveToParseSharing(name);
              			//alert("hello");
            		} 
            		else 
            		{
              			alert('Post was not published.');
           			}
          		}
        	);  
     	}
</script>

<script type="text/javascript">

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
     function onSearch()
     {
    	 
    	 $('div.boxed').empty();
    	 $('.boxed').append('<div class="col-lg-4 col-xs-12" ><div class="box" size="20" id="hello"><div class ="col-lg-12 col-xs-12 title-bag" ><div class="box-title col-lg-6 col-xs-12" data-placement="bottom"  ></div><div class="col-lg-2 col-xs-4"><img class ="location" src="img/eco/location.png" /></div><div class="col-lg-2 col-xs-4"><img class ="share" src="img/eco/share.png" /></div><div class="col-lg-2 col-xs-4"><img class ="checkingIn" src="img/eco/check.png" /></div></div><div class="row"><div class="col-lg-12"><div class="setbox"></div></div></div></div>');
    	 var searchInput = document.getElementById('txtSearch').value;
    	 //alert(searchInput);
    	 webSocket.send('@'+searchInput);
     }
     
     function parseJSON(text)
     {
		var r = JSON.parse(text);
     	//alert(r.result[0].rating);
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
    			
    		});
    		
    		var id = 0;
    		var i=0;
    		$('div.box-title').each(function() 
    		{
    		 	id++;
    			$(this).attr('id', 'id'+id);				
    			if(i!=r.result.length)
    			{
    				var check=r.result[i];
    				$(this).append("<h1>" + r.result[i].name+"</h1>  " );
    				$(this).attr('rel', 'popover'+id);
    			}
    			i++;
    		});
    		var id = 0;
    		var i=0;
    		var ids = 0;
    		var j=0;
    		$('div.setbox').each(function() 
    		{
    		 	ids++;
    			$(this).attr('id', 'id'+ids);	
    			if(j!=r.result.length)
    			{
    				var check=r.result[j];
    				function altimg(){
    					
    				}
    				if(r.result[j].photoReference!='')
    					$(this).append("<img src=https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="+r.result[j].photoReference+"&key=AIzaSyDnxFImus4mQi1h9cicwn4z_z1MkGlT3eA alt='' onerror='this.onerror=null;this.src=http://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png' style='width:100px; float:right; padding-top:25px;' />");
    				else 
    					$(this).append("<img src="+r.result[j].icon+" alt='' onerror='this.onerror=null;this.src=http://maps.gstatic.com/mapfiles/place_api/icons/restaurant-71.png' style='width:100px; float:right; padding-top:25px;' />");
    					
    				$(this).append("<br/>" + r.result[j].vicinity);
    				if(r.result[j].open ==true)
    				{
    					$(this).append("<br/> It's open");
    				}
    				else if(r.result[j].open ==false)
    				{
    					$(this).append("<br/> It's closed");
    				}
    				else
    				{
    					$(this).append("<br/> Not Available");
    				}
    				var rating=((r.result[j].rating)*20)+"%";
    				$(this).append("<br/>Rating:"+r.result[j].rating+"<div class='rating_bar'><div  class='rating' style='width:"+rating +"%' ></div></div>");
    			}
    			j++;
    		});	
    		var ids = 0;
    		var j=0;
    		$('img.location').each(function() 
    	    {
    	    	ids++;
    	    	$(this).attr('id', 'id'+ids);	
    	    	if(j!=r.result.length)
    	    	{
    	    		var check=r.result[j];
    	    		$(this).attr('onclick', 'location.href="https://maps.google.com/maps?saddr='+currentLat+','+currentLng+'&daddr='+r.result[j].name+','+r.result[j].vicinity+'"');			
    	    	}
    	    	j++;
    	    });	
    		
    		var ids = 0;
      		var j=0;
      		$('img.share').each(function() 
      	    {
      	    	ids++;
      	    	$(this).attr('id', 'id'+ids);	
      	    	if(j!=r.result.length)
      	    	{
      	    		var name=r.result[j].name;
      	    		var address=r.result[j].vicinity;
      	    		var link='https://maps.google.com/maps?saddr='+currentLat+','+currentLng+'&daddr='+r.result[j].name+','+r.result[j].vicinity;
      	    		var picture='https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference='+r.result[j].photoReference+'&key=AIzaSyDnxFImus4mQi1h9cicwn4z_z1MkGlT3eA'; 
      	    		$(this).attr('onclick', 'fb_publish("'+ name +'","'+ link +'","'+ picture +'")');
      	    	}
      	    	j++;
      	    });	
    		
      		var ids = 0;
      		var j=0;
      		$('img.checkingIn').each(function() 
      	    {
      	    	ids++;
      	    	$(this).attr('id', 'id'+ids);	
      	    	if(j!=r.result.length)
      	    	{
      	    		var name=r.result[j].name;
      	    		var d = new Date();
      	    		$(this).attr('onclick', 'saveToParse("'+name+'","'+ d +'")');
      	    		//$(this).attr('onclick', 'getDetails("'+name+'")');
      	    	}
      	    	j++;
      	    });	
      		
      		for (var i=1;i<r.result.length;i++) 
    		{
      			$("[rel='popover"+i+"']").popover({
      	    		html: 'true', 
      	    		content : '<div id="popOverBox'+i+'" onclick="getDetails(\''+i+'\',\''+r.result[i-1].name+'\')">View Details</div>'
      	    		});
    		}
    	}); 
	    console.log(JSON.parse(text));
     }
    
     function onError(event) 
     {
         alert(event.data);
     }
	function run(id)
	{
    		
	}

</script>
<script>
        $(document).ready(function() {
            appMaster.preLoader();
        }); 
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
	
	<header>


		<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="fa fa-bars fa-lg"></span>
					</button>
					<div class="row">
					<div class="col-lg-3">
					<a class="navbar-brand" href="index.html"> <img
						src="img/eco/logo.png" alt="" class="logo">
					</a>
					</div>
				
			
 					 <div class="col-lg-5">
   						 <div class="input-group pad-top">
     						<input type="text" class="form-control" id="txtSearch" name="txtSearch" placeholder="Search for...">
     						<span class="input-group-btn">
       							 <button class="btn btn-default" type="button" id="btnSearch" name="btnSearch" onclick=onSearch() >Go!</button>
     					 	</span>
   						 </div><!-- /input-group -->
  				</div><!-- /.col-lg-6 -->
  				<!-- /.row -->
				<!-- Collect the nav links, forms, and other content for toggling -->
					 <div class="col-lg-3">
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">

					<ul class="nav navbar-nav navbar-right">
						<li><a href="index.jsp">Home</a></li>
						<li><a href="#search">Search</a></li>
						<li><a href="./profile">Profile</a></li>
					</ul>
				</div>
				</div>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-->
			</div>
		</nav>
		
	</header>

 <div class="container">
	
	<!-- carousal -->
		<div class="row boxed">
			<div class="col-lg-4 col-xs-12" >
				<div class="box" size="20" id="hello">
				<div class ="col-lg-12 col-xs-12 title-bag" >
					<div class="box-title col-lg-6 col-xs-12" data-placement='bottom'>
					<!-- 	<h1>Lorem Ipsum</h1> -->
					</div>
					<div class="col-lg-2 col-xs-4"><img class ='location' src='img/eco/location.png' /></div>
					<div class="col-lg-2 col-xs-4"><img class ='share' src='img/eco/share.png' /></div>
					<div class="col-lg-2 col-xs-4"><img class ='checkingIn' src='img/eco/check.png'/></div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="setbox"></div>
							
						</div>
					</div>
				</div>
			</div>
			  
		</div>
		<a title='Bottom Popover' rel='popover' data-placement='bottom'>
Bottom Popover</a>
		  </div>	
	<script src="js/slick.min.js"></script>
	<script src="js/placeholdem.min.js"></script>
	<script src="js/rs-plugin/js/jquery.themepunch.plugins.min.js"></script>
	<script src="js/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
	<script src="js/waypoints.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="js/script.js"></script>
	

</body>

</html>
