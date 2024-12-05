//VARIABLES FROM UI

boolean start = false;
boolean pause = false;
boolean settings = false;
boolean restart = false;
boolean information = false;
boolean screenshot = false;

boolean running = false;
boolean simRunAppear = false;
boolean ifSimComplete = false;


color textColor, startbuttonColor, controlbuttonColor;
//start button diamentions
int startrx = 725;
int startry = 475;
int startrw = 250;
int startrh = 75;
//pause button diamentions
int pauserx = 1222;
int pausery = 847;
int pauserw = 75;
int pauserh = 75;
//settings button diamentions
int settingsrx = 218;
int settingsry = 847;
int settingsrw = 75;
int settingsrh = 75;

//exit button diamentions
int exitbuttonrx = 1225;
int exitbuttonry = 125;
int exitbuttonrw = 50;
int exitbuttonrh = 50;

//button images
PImage settingsButtonImg;
PImage pauseButtonImg;
PImage exitButtonImg;

//FONT
PFont font;

float textLocationX = 480;
float textLocationY = 175;



//MAIN SCENE VARIABLES

int sizeX = 1600; 
int sizeY = 1080;

//possible rotation values of the shapes
float[] rotations = {0, PI, PI/2, 3*PI/2};            //right now I have all the shapes staying the same rotation or upside down

int whichColorPalette;    //tracks the global color palette of the castle

int loopCount = 0;        //used in draw() to have background appear before castle

PGraphics mask;
PImage img1, img2, img3;
PImage[] textures;

int textureSize = 300;

 
//------ main assets ------
PImage backgroundImg;

PImage[] bushImgs;
PImage pineTreeImg;

PImage[] cloudImgs;
PImage[] moonImgs;

PImage[] dragonImgs;
PImage dragonLogo;

PImage[] doorImgs;

//----- RECURSIVE TREE DATA-----
int maxDepth = 10; // This is the base case
ArrayList<Integer> primes; // Data structure to store list of prime numbers
TreeInfo[] trees = new TreeInfo[2]; // Trees that will appear with info
int currentDepth = 0; // How big the tree will grow, I put it at zero for the "Stump"





public void settings() {
  size(sizeX, sizeY);
}


void setup() {
  //UI SET UP
  //fullScreen();
  font = createFont("Retro Gaming.ttf", 48);
  
  stroke(0); 
  frameRate(1); 
  println("setting up ");
  
  //background image
  backgroundImg = loadImage("background12.png");
  
  //load asset images
  bushImgs = new PImage[]{ loadImage("Bush_1.png"), loadImage("Bush_2.png"), loadImage("Bush_3.png"),
                           loadImage("Bush_4.png"), loadImage("Bush_5.png"), loadImage("Bush_6.png")
                         };
  
  pineTreeImg = loadImage("pinetree.png");
                         
                         
  cloudImgs = new PImage[]{ loadImage("Cloud_1.png"), loadImage("Cloud_2.png"), loadImage("Cloud_3.png"),
                            loadImage("Cloud_4.png")
                         };
                         
  moonImgs = new PImage[]{ loadImage("moon1.png"), loadImage("moon2.png"), loadImage("moon3.png"),
                            loadImage("moon4.png"), loadImage("moon5.png")
                         };
                         
  dragonImgs = new PImage[]{ loadImage("dragonFlying.png"), loadImage("Sleeping_dragon.png")};
  
  dragonLogo = loadImage("smallbigdragon1.png");
  
  
  doorImgs = new PImage[]{ loadImage("door.png"), loadImage("Castle_door_1.png"), loadImage("Castle_door_2.png") };
  
  textures = new PImage[]{ loadImage("Brick_1_1080.png"), loadImage("Brick_2_1080.png"), loadImage("Brick_3_1080.png"),
                           loadImage("Brick_4_1080.png"), loadImage("Brick_5_1080.png")
                           };
                         
                    
   
  //---- RESIZING ASSETS THAT NEED IT ----                    
  //resize bush images     
  for(int i = 0; i < bushImgs.length; i++) { 
    bushImgs[i].resize(width/11, height/11);
  }
  
  //resize cloud images
  for(int i = 0; i < cloudImgs.length; i++) { 
    cloudImgs[i].resize(width/11, height/11);
  }
  
  //resize cloud images
  for(int i = 1; i < doorImgs.length; i++) { 
    doorImgs[i].resize(width/10, height/10);
  }
  
  
  dragonImgs[1].resize(width/10, height/10);      //this one was larger than the other dragon image so i scaled it down
  dragonImgs[0].resize(2*173, 2*134); 
    
  //resize textures images
  for(int i = 0; i < textures.length; i++) { 
    textures[i].resize(textureSize, textureSize);
  }
  
  
  //----- RECURSIVE TREE SET UP------
  // Starting prime numbers that'll be generated
  primes = generatePrimes(20);

  // Creating two trees with random primes for which way the branches will grow (at an angle);
  trees[0] = new TreeInfo(width * 0.25, height, primes.get((int)random(primes.size())));
  trees[1] = new TreeInfo(width * 0.75, height, primes.get((int)random(primes.size())));
   
   
   
  //creates mask canvas
  mask = createGraphics(width, height);
  
}

