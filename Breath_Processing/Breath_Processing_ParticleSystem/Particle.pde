class Particle {

  PVector position;
  PVector l;
  int id;
  int cellColor;
  float radius;
  //float checkRadius;
  boolean mouseclick;
  boolean status = false;
  float opacity;

  //Particle(PVector l) {   location of pvector
  Particle(PVector lin,int idin) {
    
    radius = 40;
    cellColor = 255;
    position = lin.get();
    id = idin;
    opacity = 255;
    
  }
  
  void readSensors() {
    
    
  }

  void triggerLED() {
    for (float i = 255; i>0; i--){
      opacity = i;
    }
    
    status = false;
    println("status is false");
  }

  boolean isDead() {
    return true;
  }

  void display() {
    smooth();
    noStroke();
    
    if (status == true){
      println("status is True");
      triggerLED();
    }
    fill(cellColor,opacity);
    ellipse(position.x, position.y, radius, radius);
  }
  
   boolean status() {
    status=false;

    if ((dist(mouseX, mouseY, position.x, position.y)<radius) && (mousePressed ==true)) {
      status = true;
    }
    return status;
  }

    void update() {
    }

    void run() {
      update();
      display();
    }
}
