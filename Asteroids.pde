int res=30;
float vRadius=15;
World w;

void setup() {
  size(400, 400);
  w=new World();
}

void keyPressed() {
  w.keyP(keyCode);
}

void keyReleased() {
  w.keyR(keyCode);
}

void draw() {
  w.update();
  w.show();
}
