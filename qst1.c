#include<stdio.h>
#include<stdlib.h>
#define N 100000000 //N vaut 100 millions.

void calcul(float* A, float* B);

int main(int argc, char* argv[]){
  //malloc n'initialise pas contrairement a calloc qui initialise le tout a 0.
  //on parle d'initialisation c'est à dire remplacer les valeurs existantes
  //sur les adresses allouées par de nouvelles.
  float* A=(float*)malloc(sizeof(float)*N);//malloc retourne un void*
  //on alloue N emplacements memoire correspondant a des valeurs
  //de 32 bits logées dans chaque emplacement.
  float* B=(float*)malloc(sizeof(float)*N);
  for(int j=0;j<N;j++){
    A[j]=1;B[j]=1;}
  //pour verifier le resultat final seulement.(sinon des valeurs sans un clean''
  //avant ne permet pas de predire les valeurs dans les 2 tableaux et donc
  //pas de verification possible)
  calcul(A,B);
  for(int k=0;k<5;k++){
    printf("%.2f -- ",A[k]);}
  printf("\n");
  return 0;
}


void calcul(float* A, float* B){
  for(int i=0;i<N;i++){
    A[i]=A[i]*A[i]*2.5;
    A[i]+=B[i]*B[i]*B[i];//la fonction pow de math.h est a eviter
  }
}
