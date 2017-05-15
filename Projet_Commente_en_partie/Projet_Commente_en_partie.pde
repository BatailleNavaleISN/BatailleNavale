//On crée une variable renvoyant un entier (le nombre de bateaux) ici ils sont 5
int nombreBateaux = 5;        

//On crée un tableau d'entiers qui renseigne la taille des bateaux du joueur
int [] tailleBateau= {2, 2, 3, 4, 5}; 

//On crée une classe Bateau qui contiendra des bateaux différents 
//qui ne sont pas créés de la même manière
class Bateau                                                   
{
  //Chaque bateau est définit par sa taille...
  int taille;   

  //...sa coordonnée x...
  int x;                                                        

  //...sa coordonnée y...
  int y;                                                        

  //...si il est orienté de manière verticale ou horizontale (0=Horizontal ; 1=Vertical)
  int direction;                                                

  //On a créé un tableau réprésentant le bateau avec le même nombre de 
  //cases que celles qu'occupe le bateau. Il est rempli de 0 au début de la partie
  //car aucune case n'a été touchée (1=case touchée; 0=case non touchée)
  int [] touche;                                                

  //On crée le tableau touche représentant un bateau.
  Bateau()
  {
    //Il compte au maximum 5 cases car le bateau le plus grand mesure 5 cases
    touche = new int [5];
    for ( int i=0; i<5; i= i+1)
    {

      //On remplit le tableau de 0 car aucune case n'est touchée
      touche[i] = 0;
    }
  }
}
// On crée une flotte pour le Joueur
Bateau[] flotteJoueur;
// On crée une flotte pour l'Ordinateur
Bateau [] flotteOrdi;

// On crée une fonction capable d'afficher la flotte du joueur
//que l'on vient de créer
void AfficheFlotte()                                            
{
  //On parcourt le nombre de bateaux pour tous les dessiner
  for (int i=0; i<nombreBateaux; i=i+1)                         
  {
    //La fonction dessine seulement la flotte du joueur i
    DessineBateau(flotteJoueur[i]);
  }
}

void DessineBateau(Bateau Navire)                              
{
  // On dessine le bateau en forme d'ellispe du coin supérieur 
  //gauche au coin inférieur droit
  ellipseMode(CORNER); 
  // on place les bateaux visibles dans la petite grille seulement
  int X=(Navire.x*40+700);
  int Y=(Navire.y*40+230);
  int Hauteur;
  int Largeur;

  // si le bateau est horizontal, il garde une hauteur prédéfinie mais par contre
  // sa largeur va être définie en fonction du nombre de cases qu'il occupe
  if (Navire.direction==0)
  {
    Hauteur = 40;
    Largeur = Navire.taille*40;

    //si le bateau est vertical, il garde une largeur prédéfinie mais par contre
    //sa longueur va être définie en fonction des cases qu'il occupe
  } else
  {
    Hauteur = Navire.taille*40;
    Largeur = 40;
  }
  //on lisse les contours de l'ellipse
  smooth();
  // on calible l'ellipse pour qu'elle soit au centre des cases qu'elle occupe 
  ellipse(X+5, Y+5, Largeur-10, Hauteur-10);
}



// le joueur n'a pas encore joué donc coup est à faux
boolean coup = false;

// dès qu'il clique sur une case du grand plateau de jeu, il joue un coup, coup passe à vrai
void mousePressed() {
  coup=true;
}
int [][] petiteGrille = new int [10][10];

void Tir_Ordi ()
{
  int Tir_Ordi_x;
  int Tir_Ordi_y;
  do {
    Tir_Ordi_x = int (random(0, 10));
    Tir_Ordi_y = int (random(0, 10));
  }
  while (petiteGrille [Tir_Ordi_x] [Tir_Ordi_y]==1);
  petiteGrille [Tir_Ordi_x] [Tir_Ordi_y]=1;
  for (int i=0; i<5; i=i+1)
  {
    TirReussi (flotteJoueur[i], Tir_Ordi_x, Tir_Ordi_y);
  }
  //  int i;
  //  if(Coule(flotteJoueur[i]==true))
  //  {
  //    println ("coulé");
  //  }
}

