#include<stdio.h>
#include<unistd.h>
int main(void)
{
int n;
int fd[2];
char buf[100];
if(pipe(fd)<0)
{
perror("pipe");
exit(1);
}
switch(fork())
{
case -1: perror("Fork error");
exit(1);
case 0:
close(fd[1]);
n=read(fd[0],buf,100);
write(STDOUT_FILENO,buf,n);
break;
default:
close(fd[0]);
write(fd[1],"Writing to pipe\n",16);
}
exit(0);
}

