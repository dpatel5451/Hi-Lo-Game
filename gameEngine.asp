<!DOCTYPE html>

<!--
  FILE          : gameEngine.asp
  PROJECT       : WEB DESIGN AND DEVELOPMENT: Hi-Lo Game
  PROGRAMMER    : Purv Pandya & Deep Patel
  FIRST VERSION : 2021-10-20
  DESCRIPTION   : Hi-Lo game will check maximum guess number and redirects response to maxNumber.asp.
				  It will check user guess and will give them new range, everytime user guess will be wrong.
				  It will also check if user guess is outside of range and if it is alpha characters.
				  It will keep prompting user to enter guess, until the user entered number matches random
				  number. If it will match, it will congratulates user and will ask them to Play Again.
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
		
		h3 {
			color: purple;
		}
		
		p {
			color: darkgreen;
		}
		
		body {
			background-color:lightyellow;
		}
		
	</style>
	
    <script type="text/javascript">

		/**
		 * FUNCTION		:	validateNumber()
		 * PURPOSE		:	Validates the maximum guess number entered by the user. 
		 *					Checks if the maximum guess number entered by user is not less than 1.
		 * PARAMETERS	:	NONE
		 * */
		function validateNumber() {

			
			var whichNum = document.getElementById("guessedNumber").value;	// The number that is to be validated


			document.getElementById("guessErrorMessage").innerHTML = "";	// Clear the inner html from any previous use

			// If the user entered no guess number then show error
			if (whichNum.trim().length == 0) {
				document.getElementById("guessErrorMessage").innerHTML = "Your Guessed Number <b>cannot</b> be BLANK.";

			}

			// Else if the user entered a character that is not a number then show error
			else if (isNaN(whichNum)) {
				document.getElementById("guessErrorMessage").innerHTML = "Your Guessed Number <b>must</b> be NUMBER.";
			}

			// Else, the number entered by user is valid 
			else  {
				return true;
			}
			
			return false;
		}


		
		/**
		 * FUNCTION		:	restart()
		 * PURPOSE		:	It will change page to maxNumber.asp if user entered guess
		 *					is same random number.
		 * PARAMETERS	:	NONE
		 * */
		function restart() {
			window.location.href = "/maxNumber.asp";
		}

	</script>
    
</head>
<body>
	<form action="/gameEngine.asp" method="post" onsubmit="return validateNumber();">
		<h1>Hi-Lo Game</h1>
		<div id="gameUI">

	 <%
		' userName keeps tracks of user name.
		dim userName
		
		' maxGuessNumber keeps tracks of maximum guess number.
		dim maxGuessNumber 
		
		' minGuessNumber keeps tracks of minimum guess number.
		dim minGuessNumber 
		
		' answer is generated random number.
		dim answer
		
		' guessedNumber keeps tracks of user entered guess.
		dim guessedNumber
		
		' won will check if user entered guess is same as random number. 
		dim won 

		' Gets userName and maxGuessNumber from FORM.
		response.cookies("restart") = 0 
		userName = Request.Form("userName")
		maxGuessNumber = Request.Form("maxGuessNumber")

		' If maximum guess number is less than or equal to 1, then it will redirect back to maxNumber.asp page.
		if (maxGuessNumber <= 1) then
			response.redirect("/maxNumber.asp")
		end if
		
		' Gets minGuessNumber and guessedNumber from FORM.
		minGuessNumber = Request.Form("minGuessNumber")
		guessedNumber = Request.Form("guessedNumber")
		answer = Request.Form("answer")
		
		' It will set won to 0.
		won = 0
		
		' Generates random number.
		if (guessedNumber = "") then		
			Randomize
			answer = int((rnd * maxGuessNumber) + 1)

		 %>
			 <p> <% =userName %> - We Are Playing Hi-Lo Game!!</p>
		<%
		else 
			if (Cint(guessedNumber) = Cint(answer)) then
				' If user entered guess is same as random number, it will change variable won value to 1.
				won = 1
			else 
				if (Cint(guessedNumber) > Cint(maxGuessNumber)) or (Cint(guessedNumber) < Cint(minGuessNumber)) then
					' If user entered guess is outside of allowable range, it will tell user.
					response.write("<p>Your Previous Guessed Number was outside the Allowable Range.</p>")
				else

					if ((Cint(guessedNumber) < Cint(answer))) then
						' If user entered guess is less than random number, it will give user new range and will prompt message.
						response.write("<p>Your Previous Guessed Number was less than the Answer. Keep trying!!</p>")
						minGuessNumber = guessedNumber + 1
					else
						if ((Cint(guessedNumber) > Cint(answer))) then
							' If user entered guess is greater than random number, it will give user new range and will prompt message.
							response.write("<p>Your Previous Guessed Number was greater than the Answer. Keep trying!!</p>")
							maxGuessNumber = guessedNumber - 1
						end if
					end if
				end if
			end if
		end if
	%>
					
			<%
				' It will prompt user to enter guess again, if last guess doesn't matches random number.
				if (won = 0) then	
			%>
			 <p>Please Enter Your Guess:</p>
		
			<input type="text" id="guessedNumber" name="guessedNumber"/>
       
			<input type="hidden" value="<%=userName%>" name="userName" />
			<input type="hidden" value="<%=maxGuessNumber %>" name="maxGuessNumber" />
			<input type="hidden" value="<%=answer %>" name="answer" />
			<input type="hidden" value="<%=minGuessNumber %>" name="minGuessNumber" />
			<input type="submit" value="Make this guess"/>

		</div>
		
		
		<div id="allowedRangeMessage" >
			<p>Your Allowable Guessing Range is any Value Between <b> <%=minGuessNumber %> </b> and <b> <%=maxGuessNumber %></b>.</p>
		</div>
	
		<div id="guessErrorMessage" style="color:red;"></div>
		<%
			else
				' If user guess matches random number, it will congratulates user and will ask user if they want to play the game again.
				response.cookies("restart") = 1	
		%>

		<div id="finalPage"  >
			<script type="text/javascript">
				document.body.style.backgroundColor = "#9999CC";
			</script>
			<h3>You Win!! You guessed the Number!!</h3>
			<input type="button" value="Play again" onclick="restart()" />
		</div>	 
		<%end if %>
	

    <br />
	<br />

	</form>
</body>
</html>