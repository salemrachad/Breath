class Cell {
  float x, y;
  float diameter;
  int id;
  Cell[] others;
  boolean display = true;
  boolean status = false;
  color cellcolor = 0;
  boolean mouseclick;
  boolean onoff = false;
  int counter = 0;

  Cell(float xin, float yin, int idin, Cell[] oin) {
    x = xin;
    y = yin;
    diameter = 60;
    id = idin;
    others = oin;
    
  }

  void collide() {
    for (int i = id + 1; i < numcells; i++) {
      float distance = dist(x, y, others[i].x, others[i].y);
      float minDist = others[i].diameter/2 + diameter/2;
      if ((distance < minDist) || (x-diameter/2 < 0)|| (x+diameter/2 > width)|| (y-diameter/2 < 0)|| (y+diameter/2 > height)) {
        display = false;
        break;
      }
    }
  }

  boolean status() {
    status=false;

    if ((dist(mouseX, mouseY, x, y)<diameter) && (mousePressed ==true)) {
      status = true;
    }
    return status;
  }

  void display() {
    if (!display) return;
    if (status== true) {
      cellcolor = 255;
    } else cellcolor =0;
    fill(cellcolor);
    ellipse(x, y, diameter, diameter);
  }

  void checkNeighbors() {
  for (int i = id + 1; i < numcells; i++) {
      float distance = dist(x, y, others[i].x, others[i].y);
      if ((distance < 300) && (others[i].status == true)){
      status = true;
      counter = counter +1;
        break;
      }
    }
  }
  void reset() {
    status=false;
  }
}
