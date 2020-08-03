ArrayList<Particle> particles;
PFont font;
int numParticles = 5;


void setup() {
  size(600, 600);
  frameRate(30);

  particles = new ArrayList<Particle>();

  for (int i = 0; i < numParticles; i++) {

    Particle p = new Particle(new PVector(random(0+40, width-40), random(0+40, height-40)));
    particles.add(p);
  }


  font = createFont("Arial Bold", 48);
}
void draw() {

  background(105, 100, 255);

  for (int i = 0; i < numParticles; i++) {
    particles.get(i).update();
  }

  for (int i= 0; i < numParticles; i++) {

    Particle p = particles.get(i);

    for (int j = 0; j < numParticles; j++) {
      if (j != i) {

        if (p.getLight(particles.get(j))) {
        // p.particlestate(particles.get(j));
          p.triggerLight();
        }
      }
    }
  }

  for (int i = 0; i < numParticles; i++) {
    particles.get(i).display();
  }

  text(frameRate, 20, 20);
}

void mousePressed() {

  for (int i = 0; i < numParticles; i++) {
    particles.get(i).mousePressed();
  }
}
