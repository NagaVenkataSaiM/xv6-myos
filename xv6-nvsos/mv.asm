
_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    free(temp2);
    free(buff);
}

int main(int argc,char *argv[])
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	53                   	push   %ebx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	83 ec 10             	sub    $0x10,%esp
       a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    if(argc<2)
       d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
      11:	7e 3f                	jle    52 <main+0x52>
    {
        printf(2,"Usage : mv [source] [dest]\n");
    }
    else if(strcmp(argv[1],"*")==0)
      13:	c7 44 24 04 ed 11 00 	movl   $0x11ed,0x4(%esp)
      1a:	00 
      1b:	8b 43 04             	mov    0x4(%ebx),%eax
      1e:	89 04 24             	mov    %eax,(%esp)
      21:	e8 da 09 00 00       	call   a00 <strcmp>
      26:	85 c0                	test   %eax,%eax
    {
        mv_rek(".",argv[2]);
      28:	8b 43 08             	mov    0x8(%ebx),%eax
      2b:	89 44 24 04          	mov    %eax,0x4(%esp)
    else if(strcmp(argv[1],"*")==0)
      2f:	75 11                	jne    42 <main+0x42>
        mv_rek(".",argv[2]);
      31:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
      38:	e8 73 05 00 00       	call   5b0 <mv_rek>
        exit();
      3d:	e8 b0 0b 00 00       	call   bf2 <exit>
    }
    else
    {
        move(argv[1],argv[2]);
      42:	8b 43 04             	mov    0x4(%ebx),%eax
      45:	89 04 24             	mov    %eax,(%esp)
      48:	e8 c3 00 00 00       	call   110 <move>
        exit();
      4d:	e8 a0 0b 00 00       	call   bf2 <exit>
        printf(2,"Usage : mv [source] [dest]\n");
      52:	c7 44 24 04 d1 11 00 	movl   $0x11d1,0x4(%esp)
      59:	00 
      5a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      61:	e8 da 0c 00 00       	call   d40 <printf>
    }
    exit();
      66:	e8 87 0b 00 00       	call   bf2 <exit>
      6b:	66 90                	xchg   %ax,%ax
      6d:	66 90                	xchg   %ax,%ax
      6f:	90                   	nop

00000070 <fmtname>:
{
      70:	55                   	push   %ebp
      71:	89 e5                	mov    %esp,%ebp
      73:	53                   	push   %ebx
      74:	83 ec 14             	sub    $0x14,%esp
      77:	8b 5d 08             	mov    0x8(%ebp),%ebx
    for(p=path+strlen(path);p>=path && *p!='/';p--);
      7a:	89 1c 24             	mov    %ebx,(%esp)
      7d:	e8 ce 09 00 00       	call   a50 <strlen>
      82:	01 d8                	add    %ebx,%eax
      84:	73 0c                	jae    92 <fmtname+0x22>
      86:	eb 0f                	jmp    97 <fmtname+0x27>
      88:	83 e8 01             	sub    $0x1,%eax
      8b:	39 c3                	cmp    %eax,%ebx
      8d:	8d 76 00             	lea    0x0(%esi),%esi
      90:	77 05                	ja     97 <fmtname+0x27>
      92:	80 38 2f             	cmpb   $0x2f,(%eax)
      95:	75 f1                	jne    88 <fmtname+0x18>
    p++;
      97:	8d 58 01             	lea    0x1(%eax),%ebx
    memmove(buf,p,strlen(p));
      9a:	89 1c 24             	mov    %ebx,(%esp)
      9d:	e8 ae 09 00 00       	call   a50 <strlen>
      a2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
      a6:	c7 04 24 60 15 00 00 	movl   $0x1560,(%esp)
      ad:	89 44 24 08          	mov    %eax,0x8(%esp)
      b1:	e8 0a 0b 00 00       	call   bc0 <memmove>
}
      b6:	83 c4 14             	add    $0x14,%esp
      b9:	b8 60 15 00 00       	mov    $0x1560,%eax
      be:	5b                   	pop    %ebx
      bf:	5d                   	pop    %ebp
      c0:	c3                   	ret    
      c1:	eb 0d                	jmp    d0 <strcat>
      c3:	90                   	nop
      c4:	90                   	nop
      c5:	90                   	nop
      c6:	90                   	nop
      c7:	90                   	nop
      c8:	90                   	nop
      c9:	90                   	nop
      ca:	90                   	nop
      cb:	90                   	nop
      cc:	90                   	nop
      cd:	90                   	nop
      ce:	90                   	nop
      cf:	90                   	nop

000000d0 <strcat>:
{
      d0:	55                   	push   %ebp
      d1:	89 e5                	mov    %esp,%ebp
      d3:	8b 45 08             	mov    0x8(%ebp),%eax
      d6:	53                   	push   %ebx
      d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    while(*d) ++d;
      da:	80 38 00             	cmpb   $0x0,(%eax)
      dd:	89 c2                	mov    %eax,%edx
      df:	74 20                	je     101 <strcat+0x31>
      e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      e8:	83 c2 01             	add    $0x1,%edx
      eb:	80 3a 00             	cmpb   $0x0,(%edx)
      ee:	75 f8                	jne    e8 <strcat+0x18>
    while(*s) *d++=*s++;
      f0:	0f b6 0b             	movzbl (%ebx),%ecx
      f3:	84 c9                	test   %cl,%cl
      f5:	74 11                	je     108 <strcat+0x38>
      f7:	90                   	nop
      f8:	83 c2 01             	add    $0x1,%edx
      fb:	83 c3 01             	add    $0x1,%ebx
      fe:	88 4a ff             	mov    %cl,-0x1(%edx)
     101:	0f b6 0b             	movzbl (%ebx),%ecx
     104:	84 c9                	test   %cl,%cl
     106:	75 f0                	jne    f8 <strcat+0x28>
    *d=0;
     108:	c6 02 00             	movb   $0x0,(%edx)
}
     10b:	5b                   	pop    %ebx
     10c:	5d                   	pop    %ebp
     10d:	c3                   	ret    
     10e:	66 90                	xchg   %ax,%ax

