
public class Slider {

  public float x, y, w, h;
  public float value;

  public float min, max;

  public color backcolor;
  public color topcolor;

  public int textSize;

  public boolean isActivable;

  Slider(float _x, float _y, float _w, float _h, float _min, float _max, float _value) {

    x =_x;
    y =_y;
    w = _w;
    h = _h;

    backcolor = color(120, 150, 120);
    topcolor = color(120, 150, 160);

    /*Color_active = color(120, 150, 255);
     Color_mouseover = color(120, 150, 160);
     Color_standart = color(120, 150, 120);*/

    min = _min;
    max = _max;
    value = _value;

    textSize = 10;
    isActivable = true;
  }

  Slider(float _x, float _y, float _w, float _h) {

    x =_x;
    y =_y;
    w = _w;
    h = _h;

    backcolor = color(255, 150, 180);
    topcolor = color(255, 100, 255);

    min = 0;
    max = 255;
    value = random(min, max);

    textSize = 10;
    isActivable = true;
  }

  public void run() {
    display();
    checkinput();
  }

  public void display() {
    rectMode(CENTER);
    fill(backcolor);
    rect(x, y, w, h);
    fill(topcolor);
    rectMode(CORNERS);
    rect(x-w/2, y-h/2, map(value, min, max, x-w/2, x+w/2), y+h/2 );
    fill(255, 0, 0);
    rectMode(CENTER);

    textSize(textSize);
    textAlign(LEFT);
    text(min, x-w/2, y);
    textAlign(RIGHT);
    text(max, x+w/2, y);
    textAlign(CENTER);
    text(value, x, y);
  }

  public void checkinput() {
    if (isActivable) {
      if (mousePressed 
        && mouseX > x - w/2
        && mouseX < x + w/2
        && mouseY > y - h/2
        && mouseY < y + h/2) {
        value = map(mouseX, x-w/2, x+w/2, min, max);
      }
    }
  }

  public void setpos(float _x, float _y) {
    x = _x;
    y = _y;
  }
}


class QuadElement {

  public float x;
  public float y;
  public float w;
  public float h;

  public boolean isActive = false;
  public boolean isActivable = true; //variable to set if it can be active or not.

  public color Color_active;
  public color Color_mouseover;
  public color Color_standart;

  public boolean isShape = false;
  public PShape displayshape ;


  public boolean mouseFlag;

  QuadElement(float _x, float _y, float _w, float _h) {

    x = _x;
    y = _y;
    w = _w;
    h = _h;

    rectMode(CENTER);

    Color_active = color(120, 150, 255);
    Color_mouseover = color(120, 150, 160);
    Color_standart = color(120, 150, 120);

    displayshape = createShape();
    displayshape.beginShape();
    displayshape.vertex(w/2, -w/2 );
    displayshape.vertex(-w/2, -w/2 );
    displayshape.vertex(-w/2, w/2);
    displayshape.vertex(w/2, w/2);

    displayshape.endShape(CLOSE);
    displayshape.disableStyle();
  }

  public void run() {
    display();
    checkinput();
  }

  public void display() {

    if (isActive && isActivable) {
      stroke(Color_active);
      fill(Color_active);
    } else {
      if (isMouseOver()) {
        stroke(Color_mouseover);
        fill(Color_mouseover);
      } else {
        stroke(Color_standart);
        fill(Color_standart);
      }
    }

    displayShape();
    stroke(0);
    noStroke();
  }

  protected void displayShape() {
    if (isShape) {
      shapeMode(CORNER);
      //fill(150, 255, 255);
      shape(displayshape, x, y);
    } else {
      rect(x, y, w, h);
    }
  }

  public void checkinput() {
    if (isActivable) {
      if (mousePressed && isMouseOver() ) {
        isActive = true;
      }

      if (!mousePressed) {
        isActive = false;
      }
    }
  }

  public boolean isClick() {

    /*Esto realmente es innecesario, is active es lo mismo que is click,
     el asunto es que necesito otro metodo para manejar el header */

    if (isMouseOver() && mousePressed) {
      mouseFlag = true;
    }

    if (!mousePressed) {
      mouseFlag = false;
    }

    if (mouseFlag) {
      return  true;
    } else {
      return false;
    }
  }

  public boolean isMouseOver() {
    if ( mouseX > x - w/2
      && mouseX < x + w/2
      && mouseY > y - h/2
      && mouseY < y + h/2) {
      return true;
    } else return false;
  }

