class Bullet {
  PVector pos;
  PVector vel;

  Bullet(PVector p, PVector v) {
    pos=p.copy();
    pos.add(v.mult(vRadius));
    vel=v.copy();
    vel.setMag(6);
  }

  void update() {
    pos.add(vel);
  }

  boolean isOut() {
    return (pos.x<0||pos.x>width)||(pos.y<0||pos.y>height);
  }

  void show() {
    stroke(255, 0, 0);
    strokeWeight(4);
    point(pos.x, pos.y);
    noStroke();
  }
}
