const links = document.querySelectorAll('.dropdown-item[href]');
single = ""
for (const link of links) {
  if (link.innerText === 'No watermark') {
    //console.log("wget --content-disposition" + link.href);
single += ("wget --content-disposition " + link.href + "\n");
  }
}
