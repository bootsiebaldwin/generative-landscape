/**
 * NOTE from bootsie
 * This file used what Syndey had in the git before 11/28, but I made some changes
 * ---Started working on a functions that manages the recursion
 */


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
  
  recPawn1(400, 600, 50, 2);  //this is the base case (it could be any shape we want)
  
  recursiveDraw(400, 600, 50, 2);  // this calls the recursion
                                   // I just matched the base shape for the values, but this
                                   // may vary depending on what shape we use and that shapes function
                                   
  hexagon(0, 0, 2, 0, 900, 700);
}

/**
 * recursiveDraw()
 * this function manages the recursion
 * 
*/
void recursiveDraw(float xCenter, float yCenter, float size, int recLevel) {
  //variable holds random value for which shape is drawn
  //int randShapeNum = int(random(0,3));   //***uncomment once we have the other shape functions
  int randShapeNum  = 0;                   //****delete once we have other shape functions and uncomment above^^^
  
  //maybe we can add some variables here to make adjusting easier
        // ex. size/2 could be size/sizeRate -- so we can adjust it on a big scale
        // to be added
  
  //levels above 0 (before the last level)
  if(recLevel > 0){
    if (randShapeNum == 0) {     // 0 -- recPawn1
      recPawn1(xCenter - size*1.5, yCenter - size*2, size/2, recLevel-1);
      recPawn1(xCenter + size*1.5, yCenter - size*2, size/2, recLevel-1);
      
    } else if (randShapeNum == 1) {
      
    } else if (randShapeNum == 2) {
      
    }
    //recusive call below -- occurs when we are on level > 0
    recursiveDraw(xCenter - size*1.5, yCenter - size*2, size/2, recLevel-1);
    recursiveDraw(xCenter + size*1.5, yCenter - size*2, size/2, recLevel-1);
    
  } else {
    //end of recursion -- final level -- level 0
    
    //-----insert something similar to above with drawing random shapes
    // but minus the recursive calls to recursiveDraw()-----
    recPawn1(xCenter - size*1.5, yCenter - size*2, size/2, recLevel-1);
    recPawn1(xCenter + size*1.5, yCenter - size*2, size/2, recLevel-1);
  }
}


/**
 * draws the shape rectangle/trapazoid type shape 
*/
void recPawn1(float xCenter, float yCenter, float size, int recLevel){
  /*
  if(recLevel > 0){
    recPawn1(xCenter - size*1.5, yCenter - size*2, size/2, recLevel-1);
    recPawn1(xCenter + size*1.5, yCenter - size*2, size/2, recLevel-1);
  }
  */
  
  pushMatrix();
  line(xCenter, yCenter - size, xCenter + (size*2), yCenter - size);
  line(xCenter + (size*2), yCenter - size, (xCenter + (size*2 - size/2)), yCenter - (size*2));
  
  line(xCenter, yCenter - size, xCenter - (size*2), yCenter - size);
  line(xCenter - (size*2), yCenter - size, (xCenter - (size*2 - size/2)), yCenter - (size*2));
  
  line(xCenter - (size*2 - size/2), yCenter - (size*2), xCenter - (size*2 - size/2), yCenter - (size*3));
  line(xCenter + (size*2 - size/2), yCenter - (size*2), xCenter + (size*2 - size/2), yCenter - (size*3));
  
  line(xCenter + (size*2 - size/2), yCenter - (size*3), xCenter - (size*2 - size/2), yCenter - (size*3));
  popMatrix();
}

//-------------BELOW FUNCTIONS NEED WORK----------------------
//below functions need to work similar to the rectPawn1 function
//i.e. need the same number of parameters
// what parameters are needed: float xCenter, float yCenter, float size
// 

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

void recursiveShape(float xCenter, float yCenter, float size, int recLevel){
  //size determines the placement of the object away from the center, some funky math will have to be done for different objects but that's the idea
  //recLevel is how many times the function is called, with 0 being just one call of the function with no if statement called
    
    //base case, this is always done first
    pushMatrix();
    line(xCenter - size, yCenter - size, xCenter + size, yCenter - size);
    line(xCenter + size, yCenter - size, xCenter + size, yCenter + size);
    line(xCenter + size, yCenter + size, xCenter - size, yCenter + size);
    line(xCenter - size, yCenter + size, xCenter - size, yCenter - size);
    popMatrix();
  
  if(recLevel > 0){
    recursiveShape(xCenter - size, yCenter - size, size*.75, recLevel-1);
    recursiveShape(xCenter + size, yCenter - size, size*.75, recLevel-1);
  }
  
}
