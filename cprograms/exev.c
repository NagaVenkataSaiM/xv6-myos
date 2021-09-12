#include<stdio.h>
#include<unistd.h>
int main()
{
printf("file is exev.c\n");
printf("PID of exec.v is %d\n",getpid());
char *args[]={"./hello",NULL};
int pid=fork();
if(pid>0)
{
execv(args[0],args);
}
else
{
sleep(3);
printf("coming back to exev.c\n");
exit(0);
}
return 0;
}
