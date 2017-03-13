void PlateauDeJeu(int x, int y, int TailleCase, int NombreDeCases){
  for (int i=0;i<NombreDeCases+1;i=i+1){
    int coordVerticale = x+i*TailleCase;
    int coordHorizontale = y+i*TailleCase;
    line(coordVerticale,y,coordVerticale,TailleCase*NombreDeCases+y);
    line(x,coordHorizontale,TailleCase*NombreDeCases+x,coordHorizontale);
  }
}
void setup(){
  size(1300,670);
  stroke(21, 96, 189);
  background(119,181,254);
}
void draw (){
  PlateauDeJeu(30,30,60,10);
  PlateauDeJeu(700,230,40,10);
}
