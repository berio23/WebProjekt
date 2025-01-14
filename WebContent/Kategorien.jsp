<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>Kategorien</title>
<link rel="stylesheet" type="text/css" href="Kategorien.css">
</head>
<body>
<script type="text/javascript">
var req = new XMLHttpRequest();


req.onreadystatechange=function (){
	if(req.readyState==4){
		if(req.status==200){
	
			
			
			
			var searchId ='.'; // Gesuchte ID-Rezept
			str='\u003ctable[^\0@]*@*'+searchId+'[^\0i]*[^@]*\u002ftable\u003e';	 // regex für ID-Rezept
			var reg= new RegExp(str, 'g');
			rezepte=req.responseText.match(reg); // suche naach dem ID-Rezept
			
			if(rezepte!=null){ // prüfung, ob das vohanden ist 
			
			for(n=0;n<rezepte.length; n++){ // es können mehrere Rezepte der Suche entsprechen
			var my_div = newDiv = null;
			var newDiv = document.createElement("div"); // für jeden Rezept wird ein neues Kontainer erstellt und mit den Daten aus der Datenbank befüllt

	        newDiv.innerHTML = '<table ><tr><td><div id="rezeptBlock" class="rezepte"> <form action="IngredientsCalc" method="get">	<input type="hidden" name="calc" value="true"><input type="hidden" name="goTo" value="/Kategorien.jsp"> <table border="1"  ><tr> <td  align="center" width="100px" > Bild</td><td id="tdRezept" width="450px" >'+rezepte[n]+'</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td>	</tr></table></form></div></td><td ><div class="vorschau" style="height:100%;" ></div></td></tr><table>';
  
	         
			my_div = document.getElementById("out");
	    	my_div.appendChild(newDiv);
	    	
	    	
			
			}
			
			
			//Tasten zum Rezeptvorschau einf�gen
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
	<header>
		<div id="navigation">
			<form>
				<table>

					<tr>
						<td><button class="btn-hover color-8">Fleisch</button></td>
						<td><button class="btn-hover color-8">Vegetarisch</button></td>
						<td><button class="btn-hover color-8">Vegan</button></td>
						
					

					
						<td><button class="btn-hover color-8">Nudeln</button></td>
						<td><button class="btn-hover color-8">Reis</button></td>
						<td><button id="rezept-button" class="btn-hover color-8"
								formaction="NewRecipe3.jsp">+Rezept</button></td>
						<td rowspan="2"><div class="form__group field">
								<input type="text" class="form__field" placeholder="Search"
									name="search" id='search'> <label for="search"
									class="form__label">Search...</label>
							</div></td>
					</tr>

				</table>

			</form>
		</div>
	</header>


	<main>
	<table >
		<tr><td><h2>Kategoriename</h2></td><td><img id="bild" src="https://image.flaticon.com/icons/png/128/590/590510.png" alt="Einkaufsliste" width="40px" height="40px"></td></tr>
<tr>
<td width="600" valign="top">
<div class="scrollPage" id="out" >
</div>
</td>

<td width="200" valign="top" align="left"><div id="einkaufdiv">
	
<!-- Einkaufsliste -->
<div id="innereinkauf" >
<div align="right">
	    <form action="IngredientsCalc" method="get">	
<input type="hidden" name="calc" value="deleteAll">
<input type="hidden" name="goTo" value="/Kategorien.jsp">
 <input type="submit" value="Alles l�schen">
 </form>  
 </div>
	   
	 <div id="checklist">
			<jsp:useBean id="liste" class="beans.Einkaufsliste" scope="session"/> <!-- �ndern zur "session" -->
	   	


		
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


 </div>
<form action="IngredientsCalc" method="get">	
<input type="hidden" name="calc" value="false">
<input type="hidden" name="goTo" value="/RezeptVorschau2.jsp">
<input type="submit" value="Rezeptvorschau" >
 </form>
 
 <form action="IngredientsCalc" method="get">	
<input type="hidden" name="calc" value="false">
<input type="hidden" name="goTo" value="/Einkaufsliste.jsp">
<input type="submit" value="Einkaufsliste">
</form>

 <form action="IngredientsCalc" method="get">	
<input type="hidden" name="calc" value="false">
<input type="hidden" name="goTo" value="/HomePage.jsp">
<input type="submit" value="Home">
</form>

<div class="cont">	

<button id="hinzu" type="button" class="btn"><span id="span">Einkaufsliste erstellen</span><img src="https://i.cloudup.com/2ZAX3hVsBE-3000x3000.png" height="62" width="62"></button>

	
   

</div>

</div></td>


</tr>

</table>
	</main>
</body>
</html>