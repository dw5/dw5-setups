mediaElements = document.querySelectorAll(".media");
var single = ""
console.log("\n");

for (let i = 0; i < mediaElements.length; i++) {
  mediaElement = mediaElements[i];
  usernameElement = mediaElement.querySelector(
    "div:nth-child(2) > p:nth-child(1) > small:nth-child(2) > a:nth-child(1)"
  );
  username = usernameElement.textContent.trim();
  
  descElement = mediaElement.querySelector(
    "div:nth-child(2) > p:nth-child(2)"
  );
  
  desc = descElement.textContent.trim();

  if(descElement.innerHTML.startsWith('\n\n<span')) {
  desc="grab: no desc";
	} else {desc = descElement.textContent.trim();}

  dateElement = mediaElement.querySelector(
    "div:nth-child(2) > p:nth-child(1) > small:nth-child(3)"
  );
  date = new Date(dateElement.title);
  timestamp = date.getTime();

  /*dlNoWElement = mediaElement.querySelector(
    "div:nth-child(2) > div:nth-child(5) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > a:nth-child(2)"
  );
  dlNoW = descElement.textContent.trim();
  */
  
  links = mediaElement.querySelectorAll('.dropdown-item[href]');
	for (link of links) { if (link.innerText === 'No watermark') {
    //console.log("wget --content-disposition" + link.href);
	dlNoW = link.href; }}

vtags="";

  gettags = mediaElement.querySelectorAll('.is-rounded'); // or .tag

	for (thetag of gettags) {
	//console.log(thetag.innerHTML+"\n");
	vtags += thetag.innerHTML+" "; 
	}

  /*console.log("Usr:", username);
  console.log("Desc:", desc);
  console.log("Tags:", vtags);
  console.log("Publish:", dateElement.title);
  console.log("Timestamp:", timestamp);
  console.log("WatchNoW:", dlNoW);
  console.log("-----");*/
  
   single += ("wget --content-disposition \"" + dlNoW + "\"  # "+timestamp+ " § "+dateElement.title+ " § "+desc+ " § "+vtags+ " § "+username + "\n");
}


const links = document.querySelectorAll('.dropdown-item[href]');
single = ""
for (const link of links) {
  if (link.innerText === 'No watermark') {
    //console.log("wget --content-disposition" + link.href);
single += ("wget --content-disposition " + link.href + "\n");
  }
}
