#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<sys/wait.h>
int main()
{
int exit_code=10;
pid_t ret_value;
printf("\nThe process id is %d\n",getpid());
ret_value=fork();
if(ret_value<0)
{
printf("\nfork failure\n");
}
else if(ret_value==0)
{
printf("\nchild process\n");
printf("The process id id %d\n",getpid());
pid_t cpid= wait(NULL);
printf("Child pid=%d\n",cpid);
sleep(20);
}
else
{
      printf("parent process\n");
      printf("The process id is %d\n",getpid());
      sleep(30);
}
_Exit(exit_code);
return 0;
}

