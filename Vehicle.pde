class Vehicle {
  PVector pos;
  PVector vel;
  float radius;
  float angle;
  boolean dir[];
  boolean rot[];
  ArrayList<Bullet> blts;
  int health=100;

  Vehicle() {
    pos=new PVector(width/2, height/2);
    vel=new PVector(0, 0);
    radius=vRadius;
    blts=new ArrayList<Bullet>();
    dir=new boolean[4];
    for (int i=0; i<4; ++i) {
      dir[i]=false;
    }
    rot=new boolean[2];
    rot[0]=false;
    rot[1]=false;
  }

  void produceBullet() {
    PVector bvel=new PVector(cos(angle), sin(angle));
    blts.add(new Bullet(pos, bvel));
  }

  void update() {
    if (dir[0]) vel.add(new PVector(1, 0));
    if (dir[1]) vel.add(new PVector(0, 1));
    if (dir[2]) vel.add(new PVector(-1, 0));
    if (dir[3]) vel.add(new PVector(0, -1));
    vel.setMag(2);
    pos.add(vel);
    if (pos.x<-radius) pos.x=width+radius;
    if (pos.y<-radius) pos.y=height+radius;
    if (pos.x>width+radius) pos.x=-radius;
    if (pos.y>height+radius) pos.y=-radius;
    vel=new PVector(0, 0);
    if (rot[0]) angle+=0.1;
    if (rot[1]) angle-=0.1;

    //Bullets Update
    int bl=blts.size();
    for (int i=bl-1; i>=0; --i) {
      Bullet b=blts.get(i);
      b.update();
      if (b.isOut()) {
        blts.remove(i);
      }
    }
  }

  void show() {
    fill(0, 255, 0, health*255/100);
    ellipse(pos.x, pos.y, 2*radius, 2*radius);
    float x=pos.x+(radius*cos(angle));
    float y=pos.y+(radius*sin(angle));
    stroke(color(255, 0, 0), health*255/100);
    strokeWeight(2);
    line(pos.x, pos.y, x, y);
    stroke(0);
    strokeWeight(1);

    //Bullets Show
    for (Bullet b : blts)
      b.show();
  }
}
