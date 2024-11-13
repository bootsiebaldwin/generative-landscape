//canvas size width and height
int sizeX = 1080; 
int sizeY = 720;

//what Y the mountain starts at

public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0);           //pen color -- black
  frameRate(10);       //low frame rate creates a interesting sketchy look
  //noLoop();          //turns off looping
}

double[] calcPoint(int x, int y, int len, int ang) {
  double[] secPoint = {0, 0};
  
  
  
  
  return secPoint;
}

void drawKing(int x, int y, int scale, int ang) {
  //x, y of first point
  //height of bottom part, height of top part?
  //width of prong
  int prongWidth = 20;
  int prongHeight = 50;
  int baseHeight = 30;
  //int shapeWidth = prongWidth * 5;
  
  int currX = x;
  int currY = y;
  
  currY = y - baseHeight;
  line(x, y, currX, currY);
  
  //drawing prong
  line(currX, currY, currX, currY - prongHeight);
  currY = currY - prongHeight;
  line(currX, currY, currX + prongWidth, currY);
  currX = currX + prongWidth;
  line(currX, currY, currX, currY + prongHeight);
  currY = currY + prongHeight;
  line(currX, currY, currX + prongWidth, currY);
  currX = currX + prongWidth;
  
  //next prong
  line(currX, currY, currX, currY - prongHeight);
  currY = currY - prongHeight;
  line(currX, currY, currX + prongWidth, currY);
  currX = currX + prongWidth;
  line(currX, currY, currX, currY + prongHeight);
  currY = currY + prongHeight;
  line(currX, currY, currX + prongWidth, currY);
  currX = currX + prongWidth;

  //last prong
  line(currX, currY, currX, currY - prongHeight);
  currY = currY - prongHeight;
  line(currX, currY, currX + prongWidth, currY);
  currX = currX + prongWidth;
  line(currX, currY, currX, currY + prongHeight);
  currY = currY + prongHeight;
  
  // finishing the base
  line(currX, currY, currX, currY + baseHeight);
  currY = currY + baseHeight;
  
  line(currX, currY, x, y);
}

void draw() {
  //background(255);        //canvas color -- white
  int squareX = 0;         //tracks X value, starts at 0
  
  
  //rect(120, 80, 220, 220);
  
  drawKing(300, 300, 1, 0);
}
