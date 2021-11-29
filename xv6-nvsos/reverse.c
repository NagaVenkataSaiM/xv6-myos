#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       char c[52];
          
       int n;
       int k;
      int f1=open(argv[1], O_CREATE|O_RDWR);
      
      while((n=read(f1,c,sizeof(c)))>0){
       k=n;
       while(k>-1)
{
printf(1,"%c",c[k]);
k--;
}
      }
      close(f1);
     
      exit();
}

