class Particle {

  PVector position;
  float diameter;
  boolean status;
  float distance_threshold;
  float timerLight = 100;
  float timeLightRef = 0;

  Particle(PVector lin) {

    diameter = 40;
    position = lin.get();
    status = false;
    distance_threshold = 1000;
    timeLightRef = millis() - timerLight;
  }

  boolean getLight(Particle p) {
    if (position.dist(p.position) < distance_threshold) {
      if (p.status) return true;
      else return false;
    }
    else return false;
  }
  
  void update() {
    // status = false;
  }
  
  void triggerLight() {
    timeLightRef = millis();
  }

  void display() {
    smooth();
    noStroke();
    
    if (millis() - timeLightRef < timerLight) {
      status = true;
      fill(255);
    }
    else {
      status = false;
      fill(0);
    }

    ellipse(position.x, position.y, diameter, diameter);
    
    noFill();
    stroke(255, 0, 0);
    
    ellipse(position.x, position.y, distance_threshold, distance_threshold);
    
  }
  
  void mousePressed() {
    PVector mousePosition = new PVector(mouseX, mouseY);
    if (mousePosition.dist(position) < 0.5 * diameter) {
      triggerLight();
    };
  }
  

}
