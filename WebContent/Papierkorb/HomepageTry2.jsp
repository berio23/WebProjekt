<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>La Homepage</title>
<link rel="stylesheet" type="text/css" href="HomepageCSS.css">
</head>
<body>
	<style type="text/css">
div.rezepte {
	background-color: #d3d3d3;
	margin: 10px;
}

td.ee {
	font-size: 1.5em;
}

table {
	border: 0;
}

td.tag {
	font-size: 0.8em;
	background-color: #fad08c;
	letter-spacing: 1px;
}

td.uf {
	font-size: 0.8em;
	background-color: #fad08c;
	letter-spacing: 8px;
}

button.add {
	background-color: #26bf82;
	text-color: white;
}


</style>
<script type="text/javascript">
	var counter = 0
	function request(filename,create){
		var oreq = new XMLHttpRequest();
	
		oreq.onreadystatechange = function() {
			if (oreq.readyState == 4) {
				if (oreq.status == 200) {
	
					var searchId = '.'; // Gesuchte ID-Rezept
					str = '\u003ctable[^\0@]*@*' + searchId
							+ '[^\0i]*[^@]*\u002ftable\u003e'; // regex f�r ID-Rezept
					var reg = new RegExp(str, 'g');
					rezepte = oreq.responseText.match(reg); // suche naach dem ID-Rezept
	
					if (rezepte != null) { // pr�fung, ob das vohanden ist 
						var random = Math.floor(Math.random() * rezepte.length)
						var my_div = newDiv = null;
						if (create == false){
							newDiv = document.getElementById("rezeptBlock");
							newDiv.innerHTML = '<form action="IngredientsCalc" method="get">	<table border="1"  ><tr><td><button type="button" onclick="buttonprevious()">Previous</button></td> <td  align="center" width="100"> Bild</td><td id="tdRezept" >'+ rezepte[random] + '</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td><td><button type="button" onclick="buttonnext()">Next</button></td>	</tr></table> </form>';
						}
						else{
							var newDiv = document.createElement("div"); // ein Kontainer erstellen f�r die Kategorie
							newDiv.setAttribute("id","rezeptBlock");
							newDiv.setAttribute("class","rezepte");
							newDiv.innerHTML = '<form action="IngredientsCalc" method="get">	<table border="1"  ><tr><td><button type="button" onclick="buttonprevious()">Previous</button></td> <td  align="center" width="100"> Bild</td><td id="tdRezept" >'+ rezepte[random] + '</td>		<td valign="bottom"> <input name="addToList" class="add" type="submit" value="+"></td><td><button type="button" onclick="buttonnext()">Next</button></td>	</tr></table> </form>';
							my_div = document.getElementById("out");
							my_div.appendChild(newDiv);
						}
						var beschreibung = document.getElementsByClassName("be"); // Rezeptzubereitung ausblenden
	
						for (i = 0; i < beschreibung.length; i++) {
							beschreibung[i].innerHTML = "";
						}
	
						var zutatenliste = document.getElementsByClassName("zu"); // Zutatenliste ausblenden
						for (i = 0; i < zutatenliste.length; i++) {
							zutatenliste[i].innerHTML = "";
						}
	
						var zutatenServlet = document.getElementsByClassName("ser"); // Zutaten f�r Servlet-Bearbeitung ausblenden
						for (i = 0; i < zutatenServlet.length; i++) {
							zutatenServlet[i].innerHTML ="" ;
						}
					} else { // wenn keine ID-Rezept vorhanden ist....
						var my_div = newDiv = null;
						var newDiv = document.getElementById("rezeptBlock");
						newDiv.innerHTML = '<button type="button" onclick="buttonprevious()">Previous</button>:(<button type="button" onclick="buttonnext()">Next</button>';
						my_div = document.getElementById("out");
						my_div.appendChild(newDiv);
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
	window.addEventListener('DOMContentLoaded', (event) => {
		counter = 0;request("DB-KategorieE.html",true);
	});
	function buttonnext(){
		if (counter == 0){
			counter++;
			request("DB-KategorieX.html",false);
		}
		else if (counter == 1){
			counter++;
			request("DB-KategorieY.html",false); //no id
		}
		else if (counter == 2){
			counter++;
			request("DB-KategorieZ.html",false);
		}
		else if (counter == 3){
			counter = 0;
			request("DB-KategorieE.html",false);
		}
	}
	function buttonprevious(){
		if (counter == 0){
			counter = 3;
			request("DB-KategorieZ.html",false);
		}
		else if (counter == 1){
			counter--;
			request("DB-KategorieE.html",false);
		}
		else if (counter == 2){
			counter--;
			request("DB-KategorieX.html",false);
		}
		else if (counter == 3){
			counter--;
			request("DB-KategorieY.html",false); // no id
		}
	}
</script>
	<div id="navigation">
		<form>
		<h2 id="kate">Kategorien</h2>
		<table>
		
			<tr>
				<td><button class="btn-hover color-1">Fleisch</button></td><td><button class="btn-hover color-1">Vegetarisch</button></td><td><button class="btn-hover color-1">Vegan</button></td>
				<td rowspan="2"><div class="form__group field">
		<input type="text"  class="form__field" placeholder="Search" name="search" id='search'> <label for="search" class="form__label">Search...</label>
	</div></td>
			</tr>
			
			<tr>
				<td><button class="btn-hover color-1">Nudeln</button></td><td><button class="btn-hover color-1">Reis</button></td><td><button id="rezept-button" class="btn-hover color-1" formaction="NewRecipe3.jsp">+Rezept</button></td>
			</tr>
			
		
		</table>
		
		</form>
	</div>
	
	
	<table border="4">

		<tr>
			<td><h2>Homepage</h2></td>
		</tr>
		<tr>
			<td width="600" valign="top">
				<div class="scrollPage" id="out"></div>
			</td>

			<td width="200" valign="top" align="center"><div id="einkaufdiv">
					<img id="bild"
				src="https://image.flaticon.com/icons/png/128/590/590510.png"
				alt="Einkaufsliste" width="40px" height="40px">
					<div id="innereinkauf">

						<ul>

							<jsp:useBean id="liste" class="beans.Einkaufsliste"
								scope="session" />


							<jsp:useBean id="alteEinkaufsliste"
								class="beans.AlteEinkaufsliste" scope="session" />

							<c:if test="${(fn:length(liste.allIngr)) > 0}">
								<jsp:setProperty property="news" name="alteEinkaufsliste"
									value="${liste.allIngr}" />
							</c:if>




							<c:if test="${(fn:length(alteEinkaufsliste.alteIngr)) > 0}">
								<c:forEach items="${alteEinkaufsliste.alteIngr}" var="el">
									<li><c:out value="${el}" /></li>
								</c:forEach>
							</c:if>



						</ul>
					</div>
					<form><button id="hinzu" class="btn-hover color-1" formaction="EinkaufslisteAnzeigen.html">Einkaufsliste erstellen</button></form>
				</div></td>


		</tr>

	</table>
</body>
</html>