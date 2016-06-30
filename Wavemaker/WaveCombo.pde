// Combines a number of waves
// Note that weight must not necessarily add up to 1
// => weights always are normalized on the fly

class WaveCombo implements Wave {
  int col;
  float xoffset = 0;
  float xspeed = 0.01;
  ArrayList<Wave> waves = new ArrayList<Wave>();
  ArrayList<Float> weights = new ArrayList<Float>();
  float weightSum = 0;

  WaveCombo(int c) {
    col = c;
  }

  // Adds new wave, adjusts weights
  void addWave(Wave wave) {
    waves.add(wave);
    weights.add(1f);
    weightSum += 1f;
  }

  void updateWeightSum() {
    weightSum = 0;
    for (float w: weights) {
      weightSum += w;
    }
  }

  void increaseWeight(int index, float inc) {
    float newWeight = constrain(comboWave.getWeight(index) + inc, 0, 1);
    weights.set(index, newWeight);
    updateWeightSum();
  }

  float getWeight(int index) {
    return weights.get(index);
  }
  
  void setWeight(int index, float w) {
    weights.set(index, w);
    updateWeightSum();
  }

  public float getY(float x) {
    float y = 0;
    int i = 0;
    for (Wave w : waves) {
      y += weights.get(i)/weightSum * w.getY(x);
      i++;
    }
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