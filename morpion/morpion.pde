int[][] grille= new int[3][3];                       // on difinit une nouvelle grille.
int joueur = 1  ;                                    // on a deux joueurs, l'un vaut 0 l'autre vaut 1. On démmare avec le joueur 1.
boolean coup = false;                                // "coup" sert à déterminer quel joueur doit jouer. Ici on initialise coup à faux puisqu'aucun coup n'a été joué.

void mousePressed(){                                 // on crée une fonction qui fait passer "coup" à vrai dès qu'on clique sur la souris.
  coup=true;                                         // "coup" est une variable qui détermine si un coup a été joué. Elle sert à limiter l'action au seul clic de la souris.
} 

boolean termine = false;                             // on utilise "termine" pour indiquer dans quels cas la partie s'achève. Ici on le met à "false" car la partie commence, aucun coup n'a encore été joué
void TestVictoire(int somme){                        // cette fonction détermine les conditions de victoire. Elle sera appelée après chaque coup pour vérifier si un joueur a gagné ou non.
   
   //"somme" est utilisée quand on parcourt la grille et qu'on additionne les chiffres présents dans chaque case.
   // On a attribué le numéro 1 à l'un des joueurs et le numéro 4 à l'autre
   //En additionnant les lignes, les colonnes et les diagonales on obtienne 3 ou 12 (victoire) ou toute autre combinaison (match nul ou partie inachevée) 
   // Ici termine==false car on ne peut gagner que si personne n'a remporté la partie au préalable
    
  if(somme==3 && termine==false){           
    
    //on affiche un message en cas de victoire ou de match nul puis on achève la partie (termine = true)
      PFont police;                                 
      fill(96, 80, 220);
      police=loadFont("DeliusSwashCaps-Regular-48.vlw");
      textFont(police,37);
      text("Le joueur 1 gagne",5,330);
      termine = true;
    }
    if(somme==12 && termine ==false){
      PFont police;
      fill(145, 40, 59);
      police=loadFont("DeliusSwashCaps-Regular-48.vlw");
      textFont(police,36);
      text("Le joueur 2 gagne",5,330);
      termine = true;
    }
    
}

  int compteur=0;                                      // la variable "compteur" sert à compter les coups joués par les joueurs
  
// on définit la taille de la fenêtre et la couleur du fond
void setup (){
  size(300,340);
  background(244, 254, 254);
  // on appelle la fonction de dessin de la grille
  traceGrille();
  for(int i=0; i<3; i=i+1)
  {
    for(int j=0; j<3; j=j+1)
    {
      grille[i][j]=0;        // au début, aucun joueur n'a placé de pion sur le plateau donc grille[i][j]=0
    }
  }
}



void draw(){                                            // draw est appelée autant de fois que le "Frame Rate" l'indique
 if(coup){                                              // si "coup" n'existait pas, le programme jouerait 30 fois par seconde le contenu de draw.
   coup=false;                                          // confirmation que le coup vient d'être joué 
   //On récupère les coordonnées de la souris qu'on divise par 100 pour obtenir des nombres entiers entre 0 et 2. On obtient alors la case de la grille dans laquelle on placerait le pion
   int colonne = mouseX/100;
   int ligne = mouseY/100;
   if(ligne<3 && grille[colonne][ligne]==0 && termine == false){  // si il n'y a pas de pion présent dans la case, qu'on essaye pas de placer le pion en dehors de la surface prévue à cet effet
                                                                  // et que la partie n'est pas terminée alors on peut placer son pion.
     // On récupère l'entier donné par"mouseX/100" et "mouseY/100" pour placer le pion au milieu de la case 
     int milieuX = ((mouseX/100)*100)+50;
     int milieuY = ((mouseY/100)*100)+50;
    compteur=compteur+1;                           // après qu'un coup ait été joué, le compteur de coups augmente de 1              
     joueur=(joueur+1)%2;                          // on passe d'un joueur à l'autre (si c'était au joueur 1 alors : (1+1)%2 = 0 donc on passe au joueur 0)
     grille[colonne][ligne]=(3*joueur)+1;          // on attribue un chiffre à chaque joueur (soit 1, soit 4) Le joueur 0 "place" des "1" dans les cases et le joueur 1 "place" des "4".
     //le pion du joueur 0 est une croix bleue
     if(joueur==0){
       smooth();
       stroke(96, 80, 220);
       strokeWeight(3);
       fill(244, 254, 254);
       line(milieuX-31, milieuY-31, milieuX+31, milieuY+31);
       line(milieuX+31, milieuY-31, milieuX-31, milieuY+31);
     }
     //le pion du joueur 1 est un cercle rouge
     else{
       stroke(222, 49, 99);
       strokeWeight(3);
       fill(244, 254, 254);
       ellipse(milieuX,milieuY,70,70);
     }
     
     
     
     Victoire();
   }
 }
}
//on parcourt la grille pour voir si un joueur à gagné. On parcourt toutes les lignes toutes les colonnes et les deux diagonales du plateau de jeu. 
void Victoire(){
  for(int ligne = 0; ligne<3; ligne=ligne+1){  // on parcourt toutes les lignes
    int somme=0;                            // on additionne les chiffres (1 ou 4) placés par les joueurs dans la grille 
    for(int colonne = 0; colonne<3; colonne=colonne+1){
      somme=somme+grille[colonne][ligne];   // étant donné que les joueurs placent soit des 1 soit des 4 dans la grille,
                                            //en alignant 3 mêmes pions pour gagner on obtient une somme de 3 pour le joueur 0 et une somme de 12 pour le joueur 1
    }
    TestVictoire(somme);                    // on appelle la fonction de vérification de la somme (TestVictoire(somme)) pour savoir si un des joueurs à gagné.
  }
  
  for(int colonne = 0; colonne<3; colonne=colonne+1){    // on parcourt toutes les colonnes
    int somme=0;
    for(int ligne = 0; ligne<3; ligne=ligne+1){
      somme=somme+grille[colonne][ligne];
    }
    TestVictoire(somme);
  }
  
  int somme=0;
  for(int colonne_ligne = 0; colonne_ligne<3; colonne_ligne=colonne_ligne+1){      // on parcourt une des diagonales
    somme=somme+grille[colonne_ligne][colonne_ligne];
  }
  TestVictoire(somme);
  
  somme=0;
  for(int colonne_ligne = 0; colonne_ligne<3; colonne_ligne=colonne_ligne+1){      // on parcourt l'autre diagonale
    somme=somme+grille[2-colonne_ligne][colonne_ligne];
  }
  // Quand aucune des sommes effectuées dans la grille ne donnent 3 ou 12 alors aucun des joueurs n'a gagné
  TestVictoire(somme); 
  if(compteur==9 && termine==false){         // On peut jouer 9 coups dans un morpion, si le compteur de coups arrive à 9 et que personne n'a encore gagné, on déclare le Match nul.
      PFont police;
      fill(90, 94, 107);
      police=loadFont("DeliusSwashCaps-Regular-48.vlw");
      textFont(police,37);
      text("Match nul !",55,335);
      termine = true;                        // on achève la partie
  }
}

// On trace la grille en faisant une ligne de plus pour séparer le plateau de jeu de l'endroit où on affiche les résultats.
void traceGrille(){
  strokeWeight(2);
  line(99,5,99,295);
  line(199,5,199,295);
  line(5,99,295,99);
  line(5,199,295,199);
  line(5,299,295,299);
}

