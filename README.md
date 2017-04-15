# halfprec
Half-precision assembly interface for C


### Synopsis

This library converts 32-bit floats and 64-bit doubles to/from [IEEE 754-2008](https://en.wikipedia.org/wiki/Half-precision_floating-point_format) half-precision floating point format.

Consider a simple example:

```c
#include...

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
```

the output would be:

```
0.577040:
  16-bit: 14493
  32-bit: 0.576660
0.224310:
  16-bit: 13101
  32-bit: 0.224243
0.826046:
  16-bit: 15003
  32-bit: 0.825684
0.353371:
  16-bit: 13735
  32-bit: 0.353271
0.891227:
  16-bit: 15137
  32-bit: 0.891113
0.657668:
  16-bit: 14658
  64-bit: 0.65722656
0.656961:
  16-bit: 14657
  64-bit: 0.65673828
0.729467:
  16-bit: 14805
  64-bit: 0.72900391
0.270145:
  16-bit: 13394
  64-bit: 0.27001953
0.789711:
  16-bit: 14929
  64-bit: 0.78955078
```

and all you have to do to run it is:

```
nasm -felf64 src/halfprec.asm -o obj/halfprec.o;
gcc -Wall target.c obj/halfprec.o -o program;
./program
```

I've currently tested this under:
  - Operating System: Centos 7
  - GCC: 4.8.5 20150623 (Red Hat 4.8.5-11)
  - NASM: 2.10.07

### Vagrant

There is also a Vagrantfile that provisions a centos 7 environment with all the packages you'd need for development. Bring it up with `vagrant up && vagrant ssh`. The project directory is in `/home/vagrant/halfprec`.
