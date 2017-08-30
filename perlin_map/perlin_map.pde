

float[][] hmap;
int w, h, c, r, g, max_elevation;

// w = width of map
// h = height of map
// c = columns
// r = rows
// g = granularity, the width of each square

void setup() {
  fullScreen(P3D);
  //size(600, 600, P3D);
  //stroke(0);
  noStroke();
  fill(122);
  w = 1500;
  h = 1000;
  g = 2;
  max_elevation = 80;
  
  c = w / g;
  r = h / g;
  hmap = new float[c][r];

  for (int i = 0; i < c; i ++) {
    for (int j = 0; j < r; j++) {
      // hmap[i][j] = random(0, 20);
      float i_noise = i * .1 * ((float)g/5);
      float j_noise = j * .1 * ((float)g/5);
      hmap[i][j] = map(noise(i_noise, j_noise), 0, 1, 0, max_elevation);
    }
  }
}

void draw() {
  background(150);

  translate(width/2, height/2);

  rotateX(1);
  translate(-w/2, -h/2);
  for (int i = 1; i < c; i ++) {
    for (int j = 1; j < r; j++) {
      float e = hmap[i][j]; // elevation
      // the top
      //fill(48,86,29);
      fill(map(e,0,max_elevation,0,255));
      beginShape();
      vertex(i*g, j*g, e);
      vertex((i+1)*g, j*g, e);
      vertex((i+1)*g, (j+1)*g, e);
      vertex(i*g, (j+1)*g, e);
      endShape(CLOSE);
      // the front
      //fill(92,133,55);
      fill(150);
      beginShape();
      vertex(i*g, (j+1)*g, e);
      vertex(i*g, (j+1)*g, 0);
      vertex((i+1)*g, (j+1)*g, 0);
      vertex((i+1)*g, (j+1)*g, e);
      endShape(CLOSE);
      // the left
      //fill(147,189,91);
      fill(150);
      beginShape();
      vertex(i*g, j*g, e);
      vertex(i*g, j*g, 0);
      vertex(i*g, (j+1)*g, 0);
      vertex(i*g, (j+1)*g, e);
      endShape(CLOSE);
      // the right
      //fill(147,189,91);
      fill(150);
      beginShape();
      vertex((i+1)*g, j*g, e);
      vertex((i+1)*g, j*g, 0);
      vertex((i+1)*g, (j+1)*g, 0);
      vertex((i+1)*g, (j+1)*g, e);
      endShape(CLOSE);
    }
  }

  //translate(58, 48, 0); 
  //rotateY(0.5);
  //box(40, 20, 50);
}