class Bateau
{
  int taille;
  int x;
  int y;
  int direction;
  int [] touche;
  Bateau()
  {
    touche = new int [5];
    for ( int i=0; i<5; i= i+1)
    {
      touche[i] = 0;
    }
  }
}
void DessineBateau(Bateau Navire)
{
  ellipseMode(CORNER);
  int X=(Navire.x*40+700);
  int Y=(Navire.y*40+230);
  int Hauteur;
  int Largeur;
  if (Navire.direction==0)
  {
    Hauteur = 40;
    Largeur = Navire.taille*40;
  } else
  {
    Hauteur = Navire.taille*40;
    Largeur = 40;
  }
  smooth();
  ellipse(X+5, Y+5, Largeur-10, Hauteur-10);
}
boolean coup = false;
void mousePressed() {
  coup=true;
}
boolean Jeu_Lance = false;
void LanceJeu()
{
  Jeu_Lance=true;
  background(119, 181, 254);
}
void JouerEn(int CaseX, int CaseY)
{
  int X = CaseX*60+30;
  int Y = CaseY*60+30;
  line(X, Y, X+60, Y+60);
  line(X+60, Y, X, Y+60);
}
void PlateauDeJeu(int x, int y, int TailleCase, int NombreDeCases) {
  for (int i=0; i<NombreDeCases+1; i=i+1) {
    int coordVerticale = x+i*TailleCase;
    int coordHorizontale = y+i*TailleCase;
    line(coordVerticale, y, coordVerticale, TailleCase*NombreDeCases+y);
    line(x, coordHorizontale, TailleCase*NombreDeCases+x, coordHorizontale);
  }
}
void setup() {
  size(1300, 670);
  stroke(21, 96, 189);
  background(116, 180, 180);

  PFont police;
  fill(46, 40, 104);
  police=loadFont("GentiumBookBasic-48.vlw");

  size(1300, 670);
  background (119, 140, 233);

  textFont(police, 80);
  text("Bataille Navale", 260, 100);
  textFont(police, 40);
  text("Les règles", 1025, 150);
  textFont(police, 18);
  text("But du jeu : toucher les bateaux de l'adversaire", 935, 180);
  text("pour gagner la partie", 935, 210);
  text("Comment jouer : cliquer sur une case pour", 935, 230);
  text("essayer de toucher les bateaux de l'adversaire", 935, 250);
  text("Présentation des différents bateaux:", 935, 280);
  text("Le porte-avion:", 935, 300);
  text("Il mesure 5 cases", 935, 320);
  text("Le croiseur:", 935, 340);
  text("Il mesure 4 cases", 935, 360);
  text("Le contre-torpilleur:", 935, 380);
  text("Il mesure 3 cases", 935, 400);
  text("Le sous-marin:", 935, 420);
  text("Il mesure 3 cases", 935,440);
  text("Le torpilleur:", 935, 460);
  text("Il mesure 2 cases",935,480);
  textFont(police, 40);
  text("Bon jeu!",1025,580);
  Croiseur=new Bateau();
  Croiseur.taille=4;
  Croiseur.x=3;                                        
  Croiseur.y=5;
  Croiseur.direction=0;
  Porte_Avion=new Bateau();
  Porte_Avion.taille=5;
  Porte_Avion.x=0;
  Porte_Avion.y=0;
  Porte_Avion.direction=1;
  Sous_marin=new Bateau();
  Sous_marin.taille=3;
  Sous_marin.x=4;
  Sous_marin.y=6;
  Sous_marin.direction=1;
  Contre_Torpilleur=new Bateau();
  Contre_Torpilleur.taille=3;
  Contre_Torpilleur.x=7;
  Contre_Torpilleur.y=7;
  Contre_Torpilleur.direction=0;
  Torpilleur=new Bateau();
  Torpilleur.taille=2;
  Torpilleur.x=7;
  Torpilleur.y=3;
  Torpilleur.direction=0;



  PImage monImg;
  monImg =loadImage("aircraft-carrier-569867_640.jpg");
  image(monImg, 50, 180, 640, 457);
}
void Interface()
{
  fill(155, 156, 220);
  rect (760, 270, 150, 75);
  rect (760, 370, 150, 75);
  rect (760, 470, 150, 75);

  textSize (30);
  fill (1, 215, 88) ;
  text ("Facile", 800, 317);
  fill (244, 102, 27) ;
  text ("Moyen", 796, 417);
  fill (255, 0, 0) ;
  text ("Difficile", 789, 517);


  if (mouseX > 760 && mouseX < 910 && mouseY > 270 && mouseY < 345) {
    fill(1, 215, 88);
    rect (760, 270, 150, 75);
    fill (255) ;
    text ("Facile", 800, 317);
  } else
    if (mouseX > 760 && mouseX < 910 && mouseY > 370 && mouseY < 445) {
    fill(244, 102, 27);
    rect (760, 370, 150, 75);
    fill (255) ;
    text ("Moyen", 796, 417);
  } else
    if (mouseX > 760 && mouseX < 910 && mouseY > 470 && mouseY < 545) {
    fill(255, 0, 0);
    rect (760, 470, 150, 75);
    fill (255) ;
    text ("Difficile", 789, 517);
  }



  if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 270 && mouseY < 335 == true) 
  {
    LanceJeu();
  } else 
    if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 370 && mouseY < 435 == true) 
  {

    LanceJeu();
  } else 
    if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 470 && mouseY < 535 == true) 
  {

    LanceJeu();
  }
}
int CaseClique (int coordonnee, int tailleCase, int DebutGrille) 
{
  return (coordonnee-DebutGrille)/tailleCase;
}
void draw () {
  if (Jeu_Lance==true) {
    PlateauDeJeu(30, 30, 60, 10);
    PlateauDeJeu(700, 230, 40, 10);
    DessineBateau(Croiseur);
    DessineBateau(Porte_Avion);
    DessineBateau(Sous_marin);
    DessineBateau(Contre_Torpilleur);
    DessineBateau(Torpilleur);
    if (coup==true)
    {
      coup=false;
      int CaseX=CaseClique(mouseX, 60, 30);
      int CaseY=CaseClique(mouseY, 60, 30);
      if (CaseX>=0 && CaseX<=9 && CaseY>=0 && CaseY<=9)
      {
        JouerEn(CaseX, CaseY);
      }
    }
  } else 
  {
    Interface();
  }
}


