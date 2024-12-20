//canvas size width and height
int sizeX = 1000; 
int sizeY = 600;

//what Y the mountain starts at
int mountY = 250;
int mountYStored = mountY;
int mountRate = 20;        //range of Y change (mountY +/- mountRate)
int mountXRateMin = 50; 
int mountXRateMax = 20;
int mountMoveRate = 10;


public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0);           //pen color -- black
  frameRate(10);       //low frame rate creates a interesting sketchy look
  //noLoop();          //turns off looping
}

void draw() {
  //background(255);        //canvas color -- white
  int mountX = 0;         //tracks X value, starts at 0
  int r1 = mountY;        //will be random number for y variables
  int r2 = 10;            //will be random distance x moves each iteration
  int currY = mountY;     //tracks Y value, starts at programs set mount start height
  
  //if the mountain went up this is true
  boolean ifUpped = false;     //start at mountain is at low point
 
  //draws "mountain" (zigzag line across) at random intervals up and down and horizontal
  while (mountX < sizeX) {     //until end of canvas
    r2 = int(random(mountXRateMin, mountXRateMax));   //x distance the randomized. 
    
    //if point is low, next line can only be drawn above the current point
    if (!ifUpped) {
      r1 = int(random(currY, mountY + mountRate));  
      line(mountX, currY, mountX + r2, r1);
      currY = r1;
      ifUpped = true;
      
    //else point is high and next line can only be drawn below the current point
    } else {
      r1 = int(random(mountY - mountRate, currY));
      line(mountX, currY, mountX + r2, r1);
      currY = r1;
      ifUpped = false;
    }
    mountX += r2;
  }
  
  if (mountY <= sizeY - 5) {
    mountY = mountY + 5;
  } else {
    mountY = mountYStored;
  }
  
}
