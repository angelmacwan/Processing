PImage bimg;

int res = 8;

void setup(){
  size(782,782);
  bimg = loadImage("img.jpg");
  
  background(0);
}

void draw(){
  //image(bimg,0,0);
  for(int i  = 0 ; i <= 300 ; i++){
  int x = floor(random(height));
  int y = floor(random(width));
  color c = bimg.get(x,y);
  fill(c);
  strokeWeight(0);
  ellipse(x,y,res,res);
  }
}
