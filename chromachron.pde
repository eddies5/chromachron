
/*
Eduardo Saenz
1/1/2013
Chromachron clock.
Based off http://www.prismo.ch/chromachron/
*/

int max_size_window = 500;
int center = max_size_window / 2;
int margin = max_size_window / 10; // 20;
int stroke_weight_outer = margin / 4;
int stroke_weight_inner = stroke_weight_outer / 2;
int radius_outer_circle = max_size_window - margin / 2;
int radius_inner_circle = radius_outer_circle / 5;
float arc_radians = (2 * PI) / 12; // also wedge size

color[] colorpal = new color[12];
int background_color = #000000;

void setup() {
  size(max_size_window, max_size_window);
  background(background_color);
  // noFill();
  smooth();
  assignColors();
  strokeCap(SQUARE);
  drawCircles();
}

void draw() {
  int h = hour();
  int m = minute();
  boolean draw_half = false;

  // take care of hour edge cases
  if (h >= 12) {
    h -= 12;
  }

  // take care of minute edge cases
  if (m >= 30) {
    draw_half = true;
  }

  drawWedge(h, m, draw_half);

  // delay for at least five minutes
  // so we don't keep re-drawing
  delay(1000 * 60 * 5);
}

void drawWedge(int h, int m, boolean draw_half) {
  if (!draw_half) {
    fill(colorpal[h]);
    arc(center, center, radius_outer_circle - 5, radius_outer_circle - 5,
      calcRadian(h, 0), calcRadian(h + 1, 0));
  } else {
    float extra = (h + 1) * (arc_radians / 2);
    fill(colorpal[h]);
    arc(center, center, radius_outer_circle - 5, radius_outer_circle - 5,
      calcRadian(h, 1) + extra, calcRadian(h + 1, 1) + extra);
    if (h == 11) {
      fill(colorpal[0]);
    } else {
      fill(colorpal[h + 1]);
    }
    arc(center, center, radius_outer_circle - 5, radius_outer_circle - 5,
      calcRadian(h + 1, 1) + extra, calcRadian(h + 2, 1) + extra);
  }

  // make pretty
  drawCircles();
}


  // amt:
  //   0 = entire arc_radian
  //   1 = half arc_radian

float calcRadian(int i, int amt) {
  if (amt == 0) {
    return i * arc_radians - (PI / 2 + PI / 12);
  } else if (amt == 1) {
    return i * (arc_radians / 2) - (PI / 2 + PI / 12);
  }
  return 0.0;
}

void drawCircles() {
  noFill();
  // outer circle
  strokeWeight(stroke_weight_outer);
  for (int i = 0; i < 12; i++) {
    stroke(colorpal[i]);
    arc(center, center, radius_outer_circle, radius_outer_circle,
      calcRadian(i, 0), calcRadian(i + 1, 0));
  }
  // inner circle
  strokeWeight(stroke_weight_inner);
  for (int i = 0; i < 12; i++) {
    stroke(colorpal[i]);
    arc(center, center, radius_inner_circle, radius_inner_circle,
      calcRadian(i, 0), calcRadian(i + 1, 0));
  }
  // fill in center
  stroke(background_color);
  fill(background_color);
  ellipse(center, center, radius_inner_circle - 7, radius_inner_circle - 7);
  noFill();
  strokeWeight(1);
}


void assignColors() {
  colorpal[0] = color(#ffeb23); // yellow
  colorpal[1] = color(#ff7d19); // orange
  colorpal[2] = color(#ffc3c3); // pink
  colorpal[3] = color(#d7232d); // red
  colorpal[4] = color(#ff69cd); // lilac
  colorpal[5] = color(#b919a5); // violet
  colorpal[6] = color(#4141b8); // blue
  colorpal[7] = color(#2d7d2d); // green
  colorpal[8] = color(#05c3c3); // turquoise
  colorpal[9] = color(#9b4b37); // brown
  colorpal[10] = color(#e1d7b9); // ochre
  colorpal[11] = color(#cd9b69); // beige
}