//DO NOT USE scale(), ALWAYS SCALE BY CHANGING SIZE INPUTTED INTO FUNCTION
void draw(){
  if (!start) {
    background(200);
    fill(textColor);
    textFont(font);
    textAlign(LEFT);
    text("Recurrent Fantasy", 50, 100);
    
    noTint();
    image(dragonLogo, 800, 0);
    
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(displayWidth/2, displayHeight/2, 1080, 720);
    
    fill(0);
    textSize(24); 
    text("Press [space] to generate", displayWidth/4, displayHeight/2);
    
    //startButton();
    loopCount = 0;
  }
  
  if (start && !pause) {
    //program screen
    noStroke();
    rectMode(CENTER);
    fill(255);
    if (!simRunAppear) { 
      rect(displayWidth/2, displayHeight/2, 1080, 720);
    }
    
    //pause and setting button
    //pauseButton();
    //settingsButton();
    
    //other stuff for simulation can happen here
    
    
    fill(0);
    textSize(24);
    //text("Simulation has started.", textLocationX, textLocationY);
    println("start sim");
    
    if (simRunAppear) {
      running = true;
      
      if (loopCount == 0) {           //draws castle on second iteration of draw() then stops loop
        pushMatrix();
        translate(displayWidth/2 - 1080/2, displayHeight/2 - 720/2);
        //translate(displayWidth/2 - 1080/2, displayHeight/2 - 720/2);
        drawBackgroundAndAssets();
        popMatrix();
        
        loopCount++;
      }
      
      //loopCount++;
      
      if (loopCount == 1) {           //draws castle on second iteration of draw() then stops loop
        //text("Simulation has started.", 500, 300);
        int whichDoor = int(random(0,2));
        
        pushMatrix();
        translate(displayWidth/2 - 1080/2, displayHeight/2 - 720/2);
        drawCastle();
        
        if (whichDoor == 0)
          image(doorImgs[1], 518, 468);
         else 
          image(doorImgs[2], 518, 468);
          
        popMatrix();
        loopCount++;
      }
      
       //loopCount++;
       
      
      
      // ------ Draw recursive tree structures --------
     // pushMatrix();
      for (TreeInfo tree : trees) {
        pushMatrix();
        translate(60, -165);        //changes the onscreen location of tree
        
        pushMatrix();
        translate(tree.x, tree.y);
        drawTree(75, 0, tree.primeAngle + 3, currentDepth); // Increased initial branch length and width of stump
        popMatrix();
        popMatrix();
      }
      //popMatrix();
      
      //cover up previous text 
      fill(200); 
      noStroke();
      rect(0, 0, 1500, 100);
      
      // Display information about the trees (depth, angles, etc.).
      displayTreeInfo();
      
      // Increase depth after each frame until max depth is reached
      if (currentDepth < maxDepth) {
        currentDepth++;
      } else {
        loopCount++;    //stops the sim
      }
      //////////////
        
        
      if (loopCount > 1){
        running = false;
        ifSimComplete = true;
        //noLoop()
      }  
      
      if (ifSimComplete) {
        fill(0);
        textSize(24);
        //text("Simulation complete.", textLocationX, textLocationY);
      }
      
    }
    simRunAppear = true;
  }
  
  
  //idea: could insert tree iteration to run after loop count > 0, so we see growth 
  
}

