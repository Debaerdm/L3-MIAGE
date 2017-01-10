#include <stdio.h>


extern void ftest2(void);

int main(void)
{
  ftest2();
  printf("main\n");
  return 0;
}