00000110 <move>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	57                   	push   %edi
     114:	56                   	push   %esi
     115:	53                   	push   %ebx
     116:	83 ec 4c             	sub    $0x4c,%esp
    buf=(char*)malloc(512*sizeof(char));
     119:	c7 04 24 00 02 00 00 	movl   $0x200,(%esp)
     120:	e8 9b 0e 00 00       	call   fc0 <malloc>
    if((fd0=open(from,O_RDONLY))<0)
     125:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     12c:	00 
    buf=(char*)malloc(512*sizeof(char));
     12d:	89 c3                	mov    %eax,%ebx
    if((fd0=open(from,O_RDONLY))<0)
     12f:	8b 45 08             	mov    0x8(%ebp),%eax
     132:	89 04 24             	mov    %eax,(%esp)
     135:	e8 f8 0a 00 00       	call   c32 <open>
     13a:	85 c0                	test   %eax,%eax
     13c:	89 c6                	mov    %eax,%esi
     13e:	0f 88 06 02 00 00    	js     34a <move+0x23a>
    if(fstat(fd0,&st)>=0)
     144:	8d 7d d4             	lea    -0x2c(%ebp),%edi
     147:	89 7c 24 04          	mov    %edi,0x4(%esp)
     14b:	89 04 24             	mov    %eax,(%esp)
     14e:	e8 f7 0a 00 00       	call   c4a <fstat>
     153:	85 c0                	test   %eax,%eax
     155:	78 0b                	js     162 <move+0x52>
        if(st.type==T_DIR)
     157:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     15c:	0f 84 c8 01 00 00    	je     32a <move+0x21a>
    temp=(char*)malloc(512*sizeof(char));
     162:	c7 04 24 00 02 00 00 	movl   $0x200,(%esp)
     169:	e8 52 0e 00 00       	call   fc0 <malloc>
     16e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     171:	8b 45 0c             	mov    0xc(%ebp),%eax
     174:	89 04 24             	mov    %eax,(%esp)
     177:	e8 d4 08 00 00       	call   a50 <strlen>
     17c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     17f:	80 7c 01 ff 2f       	cmpb   $0x2f,-0x1(%ecx,%eax,1)
     184:	0f 84 76 01 00 00    	je     300 <move+0x1f0>
    fd1=open(to,0);
     18a:	8b 45 0c             	mov    0xc(%ebp),%eax
     18d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     194:	00 
     195:	89 04 24             	mov    %eax,(%esp)
     198:	e8 95 0a 00 00       	call   c32 <open>
        if(fstat(fd1,&st)>=0 && st.type == T_DIR)
     19d:	89 7c 24 04          	mov    %edi,0x4(%esp)
     1a1:	89 04 24             	mov    %eax,(%esp)
    fd1=open(to,0);
     1a4:	89 45 c0             	mov    %eax,-0x40(%ebp)
        if(fstat(fd1,&st)>=0 && st.type == T_DIR)
     1a7:	e8 9e 0a 00 00       	call   c4a <fstat>
     1ac:	85 c0                	test   %eax,%eax
     1ae:	78 0b                	js     1bb <move+0xab>
     1b0:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     1b5:	0f 84 8d 00 00 00    	je     248 <move+0x138>
            close(fd1);
     1bb:	8b 45 c0             	mov    -0x40(%ebp),%eax
     1be:	89 04 24             	mov    %eax,(%esp)
     1c1:	e8 54 0a 00 00       	call   c1a <close>
            if((fd1=open(to,O_CREATE | O_WRONLY))<0)
     1c6:	8b 45 0c             	mov    0xc(%ebp),%eax
     1c9:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
     1d0:	00 
     1d1:	89 04 24             	mov    %eax,(%esp)
     1d4:	e8 59 0a 00 00       	call   c32 <open>
     1d9:	85 c0                	test   %eax,%eax
     1db:	89 c7                	mov    %eax,%edi
     1dd:	79 1d                	jns    1fc <move+0xec>
     1df:	e9 86 01 00 00       	jmp    36a <move+0x25a>
     1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(fd1,"%s",buf);
     1e8:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     1ec:	c7 44 24 04 ad 11 00 	movl   $0x11ad,0x4(%esp)
     1f3:	00 
     1f4:	89 3c 24             	mov    %edi,(%esp)
     1f7:	e8 44 0b 00 00       	call   d40 <printf>
    while((n=read(fd0,buf,sizeof(buf)))>0)
     1fc:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
     203:	00 
     204:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     208:	89 34 24             	mov    %esi,(%esp)
     20b:	e8 fa 09 00 00       	call   c0a <read>
     210:	85 c0                	test   %eax,%eax
     212:	7f d4                	jg     1e8 <move+0xd8>
    close(fd1);
     214:	89 3c 24             	mov    %edi,(%esp)
     217:	e8 fe 09 00 00       	call   c1a <close>
    free(temp);
     21c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     21f:	89 04 24             	mov    %eax,(%esp)
     222:	e8 09 0d 00 00       	call   f30 <free>
    free(buf);
     227:	89 1c 24             	mov    %ebx,(%esp)
     22a:	e8 01 0d 00 00       	call   f30 <free>
    unlink(from);
     22f:	8b 45 08             	mov    0x8(%ebp),%eax
     232:	89 04 24             	mov    %eax,(%esp)
     235:	e8 08 0a 00 00       	call   c42 <unlink>
}
     23a:	83 c4 4c             	add    $0x4c,%esp
     23d:	5b                   	pop    %ebx
     23e:	5e                   	pop    %esi
     23f:	5f                   	pop    %edi
     240:	5d                   	pop    %ebp
     241:	c3                   	ret    
     242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(*d) ++d;
     248:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     24b:	80 38 00             	cmpb   $0x0,(%eax)
     24e:	0f 84 c6 00 00 00    	je     31a <move+0x20a>
     254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     258:	83 c0 01             	add    $0x1,%eax
     25b:	80 38 00             	cmpb   $0x0,(%eax)
     25e:	75 f8                	jne    258 <move+0x148>
    while(*s) *d++=*s++;
     260:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     263:	0f b6 11             	movzbl (%ecx),%edx
     266:	84 d2                	test   %dl,%dl
     268:	74 16                	je     280 <move+0x170>
     26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     270:	83 c0 01             	add    $0x1,%eax
     273:	83 c1 01             	add    $0x1,%ecx
     276:	88 50 ff             	mov    %dl,-0x1(%eax)
     279:	0f b6 11             	movzbl (%ecx),%edx
     27c:	84 d2                	test   %dl,%dl
     27e:	75 f0                	jne    270 <move+0x160>
    *d=0;
     280:	c6 00 00             	movb   $0x0,(%eax)
    while(*d) ++d;
     283:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     286:	80 38 00             	cmpb   $0x0,(%eax)
     289:	0f 84 93 00 00 00    	je     322 <move+0x212>
     28f:	90                   	nop
     290:	83 c0 01             	add    $0x1,%eax
     293:	80 38 00             	cmpb   $0x0,(%eax)
     296:	75 f8                	jne    290 <move+0x180>
    while(*s) *d++=*s++;
     298:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     29b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     29f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     2a2:	80 38 00             	cmpb   $0x0,(%eax)
     2a5:	74 6e                	je     315 <move+0x205>
     2a7:	90                   	nop
     2a8:	83 c0 01             	add    $0x1,%eax
     2ab:	80 38 00             	cmpb   $0x0,(%eax)
     2ae:	75 f8                	jne    2a8 <move+0x198>
    while(*s) *d++=*s++;
     2b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
     2b3:	0f b6 11             	movzbl (%ecx),%edx
     2b6:	84 d2                	test   %dl,%dl
     2b8:	74 16                	je     2d0 <move+0x1c0>
     2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     2c0:	83 c0 01             	add    $0x1,%eax
     2c3:	83 c1 01             	add    $0x1,%ecx
     2c6:	88 50 ff             	mov    %dl,-0x1(%eax)
     2c9:	0f b6 11             	movzbl (%ecx),%edx
     2cc:	84 d2                	test   %dl,%dl
     2ce:	75 f0                	jne    2c0 <move+0x1b0>
    *d=0;
     2d0:	c6 00 00             	movb   $0x0,(%eax)
            close(fd1);
     2d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
     2d6:	89 04 24             	mov    %eax,(%esp)
     2d9:	e8 3c 09 00 00       	call   c1a <close>
            if((fd1=open(temp,O_CREATE | O_WRONLY))<0)
     2de:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     2e1:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
     2e8:	00 
     2e9:	89 04 24             	mov    %eax,(%esp)
     2ec:	e8 41 09 00 00       	call   c32 <open>
     2f1:	85 c0                	test   %eax,%eax
     2f3:	89 c7                	mov    %eax,%edi
     2f5:	0f 89 01 ff ff ff    	jns    1fc <move+0xec>
                printf(2,"mv: error while create '%s'\n",temp);
     2fb:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     2fe:	eb 6d                	jmp    36d <move+0x25d>
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     300:	89 0c 24             	mov    %ecx,(%esp)
     303:	e8 48 07 00 00       	call   a50 <strlen>
     308:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     30b:	c6 44 01 ff 00       	movb   $0x0,-0x1(%ecx,%eax,1)
     310:	e9 75 fe ff ff       	jmp    18a <move+0x7a>
    while(*d) ++d;
     315:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     318:	eb 96                	jmp    2b0 <move+0x1a0>
     31a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     31d:	e9 3e ff ff ff       	jmp    260 <move+0x150>
     322:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     325:	e9 6e ff ff ff       	jmp    298 <move+0x188>
            printf(2,"mv: cannot copy directory '%s'\n",from);
     32a:	8b 45 08             	mov    0x8(%ebp),%eax
     32d:	c7 44 24 04 d8 10 00 	movl   $0x10d8,0x4(%esp)
     334:	00 
     335:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     33c:	89 44 24 08          	mov    %eax,0x8(%esp)
     340:	e8 fb 09 00 00       	call   d40 <printf>
            exit();
     345:	e8 a8 08 00 00       	call   bf2 <exit>
        printf(2,"mv: cannot open '%s' No such file or directory\n",from);
     34a:	8b 45 08             	mov    0x8(%ebp),%eax
     34d:	c7 44 24 04 a8 10 00 	movl   $0x10a8,0x4(%esp)
     354:	00 
     355:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     35c:	89 44 24 08          	mov    %eax,0x8(%esp)
     360:	e8 db 09 00 00       	call   d40 <printf>
        exit();
     365:	e8 88 08 00 00       	call   bf2 <exit>
                printf(2,"mv: error while create '%s'\n",to);
     36a:	8b 45 0c             	mov    0xc(%ebp),%eax
     36d:	89 44 24 08          	mov    %eax,0x8(%esp)
     371:	c7 44 24 04 90 11 00 	movl   $0x1190,0x4(%esp)
     378:	00 
     379:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     380:	e8 bb 09 00 00       	call   d40 <printf>
                exit();
     385:	e8 68 08 00 00       	call   bf2 <exit>
     38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <mv_ls>:
{
     390:	55                   	push   %ebp
     391:	89 e5                	mov    %esp,%ebp
     393:	57                   	push   %edi
     394:	56                   	push   %esi
     395:	53                   	push   %ebx
     396:	83 ec 5c             	sub    $0x5c,%esp
     399:	8b 75 08             	mov    0x8(%ebp),%esi
    buff=(char*)malloc(512*sizeof(char*));
     39c:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     3a3:	e8 18 0c 00 00       	call   fc0 <malloc>
    if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     3a8:	89 34 24             	mov    %esi,(%esp)
    buff=(char*)malloc(512*sizeof(char*));
     3ab:	89 c7                	mov    %eax,%edi
    if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     3ad:	e8 9e 06 00 00       	call   a50 <strlen>
     3b2:	80 7c 06 ff 2f       	cmpb   $0x2f,-0x1(%esi,%eax,1)
     3b7:	0f 84 6b 01 00 00    	je     528 <mv_ls+0x198>
    if((fd0=open(".",0))<0)
     3bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3c4:	00 
     3c5:	c7 04 24 b0 11 00 00 	movl   $0x11b0,(%esp)
     3cc:	e8 61 08 00 00       	call   c32 <open>
     3d1:	85 c0                	test   %eax,%eax
     3d3:	89 c3                	mov    %eax,%ebx
     3d5:	0f 88 5f 01 00 00    	js     53a <mv_ls+0x1aa>
    if((fd1=open(path,O_RDONLY))<0)
     3db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3e2:	00 
     3e3:	89 34 24             	mov    %esi,(%esp)
     3e6:	e8 47 08 00 00       	call   c32 <open>
     3eb:	85 c0                	test   %eax,%eax
     3ed:	0f 88 9a 01 00 00    	js     58d <mv_ls+0x1fd>
    if(fstat(fd1,&st)<0)
     3f3:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
     3f6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     3fa:	89 04 24             	mov    %eax,(%esp)
     3fd:	e8 48 08 00 00       	call   c4a <fstat>
     402:	85 c0                	test   %eax,%eax
     404:	0f 88 66 01 00 00    	js     570 <mv_ls+0x1e0>
        if(st.type!=T_DIR)
     40a:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     40f:	0f 85 3e 01 00 00    	jne    553 <mv_ls+0x1c3>
    while(*d) ++d;
     415:	80 3f 00             	cmpb   $0x0,(%edi)
     418:	89 f8                	mov    %edi,%eax
     41a:	74 1d                	je     439 <mv_ls+0xa9>
     41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     420:	83 c0 01             	add    $0x1,%eax
     423:	80 38 00             	cmpb   $0x0,(%eax)
     426:	75 f8                	jne    420 <mv_ls+0x90>
    while(*s) *d++=*s++;
     428:	0f b6 16             	movzbl (%esi),%edx
     42b:	84 d2                	test   %dl,%dl
     42d:	74 11                	je     440 <mv_ls+0xb0>
     42f:	90                   	nop
     430:	83 c0 01             	add    $0x1,%eax
     433:	83 c6 01             	add    $0x1,%esi
     436:	88 50 ff             	mov    %dl,-0x1(%eax)
     439:	0f b6 16             	movzbl (%esi),%edx
     43c:	84 d2                	test   %dl,%dl
     43e:	75 f0                	jne    430 <mv_ls+0xa0>
    *d=0;
     440:	c6 00 00             	movb   $0x0,(%eax)
    while(*d) ++d;
     443:	89 f8                	mov    %edi,%eax
     445:	80 3f 00             	cmpb   $0x0,(%edi)
     448:	74 0e                	je     458 <mv_ls+0xc8>
     44a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     450:	83 c0 01             	add    $0x1,%eax
     453:	80 38 00             	cmpb   $0x0,(%eax)
     456:	75 f8                	jne    450 <mv_ls+0xc0>
    while(*s) *d++=*s++;
     458:	c6 00 2f             	movb   $0x2f,(%eax)
     45b:	8d 75 c4             	lea    -0x3c(%ebp),%esi
    *d=0;
     45e:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    int len=strlen(buff);
     462:	89 3c 24             	mov    %edi,(%esp)
     465:	e8 e6 05 00 00       	call   a50 <strlen>
     46a:	89 45 b0             	mov    %eax,-0x50(%ebp)
        memmove(buff+len,de.name,strlen(de.name));
     46d:	01 f8                	add    %edi,%eax
     46f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
     472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(read(fd0,&de,sizeof(de))==sizeof(de))
     478:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     47f:	00 
     480:	89 74 24 04          	mov    %esi,0x4(%esp)
     484:	89 1c 24             	mov    %ebx,(%esp)
     487:	e8 7e 07 00 00       	call   c0a <read>
     48c:	83 f8 10             	cmp    $0x10,%eax
     48f:	75 7f                	jne    510 <mv_ls+0x180>
        if(de.inum==0) 
     491:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     496:	74 e0                	je     478 <mv_ls+0xe8>
        if(de.name[0]=='.')
     498:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     49c:	74 da                	je     478 <mv_ls+0xe8>
        if(stat(de.name, &st) >= 0 && st.type == T_DIR) continue;
     49e:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     4a1:	89 44 24 04          	mov    %eax,0x4(%esp)
     4a5:	8d 45 c6             	lea    -0x3a(%ebp),%eax
     4a8:	89 04 24             	mov    %eax,(%esp)
     4ab:	e8 90 06 00 00       	call   b40 <stat>
     4b0:	85 c0                	test   %eax,%eax
     4b2:	78 07                	js     4bb <mv_ls+0x12b>
     4b4:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     4b9:	74 bd                	je     478 <mv_ls+0xe8>
        memmove(buff+len,de.name,strlen(de.name));
     4bb:	8d 45 c6             	lea    -0x3a(%ebp),%eax
     4be:	89 04 24             	mov    %eax,(%esp)
     4c1:	e8 8a 05 00 00       	call   a50 <strlen>
     4c6:	89 44 24 08          	mov    %eax,0x8(%esp)
     4ca:	8d 45 c6             	lea    -0x3a(%ebp),%eax
     4cd:	89 44 24 04          	mov    %eax,0x4(%esp)
     4d1:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     4d4:	89 04 24             	mov    %eax,(%esp)
     4d7:	e8 e4 06 00 00       	call   bc0 <memmove>
        move(de.name,buff);
     4dc:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     4df:	89 0c 24             	mov    %ecx,(%esp)
     4e2:	89 7c 24 04          	mov    %edi,0x4(%esp)
     4e6:	e8 25 fc ff ff       	call   110 <move>
        memset(buff+len,'\0',sizeof(buff)+len);
     4eb:	8b 4d b0             	mov    -0x50(%ebp),%ecx
     4ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4f5:	00 
     4f6:	8d 41 04             	lea    0x4(%ecx),%eax
     4f9:	89 44 24 08          	mov    %eax,0x8(%esp)
     4fd:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     500:	89 04 24             	mov    %eax,(%esp)
     503:	e8 78 05 00 00       	call   a80 <memset>
     508:	e9 6b ff ff ff       	jmp    478 <mv_ls+0xe8>
     50d:	8d 76 00             	lea    0x0(%esi),%esi
    free(buff);
     510:	89 3c 24             	mov    %edi,(%esp)
     513:	e8 18 0a 00 00       	call   f30 <free>
    close(fd0);
     518:	89 1c 24             	mov    %ebx,(%esp)
     51b:	e8 fa 06 00 00       	call   c1a <close>
}
     520:	83 c4 5c             	add    $0x5c,%esp
     523:	5b                   	pop    %ebx
     524:	5e                   	pop    %esi
     525:	5f                   	pop    %edi
     526:	5d                   	pop    %ebp
     527:	c3                   	ret    
    if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     528:	89 34 24             	mov    %esi,(%esp)
     52b:	e8 20 05 00 00       	call   a50 <strlen>
     530:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
     535:	e9 83 fe ff ff       	jmp    3bd <mv_ls+0x2d>
        printf(2,"mv: cannot open '\".\"' No such file or directory\n");
     53a:	c7 44 24 04 f8 10 00 	movl   $0x10f8,0x4(%esp)
     541:	00 
     542:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     549:	e8 f2 07 00 00       	call   d40 <printf>
        exit();
     54e:	e8 9f 06 00 00       	call   bf2 <exit>
            printf(2,"mv: '%s' is not directory\n",path);
     553:	89 74 24 08          	mov    %esi,0x8(%esp)
     557:	c7 44 24 04 b2 11 00 	movl   $0x11b2,0x4(%esp)
     55e:	00 
     55f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     566:	e8 d5 07 00 00       	call   d40 <printf>
            exit();
     56b:	e8 82 06 00 00       	call   bf2 <exit>
        printf(2,"mv: cannot stat '%s' No such file or directory\n",path);
     570:	89 74 24 08          	mov    %esi,0x8(%esp)
     574:	c7 44 24 04 60 11 00 	movl   $0x1160,0x4(%esp)
     57b:	00 
     57c:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     583:	e8 b8 07 00 00       	call   d40 <printf>
        exit();
     588:	e8 65 06 00 00       	call   bf2 <exit>
        printf(2,"~mv: cannot open '%s' No such file or directory\n",path);
     58d:	89 74 24 08          	mov    %esi,0x8(%esp)
     591:	c7 44 24 04 2c 11 00 	movl   $0x112c,0x4(%esp)
     598:	00 
     599:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     5a0:	e8 9b 07 00 00       	call   d40 <printf>
        exit();
     5a5:	e8 48 06 00 00       	call   bf2 <exit>
     5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005b0 <mv_rek>:
{
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	57                   	push   %edi
     5b4:	56                   	push   %esi
     5b5:	53                   	push   %ebx
     5b6:	83 ec 4c             	sub    $0x4c,%esp
    buff=(char*)malloc(512*sizeof(char*));
     5b9:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     5c0:	e8 fb 09 00 00       	call   fc0 <malloc>
     5c5:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    if(from[strlen(from)-1]=='/') from[strlen(from)-1]=0;
     5c8:	8b 45 08             	mov    0x8(%ebp),%eax
     5cb:	89 04 24             	mov    %eax,(%esp)
     5ce:	e8 7d 04 00 00       	call   a50 <strlen>
     5d3:	8b 7d 08             	mov    0x8(%ebp),%edi
     5d6:	80 7c 07 ff 2f       	cmpb   $0x2f,-0x1(%edi,%eax,1)
     5db:	0f 84 87 03 00 00    	je     968 <mv_rek+0x3b8>
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     5e1:	8b 45 0c             	mov    0xc(%ebp),%eax
     5e4:	89 04 24             	mov    %eax,(%esp)
     5e7:	e8 64 04 00 00       	call   a50 <strlen>
     5ec:	8b 75 0c             	mov    0xc(%ebp),%esi
     5ef:	80 7c 06 ff 2f       	cmpb   $0x2f,-0x1(%esi,%eax,1)
     5f4:	0f 84 56 03 00 00    	je     950 <mv_rek+0x3a0>
    printf(1,"%s\n",to);
     5fa:	8b 45 0c             	mov    0xc(%ebp),%eax
     5fd:	c7 44 24 04 cd 11 00 	movl   $0x11cd,0x4(%esp)
     604:	00 
     605:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     60c:	89 44 24 08          	mov    %eax,0x8(%esp)
     610:	e8 2b 07 00 00       	call   d40 <printf>
    if((fd0=open(from,0))<0)
     615:	8b 45 08             	mov    0x8(%ebp),%eax
     618:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     61f:	00 
     620:	89 04 24             	mov    %eax,(%esp)
     623:	e8 0a 06 00 00       	call   c32 <open>
     628:	85 c0                	test   %eax,%eax
     62a:	89 c3                	mov    %eax,%ebx
     62c:	0f 88 5b 03 00 00    	js     98d <mv_rek+0x3dd>
    if(fstat(fd0,&st)<0)
     632:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     635:	89 44 24 04          	mov    %eax,0x4(%esp)
     639:	89 1c 24             	mov    %ebx,(%esp)
     63c:	e8 09 06 00 00       	call   c4a <fstat>
     641:	85 c0                	test   %eax,%eax
     643:	0f 88 64 03 00 00    	js     9ad <mv_rek+0x3fd>
    temp=(char*)malloc(512*sizeof(char*));
     649:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     650:	e8 6b 09 00 00       	call   fc0 <malloc>
    temp2=(char*)malloc(512*sizeof(char*));
     655:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
    temp=(char*)malloc(512*sizeof(char*));
     65c:	89 c6                	mov    %eax,%esi
    temp2=(char*)malloc(512*sizeof(char*));
     65e:	e8 5d 09 00 00       	call   fc0 <malloc>
     663:	89 c7                	mov    %eax,%edi
    switch(st.type)
     665:	0f b7 45 d4          	movzwl -0x2c(%ebp),%eax
     669:	66 83 f8 01          	cmp    $0x1,%ax
     66d:	74 49                	je     6b8 <mv_rek+0x108>
     66f:	66 83 f8 02          	cmp    $0x2,%ax
     673:	75 12                	jne    687 <mv_rek+0xd7>
            move(from,to);
     675:	8b 45 0c             	mov    0xc(%ebp),%eax
     678:	89 44 24 04          	mov    %eax,0x4(%esp)
     67c:	8b 45 08             	mov    0x8(%ebp),%eax
     67f:	89 04 24             	mov    %eax,(%esp)
     682:	e8 89 fa ff ff       	call   110 <move>
    close(fd0);
     687:	89 1c 24             	mov    %ebx,(%esp)
     68a:	e8 8b 05 00 00       	call   c1a <close>
    free(temp);
     68f:	89 34 24             	mov    %esi,(%esp)
     692:	e8 99 08 00 00       	call   f30 <free>
    free(temp2);
     697:	89 3c 24             	mov    %edi,(%esp)
     69a:	e8 91 08 00 00       	call   f30 <free>
    free(buff);
     69f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     6a2:	89 04 24             	mov    %eax,(%esp)
     6a5:	e8 86 08 00 00       	call   f30 <free>
}
     6aa:	83 c4 4c             	add    $0x4c,%esp
     6ad:	5b                   	pop    %ebx
     6ae:	5e                   	pop    %esi
     6af:	5f                   	pop    %edi
     6b0:	5d                   	pop    %ebp
     6b1:	c3                   	ret    
     6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            strcpy(buff,to);
     6b8:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bb:	89 44 24 04          	mov    %eax,0x4(%esp)
     6bf:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     6c2:	89 04 24             	mov    %eax,(%esp)
     6c5:	e8 06 03 00 00       	call   9d0 <strcpy>
    while(*d) ++d;
     6ca:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     6cd:	80 38 00             	cmpb   $0x0,(%eax)
     6d0:	0f 84 af 02 00 00    	je     985 <mv_rek+0x3d5>
     6d6:	66 90                	xchg   %ax,%ax
     6d8:	83 c0 01             	add    $0x1,%eax
     6db:	80 38 00             	cmpb   $0x0,(%eax)
     6de:	75 f8                	jne    6d8 <mv_rek+0x128>
    while(*s) *d++=*s++;
     6e0:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     6e3:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     6e7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     6ea:	80 38 00             	cmpb   $0x0,(%eax)
     6ed:	0f 84 8a 02 00 00    	je     97d <mv_rek+0x3cd>
     6f3:	90                   	nop
     6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6f8:	83 c0 01             	add    $0x1,%eax
     6fb:	80 38 00             	cmpb   $0x0,(%eax)
     6fe:	75 f8                	jne    6f8 <mv_rek+0x148>
    while(*s) *d++=*s++;
     700:	8b 4d 08             	mov    0x8(%ebp),%ecx
     703:	0f b6 11             	movzbl (%ecx),%edx
     706:	84 d2                	test   %dl,%dl
     708:	74 16                	je     720 <mv_rek+0x170>
     70a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     710:	83 c0 01             	add    $0x1,%eax
     713:	83 c1 01             	add    $0x1,%ecx
     716:	88 50 ff             	mov    %dl,-0x1(%eax)
     719:	0f b6 11             	movzbl (%ecx),%edx
     71c:	84 d2                	test   %dl,%dl
     71e:	75 f0                	jne    710 <mv_rek+0x160>
    *d=0;
     720:	c6 00 00             	movb   $0x0,(%eax)
            if(mkdir(to)>=0)
     723:	8b 45 0c             	mov    0xc(%ebp),%eax
     726:	89 04 24             	mov    %eax,(%esp)
     729:	e8 2c 05 00 00       	call   c5a <mkdir>
     72e:	85 c0                	test   %eax,%eax
     730:	0f 88 a9 01 00 00    	js     8df <mv_rek+0x32f>
     736:	66 90                	xchg   %ax,%ax
                while(read(fd0,&de,sizeof(de))==sizeof(de))
     738:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     73b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     742:	00 
     743:	89 44 24 04          	mov    %eax,0x4(%esp)
     747:	89 1c 24             	mov    %ebx,(%esp)
     74a:	e8 bb 04 00 00       	call   c0a <read>
     74f:	83 f8 10             	cmp    $0x10,%eax
     752:	0f 85 e8 01 00 00    	jne    940 <mv_rek+0x390>
                    if(de.inum==0 || de.name[0]=='.') 
     758:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     75d:	74 d9                	je     738 <mv_rek+0x188>
     75f:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     763:	74 d3                	je     738 <mv_rek+0x188>
                    strcpy(temp,from);
     765:	8b 45 08             	mov    0x8(%ebp),%eax
     768:	89 34 24             	mov    %esi,(%esp)
     76b:	89 44 24 04          	mov    %eax,0x4(%esp)
     76f:	e8 5c 02 00 00       	call   9d0 <strcpy>
    while(*d) ++d;
     774:	89 f0                	mov    %esi,%eax
     776:	80 3e 00             	cmpb   $0x0,(%esi)
     779:	74 0d                	je     788 <mv_rek+0x1d8>
     77b:	90                   	nop
     77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     780:	83 c0 01             	add    $0x1,%eax
     783:	80 38 00             	cmpb   $0x0,(%eax)
     786:	75 f8                	jne    780 <mv_rek+0x1d0>
    while(*s) *d++=*s++;
     788:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     78b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     78f:	89 f0                	mov    %esi,%eax
     791:	80 3e 00             	cmpb   $0x0,(%esi)
     794:	74 0a                	je     7a0 <mv_rek+0x1f0>
     796:	66 90                	xchg   %ax,%ax
     798:	83 c0 01             	add    $0x1,%eax
     79b:	80 38 00             	cmpb   $0x0,(%eax)
     79e:	75 f8                	jne    798 <mv_rek+0x1e8>
    while(*s) *d++=*s++;
     7a0:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     7a4:	84 d2                	test   %dl,%dl
     7a6:	74 18                	je     7c0 <mv_rek+0x210>
     7a8:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     7ab:	90                   	nop
     7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7b0:	83 c0 01             	add    $0x1,%eax
     7b3:	83 c1 01             	add    $0x1,%ecx
     7b6:	88 50 ff             	mov    %dl,-0x1(%eax)
     7b9:	0f b6 11             	movzbl (%ecx),%edx
     7bc:	84 d2                	test   %dl,%dl
     7be:	75 f0                	jne    7b0 <mv_rek+0x200>
    *d=0;
     7c0:	c6 00 00             	movb   $0x0,(%eax)
                    strcpy(temp2,to);
     7c3:	8b 45 0c             	mov    0xc(%ebp),%eax
     7c6:	89 3c 24             	mov    %edi,(%esp)
     7c9:	89 44 24 04          	mov    %eax,0x4(%esp)
     7cd:	e8 fe 01 00 00       	call   9d0 <strcpy>
    while(*d) ++d;
     7d2:	89 f8                	mov    %edi,%eax
     7d4:	80 3f 00             	cmpb   $0x0,(%edi)
     7d7:	74 0f                	je     7e8 <mv_rek+0x238>
     7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7e0:	83 c0 01             	add    $0x1,%eax
     7e3:	80 38 00             	cmpb   $0x0,(%eax)
     7e6:	75 f8                	jne    7e0 <mv_rek+0x230>
    while(*s) *d++=*s++;
     7e8:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     7eb:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     7ef:	89 f8                	mov    %edi,%eax
     7f1:	80 3f 00             	cmpb   $0x0,(%edi)
     7f4:	74 0a                	je     800 <mv_rek+0x250>
     7f6:	66 90                	xchg   %ax,%ax
     7f8:	83 c0 01             	add    $0x1,%eax
     7fb:	80 38 00             	cmpb   $0x0,(%eax)
     7fe:	75 f8                	jne    7f8 <mv_rek+0x248>
    while(*s) *d++=*s++;
     800:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     804:	84 d2                	test   %dl,%dl
     806:	74 18                	je     820 <mv_rek+0x270>
     808:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     80b:	90                   	nop
     80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     810:	83 c0 01             	add    $0x1,%eax
     813:	83 c1 01             	add    $0x1,%ecx
     816:	88 50 ff             	mov    %dl,-0x1(%eax)
     819:	0f b6 11             	movzbl (%ecx),%edx
     81c:	84 d2                	test   %dl,%dl
     81e:	75 f0                	jne    810 <mv_rek+0x260>
    *d=0;
     820:	c6 00 00             	movb   $0x0,(%eax)
                    mv_rek(temp,temp2);
     823:	89 7c 24 04          	mov    %edi,0x4(%esp)
     827:	89 34 24             	mov    %esi,(%esp)
     82a:	e8 81 fd ff ff       	call   5b0 <mv_rek>
     82f:	e9 04 ff ff ff       	jmp    738 <mv_rek+0x188>
     834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(*s) *d++=*s++;
     838:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     83b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     83f:	89 f0                	mov    %esi,%eax
     841:	80 3e 00             	cmpb   $0x0,(%esi)
     844:	74 0a                	je     850 <mv_rek+0x2a0>
     846:	66 90                	xchg   %ax,%ax
     848:	83 c0 01             	add    $0x1,%eax
     84b:	80 38 00             	cmpb   $0x0,(%eax)
     84e:	75 f8                	jne    848 <mv_rek+0x298>
    while(*s) *d++=*s++;
     850:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     854:	84 d2                	test   %dl,%dl
     856:	74 18                	je     870 <mv_rek+0x2c0>
     858:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     85b:	90                   	nop
     85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     860:	83 c0 01             	add    $0x1,%eax
     863:	83 c1 01             	add    $0x1,%ecx
     866:	88 50 ff             	mov    %dl,-0x1(%eax)
     869:	0f b6 11             	movzbl (%ecx),%edx
     86c:	84 d2                	test   %dl,%dl
     86e:	75 f0                	jne    860 <mv_rek+0x2b0>
    *d=0;
     870:	c6 00 00             	movb   $0x0,(%eax)
                    strcpy(temp2,buff);
     873:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     876:	89 3c 24             	mov    %edi,(%esp)
     879:	89 44 24 04          	mov    %eax,0x4(%esp)
     87d:	e8 4e 01 00 00       	call   9d0 <strcpy>
    while(*d) ++d;
     882:	89 f8                	mov    %edi,%eax
     884:	80 3f 00             	cmpb   $0x0,(%edi)
     887:	74 0f                	je     898 <mv_rek+0x2e8>
     889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     890:	83 c0 01             	add    $0x1,%eax
     893:	80 38 00             	cmpb   $0x0,(%eax)
     896:	75 f8                	jne    890 <mv_rek+0x2e0>
    while(*s) *d++=*s++;
     898:	c6 00 2f             	movb   $0x2f,(%eax)
    *d=0;
     89b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while(*d) ++d;
     89f:	89 f8                	mov    %edi,%eax
     8a1:	80 3f 00             	cmpb   $0x0,(%edi)
     8a4:	74 0a                	je     8b0 <mv_rek+0x300>
     8a6:	66 90                	xchg   %ax,%ax
     8a8:	83 c0 01             	add    $0x1,%eax
     8ab:	80 38 00             	cmpb   $0x0,(%eax)
     8ae:	75 f8                	jne    8a8 <mv_rek+0x2f8>
    while(*s) *d++=*s++;
     8b0:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     8b4:	84 d2                	test   %dl,%dl
     8b6:	74 18                	je     8d0 <mv_rek+0x320>
     8b8:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     8bb:	90                   	nop
     8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8c0:	83 c0 01             	add    $0x1,%eax
     8c3:	83 c1 01             	add    $0x1,%ecx
     8c6:	88 50 ff             	mov    %dl,-0x1(%eax)
     8c9:	0f b6 11             	movzbl (%ecx),%edx
     8cc:	84 d2                	test   %dl,%dl
     8ce:	75 f0                	jne    8c0 <mv_rek+0x310>
    *d=0;
     8d0:	c6 00 00             	movb   $0x0,(%eax)
                    mv_rek(temp,temp2);
     8d3:	89 7c 24 04          	mov    %edi,0x4(%esp)
     8d7:	89 34 24             	mov    %esi,(%esp)
     8da:	e8 d1 fc ff ff       	call   5b0 <mv_rek>
                while(read(fd0,&de,sizeof(de))==sizeof(de))
     8df:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     8e2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     8e9:	00 
     8ea:	89 44 24 04          	mov    %eax,0x4(%esp)
     8ee:	89 1c 24             	mov    %ebx,(%esp)
     8f1:	e8 14 03 00 00       	call   c0a <read>
     8f6:	83 f8 10             	cmp    $0x10,%eax
     8f9:	75 3d                	jne    938 <mv_rek+0x388>
                    if(de.inum==0 || de.name[0]=='.') 
     8fb:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     900:	74 dd                	je     8df <mv_rek+0x32f>
     902:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     906:	74 d7                	je     8df <mv_rek+0x32f>
                    strcpy(temp,from);
     908:	8b 45 08             	mov    0x8(%ebp),%eax
     90b:	89 34 24             	mov    %esi,(%esp)
     90e:	89 44 24 04          	mov    %eax,0x4(%esp)
     912:	e8 b9 00 00 00       	call   9d0 <strcpy>
    while(*d) ++d;
     917:	89 f0                	mov    %esi,%eax
     919:	80 3e 00             	cmpb   $0x0,(%esi)
     91c:	0f 84 16 ff ff ff    	je     838 <mv_rek+0x288>
     922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     928:	83 c0 01             	add    $0x1,%eax
     92b:	80 38 00             	cmpb   $0x0,(%eax)
     92e:	75 f8                	jne    928 <mv_rek+0x378>
     930:	e9 03 ff ff ff       	jmp    838 <mv_rek+0x288>
     935:	8d 76 00             	lea    0x0(%esi),%esi
                unlink(temp);
     938:	89 34 24             	mov    %esi,(%esp)
     93b:	e8 02 03 00 00       	call   c42 <unlink>
            unlink(to);
     940:	8b 45 0c             	mov    0xc(%ebp),%eax
     943:	89 04 24             	mov    %eax,(%esp)
     946:	e8 f7 02 00 00       	call   c42 <unlink>
            break;
     94b:	e9 37 fd ff ff       	jmp    687 <mv_rek+0xd7>
    if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     950:	89 34 24             	mov    %esi,(%esp)
     953:	e8 f8 00 00 00       	call   a50 <strlen>
     958:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     95b:	c6 44 03 ff 00       	movb   $0x0,-0x1(%ebx,%eax,1)
     960:	e9 95 fc ff ff       	jmp    5fa <mv_rek+0x4a>
     965:	8d 76 00             	lea    0x0(%esi),%esi
    if(from[strlen(from)-1]=='/') from[strlen(from)-1]=0;
     968:	89 3c 24             	mov    %edi,(%esp)
     96b:	e8 e0 00 00 00       	call   a50 <strlen>
     970:	8b 5d 08             	mov    0x8(%ebp),%ebx
     973:	c6 44 03 ff 00       	movb   $0x0,-0x1(%ebx,%eax,1)
     978:	e9 64 fc ff ff       	jmp    5e1 <mv_rek+0x31>
    while(*d) ++d;
     97d:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     980:	e9 7b fd ff ff       	jmp    700 <mv_rek+0x150>
     985:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     988:	e9 53 fd ff ff       	jmp    6e0 <mv_rek+0x130>
        printf(2,"mv: cannot open '%s' No such file or directory\n",from);
     98d:	8b 45 08             	mov    0x8(%ebp),%eax
     990:	c7 44 24 04 a8 10 00 	movl   $0x10a8,0x4(%esp)
     997:	00 
     998:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     99f:	89 44 24 08          	mov    %eax,0x8(%esp)
     9a3:	e8 98 03 00 00       	call   d40 <printf>
        exit();
     9a8:	e8 45 02 00 00       	call   bf2 <exit>
        printf(2,"mv: cannot stat '%s' No such file or directory\n",from);
     9ad:	8b 45 08             	mov    0x8(%ebp),%eax
     9b0:	c7 44 24 04 60 11 00 	movl   $0x1160,0x4(%esp)
     9b7:	00 
     9b8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     9bf:	89 44 24 08          	mov    %eax,0x8(%esp)
     9c3:	e8 78 03 00 00       	call   d40 <printf>
        exit();
     9c8:	e8 25 02 00 00       	call   bf2 <exit>
     9cd:	66 90                	xchg   %ax,%ax
     9cf:	90                   	nop

