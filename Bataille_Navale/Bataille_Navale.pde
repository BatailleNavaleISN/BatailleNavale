int nombreBateaux = 5;
int [] tailleBateau= {
  2, 2, 3, 4, 5
};

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

Bateau[] flotteJoueur;

void AfficheFlotte()
{
  for (int i=0; i<nombreBateaux; i=i+1)
  {
    DessineBateau(flotteJoueur[i]);
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

Bateau [] FlotteAleatoire ()
{
  Bateau[] b=new Bateau [nombreBateaux];
  for (int i=0; i<nombreBateaux; i=i+1)
  {
    b[i] = new Bateau();
    b[i].taille=tailleBateau[i];
    b[i].direction=int (random(0, 2));

    boolean EnCollision=false;
    do {
      if (b[i].direction==0)
      {
        b[i].x=int (random(0, 10-b[i].taille));
        b[i].y=int (random(0, 10));
      } else
      {
        b[i].x=int (random(0, 10));
        b[i].y=int (random(0, 10-b[i].taille));
      }
      EnCollision=false;
      for (int j=0; j<i; j=j+1)
      {
        EnCollision = EnCollision || Collision(b[i], b[j]);
      }
      if (EnCollision==true)
      {
        println("On recommence");
      }
    } 
    while (EnCollision==true);
  }
  return b;
}
void setup() {
  size(1300, 670);
  stroke(21, 96, 189);
  background(116, 180, 180);

  PFont police;
  fill(46, 40, 104);
  police=loadFont("GentiumBasic-48.vlw");

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
  text("Il mesure 3 cases", 935, 440);
  text("Le torpilleur:", 935, 460);
  text("Il mesure 2 cases", 935, 480);
  textFont(police, 40);
  text("Bon jeu!", 1025, 580);

  PImage monImg;
  monImg =loadImage("aircraft-carrier-569867_640.jpg");
  image(monImg, 50, 180, 640, 457);

  flotteJoueur=FlotteAleatoire ();
}
void Interface()
{
  fill(155, 156, 220);
  rect (760, 270, 150, 75);
  rect (760, 400, 150, 75);

  textSize (30);
  fill (1, 215, 88) ;
  text ("Facile", 800, 317);
  fill (255, 0, 0) ;
  text ("Difficile", 789, 447);


  if (mouseX > 760 && mouseX < 910 && mouseY > 270 && mouseY < 345) {
    fill(1, 215, 88);
    rect (760, 270, 150, 75);
    fill (255) ;
    text ("Facile", 800, 317);
  } else
    if (mouseX > 760 && mouseX < 910 && mouseY > 400 && mouseY < 475) {
    fill(255, 0, 0);
    rect (760, 400, 150, 75);
    fill (255) ;
    text ("Difficile", 789, 447);
  }



  if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 270 && mouseY < 335 == true) 
  {
    LanceJeu();
  } else 
    if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 400 && mouseY < 465 == true) 
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
    AfficheFlotte();
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

