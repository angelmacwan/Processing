Particle[] p = new Particle[5000];

void setup(){
  size(800,800, P3D);
  for(int i = 0; i< p.length; i++){
    p[i] = new Particle();
  }
}

void draw(){
  background(0);
  translate(width/2, height/2);
  rotateX(frameCount * 0.005);
  rotateY(frameCount * 0.005);
  scale(4);
  
  for(int i = 0; i < p.length; i++){
    p[i].show();
    p[i].update();
  }
  //saveFrame("./frames/Lorenz-######.png");
}

class Particle{
  float a,b,c;
  
  float x,y,z;
  
  Particle(){
    a = 10;
    b = 28;
    c = 8/3;
    x = random(-1,1);
    y = random(-1,1);
    z = random(-1,1);
  }
  
  void update(){
    int s = 100;

    float dx = ( a * (-x + y) ) / s;
    float dy = ( (-x*z) + (b*x) - y ) / s;
    float dz = ( (x*y) - (c*z) ) / s;

    x += dx;
    y += dy;
    z += dz;
  }
  
  void show(){
    stroke(255);
    strokeWeight(0.5);
    point(x,y,z);
  }
  
}
