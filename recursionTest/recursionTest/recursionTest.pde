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
  drawShape(600,600,200,5);
}

void drawShape(float x, float y, float size, float level) {
  float scale = 1.5;
  float corner = size / 4;
  
  if (level == 0) {
    line(x, y, x+size, y);
    line(x+size, y, x+size, y-size);
    line(x+size, y-size, x, y-size);
    line(x, y-size, x, y);
    
  } else {
    line(x, y, x+size, y);
    line(x+size, y, x+size, y-size);
    line(x+size, y-size, x, y-size);
    line(x, y-size, x, y);
    
    float nextSize = size / scale;
    drawShape(x-nextSize+corner,y-size+corner, nextSize, level-1);
    drawShape(x+size-corner,y-size+corner, nextSize, level-1);
  }
}
