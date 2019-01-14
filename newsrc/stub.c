/* #include <stdlib.h> */
#include <caml/mlvalues.h>

/* Code for benchmarking purposes only! */
/* Assume 64-bit Intel target and GCC Compiler */

#define int64_bsr _bit_scan_reverse

uint64_t __inline int64_bsr(uint64_t a)
{
  uint64_t b;
  __asm__ __volatile__ ("bsr" : "=b" (b) : "a" (a));
  return b;
}


CAMLprim value stub_int_bsr(value v1)
{
  /* Do not use Long_val(v1) conversion and preserve the tag. It
     guarantees that the input to builtin_clz is non-zero, to guard
     against versions of builtin_clz that are undefined for intput 0.
     Adjust the resulting index to account for the tag.
  */
  return Val_long(int64_bsr((uint64_t)v1)-1);
}
