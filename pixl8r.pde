//needs opengl for transform
import processing.opengl.*;

//change this if you want
int gridStep = 10;

//setup
PImage img;
color moduleColor = color(0);
int max_distance = screen.width; 
int  spotX = mouseX;
int  spotY = mouseY;

//default settings
boolean holdSpot = false;
int bgcolor = 0;
boolean invertSize = true;

void setup(){
  img = loadImage("blgnmn.jpg"); 
  size(img.width, img.height, OPENGL);
  noStroke();
  noCursor();
}

void draw() {
  background(bgcolor);
  smooth();

  //update focal point (if using mouse)
  if(holdSpot == false) {
    spotX = mouseX;
    spotY = mouseY;
    noCursor();
  }

  
  // loop grid
  for (int gridY=0; gridY<img.height; gridY+=gridStep) {
    for (int gridX=0; gridX<img.width; gridX+=gridStep) {
      //set fill to image color at grid position
      fill(img.get(gridX, gridY));
      
      //set diameter based on distance
      float diameter = dist(spotX, spotY, gridX, gridY); // extra math in invert mode :(
      if(invertSize == true){//overwrite diameter if in invert mode
        diameter = max_distance - dist(spotX, spotY, gridX, gridY);
      }
      //set diameter to 
      diameter = diameter/max_distance * gridStep;//consider using 40 rather than gridStep for small grids
      
      pushMatrix();
      translate(gridX, gridY, diameter*5);
      rect(0, 0, diameter, diameter);    //ellipse looks cool too
      popMatrix(); 
    }
  }
}

//set focal point to mouse position when clicked (if using mouse)
void mousePressed() {
  if(holdSpot) {
    cursor();
    spotX = mouseX;
    spotY = mouseY;
  }
}


//keyboard
void keyReleased(){
  if (key=='s' || key=='S') saveFrame("out/"+timestamp()+"_##.png");

  if (key == '1') img = loadImage("fb.jpg");
  if (key == '2') img = loadImage("galaxy.jpg"); 
  if (key == '3') img = loadImage("grass.jpg"); 
  if (key == '3') img = loadImage("lion.jpg"); 
  if (key == '4') img = loadImage("mtfuji.jpg"); 
  
  if (key == '5') gridStep =  10;
  if (key == '6') gridStep =  30;
  if (key == '7') gridStep =  50;
  if (key == '8') gridStep =  70;
  if (key == '9') gridStep =  90;
  
  if (key == '0') {
    if (holdSpot == false) { holdSpot = true; }
    else { holdSpot = false;}
  }
  
  if (key == '[') {
    if (invertSize == false) { invertSize = true; }
    else { invertSize = false;}
  }
  
  if (key == ']') {
    if (bgcolor==255){bgcolor = 0;}
    else { bgcolor = 255; }
  }
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}



