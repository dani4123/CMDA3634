#include
#include
#include
#include

#include "cuda.h"

int main(argc, char **argv){

	//get vector size from command line argument
	int N = atoi(argv[1]);

	//seed RNG
	double seed = clock();
	srand48(seed);

	double *h_a, *h_b, *h_c; //host vectors

	//allocate storage
	h_a = (double *) molloc(N*sizeof(double));	
	h_b = (double *) molloc(N*sizeof(double));
	h_c = (double *) molloc(N*sizeof(double));

	//populate a and b
	for(int n = 0; n<N; n++){
	h_a[n] = drand48();
	h_b[n] = drand48();
	}


	double hostStart = clock();

	//c = a+b
	for(int n =0; n<N; n++){
		h_c[n] = h_a[n] + h_b[n];
	}

	double hostEnd = clock();
	double hostTime = (hostEnd - hostStart)/(double)CLOCKS_PER_SEC;
	
	printf("the host took %f seconds to add a and b \n", hostTime);

	//device arrays
	double *d_a, *d_b, *d_c;

	cudaMalloc(&d_a,N*sizeof(double));	
	cudaMalloc(&d_b,N*sizeof(double));
	cudaMalloc(&d_c,N*sizeof(double));

	//copy data from the host to the device
	cudaMemcpy(d_a, h_a,N*sizeof(double),cudaMemcpyHostToDevice);
	cudaMemcpy(d_b, h_b,N*sizeof(double),cudaMemcpyHostToDevice);
	//cudaMemcpy(d_a, h_a,N*sizeof(double),cudaMemcpyHostToDevice);
	

	//at this point the data is allocated and populated on the device

	int Nthreads = atoi(argv[2]); //get the number of threads per block from command line
	

	kernelAddVectors <<< ,Nthreads >>>(d_a, d_b, d_c);
	
	cudaFree(d_a);
	cudaFree(d_b);
	cudaFree(d_c);


}
}
