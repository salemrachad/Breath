ArrayList<Cell> cells;
int cell_Count=50;

boolean overlap;
//Cell[] cellss = new Cell[cell_Count];

void setup() {
  size(800, 800);
  cells = new ArrayList<Cell>();
  for (int i=0; i < cell_Count; i++) { 
    cells.add(new Cell(random(width), random(height), i, cells));
  }
  
}
void draw() {

  for (int i = 0; i < cell_Count; i++) {
    cells.get(i).collide();
  }
  for (int i = 0; i < cell_Count; i++) {
    cells.get(i).status();
  }
  for (int i = 0; i < cell_Count; i++) {
    cells.get(i).checkNeighbors();
  }
  for (int i = 0; i < cell_Count; i++) {
    cells.get(i).display();
  }
}
