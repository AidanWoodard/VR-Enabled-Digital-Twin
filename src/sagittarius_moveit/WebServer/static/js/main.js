/*
	This file contains the main JavaScript code for the web interface of the robot.
	Much of the basis for this code came from Rui Santos's ESP32 tutorials: https://randomnerdtutorials.com/projects-esp32/
	Modifications made by Collin Schofield, with assistance from Github Copilot.
*/

//=======================================================
// Global variables
//=======================================================

// var botPath = `ws://${window.location.hostname}/ws`;
// var botPath = `http://192.168.123.168:5000`;
// var botPath = `http://${window.location.hostname}`;
var botPath = `http://${window.location.hostname}:${window.location.port}`;


// window.addEventListener('load', onload);// Initialize the websocket when the page is loaded



const LoopState = Object.freeze({
	STOP: 0,
	AUTO: 1,
	MANUAL: 2,
	EXIT: 3
});



function stateAsString(state) {
	switch (state) {
		case LoopState.STOP:
			return "STOP";
		case LoopState.AUTO:
			return "AUTO";
		case LoopState.MANUAL:
			return "MANUAL";
		case LoopState.EXIT:
			return "EXIT Program";
		default:
			return "UNKNOWN";
	}
}


//=======================================================
// Bot Command Functions
//=======================================================

function goToPosition(number) {
	console.log('Sending the goToPosition command, position: ' + number);
	fetch(botPath + `/goToPosition${number}`, {
		method: 'POST',
	})
	// .then(response => response.json())
	.then(data => {
		console.log(data);
	})
	.catch((error) => {
		console.error('Error:', error);
	});
}



function gripperPosition(number) {
	console.log('Sending the gripperPosition command, position: ' + number);
	fetch(botPath + `/gripperPosition${number}`, {
		method: 'POST'
	})
	// .then(response => response.json())
	.then(data => {
		console.log(data);
	})
	.catch((error) => {
		console.error('Error:', error);
	});
}



function updateJointSlider(element){
	var sliderNumber = element.id.charAt(element.id.length-1);
	var sliderValue = document.getElementById(element.id).value;
	document.getElementById("jointValue"+sliderNumber).innerHTML = sliderValue;
	console.log(sliderValue);
	const data = new URLSearchParams();
	data.append('position', sliderValue);
	fetch(botPath + `/joint${sliderNumber}`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded',
		},
		body: data
	})
	.then(response => response.json())
	.then(data => {
		console.log(data);
	})
	.catch((error) => {
		console.error('Error:', error);
	});
	// websocket.send(sliderNumber+"s"+sliderValue.toString());
}



// Change the Loop / Running mode of the robot
function changeMode(mode){
	console.log('Sending the changeMode command, mode: ' + mode);
	fetch(botPath + `/changeMode${mode}`, {
		method: 'GET'
	})
	.then(response => response.json())
	.then(data => {
		// console.log(data);
		// Update the mode being displayed
		document.getElementById("mode").innerHTML = stateAsString(data.mode);
	})
	.catch((error) => {
		console.error('Error:', error);
	});
}





// // Function to toggle if the bot is running or not
// function toggleBot() {
// 	if (document.getElementById('botRunning').innerHTML == 'true') {
// 		stopBot();
// 	} else {
// 		startBot();
// 	}
// }