Bateau Croiseur;
Bateau Porte_Avion;
Bateau Sous_marin;
Bateau Contre_Torpilleur;
Bateau Torpilleur;

boolean CoordIn(Bateau Navire, int Tir_x, int Tir_y)
{
  int coord_x=Navire.x;
  int coord_y=Navire.y;
  for (int i=0; i<Navire.taille; i=i+1)
  {

    if (Tir_x==coord_x && Tir_y==coord_y)
    {
      Navire.touche[i]=1;
      return true;
    }
    if (Navire.direction==0)
    {
      coord_x=coord_x+1;
    } else
    {
      coord_y=coord_y+1;
    }
  }
  return false;
}

boolean Collision (Bateau Navire_A, Bateau Navire_B)
{
  int coord_x=Navire_A.x;
  int coord_y=Navire_A.y;
  for (int i=0; i<Navire_A.taille; i=i+1)
  {

    if (CoordIn(Navire_B, coord_x, coord_y)==true)
    {
      return true;
    }
    if (Navire_A.direction==0)
    {
      coord_x=coord_x+1;
    } else
    {
      coord_y=coord_y+1;
    }
  }
  return false;
}
//void setup()                          CECI EST UN TEST
//{
// Bateau Croiseur = new Bateau ();
//  Croiseur.taille=4;
//  Croiseur.x=3;
//  Croiseur.y=4;                          CECI EST UN TEST
//  Croiseur.direction=0;
// Bateau Sous_marin = new Bateau();
//  Sous_marin.taille=3;
//  Sous_marin.x=4;
//  Sous_marin.y=3;
//  Sous_marin.direction=1;
//   if(Collision(Croiseur, Sous_marin))
//   {
//     print("collision !");
//   }
//}
boolean TirReussi(Bateau Navire, int Tir_x, int Tir_y)
{
  int coord_x=Navire.x;
  int coord_y=Navire.y;
  for (int i=0; i<Navire.taille; i=i+1)
  {

    if (Tir_x==coord_x && Tir_y==coord_y)
    {
      Navire.touche[i]=1;
      return true;
    }
    if (Navire.direction==0)
    {
      coord_x=coord_x+1;
    } else
    {
      coord_y=coord_y+1;
    }
  }
  return false;
}

boolean Coule (Bateau Navire)
{
  int somme=0;
  for ( int i=0; i<Navire.taille; i=i+1)
  {
    somme=somme+Navire.touche[i];
  }
  if ( somme==Navire.taille)
  {
    return true;
  } else
  {
    return false;
  }
}
//void setup()                              CECI EST UN TEST
//{
//  Bateau Croiseur = new Bateau ();
//  Croiseur.taille=4;
//  Croiseur.x=3;                                        CECI EST UN TEST
//  Croiseur.y=5;
//  Croiseur.direction=0;
//  for (int i=0; i<10; i=i+1)
//  {
//    for (int j=0; j<10; j=j+1)
//    {
//      if ( TirReussi(Croiseur, i, j)==true)
//      {
//        print (i);
//        print(",");                                      CECI EST UN TEST
//        print (j);
//        println (" touché");
//        if (Coule(Croiseur)==true) {
//          println("Coulé!");
//        }
//      }
//    }
//  }
//}

