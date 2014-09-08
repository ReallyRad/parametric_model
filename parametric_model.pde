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
boolean frontDraw = true;
boolean reflectionPaneDraw = true;
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
  int woodThickness = 11;
  int verticalHeight = 822;
  int depth = 384;
  int screenWidth = 659;
  int frontExtrude = 48;
  stroke(0);
  background(0);  
  jr.beginRecord();
    //jr.background("cornell_box", 5000, 5000, 5000); //Cornell Box: width, height, depth.

  pushMatrix();
    //translate();    
    //jr.background("gi_instant");
  popMatrix();  
  pushMatrix();
    rotateX(PI);
    specular(255, 255, 78);
    drawAxis(50);  
    drawFloor(workArea, 0);
    jr.fill("diffuse", 50, 50, 50);
    //jr.fill("diffuse", 150, 255, 255);
    //jr.fill("ambient_occlusion", 150, 255, 255, 0, 0, 255, 50, 16);    
    bottomBoard(woodThickness, screenWidth, depth, frontExtrude, #ffffa3);    
    verticalSide(woodThickness, depth, verticalHeight, #0002b4);
    pushMatrix();
      translate(+screenWidth-woodThickness,0,0);
      verticalSide(woodThickness, depth, verticalHeight, #ffffc7);
    popMatrix();
    backFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF);     
    topFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF);
    frontDraw(woodThickness, screenWidth, verticalHeight);
    noFill();
  popMatrix();
  pushMatrix();
      jr.fill("light", 255, 255, 31);
    translate(934,0,268);
    sphere(31);
  popMatrix();
jr.endRecord();  
noFill();  
}

void reflectionPane(){
  if (reflectionPaneDraw) {
    pushMatrix();
    
    popMatrix();
  }
}

void frontDraw(int wt, int sw, int vh) {
    if (frontDraw) {  
      stroke(190);
      pushMatrix();
        translate(500+0.5*sw,507,-0.5*vh-wt);
        jr.fill("glass", 150, 255, 255, 0, 0, 255, 50, 16);     
        box(sw-wt*2,12,vh);
      popMatrix();
    }
}