  public boolean istouchingWidget(QuadElement quad) {

    float p1a  = y + h/2;
    float p2a  = y - h/2; 

    float p3a  = x + w/2;
    float p4a  = x - w/2;

    float p1b  = quad.y + quad.h/2;
    float p2b  = quad.y - quad.h/2 ;

    float p3b  = quad.x + quad.w/2;
    float p4b  = quad.x - quad.w/2;

    if (    ((p1a > p1b &&  p1a > p2b &&  p2a > p1b && p2a > p2b) || 
      (p1a < p1b && p1a < p2b && p2a < p1b && p2a < p2b)) ||
      ((p3a > p3b && p3a > p4b && p4a > p3b && p4a > p4b) ||
      (p3a < p3b && p3a < p4b && p4a < p3b && p4a < p4b))
      ) {
      return false;
    } else {
      return true;
    }
  }

  public void setpos(float _x, float _y) {
    x = _x;
    y = _y;
  }
}

class Tick extends QuadElement {

  int dir ;
  Tick(float _x, float _y, float _w, float _h, int _dir) {

    super(_x, _y, _w, _h); 
    isShape = true;

    dir = _dir;
    displayshape = createShape();
    displayshape.beginShape();
    displayshape.vertex(_w/2, _h/2 );

    if (dir == 0) {
      displayshape.vertex(-_w/2, -_h/2 );
    } else if (dir == 1) { 
      displayshape.vertex(_w/2, -_h/2);
    }

    displayshape.vertex(-_w/2, _h/2 );
    displayshape.endShape(CLOSE);
    displayshape.disableStyle();
  }
}

class timeTick extends QuadElement {

  timeTick(float _x, float _y, float _w, float _h) {

    super(_x, _y, _w, _h); 
    isShape = true;

    displayshape = createShape();
    displayshape.beginShape();
    displayshape.vertex(-w/2, -_h/2 );
    displayshape.vertex(0, -_h/4 );
    displayshape.vertex(_w/2, -_h/2 );
    displayshape.vertex(_w/2, 0 );
    displayshape.vertex(0, _h/2 );
    displayshape.vertex(-_w/2, 0 );

    displayshape.endShape(CLOSE);
    displayshape.disableStyle();
  }
}

class Toogle extends QuadElement {

  String name ;
  float textsize;
  PFont font;
  private boolean mouseflag;


  Toogle(float _x, float _y, float _w, float _h, String _name) {
    super(_x, _y, _w, _h);

    textsize = 15;
    font = loadFont("Arial-Black-12.vlw");
    name = _name;
    mouseflag = true;
  }
  protected void displayShape() {
    super.displayShape();
    textAlign(CENTER, CENTER);
    fill(0);
    textFont(font);
    textSize(textsize);
    text(name, x, y);
  }

  void checkinput() {
    if (isActivable) {
      if (mousePressed && isMouseOver() && mouseFlag ) {
        isActive = !isActive;
        mouseFlag = false;
      }

      if (!mousePressed) {
        mouseflag = true;
      }
    }
  }
}


// ESTA CLASE DIRECTAMENTE SE PODRIA BORRAR Y METER DENTRO DEL MEGASLIDERCONTAINER, PERO BUENO YA FUE.
class Megaslider {

  protected float x, y, w, h; 
  public color backcolor;

  public color tickcolor;
  public color activecolor;

  private float rangebarX, rangesize;

  private float ticksize;
  float tickminX;
  float tickmaxX;

  float minrange, maxrange; // El minimo  y maximo dentro del rango total
  float min, max; //La posicion del minimo y del maximo
  float actualvalue;

  float speed;

  boolean dir ; //derecha, suma;
  boolean bounce;
  boolean israndom;
  boolean isPause;
  boolean isActivable;

  QuadElement tickmin, tickmax, rangebar, timetick;

  float offsety;
  float lastmousex;

  String name;
  private boolean isName;

