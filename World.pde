class World {
  ArrayList<Rock> rocks;
  Vehicle v;
  boolean gameOver=false;
  boolean won=false;
  color bgCol=color(0);

  World() {
    rocks=new ArrayList<Rock>();
    for (int i=0; i<10; ++i) {
      rocks.add(new Rock(random(10, 40)));
    }
    v=new Vehicle();
  }

  void keyP(int kC) {
    switch(kC) {
    case 'D' :
      v.dir[0]=true;
      break;
    case 'S' :
      v.dir[1]=true;
      break;
    case 'A' :
      v.dir[2]=true;
      break;
    case 'W' :
      v.dir[3]=true;
      break;
    case RIGHT :
      v.rot[0]=true;
      break;
    case LEFT :
      v.rot[1]=true;
      break;
    }
  }

  void keyR(int kC) {
    switch(kC) {
    case 'D' :
      v.dir[0]=false;
      break;
    case 'S' :
      v.dir[1]=false;
      break;
    case 'A' :
      v.dir[2]=false;
      break;
    case 'W' :
      v.dir[3]=false;
      break;
    case RIGHT :
      v.rot[0]=false;
      break;
    case LEFT :
      v.rot[1]=false;
      break;
    }
  }  

  void update() {
    if (!gameOver && !won) {
      if (frameCount%10==0) {
        v.produceBullet();
      }
      v.update();
      for (Rock r : rocks) r.update();
      for (Rock r : rocks) {
        if (r.isCollided(v)) {
          if (frameCount>100)
            v.health--;
          bgCol=color(255, 0, 0);
          break;
        } else bgCol=color(0);
      }
      if (frameCount>80) bulletsRocks();
      if (rocks.size()==0) won=true;
    }
  }

  void bulletsRocks() {
    int bl=v.blts.size();
    int rl=rocks.size();
    boolean br=false;
    for (int j=rl-1; j>=0&&!br; --j) {
      for (int i=bl-1; i>=0; --i) {
        Rock r=rocks.get(j);
        Bullet b=v.blts.get(i);
        if (r.isCollided(b)) {
          if (r.radius>10) {
            rocks.add(new Rock(r.pos, r.radius/2));
            rocks.add(new Rock(r.pos, r.radius/2));
          }
          rocks.remove(j);
          v.blts.remove(i);
          br=true;
          break;
        }
      }
    }
  }

  void show() {
    background(255);
    if (!gameOver && !won) {
      v.show();
      for (Rock r : rocks) r.show();
      if (frameCount>80) {
        if (v.health<=0) gameOver=true;
        fill(bgCol);
        rect(20, 20, 100, 15);
        fill(0, 255, 0);
        rect(20, 20, v.health, 15);
      }
    } else if (gameOver) {
      textAlign(CENTER, CENTER);
      textSize(20);
      fill(255, 0, 0);
      text("GAME OVER", width/2, height/2);
    } else {
      textAlign(CENTER, CENTER);
      textSize(20);
      fill(0, 255, 0);
      text("WON", width/2, height/2);
    }
  }
}
