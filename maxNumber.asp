<!DOCTYPE html>

<!--
  FILE          : maxNumber.asp
  PROJECT       : WEB DESIGN AND DEVELOPMENT: Hi-Lo Game
  PROGRAMMER    : Purv Pandya & Deep Patel
  FIRST VERSION : 2021-10-20
  DESCRIPTION   : Hi-Lo Game will greet user by their name. It will also
				  ask user to enter their maximum guess number. It will 
				  also check if it is empty or not. It will check if maximum 
				  guess number is an aplha character or a number. If it is 
				  Number, it will check if number is greater than 1. If 
				  Number is greater than 1, then it will go to next page. Else,
				  It will show error.
-->



<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta charset="utf-8" />
	
    <title>
		WDD : A-02
	</title>

	<style type="text/css">
	
		h1 {
			padding: 16px;
			text-align: center;
			color: white;
			font-size: 28px;
			background: #1acb8d;
		}
		
		p {
			color: darkgreen;
		}
		
		body {
			background-color:lightyellow
		}
		
	</style>

    <script type="text/javascript">

        /*
		 * FUNCTION		:	validateNumber()
		 * PURPOSE		:	Validates the maximum guess number entered by the user. 
		 *					Checks if the maximum guess number entered by user is not a decimal.
		 * PARAMETERS	:	NONE
		 */
		function validateNumber() {
			var whichNum = document.getElementById("maxGuess").value;	// The number that is to be validated

			document.getElementById("maxGuessError").innerHTML = "";	// Clear the inner html from any previous use

			// If the user entered no guess number then show error
			if (whichNum.trim().length == 0) {
				document.getElementById("maxGuessError").innerHTML = "Your Highest Guess Number <b>cannot</b> be BLANK.";

			}

			// Else if the user entered a character that is not a number then show error
			else if (isNaN(whichNum)) {
				document.getElementById("maxGuessError").innerHTML = "Your Highest Guess Number <b>must</b> be NUMBER.";

			}

			// Else, the number entered by user is valid 
			else if (whichNum % 1 != 0) {
				document.getElementById("maxGuessError").innerHTML = "Your Highest Guess Number <b>cannot</b> be a DECIMAL.";

			}
			else {
				maxGuessNumber = whichNum;	// As the number entered by user is valid set the maxGuessNumber 

				return true;

			}

			return false;
		}
	</script>
</head>
<body>
	<h1>Hi-Lo Game</h1>
	<%
		' userName keeps tracks of user entered name.
		dim userName
		
		' maxGuessNumber keeps tracks of user entered maximum guess number.
		dim maxGuessNumber
		
		' Gets userName from FORM.  
		userName = request.form("userName")
		
		' It will greet user with their name.
		if (userName <> "") then
			response.Cookies("userName") = userName
		%>
		<p>Welcome <%=userName %>!</p>

	<%
		else
			userName = request.cookies("userName")
		if (request.cookies("restart") <> 1) then
		' It will prompt user the error if number is not greater than 1.
	%>
		
			<p><%=userName %> - Your Maximum Guess Number must be Greater than 1!!</p>

	<%
		else
			response.cookies("restart") = 0
		%>
		<p>Welcome <%=userName %>!</p>
		
	<%
		
		end if
		end if
		maxGuessNumber = request.form("maxGuessNumber")
		
		
	%>

	
	<form action="/gameEngine.asp" method="post" onsubmit="return validateNumber();">

		<div id="maxGuessPrompt">
		
			<p> Please Enter Your Maximum Guess Number: </p>
			<input type="text" id="maxGuess" name="maxGuessNumber" />
			<input type="hidden" name="minGuessNumber" value="1"/>
			<input type="hidden" name="userName" value="<%=userName %>"/>
			<input type="submit" value="Submit"  />

		</div>
		
		<div id="maxGuessError" style="color:red;"></div>
		
	</form>

</body>
</html>