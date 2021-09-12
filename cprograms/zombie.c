#include<stdio.h>
int main(void)
{
int pid;
if(pid=fork()>0)
{
sleep(10);
}
else if(pid==0)
{
exit(0);
}
}