  Megaslider (float _x, float _y, float _w, float _h, float _minrange, float _maxrange, float _min, float _max, float _speed, float _value, boolean _isPause, boolean _israndom, boolean _isbounce, String _name) {

    x = _x;
    y = _y;
    w = _w;
    h = _h;

    minrange = _minrange;
    maxrange = _maxrange;

    min = _min;
    max = _max;
    actualvalue = _value;
    name = _name;

    backcolor = color(150, 100);

    ticksize = _h/2;

    rangesize = (x-w/2+ticksize/2+map(max, _minrange, _maxrange, 0, _w)) - (x-w/2-ticksize/2+map(min, _minrange, _maxrange, 0, _w)) - ticksize;
    println(rangesize);
    float rangebarX = x-w/2+map(min, _minrange, _maxrange, 0, _w)+rangesize/2; 
    offsety =_h/4 -1;

    rangebar= new QuadElement(rangebarX, _y+offsety, rangesize, _h/2);

    tickmin = new Tick(x-w/2-ticksize/2+map(min, _minrange, _maxrange, 0, _w), _y+offsety, ticksize, ticksize, 1);
    tickmax = new Tick(x-w/2+ticksize/2+map(max, _minrange, _maxrange, 0, _w), _y+offsety, ticksize, ticksize, 0);
    timetick = new timeTick(rangebarX, _y-offsety, ticksize, ticksize);


    bounce = _isbounce;
    isPause = _isPause;
    israndom = _israndom;
    dir =false;
    isActivable = true;

    speed=_speed;
    lastmousex =mouseX;
    isName = true;
  }

  Megaslider(float _x, float _y, float _w, float _h, float _minrange, float _maxrange) {

    x = _x;
    y = _y;
    w = _w;
    h = _h;

    minrange = _minrange;
    maxrange = _maxrange;

    backcolor = color(150, 100);

    rangesize = random(_w);
    ticksize = _h/2;

    float rangebarX = _x; //Cambiarlo por ponerle random cuando tenga los ticks y todo eso
    offsety =_h/4 -1;
    rangebar= new QuadElement(rangebarX, _y+offsety, rangesize, _h/2);

    /*TICK ULTIMO ARGUMENTO   
     0 = PARA QUE MIRE PARA LA DERECHA
     1 = PARA QUE MIRE PARA LA IZQUIERDA */    //cualquier otro valor no lo reconoce

    tickmin = new Tick(rangebarX-rangesize/2-ticksize/2, _y+offsety, ticksize, ticksize, 1);
    tickmax = new Tick(rangebarX+rangesize/2+ticksize/2, _y+offsety, ticksize, ticksize, 0);
    timetick = new timeTick(rangebarX, _y-offsety, ticksize, ticksize);

    bounce = true;
    dir =false;
    isPause = true;
    speed=1;
    lastmousex =mouseX;
    isName = false;
    isActivable = true;
  }

  public void run() {
    display();
    update();
  }

  public void display() {

    rectMode(CENTER);
    fill(backcolor);
    rect(x, y, w, h);

    //fill(255, 255, 255);
    //rect(x, y, ticksize, ticksize);
    rangebar.display();

    tickmin.display();
    tickmax.display();
    timetick.display();

    if (isName) {
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(16);
      text(name, rangebar.x, rangebar.y);
    }
  }

  public void checkinput() {
    if (isActivable) {

      //Should be a better way to do this, but if you don´t put 3 setinputvalues() the things look weird
      //Deberia haber una mejor solución , pero si no se pone esto las cosas se ponen raras
      setInputvalues();
      setInputvalues();
      setInputvalues();

      rangebar.checkinput();
      tickmin.checkinput();
      tickmax.checkinput();
      timetick.checkinput();
    }
  }

  public void update() {
    /*float p1 = x-w/2;
     float p2 = tickmin.x+ticksize/2;
     float p3 = tickmax.x-ticksize/2 ;
     float p4 = x+w/2 ;
     */
    min = map(tickmin.x+tickmin.w/2, x-w/2, x+w/2, minrange, maxrange);
    max = map(tickmax.x-tickmax.w/2, x-w/2, x+w/2, minrange, maxrange);

    checkEdges();

    if (!isPause && !timetick.isActive) {
      if (israndom) {
        timetick.x = random(tickmin.x+ticksize/2, tickmax.x-ticksize/2 );
      } else if (dir) {
        timetick.x+=speed;
      } else {
        timetick.x-=speed;
      }
    }

    actualvalue = map(timetick.x, x-w/2, x+w/2, minrange, maxrange);


    /*println("min", min);
     println("max", max);
     println("Valor", actualvalue);*/
  }



