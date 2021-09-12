#include <stdio.h>
#include<wait.h>
int main(int argc,char** argv)
{
int returnval;
switch(fork())
{
case 0:
if((execv(argv[1],&argv[2])<0))
{
fprintf(stderr,"execl error\n");
exit(200);
}
default:
wait(&returnval);
fprintf(stderr,"Exit status:%d\n",WEXITSTATUS(returnval));
exit(0);
}
}
