int runners = 20;
int goals = 2;

part[] p = new part[runners];

attr[] a = new attr[goals];
void setup() {
  size(1200, 800);
  //fullScreen();

  for (int i = 0; i < p.length; i++) {
    int x = int(random(50, width-50));
    int y = int(random(50, height-50));

    p[i]=new part(x, y);
  }
  for (int i = 0; i < a.length; i++) {
    int x = int(random(100, width-100));
    int y = int(random(100, height-100));
    a[i]=new attr(x, y);
  }

  background(0);
}

int count = 0;

void draw() {
  
  for (int t=0; t<=50; t++) {
    noStroke();
    for (int i =0; i<p.length; i++) {
      for (int j =0; j<a.length; j++) {
        p[i].show(a[j]);
      }
    }


    //for (int i =0; i<a.length; i++) {
    //  a[i].show();
    //}
  }
  if(count >= 10000)
    noLoop();
   else
     count++;
}




class part {
  //green
  int siz = 3;
  PVector pos;
  PVector vel;
  PVector acc;

  part(int x, int y) {
    pos = new PVector(x, y);
    vel = new PVector().random2D();
    acc = new PVector();
  }

  void show(attr target) {
    fill(0, 200, 0, 3);
    ellipse(pos.x, pos.y, siz, siz);
    vel.add(acc);
    pos.add(vel);
    this.acc.mult(0);
    PVector force = PVector.sub(target.pos, pos);
    float dirSqr = force.magSq();
    dirSqr = constrain(dirSqr, 25, 800);
    float G = 6.67;
    float strength = G / dirSqr;
    force.setMag(strength);
    this.acc.add(force);

    if (pos.x>width || pos.x<0) {
      vel.x*=-1;
    }
    if (pos.y>height || pos.y<0) {
      vel.y*=-1;
    }
  }
}



class attr {
  //red
  int siz = 3;
  PVector pos;

  attr(int x, int y) {
    pos = new PVector(x, y);
  }
  void show() {
    fill(200, 0, 0);
    ellipse(pos.x, pos.y, siz, siz);
  }
}
