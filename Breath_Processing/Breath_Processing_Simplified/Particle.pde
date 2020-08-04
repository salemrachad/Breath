class Particle {

  PVector position;
  float diameter;
  boolean status;

  int gstate;

  int stoplisteningtimer = 1000;
  long stop_timenow =0;

  float distance_threshold;

  long time_now = 0;

  float timerLight = 1000;
  float timeLightRef = 0;
  int onoff;

  Particle(PVector lin) {

    diameter = 40;
    position = lin.get();
    status = false;
    distance_threshold = 300;
    timeLightRef = millis() - timerLight;
    gstate= 0 ;
  }

  boolean getLight(Particle p) {
    if (position.dist(p.position) < distance_threshold) {
      if (p.status) return true;
      else return false;
    } else return false;
  }

  void Run(Particle p) {

    //if in stat 0 look for event
    //if in state 1- use timefrom trigger --
    display();

    switch (gstate) {

    case 0:     // Looking for event
      //display();
      if (getLight(p)) {
        gstate = 1;
      }
      break;

    case 1:     // found event and start light
      triggerLight();
      if (millis()- timeLightRef < timerLight) {
        
      }
      gstate =2 ;
      break;

    case 2:     // wait for a little bit and then switch back to 0
      stop_timenow = millis();
      if (millis() - stop_timenow > stoplisteningtimer) {
        status = false;
        gstate = 0;
      }
      break;
    }
  }

  void triggerLight() {
    time_now = millis();
    timeLightRef = millis();
  }


  void display() {
    smooth();
    noStroke();   
    //if (gstate == 1) {
    //  fill(255);
    //} else fill(0);

    if (millis() - timeLightRef < timerLight) {
      status = true;
      fill(255);
    } else {
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
      status = true;
    }
  }
}