// CALLED IN DRAW()---------
void drawBackgroundAndAssets() {
  //random color palette -- for background image but may need work, not used right now
  whichColorPalette = int(random(0,6));
  int[] randRGB = calcRandomTint();
  
  //draw background of scene
  pushMatrix();
  
  int[] randTintBackground = calcRandomTintBackground();
  tint(randTintBackground[0], randTintBackground[1], randTintBackground[2]);
  
  //tint(255, 255, 255);            //all 255 -- right now there is no tint and background is light the original
  image(backgroundImg, 0, 0);

  popMatrix();
  
  pushMatrix();
  
  tint(255, 255, 255);            //all 255 -- right now there is no tint and background is light the original
  drawStaticAssets();
  
  popMatrix();
}

void drawCastle() {
  int baseTextureIndex = int(random(textures.length));
    //new color palette for castle specifically
    whichColorPalette = int(random(0,6));
    
    println("castle drawing");
    
    pushMatrix();
    translate(600, 500);
    //rotate(PI);              //flips the entire shape
    
    stroke(0); 
    strokeWeight(1);
        
    recShape(75, 7, HALF_PI);
    drawPawn1(75, 0, baseTextureIndex);        //base case -- could be any shape
    drawPawn1(75, 0);
    
    popMatrix();
    
    //noLoop();
    
}



//---------draws assets-----------
void drawStaticAssets() {
  
  //------ moon asset --------
  
  int whichMoon = int(random(0, moonImgs.length));
  
  if (whichMoon == 0){
    image(moonImgs[0], 700, 70);
  }
  
  else if (whichMoon == 1){
    image(moonImgs[1], 20, 50);
  }
  
  else if (whichMoon == 2){
    image(moonImgs[2], 600, 30);
  }
  
  else if (whichMoon == 3){
    image(moonImgs[3], 150, 20);
  }
  
  else if (whichMoon == 4){
    image(moonImgs[4], 375, 15);
  }
  
  
  //------ dragon assets ------
  int whichDragon = int(random(0, dragonImgs.length));
  
   if (whichDragon == 0) {              
     image(dragonImgs[0], 200, 75);
     
   } else if (whichDragon == 1) {              
     image(dragonImgs[1], 220, 500);
     
   } else if (whichDragon == 2) {              
     image(dragonImgs[2], 200, 75);
   }
   
  
  //----tree/bush assets----
  int treeOrBushVal = int(random(0,2));   // if 0 -- tree, if 1 -- one of the bushes
  int plantLocationOffset = 50;
  
  //predetermined coordinates for bush and tree objects
  int[] plantLocationX = {120, 75,  750, 875, 900};
  int[] plantLocationY = {550, 450, 525, 490, 610};
  
  int[] randTintPlants = calcRandomTintPlants();
  tint(randTintPlants[0], randTintPlants[1], randTintPlants[2]);
  
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
  
  
  //------ cloud assets --------
  //random placement of cloud objects in the sky
  for(int i = 0; i < 8; i++) {
    float randX = random(0, sizeX-700);
    float randY = random(50, sizeY/4);
    
    int randomCloudIndex = int(random(0, cloudImgs.length));        //random selection of cloud asset from image array
    
    image(cloudImgs[randomCloudIndex], randX,  randY);              //places the selected cloud image
  }
  
}

