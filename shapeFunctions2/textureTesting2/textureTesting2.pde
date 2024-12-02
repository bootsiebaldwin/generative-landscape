int sizeX = 1080; 
int sizeY = 720;

//possible rotation values of the shapes
//float[] rotations = {0, PI/2, PI, 2*PI};
float[] rotations = {0, PI};                    //right now I have all the shapes staying the same rotation or upside down

PGraphics mask;
PImage img1, img2, img3;
PImage[] textures;

public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0); 
  frameRate(10); 
  
  //load images
  img1 = loadImage("https://manytextures.com/download/69/texture/jpg/2048/rock-wall-2048x2048.jpg"); // Texture 1
  img2 = loadImage("https://www.tilingtextures.com/wp-content/uploads/2017/02/0012-scaled.jpg"); // Texture 2
  img3 = loadImage("https://i.pinimg.com/originals/52/2f/60/522f606c64525168201049babb6871f6.png"); // Texture 3
  
  //resize images
  img1.resize(sizeX, sizeY); 
  img2.resize(sizeX, sizeY); 
  img3.resize(sizeX, sizeY); 
  
  //array of textures
  textures = new PImage[]{img1, img2, img3};
  
  //creates mask canvas
  mask = createGraphics(width, height);
}

//DO NOT USE scale(), ALWAYS SCALE BY CHANGING SIZE INPUTTED INTO FUNCTION
void draw(){
  int baseTextureIndex = int(random(textures.length));
  
  pushMatrix();
  translate(350, 325);
  rotate(PI);              //flips the shape
  //mask.translate(350, 325);
  //mask.rotate(PI);
  //rotate(0);
  //drawPawn1(50, 0);
  
  pushMatrix();
  drawKing(50, 0, baseTextureIndex);        //base case -- could be any shape
  popMatrix();
  
  recShape(50, 5, HALF_PI);
  popMatrix();
  
  noLoop();
  
}

//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawPawn1(float size, float rotation, int textureIndex){
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
//WITH TEXTURE
void drawKing(float size, float rotation, int textureIndex){
  //get texture which texture given the random index
  PImage currentTexture = textures[textureIndex]; 

  //create a separate masks for each shape
  PGraphics shapeMask = createGraphics(width, height);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);  // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.rotate(rotation);
  shapeMask.translate(width / 2, height / 2);      //centers the shape
  
  float fifthWidth = ((size*2 - size/2) + (size*2 - size/2)) / 5;
  float prongHeight = size - (2 * size / 3);
  
  shapeMask.beginShape();
  
  line(size-size, size-size, size-size+1, size-size+1); //draw a dot in the center of the object to track origin
  
  //the original shape is draw upside down -- so that is how I refer to the corners
  
  shapeMask.vertex((size*2 - size/2), size); 
  
  //prong points within main points
  shapeMask.vertex((size*2 - size/2) - fifthWidth, size);
  shapeMask.vertex((size*2 - size/2) - fifthWidth, prongHeight);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 2), prongHeight);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 2), size);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 3), size);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 3), prongHeight);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 4), prongHeight);
  shapeMask.vertex((size*2 - size/2) - (fifthWidth * 4), size); 
  
  //main corners
  shapeMask.vertex(-(size*2 - size/2), size);     //bottom left corner
  shapeMask.vertex(-(size*2 - size/2), -size);    //top left corner
  shapeMask.vertex((size*2 - size/2), -size);     //top right corner
  shapeMask.vertex((size*2 - size/2), size);      //bottom right corner  
  
  shapeMask.endShape(CLOSE);  //close the shape
  
  shapeMask.popMatrix();
  shapeMask.endDraw();
  
  //apply the mask to the selected texture
  currentTexture.mask(shapeMask);
  
  //draw the image with the mask
  image(currentTexture, -width/2, -height/2);

}

//ORIGINAL WITH NO TEXTURE -- JUST LINES
void drawKing(float size, float rotation){
  pushMatrix();
  //translate(-(size*1.5) * 1.5 * 1.2, -2*size+(size/2) *1.2); 
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
  int randomTextureVal;
  
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
    
    //value determines random texture
    randomTextureVal = int(random(0, textures.length));
    
    //logic for which value draws which shape
    if (randomShapeVal == 0) {
      //drawPawn1(size/rateOfSize, rotation/2);                //original line of code for rotation
      //drawPawn1(size/rateOfSize, rotations[randomRotVal], randomTextureVal);     //with random rotation
      drawPawn1(size/rateOfSize, rotations[randomRotVal]);
      
    } else if (randomShapeVal == 1) {
      //drawKing(size/rateOfSize, rotation/2);                 //original line of code for rotation
      //drawKing(size/rateOfSize, rotations[randomRotVal], randomTextureVal);      //with random rotation
      drawKing(size/rateOfSize, rotations[randomRotVal]);
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
    
    //value determines random texture
    randomTextureVal = int(random(0, textures.length));
    
    //logic for which value draws which shape
    if (randomShapeVal == 0) {
      //drawPawn1(size/rateOfSize, -rotation/2);              //original line of code for rotation
      //drawPawn1(size/rateOfSize, rotations[randomRotVal], randomTextureVal);    //with random rotation
      drawPawn1(size/rateOfSize, rotations[randomRotVal]);
      
      
    } else if (randomShapeVal == 1) {
      //drawKing(size/rateOfSize, -rotation/2);               //original line of code for rotation
      drawKing(size/rateOfSize, rotations[randomRotVal], randomTextureVal);     //with random rotation
      drawKing(size/rateOfSize, rotations[randomRotVal]);
  }
    
    recShape(size/rateOfSize, recLevel-1, -rotation/2);        //***recursive call
    popMatrix();
  }
  
}
