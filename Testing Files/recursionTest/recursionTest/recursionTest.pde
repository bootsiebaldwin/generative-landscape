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
  drawShape(500,500,1,4);
  //drawKing(400, 400, 1);
}

void drawShape(float x, float y, float size, float level) {
  float scale = 1.5;
  float corner = 100 * size;
  
  if (level == 0) {
    //drawSquare(x, y, size);
    drawKing(x, y, size);
    
  } else {
    //drawSquare(x, y, size);
    drawKing(x, y, size);
   
    //float nextSize = size / scale;
    float nextSize = size * 0.5;

    drawShape(x-corner,y-corner, nextSize, level-1);
    drawShape(x+corner,y-corner, nextSize, level-1);
  }
}

void drawSquare(float x, float y, float size){
  float scale = 1.5;
  float corner = size / 2;
  float ang = random(0,2*PI);
  float ang2 = ang + PI/2;
  float ang3 = ang2 + PI/2;
  float ang4 = ang3 + PI/2;
  
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
  }


void drawKing(float x, float y, float scale) {
  //height and width of the base
  float baseHeight  = 80 * scale;
  float baseWidth   = 200 * scale;
  
  //height and width of the "prongs"
  float prongWidth  = baseWidth / 5;
  float prongHeight = 50 * scale;
  
  //list of rotation angle possibilities
  float[] angList = {0, PI/6, 5*PI/6, 7*PI/6, 11*PI/6, PI};
  int randNum = int(random(0,6));
  //angle of rotation of whole shape
  float ang = angList[randNum];

  //calc point for the base of the shape
  float r1x = calcPointX(x, y, baseWidth / 2, -baseHeight / 2, ang); 
  float r1y = calcPointY(x, y, baseWidth / 2, -baseHeight / 2, ang);
  
  float r2x = calcPointX(x, y, baseWidth / 2, baseHeight / 2, ang); 
  float r2y = calcPointY(x, y, baseWidth / 2, baseHeight / 2, ang);
  
  float r3x = calcPointX(x, y, -baseWidth / 2, baseHeight / 2, ang); 
  float r3y = calcPointY(x, y, -baseWidth / 2, baseHeight / 2, ang);
  
  float r4x = calcPointX(x, y, -baseWidth / 2, -baseHeight / 2, ang); 
  float r4y = calcPointY(x, y, -baseWidth / 2, -baseHeight / 2, ang);
  
  //calc prong points
  float prongDelY = -(baseHeight/2 + prongHeight);

  // prong a points  
  float a1X = calcPointX(x, y, -5 * prongWidth/2, prongDelY, ang);
  float a1Y = calcPointY(x, y, -5 * prongWidth/2, prongDelY, ang);
  
  float a2X = calcPointX(x, y, -3 * prongWidth/2, prongDelY, ang);
  float a2Y = calcPointY(x, y, -3 * prongWidth/2, prongDelY, ang);
  
  float a3X = calcPointX(x, y, -3 * prongWidth/2, -baseHeight/2, ang);
  float a3Y = calcPointY(x, y, -3 * prongWidth/2, -baseHeight/2, ang);
  
  // prong b points
  float b1X = calcPointX(x, y, -prongWidth / 2, -baseHeight / 2, ang);
  float b1Y = calcPointY(x, y, -prongWidth / 2, -baseHeight / 2, ang);
  
  float b2X = calcPointX(x, y, -prongWidth / 2, prongDelY, ang);
  float b2Y = calcPointY(x, y, -prongWidth / 2, prongDelY, ang);
  
  float b3X = calcPointX(x, y, prongWidth / 2, prongDelY, ang);
  float b3Y = calcPointY(x, y, prongWidth / 2, prongDelY, ang);
  
  float b4X = calcPointX(x, y, prongWidth / 2, -baseHeight / 2, ang);
  float b4Y = calcPointY(x, y, prongWidth / 2, -baseHeight / 2, ang);
  
  // prong c points
  float c1X = calcPointX(x, y, 3 * prongWidth / 2, -baseHeight / 2, ang);
  float c1Y = calcPointY(x, y, 3 * prongWidth / 2, -baseHeight / 2, ang);
  
  float c2X = calcPointX(x, y, 3 * prongWidth / 2, prongDelY, ang);
  float c2Y = calcPointY(x, y, 3 * prongWidth / 2, prongDelY, ang);
  
  float c3X = calcPointX(x, y, 5 * prongWidth / 2, prongDelY, ang);
  float c3Y = calcPointY(x, y, 5 * prongWidth / 2, prongDelY, ang);
  
  //all x values for points
  float[] xVals = {
    r1x, r2x, r3x, r4x,  // base X values
    a1X, a2X, a3X,       // a-prong X values
    b1X, b2X, b3X, b4X,  // b-prong X values
    c1X, c2X, c3X        // c-prong X values
  };
  
  //all y values for points
  float[] yVals = {
    r1y, r2y, r3y, r4y,  // base Y values
    a1Y, a2Y, a3Y,       // a-prong Y values
    b1Y, b2Y, b3Y, b4Y,  // b-prong Y values
    c1Y, c2Y, c3Y        // c-prong Y values
  };
  
  /*
  for (int i = 0; i < xVals.length-1; i++) {
    line(xVals[i], yVals[i], xVals[i+1], yVals[i+1]);
  }*/
  
  line(r1x, r1y, r2x, r2y);
  line(r2x, r2y, r3x, r3y);
  line(r3x, r3y, r4x, r4y);
  //line(r4x, r4Y, r1x, r1y);


  
  line(r4x, r4y, a1X, a1Y);
  line(a1X, a1Y, a2X, a2Y);
  line(a2X, a2Y, a3X, a3Y);
  
  line(a3X, a3Y, b1X, b1Y);
  line(b1X, b1Y, b2X, b2Y);
  line(b2X, b2Y, b3X, b3Y);
  line(b3X, b3Y, b4X, b4Y);
  
  line(b4X, b4Y, c1X, c1Y);
  line(c1X, c1Y, c2X, c2Y);
  line(c2X, c2Y, c3X, c3Y);
  line(c3X, c3Y, r1x, r1y); 
  
  
 // line(xVals[xVals.length-1], yVals[yVals.length-1], xVals[0], yVals[0]);
}

