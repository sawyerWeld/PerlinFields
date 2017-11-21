// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/IKB1hWWedMk
// Modified from original by Sawyer Welden

int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;
float rotation = (PI/2);
int yoffset = 0;
boolean fly = false;

float flying = 0;

float[][] terrain;

void setup() {
  size(1200, 800, P3D);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

void mouseClicked() {
  fly = !fly;
}

void mouseWheel(MouseEvent event) {
  rotation += (event.getCount()>0)?.013:-.013;
  //rotation = (rotation<PI/2)?PI/2:rotation;
  yoffset += (event.getCount()>0)?-2:+2;
  //yoffset = (yoffset<0)?0:yoffset;
}

void draw() {
  if (fly)
  flying -= 0.1;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }



  background(150);
  stroke(255);
  //noFill();
  fill(0);
  
  translate(width/2, (height/2)+50+yoffset);
  rotateX(rotation);
  translate(-w/2, -h);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
}
