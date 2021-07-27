 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="NewRecipe3.css">
<meta charset="ISO-8859-1">
<title>Neues Rezept</title>
</head>
<body style="background-color:black">

<script src='http://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.js'></script>
<script type="text/javascript">
$(document).ready(function(){
 
 $('#button').click(function(){
   $('#txt1').val("Button clicked");
 });
});


var counter = 0;

function addIngredient(){
	
	
	var select = document.getElementById("Zutaten");
	var $tr = $(select).closest("tr");
	if (!$($tr).is(':empty')){
	
	var row = select.insertRow(0);
	
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	var cell4 = row.insertCell(3);
	var cell5 = row.insertCell(4);
	
	cell1.innerHTML = `<input  type="text" class="form__field"
		placeholder="Zutat" name="Zutat" id='zutat' required /> <label
		for="zutat" class="form__label">Zutat</label>
		`;
	cell2.innerHTML = `<input type="text" class="form__field"
		placeholder="Menge" name="Menge" id='menge' required /><label
		for="menge" class="form__label">Menge</label>
		`;
	cell3.innerHTML = `<select name="Einheit" class="select-wrapper">
		<option>Gramm</option>
		<option>Kilogramm</option>
		<option>Liter</option>
		`;
	cell4.innerHTML =`<button type="button" id="DeleteZutat" class="btn-hover color-1" onclick="removeIngredient()">Zutat löschen</button>`
	cell5.innerHTML = `<button type="button" id="AddZutat" class="btn-hover color-1" onclick="addIngredient()">+Zutat</button>`
	}
}

function removeIngredient(){
	var select = document.getElementById("Zutaten");
	
	if(select.rows.length > 1){
			var $tr = $(event.target).closest("tr");
	$tr.remove();
	}
}


function addtag(){
	var select = document.getElementById("Tags");
	
	var row = select.insertRow(0);
	
	var cell1 = row.insertCell(0);
	var cell2 = row.insertCell(1);
	var cell3 = row.insertCell(2);
	
	cell1.innerHTML = `<input name="tag" type="text" class="form__field" placeholder="Tag" name="tag"
		id='tag' required /> <label for="tag" class="form__label">Tags</label>`;
	cell2.innerHTML =`<button type="button" id="addTag" class="btn-hover color-1" onclick="addtag()">+Tag</button>`;
	cell3.innerHTML = `<button type="button" id="deleteTag" class="btn-hover color-1" onclick="removeTag()">Tag löschen</button>`;
}


function removeTag(){
	var select = document.getElementById("Tags");
	if(select.rows.length > 1){
			var $tr = $(event.target).closest("tr");
		}
			
	$tr.remove();
	
}



</script>

<form action="SaveRecipe" method="get" >

		<h1>Neues Rezept erstellen</h1>
		<div class="form__group field">
			<input type="text" class="form__field" placeholder="Name"
				name="Rezeptname" id='name' required /> <label for="name"
				class="form__label">Name des Gerichts</label>
		</div>
		<br>
		<input type="file" id="img" name="img" accept="image/jpg">
		<div class="form__group field">

			<input type="text" class="form__field" placeholder="Dauer"
				name="dauer" id='dauer' required /> <label for="Dauer"
				class="form__label">Dauer (Min)</label>
		</div>
		<br> <select name="Kategorie" class="select-wrapper">
			<option>Kategorie A</option>
			<option>Kategorie B</option>
			<option>Kategorie C</option>
			<option>Kategorie D</option>
			<option>Kategorie E</option>
		</select>
		<div class="form__group field">
			<table id="Tags">	
			<tr>
			<td width = "50%"><input name="tag" type="text" class="form__field" placeholder="Tag" name="tag"
				id='tag' required /> <label for="tag" class="form__label">Tags</label> </td>
				<td width = "25%"><button type="button" id="addTag" class="btn-hover color-1" onclick="addtag()">+Tag</button></td>
				<td width = "25%"><button type="button" id="deleteTag" class="btn-hover color-1" onclick="removeTag()">Tag löschen</button></td>
			
				</tr>
				</table>
		</div>
		<br>
		<h1>Zutaten</h1>
		<div class="form__group field">
			<table id="Zutaten">
				<tr>
					<td width="40%"><input  type="text" class="form__field"
						placeholder="Zutat" name="Zutat" id='zutat' required /> <label
						for="zutat" class="form__label">Zutat</label></td>
					<td width="40%"><input type="text" class="form__field"
						placeholder="Menge" name="Menge" id='menge' required /><label
						for="menge" class="form__label">Menge</label></td>
					<td width="20%"><select name="Einheit" class="select-wrapper">
							<option>Gramm</option>
							<option>Kilogramm</option>
							<option>Liter</option>
					
					</select></td>
					<td><button type="button" id="DeleteZutat" class="btn-hover color-1" onclick="removeIngredient()">Zutat löschen</button></td>
					<td><button type="button" id="AddZutat" class="btn-hover color-1" onclick="addIngredient()">+Zutat</button></td>
				</tr>
			</table>
		</div>	
		
			
		<h1>Beschreibung</h1>
		<textarea rows="30" cols="100" name="Beschreibung" placeholder="Deine Beschreibung..." id="beschreibung"></textarea>
		<br>
		<button onclick="submitclick()" id="subm" class="btn-hover color-1">Bestätigen</button>
		
		<script type="text/javascript">
			function submitclick(){
				
			}
		</script>

</form>
</body>
</html>