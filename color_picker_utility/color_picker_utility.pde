void setup() {
  size(800, 800, P3D);
  stroke(0);
  rotateX(PI/2);
}

void draw() {
  background(255);
  textSize(16);
  fill(0);
  text("fps = " + frameRate, 0, 30);
  translate(width/2, height/2);

  
  float time_scale = map(millis(),0,1000,0,1);
  float rot = time_scale * 2 * PI;
  
  rotateY(rot/10);
  rotateZ(PI/3);
  
  fill(interpolateColor(map(mouseX,0,width,0,1)));
  
  box(100, 100, 100);
}

color interpolateColor(float interp) {
  color darkest = color(44,59,16);
  color lightest = color(133,160,78);
  return lerpColor(lightest,darkest,interp);
}