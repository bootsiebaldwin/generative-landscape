//canvas size width and height
int sizeX = 1000; 
int sizeY = 600;

//what Y the mountain starts at (x should be 0
int mountY = 250;
int mountRate = 20;


public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0);
  frameRate(10);
  //noLoop();
}

void draw() {
  background(255);
  int mountX = 0;
  int r1 = mountY;
  int r2 = 10;
  int currY = mountY;
  
  boolean ifUpped = false;     //if the mountain went up this is true
  while (mountX < sizeX) {
    r2 = int(random(5, 20));    //x distance the randomized. 
    //r2 = 50;
    if (!ifUpped) {            //if point is low, next line can only be drawn above the current point
      r1 = int(random(currY, mountY + mountRate));  
      line(mountX, currY, mountX + r2, r1);
      currY = r1;
      ifUpped = true;
    } else {                   //else point is high and next line can only be drawn below the current point
      r1 = int(random(mountY - mountRate, currY));
      line(mountX, currY, mountX + r2, r1);
      currY = r1;
      ifUpped = false;
    }
    mountX += r2;
  }
  //line(0, mountY, width, mountY);
  /*
  mountY--;
  if (mountY < 0) { 
    mountY = height;
  }
  */
}
