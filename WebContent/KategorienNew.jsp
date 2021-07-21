<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
<link rel="stylesheet" href="node_modules/mdbootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="node_modules/mdbootstrap/css/mdb.min.css">
<link rel="stylesheet" href="node_modules/mdbootstrap/css/style.css">
<link rel="stylesheet" type="text/css" href="KategorienNew.css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">	var req = new XMLHttpRequest();


req.onreadystatechange=function (){
	if(req.readyState==4){
		if(req.status==200){
	
			
			
			
			var searchId ='.'; // Gesuchte ID-Rezept
			str='\u003ctable[^\0@]*@*'+searchId+'[^\0i]*[^@]*\u002ftable\u003e';	 // regex fÃ¼r ID-Rezept
			var reg= new RegExp(str, 'g');
			rezepte=req.responseText.match(reg); // suche naach dem ID-Rezept
			
			if(rezepte!=null){ // prÃ¼fung, ob das vohanden ist 
			
			for(n=0;n<rezepte.length; n++){ // es kÃ¶nnen mehrere Rezepte der Suche entsprechen
			var my_div = newDiv = null;
			var newDiv = document.createElement("div"); // fÃ¼r jeden Rezept wird ein neues Kontainer erstellt und mit den Daten aus der Datenbank befÃ¼llt

	        newDiv.innerHTML = '<table ><tr><td><div id="rezeptBlock" class="rezepte"> <form action="IngredientsCalc" method="get">	<input type="hidden" name="calc" value="true"><input type="hidden" name="goTo" value="/KategorienNew.jsp"> <table border="1"  ><tr> <td  align="center" width="100px" > Bild</td><td id="tdRezept" width="450px" >'+rezepte[n]+'</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td>	</tr></table></form></div></td><td ><div class="vorschau" style="height:100%;" ></div></td></tr><table>';
  
	         
			my_div = document.getElementById("out");
	    	my_div.appendChild(newDiv);
	    	
	    	
			
			}
			
			
			//Tasten zum Rezeptvorschau einfügen
			var rezeptID = document.getElementsByClassName("rezeptID"); // Name von einem Rezept=Link zur Rezeptvorschau
    	   	for (i=0; i<rezeptID.length; i++){
    			var n=rezeptID[i].innerHTML;	    		
    		//	document.getElementsByClassName("vorschau")[i].innerHTML='<form action="RezeptVorschau2.jsp"><input type="hidden" name="list" value="'+n+'"><input type="submit" id="rezeptSeite"  class="nB"  style="height:123px;" value=">" ></form>';
    		
			
    	   	document.getElementsByClassName("vorschau")[i].innerHTML='<form action="IngredientsCalc"><input type="hidden" name="calc" value="false"><input type="hidden" name="vorschau" value="'+n+'"><input type="hidden" name="goTo" value="/RezeptVorschau2.jsp"><input type="submit" id="rezeptSeite"  class="nB"  style="height:123px;" value=">" ></form>';
		}
		
			var rid = document.getElementsByClassName("rezeptID"); // RezeptID ausblenden
	    	
	    	for (i=0; i<rid.length; i++){
	    		rid[i].innerHTML ="" ;
	    	}
			
			var beschreibung = document.getElementsByClassName("be"); // Rezeptzubereitung ausblenden
	    	
	    	for (i=0; i<beschreibung.length; i++){
	    		beschreibung[i].innerHTML ="" ;
	    	}
	    	
	    	var zutatenliste = document.getElementsByClassName("zu"); // Zutatenliste ausblenden
	    	for (i=0; i<zutatenliste.length; i++){
	    		zutatenliste[i].innerHTML ="" ;
	    	}
			
			

			
			}else{ // wenn keine ID-Rezept vorhanden ist....
				var my_div = newDiv = null;
				var newDiv = document.createElement("div");
		        newDiv.innerHTML = ":(";
				my_div = document.getElementById("out");
		    	my_div.appendChild(newDiv);
				}
			
			
		
			}
		if (req.status==404){
			console.log('File or resource not found');
		}
	}

};



req.open('GET', 'DB/DB-KategorieP.html', true);




req.send();
</script>


</head>
<body>
    <nav class="navKat">
        <div class="container">
            <div class="logo">
                <a href="#"><img src="logo.png"></a>
            </div>
            <div id="mainListDiv" class="main_list">
                <ul class="navlinks">
                    <li><a href="#">Fleisch</a></li>
                    <li><a href="#">Vegetarisch</a></li>
                    <li><a href="#">Vegan</a></li>
                    <li><a href="#">Nudeln</a></li>
                    <li><a href="#">Reis</a></li>
                    <li><a href="#">+Rezept</a></li>
                    <li><a href="#">
                            <form class="form-inline">
                                <input class="form-control" type="search" placeholder="Search" aria-label="Search">
                            </form>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <button class="btn btn-outline-success" type="submit">Search</button>
                        </a>
                    </li>

                     
                </ul>
            </div>
            <span class="navTriggerKat">
                <i></i>
                <i></i>
                <i></i>
            </span>
        </div>
    </nav>

    <section class="homeKat">
   
    	
    </section>
        <!-- just to make scrolling effect possible -->
               <div style="padding-top: 6em; max-height: 100%; background-color:lightgrey">
           
            	<table class="bigTable" >
		<tr><td><h2>Kategoriename</h2></td><td><img id="bild" src="https://image.flaticon.com/icons/png/128/590/590510.png" alt="Einkaufsliste" width="40px" height="40px"></td></tr>