000009d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     9d0:	55                   	push   %ebp
     9d1:	89 e5                	mov    %esp,%ebp
     9d3:	8b 45 08             	mov    0x8(%ebp),%eax
     9d6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     9d9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     9da:	89 c2                	mov    %eax,%edx
     9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9e0:	83 c1 01             	add    $0x1,%ecx
     9e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     9e7:	83 c2 01             	add    $0x1,%edx
     9ea:	84 db                	test   %bl,%bl
     9ec:	88 5a ff             	mov    %bl,-0x1(%edx)
     9ef:	75 ef                	jne    9e0 <strcpy+0x10>
    ;
  return os;
}
     9f1:	5b                   	pop    %ebx
     9f2:	5d                   	pop    %ebp
     9f3:	c3                   	ret    
     9f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     9fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	8b 55 08             	mov    0x8(%ebp),%edx
     a06:	53                   	push   %ebx
     a07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     a0a:	0f b6 02             	movzbl (%edx),%eax
     a0d:	84 c0                	test   %al,%al
     a0f:	74 2d                	je     a3e <strcmp+0x3e>
     a11:	0f b6 19             	movzbl (%ecx),%ebx
     a14:	38 d8                	cmp    %bl,%al
     a16:	74 0e                	je     a26 <strcmp+0x26>
     a18:	eb 2b                	jmp    a45 <strcmp+0x45>
     a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a20:	38 c8                	cmp    %cl,%al
     a22:	75 15                	jne    a39 <strcmp+0x39>
    p++, q++;
     a24:	89 d9                	mov    %ebx,%ecx
     a26:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     a29:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     a2c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     a2f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
     a33:	84 c0                	test   %al,%al
     a35:	75 e9                	jne    a20 <strcmp+0x20>
     a37:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     a39:	29 c8                	sub    %ecx,%eax
}
     a3b:	5b                   	pop    %ebx
     a3c:	5d                   	pop    %ebp
     a3d:	c3                   	ret    
     a3e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
     a41:	31 c0                	xor    %eax,%eax
     a43:	eb f4                	jmp    a39 <strcmp+0x39>
     a45:	0f b6 cb             	movzbl %bl,%ecx
     a48:	eb ef                	jmp    a39 <strcmp+0x39>
     a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a50 <strlen>:

