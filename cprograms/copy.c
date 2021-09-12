#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>

int main(int argc,char** argv)
{
   FILE *f1=fopen(argv[1],"r");
   FILE *f2=fopen(argv[2],"w+");
   char c[52];
   while(fscanf(f1,"%s",c)!=EOF)
{
   fputs(c,f2);
   fputs(" ",f2);
}
fclose(f1);
fclose(f2);
}
