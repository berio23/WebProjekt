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
<link rel="stylesheet" type="text/css" href="style.css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">	var counter = 0
function request(filename,create){
	var oreq = new XMLHttpRequest();
	var tempstring = "";
	oreq.onreadystatechange = function() {
		if (oreq.readyState == 4) {
			if (oreq.status == 200) {

				var searchId = '.'; // Gesuchte ID-Rezept
				str = '\u003ctable[^\0@]*@*' + searchId
						+ '[^\0i]*[^@]*\u002ftable\u003e'; // regex fÃ¼r ID-Rezept
				var reg = new RegExp(str, 'g');
				rezepte = oreq.responseText.match(reg); // suche naach dem ID-Rezept

				if (rezepte != null) { // prÃ¼fung, ob das vohanden ist 
					var random = Math.floor(Math.random() * rezepte.length)
					var my_div = newDiv = null;
					if (create == false){
						newDiv = document.getElementById("rezeptBlock");
					}
					else{
						var newDiv = document.createElement("div"); // ein Kontainer erstellen fÃ¼r die Kategorie
						newDiv.setAttribute("id","rezeptBlock");
						newDiv.setAttribute("class","rezepte");
						newDiv.innerHTML = '';
						my_div = document.getElementById("out");
						my_div.appendChild(newDiv);
					}
					
					tempstring = '<td id="tdRezept" >'+ rezepte[random] + '</td>';
					var rezeptID = $('#tdRezept','<div><table>'+ tempstring +'</table></div>').children().attr('id'); //get id of table in Kategorie
					console.log(rezeptID);
					var path = '${pageContext.request.contextPath}/images/' + rezeptID + '.jpg';
					var bild = '<td align="center" width="300"><image width="300px" height="300px" src ="' + path +'"></td>';
					
					newDiv.innerHTML = '<form action="IngredientsCalc" method="get"> <input type="hidden" name="calc" value="true"><input type="hidden" name="goTo" value="/KategorienNew.jsp"><table border="1" id="tablette" ><tr><td><button type="button" onclick="buttonprevious()">Previous</button></td>' + bild + tempstring + '<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td><td><button type="button" onclick="buttonnext()">Next</button></td>	</tr></table> </form>';
					
					var beschreibung = document.getElementsByClassName("be"); // Rezeptzubereitung ausblenden

					for (i = 0; i < beschreibung.length; i++) {
						beschreibung[i].innerHTML = "";
					}

					var zutatenliste = document.getElementsByClassName("zu"); // Zutatenliste ausblenden
					for (i = 0; i < zutatenliste.length; i++) {
						zutatenliste[i].innerHTML = "";
					}

					var zutatenServlet = document.getElementsByClassName("ser"); // Zutaten fÃ¼r Servlet-Bearbeitung ausblenden
					for (i = 0; i < zutatenServlet.length; i++) {
						zutatenServlet[i].innerHTML ="" ;
						
						
						
						  for(n=0;n<rezepte.length; n++){ // es kÃ¶nnen mehrere Rezepte der Suche entsprechen
								var my_div = newDiv = null;
								var pp = document.getElementById("pp");
								
								

								  pp.innerHTML = '<form action="IngredientsCalc" method="get"><button type="button" onclick="buttonprevious()">Previous</button><input type="hidden" name="goTo" value="/HomePageNew.jsp"> <input type="hidden" name="calc" value="true">	<table border="1"  ><tr> <td  align="center" width="100px" > Bild</td><td id="tdRezept" width="450px" >'+rezepte[n]+'</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td>	</tr></table></form>';
								  


						    	
						    	
								
								}
								
						
						
					}
				} else { // wenn keine ID-Rezept vorhanden ist....
					var my_div = newDiv = null;
					var newDiv = document.getElementById("rezeptBlock");
					newDiv.innerHTML = '<button type="button" onclick="buttonprevious()">Previous</button>:(<button type="button" onclick="buttonnext()">Next</button>';
				}
				
				
				
				
			}
			if (oreq.status == 404) {
				console.log('File or resource not found');
			}
		}

	};
	oreq.open('GET', filename, true);
	oreq.send();
}
$(document).ready(function() {
	counter = 0;
	request("DB/DB-KategorieP.html",true);
	$('#rezeptBlock').css( "border", "3px solid pink" );
});
function buttonnext(){
	if (counter == 0){
		counter++;
		request("DB/DB-KategorieP.html",false);
	}
	else if (counter == 1){
		counter++;
		request("DB/DB-KategorieP.html",false); //no id
	}
	else if (counter == 2){
		counter++;
		request("DB/DB-KategorieP.html",false);
	}
	else if (counter == 3){
		counter = 0
		request("DB/DB-KategorieP.html",false);
	}
}
function buttonprevious(){
	if (counter == 0){
		counter = 3;
		request("DB/DB-KategorieP.html",false);
	}
	else if (counter == 1){
		counter--;
		request("DB/DB-KategorieP.html",false);
	}
	else if (counter == 2){
		counter--;
		request("DB/DB-KategorieP.html",false);
	}
	else if (counter == 3){
		counter--;
		request("DB/DB-KategorieP.html",false); // no id
	}
}</script>


