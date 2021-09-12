#include<stdio.h>
#include<errno.h>
int main(void)
{
extern int errno;
int i;
for(i=0;i<errno;i++)
{
printf("%d: %s\n",i,strerror(i));
}
printf("Number of errors available:%d\n",errno);
_Exit(0);
}
