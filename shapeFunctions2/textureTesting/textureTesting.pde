int sizeX = 1080; 
int sizeY = 720;

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
  img1.resize(width, height); 
  img2.resize(width, height); 
  img3.resize(width, height); 
  
  //array of textures
  textures = new PImage[]{img1, img2, img3};
  
  //creates mask canvas
  mask = createGraphics(width, height);
  
  noLoop();
}

void draw() {
  background(255);  //white background before drawing
  
  //draw the base shape directly (without recursion) for the first case
  int baseTextureIndex = int(random(textures.length));
  recPawn1(400, 600, 50, 2, baseTextureIndex); 
  
  //then call recursive function
  recursiveDraw(400, 600, 50, 2);
  
  noLoop();
}

/**
 * recursiveDraw()
 * This function manages the recursion
 */
void recursiveDraw(float xCenter, float yCenter, float size, int recLevel) {
  //variable holds random value for which shape is drawn
  //int randShapeNum = int(random(0,3));   //***uncomment once we have the other shape functions
  int randShapeNum  = 0;                   //****delete once we have other shape functions and uncomment above^^^
  
  int randTextureIndex = int(random(textures.length)); //random texture from the list of textures
  
  
  //maybe we can add some variables here to make adjusting easier
        // ex. size/2 could be size/sizeRate -- so we can adjust it on a big scale
        // to be added
  
  
  //levels above 0 (before the last level)
  if (recLevel > 0) {
    if (randShapeNum == 0) {     // 0 -- recPawn1
     recPawn1(xCenter - size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
     recPawn1(xCenter + size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
      
    } else if (randShapeNum == 1) {
      
    } else if (randShapeNum == 2) {
      
    }
    recPawn1(xCenter - size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
    recPawn1(xCenter + size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
    
    //recusive call below -- occurs when we are on level > 0
    recursiveDraw(xCenter - size * 1.5, yCenter - size * 2, size / 2, recLevel - 1);
    recursiveDraw(xCenter + size * 1.5, yCenter - size * 2, size / 2, recLevel - 1);
    
  } else {
    //end of recursion -- final level -- level 0
    
    //-----insert something similar to above with drawing random shapes
    // but minus the recursive calls to recursiveDraw()-----
    
    //int randTextureIndex = int(random(textures.length)); //random texture from the list of textures
    recPawn1(xCenter - size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
    recPawn1(xCenter + size * 1.5, yCenter - size * 2, size / 2, recLevel - 1, randTextureIndex);
  }
}

/**
 * draws the shape rectangle/trapazoid type shape 
 * now creates a shape mask for a randomly assigned texture, so the shape has texture
*/
void recPawn1(float xCenter, float yCenter, float size, int recLevel, int textureIndex) {
  //get texture which texture given the random index
  PImage currentTexture = textures[textureIndex]; 

  //create a separate masks for each shape
  PGraphics shapeMask = createGraphics(width, height);
  shapeMask.beginDraw();
  shapeMask.stroke(255);  
  shapeMask.fill(255);  // fills the defined area (affects transparency)
  
  //defining where the shape is -- begin shape and vertices
  shapeMask.beginShape();
  
  //each point of the pawn shape in clock wise order
  //starting with top left corner ending with bottom left corner after diagnol
  shapeMask.vertex(xCenter - (size * 2), yCenter - size); 
  shapeMask.vertex(xCenter + (size * 2), yCenter - size); 
  shapeMask.vertex(xCenter + (size * 2 - size / 2), yCenter - (size * 2)); 
  shapeMask.vertex(xCenter + (size * 2 - size / 2), yCenter - (size * 3));
  shapeMask.vertex(xCenter - (size * 2 - size / 2), yCenter - (size * 3));
  shapeMask.vertex(xCenter - (size * 2 - size / 2), yCenter - (size * 2));
  
  shapeMask.endShape(CLOSE);  //close the shape
  shapeMask.endDraw();
  
  //apply the mask to the selected texture
  currentTexture.mask(shapeMask);
  
  //draw the image with the mask
  image(currentTexture, 0, 0);  
}
