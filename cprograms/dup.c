#include<stdio.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<wait.h>
#include<unistd.h>

#define OPENFLAGS (O_WRONLY | O_CREAT | O_TRUNC)
#define MODE600 (S_IRUSR | S_IWUSR)

int main(int argc,char** argv)
{
int fd1,fd2,rv,exit_status;
if(fork()==0)
{
if((fd1=open(argv[1],O_RDONLY))==-1)
{
perror("Error in opening file for reading");
_exit(1);
}
if((fd2=open(argv[2],OPENFLAGS, MODE600))==-1)
{
perror("Error in opening file for writing");
_exit(2);
}
dup(fd1);
dup(fd2);
execvp(argv[3],&argv[3]);
perror("exec error");
_exit(3);
}
else
{
wait(&rv);
printf("Exit status: %d\n",WEXITSTATUS(rv));
}
}
