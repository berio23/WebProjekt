<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
   
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<script >




var req = new XMLHttpRequest();


req.onreadystatechange=function (){
	if(req.readyState==4){
		if(req.status==200){
	
			
			var searchId ='.'; // Gesuchte ID-Rezept
			str='\u003ctable[^\0@]*@*'+searchId+'[^\0i]*[^@]*\u002ftable\u003e';	 // regex f�r ID-Rezept
			var reg= new RegExp(str, 'g');
			rezepte=req.responseText.match(reg); // suche naach dem ID-Rezept
			
			if(rezepte!=null){ // pr�fung, ob das vohanden ist 
			
			for(n=0;n<rezepte.length; n++){ // es k�nnen mehrere Rezepte der Suche entsprechen
			var my_div = newDiv = null;
			var newDiv = document.createElement("div"); // f�r jeden Rezept wird ein neues Kontainer erstellt und mit den Daten aus der Datenbank bef�llt
	        newDiv.innerHTML = '<div id="rezeptBlock" class="rezepte"> <form action="IngredientsCalc" method="get">	<table border="1"  ><tr> <td  align="center" width="100"> Bild</td><td id="tdRezept" >'+rezepte[n]+'</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td>	</tr></table> </form>';
			my_div = document.getElementById("out");
	    	my_div.appendChild(newDiv);
	    	
	    	
	    	
	    
			
			}
			
			var beschreibung = document.getElementsByClassName("be"); // Rezeptzubereitung ausblenden
	    	
	    	for (i=0; i<beschreibung.length; i++){
	    		beschreibung[i].innerHTML ="" ;
	    	}
	    	
	    	var zutatenliste = document.getElementsByClassName("zu"); // Zutatenliste ausblenden
	    	for (i=0; i<zutatenliste.length; i++){
	    		zutatenliste[i].innerHTML ="" ;
	    	}
			
			
			var zutatenServlet = document.getElementsByClassName("ser"); // Zutaten f�r Servlet-Bearbeitung ausblenden
	    	for (i=0; i<zutatenServlet.length; i++){
	    		//zutatenServlet[i].innerHTML ="" ;
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


req.open('GET', 'DB-KategorieZ.html', true);



req.send();






</script>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
<title>Insert title here</title>
</head>
<body>



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
	
	
 <div id="checklist">
  <input id="01" type="checkbox" name="r" value="1" checked>
  <label for="01">Brot</label>
  <input id="02" type="checkbox" name="r" value="2">
  <label for="02">Quark</label>
  <input id="03" type="checkbox" name="r" value="3">
  <label for="03">Sucuk</label>
</div>

<table >

<tr><td><h2>Kategoriename</h2></td><td><img id="bild" src="https://image.flaticon.com/icons/png/128/590/590510.png" alt="Einkaufsliste" width="40px" height="40px"></td></tr>
<tr>
<td width="600" valign="top">
<div class="scrollPage" id="out"  >
</div>
</td>

<td width="200" valign="top" align="center"><div id="einkaufdiv">

<div id="innereinkauf" >

<ul>

	<jsp:useBean id="liste" class="beans.Einkaufsliste" scope="session"/>
	
		
	   <jsp:useBean id="alteEinkaufsliste" class="beans.AlteEinkaufsliste" scope="session"/>
	   
	   <c:if test="${(fn:length(liste.allIngr)) > 0}" >
	   			<jsp:setProperty property="news" name="alteEinkaufsliste" value="${liste.allIngr}"/>
	   </c:if>
	
	
		
		
		<c:if test="${(fn:length(alteEinkaufsliste.alteIngr)) > 0}" >			
	   			<c:forEach items="${alteEinkaufsliste.alteIngr}" var="el">
					<li><c:out value="${el}"/></li>
	   			</c:forEach>
		</c:if>
	
	

</ul>
</div>
<div class="cont">	
<button id="hinzu" type="button" class="btn"><span id="span">Einkaufsliste erstellen</span><img src="https://i.cloudup.com/2ZAX3hVsBE-3000x3000.png" height="62" width="62"></button>
	
    
</div>
</div></td>


</tr>

</table>
</body>
</html>