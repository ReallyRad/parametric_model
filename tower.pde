class Tower {
  ArrayList<Shape> shapes;  
  
  Tower(Shape s){
    shapes = new ArrayList<Shape>();
    for (int i=0; i<10; i++) {
      shapes.add(newShape(s, i)); //create interpolation of shapes 
    }     
  }
  
  void draw() {
    pushMatrix();
      for (int i=0; i< 10; i++) {
        translate(0,0,80);
        shapes.get(i).draw();
      }
    popMatrix();
  }
  
  Shape newShape(Shape s, int index) {                     
    APoint points[]; //used to create incremental shapes
    points = s.myPoints;
    
    for (int i=0; i<8; i++) {        
      //create datapoints for new shape                        
      points[i] = new APoint(i, lerp(s.myPoints[i].val, s.average*1.5, (float)1/8*(float)i));      
      //points[i] = new APoint(i, points[i].val-0.1*index*(points[i].val-s.average)+1*i*s.average);       
    }    
    return new Shape(points);                    
  }  
  
  
}

