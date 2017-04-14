#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include <time.h>
#include <unistd.h>

void half2float(uint16_t*, float* __restrict, int);
void float2half(float*, uint16_t* __restrict, int);
void double2half(double*, uint16_t* __restrict, int);
void half2double(uint16_t*, double* __restrict, int);

int main(int argc, char *argv[]) {
  int i, n = 5;
  float float1[n], float2[n];
  double double1[n], double2[n];
  unsigned short halfs[n], halfs2[n];
  srand48(time(0)+getpid());
  for(i=0; i<n; i++) {
    float1[i] = drand48();
    double1[i] = drand48();
  }
  float2half(float1, halfs, n);
  half2float(halfs, float2, n);
  double2half(double1, halfs2, n);
  half2double(halfs2, double2, n);
  for(i=0; i<n; i++)
    printf("%f:\n\t%d-bit: %hu\n\t%d-bit: %f\n",
           float1[i],
           sizeof(halfs[i]) * 8,
           halfs[i],
           sizeof(float2[i]) * 8,
           float2[i]);
  for(i=0; i<n; i++)
    printf("%f:\n\t%d-bit: %hu\n\t%d-bit: %.8f\n",
           double1[i],
           sizeof(halfs2[i]) * 8,
           halfs2[i],
           sizeof(double2[i]) * 8,
           double2[i]);
  return 0;
}
