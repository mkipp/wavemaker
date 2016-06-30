class WaveSine implements Wave {
  float amplitude = 130; // in pixels
  float spread = 1.5; // 1 = width of screen
  float xoffset = 0;
  float xspeed = 0.01;
  int col;

  // amplitude = how high/low the wave is
  // spread = how spread out the wave is, with 1 = one screen width
  // color = drawing color
  WaveSine(float amp, float spread, int c) {
    amplitude = amp;
    this.spread = spread;
    col = c;
  }
  
  WaveSine(float amp, float spread, float speed, int c) {
    this(amp, spread, c);
    xspeed = speed;
  }

  // expects x in terms of [0, width]
  public float getY(float x) {
    float x1 = (map(x, 0, width, 0, PI*2 / spread) + xoffset) % (PI*2);
    float y = (height-amplitude)/2 + map(sin(x1), -1, 1, amplitude, 0);
    return y;
  }

  public void render() {
    stroke(col);
    for (float x = 0; x < width; x++) {
      point(x, getY(x));
    }
  }

  public void update() {
    xoffset += xspeed;
  }
}