<tr>
<td width="600" valign="top">
<div class="scrollPage" id="out" >

</div>
</td>

<td width="200" valign="top" align="center">
<div id="einkaufdiv">
	
<!-- Einkaufsliste -->
<div id="innereinkauf" >
<div align="right">
	    <form action="IngredientsCalc" method="get">	
<input type="hidden" name="calc" value="deleteAll">
<input type="hidden" name="goTo" value="/KategorienNew.jsp">
 <input type="submit" value="Alles löschen">
 </form>  
 </div>
	   
			<jsp:useBean id="liste" class="beans.Einkaufsliste" scope="session"/> <!-- Ändern zur "session" -->
	   	


		<ul class="list-group list-group-flush">
				<!-- Ausgabe der alten Einkaufsliste -->
				<% int counter=0; %> 
	   			<c:forEach items="${liste.result}" var="el">
	   				<% if( counter<17){ %> <!-- nur die ersten 17 Zutaten sollten gezeigt werden, damit die Liste nicht zu voll wird -->
	   					<% counter++; %>	   			
	   					<li class="list-group-item"><input type="checkbox"  ><label style="padding-left:10px;" ><c:out value="${el}"/></label> </li>
	   				<% } %>
	   				<% if( counter==17){ %>
	   					<% counter++; %>	   			
	   					<li class="list-group-item"><input type="checkbox" ><label ><c:out value="........"/></label></li>
	   				<% } %> 	
				</c:forEach>
		</ul>
		
 			


 </div>
 <div id="thebuttons">
	<form  id="rezeptvorschau" action="IngredientsCalc" method="get">	
	<input type="hidden" name="calc" value="false">
	<input type="hidden" name="goTo" value="/RezeptVorschau2.jsp">
	<input type="submit" value="Rezeptvorschau" >
	 </form>
	 
	 <form id="einkaufsliste" action="IngredientsCalc" method="get">	
	<input type="hidden" name="calc" value="false">
	<input type="hidden" name="goTo" value="/Einkaufsliste.jsp">
	<input type="submit" value="Einkaufsliste" >
	</form>
	
	 <form id="home" action="IngredientsCalc" method="get" >	
	<input type="hidden" name="calc" value="false">
	<input type="hidden" name="goTo" value="/HomePage.jsp">
	<input type="submit" value="Home">
</form>
</div>
<div class="cont">	

<button id="hinzu" type="button" class="btn"><span id="span">Einkaufsliste erstellen</span><img id="bildd" src="https://i.cloudup.com/2ZAX3hVsBE-3000x3000.png" height="62" width="62"></button>

	
   

</div>

</div></td>


</tr>

</table>
           
     
           <footer class="bg-dark text-center text-white" style="position:absolute; bottom:0px; width:100%;">
  <!-- Grid container -->
  <div class="container p-4">



    <!-- Section: Text -->
    
    <!-- Section: Text -->


    <!-- Section: Links -->
    <section class="">
      <!--Grid row-->
      <div class="row">
        <!--Grid column-->
        <div class="col-lg-12 col-md-6 mb-4 mb-md-0">
          <h5 class="text-uppercase">Informationen</h5>

          <ul class="list-unstyled mb-0">
            <li>
              <a href="#!" class="text-white">Hilfe</a>
            </li>
            <li>
              <a href="#!" class="text-white">Impressum</a>
            </li>
            <li>
              <a href="#!" class="text-white">Quellen</a>
            </li>
          </ul>
        </div>
        <!--Grid column-->

       
        <!--Grid column-->
      <!--Grid row-->
    </section>
    <!-- Section: Links -->

  </div>
  <!-- Grid container -->

  <!-- Copyright -->
  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
    2021
    Reclist
  </div>
  <!-- Copyright -->

</footer>
<!-- Footer -->
           
           </div>
          
</body>
<!-- Footer -->

    </div>

<!-- Jquery needed -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="js/scripts.js"></script>

<!-- Function used to shrink nav bar removing paddings and adding black background -->
    <script>
        $(window).scroll(function() {
            if ($(document).scrollTop() > 50) {
                $('.nav').addClass('affix');
                console.log("OK");
            } else {
                $('.nav').removeClass('affix');
            }
        });
     

    
    </script>
</body>
</html>
