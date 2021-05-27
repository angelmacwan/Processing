int num = 200;
Particle[] p = new Particle[2000];

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
  scale(8);
  
  for(int i = 0; i < p.length; i++){
    p[i].show();
    p[i].update();
  }
  //if (frameCount <= 1300){
  //  saveFrame("./frames/ROSSELRS-######.png");
  //}else{
  //  println("END");
  //  noLoop();
  //}
}

class Particle{
  float a,b,c;
  
  float x,y,z;
  
  Particle(){
    a = 0.2;
    b = 0.2;
    c = 5.7;
    x = random(-1,1);
    y = random(-1,1);
    z = random(-1,1);
  }
  
  void update(){
    int s = 18;
    //int s = 10;
    //int s = 52;
    //int s = 11;

    float dx = (-(y + z)) / s;
    float dy = (x + (a*y)) / s;
    float dz = (b + z * (x - c)) / s;

    x += dx;
    y += dy;
    z += dz;
  }
  
  void show(){
    stroke(255);
    strokeWeight(0.4);
    point(x,y,z);
  }
  
}
