#include<stdio.h>
#include<fcntl.h>
#include<sys/stat.h>

#define BUFSIZE 1024

int main(void)
{
int fd1,fd2;
int n;
char buf[BUFSIZE];
if((fd1=open("/etc/passwd",O_RDONLY))==-1)
{
perror("open error");
}
if((fd2=open("passwd.bak",O_WRONLY | O_CREAT | O_TRUNC , S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH)) == -1)
{
perror("open2 error");
}
while((n=read(fd1,buf,BUFSIZE))>0)
{
if(n!=write(fd2,buf,n))
{
perror("write");
}
}
close(fd1);
close(fd2);
exit(0);
}
