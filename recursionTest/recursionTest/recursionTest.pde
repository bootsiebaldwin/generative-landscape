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
  frameRate(1); 
  noLoop();
}

void draw() {
  drawShape(500,500,200,4);
}

void drawShape(float x, float y, float size, float level) {
  float scale = 1.5;
  float corner = size / 2;
  float ang = random(0,2*PI);
  float ang2 = ang + PI/2;
  float ang3 = ang2 + PI/2;
  float ang4 = ang3 + PI/2;
  
  
  if (level == 0) {
    float x1 = calcPointX(x, y, size/2, size/2, ang);
    float y1 = calcPointY(x, y, size/2, size/2, ang);
    float x2 = calcPointX(x, y, size/2, size/2, ang2);
    float y2 = calcPointY(x, y, size/2, size/2, ang2);
    float x3 = calcPointX(x, y, size/2, size/2, ang3);
    float y3 = calcPointY(x, y, size/2, size/2, ang3);
    float x4 = calcPointX(x, y, size/2, size/2, ang4);
    float y4 = calcPointY(x, y, size/2, size/2, ang4);
    
    line(x1, y1, x2, y2);
    line(x2, y2, x3, y3);
    line(x3, y3, x4, y4);
    line(x4, y4, x1, y1);
    
    
  } else {
    /*
    line(x, y, x+size, y);
    line(x+size, y, x+size, y-size);
    line(x+size, y-size, x, y-size);
    line(x, y-size, x, y);
    */
    
    float x1 = calcPointX(x, y, size/2, size/2, ang);
    float y1 = calcPointY(x, y, size/2, size/2, ang);
    float x2 = calcPointX(x, y, size/2, size/2, ang2);
    float y2 = calcPointY(x, y, size/2, size/2, ang2);
    float x3 = calcPointX(x, y, size/2, size/2, ang3);
    float y3 = calcPointY(x, y, size/2, size/2, ang3);
    float x4 = calcPointX(x, y, size/2, size/2, ang4);
    float y4 = calcPointY(x, y, size/2, size/2, ang4);
    
    
    line(x1, y1, x2, y2);
    line(x2, y2, x3, y3);
    line(x3, y3, x4, y4);
    line(x4, y4, x1, y1);
    
    
    float nextSize = size / scale;
    drawShape(x-corner,y-corner, nextSize, level-1);
    drawShape(x+corner,y-corner, nextSize, level-1);
  }
}
  
float calcPointX(float orgX, float orgY, float delX, float delY, float ang) {
  float calcX = 0;
  
  calcX = orgX + delX * (cos(ang) - sin(ang));
  
  return calcX;
    
}

float calcPointY(float orgX, float orgY, float delX, float delY, float ang) {
  float calcY = 0;
  
  calcY = orgY + delY * (sin(ang) + cos(ang));
  
  return calcY;
    
}
