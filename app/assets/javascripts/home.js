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
var urls = ['https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/29749500_1846027302356928_1424356246379965960_o.jpg?_nc_cat=105&_nc_ht=scontent-sjc3-1.xx&oh=62035fae7e54f571638975b4794a9020&oe=5D3F1A8C',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/22769682_1781777335448592_5772115123594286650_o.jpg?_nc_cat=108&_nc_ht=scontent-sjc3-1.xx&oh=ba15f1f38bd7edc06e0dd97ee7aa3d7e&oe=5D6FDE36',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/16113169_1670482029911457_5672124951285453401_o.jpg?_nc_cat=103&_nc_ht=scontent-sjc3-1.xx&oh=3db7135f5c73eb990a8998380efb3584&oe=5D7779BC',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t1.0-9/45006054_1978141279145529_6321221626599833600_o.jpg?_nc_cat=111&_nc_ht=scontent-sjc3-1.xx&oh=c2d5b3fe73353b56e7fb0951315cfa02&oe=5D650991',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/14612434_1635012100125117_2082643130819550668_o.jpg?_nc_cat=100&_nc_ht=scontent-sjc3-1.xx&oh=7a39da2b628f9fd505874a3f280b9ee8&oe=5D2A3F9A',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/30945287_1859210474371944_5647595661945196635_o.jpg?_nc_cat=104&_nc_ht=scontent-sjc3-1.xx&oh=d32715a378b1b084c9899323c27a271c&oe=5D38D1EF',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t1.0-9/55532077_2058335077792815_6997238389384675328_o.jpg?_nc_cat=109&_nc_ht=scontent-sjc3-1.xx&oh=5c8cb5b826183d4ab484e21fc01a4b5e&oe=5D346A4A',
'https://scontent-sjc3-1.xx.fbcdn.net/v/t31.0-8/22791912_1781779578781701_2304727614290918746_o.jpg?_nc_cat=110&_nc_ht=scontent-sjc3-1.xx&oh=6a229eb4c1a61a4bc0ef5de48a7e3d00&oe=5D696319'];