uint
strlen(const char *s)
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     a56:	80 39 00             	cmpb   $0x0,(%ecx)
     a59:	74 12                	je     a6d <strlen+0x1d>
     a5b:	31 d2                	xor    %edx,%edx
     a5d:	8d 76 00             	lea    0x0(%esi),%esi
     a60:	83 c2 01             	add    $0x1,%edx
     a63:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     a67:	89 d0                	mov    %edx,%eax
     a69:	75 f5                	jne    a60 <strlen+0x10>
    ;
  return n;
}
     a6b:	5d                   	pop    %ebp
     a6c:	c3                   	ret    
  for(n = 0; s[n]; n++)
     a6d:	31 c0                	xor    %eax,%eax
}
     a6f:	5d                   	pop    %ebp
     a70:	c3                   	ret    
     a71:	eb 0d                	jmp    a80 <memset>
     a73:	90                   	nop
     a74:	90                   	nop
     a75:	90                   	nop
     a76:	90                   	nop
     a77:	90                   	nop
     a78:	90                   	nop
     a79:	90                   	nop
     a7a:	90                   	nop
     a7b:	90                   	nop
     a7c:	90                   	nop
     a7d:	90                   	nop
     a7e:	90                   	nop
     a7f:	90                   	nop

00000a80 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a80:	55                   	push   %ebp
     a81:	89 e5                	mov    %esp,%ebp
     a83:	8b 55 08             	mov    0x8(%ebp),%edx
     a86:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     a87:	8b 4d 10             	mov    0x10(%ebp),%ecx
     a8a:	8b 45 0c             	mov    0xc(%ebp),%eax
     a8d:	89 d7                	mov    %edx,%edi
     a8f:	fc                   	cld    
     a90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     a92:	89 d0                	mov    %edx,%eax
     a94:	5f                   	pop    %edi
     a95:	5d                   	pop    %ebp
     a96:	c3                   	ret    
     a97:	89 f6                	mov    %esi,%esi
     a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000aa0 <strchr>:

