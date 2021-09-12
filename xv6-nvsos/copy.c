#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       char c[52];
       int n;
      int f1=open(argv[1], O_CREATE|O_RDWR);
      int f2=open(argv[2], O_CREATE|O_RDWR);
      while((n=read(f1,c,sizeof(c)))>0){
      write(f2,c,n);
      }
      close(f1);
      close(f2);
      exit();
}
