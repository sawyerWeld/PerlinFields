float interpolation;
int menu_pointer;
int[]  menu_options = new int[6];

void setup() {
  size(420, 390, P3D);
  stroke(0);
  rotateX(PI/2);

  boolean randColors = true;
  if (randColors) {
    for (int i = 0; i < 6; i++) {
      menu_options[i] = (int) random(255);
    }
  } else {
    menu_options[0] = 0;
    menu_options[1] = 0;
    menu_options[2] = 0;
    menu_options[3] = 255;
    menu_options[4] = 255;
    menu_options[5] = 255;
  }

  menu_pointer = 0;
}

void draw() {
  background(255);
  textSize(16);
  fill(0);
  text("Color Interpolation Utility", 10, 30);
  text("Interpolation = " + String.format("%.2f", interpolation), 10, 60);
  drawMenus();

  strokeWeight(2);

  // Left Color Rect
  fill(color(menu_options[3], menu_options[4], menu_options[5]));
  rect(30, 270, 30, 90);

  // Right Color Rect
  fill(color(menu_options[0], menu_options[1], menu_options[2]));
  rect(360, 270, 30, 90);

  // Pointer Thing
  strokeWeight(1);
  fill(0);
  line(60, 330, 360, 330);
  int pointer_x = (int) (map(interpolation, 0, 1, 1, 0) * 300 + 60); 
  triangle(pointer_x, 330, pointer_x-10, 310, pointer_x+10, 310);

  // Color Cube (drawn last because of rotation)
  translate(300, 140);
  float time_scale = map(millis(), 0, 1000, 0, 1);
  float rot = time_scale * 2 * PI;
  rotateY(rot/10);
  //fill(interpolateColor(map(mouseX, 0, width, 0, 1)));
  float color_lerp = map(millis()%3000, 0, 3000, 1, 0);
  fill(interpolateColor(color_lerp));
  box(100, 100, 100);
}

void drawMenus() {
  int[]mu = menu_options;

  // menu options
  String m_r0 = String.format("Red = %s", mu[0]);
  String m_g0 = String.format("Green = %s", mu[1]);
  String m_b0 = String.format("Blue = %s", mu[2]);
  String m_r1 = String.format("Red = %s", mu[3]);
  String m_g1 = String.format("Green = %s", mu[4]);
  String m_b1 = String.format("Blue = %s", mu[5]);  

  textSize(16);
  fill(0);

  int menu_down = 90; //looks good at 90, so 90 -> 240

  text(">", 10, menu_down + 30 * menu_pointer);

  text(m_r0, 30, menu_down + (30 * 0));
  text(m_g0, 30, menu_down + (30 * 1));
  text(m_b0, 30, menu_down + (30 * 2));
  text(m_r1, 30, menu_down + (30 * 3));
  text(m_g1, 30, menu_down + (30 * 4));
  text(m_b1, 30, menu_down + (30 * 5));
}

color interpolateColor(float interp) {
  //color darkest = color(44, 59, 16);
  //color lightest = color(133, 160, 78);
  //return lerpColor(lightest, darkest, interp);
  //print(interp + "\n");
  interpolation = interp;
  color a = color(menu_options[0], menu_options[1], menu_options[2]);
  color b = color(menu_options[3], menu_options[4], menu_options[5]);
  return lerpColor(a, b, interp);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && menu_pointer != 0) {
      menu_pointer--;
    } else if (keyCode == DOWN && menu_pointer != 5) {
      menu_pointer++;
    } else if (keyCode == LEFT && menu_options[menu_pointer] > 0) {
      menu_options[menu_pointer] -= 10;
    } else if (keyCode == RIGHT && menu_options[menu_pointer] < 255) {
      menu_options[menu_pointer] += 10;
    }
  }
}

void mouseClicked() {
  setup();
}