# rehla
palier1:
![alt text](image-1.png)

palier2:

Réponse 1: 
L'avatar se colle juste à côté du texte au lieu d'être à droite. 
Sans Expanded, la Column ne prend pas toute la largeur disponible pour pousser l'avatar.

Réponse 2: 
Parce que StatelessWidget est immuable. Ses variables doivent être `final` et ne changent pas.

Réponse 3: 
- Colors.teal : Couleur fixe.
- cs.primary : Couleur dynamique qui change automatiquement avec la seedColor du thème.
![alt text](image-2.png)

palier3:

Réponse 1: 
L'image va couvrir le dégradé et le texte sera difficile à lire. 
Dans un Stack, les enfants sont superposés (le dernier est au premier plan).


Réponse 2: 
L'image perd ses coins arrondis et devient un rectangle carré.


Réponse 3: 
Pour réserver de l'espace à droite afin que le texte ne se superpose pas avec le bouton "Découvrir".

![alt text](image-3.png)

palier4:


Réponse 1: 
Parce que le Spacer a besoin de savoir qu'il y a un espace disponible fini pour s'étendre. Sans Expanded, la Column a une hauteur/largeur infinie ou non contrainte horizontalement.

Réponse 2: 
Aucune ligne de code à ajouter ! Il suffit d'ajouter la 7e destination dans le fichier `lib/data/destinations.dart` et la boucle `for` s'en chargera automatiquement.

![alt text](image-4.png)

