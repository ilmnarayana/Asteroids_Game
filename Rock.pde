class Rock {
  PVector pos;
  PVector vel;
  float[] offset;
  float radius;

  Rock(float r) {
    radius=r;
    pos=new PVector(random(width), random(height));
    vel=new PVector(random(-3, 3), random(-3, 3));
    offset=new float[res];
    float xoff=random(1, 100);
    for (int i=0; i<res; ++i) {
      offset[i]=(noise(xoff)*(2*r/5))-(r/5);
      xoff+=(10.0/res);
    }
  }

  Rock(PVector p, float r) {
    radius=r;
    pos=p.copy();
    vel=new PVector(random(-3, 3), random(-3, 3));
    offset=new float[res];
    float xoff=random(1, 100);
    for (int i=0; i<res; ++i) {
      offset[i]=(noise(xoff)*(2*r/5))-(r/5);
      xoff+=(10.0/res);
    }
  }

  boolean isCollided(Vehicle v) {
    PVector pv=PVector.sub(v.pos, pos);
    float ang=PVector.angleBetween(new PVector(1, 0), pv);
    int p=int(ang*res/(2*PI));
    float d=PVector.dist(v.pos, pos);
    return d<(v.radius+radius+offset[p]);
  }

  boolean isCollided(Bullet b) {
    PVector pv=PVector.sub(b.pos, pos);
    float ang=PVector.angleBetween(new PVector(1, 0), pv);
    int p=int(ang*res/(2*PI));
    float d=PVector.dist(b.pos, pos);
    return d<(radius+offset[p]);
  }

  void update() {
    pos.add(vel);
    if (pos.x<-radius) pos.x=width+radius;
    if (pos.y<-radius) pos.y=height+radius;
    if (pos.x>width+radius) pos.x=-radius;
    if (pos.y>height+radius) pos.y=-radius;
  }

  void show() {
    beginShape();
    fill(50, 50, 50);
    for (int i=0; i<res; ++i) {
      float angle=(2*PI*i)/res;
      float x=pos.x+((radius+offset[i])*cos(angle));
      float y=pos.y+((radius+offset[i])*sin(angle));
      vertex(x, y);
    }
    endShape(CLOSE);
  }
}