char*
strchr(const char *s, char c)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	53                   	push   %ebx
     aa7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     aaa:	0f b6 18             	movzbl (%eax),%ebx
     aad:	84 db                	test   %bl,%bl
     aaf:	74 1d                	je     ace <strchr+0x2e>
    if(*s == c)
     ab1:	38 d3                	cmp    %dl,%bl
     ab3:	89 d1                	mov    %edx,%ecx
     ab5:	75 0d                	jne    ac4 <strchr+0x24>
     ab7:	eb 17                	jmp    ad0 <strchr+0x30>
     ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ac0:	38 ca                	cmp    %cl,%dl
     ac2:	74 0c                	je     ad0 <strchr+0x30>
  for(; *s; s++)
     ac4:	83 c0 01             	add    $0x1,%eax
     ac7:	0f b6 10             	movzbl (%eax),%edx
     aca:	84 d2                	test   %dl,%dl
     acc:	75 f2                	jne    ac0 <strchr+0x20>
      return (char*)s;
  return 0;
     ace:	31 c0                	xor    %eax,%eax
}
     ad0:	5b                   	pop    %ebx
     ad1:	5d                   	pop    %ebp
     ad2:	c3                   	ret    
     ad3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ae0 <gets>:

char*
gets(char *buf, int max)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	57                   	push   %edi
     ae4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ae5:	31 f6                	xor    %esi,%esi
{
     ae7:	53                   	push   %ebx
     ae8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
     aeb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     aee:	eb 31                	jmp    b21 <gets+0x41>
    cc = read(0, &c, 1);
     af0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     af7:	00 
     af8:	89 7c 24 04          	mov    %edi,0x4(%esp)
     afc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     b03:	e8 02 01 00 00       	call   c0a <read>
    if(cc < 1)
     b08:	85 c0                	test   %eax,%eax
     b0a:	7e 1d                	jle    b29 <gets+0x49>
      break;
    buf[i++] = c;
     b0c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
     b10:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
     b12:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
     b15:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
     b17:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     b1b:	74 0c                	je     b29 <gets+0x49>
     b1d:	3c 0a                	cmp    $0xa,%al
     b1f:	74 08                	je     b29 <gets+0x49>
  for(i=0; i+1 < max; ){
     b21:	8d 5e 01             	lea    0x1(%esi),%ebx
     b24:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     b27:	7c c7                	jl     af0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     b29:	8b 45 08             	mov    0x8(%ebp),%eax
     b2c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     b30:	83 c4 2c             	add    $0x2c,%esp
     b33:	5b                   	pop    %ebx
     b34:	5e                   	pop    %esi
     b35:	5f                   	pop    %edi
     b36:	5d                   	pop    %ebp
     b37:	c3                   	ret    
     b38:	90                   	nop
     b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b40 <stat>:

int
stat(const char *n, struct stat *st)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	56                   	push   %esi
     b44:	53                   	push   %ebx
     b45:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     b48:	8b 45 08             	mov    0x8(%ebp),%eax
     b4b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     b52:	00 
     b53:	89 04 24             	mov    %eax,(%esp)
     b56:	e8 d7 00 00 00       	call   c32 <open>
  if(fd < 0)
     b5b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
     b5d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     b5f:	78 27                	js     b88 <stat+0x48>
    return -1;
  r = fstat(fd, st);
     b61:	8b 45 0c             	mov    0xc(%ebp),%eax
     b64:	89 1c 24             	mov    %ebx,(%esp)
     b67:	89 44 24 04          	mov    %eax,0x4(%esp)
     b6b:	e8 da 00 00 00       	call   c4a <fstat>
  close(fd);
     b70:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     b73:	89 c6                	mov    %eax,%esi
  close(fd);
     b75:	e8 a0 00 00 00       	call   c1a <close>
  return r;
     b7a:	89 f0                	mov    %esi,%eax
}
     b7c:	83 c4 10             	add    $0x10,%esp
     b7f:	5b                   	pop    %ebx
     b80:	5e                   	pop    %esi
     b81:	5d                   	pop    %ebp
     b82:	c3                   	ret    
     b83:	90                   	nop
     b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     b88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     b8d:	eb ed                	jmp    b7c <stat+0x3c>
     b8f:	90                   	nop

00000b90 <atoi>:

int
atoi(const char *s)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b96:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b97:	0f be 11             	movsbl (%ecx),%edx
     b9a:	8d 42 d0             	lea    -0x30(%edx),%eax
     b9d:	3c 09                	cmp    $0x9,%al
  n = 0;
     b9f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     ba4:	77 17                	ja     bbd <atoi+0x2d>
     ba6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     ba8:	83 c1 01             	add    $0x1,%ecx
     bab:	8d 04 80             	lea    (%eax,%eax,4),%eax
     bae:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     bb2:	0f be 11             	movsbl (%ecx),%edx
     bb5:	8d 5a d0             	lea    -0x30(%edx),%ebx
     bb8:	80 fb 09             	cmp    $0x9,%bl
     bbb:	76 eb                	jbe    ba8 <atoi+0x18>
  return n;
}
     bbd:	5b                   	pop    %ebx
     bbe:	5d                   	pop    %ebp
     bbf:	c3                   	ret    

