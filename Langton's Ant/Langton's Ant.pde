int grid[][];
int x;
int y;

int dir;

int aup = 0;
int art = 1;
int adown = 2;
int alt = 3;

void turnRight() {
  dir++;
  if (dir > alt) {
    dir = aup;
  }
}
void turnLeft() {
  dir--;
  if (dir < aup) {
    dir = alt;
  }
}

void setup() {
  size(1200, 800);
  grid = new int[width][height];
  x=200;
  y=200;
  dir = aup;
}

void moveForward() {
  if (dir == aup) {
    y--;
  } else if (dir == art) {
    x++;
  } else if (dir == adown) {
    y++;
  } else if (dir == alt) {
    x--;
  }
  if (x > width-1) {
    x=0;
  } else if (x<0) {
    x=width-1;
  }
  if (y > height-1) {
    y=0;
  } else if (y<0) {
    y=height-1;
  }
}

void draw() {
  background(255);

  for (int n= 0; n<100; n++) {

    int state  = grid[x][y];

    if (state == 0) {
      turnRight();
      grid[x][y]  =1;
      moveForward();
    } else if (state == 1) {
      turnLeft();
      grid[x][y]  =0;
      moveForward();
    }
  }


  loadPixels();
  for (int i =0; i<width; i++) {
    for (int j=0; j<height; j++) {
      int pix = i + width * j;
      if (grid[i][j]==0) {
        pixels[pix] = color(255);
      } else {
        pixels[pix] = color(0);
      }

    }
  }
  updatePixels();
}