//DRAWS WITH TEXTURE
//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawPawn1(float size, float rotation, int textureIndex){
  //get texture which texture given the random index
  PImage currentTexture = textures[textureIndex]; 

  //create a separate masks for each shape
  PGraphics shapeMask = createGraphics(textureSize, textureSize);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);  // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.translate(textureSize / 2, textureSize / 2);      //centers the shape
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
  image(currentTexture, -textureSize/2, -textureSize/2);
}

//this function draws the basic pawn1 shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
//ORIGINAL WITH NO TEXTURE -- Just lines
void drawPawn1(float size, float rotation){
  pushMatrix();
  rotate(rotation);
  
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
  PGraphics shapeMask = createGraphics(textureSize, textureSize);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);    // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.translate(textureSize / 2, textureSize / 2);      //centers the shape
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
  image(currentTexture, -textureSize/2, -textureSize/2);

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

//DRAWS WITH TEXTURE
//this function draws the basic a hexagon shape around the origin, allowing it to be rotated at any location when using translate and rotate in draw()
void drawHexagon(float size, float rotation, int textureIndex){
  //get texture which texture given the random index
  PImage currentTexture = textures[textureIndex]; 
  
  float hexWidthVal = 1.5;
  float hexTopWidVal = hexWidthVal - hexWidthVal / 4;
  float hexBotWidVal = hexWidthVal - hexWidthVal / 2;
  
  //create a separate masks for each shape
  PGraphics shapeMask = createGraphics(textureSize, textureSize);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);  // fills the defined area (affects transparency)
  
  shapeMask.pushMatrix();
  shapeMask.translate(textureSize / 2, textureSize / 2);      //centers the shape
  shapeMask.rotate(rotation);
  
  shapeMask.beginShape();
  
  //each point of the pawn shape in clock wise order
  shapeMask.vertex(-size * hexWidthVal, size-size); 
  shapeMask.vertex(-size * hexTopWidVal, -size);
  shapeMask.vertex(size * hexTopWidVal, -size);
  shapeMask.vertex(size * hexWidthVal, size-size);
  shapeMask.vertex(size * hexBotWidVal, size);
  shapeMask.vertex(-size * hexBotWidVal, size);
  
  
  shapeMask.endShape(CLOSE);  //close the shape
  
  shapeMask.popMatrix();
  shapeMask.endDraw();
  
  //apply the mask to the selected texture
  currentTexture.mask(shapeMask);
  
  //random tint and adds tint to image
  int[] randRGB = calcRandomTint();
  tint(randRGB[0], randRGB[1], randRGB[2]);
  
  //draw the image with the mask
  image(currentTexture, -textureSize/2, -textureSize/2);
}

//ORIGINAL WITH NO TEXTURE -- JUST LINES
void drawHexagon(float size, float rotation){
  pushMatrix();
  
  float hexWidthVal = 1.6;
  float hexTopWidVal = hexWidthVal - hexWidthVal / 4;
  float hexBotWidVal = hexWidthVal - hexWidthVal / 2;
  
  rotate(rotation);

  //prong lines
  line((-size * hexWidthVal), size-size, -(size * hexTopWidVal), -size);
  line(-(size * hexTopWidVal), -size, (size * hexTopWidVal), -size); 
  line((size * hexTopWidVal), -size, size * hexWidthVal, size-size);
  line(size * hexWidthVal, size-size, (size * hexBotWidVal), size);
  line((size * hexBotWidVal), size, -(size * hexBotWidVal), size);
  line(-(size * hexBotWidVal), size, (-size * hexWidthVal), size-size);
  
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
    randomRGB[2] = randomRGB[1];                              //Blue
  }
  
  return randomRGB;
}

int[] calcRandomTintPlants() {
  int[] randomRGB = new int[3];      // holds RGB value   

  int randomNum  = int(random(230,240));
  
  randomRGB[0] = int(random(randomNum - 10, randomNum));    //Red
  randomRGB[1] = int(random(randomNum - 5, randomNum + 10));  //Green
  randomRGB[2] = randomRGB[0];      
    
  return randomRGB;
}

