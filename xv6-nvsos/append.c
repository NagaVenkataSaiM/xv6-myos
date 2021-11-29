#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
       char c[52];
char s[500];
       int n;
int z=0;
      int f1=open(argv[1], O_CREATE|O_RDWR);

      while((n=read(f1,c,sizeof(c)))>0){
      int i=0;
      while(c[i]!='\0')
{
     s[z]=c[i];
     z++;
 i++;
}
 }
int i=2;
for(i=2;i<=argc;i++)
{
int j=0;
for(j=0;j<=sizeof(argv[i]);j++)
{
s[z]=argv[i][j];
z++;
}
}
printf(1,s);
      close(f1);
      exit();
}

