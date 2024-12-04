boolean start = false;
boolean pause = false;
boolean settings = false;
boolean restart = false;
boolean information = false;
boolean screenshot = false;


color textColor, startbuttonColor, controlbuttonColor;
//start button diamentions
int startrx = 725;
int startry = 475;
int startrw = 250;
int startrh = 100;
//pause button diamentions
int pauserx = 1225;
int pausery = 850;
int pauserw = 75;
int pauserh = 75;
//settings button diamentions
int settingsrx = 220;
int settingsry = 850;
int settingsrw = 75;
int settingsrh = 75;

//exit button diamentions
int exitbuttonrx = 1225;
int exitbuttonry = 200;
int exitbuttonrw = 50;
int exitbuttonrh = 50;

//button images
PImage settingsButtonImg;
PImage pauseButtonImg;
PImage exitButtonImg;

void setup() {

  fullScreen();


  background(200);

  textColor = color(0);
  startbuttonColor = color(210);
  controlbuttonColor = color(255);
}
//program screen
void draw() {
  //title
  PFont font;
  font = createFont("Retro Gaming.ttf", 48);
  //starting screen before simulation
  if (!start) {
    background(200);
    fill(textColor);
    textFont(font);
    textAlign(LEFT);
    text("Recurrent Fantasy", 50, 50);

    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(displayWidth/2, displayHeight/2, 1080, 720);

    startButton();
  }
  //pause button for simulation
  if (start && pause) {
    noStroke();
    rectMode(CENTER);
    fill(255, 25);
    rect(displayWidth/2, displayHeight/2, 1080, 720);


    fill(0);
    text("Simulation paused", 500, 500);
  }
  //simulation in progress
  if (start && !pause) {
    //program screen
    noStroke();
    rectMode(CENTER);
    fill(255);
    rect(displayWidth/2, displayHeight/2, 1080, 720);
    //pause and setting button
    pauseButton();
    settingsButton();
    //other stuff for simulation can happen here
    fill(0);
    textSize(24);
    text("Simulation has started.", 500, 300);
  }

  if (start && settings) {

    //program screen
    noStroke();
    rectMode(CENTER);
    fill(220, 75);
    rect(displayWidth/2, displayHeight/2, 1080, 720);
    //
    exitButton();
    restartButton();
    screenshotButton();
    infoButton();


    if (screenshot) {
      settings = false;
      
      for (int sstimer = 0; sstimer < 10; sstimer = sstimer +1) {
      text("Screenshot taken!", 725, 375);
      save("recurrent_fantasyss.jpg");
      
      }
      settings = true;
      
      
    }
    if (information) {
      noStroke();
      rectMode(CENTER);
      fill(250);
      rect(displayWidth/2, displayHeight/2, 1080, 720);
      //text about project
      fill(0);
      textAlign(CENTER);
      textSize(24);
      text("About Reccurent Fantasy", 725, 350);

      fill(0);
      textAlign(CENTER);
      textSize(14);
      text("This project is a dark fantasy simulation that creates a landscape based on of recusion and randomness. ", 725, 400);
      text("The randomness of the code allows for countless possibilities within the program.", 725, 450);
      text("Each landscape changes over time with recursion methods.", 725, 500);
      text("Created by: Briana Addison, Bootsie Baldwin, Jonah Boxer, Sophia Butcher, and Sydney Wertz.", 725, 550);
      exitButton();
    }
  }
}

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
  stroke(2);
  fill(255);
  rect(pauserx, pausery, pauserw, pauserh);
  pauseButtonImg = loadImage("Pause_Button_.png");
  image(pauseButtonImg, pauserx - 40, pausery - 37, pauserw, pauserh);
}

void settingsButton() {
  stroke(2);
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
  rect(725, 550, 250, 60);
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
