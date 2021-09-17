#include<stdio.h>
int main(int argc,char** argv)
{
if(chmod(argv[1],0600)<-1)
{
printf("unable to change permissions");
}
}