  private void checkEdges() {

    float p1 = x-w/2;
    float p2 = tickmin.x+ticksize/2;
    float p3 = tickmax.x-ticksize/2 ;
    float p4 = x+w/2 ;


    if (!timetick.isActive) {
      if (bounce) {
        if (timetick.x > p3) {
          timetick.x = p3;
          dir = !dir;
        }
        if (timetick.x  <p2) {

          timetick.x = p2;
          dir = !dir;
        }
      } else {


        if (timetick.x > p3) {
          timetick.x = p2;
        }

        if (timetick.x  <p2) {
          timetick.x = p3;
        }
      }
    }
  }


  private void setInputvalues() {

    // Son 4 los puntos de control

    /* |-----/_|--------|_\-------| 
     p1     p2         p3       p4 */

    float p1 = x-w/2;
    float p2 = tickmin.x+ticksize/2;
    float p3 = tickmax.x-ticksize/2 ;
    float p4 = x+w/2 ;

    float rangebaraux = rangebar.w;

    if (mousePressed) {
      if (rangebar.isActive) {
        if (p2 >= p1  && p3 <= p4) { 
          rangebar.x += mouseX - lastmousex;
          tickmin.x = rangebar.x-rangebar.w/2-ticksize/2; 
          tickmax.x = rangebar.x+rangebar.w/2+ticksize/2;
          tickmin.isActivable = false;
          tickmax.isActivable = false;
          timetick.isActivable =false;
        }
        if (p2 < p1) {
          tickmin.x = p1 -tickmin.w/2;
          rangebar.x = tickmin.x+rangebar.w/2+tickmin.w/2;
          tickmax.x = rangebar.x+rangebar.w/2+tickmin.w/2;
          println("P2 < P1");
        }

        if (p3 > p4) {
          tickmax.x = p4+tickmin.w/2;
          rangebar.x = tickmax.x-rangebar.w/2-tickmin.w/2;
          tickmin.x = rangebar.x-rangebar.w/2-tickmin.w/2;
          println("P3 > P4");
        }
      }
      if (tickmin.isActive) { 
        if (p2 >= p1  &&  p2 <= p3) {
          tickmin.x += mouseX - lastmousex;
          float DistTickminmax = tickmax.x + tickmin.x;
          rangebar.x = DistTickminmax/2;
          rangebar.w = (rangebar.x - tickmin.x-tickmin.w/2)*2;
          rangebar.isActivable = false;
          tickmax.isActivable = false;
          timetick.isActivable =false;
        }
        if (p2 < p1) {
          rangebar.w = rangebaraux;
          tickmin.x = p1 -tickmin.w/2;
          rangebar.x = tickmin.x+rangebar.w/2+tickmin.w/2;
          println("P2 < P1");
        }
        if (p2 > p3) {
          tickmin.x = tickmax.x-tickmin.w;
          rangebar.x = tickmax.x-rangebar.w/2-tickmin.w/2;
          tickmin.x--;
          println("P2 > P3");
        }
      }
      if (tickmax.isActive) {
        if (p3 >= p2 && p3 <=p4) {
          tickmax.x+= mouseX - lastmousex;
          float DistTickminmax = tickmax.x + tickmin.x;
          rangebar.x = DistTickminmax/2;
          rangebar.w = (rangebar.x - tickmin.x-tickmin.w/2)*2;
          rangebar.isActivable = false;
          tickmin.isActivable = false;
          timetick.isActivable =false;
        } 
        if (p3 < p2) {
          tickmax.x = tickmin.x + tickmax.w;
          rangebar.x = tickmax.x+rangebar.w/2+tickmax.w/2;
          tickmax.x++;
          println("P3 < P2");
        }   
        if (p3 > p4) {
          tickmax.x = p4+tickmin.w/2;
          rangebar.x = tickmax.x-rangebar.w/2-tickmin.w/2;
          println("P3 > P4");
        }
      }

      if (timetick.isActive) {

        if (timetick.x >= p2 && timetick.x <= p3) {
          timetick.x+= mouseX - lastmousex;
        }

        if (timetick.x < p2) {
          timetick.x = p2;
        }
        if (timetick.x > p3) {
          timetick.x = p3;
        }
        rangebar.isActivable = false;
        tickmin.isActivable = false;
        tickmax.isActivable = false;
        rangebar.isActivable = false;
      }
    } else {
      rangebar.isActivable = true;
      tickmax.isActivable = true;
      tickmin.isActivable = true;
      timetick.isActivable = true;
    }
    lastmousex = mouseX;
  }

