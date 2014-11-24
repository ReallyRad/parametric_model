class APoint {
  PVector loc;
  float val;
  float ang; 
  float x,y;
  
  APoint(int i) {
    ang = TWO_PI/8*i;   
    val=random(0.20, 1.5);    
    //println("dia " + dia); 
    println("val " + val);   
    /*println("cos " + ang);
    println("x " + x);
    println("y " + y);
    println("///");*/    
  }    


APoint(int i, float f) {
    ang = TWO_PI/8*i;       
    val=f;
    x = dia*val*cos(ang);
    y = dia*val*sin(ang);    
  }    

 Integer marks(float i) {
  Integer o = 0;  
  if (i<0.20){o = 0;} 
  else if (i>0.20 && i<=0.39){o = 1;}
  else if (i>0.40 && i<=0.60){o = 2;}  
  else if (i>0.60 && i<=0.80){o = 3;}
  else if (i>0.80 && i<=1.00){o = 4;}   
  return o;
}
}
