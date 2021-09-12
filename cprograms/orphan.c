#include<stdio.h>
int main(void)
{
int pid;
if((pid=fork())>0)
{
exit(10);
}
else if(pid==0){
sleep(2);
printf("CHILD: Adopted by init now,PPID: %d\n",getppid());
exit(0);
}
}

