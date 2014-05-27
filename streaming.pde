var video = document.getElementsByTagName('video')[0];
video.style.display = "none";


function initStream() {
  var success = function(stream) {
    video.src = window.URL.createObjectURL(stream);
  };
  var error = function() {
    console.log('error');
  };
  navigator.webkitGetUserMedia({video: true}, success, error);
}

var ctx;
PImage img;
int limit = 20;

var p = document.getElementById('count');
var range = document.getElementById('range');
range.oninput = function(e) {
  limit = range.value;
  count.innerHTML = limit + ' x ' + limit;
};

void setup() {
  size(600, 600);
  ctx = externals.context;
  initStream();
}

void draw() {
  pushMatrix();
  translate(width, 0);
  scale(-1, 1);
  ctx.drawImage(video, 0, 0, width, height);
  popMatrix();

  noStroke();
  img = get();
  img.resize(limit, limit);

  background(255);

  for (int i = 0; i < limit; i++) {
    for (int j = 0; j < limit; j++) {

      fill(img.get(j, i));

      int x = Math.floor(j * width / limit);
      int y = Math.floor(i * height / limit);
      int w = Math.ceil(width / limit);
      int h = Math.ceil(height / limit);

      ellipse(x, y, w, h);
    }
  }

}
