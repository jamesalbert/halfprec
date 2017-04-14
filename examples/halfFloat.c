#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <time.h>
#include <unistd.h>

// Convert array of single precision to half-precision.
void half2float(uint16_t*, float* __restrict, int);
void float2half(float*, uint16_t* __restrict, int);
void double2half(double*, uint16_t* __restrict, int);
void half2double(uint16_t*, double* __restrict, int);

// Call on command line with one integer, the size of the array to convert.
int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("usage: ./halfFloat <number of ints>\n");
    exit(1);
  }
  int i, n = atoi(argv[1]);
  float float1[n], float2[n]; // 4 bytes = 32 bits; double would be 8 bytes (64 bits)
  unsigned short halfs[n]; // short = 2 bytes = 16 bits
  srand48(time(0)+getpid());	// seed the random number generator

  //printf("generating numbers:\n");
  for(i=0; i<n; i++)
    float1[i] = 2*drand48()-1;	// uniformly between -1 and 1.
  float2half(float1, halfs, n);
  half2float(halfs, float2, n);

  for(i=0; i<n; i++) {
    // all numbers smaller than this will come back zero:
    // But if this occurs please check the actual size of float1[i], maybe my constant is a bit off.
    //printf("%f -> %f\n", float1[i], float2[i]);
    if(float2[i] == 0.0) assert(fabs(float1[i]) < 6.10352e-05); // 2^(-14)
    else assert(fabs(float1[i]-float2[i]) < 4.8828125e-4); // 2^-11
  }
  return 0;
}
