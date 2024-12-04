int sizeX = 1080; 
int sizeY = 720;

//possible rotation values of the shapes
float[] rotations = {0, PI, PI/2, 3*PI/2};            //right now I have all the shapes staying the same rotation or upside down

int whichColorPalette;    //tracks the global color palette of the castle

int loopCount = 0;        //used in draw() to have background appear before castle

PGraphics mask;
PImage img1, img2, img3;
PImage[] textures;
 
//------ main assets ------
PImage backgroundImg;

PImage[] bushImgs;
PImage pineTreeImg;

PImage[] cloudImgs;
PImage[] moonImgs;

PImage[] dragonImgs;


public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0); 
  frameRate(1); 
  
  //background image
  backgroundImg = loadImage("background.png");
  
  //load asset images
  bushImgs = new PImage[]{ loadImage("Bush_1.png"), loadImage("Bush_2.png"), loadImage("Bush_3.png"),
                           loadImage("Bush_4.png"), loadImage("Bush_5.png"), loadImage("Bush_6.png")
                         };
  
  pineTreeImg = loadImage("pinetree.png");
                         
                         
  cloudImgs = new PImage[]{ loadImage("Cloud_1.png"), loadImage("Cloud_2.png"), loadImage("Cloud_3.png"),
                            loadImage("Cloud_4.png")
                         };
   
                         
  //resize bush images     
  //having issues with current sizing!!!!
  for(int i = 0; i < bushImgs.length; i++) { 
    bushImgs[i].resize(width/4, height/4);
  }
  
  //load test texture images
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
  
  if (loopCount == 0) {        //draws background on first iteration of draw()  
    //random color palette -- for background image but may need work, not used right now
    whichColorPalette = int(random(0,6));
    int[] randRGB = calcRandomTint();
    
    //draw background of scene
    pushMatrix();
    
    tint(255, 255, 255);            //all 255 -- right now there is no tint and background is light the original
    image(backgroundImg, 0, 0);
  
    popMatrix();
    
    pushMatrix();
    
    tint(255, 255, 255);            //all 255 -- right now there is no tint and background is light the original
    drawStaticAssets();
    
    popMatrix();
  }
  
  if (loopCount == 1) {           //draws castle on second iteration of draw() then stops loop
    //new color palette for castle specifically
    whichColorPalette = int(random(0,6));
    
    pushMatrix();
    translate(600, 500);
    //rotate(PI);              //flips the entire shape
    
    recShape(75, 6, HALF_PI);
    drawPawn1(75, 0, baseTextureIndex);        //base case -- could be any shape
    drawPawn1(75, 0);
    
    popMatrix();
    
    noLoop();
  }
  
  loopCount++;
  
  //idea: could insert tree iteration to run after loop count > 0, so we see growth 
  
}

//---------draws assets-----------
void drawStaticAssets() {
  
  //----tree/bush assets----
  int treeOrBushVal = int(random(0,2));   // if 0 -- tree, if 1 -- one of the bushes
  int plantLocationOffset = 50;
  
  int[] plantLocationX = {120, 75,  750, 875, 990};
  int[] plantLocationY = {550, 450, 525, 490, 610};
  
  //draws the trees or bushes at given points
  for(int i = 0; i < plantLocationX.length; i++) {
    if (treeOrBushVal == 0) {              
      image(pineTreeImg, plantLocationX[i],  plantLocationY[i]);
      
    } else {
      int randBushVal = int(random(0, bushImgs.length));
      image(bushImgs[randBushVal], plantLocationX[i],  plantLocationY[i]);
    }
    
    treeOrBushVal = int(random(0,2));
  }
  
  //additional assets
}

//DRAWS WITH TEXTURE
//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawPawn1(float size, float rotation, int textureIndex){
  //get texture which texture given the random index
  PImage currentTexture = textures[textureIndex]; 

  //create a separate masks for each shape
  PGraphics shapeMask = createGraphics(width, height);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);  // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.translate(width / 2, height / 2);      //centers the shape
  shapeMask.rotate(rotation);
  
  shapeMask.beginShape();
  
  //each point of the pawn shape in clock wise order
  shapeMask.vertex(size-size, size); 
  shapeMask.vertex((size * 2), size); 
  shapeMask.vertex((size * 2 - size / 2), size-size); 
  shapeMask.vertex((size * 2 - size / 2),-(size));
  shapeMask.vertex(-(size * 2 - size / 2), -(size));
  shapeMask.vertex(-(size * 2 - size / 2), size-size);
  shapeMask.vertex(-(size * 2), size); 
  
  shapeMask.endShape(CLOSE);  //close the shape
  
  shapeMask.popMatrix();
  shapeMask.endDraw();
  
  //apply the mask to the selected texture
  currentTexture.mask(shapeMask);
  
  //random tint and adds tint to image
  int[] randRGB = calcRandomTint();
  tint(randRGB[0], randRGB[1], randRGB[2]);
  
  //draw the image with the mask
  image(currentTexture, -width/2, -height/2);
}

