function retranslateAgain() {
	let inputV = document.getElementById('input').value;
	let outputV = document.getElementById('output').value;
	document.getElementById('input').value = outputV;
	document.getElementById('output').value = inputV;
	sendTranslation(outputV);
}

function sendTranslation(txt) {
	let errM = document.getElementById('errorMessage');
	errM.style.visibilty = 'visible';
	//let strSent = btoa(txt).replace('/', '__SL__').replace('=', '__EQ__').replace('+', '__MN__');
	let strSent = txt;
	let strFunc = 'do-meow';
	if (document.getElementById('lang').value.startsWith("Meow-"))
		strFunc = 'do-english';
	$.post(strFunc, strSent, function(resp) {
			errM.style.visibilty = 'hidden';
			document.getElementById('output').value = resp; });

}
