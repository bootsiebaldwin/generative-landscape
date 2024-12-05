int sizeX = 1080; 
int sizeY = 720;

//possible rotation values of the shapes
//float[] rotations = {0, PI/2, PI, 2*PI};
float[] rotations = {0, PI};                    //right now I have all the shapes staying the same rotation or upside down

public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0); 
  frameRate(10); 
}

//DO NOT USE scale(), ALWAYS SCALE BY CHANGING SIZE INPUTTED INTO FUNCTION
void draw(){
  
  pushMatrix();
  translate(350, 325);
  rotate(PI);              //flips the shape
  //rotate(0);
  //drawPawn1(50, 0);
  drawKing(50, 0);        //base case -- could be anything
  recShape(50, 5, HALF_PI);
  popMatrix();
  
  noLoop();
  
}

//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawPawn1(float size, float rotation){
  pushMatrix();
  rotate(rotation);
  line(size-size, size-size, size-size+1, size-size+1); //draw a dot in the center of the object to track origin
  
  line((size-size), size, (size*2), size); //using (size-size) instead of 0 just in case 0 messes up some weird rotate function in some way
  line((size*2), size, (size*2 - size/2), (size-size));
  
  line((size-size), size, -(size*2), size);
  line(-(size*2), size, -(size*2 - size/2), (size-size));
  
  line(-(size*2 - size/2), -size, -(size*2 - size/2), (size-size));
  line((size*2 - size/2), -size, (size*2 - size/2), (size-size));
  
  line((size*2 - size/2), -size, -(size*2 - size/2), -size);
  popMatrix();
}

//this function draws the basic king shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawKing(float size, float rotation){
  pushMatrix();
  rotate(rotation);
  float fifthWidth = ((size*2 - size/2) + (size*2 - size/2)) / 5;
  float prongHeight = size - (2 * size / 3);
  
  line(size-size, size-size, size-size+1, size-size+1); //draw a dot in the center of the object to track origin
  
  //prong lines
  line((size*2 - size/2) - (fifthWidth * 4), size, (size*2 - size/2) - (fifthWidth * 5), size);
  line((size*2 - size/2) - (fifthWidth * 4), prongHeight, (size*2 - size/2) - (fifthWidth * 4), size);
  line((size*2 - size/2) - (fifthWidth * 3), prongHeight, (size*2 - size/2) - (fifthWidth * 4), prongHeight);
  line((size*2 - size/2) - (fifthWidth * 3), size, (size*2 - size/2) - (fifthWidth * 3), prongHeight);
  line((size*2 - size/2) - (fifthWidth * 2), size, (size*2 - size/2) - (fifthWidth * 3), size);
  line((size*2 - size/2) - (fifthWidth * 2), prongHeight, (size*2 - size/2) - (fifthWidth * 2), size);
  line((size*2 - size/2) - fifthWidth, prongHeight, (size*2 - size/2) - (fifthWidth * 2), prongHeight); 
  line((size*2 - size/2) - fifthWidth, size, (size*2 - size/2) - fifthWidth, prongHeight); 
  line((size*2 - size/2), size, (size*2 - size/2) - fifthWidth, size);
  
  line(-(size*2 - size/2), -size, -(size*2 - size/2), size);  //vertical lines of base
  line((size*2 - size/2), -size, (size*2 - size/2), size);  //vertical lines of base
  
  line((size*2 - size/2), -size, -(size*2 - size/2), -size);  //bottom line of base
  popMatrix();
}

// draw the shape recursively, currently only using drawPawn1 and drawKing
// 
// random rotation implemented right now it only does normal orientation (rot 0) and upside down (rot PI)
//      * rotation can be changed by adding/removing values from the rotations[] list (global).
//      * we can go back to the original rotation method by uncommenting what I labeled as original code for rotation
//        and commenting out what I have for the rotation
//
//      * rotation parameter in recShape() is obsolete unless we are using the original rotation method
//
// random shape -- 0 is pawn1 and 1 is king 
//      * more can be added by adding an additional if else statement for each branch, 
//        and adding to the shapeTypeCount
//       
void recShape(float size, float recLevel, float rotation){
  float rateOfSize = 1.2;   //number size is divided by -- variable for easier updating
  
  //declaring random values
  int randomShapeVal;       
  int randomRotVal;
  
  int shapeTypeCount = 2;      // number of shapes, just makes it easier to only have to change one number when we add things
  
  //this stops the recursion -- once recLevel reaches 0
  if(recLevel > 0){
    
   //------- first branch --------
    pushMatrix();
    //translate(-(size*1.5), -size+(size/2));      //location of shape
    translate(-(size*1.5), -2*size+(size/2));      //location of shape -- more space between levels
    
    //value determines random shape
    randomShapeVal = int(random(0, shapeTypeCount));
    
    //value determines random rotation
    randomRotVal = int(random(0, rotations.length));      //rotations[randomRotVal]
    
    //logic for which value draws which shape
    if (randomShapeVal == 0) {
      //drawPawn1(size/rateOfSize, rotation/2);                //original line of code for rotation
      drawPawn1(size/rateOfSize, rotations[randomRotVal]);     //with random rotation
      
    } else if (randomShapeVal == 1) {
      //drawKing(size/rateOfSize, rotation/2);                 //original line of code for rotation
      drawKing(size/rateOfSize, rotations[randomRotVal]);      //with random rotation
    }
    
    recShape(size/rateOfSize, recLevel-1, rotation/2);    //***recursive call
    popMatrix();
    
    
    //------- second branch -------
    pushMatrix();
    //translate(size*1.5, -size+(size/2));
    translate(size*1.5, -2*size+(size/2));                   //location of shape -- more space between levels in the y
    
    //value determines random shape
    randomShapeVal = int(random(0,2));
    
    //value determines random rotation
    randomRotVal = int(random(0, rotations.length));
    
    //logic for which value draws which shape
    if (randomShapeVal == 0) {
      //drawPawn1(size/rateOfSize, -rotation/2);              //original line of code for rotation
      drawPawn1(size/rateOfSize, rotations[randomRotVal]);    //with random rotation
      
    } else if (randomShapeVal == 1) {
      //drawKing(size/rateOfSize, -rotation/2);               //original line of code for rotation
      drawKing(size/rateOfSize, rotations[randomRotVal]);     //with random rotation
    }
    
    recShape(size/rateOfSize, recLevel-1, -rotation/2);        //***recursive call
    popMatrix();
  }
  
}
