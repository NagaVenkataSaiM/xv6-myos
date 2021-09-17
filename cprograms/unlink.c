#include<stdio.h>
#include<stdlib.h>
int main(int argc,char** argv)
{
if(unlink(argv[1])<0)
{
printf("cant unlink");
}
exit(0);
}
