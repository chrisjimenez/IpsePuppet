/************************************************
*  Scan.pde
*  IpsePuppet project
*  By Chris Jimenez
*  
*************************************************/

class Scan {
  //  create selecting rectangle objects
  SelectingRectangle head = new SelectingRectangle("head", width/2, 20, 45, 45);
  SelectingRectangle midsection = new SelectingRectangle("midsection", width/2, 100, 90, 160);
  SelectingRectangle leftArm = new SelectingRectangle("left arm", width/2 - 100, 100, 30, 100);
  SelectingRectangle rightArm = new SelectingRectangle("right arm", width/2+160, 100, 30, 100);
  SelectingRectangle leftLeg = new SelectingRectangle("left leg", width/2 - 100, 250, 40, 120);
  SelectingRectangle rightLeg = new SelectingRectangle("right leg", width/2 + 160, 250, 40, 120);

  // set up buttons for the scan
  PImage scanButtonImage;
  PImage scanButtonPressedImage;
  PImage continueButtonImage;
  PImage continueButtonPressedImage;
  PImage rescanButtonImage;
  PImage rescanButtonPressedImage;
  ImageButton scanButton;
  ImageButton continueButton;
  ImageButton rescanButton;

  /**
  *  CONSTRUCTOR
  */
  Scan() {
    
    // scan button
    scanButtonImage = loadImage("scanbutton.png");
    scanButtonPressedImage = loadImage("scanbutton-pressed.png");
    scanButton = new ImageButton(scanButtonImage, scanButtonPressedImage);
    scanButton.resizeButton(100, 57);

    // continue button
    continueButtonImage = loadImage("continuebutton.png");
    continueButtonPressedImage = loadImage("continuebutton-pressed.png");
    continueButton = new ImageButton(continueButtonImage, continueButtonPressedImage);
    continueButton.resizeButton(100, 57);

    // rescan button
    rescanButtonImage = loadImage("rescanbutton.png");
    rescanButtonPressedImage = loadImage("rescanbutton-pressed.png");
    rescanButton = new ImageButton(rescanButtonImage, rescanButtonPressedImage);
    rescanButton.resizeButton(100, 57);
  }


  /**
  *  Starts teh scan when it's called.
  */
  void startScan() {
    if (scan) {
      // tell kienct ot stop tracking the user
      tracking = false;

      // display image to user and ask if they like
      image(userImage, 0, 0);
      // display continue and rescan button
      rescanButton.display(width - 110, 10);
      continueButton.display(width - 110, height - 67);

      // if user clicks continue, go to next state else rescan
      if (continueButton.isPressed() && mousePressed) {
        createPuppet();
        state++;
      }

      head.display();
      midsection.display();
      leftArm.display();
      rightArm.display();
      leftLeg.display();
      rightLeg.display();

      if (rescanButton.isPressed() && mousePressed) scan = false;
    } else {
      // update the pixel from the inner array to image
      userImage.updatePixels();
      image(userImage, 0, 0);

      scanButton.display(10, height - 67);
      // if scan button is pressed, take scan
      if (scanButton.isPressed() && mousePressed) scan = true;
    }

    if (tracking) {
      // ask kinect for bitmap of user pixels
      userImage.loadPixels();
      userMap = kinect.userMap();
      for (int i =0; i < userMap.length; i++) {
        // if the pixel is part of the user
        if (userMap[i] != 0) {
          // set the pixel to the color pixel
          userImage.pixels[i] = kinect.rgbImage().pixels[i];
        } else {//otherwise its green
          userImage.pixels[i] = color(0, 255, 0, 255);
        }
      }
    }
  }


  /**
  *  Creates the actual puppet.
  */
  void createPuppet() {
    PImage headImage = cropScan(head);
    PImage midSectionImage = cropScan(midsection);
    PImage leftArmImage = cropScan(leftArm);
    PImage rightArmImage = cropScan(rightArm);
    PImage leftLegImage = cropScan(leftLeg);
    PImage rightLegImage = cropScan(rightLeg);

    puppet = new Puppet(headImage, midSectionImage, leftArmImage, 
    rightArmImage, leftLegImage, rightLegImage);
  }

  /**
  * returns the cropped scan based on rectangles location
  */
  PImage cropScan(SelectingRectangle sr) {
    PImage croppedImage = new PImage(sr.rectWidth, sr.rectHeight);
    croppedImage.loadPixels();
    userImage.loadPixels();
    
    // initilize location of x,y position of section
    int location = sr.xPos + sr.yPos * width;

    for (int i = 0; i < sr.rectWidth; i++) {//for eahc pixel in the row
      for (int j = 0; j < sr.rectHeight; j++) {//for each row of section
        croppedImage.pixels[i+ j*sr.rectWidth] = userImage.pixels[location + i + j*width];
      }
    }
    croppedImage.updatePixels();

    return croppedImage;
  }
}