int[] calcRandomTintBackground() {
  int[] randomRGB = new int[3];      // holds RGB value   

  int randomNum  = int(random(200,230));
  
  randomRGB[0] = int(random(randomNum - 5, randomNum + 10));    //Red
  randomRGB[1] = int(random(randomNum - 5, randomNum + 10));  //Green
  randomRGB[2] = int(random(randomNum - 5, randomNum + 10));      
    
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
  
  int shapeTypeCount = 3;      // number of shapes, just makes it easier to only have to change one number when we add things
    
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
        
      }  else if (randomShapeVal == 2) {
        //drawHexagon(size/rateOfSize, rotation/2);                 //original line of code for rotation
        drawHexagon(size/rateOfSize, rotations[randomRotVal], randomTextureVal);      //with random rotation
        drawHexagon(size/rateOfSize, rotations[randomRotVal]);
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


//-----------UI Elements--------------


void startButton() {
  //start button
  stroke(2);
  fill(startbuttonColor);
  rect(startrx, startry, startrw, startrh);
  //start text
  fill(0);
  textSize(24);
  text("Start Simulation", (startrx - 125), startry);
}

void pauseButton() {
  noStroke();
  fill(255);
  rect(pauserx, pausery, pauserw, pauserh);
  pauseButtonImg = loadImage("Pause_Button_.png");
  image(pauseButtonImg, pauserx - 40, pausery - 37, pauserw, pauserh);
}

void settingsButton() {
  noStroke();
  fill(255);
  rect(settingsrx, settingsry, settingsrw, settingsrh);
  settingsButtonImg = loadImage("Settings_Button.png");
  image(settingsButtonImg, settingsrx - 40, settingsry - 37, 75, 75);
}
void restartButton() {
  stroke(2);
  fill(startbuttonColor);
  rectMode(CENTER);
  rect(725, 450, 220, 60);
  fill(0);
  textAlign(CENTER);
  textSize(18);
  text("Restart simulation", 725, 460);
}
void screenshotButton() {
  stroke(2);
  fill(startbuttonColor);
  rectMode(CENTER);
  rect(725, 550, 260, 60);
  fill(0);
  textAlign(CENTER);
  textSize(18);
  text("Screenshot simulation", 725, 560);
}
void infoButton() {
  stroke(2);
  fill(startbuttonColor);
  rectMode(CENTER);
  rect(725, 650, 220, 60);
  fill(0);
  textAlign(CENTER);
  textSize(18);
  text("Information", 725, 660);
}

void exitButton() {
  stroke(2);
  fill(255);
  rect(exitbuttonrx, exitbuttonry, exitbuttonrw, exitbuttonrh);
  exitButtonImg = loadImage("exit_button.png");
  image(exitButtonImg, exitbuttonrx - 25, exitbuttonry - 25, exitbuttonrh, exitbuttonrw);
}


void mousePressed() {
  //mouse fucntion for start button
  if (mouseX >= startrx -10 &&  mouseX <= (startrx -10) + (startrw - 10) &&
    mouseY >= startry -10 && mouseY <= (startry - 10) + (startrh - 10)) {
    start = true;
  }

  //mouse fucntion for pause button
  if (mouseX >= pauserx && mouseX < pauserx + pauserw
    && mouseY >= pausery && mouseY <= pausery + pauserh) {
    pause = !pause;
  }
  //mouse fucntion for settings button
  if (mouseX >= settingsrx - 10 && mouseX < (settingsrx - 10) + (settingsrw - 10)
    && mouseY >= settingsry - 10 && mouseY <= (settingsry - 10) + (settingsrh -10)) {
    settings = !settings;
  }

  //mouse function for restart button
  if (settings) {
    
      if (mouseX >= 725 - 10 && mouseX < (725 - 10) + (220 - 10) && mouseY >= 460-10 &&
        mouseY <= (460 - 10) + (60 - 10)) {
        start = false;
        pause = false;
        settings = false;
        restart = false;
        information = false;
        screenshot = false;
        //program screen
        noStroke();
        rectMode(CENTER);
        fill(255);
        rect(displayWidth/2, displayHeight/2, 1080, 720);
      }

      //mouse fucntion for screenshot button
      if (mouseX >= 725 - 10 && mouseX < (725 - 10) + (240 - 10) && mouseY >= 550-10 &&
        mouseY <= (550 - 10) + (60 - 10)) {
        screenshot = !screenshot;
      }
      //mouse function for info button
      if (mouseX >= 725 - 10 && mouseX < (725 - 10) + (220 - 10) && mouseY >= 650-10 &&
        mouseY <= (650 - 10) + (60 - 10)) {
        information = !information;
      }
      //mouse function for exit button
    if (mouseX >= exitbuttonrx - 10 && mouseX < (exitbuttonrx - 10) + (exitbuttonrw - 10) &&
      mouseY >= (exitbuttonry-10) && mouseY <= (exitbuttonry - 10) + (exitbuttonrh - 10)) {
      if (information) {
        information = false;
      } else if (settings) {
        settings = false;
      } else if (screenshot) {
        screenshot = false;
      }

    }
  }
}


void keyPressed() {
  if (key == ' ') {
    println("space bar");
    
    if(!start) {
      start = true;
    } else {
      start = false;
      simRunAppear = false;
      
      //----- RECURSIVE TREE SET UP------
      // Starting prime numbers that'll be generated
      primes = generatePrimes(20);
    
      // Creating two trees with random primes for which way the branches will grow (at an angle);
      trees[0] = new TreeInfo(width * 0.25, height, primes.get((int)random(primes.size())));
      trees[1] = new TreeInfo(width * 0.75, height, primes.get((int)random(primes.size())));
 
    }
  }
}

//tree functions

void drawTree(float len, int depth, int angle, int limit) {
  if (depth >= limit) return;

  pushStyle();  // Save current style settings
  if (depth < 6) {
    stroke(155, 105, 60); 
    strokeWeight(7 - depth); 
  } else {
    stroke(0, 100, 0); 
    strokeWeight(6); 
  }

  line(0, 0, 0, -len);
  translate(0, -len);

  pushMatrix();
  rotate(radians(angle));
  drawTree(len * 0.6, depth + 1, angle, limit);
  popMatrix();

  pushMatrix();
  rotate(radians(-angle));
  drawTree(len * 0.6, depth + 1, angle, limit);
  popMatrix();

  translate(0, len);
  popStyle();  // Restore previous style settings
}

ArrayList<Integer> generatePrimes(int limit) {
  ArrayList<Integer> primeList = new ArrayList<Integer>();
  int count = 2;
  while (primeList.size() < limit) {
    if (isPrime(count)) primeList.add(count);
    count++;
  }
  return primeList;
}

boolean isPrime(int n) {
  if (n < 2) return false;
  for (int i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}

class TreeInfo {
  float x, y;
  int primeAngle;
  TreeInfo(float x, float y, int primeAngle) {
    this.x = x;
    this.y = y;
    this.primeAngle = primeAngle;
  }
}

// Display information about each tree's position, angle, and depth.
void displayTreeInfo() {
  fill(0); // Black text color.
  textSize(12); // Small text size.
  int yOffset = 15; // Vertical spacing for each line of text.
  for (int i = 0; i < trees.length; i++) {
    TreeInfo tree = trees[i]; // Get the current tree's information.
    text(
      "Tree " + (i + 1) + ": Position (" + (int)tree.x + ", " + (int)tree.y + 
      "), Prime Angle: " + tree.primeAngle + "°, Current Depth: " + currentDepth + 
      ", Max Depth: " + maxDepth, 
      10, yOffset); // Display tree information.
    yOffset += 15; // Move to the next line.
  }
}
