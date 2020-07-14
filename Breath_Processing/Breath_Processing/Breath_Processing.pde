int numcells = 200;
boolean overlap;
Cell[] cells = new Cell[numcells];
boolean offon = false;

void setup() {
  size(800, 800);
  noStroke();
  smooth();
  for (int i = 0; i < numcells; i++) {
    cells[i] = new Cell(random(width), random(height), i, cells);
  }
}
void draw() {

  for (int i = 0; i < numcells; i++) {
    cells[i].collide();
  }
  for (int i = 0; i < numcells; i++) {
    if (cells[i].status() ==true) {
      cells[i].checkNeighbors();
    }
  }

  for (int i = 0; i < numcells; i++) {
    cells[i].display();
  }
}
