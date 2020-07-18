class ParticleSystem {

  ArrayList<Particle> particles;
  PVector origin; //This particular ParticleSystem implementation includes an origin point where each Particle begins.
  PVector v,v1;
  int howmanyparticles;

  ParticleSystem(PVector position) {

    particles = new ArrayList<Particle>();
    origin = position.get();
     v = new PVector(random(0, height), random(0, height));
     v1 = new PVector(random(0, height), random(0, height));
     
  }

  void addParticle(int howmanyparticles_) {
  
    //howmanyparticles = howmanyparticles_;
    //for (int i=0; i< howmanyparticles; i ++){
    //particles.add(new Particle());
    //}
    //The origin is passed to each Particle when it is added.
      particles.add(new Particle(v,0));
      particles.add(new Particle(v1,1));

  }

  void run() {   
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.status();
      p.display();

      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