  public boolean isOverSlider() {
    if (mouseX > x - w/2
      && mouseX < x + w/2
      && mouseY > y - h/2
      && mouseY < y + h/2) {
      return true;
    } else return false;
  }

  public void setpos(float _x, float _y) {
    x = _x;
    y = _y;

    rangebarX = abs((_x-w/2-ticksize/2+map(min, minrange, maxrange, 0, w)) - (_x-w/2+ticksize/2+map(max, minrange, maxrange, 0, w)));
    ////rangebar.w =
    //rangebar.setpos(rangebarX, _y+offsety);
    tickmin.setpos(_x-w/2-ticksize/2+map(min, minrange, maxrange, 0, w), _y+offsety);
    tickmax.setpos(_x-w/2+ticksize/2+map(max, minrange, maxrange, 0, w), _y+offsety);
   // timetick.setpos(rangebarX+rangesize/2+ticksize/2, _y-offsety);
  }
}

class MegasliderContainer {

  Megaslider megaslider;

  Slider speed;


  boolean mouseflag;
  boolean isActivable = true;


  float x, y, w, h;
  float margin; //MARGIN BETWEEN ELEMENTS , el margen entre los elementos

  float tooglesize;
  Toogle left, right, pause, random, bounce ;

  float toogleoffset, slideroffset;


  color backcolor;
  float value;

  MegasliderContainer(
    float _x, float _y, 
    float _w, float _h, 
    float _minrange, float _maxrange, 
    float _min, float _max, 
    float _speed, 
    float _value, 
    boolean _isPause, 
    boolean _isBounce, 
    boolean _isRandom, 
    String _name) {

    backcolor = color (0);

    x =_x;
    y = _y;
    w = _w;
    h = _h;
    margin = 30;
    slideroffset = 5;

    megaslider = new Megaslider(_x, _y -h/4+slideroffset, _w-margin, _h/3, _minrange, _maxrange, _min, _max, _speed, _value, _isPause, _isRandom, _isBounce, _name);


    /* CONSTRUCTOR
     Megaslider (float _x, float _y, float _w, float _h, float _minrange, float _maxrange, float _min, float _max,float _speed, float _value,boolean _isPause,boolean _israndom,boolean _isbounce, String _name) */

    megaslider.speed = 1;

    toogleoffset = 0;
    tooglesize = 20;

    // float sliderW = _w/2;

    left   = new Toogle(_x-_w/2+tooglesize*0.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "<");
    right  = new Toogle(_x-_w/2+tooglesize*1.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, ">");
    pause  = new Toogle(_x-_w/2+tooglesize*2.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "||");
    random = new Toogle(_x-_w/2+tooglesize*3.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "R");
    bounce = new Toogle(_x-_w/2+tooglesize*4.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "B");
    speed  = new Slider(_x - _w/2+tooglesize*6 +margin/2 + _w/2/2, _y + h/4, _w/2, tooglesize, 0, 10, 1);

    speed.value = _speed;
    pause.isActive =_isPause;
    bounce.isActive = _isBounce;
    random.isActive = _isRandom;
    isActivable = true;
  }

  MegasliderContainer(float _x, float _y, float _w, float _h, float _max, float _min) {

    backcolor = color (0);

    x =_x;
    y = _y;
    w = _w;
    h = _h;
    margin = 30;
    slideroffset = 5;
    megaslider = new Megaslider(_x, _y -h/4+slideroffset, _w-margin, _h/3, _min, _max);
    megaslider.speed = 1;

    toogleoffset = 0;
    tooglesize = 20;

    left   = new Toogle(_x-_w/2+tooglesize*0.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "<");
    right  = new Toogle(_x-_w/2+tooglesize*1.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, ">");
    pause  = new Toogle(_x-_w/2+tooglesize*2.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "||");
    random = new Toogle(_x-_w/2+tooglesize*3.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "R");
    bounce = new Toogle(_x-_w/2+tooglesize*4.5 +margin/2, _y + h/4 + toogleoffset, tooglesize, tooglesize, "B");
    speed  = new Slider(_x - _w/2+tooglesize*6 +margin/2 + _w/2/2, _y + h/4, _w/2, tooglesize, 0, 10, 1);

    pause.isActive =true;
    isActivable = true;
  }

  void run() {
    display();
    checkinput();
    update();
  }

