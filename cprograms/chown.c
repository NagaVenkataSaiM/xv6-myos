#include<stdio.h>
int main(int argc,char** argv)
{
if(chown(argv[1],-1,62)<0)
{
printf("unable to get permissions");
}
}
