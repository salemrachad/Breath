class Cell {
  PVector position;

  float radius;
  float offset;
  boolean status;
  color cellcolor;
  boolean mousee;
  Cell[] others;

  Cell(int i) {
    radius = 30;
    offset = radius/2;
    position = new PVector(random(0+offset, width-offset), random(0+offset, height-offset));
    cellcolor = color(255);
    boolean mousee = false;
  }

  boolean status() {
    status=false;

    if ((dist(mouseX, mouseY, position.x, position.y)<radius) && (mousePressed ==true)) {
      status = true;
    }
    return status;
  }

  void checkNeighbors() {
  }

  void play() {
    if (status == true) {
      fill(cellcolor);
    }
    else fill(0);

    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
  } 
  void reset() {
    status=false;
    fill(cellcolor);
  }
}
