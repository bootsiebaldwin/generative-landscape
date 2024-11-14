int sizeX = 1080; 
int sizeY = 720;

//all transformations must be done in translate, rotate, scale, from top to bottom! Operations are performed in reverse, 
//but this is the order the lines must be in
//all transformations should always be done in a transform matrix, that way it only changes one object at a time

//Note that the object is always rotated from its bottom left corner, as that is where I start drawing it from
//This won't be too bad to change, I will just need to reconfigure some math but I can't change how a single object rotates in between calls

public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0); 
  frameRate(10); 
}

void draw() {

  pawn1(0, 0, 1, 0, 400, 300);
  pawn2(0, 0, 0.5, HALF_PI, 700, 400);
  tallRect1(0, 0, 1.25, PI, 250, 600);
  tallRect2(0, 0, 0.75, PI/4, 850, 300);
  
  pawn2(500, 300, 1, 0, 200, 100);
  hexagon(0, 0, 2, 0, 900, 700);

}

//create one variant of the pawn shape
void pawn1(float xStart, float yStart, float scl, float rtt, float xTrans, float yTrans) {
  //push and pop statememts control transformations for drawings inside the pair only
  pushMatrix();
  
  translate(xTrans, yTrans);
  rotate(rtt);
  scale(scl);
  
  line(xStart, yStart, xStart + 200, yStart);
  
  line(xStart, yStart, xStart + 30, yStart - 50);
  line(xStart + 200, yStart, xStart + 170, yStart - 50);
  
  line(xStart + 30, yStart - 50, xStart + 30, yStart - 100);
  line(xStart + 170, yStart - 50, xStart + 170, yStart - 100);
  
  line(xStart + 30, yStart - 100, xStart + 170, yStart - 100);
  popMatrix();
}

void pawn2(float xStart, float yStart, float scl, float rtt, float xTrans, float yTrans){
  pushMatrix();
  
  translate(xTrans, yTrans);
  rotate(rtt);
  scale(scl);
  
  line(xStart, yStart, xStart + 200, yStart);
  
  curve(xStart + 200, yStart - 16.5, xStart, yStart, xStart, yStart - 50, xStart + 200, yStart - 33.5);
  curve(xStart, yStart - 16.5, xStart + 200, yStart, xStart + 200, yStart - 50, xStart, yStart - 33.5);
  
  line(xStart, yStart - 50, xStart - 30, yStart - 100);
  line(xStart + 200, yStart - 50, xStart + 230, yStart - 100);
  
  line(xStart - 30, yStart - 100, xStart + 230, yStart - 100);
  popMatrix();
}

void tallRect1(float xStart, float yStart, float scl, float rtt, float xTrans, float yTrans){
  pushMatrix();
  
  translate(xTrans, yTrans);
  rotate(rtt);
  scale(scl);
  
  line(xStart, yStart, xStart + 50, yStart);
  
  line(xStart + 50, yStart, xStart + 50, yStart - 75);
  line(xStart + 50, yStart - 75, xStart + 100, yStart - 75);
  
  line(xStart + 100, yStart - 75, xStart + 100, yStart - 150);
  line(xStart + 100, yStart - 150, xStart, yStart - 150);
  
  line(xStart, yStart - 150, xStart, yStart);
  popMatrix();
}

void tallRect2(float xStart, float yStart, float scl, float rtt, float xTrans, float yTrans){
  pushMatrix();
  
  translate(xTrans, yTrans);
  rotate(rtt);
  scale(scl);
  
  line(xStart, yStart, xStart + 50, yStart);
  
  line(xStart + 50, yStart, xStart + 50, yStart - 75);
  line(xStart + 50, yStart - 75, xStart + 150, yStart - 150);
  
  line(xStart + 150, yStart - 150, xStart, yStart - 150);
  line(xStart, yStart - 150, xStart, yStart);
  
  popMatrix();
}

void hexagon(float xStart, float yStart, float scl, float rtt, float xTrans, float yTrans){
  pushMatrix();
  
  translate(xTrans, yTrans);
  rotate(rtt);
  scale(scl);
  
  line(xStart, yStart, xStart + 80, yStart);
  line(xStart + 80, yStart, xStart + 105, yStart - 50);
  
  line(xStart + 105, yStart - 50, xStart + 80, yStart - 100);
  line(xStart + 80, yStart - 100, xStart, yStart - 100);
  
  line(xStart, yStart - 100, xStart - 25, yStart - 50);
  line(xStart - 25, yStart - 50, xStart, yStart);
  
  popMatrix();
}