00000bc0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     bc0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     bc1:	31 d2                	xor    %edx,%edx
{
     bc3:	89 e5                	mov    %esp,%ebp
     bc5:	56                   	push   %esi
     bc6:	8b 45 08             	mov    0x8(%ebp),%eax
     bc9:	53                   	push   %ebx
     bca:	8b 5d 10             	mov    0x10(%ebp),%ebx
     bcd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
     bd0:	85 db                	test   %ebx,%ebx
     bd2:	7e 12                	jle    be6 <memmove+0x26>
     bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     bd8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     bdc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     bdf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     be2:	39 da                	cmp    %ebx,%edx
     be4:	75 f2                	jne    bd8 <memmove+0x18>
  return vdst;
}
     be6:	5b                   	pop    %ebx
     be7:	5e                   	pop    %esi
     be8:	5d                   	pop    %ebp
     be9:	c3                   	ret    

00000bea <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     bea:	b8 01 00 00 00       	mov    $0x1,%eax
     bef:	cd 40                	int    $0x40
     bf1:	c3                   	ret    

00000bf2 <exit>:
SYSCALL(exit)
     bf2:	b8 02 00 00 00       	mov    $0x2,%eax
     bf7:	cd 40                	int    $0x40
     bf9:	c3                   	ret    

00000bfa <wait>:
SYSCALL(wait)
     bfa:	b8 03 00 00 00       	mov    $0x3,%eax
     bff:	cd 40                	int    $0x40
     c01:	c3                   	ret    

00000c02 <pipe>:
SYSCALL(pipe)
     c02:	b8 04 00 00 00       	mov    $0x4,%eax
     c07:	cd 40                	int    $0x40
     c09:	c3                   	ret    

00000c0a <read>:
SYSCALL(read)
     c0a:	b8 05 00 00 00       	mov    $0x5,%eax
     c0f:	cd 40                	int    $0x40
     c11:	c3                   	ret    

00000c12 <write>:
SYSCALL(write)
     c12:	b8 10 00 00 00       	mov    $0x10,%eax
     c17:	cd 40                	int    $0x40
     c19:	c3                   	ret    

