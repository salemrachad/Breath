class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList<Particle>(); //Arraylist of Particles
  
  PVector origin; //This particular ParticleSystem implementation includes an origin point where each Particle begins.
  int howmanyparticles = 5;

  ParticleSystem(PVector position) {

    origin = position.get();

    
  }

  void addParticle() {
    for (int i = 0; i < howmanyparticles; i++) {
      particles.add(new Particle(new PVector(random(width), random(0, height)), i));
    }
  }

  void run() {   
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      //p.readSensors
      //p.triggerLED
      p.run();
    }
  }
}

 //void checkNeighbors(int i) {

 //   for (int j = i+1; j<particles.size(); j++) {
 //     float distance = position.dist(p.get(i).position);

 //     if (distance < 200) {
 //       float intensity = map (distance, 0, 200, 0, 255);


 //       readSensors(intensity);
 //     }
 //   }
