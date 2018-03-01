#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#include "functions.h"

int main (int argc, char **argv) {

	//seed value for the randomizer 
  double seed;
  
  seed = clock(); //this will make your program run differently everytime
 // seed = 0; //uncomment this and you program will behave the same everytime it's run
  
  srand48(seed);


  //begin by getting user's input
	unsigned int n;

  printf("Enter a number of bits: ");
  scanf("%u",&n);

  //make sure the input makes sense
  if ((n<2)||(n>30)) {
  	printf("Unsupported bit size.\n");
		return 0;  	
  }

  int p;

  /* Q2.2: Use isProbablyPrime and randomXbitInt to find a random n-bit prime number */
  p = isProbablyPrime(randXbitInt(n)); 
// while(isProbablyPrime(p) == 0){
  //	p = randXbitInt(n);
 // }
  printf("p = %u is probably prime.\n", p);

  /* Q3.2: Use isProbablyPrime and randomXbitInt to find a new random n-bit prime number 
     which satisfies p=2*q+1 where q is also prime */
  int q;
  p = randXbitInt(n);
  q = (p-1)/2;

	printf("p = %u is probably prime and equals 2*q + 1. q= %u and is also probably prime.\n", p, q);  

	/* Q3.3: use the fact that p=2*q+1 to quickly find a generator */
	unsigned int g = findGenerator(p);

	printf("g = %u is a generator of Z_%u \n", g, p); 
	unsigned int x = randXbitInt(n)%p;
	int h = modExp(g, x, p);
	int found = 0;
	for(int i =1; i<p; i++)
	{
		if(modExp(g, i, p) == h)
		{
			found = i;
			break;
		}
	}
	printf("the x found = %u\n", found);
  return 0;
}