00000c1a <close>:
SYSCALL(close)
     c1a:	b8 15 00 00 00       	mov    $0x15,%eax
     c1f:	cd 40                	int    $0x40
     c21:	c3                   	ret    

00000c22 <kill>:
SYSCALL(kill)
     c22:	b8 06 00 00 00       	mov    $0x6,%eax
     c27:	cd 40                	int    $0x40
     c29:	c3                   	ret    

00000c2a <exec>:
SYSCALL(exec)
     c2a:	b8 07 00 00 00       	mov    $0x7,%eax
     c2f:	cd 40                	int    $0x40
     c31:	c3                   	ret    

00000c32 <open>:
SYSCALL(open)
     c32:	b8 0f 00 00 00       	mov    $0xf,%eax
     c37:	cd 40                	int    $0x40
     c39:	c3                   	ret    

00000c3a <mknod>:
SYSCALL(mknod)
     c3a:	b8 11 00 00 00       	mov    $0x11,%eax
     c3f:	cd 40                	int    $0x40
     c41:	c3                   	ret    

00000c42 <unlink>:
SYSCALL(unlink)
     c42:	b8 12 00 00 00       	mov    $0x12,%eax
     c47:	cd 40                	int    $0x40
     c49:	c3                   	ret    

00000c4a <fstat>:
SYSCALL(fstat)
     c4a:	b8 08 00 00 00       	mov    $0x8,%eax
     c4f:	cd 40                	int    $0x40
     c51:	c3                   	ret    

00000c52 <link>:
SYSCALL(link)
     c52:	b8 13 00 00 00       	mov    $0x13,%eax
     c57:	cd 40                	int    $0x40
     c59:	c3                   	ret    

00000c5a <mkdir>:
SYSCALL(mkdir)
     c5a:	b8 14 00 00 00       	mov    $0x14,%eax
     c5f:	cd 40                	int    $0x40
     c61:	c3                   	ret    

00000c62 <chdir>:
SYSCALL(chdir)
     c62:	b8 09 00 00 00       	mov    $0x9,%eax
     c67:	cd 40                	int    $0x40
     c69:	c3                   	ret    

00000c6a <dup>:
SYSCALL(dup)
     c6a:	b8 0a 00 00 00       	mov    $0xa,%eax
     c6f:	cd 40                	int    $0x40
     c71:	c3                   	ret    

00000c72 <getpid>:
SYSCALL(getpid)
     c72:	b8 0b 00 00 00       	mov    $0xb,%eax
     c77:	cd 40                	int    $0x40
     c79:	c3                   	ret    

00000c7a <sbrk>:
SYSCALL(sbrk)
     c7a:	b8 0c 00 00 00       	mov    $0xc,%eax
     c7f:	cd 40                	int    $0x40
     c81:	c3                   	ret    

00000c82 <sleep>:
SYSCALL(sleep)
     c82:	b8 0d 00 00 00       	mov    $0xd,%eax
     c87:	cd 40                	int    $0x40
     c89:	c3                   	ret    

00000c8a <uptime>:
SYSCALL(uptime)
     c8a:	b8 0e 00 00 00       	mov    $0xe,%eax
     c8f:	cd 40                	int    $0x40
     c91:	c3                   	ret    

00000c92 <getpinfo>:
SYSCALL(getpinfo)
     c92:	b8 16 00 00 00       	mov    $0x16,%eax
     c97:	cd 40                	int    $0x40
     c99:	c3                   	ret    
     c9a:	66 90                	xchg   %ax,%ax
     c9c:	66 90                	xchg   %ax,%ax
     c9e:	66 90                	xchg   %ax,%ax

00000ca0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	57                   	push   %edi
     ca4:	56                   	push   %esi
     ca5:	89 c6                	mov    %eax,%esi
     ca7:	53                   	push   %ebx
     ca8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cae:	85 db                	test   %ebx,%ebx
     cb0:	74 09                	je     cbb <printint+0x1b>
     cb2:	89 d0                	mov    %edx,%eax
     cb4:	c1 e8 1f             	shr    $0x1f,%eax
     cb7:	84 c0                	test   %al,%al
     cb9:	75 75                	jne    d30 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     cbb:	89 d0                	mov    %edx,%eax
  neg = 0;
     cbd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     cc4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
     cc7:	31 ff                	xor    %edi,%edi
     cc9:	89 ce                	mov    %ecx,%esi
     ccb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     cce:	eb 02                	jmp    cd2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
     cd0:	89 cf                	mov    %ecx,%edi
     cd2:	31 d2                	xor    %edx,%edx
     cd4:	f7 f6                	div    %esi
     cd6:	8d 4f 01             	lea    0x1(%edi),%ecx
     cd9:	0f b6 92 f6 11 00 00 	movzbl 0x11f6(%edx),%edx
  }while((x /= base) != 0);
     ce0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     ce2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     ce5:	75 e9                	jne    cd0 <printint+0x30>
  if(neg)
     ce7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
     cea:	89 c8                	mov    %ecx,%eax
     cec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
     cef:	85 d2                	test   %edx,%edx
     cf1:	74 08                	je     cfb <printint+0x5b>
    buf[i++] = '-';
     cf3:	8d 4f 02             	lea    0x2(%edi),%ecx
     cf6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
     cfb:	8d 79 ff             	lea    -0x1(%ecx),%edi
     cfe:	66 90                	xchg   %ax,%ax
     d00:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
     d05:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
     d08:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     d0f:	00 
     d10:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     d14:	89 34 24             	mov    %esi,(%esp)
     d17:	88 45 d7             	mov    %al,-0x29(%ebp)
     d1a:	e8 f3 fe ff ff       	call   c12 <write>
  while(--i >= 0)
     d1f:	83 ff ff             	cmp    $0xffffffff,%edi
     d22:	75 dc                	jne    d00 <printint+0x60>
    putc(fd, buf[i]);
}
     d24:	83 c4 4c             	add    $0x4c,%esp
     d27:	5b                   	pop    %ebx
     d28:	5e                   	pop    %esi
     d29:	5f                   	pop    %edi
     d2a:	5d                   	pop    %ebp
     d2b:	c3                   	ret    
     d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
     d30:	89 d0                	mov    %edx,%eax
     d32:	f7 d8                	neg    %eax
    neg = 1;
     d34:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     d3b:	eb 87                	jmp    cc4 <printint+0x24>
     d3d:	8d 76 00             	lea    0x0(%esi),%esi

