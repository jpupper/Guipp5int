

//Inicializar objetos
/*Megaslider megas;
 MegasliderContainer MC;
 Widget ea;*/
Widgetgroup widgetG;

Pencil pencil;

boolean optimizedstroke=false;
boolean showcontrols = true;

void settings() {
 // fullScreen(P3D);
  size(1200,600,P3D);
}
void setup() {

  colorMode(HSB);

  float W = 500;
  float H = 20;
  float sepx = 0;

  //WidgetGroup es el objeto que tiene cada widget que se setea siempre en el medio.
  widgetG = new Widgetgroup(W/2, H/2, W, H, 80);

  //Con esta funcion se agregan widgets que son los que tendran los sliders
  widgetG.addWidget("Color relleno");
  widgetG.addWidget("Color Borde");
  widgetG.addWidget("Oscilacion");
  widgetG.addWidget("PS");
 // widgetG.addWidget("Colores");
  
  
  /* megas = new Megaslider(width/2, height/2, 
   400, 80, 
   0, 255, 
   0, 200, 
   5, 
   200, 
   false, 
   false, 
   false, 
   "e");
   
   MC = new MegasliderContainer(width/2, height/2, 
   400, 80, 
   0, 255, 
   0, 200, 
   5, 
   200, 
   false, 
   false, 
   false, 
   "e");*/

  /*ea = new Widget(width/2, height/2, 400, 100, 100, "AAA");
   ea.addSlider(0, 255, 150, 220, 3, 125, false, true, false, "Tono");
   ea.addSlider( 0, 255, 120, 200, 0.5, 125, false, true, false, "Saturación");*/

  //addSlider : Funcion que crea los sliders, estos son los parametros que toma : 
  /*
   float _minrange, float _maxrange, 
   float _min, float _max, 
   float _speed, 
   float _value, 
   boolean _isPause, 
   boolean _isBounce, 
   boolean _isRandom, 
   String _name*/

  widgetG.widgets.get(0).addSlider(0, 255, 150, 220, 3, 125, false, true, false, "Tono");
  widgetG.widgets.get(0).addSlider( 0, 255, 120, 200, 0.5, 125, false, true, false, "Saturación");
  widgetG.widgets.get(0).addSlider( 0, 255, 150, 255, 2, 255, false, false, false, "Brillo");
  widgetG.widgets.get(0).addSlider( 0, 255, 0, 255, 1, 150, true, true, false, "Alpha");
  
  widgetG.widgets.get(1).addSlider(  0, 255, 0, 255, 5, 125, false, true, false, "Tono");
  widgetG.widgets.get(1).addSlider( 0, 255, 0, 255, 1, 255, true, true, true, "Saturación");
  widgetG.widgets.get(1).addSlider( 0, 255, 0, 50, 3, 0, false, true, false, "Brillo");
  widgetG.widgets.get(1).addSlider( 0, 255, 0, 20, 1, 20, true, true, false, "Alpha");
  
  widgetG.widgets.get(2).addSlider( 0, 150, 0, 75, 9, 50, false, true, false, "Tamaño elipse");
  widgetG.widgets.get(2).addSlider( 0, 10, 0, 10, 10, 255, true, true, false, "Tamaño borde");
  widgetG.widgets.get(2).addSlider( 0, 400, 0, 300, 9, 10, false, true, false, "Amplitud");
  widgetG.widgets.get(2).addSlider( -0.1, 0.1, -0.1, 0.1, 6, 20, false, false, true, "Velocidad Angular");
  pencil = new Pencil();
  background(255);
  //hint(DISABLE_OPTIMIZED_STROKE);
}

void draw() {


  //Dibujar pincel o goma
  if (mousePressed) {
    if (mouseButton == LEFT) {
      pencil.display();
    } else if (mouseButton == RIGHT) {
      fill(255, 150);
      ellipse(mouseX, mouseY, 50, 50);
    }
  }
  //megas.display();
  //megas.update();
  /*MC.display();
   MC.checkinput();
   MC.update();*/

  /*ea.display();
   ea.update();
   ea.checkinput();*/


  // Actualizar valores dados por la interfaz
  widgetG.run();

  //Setear nuevamente las variables del objeto pincel utilizando los valores dados por los sliders de la interfaz

  pencil.setvars(color(widgetG.widgets.get(0).sliders.get(0).value, 
    widgetG.widgets.get(0).sliders.get(1).value, 
    widgetG.widgets.get(0).sliders.get(2).value, 
    widgetG.widgets.get(0).sliders.get(3).value), 
    color(widgetG.widgets.get(1).sliders.get(0).value, 
    widgetG.widgets.get(1).sliders.get(1).value, 
    widgetG.widgets.get(1).sliders.get(2).value, 
    widgetG.widgets.get(1).sliders.get(3).value), 
    widgetG.widgets.get(2).sliders.get(0).value, 
    widgetG.widgets.get(2).sliders.get(2).value, 
    widgetG.widgets.get(2).sliders.get(3).value);
  pencil.strokesize = widgetG.widgets.get(2).sliders.get(1).value;
}

void keyPressed() {
  //Comandos: 
  if (key == '1') {
    pencil.isEllipse = !pencil.isEllipse;
  }
  if (key == '2') {
    pencil.isPolygon = !pencil.isPolygon;
  }
  if (key == '3') {
    pencil.isShape = !pencil.isShape;
  }

  if (key == 's') {
    pencil.npoints++;
  }
  if (key == 'a') {
    pencil.npoints--;
  }
  if (key == 'b') {
    background(255);
  }
  if (key == 'n') {
    showcontrols = !showcontrols;
  }

  if (key == 'l') {
    optimizedstroke = !optimizedstroke;
  }

  if (optimizedstroke) {
    hint(ENABLE_OPTIMIZED_STROKE);
  } else {
    hint(DISABLE_OPTIMIZED_STROKE);
  }  

  if (key == 'm') {
    widgetG.isDraw = !widgetG.isDraw;
  }
}