  void display() {
    noStroke();
    fill(backcolor);
    rect(x, y, w, h);
    megaslider.display();    
    left.display();
    right.display();
    pause.display();
    random.display();
    bounce.display();    
    speed.display();
  }

  void update() {
    megaslider.update();
    megaslider.speed = speed.value;
    value = megaslider.actualvalue;
  }

  void checkinput() {
    if (isActivable) {
      megaslider.checkinput();
      checkToogles() ;
      left.checkinput();
      right.checkinput();
      pause.checkinput();
      random.checkinput();
      bounce.checkinput();
      speed.checkinput();
    }
  }

  private void checkToogles() {

    if (mousePressed && mouseflag ) {

      if (left.isMouseOver()) {
        left.isActive = true; 
        right.isActive = false;
        megaslider.dir = !megaslider.dir;
        mouseflag = false;

        right.isActivable = false;
        random.isActivable =false;
        bounce.isActivable =false;
        pause.isActivable = false;
      }

      if (right.isMouseOver()) {
        left.isActive = false; 
        right.isActive = true;
        megaslider.dir = !megaslider.dir;
        mouseflag = false;

        left.isActivable = false;
        random.isActivable =false;
        bounce.isActivable =false;
        pause.isActivable = false;
      }

      if (random.isMouseOver()) {
        left.isActive = false; 
        right.isActive = false;
        random.checkinput();
        megaslider.israndom = !megaslider.israndom;
        mouseflag = false;
        random.isActive = !random.isActive;

        left.isActivable   = false;
        right.isActivable  = false;
        bounce.isActivable = false;
        pause.isActivable  = false;
      }

      if (bounce.isMouseOver()) {
        bounce.checkinput();
        megaslider.bounce = !megaslider.bounce;
        mouseflag = false;
        bounce.isActive = !bounce.isActive;

        left.isActivable   = false;
        right.isActivable  = false;
        random.isActivable = false;
        pause.isActivable  = false;
      }

      if (pause.isMouseOver()) {
        pause.checkinput();
        megaslider.isPause = !megaslider.isPause;
        mouseflag = false;
        pause.isActive = !pause.isActive;

        left.isActivable   = false;
        right.isActivable  = false;
        random.isActivable = false;
        bounce.isActivable = false;
      }
    }

    if (!mousePressed) {
      mouseflag = true;
      left.isActivable  = true;
      right.isActivable  =true;
      random.isActivable =true;
      bounce.isActivable = true;
      pause.isActivable  = true;
    }

    if (megaslider.dir) {
      left.isActive = false; 
      right.isActive = true;
    } else {
      left.isActive = true; 
      right.isActive = false;
    }
  }

  void changecolor(color _color) {
    backcolor = _color; 
    megaslider.backcolor = _color;
  }

  void setpos(float _x, float _y) {
    x = _x;
    y = _y;

    left.x = _x-w/2+tooglesize*0.5 +margin/2;
    right.x = _x-w/2+tooglesize*1.5 +margin/2;
    pause.x = _x-w/2+tooglesize*2.5 +margin/2;
    random.x = _x-w/2+tooglesize*3.5 +margin/2;
    bounce.x = _x-w/2+tooglesize*4.5 +margin/2;

    left.y =  _y + h/4 + toogleoffset ;
    right.y =  _y + h/4 + toogleoffset ;
    pause.y =  _y + h/4 + toogleoffset ;
    random.y =  _y + h/4 + toogleoffset ;
    bounce.y =  _y + h/4 + toogleoffset ;

    megaslider.setpos(_x, _y -h/4+slideroffset); 
    speed.setpos(_x - w/2+tooglesize*6 +margin/2 + w/2/2, _y + h/4);
    //speed  = new Slider(_x - w/2+tooglesize*6 +margin/2 + w/2/2, _y + h/4, w/2, tooglesize, 0, 10, 1);
  }
}

class Widget {

  ArrayList<MegasliderContainer> sliders;


  float x, y, w, h;
  float headerh;
  float sliderh;


  Toogle header;

  boolean isDraw = true;
  boolean isOpen = false; //This works just like "isActivable method but it also will display/not display de sliders;

  private boolean mouseFlag;
  float widgetH;

  color backgroundcolor ;

