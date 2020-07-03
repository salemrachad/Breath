ArrayList<Cell> cells;
int cell_Count=25;

void setup() {
  size(800, 800);

  cells = new ArrayList<Cell>();

  for (int i=0; i < cell_Count; i++) { 
    cells.add(new Cell(i));
  }
}
void draw() {
  for (int i = 0; i < cells.size(); i++) {
    cells.get(i).status();
    cells.get(i).play();
  }
}