boolean Jeu_Lance = false;
void LanceJeu()
{
  Jeu_Lance=true;
  background(119, 181, 254);
}
// on restreint le clic du joueur à une seule case puis on trace une croix dans celle-ci
//pour indiquer qu'elle a déjà été ciblée
void JouerEn(int CaseX, int CaseY)
{
  int X = CaseX*60+30;
  int Y = CaseY*60+30;
  line(X, Y, X+60, Y+60);
  line(X+60, Y, X, Y+60);
}
// une grille de jeu est définie par sa coordonnée en x en y, la taille 
//de ses cases et le nombre de celles-ci
void PlateauDeJeu(int x, int y, int TailleCase, int NombreDeCases) {

  // on parcourt la grille
  for (int i=0; i<NombreDeCases+1; i=i+1) {

    //
    int coordVerticale = x+i*TailleCase;

    //
    int coordHorizontale = y+i*TailleCase;
    line(coordVerticale, y, coordVerticale, TailleCase*NombreDeCases+y);
    line(x, coordHorizontale, TailleCase*NombreDeCases+x, coordHorizontale);
  }
}
// on crée une flotte de bateaux, placés aléatoirement
Bateau [] FlotteAleatoire ()
{
  // b est un tableau de bateaux qui est pour l'instant vide
  Bateau[] b=new Bateau [nombreBateaux];

  // on parcourt tout les éléments du tableau nombreBateaux et on crée
  // un bateau pour chaque élément
  for (int i=0; i<nombreBateaux; i=i+1)
  {

    b[i] = new Bateau();

    //la taille du nouveau bateau est renseignée dans le tableau tailleBateau
    // il ne peut ni être plus grand ni plus petit etc
    b[i].taille=tailleBateau[i];

    // on tire la direction du bateau au hasard entre 0 et 1
    b[i].direction=int (random(0, 2));

    // tant que les bateaux ne sont pas superposés : 
    boolean EnCollision=false;
    do {
      //si le bateau est horizontal on va tirer ses coordonnées 
      //au hasard mais avec des conditions
      if (b[i].direction==0)
      {
        //sa coordonnée en x ne doit pas le faire sortir de la
        // grille alors on enlève à x la taille du bateau
        b[i].x=int (random(0, 10-b[i].taille));

        //on tire au hasard la coordonnée y
        b[i].y=int (random(0, 10));

        //si le bateau est vertical on tire ses coordonnées au hasard
        // avec des conditions
      } else
      {
        // on tire au hasard la coordonnée x
        b[i].x=int (random(0, 10));
        // la coordonnée y ne doit pas le faire sortir de la grille 
        //alors on enlève à y la taille du bateau
        b[i].y=int (random(0, 10-b[i].taille));
      }
      // on compare les coordonnées du bateau i que l'on veut placer avec
      // les coordonnées des bateaux déjà placés sur la grille
      EnCollision=false;
      for (int j=0; j<i; j=j+1)
      {
        // les bateaux sont considérés en collision si il y a une collision
        // entre deux bateaux i et j ou qu'il y a eu une collision entre des
        // bateaux placés auparavant
        EnCollision = EnCollision || Collision(b[i], b[j]);
      }

      if (EnCollision==true)
      {
        println("On recommence");
      }
    } 

    // tant que les bateaux placés sont superposés on recommence
    while (EnCollision==true);
  }
  return b;
}
// On déclare le setup en donnant la taille de la page et sa couleur de fond
void setup() {
  size(1300, 670);
  stroke(21, 96, 189);
  background(116, 180, 180);

  for (int i=0; i<10; i=i+1)
  {
    for (int j=0; j<10; j=j+1)
    {
      petiteGrille [i][j] = 0;
    }
  }

  //On annonce la police d'écriture, sa couleur ainsi que sa taille
  PFont police;
  fill(46, 0, 108);
  police=loadFont("GentiumBasic-48.vlw");

  size(1300, 670);
  background (119, 140, 233);

  //On écrit le texte, le titre et les règles du jeu
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

  //On met l'image en précisant sa taille
  PImage monImg;
  monImg =loadImage("aircraft-carrier-569867_640.jpg");
  image(monImg, 50, 180, 640, 457);

  //On renseigne que les différentes flottes créées sont des flottes
  //aléatoires et donc qu'elles suivent la fonction Flotte aléatoire
  flotteJoueur=FlotteAleatoire ();
  flotteOrdi=FlotteAleatoire ();
}
void Interface()
{
  //On dessine le rectangle pour jouer 
  fill(155, 156, 220);
  rect (740, 350, 150, 75);

  //On précise sa taille et sa couleur
  textSize (30);
  fill (46, 0, 108) ;
  text ("Jouer", 785, 395);

  //Si la souris est au dessus du rectangle "jouer", alors le rectangle
  // change de couleur et devient violet et le texte devient blanc
  if (mouseX > 760 && mouseX < 910 && mouseY > 350 && mouseY < 425)
  {
    fill(46, 0, 108);
    rect (740, 350, 150, 75);
    fill (255) ;
    text ("Jouer", 785, 395);
  }

  //Si on appuie sur la souris lorsqu'elle est au dessus du rectangle jouer alors la grille
  // du jeu se lance pour le niveau facile
  if (mousePressed && mouseX > 760 && mouseX < 910 && mouseY > 350 && mouseY < 425 == true) 
  {
    LanceJeu();
  }
}

