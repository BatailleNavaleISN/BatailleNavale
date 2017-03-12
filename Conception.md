# Représentation des bateaux
### Un bateau est représenté par : 
* Sa taille (le nombre de cases qu'il occupe)
* Son orientation (s'il est placé de manière horizontale ou verticale)

Pour représenter les éléments du bateau qui sont touchés on va utiliser un tableau
à une seule dimension et de longueur 5 (la taille maximale d'un bateau).

On utilisera seulement les n premières cases (correspondant aux nombres de cases occupées par le bateau (par exemple pour un bateau de 2 cases on ne va remplir que les deux premières cases du tableau à 5 cases))

Les cases utilisées dans le tableau seront remplies avec des 0 tant que le bateau n'est pas touché, puis on remplacera les 0 par des 1 quand le bateau sera touché. 

Les bateaux seront placés sur une grille de coordonnées (x,y) et définis par la coordonnée du point le plus en haut à gauche

Par exemple un bateau de deux cases placé au coin supérieur gauche du plateau de jeu sera défini par les coordonnées (0,0) car la case occupée par le bateau qui est le plus en haut à gauche à pour coordonnées (0,0)

L'orientation sera codée avec un 0 si le bateau est horizontal et avec un 1 s'il est vertical

### Exemples : 
Un bateau de 3 cases orienté verticalement et situé dans le coin inférieur droit d'un plateau de jeu à 100 cases (10x10):

On codera ses coordonnées par : (10,7) ; 1

Il ne pourra évidemment pas dépasser le plateau de jeu
