void setup(){
  size(600,600);
  stroke(255);
  background(119,181,254);
}

void draw(){
  int espacey=(height-20)/5;
  int espacex=(width-20)/5;
  
  for (int i=0;i<=5;i++){
    line(10,10+i*espacey,width-10,10+i*espacey);
  }
  
  for (int i=0;i<=5;i++){
    line(10+i*espacex,10,10+i*espacex,height-10);
  }
}
  