void topFace(int wt, int sw, int vh, int d, int s){
  if (topDraw) {
    stroke(s);
    fill(s+#444444);
   /* beginShape(QUADS);
      vertex(500+sw, 500+d, -vh-wt);
      vertex(500, 500+d, -vh-wt);
      vertex(500, 500,-vh-wt);
      vertex(500+sw, 500, -vh-wt);
    endShape();*/
    pushMatrix();
      translate(500+0.5*sw, 0.5*d+500,-vh-1.5*wt);
      box(sw, d, wt);
    popMatrix();  
  }
}

void backFace(int wt, int sw, int vh, int d, int s) {
  if (backDraw) {
    stroke(s);
    fill(s+#555555);
    //back board, outer face
    beginShape(QUADS);
      vertex(500+wt,500+d,-wt);
      vertex(500+wt,500+d,-wt-vh);
      vertex(500+sw-wt,500+d, -wt-vh);
      vertex(500+sw-wt,500+d,-wt);
    endShape();
    //back board, inner face
    pushMatrix();
      translate(0,-wt,0);
      beginShape(QUADS);
      vertex(500+wt,500+d,-wt);
      vertex(500+wt,500+d,-wt-vh);
      vertex(500+sw-wt,500+d, -wt-vh);
      vertex(500+sw-wt,500+d,-wt);    
      endShape();
    popMatrix();
    //backboard, top face
    beginShape(QUADS);
      vertex(500+sw-wt,500+d,-wt-vh);
      vertex(500+wt,500+d,-wt-vh);
      vertex(500+wt,500+d-wt,-wt-vh);
      vertex(500+sw-wt,500+d-wt,-wt-vh);  
    endShape();
    
    //backboard, bottom face  
    beginShape(QUADS);
      vertex(500+sw-wt,500+d,-wt);
      vertex(500+wt,500+d,-wt);
      vertex(500+wt,500+d-wt,-wt);
      vertex(500+sw-wt,500+d-wt,-wt);  
    endShape();  
      
   //back board, right face
    beginShape(QUADS);
      vertex(500+wt, 500+d, -wt-vh);
      vertex(500+wt,500+d-wt, -wt-vh);
      vertex(500+wt,500+d-wt, -wt);
      vertex(500+wt, 500+d, -wt);
    endShape();
    
   //back board, left face
    beginShape(QUADS);
      vertex(500+sw-wt, 500+d, -wt-vh);
      vertex(500+sw-wt,500+d-wt, -wt-vh);
      vertex(500+sw-wt,500+d-wt, -wt);
      vertex(500+sw-wt, 500+d, -wt);
    endShape();
      
    /*
    //back board, left face
    beginShape(QUADS);
      vertex(500+wt, 500+d, -wt-vh);
      vertex(500+wt,500+d-wt, -wt);
      vertex(500+wt,500+d-wt, -wt);
      vertex(500+wt, 500+d, -wt-vh);
    endShape();
    */
  } 
}

void verticalSide(int wt, int d, int vh, int s) {
  if (sideDraw) {
    stroke(s);
    fill(s+#555555);  
    //vertical right board, outer face
     beginShape(QUADS);
       vertex(500,500,-wt);
       vertex(500, 500+d,-wt);
       vertex(500, 500+d, -vh-wt);
       vertex(500, 500,-vh-wt);
     endShape();
     //vertical right board, inner face
     pushMatrix();
     translate(wt, 0, 0);
       beginShape(QUADS);
         vertex(500,500,-wt);
         vertex(500, 500+d,-wt);
         vertex(500, 500+d, -vh-wt);
         vertex(500, 500,-vh-wt);
       endShape();  
     popMatrix();
     //vertical right board, front face
     beginShape(QUADS);    
       vertex(500,500,-wt);
       vertex(500+wt,500,-wt);
       vertex(500+wt,500,-vh-wt);  
       vertex(500,500,-vh-wt);
     endShape();
    //vertical right board, back face
    pushMatrix();
      translate(0,d,0);
      beginShape(QUADS);       
        vertex(500,500,-wt);
        vertex(500+wt,500,-wt);
        vertex(500+wt,500,-vh-wt);  
        vertex(500,500,-vh-wt);
      endShape();
    popMatrix();
      
    //vertical right board, bottom face
    beginShape(QUADS);    
      vertex(500,500+d, -wt);
      vertex(500+wt,500+d, -wt);   
      vertex(500+wt,500, -wt);  
      vertex(500,500, -wt);  
    endShape();
   
    //vertical right board, top face
    pushMatrix();
      translate(0,0,-vh);
      beginShape(QUADS);      
        vertex(500,500+d, -wt);
        vertex(500+wt,500+d, -wt);   
        vertex(500+wt,500, -wt);  
        vertex(500,500, -wt);  
      endShape();
    popMatrix();
  }  
}

void bottomBoard(int wt, int sw, int d, int fe, int s) {  
  if (bottomDraw) {  
    stroke(s);
    fill(s+#555555);
    beginShape(QUADS);
      //front board, lower face
      vertex(500, 50+fe, 0);
      vertex(500+sw, 250+fe, 0);  
      vertex(500+sw, 500+d, 0);
      vertex(500, 500+d, 0);  
    endShape();
    pushMatrix();
      translate(0, 0, -wt);
      beginShape(QUADS);
        //bottom board, upper face
        vertex(500, 50+fe, 0);
        vertex(500+sw, 250+fe, 0);  
        vertex(500+sw, 500+d, 0);
        vertex(500, 500+d, 0);  
      endShape();
    popMatrix();
    //bottom board, front face
    beginShape(QUADS);
      vertex(500,50+fe,0);
      vertex(500+sw,250+fe,0);
      vertex(500+sw,250+fe,-wt);
      vertex(500,50+fe,-wt);
    endShape();    
    //bottom board, right face    
    beginShape(QUADS);
      vertex(500+sw, 250+fe, 0);
      vertex(500+sw, 500+d, 0);  
      vertex(500+sw, 500+d, -wt);
      vertex(500+sw, 250+fe, -wt);
    endShape();
    //bottom board, back face
    beginShape(QUADS);
      vertex(500+sw, 500+d, 0);
      vertex(500, 500+d, 0);
      vertex(500, 500+d, -wt);
      vertex(500+sw, 500+d, -wt);
    endShape();
    //bottom board, left face
    beginShape(QUADS);
      vertex(500, 500+d, 0);
      vertex(500, 50+fe, 0);
      vertex(500, 50+fe, -wt);
      vertex(500, 500+d, -wt);
    endShape();
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

void drawFloor(int l, int h){
  if (floorDraw){
    fill(255);
    pushMatrix();
    rotateX(6*PI/4);
      beginShape(QUADS);
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
  if (key == 'a') floorDraw=!floorDraw;
  if (key == 'z') frontDraw=!frontDraw;
  if (key == 'e') sideDraw=!sideDraw;  
  if (key == 'r') bottomDraw=!bottomDraw;  
  if (key == 't') backDraw=!backDraw;
  if (key == 'y') topDraw=!topDraw;    
  if (key == '5') cam.setDistance(cam.getDistance()+85);    
  if (key == '0') cam.setDistance(cam.getDistance()-85);  
  if (key == ' ') jr.render(); //Press 'r' key to start rendering.
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