void drawRect(float x, float y, float scale) {
  float baseHeight  = 30 * scale;
  float baseWidth   = 300 * scale;
  //float rot = random(0,2*PI);
  float rot = 0;
  float baseAng = rot;
  
  //rectangle/base angle:
  //float baseAng = atan2(baseHeight, baseWidth) + rot;  
  float r1X = calcPointX(x, y, baseWidth / 2, -baseHeight / 2, baseAng); 
  float r1y = calcPointY(x, y, baseWidth / 2, -baseHeight / 2, baseAng);
  
  float r2x = calcPointX(x, y, baseWidth / 2, baseHeight / 2, baseAng); 
  float r2y = calcPointY(x, y, baseWidth / 2, baseHeight / 2, baseAng);
  
  float r3x = calcPointX(x, y, -baseWidth / 2, baseHeight / 2, baseAng); 
  float r3y = calcPointY(x, y, -baseWidth / 2, baseHeight / 2, baseAng);
  
  float r4X = calcPointX(x, y, -baseWidth / 2, -baseHeight / 2, baseAng); 
  float r4Y = calcPointY(x, y, -baseWidth / 2, -baseHeight / 2, baseAng);
  
  line(r1X, r1y, r2x, r2y);
  line(r2x, r2y, r3x, r3y);
  line(r3x, r3y, r4X, r4Y);
  line(r4X, r4Y, r1X, r1y);
}
  
float calcPointX(float orgX, float orgY, float delX, float delY, float ang) {
  float calcX = 0;

  calcX = orgX + (delX) * cos(ang) - (delY) * sin(ang);
  
  return calcX;
    
}

float calcPointY(float orgX, float orgY, float delX, float delY, float ang) {
  float calcY = 0;
  
  calcY = orgY +  delX * sin(ang) + (delY) * cos(ang);
  
  return calcY;
    
}
