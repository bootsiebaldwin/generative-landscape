int sizeX = 1080; 
int sizeY = 720;

public void settings() {
  size(sizeX, sizeY);
}
void setup() {
  stroke(0); 
  frameRate(10); 
}

void draw(){
  //line(x1, y1, x2, y2);
  pawn1(400, 600);

}

//create one variant of the pawn shape
void pawn1(float xStart, float yStart){
  line(xStart, yStart, xStart + 200, yStart);
  
  line(xStart, yStart, xStart + 30, yStart - 50);
  line(xStart + 200, yStart, xStart + 170, yStart - 50);
  
  line(xStart + 30, yStart - 50, xStart + 30, yStart - 100);
  line(xStart + 170, yStart - 50, xStart + 170, yStart - 100);
  
  line(xStart + 30, yStart - 100, xStart + 170, yStart - 100);
}
