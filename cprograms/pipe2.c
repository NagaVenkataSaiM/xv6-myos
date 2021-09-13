#include<unistd.h>
#include<stdio.h>
int main(void)
{
int fd[2];
pipe(fd);
switch(fork())
{
case 0:
close(fd[0]);
dup2(fd[1],STDOUT_FILENO);
close(fd[1]);
execlp("cat","cat","sampletextfile",(char *) 0);
default:
close(fd[1]);
dup2(fd[0],STDIN_FILENO);
close(fd[0]);
execlp("tr","tr","'[a-z]'","'[A-Z]'",(char *) 0);
}
}
