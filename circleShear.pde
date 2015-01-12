//process to read image pixels from center to edge of image 
//then shear a circle of the pixels from the center to the edge 
//in a specified direction

PImage img;
String imgFileName = "TomasB";
String fileType = "png";

//control the direction that the pixel line is sourced from
//0 = up
//1 = down
//2 = left **NOT IMPLIMENTED
//3 = right **NOT IMPLIMENTED
//4 = angle **NOT IMPLIMENTED
int radiusDirection = 0;
int directionAngle = 0;

//control radius of inside circle 
//and offset from image edge to outside circle
int insideRadius = 0;
int outsideOffset = 220;

//control which edge the outside circle extends to
//0 = default (whichever edge is closest to centre)
//1 = top/bottom **NOT IMPLIMENTED
//2 = left/right **NOT IMPLIMENTED
int outsideEdge = 0;

//control circle style mode
//0 = Dense
//1 = Transparent
//2 = Echo
int circleMode = 0;

color c;
int pixelNum = insideRadius;

void setup(){
  img = loadImage(imgFileName+"."+fileType);
  size(img.width, img.height);
  image(img, 0, 0);
}

void draw(){
  int endPixel = lastPixel();
  while (pixelNum <= endPixel){
    img.loadPixels();
    c = pixelColor();
    drawCircle();
    //draw circles in the colour of each pixel
    img.updatePixels(); //this may be redundant?
    pixelNum++;
  }
  saveFrame(imgFileName+"_"+"CS"+"rd"+radiusDirection+"ir"+insideRadius+"oo"+outsideOffset+"oe"+outsideEdge+"cm"+circleMode+".png");
  image(img, 0, 0);
  System.exit(0);
}

void drawCircle(){
  noFill();
  stroke(c);
  ellipse((img.width / 2),(img.height / 2),(pixelNum*2),(pixelNum*2));
  switch(circleMode){
    case 0:
      ellipse((img.width / 2),(img.height / 2), ((pixelNum*2)-1) , ((pixelNum*2)-1) );
      break;
    case 1:
      break;
    case 2:
      ellipse((img.width / 2),(img.height / 2), pixelNum, pixelNum);
      println("here");
      break;
  }
}

int lastPixel(){ //Returns the radius of the largest circle to be drawn
  int endPixel = 0;
  switch(outsideEdge) {
    case 0:
      if (img.width >= img.height){
        endPixel = (img.height / 2) - outsideOffset;
      } else {
        endPixel = (img.width / 2) - outsideOffset;
      }
      break;
  }
  return endPixel;
}

color pixelColor(){
  int c = 0;
  switch(radiusDirection){
    case 0:
      c = img.pixels[ (img.width / 2) + ( ( (img.height / 2) - pixelNum ) * img.width ) ];
      break;
    case 1:
      c = img.pixels[ (img.width / 2) + ( ( (img.height / 2) + pixelNum ) * img.width ) ];
      break;
  }
  return c;
}



  
  