  Widget(float _x, float _y, float _w, float _headerh, float _sliderh, String _headertext) {

    x = _x;
    y = _y;
    w = _w;
    headerh = _headerh;
    sliderh = _sliderh;

    sliders = new ArrayList<MegasliderContainer>();
    sliderh = _sliderh;
    header = new Toogle(_x, _y, _w, _headerh, _headertext);

    backgroundcolor = color(110, 255, 255, 255);
    // sliderh =

    widgetH = headerh/2+sliderh/2; 
    /*Bueno en realidad no es el widgetH si no le agregas ningun slider,
     pero asumamos que siempre que se crea un widget se le pone un slider.
     Igual esto habría que cambiarlo si se le pone otra cosa que no sea sliders
     O si se planea que haya sliders de distintos tamaños, porque esta todo como bastante standarizado en este sentido*/
  }

  void run() {
    display();
    update();
    checkinput();
  }
  void display() {
    if (isDraw) {
      fill(backgroundcolor);
      header.display();
      if (isOpen) {
        // rect(x, widgetH*0.5, w, widgetH);
        for (MegasliderContainer p : sliders) {
          p.display();
        }
      }
    }
  }

  void update() {

    for (int j =0; j<sliders.size(); j++) {
      sliders.get(j).update();
    }
  }

  void checkinput() {
    if (header.isClick() && mouseFlag) {
      isOpen = !isOpen;
      mouseFlag = false;
    }
    if (!mousePressed) {
      mouseFlag = true;
    }
    header.checkinput();

    if (isOpen) {
      for (MegasliderContainer p : sliders) {
        p.checkinput();
      }
    }
  }

  void addSlider(float _minrange, float _maxrange) {
    sliders.add(new MegasliderContainer( x, y+widgetH, w, sliderh, _minrange, _maxrange));
    widgetH+= sliderh;
  }

  void addSlider(float _minrange, float _maxrange, 
    float _min, float _max, 
    float _speed, 
    float _value, 
    boolean _isPause, 
    boolean _isBounce, 
    boolean _isRandom, 
    String _name
    ) {
    sliders.add(new MegasliderContainer(x, y+widgetH, 
      w, sliderh, 
      _minrange, _maxrange, 
      _min, _max, 
      _speed, 
      _value, 
      _isPause, 
      _isBounce, 
      _isRandom, 
      _name));
    widgetH+= sliderh;
  }

  void addSlider() {
    sliders.add(new MegasliderContainer( x, y+widgetH, w, sliderh, 0, 255));
    widgetH+= sliderh;
  }

  void setpos(float _x, float _y) {
    header.x = _x;
    header.y = _y;

    float setslidery = _y + header.h/2 +sliderh/2;
    for (int x=0; x<sliders.size(); x++) {
      sliders.get(x).setpos(_x, setslidery);
      setslidery+=sliderh;
    }
  }
}


class Widgetgroup {

  ArrayList<Widget> widgets;

  float x, y, w, headerh, sliderh;
  //int activewidget = 0;

  private float widgety;

  boolean mouseFlag;
  boolean isDraw = true;

  Widgetgroup(float _x, float _y, float _w, float _headerh, float _sliderh) {

    x =_x;
    y = _y;
    w = _w;
    widgety = _y;
    headerh = _headerh;
    sliderh = _sliderh;
    widgets = new ArrayList<Widget>();

    mouseFlag = true;
  }

  void run() {
    strokeWeight(1);
    display();
    update();
    checkinput();
  }

  void display() {
    if (isDraw) {
      for (int x=widgets.size()-1; x>=0; x--) {
        Widget W = widgets.get(x);
        W.display();
      }
    }
  }

  void update() {
    for (int k=0; k<widgets.size(); k++) {
      Widget W = widgets.get(k);
      W.update();
    }
  }

  void checkinput() {
    if (isDraw) {
      for (Widget p : widgets) {
        p.checkinput();
        if (p.header.isClick()) {
         activeWidget();
         }
      }
    }
  }

  void addWidget(String _widgetname) {
    widgets.add(new Widget (x, widgety, w, headerh, sliderh, _widgetname));
    widgety+=headerh;
  }

  void activeWidget() {

    float poswidgety = y;

    for (int k=0; k<widgets.size(); k++) {
      widgets.get(k).setpos(x, poswidgety);
      if (widgets.get(k).isOpen 
        && widgets.size()-1 != k) {
        poswidgety+=widgets.get(k).widgetH-headerh*1.5;
      } else {
        poswidgety+= headerh ;
      }
    }
  }
}