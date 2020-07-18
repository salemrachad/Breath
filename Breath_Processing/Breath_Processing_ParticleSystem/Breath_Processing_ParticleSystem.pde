ParticleSystem ps;
PFont font;

void setup() {
  size(800, 800);
  frameRate(30);
  
  ps = new ParticleSystem(new PVector(width/2,height/2));
  font = createFont("Arial Bold",48);
 
}
void draw() {
  
background(0);
ps.addParticle(5);
ps.run();
text(frameRate,20,20);

}
