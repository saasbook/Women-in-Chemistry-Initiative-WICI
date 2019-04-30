function myFunction(imgs) {
  var expandImg = document.getElementById("expandedImg");
  var imgText = document.getElementById("imgtext");
  expandImg.src = imgs.src;
  imgText.innerHTML = imgs.alt;
  expandImg.parentElement.style.display = "block";
	arr.i = imgs.id
}



function collection(imgs) {
  this.imgs = imgs;
  this.i = 0;

  this.next = function(element) {
    var img = document.getElementById(element);

    this.i++;
    if (this.i >= imgs.length) {
      this.i = 0;
    }

    img.src = imgs[this.i];
  };

  this.prev = function(element) {
    var img = document.getElementById(element);

    this.i--;
    if (this.i < 0) {
      this.i = imgs.length - 1;
    }

    img.src = imgs[this.i];
  };



  this.next("expandedImg");
}
