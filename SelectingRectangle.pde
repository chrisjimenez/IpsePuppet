/************************************************
*  SelectingRectangle.pde
*  IpsePuppet project
*  By Chris Jimenez
*  
*************************************************/

class SelectingRectangle {
  int xPos;
  int yPos;
  int rectWidth;
  int rectHeight;

  int cornerX;
  int cornerY;
  int cornerWidth = 10;
  int cornerHeight = 10;

  String label;

  /**
  *  CONSTRUCTOR
  */
  SelectingRectangle(String s, int x, int y, int w, int h) {
    label = s;
    xPos = x;
    yPos = y;
    rectWidth = w;
    rectHeight = h;

    cornerX = x + rectWidth;
    cornerY = y + rectHeight;
  }

  /**
  *  Displays selecting triangle
  */
  void display() {
    stroke(255, 0, 0);
    strokeWeight(2);
    noFill();
    rect(xPos, yPos, rectWidth, rectHeight);

    fill(255);
    noStroke();
    rect(cornerX, cornerY, cornerWidth, cornerHeight);

    //display text
    textSize(map(rectWidth, 0, 100, 4, 15));
    fill(255, 0, 0);
    text(label, xPos + 5, yPos + rectHeight/2);

    drag();
  }


  /**
  *  Determines if the mouse is over the selected rectangle
  */
  boolean mouseOver(float x, float y, float w, float h) {
    if (((mouseX >= x) && (mouseX <= x+w)) &&
      ((mouseY >= y) && (mouseY <=y+h))) 
      return true;
    else 
      return false;
  }

  /**
  *  Drags selected rectangle
  */
  void drag() {
    int xDist = mouseX - pmouseX;
    int yDist = mouseY - pmouseY;

    if (mousePressed && mouseOver(xPos, yPos, rectWidth, rectHeight)) {    
      xPos+= xDist;
      yPos += yDist;
      cornerX += xDist;
      cornerY += yDist;
    }

    if (mousePressed && mouseOver(cornerX, cornerY, cornerWidth, cornerHeight)) {    
      rectWidth += xDist;
      rectHeight += yDist;
      cornerX += xDist;
      cornerY += yDist;
    }
  }
}