int CaseClique (int coordonnee, int tailleCase, int DebutGrille) 
{
  return (coordonnee-DebutGrille)/tailleCase;
}
void draw () {
  // si le jeu est lancé alors on dessine les grilles de jeu 
  if (Jeu_Lance==true)
  {
    // Le grand plateau de Jeu commence en x=30 y=30, ses cases sont au
    // nombre de 10 et mesurent 60 pixels
    PlateauDeJeu(30, 30, 60, 10);                                  

    // Le petit plateau de Jeu commence en x=700 y=230, ses cases sont
    // au nombre de 10 et mesurent 40 pixels
    PlateauDeJeu(700, 230, 40, 10);  
    // On apelle la fonction Affiche flotte pour afficher dans la petite 
    //grille la flotte du joueur
    AfficheFlotte();     
    for (int i=0; i<10; i=i+1)
    {
      for (int j=0; j<10; j=j+1)
      {
        if (petiteGrille [i] [j]==1) 
        {

          int Px = i*40+700;
          int Py = j*40+230;
          line(Px, Py, Px+40, Py+40);
          line(Px+40, Py, Px, Py+40);
        }
      }
    }

    // Si le joueur à cliqué sur une case et coup est passé à vrai alors :
    if (coup==true)                                              
    {
      coup=false;

      // On restreint la possibilité de cliquer à la grande grille
      int CaseX=CaseClique(mouseX, 60, 30);                        
      int CaseY=CaseClique(mouseY, 60, 30);
      if (CaseX>=0 && CaseX<=9 && CaseY>=0 && CaseY<=9)            
      {
        JouerEn(CaseX, CaseY);
        // L'ordinateur choisit des coordonnées pour tirer sur la flotte du joueur
        Tir_Ordi () ;
      }
    }
  } else 

  {
    // Si la fonction LanceJeu n'est pas lancée alors on affiche l'interface
    Interface();
  }
}


// on compare les coordonnées d'un bateau quelconque (test_x, test_y) avec les coordonnées 
//d'un autre bateau cette fonction servira dans la fonction collision
boolean CoordIn(Bateau Navire, int test_x, int test_y )
{
  int coord_x=Navire.x;
  int coord_y=Navire.y;
  for (int i=0; i<Navire.taille; i=i+1)
  {

    if (test_x==coord_x && test_y==coord_y)
    {
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
// on crée une fonction qui va comparer les coordonnées de deux navires
//pour savoir si ils sont superposés cette fonction nous a servi pour placer
//les bateaux aléatoirement et ne pas les superposer
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

//on a testé la fonction collision avec des bateaux

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

// on compare les coordonnées de la case touchée avec les coordonnées de tous les bateaux
// pour savoir si le tir est réussi ou non
boolean TirReussi(Bateau Navire, int Tir_x, int Tir_y)
{

  // si les coordonnées correspondent alors le bateau est touché et le tir est réussi 
  int coord_x=Navire.x;
  int coord_y=Navire.y;

  // pour chaque coordonnée de chaque navire on compare avec les coordonnées du tir
  for (int i=0; i<Navire.taille; i=i+1)
  {
    // si la coordonnée x et la coordonnée y concordent alors le bateau est touché
    if (Tir_x==coord_x && Tir_y==coord_y)
    {
      // on remplace le 0 par un 1 dans la bonne case du tableau "touche" du bateau touché
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

  //si les coordonnées en x et en y ne correspondent aux coordonnées 
  //d'aucun des bateaux de la flotte alors aucun bateau n'est touché
  return false;
}

// On crée une fonction pour savoir si un bateau est coulé
boolean Coule (Bateau Navire)                                                
{
  // on fait la somme des cases touchées
  int somme=0;                                                                
  for ( int i=0; i<Navire.taille; i=i+1)
  {
    somme=somme+Navire.touche[i];
  }

  // Si la somme de tous les 1 dans le tableau du bateau est égale
  // à la taille du bateau en question alors cela signifie que tout le
  // tableau est rempli de 1 et que le bateau a entièrement été touché
  if ( somme==Navire.taille)                                                 

  {
    //Comme toutes les cases du bateau sont touchées alors on retourne
    // vrai c.-a.-d. que le bateau est alors coulé
    return true;
  } else
  {
    // Si toutes les cases du bateau ne sont pas touchées,
    // le bateau n'est pas coulé et reste en jeu
    return false;
  }
}

//on a testé la fonction tir réussi et la fonction coulé

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

