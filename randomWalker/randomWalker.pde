//import peasy.*;
//PeasyCam cam;

//number of walkers
int num = 20;

walker w[] = new walker[num];

//opacity
int op=5;

//Speed
int tLim = 500;

float wid,hei,zcurve;

void setup(){
  size(800,800, P3D);
  background(0);
  
  //cam = new PeasyCam(this, 0, 0, 0, 50);
    
  for(int i = 0 ; i <= num-1; i++)
    w[i]= new walker(int(random(0,height)), int(random(0,height)), int(random(0,height)));
}

void draw(){
  for(int tim = 0; tim <= tLim; tim++){
    for(int i = 0 ; i <= num-1; i++){
      if(i%2==0)
        w[i].render(255,255,255,op);
      else
        w[i].render(255,0,0,op);
      
      w[i].update();
    }
  }
  op++;
    if(op > 100)
      op=1;
}

class walker{
  int x;
  int y;
  int z;
  walker(int a, int b, int c){
    x=a;
    y=b;
    z=c;
  }
  void render(int c1, int c2, int c3, int op){
    stroke(c1,c2,c3,op);
    //point(x,y);
    point(x,y,z);
    beginShape();
    vertex(x,y,z);
    endShape();
  }
  void update(){
    strokeWeight(0.5);
    int chX = int(random(0,4));
    int chY= int(random(0,4));
    int chZ = int(random(0,4));
    if (chX < 2)
      x++;
    else
      x--;
      
    if (chY < 2)
      y++;
    else
      y--;
            
    if (chZ < 2)
      z++;
    else
      z--;
      
     if(x > height || x < 0)
       x=int(random(height));
     if(y > height || y < 0)
       y=int(random(height));
      
  }
}
