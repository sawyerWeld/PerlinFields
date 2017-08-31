

float[][] hmap;
int w, h, c, r, g, max_elevation, water_height;

// w = width of map
// h = height of map
// c = columns
// r = rows
// g = granularity, the width of each square

void setup() {
  fullScreen(P3D);
  noiseSeed((long)random(1000));
  //size(1200, 600, P3D);
  //stroke(0);
  noStroke();
  w = 2000;
  h = 1000;
  g = 5;
  max_elevation = (int) random(100, 200);
  water_height = (int) random(10, max_elevation-20);


  c = w / g;
  r = h / g;
  hmap = new float[c][r];

  for (int i = 0; i < c; i ++) {
    for (int j = 0; j < r; j++) {
      // hmap[i][j] = random(0, 20);
      float i_noise = i * .1 * ((float)g/10);
      float j_noise = j * .1 * ((float)g/10);
      hmap[i][j] = map(noise(i_noise, j_noise), 0, 1, 0, max_elevation);
    }
  }
}

void draw() {
  background(165, 237, 237);

  translate(width/2, height/2);

  rotateX(1);
  translate(-w/2, -h/2);

  for (int i = 1; i < c; i ++) {
    for (int j = 1; j < r; j++) {
      if (hmap[i][j] > water_height) {
        drawLand(i, j);
      } else {
        drawWater(i, j);
      }
    }
  }
  drawWaterLevel();
}

void drawLand(int i, int j)
{
  float e = hmap[i][j]; // elevation
  // the top
  //fill(48,86,29);
  float height_shade = map(e, 0, max_elevation, 0, 255);
  fill(height_shade);

  beginShape();
  vertex(i*g, j*g, e);
  vertex((i+1)*g, j*g, e);
  vertex((i+1)*g, (j+1)*g, e);
  vertex(i*g, (j+1)*g, e);
  endShape(CLOSE);
  // the left
  fill(147, 189, 91);
  beginShape();
  vertex(i*g, j*g, e);
  vertex(i*g, j*g, 0);
  vertex(i*g, (j+1)*g, 0);
  vertex(i*g, (j+1)*g, e);
  endShape(CLOSE);
  // the right
  fill(147, 189, 91);
  //fill(150);
  beginShape();
  vertex((i+1)*g, j*g, e);
  vertex((i+1)*g, j*g, 0);
  vertex((i+1)*g, (j+1)*g, 0);
  vertex((i+1)*g, (j+1)*g, e);
  endShape(CLOSE);
  // the front
  fill(92, 133, 55);
  //fill(150);
  if (j == r-1) {
    fill(165, 237, 237);
  }
  beginShape();
  vertex(i*g, (j+1)*g, e);
  vertex(i*g, (j+1)*g, 0);
  vertex((i+1)*g, (j+1)*g, 0);
  vertex((i+1)*g, (j+1)*g, e);
  endShape(CLOSE);
}

void drawWater(int i, int j) {
  float e = water_height; // elevation
  fill(0, 0, 128);
  beginShape();
  vertex(i*g, j*g, e);
  vertex((i+1)*g, j*g, e);
  vertex((i+1)*g, (j+1)*g, e);
  vertex(i*g, (j+1)*g, e);
  endShape(CLOSE);
}

void drawWaterLevel() {
  fill(165, 237, 237);
  beginShape();
  vertex(0, h+1, water_height);
  vertex(w, h+1, water_height);
  vertex(w, h+1, 0);
  vertex(0, h+1, 0);
  endShape(CLOSE);
}

void mouseClicked() {
  setup();
}