#include <stdio.h>


extern void ftest1(void);

void ftest2(void)
{
  ftest1();
  printf("ftest2\n");
}

