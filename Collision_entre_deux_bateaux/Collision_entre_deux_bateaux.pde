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
void setup()
{
 Bateau Cuirasse = new Bateau ();
  Cuirasse.taille=4;
  Cuirasse.x=3;
  Cuirasse.y=4;
  Cuirasse.direction=0;
 Bateau Sous_marin = new Bateau();
  Sous_marin.taille=3;
  Sous_marin.x=4;
  Sous_marin.y=3;
  Sous_marin.direction=1;
   if(Collision(Cuirasse, Sous_marin))
   {
     print("collision !");
   }
}