00000d40 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     d44:	31 ff                	xor    %edi,%edi
{
     d46:	56                   	push   %esi
     d47:	53                   	push   %ebx
     d48:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     d4b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
     d4e:	8d 45 10             	lea    0x10(%ebp),%eax
{
     d51:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
     d54:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     d57:	0f b6 13             	movzbl (%ebx),%edx
     d5a:	83 c3 01             	add    $0x1,%ebx
     d5d:	84 d2                	test   %dl,%dl
     d5f:	75 39                	jne    d9a <printf+0x5a>
     d61:	e9 c2 00 00 00       	jmp    e28 <printf+0xe8>
     d66:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     d68:	83 fa 25             	cmp    $0x25,%edx
     d6b:	0f 84 bf 00 00 00    	je     e30 <printf+0xf0>
  write(fd, &c, 1);
     d71:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     d74:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     d7b:	00 
     d7c:	89 44 24 04          	mov    %eax,0x4(%esp)
     d80:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
     d83:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
     d86:	e8 87 fe ff ff       	call   c12 <write>
     d8b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
     d8e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     d92:	84 d2                	test   %dl,%dl
     d94:	0f 84 8e 00 00 00    	je     e28 <printf+0xe8>
    if(state == 0){
     d9a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     d9c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
     d9f:	74 c7                	je     d68 <printf+0x28>
      }
    } else if(state == '%'){
     da1:	83 ff 25             	cmp    $0x25,%edi
     da4:	75 e5                	jne    d8b <printf+0x4b>
      if(c == 'd'){
     da6:	83 fa 64             	cmp    $0x64,%edx
     da9:	0f 84 31 01 00 00    	je     ee0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     daf:	25 f7 00 00 00       	and    $0xf7,%eax
     db4:	83 f8 70             	cmp    $0x70,%eax
     db7:	0f 84 83 00 00 00    	je     e40 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     dbd:	83 fa 73             	cmp    $0x73,%edx
     dc0:	0f 84 a2 00 00 00    	je     e68 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     dc6:	83 fa 63             	cmp    $0x63,%edx
     dc9:	0f 84 35 01 00 00    	je     f04 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     dcf:	83 fa 25             	cmp    $0x25,%edx
     dd2:	0f 84 e0 00 00 00    	je     eb8 <printf+0x178>
  write(fd, &c, 1);
     dd8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     ddb:	83 c3 01             	add    $0x1,%ebx
     dde:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     de5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     de6:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     de8:	89 44 24 04          	mov    %eax,0x4(%esp)
     dec:	89 34 24             	mov    %esi,(%esp)
     def:	89 55 d0             	mov    %edx,-0x30(%ebp)
     df2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
     df6:	e8 17 fe ff ff       	call   c12 <write>
        putc(fd, c);
     dfb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
     dfe:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e01:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e08:	00 
     e09:	89 44 24 04          	mov    %eax,0x4(%esp)
     e0d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
     e10:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     e13:	e8 fa fd ff ff       	call   c12 <write>
  for(i = 0; fmt[i]; i++){
     e18:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     e1c:	84 d2                	test   %dl,%dl
     e1e:	0f 85 76 ff ff ff    	jne    d9a <printf+0x5a>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
     e28:	83 c4 3c             	add    $0x3c,%esp
     e2b:	5b                   	pop    %ebx
     e2c:	5e                   	pop    %esi
     e2d:	5f                   	pop    %edi
     e2e:	5d                   	pop    %ebp
     e2f:	c3                   	ret    
        state = '%';
     e30:	bf 25 00 00 00       	mov    $0x25,%edi
     e35:	e9 51 ff ff ff       	jmp    d8b <printf+0x4b>
     e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     e40:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     e43:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
     e48:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
     e4a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     e51:	8b 10                	mov    (%eax),%edx
     e53:	89 f0                	mov    %esi,%eax
     e55:	e8 46 fe ff ff       	call   ca0 <printint>
        ap++;
     e5a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
     e5e:	e9 28 ff ff ff       	jmp    d8b <printf+0x4b>
     e63:	90                   	nop
     e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     e68:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
     e6b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
     e6f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
     e71:	b8 ef 11 00 00       	mov    $0x11ef,%eax
     e76:	85 ff                	test   %edi,%edi
     e78:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
     e7b:	0f b6 07             	movzbl (%edi),%eax
     e7e:	84 c0                	test   %al,%al
     e80:	74 2a                	je     eac <printf+0x16c>
     e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e88:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     e8b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
     e8e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
     e91:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e98:	00 
     e99:	89 44 24 04          	mov    %eax,0x4(%esp)
     e9d:	89 34 24             	mov    %esi,(%esp)
     ea0:	e8 6d fd ff ff       	call   c12 <write>
        while(*s != 0){
     ea5:	0f b6 07             	movzbl (%edi),%eax
     ea8:	84 c0                	test   %al,%al
     eaa:	75 dc                	jne    e88 <printf+0x148>
      state = 0;
     eac:	31 ff                	xor    %edi,%edi
     eae:	e9 d8 fe ff ff       	jmp    d8b <printf+0x4b>
     eb3:	90                   	nop
     eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     eb8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
     ebb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     ebd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ec4:	00 
     ec5:	89 44 24 04          	mov    %eax,0x4(%esp)
     ec9:	89 34 24             	mov    %esi,(%esp)
     ecc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
     ed0:	e8 3d fd ff ff       	call   c12 <write>
     ed5:	e9 b1 fe ff ff       	jmp    d8b <printf+0x4b>
     eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
     ee0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     ee3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
     ee8:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
     eeb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ef2:	8b 10                	mov    (%eax),%edx
     ef4:	89 f0                	mov    %esi,%eax
     ef6:	e8 a5 fd ff ff       	call   ca0 <printint>
        ap++;
     efb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
     eff:	e9 87 fe ff ff       	jmp    d8b <printf+0x4b>
        putc(fd, *ap);
     f04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
     f07:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
     f09:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
     f0b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f12:	00 
     f13:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
     f16:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     f19:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f1c:	89 44 24 04          	mov    %eax,0x4(%esp)
     f20:	e8 ed fc ff ff       	call   c12 <write>
        ap++;
     f25:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
     f29:	e9 5d fe ff ff       	jmp    d8b <printf+0x4b>
     f2e:	66 90                	xchg   %ax,%ax

00000f30 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f30:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f31:	a1 60 17 00 00       	mov    0x1760,%eax
{
     f36:	89 e5                	mov    %esp,%ebp
     f38:	57                   	push   %edi
     f39:	56                   	push   %esi
     f3a:	53                   	push   %ebx
     f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f3e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
     f40:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f43:	39 d0                	cmp    %edx,%eax
     f45:	72 11                	jb     f58 <free+0x28>
     f47:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f48:	39 c8                	cmp    %ecx,%eax
     f4a:	72 04                	jb     f50 <free+0x20>
     f4c:	39 ca                	cmp    %ecx,%edx
     f4e:	72 10                	jb     f60 <free+0x30>
     f50:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f52:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f54:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f56:	73 f0                	jae    f48 <free+0x18>
     f58:	39 ca                	cmp    %ecx,%edx
     f5a:	72 04                	jb     f60 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f5c:	39 c8                	cmp    %ecx,%eax
     f5e:	72 f0                	jb     f50 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
     f60:	8b 73 fc             	mov    -0x4(%ebx),%esi
     f63:	8d 3c f2             	lea    (%edx,%esi,8),%edi
     f66:	39 cf                	cmp    %ecx,%edi
     f68:	74 1e                	je     f88 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     f6a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
     f6d:	8b 48 04             	mov    0x4(%eax),%ecx
     f70:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
     f73:	39 f2                	cmp    %esi,%edx
     f75:	74 28                	je     f9f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     f77:	89 10                	mov    %edx,(%eax)
  freep = p;
     f79:	a3 60 17 00 00       	mov    %eax,0x1760
}
     f7e:	5b                   	pop    %ebx
     f7f:	5e                   	pop    %esi
     f80:	5f                   	pop    %edi
     f81:	5d                   	pop    %ebp
     f82:	c3                   	ret    
     f83:	90                   	nop
     f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
     f88:	03 71 04             	add    0x4(%ecx),%esi
     f8b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
     f8e:	8b 08                	mov    (%eax),%ecx
     f90:	8b 09                	mov    (%ecx),%ecx
     f92:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
     f95:	8b 48 04             	mov    0x4(%eax),%ecx
     f98:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
     f9b:	39 f2                	cmp    %esi,%edx
     f9d:	75 d8                	jne    f77 <free+0x47>
    p->s.size += bp->s.size;
     f9f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
     fa2:	a3 60 17 00 00       	mov    %eax,0x1760
    p->s.size += bp->s.size;
     fa7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
     faa:	8b 53 f8             	mov    -0x8(%ebx),%edx
     fad:	89 10                	mov    %edx,(%eax)
}
     faf:	5b                   	pop    %ebx
     fb0:	5e                   	pop    %esi
     fb1:	5f                   	pop    %edi
     fb2:	5d                   	pop    %ebp
     fb3:	c3                   	ret    
     fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fc0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	57                   	push   %edi
     fc4:	56                   	push   %esi
     fc5:	53                   	push   %ebx
     fc6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fc9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
     fcc:	8b 1d 60 17 00 00    	mov    0x1760,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fd2:	8d 48 07             	lea    0x7(%eax),%ecx
     fd5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
     fd8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     fda:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
     fdd:	0f 84 9b 00 00 00    	je     107e <malloc+0xbe>
     fe3:	8b 13                	mov    (%ebx),%edx
     fe5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
     fe8:	39 fe                	cmp    %edi,%esi
     fea:	76 64                	jbe    1050 <malloc+0x90>
     fec:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
     ff3:	bb 00 80 00 00       	mov    $0x8000,%ebx
     ff8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     ffb:	eb 0e                	jmp    100b <malloc+0x4b>
     ffd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1000:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1002:	8b 78 04             	mov    0x4(%eax),%edi
    1005:	39 fe                	cmp    %edi,%esi
    1007:	76 4f                	jbe    1058 <malloc+0x98>
    1009:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    100b:	3b 15 60 17 00 00    	cmp    0x1760,%edx
    1011:	75 ed                	jne    1000 <malloc+0x40>
  if(nu < 4096)
    1013:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1016:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    101c:	bf 00 10 00 00       	mov    $0x1000,%edi
    1021:	0f 43 fe             	cmovae %esi,%edi
    1024:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
    1027:	89 04 24             	mov    %eax,(%esp)
    102a:	e8 4b fc ff ff       	call   c7a <sbrk>
  if(p == (char*)-1)
    102f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1032:	74 18                	je     104c <malloc+0x8c>
  hp->s.size = nu;
    1034:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1037:	83 c0 08             	add    $0x8,%eax
    103a:	89 04 24             	mov    %eax,(%esp)
    103d:	e8 ee fe ff ff       	call   f30 <free>
  return freep;
    1042:	8b 15 60 17 00 00    	mov    0x1760,%edx
      if((p = morecore(nunits)) == 0)
    1048:	85 d2                	test   %edx,%edx
    104a:	75 b4                	jne    1000 <malloc+0x40>
        return 0;
    104c:	31 c0                	xor    %eax,%eax
    104e:	eb 20                	jmp    1070 <malloc+0xb0>
    if(p->s.size >= nunits){
    1050:	89 d0                	mov    %edx,%eax
    1052:	89 da                	mov    %ebx,%edx
    1054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1058:	39 fe                	cmp    %edi,%esi
    105a:	74 1c                	je     1078 <malloc+0xb8>
        p->s.size -= nunits;
    105c:	29 f7                	sub    %esi,%edi
    105e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    1061:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    1064:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1067:	89 15 60 17 00 00    	mov    %edx,0x1760
      return (void*)(p + 1);
    106d:	83 c0 08             	add    $0x8,%eax
  }
}
    1070:	83 c4 1c             	add    $0x1c,%esp
    1073:	5b                   	pop    %ebx
    1074:	5e                   	pop    %esi
    1075:	5f                   	pop    %edi
    1076:	5d                   	pop    %ebp
    1077:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1078:	8b 08                	mov    (%eax),%ecx
    107a:	89 0a                	mov    %ecx,(%edx)
    107c:	eb e9                	jmp    1067 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
    107e:	c7 05 60 17 00 00 64 	movl   $0x1764,0x1760
    1085:	17 00 00 
    base.s.size = 0;
    1088:	ba 64 17 00 00       	mov    $0x1764,%edx
    base.s.ptr = freep = prevp = &base;
    108d:	c7 05 64 17 00 00 64 	movl   $0x1764,0x1764
    1094:	17 00 00 
    base.s.size = 0;
    1097:	c7 05 68 17 00 00 00 	movl   $0x0,0x1768
    109e:	00 00 00 
    10a1:	e9 46 ff ff ff       	jmp    fec <malloc+0x2c>
