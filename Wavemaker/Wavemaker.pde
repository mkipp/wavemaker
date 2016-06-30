// Wavemaker
// Mulitple sine waves can be combined
// All waves are centered around the middle of the y-axis
//
// Control menu with up/down/left/right
// Keys 1, 2, 3 switche visibility of single waves on/off
//
// (c) 2016 Michael Kipp

int[] waveColor = {#7DFF6A, #FCFF6A, #6AD6FF}; // green, yellow, blue
int colorCombo = #FF886A; // red

WaveSine[] waves = new WaveSine[3];
boolean[] showWave = new boolean[3];

WaveCombo comboWave = new WaveCombo(colorCombo); // combination of w1 and w2 (and w3)

int selectedWave = 0;
int selectedFeature = 0;

void setup() {
  size(800, 600);

  waves[0] = new WaveSine(130, 3, waveColor[0]); // green
  waves[1] = new WaveSine(140, 1.1, .15, waveColor[1]); // yellow
  waves[2] = new WaveSine(150, 1.1, 0.03, waveColor[2]); // blue

  for (int i = 0; i < waves.length; i++) {
    comboWave.addWave(waves[i]);
    showWave[i] = false;
  }
}

void draw() {
  background(0);

  strokeWeight(1);

  for (int i = 0; i < waves.length; i++) {
    if (showWave[i]) {
      waves[i].render();
    }
    waves[i].update();
  }

  strokeWeight(2);
  comboWave.render();
  comboWave.update();

  drawInfo();
}

void drawInfo() {
  textAlign(CENTER);
  fill(255);
  text("change with cursor keys", width-90, 20);
  rectMode(CENTER);
  noFill();
  stroke(255);
  strokeWeight(1);
  rect(width-90, 50, 40, 40);
  rect(width-90, 100, 40, 40);
  rect(width-140, 100, 40, 40);
  rect(width-40, 100, 40, 40);

  fill(255);
  triangle(width-100, 60, width-80, 60, width-90, 40);
  triangle(width-100, 90, width-80, 90, width-90, 110);
  triangle(width-150, 100, width-130, 90, width-130, 110);
  triangle(width-50, 90, width-30, 100, width-50, 110);

  textAlign(LEFT);
  for (int i = 0; i < waves.length; i++) {
    fill(waveColor[i]);
    int x = 20 + i*200;
    if (selectedWave == i && selectedFeature == 0) {
      stroke(waveColor[i]);
      strokeWeight(3);
      line(x, 8, x + 160, 8);
    }

    textSize(18);
    text("Wave " + (i+1), x, 30);

    int y = 50;
    if (selectedWave == i && selectedFeature == 1) {
      noStroke();
      ellipse(x - 10, y-5, 7, 7);
    }
    text("weight = " + nf(comboWave.getWeight(i), 0, 2), x, y);

    textSize(14);

    y = 80;
    if (selectedWave == i && selectedFeature == 2) {
      noStroke();
      ellipse(x - 10, y-5, 7, 7);
    }
    text("amp = " + nf(waves[i].amplitude, 0, 1), x, y);

    y = 100;
    if (selectedWave == i && selectedFeature == 3) {
      noStroke();
      ellipse(x - 10, y-5, 7, 7);
    }
    text("spread = " + nf(waves[i].spread, 0, 1), x, y);

    y = 120;
    if (selectedWave == i && selectedFeature == 4) {
      noStroke();
      ellipse(x - 10, y-5, 7, 7);
    }
    text("xspeed = " + nf(waves[i].xspeed, 0, 3), x, y);
  }
}

void keyPressed() {
  if (key >= '1' && key <= '3') {
    int index = keyCode - '1';
    showWave[index] = !showWave[index];
  } else if (keyCode == LEFT || keyCode == RIGHT) {
    int sign = keyCode == LEFT ? -1 : 1;
    switch (selectedFeature) {
    case 0:
      selectedWave = constrain(selectedWave + sign, 0, waves.length - 1);
      break;
    case 1:
      comboWave.increaseWeight(selectedWave, sign * .1);
      break;
    case 2:
      waves[selectedWave].amplitude = constrain(waves[selectedWave].amplitude + sign*10, 0, 300);
      break;
    case 3:
      waves[selectedWave].spread = constrain(waves[selectedWave].spread + sign*.1, 0.1, 10);
      break;
    case 4:
      waves[selectedWave].xspeed = constrain(waves[selectedWave].xspeed + sign*.01, 0, 1);
      break;
    }
  } else if (key == '+') {
    comboWave.increaseWeight(selectedWave, .1);
  } else if (key == '-') {
    comboWave.increaseWeight(selectedWave, -.1);
  } else if (keyCode == DOWN) {
    selectedFeature = constrain(selectedFeature + 1, 0, 4);
  } else if (keyCode == UP) {
    selectedFeature = constrain(selectedFeature - 1, 0, 4);
  }
}