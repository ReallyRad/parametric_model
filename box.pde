
void drawBox() {
  int woodThickness = 15;
  int verticalHeight = 830;
  int depth = 352;
  int screenWidth = 932;
  int frontExtrude = -204;
  //jr.fill("diffuse", 50, 50, 50);
  //jr.fill("ambient_occlusion");
  bottomBoard(woodThickness, screenWidth, depth, frontExtrude, #ffffff);    
  verticalSide(woodThickness, depth, verticalHeight, #ffffff);
  pushMatrix();
    translate(+screenWidth-woodThickness,0,0);
    verticalSide(woodThickness, depth, verticalHeight, #ffffff);
  popMatrix();
  backFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF);     
  topFace(woodThickness, screenWidth, verticalHeight, depth, #FFFFFF);
  frontDraw(woodThickness, screenWidth, verticalHeight);
  drawFloor(workArea, 0);
}

void frontDraw(int wt, int sw, int vh) {
    if (frontDraw) {  
      stroke(190);
      pushMatrix();
        translate(500+0.5*sw,507,-0.5*vh-wt);
        jr.fill("glass");//, 150, 214, 237, 0, 0, 255, 50, 16); 
        //jr.fill("mirror", 255, 255, 255);    
        box(sw-wt*2,12,vh);
      popMatrix();
    }
}

void topFace(int wt, int sw, int vh, int d, int s) {
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


void drawFloor(int l, int h){
  if (floorDraw){
    pushMatrix();
      translate(50*10,5000,6);
      fill(2);        
      box(210*58,1000*24,10);
    popMatrix();
    /*
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
    */
  }
}

