/**
 * width of the window
 */
final int WIDTH = 800;

/**
 * height of the window
 */
final int HEIGHT = 800;

/**
 * midpoint of the spiral
 */
final PVector MIDPOINT = new PVector(WIDTH/2, HEIGHT/2);

/**
 * the default value of the offset multiplier
 */
final float OFFSET_MULTIPLIER_DEFAULT = 0.025;

/**
 * the maximum delta value that is applied to the default
 */
final float OFFSET_MULTIPLIER_DELTA = 0.01;

/**
 * Function determins the amount of delta that is applied
 */
float OFFSET_FUNCTION(float time) {
  return sin(time);
  //return (sin(time) + sin(time/4))/2;
}


/**
 * fixed timestep of the calculation for spinning and dilation
 */
final float TIMESTEP = 0.1;

// -------- ACTUAL CODE --------

float offset_mult = 0;
float time = 0;

void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  frameRate(60);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(220);
  loadPixels();
  for (int y = 0; y < pixelHeight; y++) {
    for (int x = 0; x < pixelWidth; x++) {
      PVector current = new PVector(x, y);
      PVector difference = current.sub(MIDPOINT);
      double angle = (8 * PI + time - difference.mag() * offset_mult + atan2(difference.y, difference.x)) % (2 * PI);
      
      int index = y * pixelWidth + x;
      color c = color((int)(angle*180/PI), 80, 80);
      pixels[index] = c;
    }
  }

  updatePixels();
  time = time + TIMESTEP;
  offset_mult = OFFSET_FUNCTION(time) * OFFSET_MULTIPLIER_DELTA + OFFSET_MULTIPLIER_DEFAULT;
}
