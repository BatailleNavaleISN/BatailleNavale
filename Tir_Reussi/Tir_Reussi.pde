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
void setup()
{
  Bateau Cuirasse = new Bateau ();
  Cuirasse.taille=4;
  Cuirasse.x=3;
  Cuirasse.y=5;
  Cuirasse.direction=0;
  for (int i=0; i<10; i=i+1)
  {
    for (int j=0; j<10; j=j+1)
    {
      if ( TirReussi(Cuirasse, i, j)==true)
      {
        print (i);
        print(",");
        print (j);
        println (" touché");
        if (Coule(Cuirasse)==true) {
          println("Coulé!");
        }
      }
    }
  }
}

