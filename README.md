# halfprec
Half-precision assembly interface for C


##### Synopsis

This library converts 32-bit floats to [IEEE 754-2008](https://en.wikipedia.org/wiki/Half-precision_floating-point_format) half-precision floating point format.

Consider a simple example:

```
#include...

void half2float(float* __restrict out, uint16_t* in, int n);
void float2half(uint16_t* __restrict out, float* in, int n);

int main(int argc, char *argv[]) {
  int i, n = 5;
  float float1[n], float2[n];
  unsigned short halfs[n];
  srand48(time(0)+getpid());
  for(i=0; i<n; i++)
    float1[i] = drand48();
  float2half(halfs, float1, n);
  half2float(float2, halfs, n);
  for(i=0; i<n; i++)
    printf("%f converted to %hu converted to %f\n", float1[i], halfs[i], float2[i]);
  return 0;
}
```

the output would be:

```
0.142886 converted to 12434 converted to 0.142822
0.728122 converted to 14803 converted to 0.728027
0.386010 converted to 13869 converted to 0.385986
0.002425 converted to 6391 converted to 0.002424
0.622540 converted to 14586 converted to 0.622070
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

##### Vagrant

There is also a Vagrantfile that provisions a centos 7 environment with all the packages you'd need for development. Bring it up with `vagrant up && vagrant ssh`. The project directory is in `/home/vagrant/halfprec`.
