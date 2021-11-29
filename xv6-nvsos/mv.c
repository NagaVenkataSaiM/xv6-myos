#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char* fmtname(char *path)
{
    static char buf[512];
    char *p;
    for(p=path+strlen(path);p>=path && *p!='/';p--);
    p++;
    memmove(buf,p,strlen(p));
    return buf;
}

char* strcat(char *d,char *s)
{
    char *temp=d;
    while(*d) ++d;
    while(*s) *d++=*s++;
    *d=0;
    return temp;
}

void move(char *from,char *to)
{
    struct stat st;
    char *buf;
    buf=(char*)malloc(512*sizeof(char));
    int fd0;
    // OPEN FILE FROM
    if((fd0=open(from,O_RDONLY))<0)
    {
        printf(2,"mv: cannot open '%s' No such file or directory\n",from);
        exit();
    }
    // IF IS A DIRECTORY
    if(fstat(fd0,&st)>=0)
    {
        if(st.type==T_DIR)
        {
            printf(2,"mv: cannot copy directory '%s'\n",from);
            exit();
        }
    }

    int fd1;
    char *temp;
    temp=(char*)malloc(512*sizeof(char));
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
    // OPEN FILE TO
    fd1=open(to,0);
    if(1)
    {
        // IF IS A DIRECTORY
        if(fstat(fd1,&st)>=0 && st.type == T_DIR)
        {
            strcat(temp,to);
            strcat(temp,"/");
            strcat(temp,from);
            close(fd1);
            if((fd1=open(temp,O_CREATE | O_WRONLY))<0)
            {
                printf(2,"mv: error while create '%s'\n",temp);
                exit();
            }
        }
        // IF IS A FILE
        else{
            close(fd1);
            if((fd1=open(to,O_CREATE | O_WRONLY))<0)
            {
                printf(2,"mv: error while create '%s'\n",to);
                exit();
            }
        }
    }
    int n;
    while((n=read(fd0,buf,sizeof(buf)))>0)
    {
        printf(fd1,"%s",buf);
    }
    close(fd1);
    free(temp);
    free(buf);
    unlink(from);
}

void mv_ls(char *path,int length,char *extension)
{
    char *buff;
    buff=(char*)malloc(512*sizeof(char*));
    int fd0,fd1;
    struct dirent de;
    struct stat st;
    if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
    if((fd0=open(".",0))<0)
    {
        printf(2,"mv: cannot open '\".\"' No such file or directory\n");
        exit();
    }

    if((fd1=open(path,O_RDONLY))<0)
    {
        printf(2,"~mv: cannot open '%s' No such file or directory\n",path);
        exit();
    }
    if(fstat(fd1,&st)<0)
    {
        printf(2,"mv: cannot stat '%s' No such file or directory\n",path);
        exit();
    }
    else
    {
        if(st.type!=T_DIR)
        {
            printf(2,"mv: '%s' is not directory\n",path);
            exit();
        }
    }
    // no need to switch because it is definitely entered into   //the directory
    strcat(buff,path);
    strcat(buff,"/");
    int len=strlen(buff);
    while(read(fd0,&de,sizeof(de))==sizeof(de))
    {
        if(de.inum==0) 
            continue;
        if(de.name[0]=='.')
            continue;
        if(stat(de.name, &st) >= 0 && st.type == T_DIR) continue;
        memmove(buff+len,de.name,strlen(de.name));
        //if(strcmp(de.name+(strlen(de.name)-length-1),extension)==0) 
        move(de.name,buff);
        memset(buff+len,'\0',sizeof(buff)+len);
    }
    free(buff);
    close(fd0);
}
void mv_rek(char *from,char *to)
{
    char *buff;
    buff=(char*)malloc(512*sizeof(char*));
    int fd0;
    struct dirent de;
    struct stat st;
    if(from[strlen(from)-1]=='/') from[strlen(from)-1]=0;
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
    printf(1,"%s\n",to);
    if((fd0=open(from,0))<0)
    {
        printf(2,"mv: cannot open '%s' No such file or directory\n",from);
        exit();
    }
    if(fstat(fd0,&st)<0)
    {
        printf(2,"mv: cannot stat '%s' No such file or directory\n",from);
        exit();
    }
    char *temp,*temp2;
    temp=(char*)malloc(512*sizeof(char*));
    temp2=(char*)malloc(512*sizeof(char*));
    switch(st.type)
    {
        case T_FILE:
        {
            move(from,to);
            break;
        }
        case T_DIR:
        {
            strcpy(buff,to);
            strcat(buff,"/");
            strcat(buff,from);
            if(mkdir(to)>=0)
            {
                while(read(fd0,&de,sizeof(de))==sizeof(de))
                {
                    if(de.inum==0 || de.name[0]=='.') 
                        continue;
                    strcpy(temp,from);
                    strcat(temp,"/");
                    strcat(temp,de.name);
                    strcpy(temp2,to);
                    strcat(temp2,"/");
                    strcat(temp2,de.name);
                    mv_rek(temp,temp2);
                }
            }
            else
            {
                while(read(fd0,&de,sizeof(de))==sizeof(de))
                {
                    if(de.inum==0 || de.name[0]=='.') 
                        continue;
                    strcpy(temp,from);
                    strcat(temp,"/");
                    strcat(temp,de.name);
                    strcpy(temp2,buff);
                    strcat(temp2,"/");
                    strcat(temp2,de.name);
                    mv_rek(temp,temp2);
                }
                unlink(temp);
            }
            unlink(to);
            break;
        }
    }
    close(fd0);
    free(temp);
    free(temp2);
    free(buff);
}

int main(int argc,char *argv[])
{
    if(argc<2)
    {
        printf(2,"Usage : mv [source] [dest]\n");
    }
    else if(strcmp(argv[1],"*")==0)
    {
        mv_rek(".",argv[2]);
        exit();
    }
    else
    {
        move(argv[1],argv[2]);
        exit();
    }
    exit();
}


