class Particle {

  PVector position;
  PVector l;
  int id;
  int cellColor;
  float radius;
  //float checkRadius;
  boolean mouseclick;
  boolean status;
  float fade = 0.25;

  Particle(PVector lin, int idin) {

    radius = 40;
    cellColor = 1;
    position = lin.get();
    id = idin;
    status = false;
  }



  boolean status() {

    if ((dist(mouseX, mouseY, position.x, position.y)<radius) && (mousePressed ==true)) {
      status = true;
    } else status = false;
    return status;
  }


  void update(ArrayList<Particle> p, int i) {

    for (int j = i+1; j<p.size(); j++) {
      float distance = position.dist(p.get(i).position);

      if (distance < 200) {
        float intensity = map (distance, 0, 200, 0, 255);


        readSensors(intensity);
      }
    }
  }

  void readSensors(float intensity_) {   //Detect LDR

    //LDR Range
    //LDR Sensitivity
    
  }

  void triggerLED() {                    // Emit Light
    if (status == true) {
      cellColor = 254;
    } else if (status == false) {
      cellColor = 1;
    }
  }

  void display() {
    smooth();
    noStroke();
    fill(cellColor);
    ellipse(position.x, position.y, radius, radius);
  }
  
  void run() {
    status();
    triggerLED();
    display();
  }
}
