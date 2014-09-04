import joons.JoonsRenderer;

import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
static int workArea = 1000;

boolean floorDraw = true;
boolean sideDraw = true;
boolean bottomDraw = true;
boolean backDraw = true;
boolean topDraw = true;
PImage grid;

JoonsRenderer jr;

CameraState initState;
//CameraState(Rotation rotation, Vector3D center, double distance) 
//setState(CameraState state)

void setup(){
  //size(1920,1000, OPENGL);
  size(1366/2,766, OPENGL);
  cam = new PeasyCam(this, 100);  
  grid = loadImage("grid.png");
  
  cam.rotateX(3*PI/2);
  cam.pan(850,-250);
  cam.setDistance(500);
  
  jr = new JoonsRenderer(this);
  
  initState = cam.getState();
}

void draw() {
  //cam.setState(new CameraState(new Rotation(), new Vector3D(0,0,0), (double) 500));
  
  int woodThickness = 13;
  int verticalHeight = 721;
  int depth = 300;
  int screenWidth = 693;
  int frontExtrude = 48;
  stroke(0);
  background(0);  
  jr.beginRecord();
  pushMatrix();
    //translate();
    jr.background("cornell_box", 400000,40000,4000);
    //jr.background("gi_instant");
  popMatrix();  
  pushMatrix();
    rotateX(PI);
    specular(255, 255, 255);
    drawAxis(50);  
    drawFloor(workArea, 0);
    //jr.fill("diffuse", 150, 255, 255);
    //jr.fill("ambient_occlusion", 150, 255, 255, 0, 0, 255, 50, 16); 
    if (bottomDraw) bottomBoard(woodThickness, screenWidth, depth, frontExtrude, #FFFFFF);
    if (sideDraw) verticalSide(woodThickness, depth, verticalHeight, #FFFFFF);
    pushMatrix();
      translate(+screenWidth-woodThickness,0,0);
      if (sideDraw) verticalSide(woodThickness, depth, verticalHeight, #FFFFFF);
    popMatrix();
    if (backDraw) backFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF);    
    stroke(0);
    if (topDraw) topFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF); 
  popMatrix();
noFill();  
}

void topFace(int wt, int sw, int vh, int d, int s){
  stroke(s);
  fill(s+#444444);
 /* beginShape();
    vertex(500+sw, 500+d, -vh-wt);
    vertex(500, 500+d, -vh-wt);
    vertex(500, 500,-vh-wt);
    vertex(500+sw, 500, -vh-wt);
  endShape();*/
  pushMatrix();
    translate(847, 650,-vh+-6.5-wt);
    box(sw, d, -wt);
  popMatrix();  
}

void backFace(int wt, int sw, int vh, int d, int s) {
  stroke(s);
  fill(s+#555555);
  //back board, outer face
  beginShape();
    vertex(500+wt,500+d,-wt);
    vertex(500+wt,500+d,-wt-vh);
    vertex(500+sw-wt,500+d, -wt-vh);
    vertex(500+sw-wt,500+d,-wt);
  endShape();
  //back board, inner face
  pushMatrix();
    translate(0,-wt,0);
    beginShape();
    vertex(500+wt,500+d,-wt);
    vertex(500+wt,500+d,-wt-vh);
    vertex(500+sw-wt,500+d, -wt-vh);
    vertex(500+sw-wt,500+d,-wt);    
    endShape();
  popMatrix();
  //backboard, top face
  beginShape();
    vertex(500+sw-wt,500+d,-wt-vh);
    vertex(500+wt,500+d,-wt-vh);
    vertex(500+wt,500+d-wt,-wt-vh);
    vertex(500+sw-wt,500+d-wt,-wt-vh);  
  endShape();
  
  //backboard, bottom face  
  beginShape();
    vertex(500+sw-wt,500+d,-wt);
    vertex(500+wt,500+d,-wt);
    vertex(500+wt,500+d-wt,-wt);
    vertex(500+sw-wt,500+d-wt,-wt);  
  endShape();  
    
 //back board, right face
  beginShape();
    vertex(500+wt, 500+d, -wt-vh);
    vertex(500+wt,500+d-wt, -wt-vh);
    vertex(500+wt,500+d-wt, -wt);
    vertex(500+wt, 500+d, -wt);
  endShape();
  
 //back board, left face
  beginShape();
    vertex(500+sw-wt, 500+d, -wt-vh);
    vertex(500+sw-wt,500+d-wt, -wt-vh);
    vertex(500+sw-wt,500+d-wt, -wt);
    vertex(500+sw-wt, 500+d, -wt);
  endShape();
    
  /*
  //back board, left face
  beginShape();
    vertex(500+wt, 500+d, -wt-vh);
    vertex(500+wt,500+d-wt, -wt);
    vertex(500+wt,500+d-wt, -wt);
    vertex(500+wt, 500+d, -wt-vh);
  endShape();
  */
}

void verticalSide(int wt, int d, int vh, int s) {
  stroke(s);
  fill(s+#555555);  
  //vertical right board, outer face
   beginShape();
     vertex(500,500,-wt);
     vertex(500, 500+d,-wt);
     vertex(500, 500+d, -vh-wt);
     vertex(500, 500,-vh-wt);
   endShape();
   //vertical right board, inner face
   pushMatrix();
   translate(wt, 0, 0);
     beginShape();
       vertex(500,500,-wt);
       vertex(500, 500+d,-wt);
       vertex(500, 500+d, -vh-wt);
       vertex(500, 500,-vh-wt);
     endShape();  
   popMatrix();
   //vertical right board, front face
   beginShape();    
     vertex(500,500,-wt);
     vertex(500+wt,500,-wt);
     vertex(500+wt,500,-vh-wt);  
     vertex(500,500,-vh-wt);
   endShape();
  //vertical right board, back face
  pushMatrix();
    translate(0,d,0);
    beginShape();       
      vertex(500,500,-wt);
      vertex(500+wt,500,-wt);
      vertex(500+wt,500,-vh-wt);  
      vertex(500,500,-vh-wt);
    endShape();
  popMatrix();
    
  //vertical right board, bottom face
  beginShape();    
    vertex(500,500+d, -wt);
    vertex(500+wt,500+d, -wt);   
    vertex(500+wt,500, -wt);  
    vertex(500,500, -wt);  
  endShape();
 
  //vertical right board, top face
  pushMatrix();
    translate(0,0,-vh);
    beginShape();      
      vertex(500,500+d, -wt);
      vertex(500+wt,500+d, -wt);   
      vertex(500+wt,500, -wt);  
      vertex(500,500, -wt);  
    endShape();
  popMatrix();    
}

void bottomBoard(int wt, int sw, int d, int fe, int s) {  
  stroke(s);
  fill(s+#555555);
  beginShape();
    //front board, lower face
    vertex(500, 50+fe, 0);
    vertex(500+sw, 250+fe, 0);  
    vertex(500+sw, 500+d, 0);
    vertex(500, 500+d, 0);  
  endShape();
  pushMatrix();
    translate(0, 0, -wt);
    beginShape();
      //bottom board, upper face
      vertex(500, 50+fe, 0);
      vertex(500+sw, 250+fe, 0);  
      vertex(500+sw, 500+d, 0);
      vertex(500, 500+d, 0);  
    endShape();
  popMatrix();
  //bottom board, front face
  beginShape();
    vertex(500,50+fe,0);
    vertex(500+sw,250+fe,0);
    vertex(500+sw,250+fe,-wt);
    vertex(500,50+fe,-wt);
  endShape();    
  //bottom board, right face    
  beginShape();
    vertex(500+sw, 250+fe, 0);
    vertex(500+sw, 500+d, 0);  
    vertex(500+sw, 500+d, -wt);
    vertex(500+sw, 250+fe, -wt);
  endShape();
  //bottom board, back face
  beginShape();
    vertex(500+sw, 500+d, 0);
    vertex(500, 500+d, 0);
    vertex(500, 500+d, -wt);
    vertex(500+sw, 500+d, -wt);
  endShape();
  //bottom board, left face
  beginShape();
    vertex(500, 500+d, 0);
    vertex(500, 50+fe, 0);
    vertex(500, 50+fe, -wt);
    vertex(500, 500+d, -wt);
  endShape();  
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

void drawFloor(int l, int h){
  if (floorDraw){
    fill(255);
    pushMatrix();
    rotateX(6*PI/4);
      beginShape();
        texture(grid);
        vertex(0, h, 0, 0, 0);
        vertex(2*l, h, 0,800 ,0 );
        vertex(2*l, h, 2*l, 800, 800);
        vertex(0, h, 2*l, 0, 800);
      endShape();
    popMatrix();
  }
}

void keyPressed() {
  if (key == 'f') floorDraw=!floorDraw;  
  if (key == 's') sideDraw=!sideDraw;  
  if (key == 'b') bottomDraw=!bottomDraw;  
  if (key == 'a') backDraw=!backDraw;
  if (key == 't') topDraw=!topDraw;    
  if (key == '5') cam.setDistance(cam.getDistance()+85);    
  if (key == '0') cam.setDistance(cam.getDistance()-85);  
  
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
}

void camReset() {
  println("cam reset");
  cam.setState(initState);
  cam.setDistance(500); 
}
