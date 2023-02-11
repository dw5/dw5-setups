videos="";
var currentUrl = window.location.href; var username = currentUrl.split('/')[3]; //console.log(username);
gettags = document.querySelectorAll("a[href^='https://beta.vanillo.tv/" + username + "/']");
console.log(username+" videos counted: "+gettags.length);
	for (thetag of gettags) {
	//console.log(thetag+"\n");
	videos+="yt-dlp "+thetag+" \n"; 
	}
