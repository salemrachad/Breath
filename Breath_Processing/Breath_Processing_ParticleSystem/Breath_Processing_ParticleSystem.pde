ParticleSystem ps;
PFont font;

void setup() {
  size(800, 800);
  frameRate(30);
  
  ps = new ParticleSystem(new PVector(width/2,height/2));
  ps.addParticle();
  font = createFont("Arial Bold",48);
 
}
void draw() {
  
background(105,100,255);

ps.run();
text(frameRate,20,20);

}
