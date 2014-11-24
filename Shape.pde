class Shape {   
  float average;
  int thick;
  PShape shp;
  APoint[] myPoints;  
  ArrayList <PVector> curvePoints;   
  
  Shape(APoint[] points) {              
    //initializing myPoints
    myPoints = new APoint[8];    
    
    for(int i=0; i<8; i++) {
      myPoints[i]=points[i];
      /*print("myPoints["+i+"].x ");
      println(myPoints[i].x);  
      print("points["+i+"].y ");
      println(points[i].y );      
      */
      //println("val : ", val);      
    }          
    
    //calculate average    
    average=0;
    for (int i=0; i<8; i++) {
        average+=myPoints[i].val;
        average=average/8;
    }
    
    println("average ", average);    
                              
    textSize(20);    
    thick = 14;  
    
    curvePoints = new ArrayList <PVector>();  
    curveTightness(0.04);       
    for (int i=0; i<8; i++) {
      APoint a = myPoints[getIndex(i-2)];
      //println("myPoints[getIndex(",i-2,")] ", myPoints[getIndex(i-2)].x);
      //println("a " + a.x );
      APoint b = myPoints[getIndex(i-1)];
      APoint c = myPoints[getIndex(i)];
      APoint d = myPoints[getIndex(i+1)];    
      int nr = 6; //number of segments between each point
      for (int j=0; j<nr; j++) {
        PVector pos = new PVector(curvePoint(a.x, b.x, c.x, d.x, (float)j/nr),curvePoint(a.y, b.y, c.y, d.y, (float)j/nr));                 
        curvePoints.add(new PVector(pos.x, pos.y));        
        //println("pos.x ", pos.x, "pos.y", pos.y);        
      }      
    }     
}  
      
  void draw() {    
    jr.fill("diffuse");
          
if (record) {
      beginRecord("nervoussystem.obj.OBJExport", "nuface4.obj");
      println("record started!");
    }  
    
      for (int i=0; i<curvePoints.size()+1; i++) {            
          //top face
          beginShape(TRIANGLES);          
            vertex(curvePoints.get((i+1)%curvePoints.size()).x, curvePoints.get((i+1)%curvePoints.size()).y,0);
            vertex(curvePoints.get(i%curvePoints.size()).x, curvePoints.get(i%curvePoints.size()).y, 0);                                
            vertex(0,0,0);
          endShape(CLOSE);
          
          //outer face, 1st half
          beginShape(TRIANGLES);            
            vertex(curvePoints.get(i%curvePoints.size()).x, curvePoints.get(i%curvePoints.size()).y, 0);                    
            vertex(curvePoints.get((i+1)%curvePoints.size()).x, curvePoints.get((i+1)%curvePoints.size()).y, 0);
            vertex(curvePoints.get((i+1)%curvePoints.size()).x, curvePoints.get((i+1)%curvePoints.size()).y, thick);                                
          endShape(CLOSE);
          
          //outer face, 2nd half
          beginShape(TRIANGLES);            
            vertex(curvePoints.get(i%curvePoints.size()).x, curvePoints.get(i%curvePoints.size()).y, 0);                                
            vertex(curvePoints.get((i+1)%curvePoints.size()).x, curvePoints.get((i+1)%curvePoints.size()).y, thick);
            vertex(curvePoints.get((i)%curvePoints.size()).x, curvePoints.get((i)%curvePoints.size()).y, thick);
          endShape(CLOSE);

          //bottom face          
          fill(155,255,150);
          beginShape(TRIANGLES);
            vertex(curvePoints.get((i+1)%curvePoints.size()).x, curvePoints.get((i+1)%curvePoints.size()).y,thick);
            vertex(curvePoints.get(i%curvePoints.size()).x, curvePoints.get(i%curvePoints.size()).y, thick);                     
            vertex(0,0,thick);
            endShape(CLOSE);                          
      }
      
if (record) {
      endRecord();
      println("record ended!");
      record=false;}      
  }

  void myVertex(float x, float y, float z, int i){
    pushMatrix();
      translate(x,y,z);
      vertex(0,0,0);
      ellipse(0,0,5,5);
      fill(0);
      stroke(0);    
      text(i,0,0,15);
    popMatrix();
  }
    
  int getIndex(int i) { //get control points id from graph also for negative index
    if (i<0) {return 8+i;} 
    else {return i%8;}
  }              
 
}


