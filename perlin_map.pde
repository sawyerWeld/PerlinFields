

float[][] hmap;
int w, h, c, r, g;

// w = width of map
// h = height of map
// c = columns
// r = rows
// g = granularity, the width of each square

void setup() {
  size(600, 600, P3D);
  stroke(0);
  noFill();
  w = 1000;
  h = 1000;
  g = 20;
  c = w / g;
  r = w / g;
  hmap = new float[c][r];

  for (int i = 0; i < c; i ++) {
    for (int j = 0; j < r; j++) {
      hmap[i][j] = random(0, 20);
    }
  }
  hmap[15][15] = 150;
}

void draw() {
  background(255);
  
  translate(width/2, height/2);
  
  rotateX(1);
  translate(-w/2,-h/2);
  for (int i = 1; i < c; i ++) {
    for (int j = 1; j < r; j++) {
      float e = hmap[i][j]; // elevation
      // the flat top
      beginShape();
      vertex(i*g, j*g, e);
      vertex((i+1)*g, j*g, e);
      vertex((i+1)*g, (j+1)*g, e);
      vertex(i*g, (j+1)*g, e);
      endShape(CLOSE);
    }
  }

  //translate(58, 48, 0); 
  //rotateY(0.5);
  //box(40, 20, 50);
}