</head>
<body>
    <nav class="nav">
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
            <span class="navTrigger">
                <i></i>
                <i></i>
                <i></i>
            </span>
        </div>
    </nav>

    <section class="home">
    hehfahfiashfiashfiashf
    </section>
    <div style="height: 450px; background-color:#a9f5a6">
        <!-- just to make scrolling effect possible -->
            <table border="1" width="100%" height="100%">
            <tr>
                <td width="70%"><table border="1" width="100%" height="90%">

        <tr>
            <td width="600" valign="top">
                <div class="scrollPage" id="out"></div>
            </td></tr></table></td>

            <td class="colo" id="collapsee"><p>
  <a id="btnliste" class="btn btn-primary" data-bs-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
    <img id="bild"
                            src="https://image.flaticon.com/icons/png/128/590/590510.png"
                            alt="Einkaufsliste" width="40px" height="40px">
  </a>
</p>
<div class="collapse" id="collapseExample">
  <div class="card card-body">
    <div id="innereinkauf">
                        <img id="bild"
                            src="https://image.flaticon.com/icons/png/128/590/590510.png"
                            alt="Einkaufsliste" width="40px" height="40px">
                        <ul>	 
		
				<!-- Ausgabe der alten Einkaufsliste -->
				 <div id="checklist">
			<jsp:useBean id="liste" class="beans.Einkaufsliste" scope="application"/> <!-- Ändern zur "session" -->
	 
		
				<!-- Ausgabe der alten Einkaufsliste -->
				<% int counter=0; %> 
	   			<c:forEach items="${liste.result}" var="el">
	   				<% if( counter<17){ %> <!-- nur die ersten 17 Zutaten sollten gezeigt werden, damit die Liste nicht zu voll wird -->
	   					<% counter++; %>	   			
	   					<input type="checkbox" ><label ><c:out value="${el}"/></label> 
	   				<% } %>
	   				<% if( counter==17){ %>
	   					<% counter++; %>	   			
	   					<input type="checkbox" ><label ><c:out value="........"/></label>  
	   				<% } %> 	
				</c:forEach>
			
				
	   			
</div>



                        </ul>
                        <ul class="list-group list-group-flush">
                          <li class="list-group-item">Tomate</li>
                          <li class="list-group-item">Apfel</li>
                          <li class="list-group-item">Salat</li>
                          <li class="list-group-item">Fisch</li>
                          <li class="list-group-item">Steak</li>
                        </ul>
                    </div><form>
                            
  <button id="hinzu" class="btn-hover color-8" formaction="EinkaufslisteAnzeigen.html">Einkaufsliste erstellen</button>

                        </form>
  </div>
</div></td>

                
            </tr>
        </table>
    </main>
    </div>
</body>
<!-- Footer -->
<footer class="bg-dark text-center text-white">
  <!-- Grid container -->
  <div class="container p-4">



    <!-- Section: Text -->
    <section class="mb-4">
      <p>
        Reclist ist eine Webanwendung, welche das schnelle und intuitive erstellen eines Rezeptes ermöglicht.
        Hierbei ist die Auswahl von Rezepten aus aller Welt zu treffen, wobei eigene Rezepte ebenfalls einfach
        über die <a href="#">Rezept hinzufügen</a> Seite einfach hinzugefügt werden kann. Reclist stellt dir nach
        deiner Auswahl automatisch deine Einkaufsliste bereit. Kochvorbereitung war noch nie so einfach!
      </p>
    </section>
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
        $(document).scroll(function() {
          var y = $(this).scrollTop();
          if (y > 300) {
            $('.colo').fadeIn();
          } else {
            $('.colo').fadeOut();
          }
        });

    
    </script>
</body>
</html>
