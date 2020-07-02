class Pencil {

  int npoints;

  float angle;
  float amp;
  float anglespeed;
  float strokesize;
  
  float circlesize;

  boolean isEllipse;
  boolean isPolygon;
  boolean isShape;

  color colorShape;
  color colorStroke;

  Pencil() {

    npoints = 15;
    isEllipse = true;
    isPolygon = false;
    isShape = true;
    strokesize = 1;
    circlesize = 30;
    anglespeed+=0.1;
    amp = 100;
    colorShape = color(255, 200, 255);
    colorStroke = color(20, 200, 255);
    angle = 0;
  }

  void HSBA() {
    strokeWeight(strokesize);
    stroke(colorStroke);
    if (!isShape) {
      noFill();
    } else {
      fill(colorShape);
    }
  }

  void display() {
    HSBA();


    angle+=anglespeed;
    for (int x=0; x<npoints; x++) {

      float xang = map(x, 0, npoints-1, 0, TWO_PI);

      float rdmx = amp * sin(xang);
      float rdmy = amp * cos(xang);

      pushMatrix();
      translate(mouseX, mouseY);
      rotate(angle);
      if (isPolygon) {
        polygon(0, 0, amp, npoints);
      }
      if (isEllipse) {
        ellipse(rdmx, rdmy, circlesize, circlesize);
      }
      popMatrix();
    }
  }

  void setvars(color _colorShape, color _colorStroke, float _circlesize, float _amp, float _anglespeed) {
    colorShape = _colorShape;
    colorStroke = _colorStroke;
    circlesize = _circlesize;
    amp = _amp;
    anglespeed = _anglespeed;
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}