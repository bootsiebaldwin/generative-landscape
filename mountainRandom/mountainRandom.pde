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
  stroke(0);           //pen color -- black
  frameRate(10);       //low frame rate creates a interesting sketchy look
  //noLoop();          //turns off looping
}s

void draw() {
  background(255);        //canvas color -- white
  int mountX = 0;         //tracks X value, starts at 0
  int r1 = mountY;        //will be random number for y variables
  int r2 = 10;            //will be random distance x moves each iteration
  int currY = mountY;     //tracks Y value, starts at programs set mount start height
  
  //if the mountain went up this is true
  boolean ifUpped = false;     //start at mountain is at low point
 
  //draws "mountain" (zigzag line across) at random intervals up and down and horizontal
  while (mountX < sizeX) {     //until end of canvas
    r2 = int(random(5, 20));   //x distance the randomized. 
    
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
}
