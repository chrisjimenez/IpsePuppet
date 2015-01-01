class Puppet {
  float xPos;
  float yPos;

  PImage headImage;
  PImage midsectionImage;
  PImage leftArmImage;
  PImage rightArmImage;
  PImage leftLegImage;
  PImage rightLegImage;

  FBox head, midsection, leftArm, rightArm, leftLeg, rightLeg;

  //constructor for image puppet
  Puppet(PImage h, PImage m, PImage la, PImage ra, PImage ll, PImage rl) {
    headImage = h;
    midsectionImage = m;
    leftArmImage = la;
    rightArmImage = ra;
    leftLegImage = ll;
    rightLegImage = rl;

    setupImagePuppet();
    setupGamePuppet();
  }

  //===========================================================
  //second constructor to create generic puppet
  Puppet() {
    setupGenericPuppet();
  }

  //=============================================================================
  // create generic puppet
  void setupGenericPuppet() {
    xPos = width/2 - 22;
    yPos = height/2- 40;

    //head
    head = new FBox(45, 45);
    head.setPosition(xPos, yPos);
    head.setStroke(255, 0, 0);

    //midsection
    midsection = new FBox(90, 160);
    midsection.setStroke(255, 0, 0);
    midsection.setPosition(xPos - 45, yPos +90);

    //left arm
    leftArm = new FBox(30, 100);
    leftArm.setStroke(255, 0, 0);
    leftArm.setPosition(xPos - 15, yPos +90);

    //right arm
    rightArm = new FBox(30, 100);
    rightArm.setStroke(255, 0, 0);
    rightArm.setPosition(xPos +60, yPos +90);

    //left leg
    leftLeg = new FBox(40, 120);
    leftLeg.setStroke(255, 0, 0);

    //right leg
    rightLeg = new FBox(40, 120);
    rightLeg.setStroke(255, 0, 0);

    //joint between head and midsection
    FDistanceJoint jointHeadToMidsection = new FDistanceJoint(head, midsection);
    jointHeadToMidsection.setLength(0);
    jointHeadToMidsection.setAnchor1(0, head.getHeight()/2);
    jointHeadToMidsection.setAnchor2(0, -1*midsection.getHeight()/2);

    //joint between left arm and midsection
    FDistanceJoint jointLeftArmAndMidsection = new FDistanceJoint(leftArm, midsection) ;
    jointLeftArmAndMidsection.setLength(0);
    jointLeftArmAndMidsection.setAnchor1(leftArm.getWidth()/2, -1*leftArm.getHeight()/2);
    jointLeftArmAndMidsection.setAnchor2(-1*midsection.getWidth()/2, -1*midsection.getHeight()/2);

    //joint between right arm and midsection
    FDistanceJoint jointRightArmAndMidsection = new FDistanceJoint(rightArm, midsection) ;
    jointRightArmAndMidsection.setLength(0);
    jointRightArmAndMidsection.setAnchor1(-1*rightArm.getWidth()/2, -1*rightArm.getHeight()/2);
    jointRightArmAndMidsection.setAnchor2(midsection.getWidth()/2, -1*midsection.getHeight()/2);

    //joint between left leg and midsection
    FDistanceJoint jointLeftLegAndMidsection = new FDistanceJoint(leftLeg, midsection);
    jointLeftLegAndMidsection.setLength(0);
    jointLeftLegAndMidsection.setAnchor1(-1*leftLeg.getWidth()/2, -1*leftLeg.getHeight()/2);
    jointLeftLegAndMidsection.setAnchor2(-1*midsection.getWidth()/2, midsection.getHeight()/2);

    //joint between right leg and midsection
    FDistanceJoint jointRightLegAndMidsection = new FDistanceJoint(rightLeg, midsection);
    jointRightLegAndMidsection.setLength(0);
    jointRightLegAndMidsection.setAnchor1(rightLeg.getWidth()/2, -1*rightLeg.getHeight()/2);
    jointRightLegAndMidsection.setAnchor2(midsection.getWidth()/2, midsection.getHeight()/2);

    //add puppet bodies ot the fisica world
    menuWorld.add(head);
    menuWorld.add(midsection);
    menuWorld.add(leftArm);
    menuWorld.add(rightArm);
    menuWorld.add(leftLeg);
    menuWorld.add(rightLeg);

    //Construct a revolute joint between two bodies given an anchor position.
    menuWorld.add(jointHeadToMidsection);
    menuWorld.add(jointLeftArmAndMidsection);
    menuWorld.add(jointRightArmAndMidsection);
    menuWorld.add(jointLeftLegAndMidsection);
    menuWorld.add(jointRightLegAndMidsection);
  }

  //==============================================================================
  //set up the puppet with image of seclected body part images
  void setupImagePuppet() {
    xPos = width/2 - headImage.width/2;
    yPos = height/2 - 40;

    removeGreenBackground(headImage);

    //head
    head = new FBox(headImage.width, headImage.height);
    head.setPosition(xPos, yPos);
    head.attachImage(headImage);

    //midsection
    midsection = new FBox(midsectionImage.width, midsectionImage.height);
    midsection.setPosition(xPos - midsectionImage.width/2, yPos +headImage.height);
    midsection.setImageAlpha(0);
    midsection.setNoStroke();

    //left arm
    leftArm = new FBox(leftArmImage.width, leftArmImage.height);
    leftArm.setPosition(xPos - midsectionImage.width/2 - leftArmImage.width, yPos +headImage.height);
    leftArm.setImageAlpha(0);
    leftArm.setNoStroke();

    //right arm
    rightArm = new FBox(rightArmImage.width, rightArmImage.height);
    rightArm.setPosition(xPos + midsectionImage.width/2 + leftArmImage.width, yPos +headImage.height);
    rightArm.setImageAlpha(0);
    rightArm.setNoStroke();

    //left leg
    leftLeg = new FBox(leftLegImage.width, leftLegImage.height);
    leftLeg.setPosition(xPos - midsectionImage.width/2, yPos +headImage.height+midsectionImage.height);
    leftLeg.setImageAlpha(0);
    leftLeg.setNoStroke();

    //right leg
    rightLeg = new FBox(rightLegImage.width, rightLegImage.height);
    rightLeg.setPosition(xPos - midsectionImage.width/2, yPos +headImage.height+midsectionImage.height);
    rightLeg.setImageAlpha(0);
    rightLeg.setNoStroke();

    //joint between head and midsection
    FDistanceJoint jointHeadToMidsection = new FDistanceJoint(head, midsection);
    jointHeadToMidsection.setLength(0);
    jointHeadToMidsection.setAnchor1(0, head.getHeight()/2);
    jointHeadToMidsection.setAnchor2(0, -1*midsection.getHeight()/2);

    //joint between left arm and midsection
    FDistanceJoint jointLeftArmAndMidsection = new FDistanceJoint(leftArm, midsection) ;
    jointLeftArmAndMidsection.setLength(0);
    jointLeftArmAndMidsection.setAnchor1(leftArm.getWidth()/2, -1*leftArm.getHeight()/2);
    jointLeftArmAndMidsection.setAnchor2(-1*midsection.getWidth()/2, -1*midsection.getHeight()/2);

    //joint between right arm and midsection
    FDistanceJoint jointRightArmAndMidsection = new FDistanceJoint(rightArm, midsection) ;
    jointRightArmAndMidsection.setLength(0);
    jointRightArmAndMidsection.setAnchor1(-1*rightArm.getWidth()/2, -1*rightArm.getHeight()/2);
    jointRightArmAndMidsection.setAnchor2(midsection.getWidth()/2, -1*midsection.getHeight()/2);

    //joint between left leg and midsection
    FDistanceJoint jointLeftLegAndMidsection = new FDistanceJoint(leftLeg, midsection);
    jointLeftLegAndMidsection.setLength(0);
    jointLeftLegAndMidsection.setAnchor1(-1*leftLeg.getWidth()/2, -1*leftLeg.getHeight()/2);
    jointLeftLegAndMidsection.setAnchor2(-1*midsection.getWidth()/2, midsection.getHeight()/2);

    //joint between right leg and midsection
    FDistanceJoint jointRightLegAndMidsection = new FDistanceJoint(rightLeg, midsection);
    jointRightLegAndMidsection.setLength(0);
    jointRightLegAndMidsection.setAnchor1(rightLeg.getWidth()/2, -1*rightLeg.getHeight()/2);
    jointRightLegAndMidsection.setAnchor2(midsection.getWidth()/2, midsection.getHeight()/2);

    //add puppet bodies ot the fisica world
    world.add(head);
    world.add(midsection);
    world.add(leftArm);
    world.add(rightArm);
    world.add(leftLeg);
    world.add(rightLeg);

    //Construct a revolute joint between two bodies given an anchor position.
    world.add(jointHeadToMidsection);
    world.add(jointLeftArmAndMidsection);
    world.add(jointRightArmAndMidsection);
    world.add(jointLeftLegAndMidsection);
    world.add(jointRightLegAndMidsection);
  }

  //============================================
  // creates the 8 bit image of the given image on the
  // fisica box
  void createCubes(FBox box, PImage image) {
    int step = 3;
    int boxDepth = 40;

    pushMatrix();
    translate(box.getX(), box.getY(), 0);

    //rotate all boxes
    rotate(box.getRotation());

    for (int x = 0; x < image.width; x+=step) {
      for (int y = 0; y < image.height; y+=step) {
        int location = x + y*image.width;
        color temp = image.pixels[ location ];
        pushMatrix();
        //noStroke();
        translate((x-box.getWidth()/2), (y-box.getHeight()/2), 0);
        if (green(temp) == 255) {
          fill(255, 255, 255, 255);
          box(step, step, boxDepth);
        }
        else {
          fill(temp);
          box(step, step, boxDepth);
        }
        popMatrix();
      }
    }

    popMatrix();
  }
  
  
  
  void setupGamePuppet(){
    
    
  }

  //=========================================================
  void display() {
    createCubes(midsection, midsectionImage);
    createCubes(leftArm, leftArmImage);
    createCubes(rightArm, rightArmImage);
    createCubes(leftLeg, leftLegImage);
    createCubes(rightLeg, rightLegImage);
  }

  //removes green background of user body images
  void removeGreenBackground(PImage i) {

    i.loadPixels();
    for (int x = 0; x < i.width; x++) {
      for (int y = 0; y < i.height; y++) {

        int location = x+ y*i.width;
        color temp = i.pixels[location];

        if (green(temp) == 255) {
          i.pixels[location] = color(255, 255, 255);
        }
      }
    }
    i.updatePixels();
  }
}

