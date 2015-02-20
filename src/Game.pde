/************************************************
*  Game.pde
*  IpsePuppet project
*  By Chris Jimenez
*  
*************************************************/

class Game {
  int score = 0;

  float initX, initY;
  float contactX, contactY;

  float startTime;
  float currentTime;
  float displayTime;
  float timer = 30.0;

  int count = 140;//for the fading text

  FBox leftWall;
  FBox rightWall;
  FBox cieling;

  boolean highlightLeftWall;
  boolean highlightLRightWall;
  boolean highlightCieling;

  /**
  *  CONSTRUCTOR  
  */
  Game() {

    initX = puppet.xPos;
    initX = puppet.yPos;

    score = 0;

    leftWall = new FBox(15, height);
    leftWall.setPosition(7, height/2);
    leftWall.setNoStroke();
    leftWall.setDensity(1);
    leftWall.setGrabbable(false);
    leftWall.setStatic(true);

    rightWall = new FBox(15, height);
    rightWall.setPosition(width - 7, height/2);
    rightWall.setNoStroke();
    rightWall.setDensity(1);
    rightWall.setGrabbable(false);
    rightWall.setStatic(true);


    cieling = new FBox(width, 15);
    cieling.setPosition(width/2, 7);
    cieling.setNoStroke();
    cieling.setDensity(1);
    cieling.setGrabbable(false);
    cieling.setStatic(true);

    world.add(leftWall);
    world.add(rightWall);
    world.add(cieling);

    reset();
  }

  /**
  *  method to start game...
  */
  void playGame() {
    background(213, 15, 37);
    world.step();
    world.draw();

    puppet.display();

    // check if bat touches any part of the puppet
    checkCollision(puppet.head);
    checkCollision(puppet.midsection);
    checkCollision(puppet.leftArm);
    checkCollision(puppet.rightArm);
    checkCollision(puppet.leftLeg);
    checkCollision(puppet.rightLeg);

    // display fading text
    displayFadingText("You got "+ timer+" seconds!", 100, 160);

    // display the commands
    displayCommands(350, 30);

    // display score
    displayTimeAndScore(20, 50);


    if (keyPressed && key =='r') {// resets the game
      score= 0;
      reset();
      currentTime = 0;
    }

    if (keyPressed && key =='q') {// quits the game
      state = 0;
    }

    checkTimer();
  }

  /**
  *  checks if stick is hitting given fisica box
  */
  void checkCollision(FBox box) {
    if (leftWall.isTouchingBody(box) && (abs(box.getVelocityX()) > 300)) {
      leftWall.setFill(131, 245, 44);
      score++;
    } else {
      leftWall.setFill(0, 0, 0);
    }


    if (rightWall.isTouchingBody(box) && (abs(box.getVelocityX()) > 300)) {
      rightWall.setFill(243, 243, 21);
      score++;
    } else {
      rightWall.setFill(0, 0, 0);
    }


    if (cieling.isTouchingBody(box) && (abs(box.getVelocityY()) > 300)) {
      cieling.setFill(180, 49, 244);
      score++;
    } else {
      cieling.setFill(0, 0, 0);
    }
  }

  /**
  *  resets the game
  */
  void reset() {
    score = 0;
    //reset start time
    startTime = (millis()/1000);
  }

  /**
  *  Displays the commands to reset or quit
  */
  void displayTimeAndScore(float x, float y) {
    fill(255);
    textSize(10);
    currentTime = (millis()/1000);
    displayTime = currentTime - startTime;
    text("TIME: " + displayTime, x, y);
    text("SCORE: " +score, x, y-20);
  }

  /**
  *  Displays the commands to reset or quit
  */
  void displayCommands(float x, float y) {
    fill(255);
    textSize(10);
    text("TO RESET GAME, PRESS 'R'", x, y);
  }

  /**
  * display the fading text on the screen
  */
  void displayFadingText(String s, float x, float y) {
    fill(255, 255, 255, count--);
    textSize(25);//slightly larger text size
    text(s, x, y);
  }

  /**
  *  checks to see if timer is up
  */
  void checkTimer() {
    if (displayTime >= timer) {
      endGame();
    }
  }

  /**
  * when timer goes up this will be displayed
  */
  void endGame() {
    background(0, 153, 37);

    fill(255);
    textSize(68);
    text("GAME OVER!", width/2 - 310, 70);
    textSize(45);
    text("SCORE: " + score, width/2 - 240, height/2+30);
    textSize(20);
    text("DO YOU WANT TO PLAY AGAIN(Y/N)", width/2 - 260, height/2 + 200);

    if (keyPressed && key=='y') {
      reset();
    }
    else if (keyPressed && key=='n') {
      exit();
    }
  }
}

