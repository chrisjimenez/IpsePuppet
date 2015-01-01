//Created by Chris Jimenezo
//Interactive Computing Final Project
//Driver class that will start the program
//Last edit: 12-10-13
import processing.opengl.*; 
import SimpleOpenNI.*;
import fisica.util.nonconvex.*;
import fisica.*;
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//set up kinect
SimpleOpenNI  kinect;

//adjust size of canvas with the width(w) variable
//height will be adjusted based on width (4:3)
int w = 640;
int h = (int)(0.75 * w);

//set up start button
PImage startButtonImage;
PImage startButtonPressedImage;
ImageButton startButton;

//set up play button
PImage playButtonImage;
PImage playButtonPressedImage;
ImageButton playButton;

//load up unique font 
PFont font;

//user image
PImage userImage;

//To scan and extract the user
int[] userMap;
int userID;

boolean tracking = false; 
boolean scan;

//hit osund when bat hits puppet
Minim minim;
AudioPlayer hitSound;

//Game object for gameplay in fourth state
Scan scanner;

//puppet
Puppet mainPagePuppet;
Puppet puppet;

//set up fisica world
FWorld world;
FWorld menuWorld;

Game game;

int state = 0;//if state = 0, we are at menu state
//if state = 1, we are at the scanning state
//if state = 2, we are at the home state
//if state = 3, we are at the game state

//=============================================================================
// setup() method...
void setup() {
  size(w, h, P3D);

  kinect = new SimpleOpenNI(this);

  if (kinect.isInit() == false) {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  //load hti sound file
  minim = new Minim(this);
  hitSound = minim.loadFile("hit.mp3");

  // enable depthMap, RGB & User
  kinect.enableDepth();
  kinect.enableUser();
  kinect.enableRGB();  
  // turn on depth/color alignment
  kinect.alternativeViewPointDepthToImage();

  //image of the user with the background subtracted,
  //which will be used for the puppet
  userImage = new PImage(width, height, RGB);

  //unique font used for program
  font = loadFont("8BITWONDERNominal-48.vlw");
  textFont(font);

  //button images
  startButtonImage = loadImage("startbutton.png");
  startButtonPressedImage = loadImage("startbutton-pressed.png");
  startButton = new ImageButton(startButtonImage, startButtonPressedImage);
  startButton.resizeButton(100, 57);

  //set up play button
  playButtonImage = loadImage("playbutton.png");
  playButtonPressedImage = loadImage("playbutton-pressed.png");
  playButton = new ImageButton(playButtonImage, playButtonPressedImage);
  playButton.resizeButton(100, 57);

  //create new scan option for scanning state
  scanner = new Scan();

  //set up fisica world
  setupFisicaWorld();

  mainPagePuppet = new Puppet();

  //frameRate MUST be 30, otherwise it wont work
  frameRate(30);
  smooth();
}


//=============================================================================
// draw() method...
void draw() {
  background(0);
  //update kinect
  kinect.update();

  if ( state == 0) menu();
  else if ( state == 1) scanner.startScan();
  else if ( state == 2) home();
  else if ( state == 3) game();
}//===========================================================================

//============================================================================
// menu state which the program opens up to, if user wants to initiate scan
// they will have the option to do so
void menu() {
  background(51, 105, 232);

  menuWorld.step();
  menuWorld.draw();

  //display title
  textSize(60);
  fill(255, 0, 0);
  text("IPSEPUPPET", width/2- 283, 120+3);
  fill(255, 255, 255);
  text("IPSEPUPPET", width/2 - 280, 120);

  //display start button
  startButton.display(width/2 - 60, height - 100); 
  if (startButton.isPressed() && mousePressed) state++;
}//==========================================================================

//============================================================================
// home state which allows the user to practice playing nad manipulating their
// puppet. They will have the option to play a game with their puppet
void home() {
  background(238, 178, 17);
  world.step();
  world.draw();

  puppet.display();

  //display play button
  playButton.display(width - 110, 10);
  if (playButton.isPressed() && mousePressed) { 
    game = new Game();
    state++;
  }
}
//============================================================================

//============================================================================
// game state which asks the user will a play a game with their puppet game TBD
void game() {
  game.playGame();
}//=========================================================================

//==========================================================================
//the foloowing methods are needed for the execution of the program..
void onNewUser(SimpleOpenNI curContext, int userId) {
  userID = userId;
  tracking = true;
  println("tracking");
  curContext.startTrackingSkeleton(userId);
}

void setupFisicaWorld() {
  // init the world with a reference to our canvas
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, 400);
  world.setEdges();

  menuWorld = new FWorld();
  menuWorld.setGravity(0, 400);
  menuWorld.setEdges();
}

//============================================================================
// stop() method.....
void stop() {
  super.stop();
}

