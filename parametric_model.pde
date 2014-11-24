import joons.JoonsRenderer;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

import nervoussystem.obj.*;

float dia=300;
APoint[] firstPoints;
Shape firstShape; 
Tower tower;

PeasyCam cam;
int workArea = 10000;

boolean floorDraw = true;
boolean sideDraw = true;
boolean bottomDraw = true;
boolean backDraw = true;
boolean topDraw = true;
boolean frontDraw = true;
boolean reflectionPaneDraw = true;
PImage grid;

JoonsRenderer jr;

CameraState initState;

boolean record = false;

void setup(){
  //size(1920,1000, OPENGL);
  size(1366/2,766, P3D);
  
  firstPoints=new APoint[8];  
  for (int i=0; i<firstPoints.length; i++) {
    float ang = i*TWO_PI/8;             
    firstPoints[i]= new APoint(i);  
  }     
    
  cam = new PeasyCam(this, 100);  
  
  cam.rotateX(3*PI/2);
  cam.pan(850,-250);
  cam.setDistance(500);
  
  jr = new JoonsRenderer(this);
  jr.setSizeMultiplier(2); //Set size of PNG file
  
  initState = cam.getState();
    
  firstShape = new Shape(firstPoints);
  tower = new Tower(firstShape);
}

void draw() {
  //cam.setState(new CameraState(new Rotation(), new Vector3D(0,0,0), (double) 500));    

  stroke(0);
  background(255);  
  jr.beginRecord();
    //jr.background("gi_instant")  ;
    //jr.background("gi_ambient_occlusion", 206, 12, 250, 80,80,80, 3384, 303);
    jr.background("gi_ambient_occlusion");
    pushMatrix();
      tower.draw(); 
      //jr.background("cornell_box", 5000, 5000, 5000); //Cornell Box: width, height, depth.
    popMatrix();  
    pushMatrix();
      rotateX(PI);
      specular(255, 255, 78);
      drawAxis(50);             
      //jr.fill("diffuse", 150, 255, 255);
      //jr.fill("ambient_occlusion", 150, 255, 255, 0, 0, 255, 50, 16);
      drawBox();        
      noFill();
    popMatrix();
    lightning();    
  jr.endRecord();  
noFill();  
}

void lightning(){
  pushMatrix();
    jr.fill("light", 95, 121, 121);
    translate(1969,497,2316);
    rotateX(11*PI/6);  
    box(2127,748,5);
  popMatrix();
    
  pushMatrix();
    jr.fill("light", 82, 75, 77);
    translate(764,459,2431);
    rotateX(11*PI/6);  
    box(2127,748,5);
  popMatrix();
  
  pushMatrix();     
    translate(691,-598,505);
    sphere(63);
  popMatrix();
}
void reflectionPane(){
  if (reflectionPaneDraw) {
    pushMatrix();
    
    popMatrix();
  }
}

void drawAxis(int l) {  
  stroke(255,0,0);
  pushMatrix();
    translate(450,250,-80);
    line(0,0,0,l,0,0);
    stroke(0,255,0);
    line(0,0,0,0,l,0);
    stroke(0,0,255);
    line(0,0,0,0,0,l);
  popMatrix();
  noStroke();
}

void keyPressed() {
  if (key == 'a') floorDraw=!floorDraw;
  if (key == 'z') frontDraw=!frontDraw;
  if (key == 'e') sideDraw=!sideDraw;  
  if (key == 'r') bottomDraw=!bottomDraw;  
  if (key == 't') backDraw=!backDraw;
  if (key == 'y') topDraw=!topDraw;    
  if (key == '5') cam.setDistance(cam.getDistance()+85);    
  if (key == '0') cam.setDistance(cam.getDistance()-85);  
  if (key == ' ') jr.render(); //Press SPACE key to start rendering.
  if (key == '8') cam.pan(0,-7);
  if (key == '2') cam.pan(0,7);
  if (key == '4') cam.pan(-7,0);
  if (key == '6') cam.pan(7,0);
   
  if (key == '.') camReset();  
    
  if (key == CODED) {
    if (keyCode == UP) cam.pan(0,-7);
    if (keyCode == DOWN) cam.pan(0,7);
    if (keyCode == LEFT) cam.pan(-7,0);
    if (keyCode == RIGHT) cam.pan(7,0);
  }
  
  if (key == 'n') {
    record = true;
  }
}

void camReset() {
  println("cam reset");
  cam.setState(initState);
  cam.setDistance(500); 
}
