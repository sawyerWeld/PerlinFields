float interpolation;
int menu_pointer;
int[]  menu_options = new int[6];

void setup() {
  size(800, 800, P3D);
  stroke(0);
  rotateX(PI/2);
  menu_options[0] = 0;
  menu_options[1] = 0;
  menu_options[2] = 0;
  menu_options[3] = 255;
  menu_options[4] = 255;
  menu_options[5] = 255;
  menu_pointer = 0;
}

void draw() {
  background(255);
  textSize(16);
  fill(0);
  text("fps = " + String.format("%.2f",frameRate), 0, 30);
  text("interpolation = " + interpolation, 0, 180);
  drawMenus();

  translate(width/2, height/4);


  float time_scale = map(millis(), 0, 1000, 0, 1);
  float rot = time_scale * 2 * PI;

  rotateY(rot/10);

  //fill(interpolateColor(map(mouseX, 0, width, 0, 1)));
  float color_lerp = map(millis()%3000,0,3000,1,0);
  //print(millis()+"\n");
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

  for (int i = 0; i < menu_options.length; i++) {
    if (i == menu_pointer) {
      menu_options[i] = menu_options[i]++;
    }
  }

  textSize(16);
  fill(0);

  text("  >", 0, 300 + 30 * menu_pointer);

  text(m_r0, 30, 300);
  text(m_g0, 30, 330);
  text(m_b0, 30, 360);
  text(m_r1, 30, 390);
  text(m_g1, 30, 420);
  text(m_b1, 30, 450);
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