//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
//ORIGINAL WITH NO TEXTURE -- Just lines
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
  shapeMask.fill(255);    // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.translate(width / 2, height / 2);      //centers the shape
  shapeMask.rotate(rotation);
  
  float fifthWidth = ((size*2 - size/2) + (size*2 - size/2)) / 5;
  float prongHeight = size - (2 * size / 3);
  
  shapeMask.beginShape();
  
  line(size-size, size-size, size-size+1, size-size+1); //draw a dot in the center of the object to track origin
  
  //Note: the original shape is draw upside down -- so that is how I refer to the corners
  
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
  
  //random tint and adds tint to image
  int[] randRGB = calcRandomTint();
  tint(randRGB[0], randRGB[1], randRGB[2]);
  
  //draw the image with the mask
  image(currentTexture, -width/2, -height/2);

}


//ORIGINAL WITH NO TEXTURE -- JUST LINES
void drawKing(float size, float rotation){
  pushMatrix();
 
  rotate(rotation);
  float fifthWidth = ((size*2 - size/2) + (size*2 - size/2)) / 5;
  float prongHeight = size - (2 * size / 3);
    
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

//gives random color value for image tint
int[] calcRandomTint() {
  int[] randomRGB = new int[3];      // holds RGB value  
  
 // whichColorPalette = 6;
  
  if (whichColorPalette == 0) {
    // brick color palette
    int randomNum  = int(random(120,125));
    
    randomRGB[0] = int(random(randomNum, randomNum + 10));    //Red
    randomRGB[1] = int(random(randomNum - 40, randomNum-5));  //Green
    randomRGB[2] = randomRGB[1];                              //Blue
    
  } else if (whichColorPalette == 1) {
    // dark blue green palette
    int randomNum  = int(random(60,125));
    
    randomRGB[0] = int(random(randomNum - 40, randomNum-5));    //Red
    randomRGB[1] = randomRGB[0] + 20;                           //Green
    randomRGB[2] = int(random(randomNum, randomNum + 10));      //Blue
  
  } else if (whichColorPalette == 2) {
    // dark grey color palette
    int randomNum  = int(random(60,125));
    //int randomVary = int(random(0, 10));
    
    randomRGB[0] = randomNum - int(random(0, 10));    //Red
    randomRGB[1] = randomNum - int(random(0, 5));    //Green
    randomRGB[2] = randomNum - int(random(0, 10));   //Blue
    
  } else if (whichColorPalette == 3) {
    // dark warm purple palette
    int randomNum  = int(random(60,125));
    
    randomRGB[0] = int(random(randomNum, randomNum + 10));    //Red
    randomRGB[1] = int(random(randomNum - 40, randomNum-5));  //Green
    randomRGB[2] = randomRGB[0] + 20;                         //Blue
  
  } else if (whichColorPalette == 4) {
    // dark cool purple palette
    int randomNum  = int(random(60,125));
    
    randomRGB[0] = int(random(randomNum - 20, randomNum - 10));    //Red
    randomRGB[1] = randomRGB[0] - 20;                              //Green
    randomRGB[2] = int(random(randomNum + 10, randomNum + 60));    //Blue
    
  } else if (whichColorPalette == 5) {
    // purple grey palette
    int randomNum  = int(random(120,125));
    
    randomRGB[0] = int(random(randomNum - 40, randomNum-5));    //Red
    randomRGB[1] = randomRGB[0];                                //Green
    randomRGB[2] = int(random(randomNum, randomNum + 10));      //Blue
  
} else if (whichColorPalette == 6) {
    // brown palette
    int randomNum  = int(random(120,125));
    
    randomRGB[0] = int(random(randomNum, randomNum + 10));    //Red
    randomRGB[1] = int(random(randomNum - 10, randomNum-5));  //Green
    randomRGB[2] = randomRGB[1];      //Blue
  }
  
  return randomRGB;
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
  float rateOfSize = 1.5;   //number size is divided by -- variable for easier updating
  
  //declaring random values
  int randomShapeVal;
  int randomRotVal;
  int randomTextureVal;
  
  int randomBranchVal;
  
  int[] randomBranchVals = {0,1,2,3,4};
  
  int shapeTypeCount = 2;      // number of shapes, just makes it easier to only have to change one number when we add things
    
  //this stops the recursion -- once recLevel reaches 0
  if(recLevel > 0){
    //value determines random branch
    randomBranchVal = int(random(0, randomBranchVals.length));
    
    if (randomBranchVal != 0) {
     //------- first branch -------- right branch
      pushMatrix();
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
        drawPawn1(size/rateOfSize, rotations[randomRotVal], randomTextureVal);  
        drawPawn1(size/rateOfSize, rotations[randomRotVal]);  
        
      } else if (randomShapeVal == 1) {
        //drawKing(size/rateOfSize, rotation/2);                 //original line of code for rotation
        drawKing(size/rateOfSize, rotations[randomRotVal], randomTextureVal);      //with random rotation
        drawKing(size/rateOfSize, rotations[randomRotVal]);
      }
      
      recShape(size/rateOfSize, recLevel-1, rotation/2);    //***recursive call
      popMatrix();
    }
    
    if (randomBranchVal != 1) {
      //------- second branch ------- left branch
      pushMatrix();
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
        drawPawn1(size/rateOfSize, rotations[randomRotVal], randomTextureVal);
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
  
}
