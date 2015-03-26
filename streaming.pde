var video = document.getElementsByTagName('video')[0];
var ctx;
PImage img;
int limit = 20;
shape = null;

video.style.display = "none";

function initStream() {
  var success = function(stream) {
    video.src = window.URL.createObjectURL(stream);
  };
  var error = function() {
    console.log('error');
  };
  navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;
  navigator.getUserMedia({video: true}, success, error);
}

var count = document.getElementById('count');
var range = document.getElementById('range');
var shapes = document.getElementsByClassName('shape');

for (var i = 0; i < shapes.length; i++) {
  shapes[i].addEventListener('change', function() {
    shape = this.getAttribute('data-shape');
  }, false);
}

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

      color c = img.get(j, i);
      fill(c);

      int x = Math.floor(j * width / limit);
      int y = Math.floor(i * height / limit);
      int w = Math.ceil(width / limit);
      int h = Math.ceil(height / limit);

      if (shape == "ellipse") {
        ellipse(x, y, w, h);
      } else if (shape == "rect") {
        rect(x, y, w, h);
      } else if (shape == "triangle") {
        triangle(x, y + (h / 2), x + (w / 2), y - (h / 2), x + w, y + (h / 2));
      } else {
        ellipse(x, y, w, h);
      }
    }
  }
}
