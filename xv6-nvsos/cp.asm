
_cp:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
      free(temp2);
      free(buff);
  }
  
  int main(int argc,char *argv[])
  {
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	57                   	push   %edi
       4:	56                   	push   %esi
       5:	53                   	push   %ebx
       6:	83 e4 f0             	and    $0xfffffff0,%esp
       9:	81 ec 10 02 00 00    	sub    $0x210,%esp
       f:	8b 5d 0c             	mov    0xc(%ebp),%ebx
      if(argc<2)
      12:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
      16:	0f 8e 26 01 00 00    	jle    142 <main+0x142>
      {
          printf(2,"Usage : cp [OPTIONS] [source] [dest]\n");
          printf(2,"Options:\n");
          printf(2,"  -R : copy file secara recursive\n");
      }
      if(argv[1][0]=='*')
      1c:	8b 43 04             	mov    0x4(%ebx),%eax
      1f:	80 38 2a             	cmpb   $0x2a,(%eax)
      22:	0f 84 e2 00 00 00    	je     10a <main+0x10a>
          char eks[512];
          strcpy(eks,argv[1]+1);
          cp_ls(argv[2],panjang,eks);
          exit();
      }
      else if(strcmp(argv[1],"-R")==0)
      28:	c7 44 24 04 1f 13 00 	movl   $0x131f,0x4(%esp)
      2f:	00 
      30:	89 04 24             	mov    %eax,(%esp)
      33:	e8 f8 0a 00 00       	call   b30 <strcmp>
      38:	85 c0                	test   %eax,%eax
      3a:	75 26                	jne    62 <main+0x62>
      {
          char *temp;
          temp=(char*)malloc(512*sizeof(char*));
      3c:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
      43:	e8 a8 10 00 00       	call   10f0 <malloc>
          strcat(temp,argv[3]);
      48:	8b 4b 0c             	mov    0xc(%ebx),%ecx
      while(*d) ++d;
      4b:	80 38 00             	cmpb   $0x0,(%eax)
          temp=(char*)malloc(512*sizeof(char*));
      4e:	89 c6                	mov    %eax,%esi
      while(*d) ++d;
      50:	89 c2                	mov    %eax,%edx
      52:	74 35                	je     89 <main+0x89>
      54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      58:	83 c2 01             	add    $0x1,%edx
      5b:	80 3a 00             	cmpb   $0x0,(%edx)
      5e:	75 f8                	jne    58 <main+0x58>
      60:	eb 27                	jmp    89 <main+0x89>
          free(temp);
          exit();
      }
      else
      {
          copy(argv[1],argv[2]);
      62:	8b 43 08             	mov    0x8(%ebx),%eax
      65:	89 44 24 04          	mov    %eax,0x4(%esp)
      69:	8b 43 04             	mov    0x4(%ebx),%eax
      6c:	89 04 24             	mov    %eax,(%esp)
      6f:	e8 bc 01 00 00       	call   230 <copy>
          exit();
      74:	e8 a9 0c 00 00       	call   d22 <exit>
      79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      while(*s) *d++=*s++;
      80:	83 c2 01             	add    $0x1,%edx
      83:	83 c1 01             	add    $0x1,%ecx
      86:	88 42 ff             	mov    %al,-0x1(%edx)
      89:	0f b6 01             	movzbl (%ecx),%eax
      8c:	84 c0                	test   %al,%al
      8e:	75 f0                	jne    80 <main+0x80>
      *d=0;
      90:	c6 02 00             	movb   $0x0,(%edx)
      while(*d) ++d;
      93:	89 f2                	mov    %esi,%edx
      95:	80 3e 00             	cmpb   $0x0,(%esi)
      98:	74 0e                	je     a8 <main+0xa8>
      9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      a0:	83 c2 01             	add    $0x1,%edx
      a3:	80 3a 00             	cmpb   $0x0,(%edx)
      a6:	75 f8                	jne    a0 <main+0xa0>
      while(*s) *d++=*s++;
      a8:	c6 02 2f             	movb   $0x2f,(%edx)
      *d=0;
      ab:	c6 42 01 00          	movb   $0x0,0x1(%edx)
      while(*d) ++d;
      af:	89 f2                	mov    %esi,%edx
          strcat(temp,argv[2]);
      b1:	8b 43 08             	mov    0x8(%ebx),%eax
      while(*d) ++d;
      b4:	80 3e 00             	cmpb   $0x0,(%esi)
      b7:	74 20                	je     d9 <main+0xd9>
      b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      c0:	83 c2 01             	add    $0x1,%edx
      c3:	80 3a 00             	cmpb   $0x0,(%edx)
      c6:	75 f8                	jne    c0 <main+0xc0>
      c8:	eb 0f                	jmp    d9 <main+0xd9>
      ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(*s) *d++=*s++;
      d0:	83 c2 01             	add    $0x1,%edx
      d3:	83 c0 01             	add    $0x1,%eax
      d6:	88 4a ff             	mov    %cl,-0x1(%edx)
      d9:	0f b6 08             	movzbl (%eax),%ecx
      dc:	84 c9                	test   %cl,%cl
      de:	75 f0                	jne    d0 <main+0xd0>
      *d=0;
      e0:	c6 02 00             	movb   $0x0,(%edx)
          mkdir(temp);
      e3:	89 34 24             	mov    %esi,(%esp)
      e6:	e8 9f 0c 00 00       	call   d8a <mkdir>
          cp_rek(argv[2],argv[3]);
      eb:	8b 43 0c             	mov    0xc(%ebx),%eax
      ee:	89 44 24 04          	mov    %eax,0x4(%esp)
      f2:	8b 43 08             	mov    0x8(%ebx),%eax
      f5:	89 04 24             	mov    %eax,(%esp)
      f8:	e8 23 06 00 00       	call   720 <cp_rek>
          free(temp);
      fd:	89 34 24             	mov    %esi,(%esp)
     100:	e8 5b 0f 00 00       	call   1060 <free>
          exit();
     105:	e8 18 0c 00 00       	call   d22 <exit>
          int panjang=strlen(argv[1]);
     10a:	89 04 24             	mov    %eax,(%esp)
          strcpy(eks,argv[1]+1);
     10d:	8d 74 24 10          	lea    0x10(%esp),%esi
          int panjang=strlen(argv[1]);
     111:	e8 6a 0a 00 00       	call   b80 <strlen>
     116:	89 c7                	mov    %eax,%edi
          strcpy(eks,argv[1]+1);
     118:	8b 43 04             	mov    0x4(%ebx),%eax
     11b:	89 34 24             	mov    %esi,(%esp)
     11e:	83 c0 01             	add    $0x1,%eax
     121:	89 44 24 04          	mov    %eax,0x4(%esp)
     125:	e8 d6 09 00 00       	call   b00 <strcpy>
          cp_ls(argv[2],panjang,eks);
     12a:	89 74 24 08          	mov    %esi,0x8(%esp)
     12e:	89 7c 24 04          	mov    %edi,0x4(%esp)
     132:	8b 43 08             	mov    0x8(%ebx),%eax
     135:	89 04 24             	mov    %eax,(%esp)
     138:	e8 73 03 00 00       	call   4b0 <cp_ls>
          exit();
     13d:	e8 e0 0b 00 00       	call   d22 <exit>
          printf(2,"Usage : cp [OPTIONS] [source] [dest]\n");
     142:	c7 44 24 04 8c 12 00 	movl   $0x128c,0x4(%esp)
     149:	00 
     14a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     151:	e8 1a 0d 00 00       	call   e70 <printf>
          printf(2,"Options:\n");
     156:	c7 44 24 04 15 13 00 	movl   $0x1315,0x4(%esp)
     15d:	00 
     15e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     165:	e8 06 0d 00 00       	call   e70 <printf>
          printf(2,"  -R : copy file secara recursive\n");
     16a:	c7 44 24 04 b4 12 00 	movl   $0x12b4,0x4(%esp)
     171:	00 
     172:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     179:	e8 f2 0c 00 00       	call   e70 <printf>
     17e:	e9 99 fe ff ff       	jmp    1c <main+0x1c>
     183:	66 90                	xchg   %ax,%ax
     185:	66 90                	xchg   %ax,%ax
     187:	66 90                	xchg   %ax,%ax
     189:	66 90                	xchg   %ax,%ax
     18b:	66 90                	xchg   %ax,%ax
     18d:	66 90                	xchg   %ax,%ax
     18f:	90                   	nop

00000190 <fmtname>:
  {
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	53                   	push   %ebx
     194:	83 ec 14             	sub    $0x14,%esp
     197:	8b 5d 08             	mov    0x8(%ebp),%ebx
      for(p=path+strlen(path);p>=path && *p!='/';p--);
     19a:	89 1c 24             	mov    %ebx,(%esp)
     19d:	e8 de 09 00 00       	call   b80 <strlen>
     1a2:	01 d8                	add    %ebx,%eax
     1a4:	73 0c                	jae    1b2 <fmtname+0x22>
     1a6:	eb 0f                	jmp    1b7 <fmtname+0x27>
     1a8:	83 e8 01             	sub    $0x1,%eax
     1ab:	39 c3                	cmp    %eax,%ebx
     1ad:	8d 76 00             	lea    0x0(%esi),%esi
     1b0:	77 05                	ja     1b7 <fmtname+0x27>
     1b2:	80 38 2f             	cmpb   $0x2f,(%eax)
     1b5:	75 f1                	jne    1a8 <fmtname+0x18>
      p++;
     1b7:	8d 58 01             	lea    0x1(%eax),%ebx
      memmove(buf,p,strlen(p));
     1ba:	89 1c 24             	mov    %ebx,(%esp)
     1bd:	e8 be 09 00 00       	call   b80 <strlen>
     1c2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     1c6:	c7 04 24 a0 16 00 00 	movl   $0x16a0,(%esp)
     1cd:	89 44 24 08          	mov    %eax,0x8(%esp)
     1d1:	e8 1a 0b 00 00       	call   cf0 <memmove>
  }
     1d6:	83 c4 14             	add    $0x14,%esp
     1d9:	b8 a0 16 00 00       	mov    $0x16a0,%eax
     1de:	5b                   	pop    %ebx
     1df:	5d                   	pop    %ebp
     1e0:	c3                   	ret    
     1e1:	eb 0d                	jmp    1f0 <strcat>
     1e3:	90                   	nop
     1e4:	90                   	nop
     1e5:	90                   	nop
     1e6:	90                   	nop
     1e7:	90                   	nop
     1e8:	90                   	nop
     1e9:	90                   	nop
     1ea:	90                   	nop
     1eb:	90                   	nop
     1ec:	90                   	nop
     1ed:	90                   	nop
     1ee:	90                   	nop
     1ef:	90                   	nop

000001f0 <strcat>:
  {
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	8b 45 08             	mov    0x8(%ebp),%eax
     1f6:	53                   	push   %ebx
     1f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
      while(*d) ++d;
     1fa:	80 38 00             	cmpb   $0x0,(%eax)
     1fd:	89 c2                	mov    %eax,%edx
     1ff:	74 20                	je     221 <strcat+0x31>
     201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     208:	83 c2 01             	add    $0x1,%edx
     20b:	80 3a 00             	cmpb   $0x0,(%edx)
     20e:	75 f8                	jne    208 <strcat+0x18>
      while(*s) *d++=*s++;
     210:	0f b6 0b             	movzbl (%ebx),%ecx
     213:	84 c9                	test   %cl,%cl
     215:	74 11                	je     228 <strcat+0x38>
     217:	90                   	nop
     218:	83 c2 01             	add    $0x1,%edx
     21b:	83 c3 01             	add    $0x1,%ebx
     21e:	88 4a ff             	mov    %cl,-0x1(%edx)
     221:	0f b6 0b             	movzbl (%ebx),%ecx
     224:	84 c9                	test   %cl,%cl
     226:	75 f0                	jne    218 <strcat+0x28>
      *d=0;
     228:	c6 02 00             	movb   $0x0,(%edx)
  }
     22b:	5b                   	pop    %ebx
     22c:	5d                   	pop    %ebp
     22d:	c3                   	ret    
     22e:	66 90                	xchg   %ax,%ax

00000230 <copy>:
  {
     230:	55                   	push   %ebp
     231:	89 e5                	mov    %esp,%ebp
     233:	57                   	push   %edi
     234:	56                   	push   %esi
     235:	53                   	push   %ebx
     236:	83 ec 4c             	sub    $0x4c,%esp
     239:	8b 7d 08             	mov    0x8(%ebp),%edi
      buf=(char*)malloc(512*sizeof(char));
     23c:	c7 04 24 00 02 00 00 	movl   $0x200,(%esp)
     243:	e8 a8 0e 00 00       	call   10f0 <malloc>
      if((fd0=open(from,O_RDONLY))<0)
     248:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     24f:	00 
     250:	89 3c 24             	mov    %edi,(%esp)
      buf=(char*)malloc(512*sizeof(char));
     253:	89 c3                	mov    %eax,%ebx
      if((fd0=open(from,O_RDONLY))<0)
     255:	e8 08 0b 00 00       	call   d62 <open>
     25a:	85 c0                	test   %eax,%eax
     25c:	89 c6                	mov    %eax,%esi
     25e:	0f 88 0b 02 00 00    	js     46f <copy+0x23f>
      if(fstat(fd0,&st)>=0)
     264:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     267:	89 44 24 04          	mov    %eax,0x4(%esp)
     26b:	89 34 24             	mov    %esi,(%esp)
     26e:	e8 07 0b 00 00       	call   d7a <fstat>
     273:	85 c0                	test   %eax,%eax
     275:	78 0b                	js     282 <copy+0x52>
          if(st.type==T_DIR)
     277:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     27c:	0f 84 d0 01 00 00    	je     452 <copy+0x222>
      temp=(char*)malloc(512*sizeof(char));
     282:	c7 04 24 00 02 00 00 	movl   $0x200,(%esp)
     289:	e8 62 0e 00 00       	call   10f0 <malloc>
     28e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
      if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     291:	8b 45 0c             	mov    0xc(%ebp),%eax
     294:	89 04 24             	mov    %eax,(%esp)
     297:	e8 e4 08 00 00       	call   b80 <strlen>
     29c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     29f:	80 7c 01 ff 2f       	cmpb   $0x2f,-0x1(%ecx,%eax,1)
     2a4:	0f 84 b6 00 00 00    	je     360 <copy+0x130>
      fd1=open(to,0);
     2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ad:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     2b4:	00 
     2b5:	89 04 24             	mov    %eax,(%esp)
     2b8:	e8 a5 0a 00 00       	call   d62 <open>
     2bd:	89 c1                	mov    %eax,%ecx
          if(fstat(fd1,&st)>=0 && st.type == T_DIR)
     2bf:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     2c2:	89 0c 24             	mov    %ecx,(%esp)
     2c5:	89 44 24 04          	mov    %eax,0x4(%esp)
     2c9:	89 4d c0             	mov    %ecx,-0x40(%ebp)
     2cc:	e8 a9 0a 00 00       	call   d7a <fstat>
     2d1:	8b 4d c0             	mov    -0x40(%ebp),%ecx
     2d4:	85 c0                	test   %eax,%eax
     2d6:	78 0b                	js     2e3 <copy+0xb3>
     2d8:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     2dd:	0f 84 95 00 00 00    	je     378 <copy+0x148>
              close(fd1);
     2e3:	89 0c 24             	mov    %ecx,(%esp)
     2e6:	e8 5f 0a 00 00       	call   d4a <close>
              if((fd1=open(to,O_CREATE | O_RDWR))<0)
     2eb:	8b 45 0c             	mov    0xc(%ebp),%eax
     2ee:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     2f5:	00 
     2f6:	89 04 24             	mov    %eax,(%esp)
     2f9:	e8 64 0a 00 00       	call   d62 <open>
     2fe:	85 c0                	test   %eax,%eax
     300:	89 c7                	mov    %eax,%edi
     302:	79 20                	jns    324 <copy+0xf4>
     304:	e9 83 01 00 00       	jmp    48c <copy+0x25c>
     309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          printf(fd1,"%s",buf);
     310:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     314:	c7 44 24 04 f5 12 00 	movl   $0x12f5,0x4(%esp)
     31b:	00 
     31c:	89 3c 24             	mov    %edi,(%esp)
     31f:	e8 4c 0b 00 00       	call   e70 <printf>
      while((n=read(fd0,buf,sizeof(buf)))>0)
     324:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
     32b:	00 
     32c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     330:	89 34 24             	mov    %esi,(%esp)
     333:	e8 02 0a 00 00       	call   d3a <read>
     338:	85 c0                	test   %eax,%eax
     33a:	7f d4                	jg     310 <copy+0xe0>
      close(fd1);
     33c:	89 3c 24             	mov    %edi,(%esp)
     33f:	e8 06 0a 00 00       	call   d4a <close>
      free(temp);
     344:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     347:	89 04 24             	mov    %eax,(%esp)
     34a:	e8 11 0d 00 00       	call   1060 <free>
      free(buf);
     34f:	89 1c 24             	mov    %ebx,(%esp)
     352:	e8 09 0d 00 00       	call   1060 <free>
  }
     357:	83 c4 4c             	add    $0x4c,%esp
     35a:	5b                   	pop    %ebx
     35b:	5e                   	pop    %esi
     35c:	5f                   	pop    %edi
     35d:	5d                   	pop    %ebp
     35e:	c3                   	ret    
     35f:	90                   	nop
      if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     360:	89 0c 24             	mov    %ecx,(%esp)
     363:	e8 18 08 00 00       	call   b80 <strlen>
     368:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     36b:	c6 44 01 ff 00       	movb   $0x0,-0x1(%ecx,%eax,1)
     370:	e9 35 ff ff ff       	jmp    2aa <copy+0x7a>
     375:	8d 76 00             	lea    0x0(%esi),%esi
              mkdir(to);
     378:	8b 45 0c             	mov    0xc(%ebp),%eax
     37b:	89 04 24             	mov    %eax,(%esp)
     37e:	e8 07 0a 00 00       	call   d8a <mkdir>
      while(*d) ++d;
     383:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     386:	8b 4d c0             	mov    -0x40(%ebp),%ecx
     389:	80 38 00             	cmpb   $0x0,(%eax)
     38c:	0f 84 ae 00 00 00    	je     440 <copy+0x210>
     392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     398:	83 c0 01             	add    $0x1,%eax
     39b:	80 38 00             	cmpb   $0x0,(%eax)
     39e:	75 f8                	jne    398 <copy+0x168>
      while(*s) *d++=*s++;
     3a0:	8b 55 0c             	mov    0xc(%ebp),%edx
     3a3:	0f b6 12             	movzbl (%edx),%edx
     3a6:	84 d2                	test   %dl,%dl
     3a8:	74 19                	je     3c3 <copy+0x193>
     3aa:	89 5d c0             	mov    %ebx,-0x40(%ebp)
     3ad:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     3b0:	83 c0 01             	add    $0x1,%eax
     3b3:	83 c3 01             	add    $0x1,%ebx
     3b6:	88 50 ff             	mov    %dl,-0x1(%eax)
     3b9:	0f b6 13             	movzbl (%ebx),%edx
     3bc:	84 d2                	test   %dl,%dl
     3be:	75 f0                	jne    3b0 <copy+0x180>
     3c0:	8b 5d c0             	mov    -0x40(%ebp),%ebx
      *d=0;
     3c3:	c6 00 00             	movb   $0x0,(%eax)
      while(*d) ++d;
     3c6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     3c9:	80 38 00             	cmpb   $0x0,(%eax)
     3cc:	74 7f                	je     44d <copy+0x21d>
     3ce:	66 90                	xchg   %ax,%ax
     3d0:	83 c0 01             	add    $0x1,%eax
     3d3:	80 38 00             	cmpb   $0x0,(%eax)
     3d6:	75 f8                	jne    3d0 <copy+0x1a0>
      while(*s) *d++=*s++;
     3d8:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     3db:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     3df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     3e2:	80 38 00             	cmpb   $0x0,(%eax)
     3e5:	74 61                	je     448 <copy+0x218>
     3e7:	89 c2                	mov    %eax,%edx
     3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3f0:	83 c2 01             	add    $0x1,%edx
     3f3:	80 3a 00             	cmpb   $0x0,(%edx)
     3f6:	75 f8                	jne    3f0 <copy+0x1c0>
      while(*s) *d++=*s++;
     3f8:	0f b6 07             	movzbl (%edi),%eax
     3fb:	84 c0                	test   %al,%al
     3fd:	74 11                	je     410 <copy+0x1e0>
     3ff:	90                   	nop
     400:	83 c2 01             	add    $0x1,%edx
     403:	83 c7 01             	add    $0x1,%edi
     406:	88 42 ff             	mov    %al,-0x1(%edx)
     409:	0f b6 07             	movzbl (%edi),%eax
     40c:	84 c0                	test   %al,%al
     40e:	75 f0                	jne    400 <copy+0x1d0>
      *d=0;
     410:	c6 02 00             	movb   $0x0,(%edx)
              close(fd1);
     413:	89 0c 24             	mov    %ecx,(%esp)
     416:	e8 2f 09 00 00       	call   d4a <close>
              if((fd1=open(temp,O_CREATE | O_RDWR))<0)
     41b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     41e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     425:	00 
     426:	89 04 24             	mov    %eax,(%esp)
     429:	e8 34 09 00 00       	call   d62 <open>
     42e:	85 c0                	test   %eax,%eax
     430:	89 c7                	mov    %eax,%edi
     432:	0f 89 ec fe ff ff    	jns    324 <copy+0xf4>
                  printf(2,"cp: error while create '%s'\n",temp);
     438:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     43b:	eb 52                	jmp    48f <copy+0x25f>
     43d:	8d 76 00             	lea    0x0(%esi),%esi
      while(*d) ++d;
     440:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     443:	e9 58 ff ff ff       	jmp    3a0 <copy+0x170>
     448:	8b 55 c4             	mov    -0x3c(%ebp),%edx
     44b:	eb bc                	jmp    409 <copy+0x1d9>
     44d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     450:	eb 86                	jmp    3d8 <copy+0x1a8>
              printf(2,"cp: cannot copy directory '%s'\n",from);
     452:	89 7c 24 08          	mov    %edi,0x8(%esp)
     456:	c7 44 24 04 08 12 00 	movl   $0x1208,0x4(%esp)
     45d:	00 
     45e:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     465:	e8 06 0a 00 00       	call   e70 <printf>
              exit();
     46a:	e8 b3 08 00 00       	call   d22 <exit>
          printf(2,"cp: cannot open '%s' No such file or directory\n",from);
     46f:	89 7c 24 08          	mov    %edi,0x8(%esp)
     473:	c7 44 24 04 d8 11 00 	movl   $0x11d8,0x4(%esp)
     47a:	00 
     47b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     482:	e8 e9 09 00 00       	call   e70 <printf>
          exit();
     487:	e8 96 08 00 00       	call   d22 <exit>
                  printf(2,"cp: error while create '%s'\n",to);
     48c:	8b 45 0c             	mov    0xc(%ebp),%eax
     48f:	89 44 24 08          	mov    %eax,0x8(%esp)
     493:	c7 44 24 04 d8 12 00 	movl   $0x12d8,0x4(%esp)
     49a:	00 
     49b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     4a2:	e8 c9 09 00 00       	call   e70 <printf>
                  exit();
     4a7:	e8 76 08 00 00       	call   d22 <exit>
     4ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004b0 <cp_ls>:
  {
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	57                   	push   %edi
     4b4:	56                   	push   %esi
     4b5:	53                   	push   %ebx
     4b6:	83 ec 5c             	sub    $0x5c,%esp
     4b9:	8b 75 08             	mov    0x8(%ebp),%esi
      buff=(char*)malloc(512*sizeof(char*));
     4bc:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     4c3:	e8 28 0c 00 00       	call   10f0 <malloc>
      if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     4c8:	89 34 24             	mov    %esi,(%esp)
      buff=(char*)malloc(512*sizeof(char*));
     4cb:	89 45 b4             	mov    %eax,-0x4c(%ebp)
      if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     4ce:	e8 ad 06 00 00       	call   b80 <strlen>
     4d3:	80 7c 06 ff 2f       	cmpb   $0x2f,-0x1(%esi,%eax,1)
     4d8:	0f 84 aa 01 00 00    	je     688 <cp_ls+0x1d8>
      if((fd0=open(".",0))<0)
     4de:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4e5:	00 
     4e6:	c7 04 24 f8 12 00 00 	movl   $0x12f8,(%esp)
     4ed:	e8 70 08 00 00       	call   d62 <open>
     4f2:	85 c0                	test   %eax,%eax
     4f4:	89 c3                	mov    %eax,%ebx
     4f6:	0f 88 a6 01 00 00    	js     6a2 <cp_ls+0x1f2>
      if((fd1=open(path,O_RDONLY))<0)
     4fc:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     503:	00 
     504:	89 34 24             	mov    %esi,(%esp)
     507:	e8 56 08 00 00       	call   d62 <open>
     50c:	85 c0                	test   %eax,%eax
     50e:	0f 88 c4 01 00 00    	js     6d8 <cp_ls+0x228>
      if(fstat(fd1,&st)<0)
     514:	8d 4d d4             	lea    -0x2c(%ebp),%ecx
     517:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     51b:	89 04 24             	mov    %eax,(%esp)
     51e:	e8 57 08 00 00       	call   d7a <fstat>
     523:	85 c0                	test   %eax,%eax
     525:	0f 88 90 01 00 00    	js     6bb <cp_ls+0x20b>
          if(st.type!=T_DIR)
     52b:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     530:	0f 85 bf 01 00 00    	jne    6f5 <cp_ls+0x245>
      while(*d) ++d;
     536:	8b 4d b4             	mov    -0x4c(%ebp),%ecx
     539:	80 39 00             	cmpb   $0x0,(%ecx)
     53c:	89 c8                	mov    %ecx,%eax
     53e:	74 19                	je     559 <cp_ls+0xa9>
     540:	83 c0 01             	add    $0x1,%eax
     543:	80 38 00             	cmpb   $0x0,(%eax)
     546:	75 f8                	jne    540 <cp_ls+0x90>
      while(*s) *d++=*s++;
     548:	0f b6 16             	movzbl (%esi),%edx
     54b:	84 d2                	test   %dl,%dl
     54d:	74 11                	je     560 <cp_ls+0xb0>
     54f:	90                   	nop
     550:	83 c0 01             	add    $0x1,%eax
     553:	83 c6 01             	add    $0x1,%esi
     556:	88 50 ff             	mov    %dl,-0x1(%eax)
     559:	0f b6 16             	movzbl (%esi),%edx
     55c:	84 d2                	test   %dl,%dl
     55e:	75 f0                	jne    550 <cp_ls+0xa0>
      *d=0;
     560:	c6 00 00             	movb   $0x0,(%eax)
      while(*d) ++d;
     563:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     566:	80 38 00             	cmpb   $0x0,(%eax)
     569:	0f 84 2b 01 00 00    	je     69a <cp_ls+0x1ea>
     56f:	90                   	nop
     570:	83 c0 01             	add    $0x1,%eax
     573:	80 38 00             	cmpb   $0x0,(%eax)
     576:	75 f8                	jne    570 <cp_ls+0xc0>
      while(*s) *d++=*s++;
     578:	c6 00 2f             	movb   $0x2f,(%eax)
     57b:	8d 75 c4             	lea    -0x3c(%ebp),%esi
      *d=0;
     57e:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      int len=strlen(buff);
     582:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     585:	89 04 24             	mov    %eax,(%esp)
     588:	e8 f3 05 00 00       	call   b80 <strlen>
          if(strcmp(de.name+(strlen(de.name)-panjang+1),ekstensi)==0) 
     58d:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
      int len=strlen(buff);
     594:	89 45 b0             	mov    %eax,-0x50(%ebp)
          if(strcmp(de.name+(strlen(de.name)-panjang+1),ekstensi)==0) 
     597:	8b 45 0c             	mov    0xc(%ebp),%eax
     59a:	29 45 ac             	sub    %eax,-0x54(%ebp)
     59d:	8d 76 00             	lea    0x0(%esi),%esi
      while(read(fd0,&de,sizeof(de))==sizeof(de))
     5a0:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     5a7:	00 
     5a8:	89 74 24 04          	mov    %esi,0x4(%esp)
     5ac:	89 1c 24             	mov    %ebx,(%esp)
     5af:	e8 86 07 00 00       	call   d3a <read>
     5b4:	83 f8 10             	cmp    $0x10,%eax
     5b7:	0f 85 93 00 00 00    	jne    650 <cp_ls+0x1a0>
          if(de.inum==0) 
     5bd:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     5c2:	74 dc                	je     5a0 <cp_ls+0xf0>
          if(de.name[0]=='.')
     5c4:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     5c8:	74 d6                	je     5a0 <cp_ls+0xf0>
          if(stat(de.name, &st) >= 0 && st.type == T_DIR) continue;
     5ca:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     5cd:	8d 7d c6             	lea    -0x3a(%ebp),%edi
     5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5d4:	89 3c 24             	mov    %edi,(%esp)
     5d7:	e8 94 06 00 00       	call   c70 <stat>
     5dc:	85 c0                	test   %eax,%eax
     5de:	78 07                	js     5e7 <cp_ls+0x137>
     5e0:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
     5e5:	74 b9                	je     5a0 <cp_ls+0xf0>
          memmove(buff+len,de.name,strlen(de.name));
     5e7:	89 3c 24             	mov    %edi,(%esp)
     5ea:	e8 91 05 00 00       	call   b80 <strlen>
     5ef:	8b 55 b4             	mov    -0x4c(%ebp),%edx
     5f2:	03 55 b0             	add    -0x50(%ebp),%edx
     5f5:	89 7c 24 04          	mov    %edi,0x4(%esp)
     5f9:	89 14 24             	mov    %edx,(%esp)
     5fc:	89 55 a8             	mov    %edx,-0x58(%ebp)
     5ff:	89 44 24 08          	mov    %eax,0x8(%esp)
     603:	e8 e8 06 00 00       	call   cf0 <memmove>
          if(strcmp(de.name+(strlen(de.name)-panjang+1),ekstensi)==0) 
     608:	89 3c 24             	mov    %edi,(%esp)
     60b:	e8 70 05 00 00       	call   b80 <strlen>
     610:	8b 4d 10             	mov    0x10(%ebp),%ecx
     613:	03 45 ac             	add    -0x54(%ebp),%eax
     616:	89 4c 24 04          	mov    %ecx,0x4(%esp)
     61a:	8d 44 06 02          	lea    0x2(%esi,%eax,1),%eax
     61e:	89 04 24             	mov    %eax,(%esp)
     621:	e8 0a 05 00 00       	call   b30 <strcmp>
     626:	8b 55 a8             	mov    -0x58(%ebp),%edx
     629:	85 c0                	test   %eax,%eax
     62b:	74 43                	je     670 <cp_ls+0x1c0>
          memset(buff+len,'\0',sizeof(buff)+len);
     62d:	8b 45 b0             	mov    -0x50(%ebp),%eax
     630:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     637:	00 
     638:	89 14 24             	mov    %edx,(%esp)
     63b:	83 c0 04             	add    $0x4,%eax
     63e:	89 44 24 08          	mov    %eax,0x8(%esp)
     642:	e8 69 05 00 00       	call   bb0 <memset>
     647:	e9 54 ff ff ff       	jmp    5a0 <cp_ls+0xf0>
     64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      free(buff);
     650:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     653:	89 04 24             	mov    %eax,(%esp)
     656:	e8 05 0a 00 00       	call   1060 <free>
      close(fd0);
     65b:	89 1c 24             	mov    %ebx,(%esp)
     65e:	e8 e7 06 00 00       	call   d4a <close>
  }
     663:	83 c4 5c             	add    $0x5c,%esp
     666:	5b                   	pop    %ebx
     667:	5e                   	pop    %esi
     668:	5f                   	pop    %edi
     669:	5d                   	pop    %ebp
     66a:	c3                   	ret    
     66b:	90                   	nop
     66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
              copy(de.name,buff);
     670:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     673:	89 3c 24             	mov    %edi,(%esp)
     676:	89 44 24 04          	mov    %eax,0x4(%esp)
     67a:	e8 b1 fb ff ff       	call   230 <copy>
     67f:	8b 55 a8             	mov    -0x58(%ebp),%edx
     682:	eb a9                	jmp    62d <cp_ls+0x17d>
     684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(path[strlen(path)-1]=='/') path[strlen(path)-1]=0;
     688:	89 34 24             	mov    %esi,(%esp)
     68b:	e8 f0 04 00 00       	call   b80 <strlen>
     690:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
     695:	e9 44 fe ff ff       	jmp    4de <cp_ls+0x2e>
      while(*d) ++d;
     69a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     69d:	e9 d6 fe ff ff       	jmp    578 <cp_ls+0xc8>
          printf(2,"cp: cannot open '\".\"' No such file or directory\n");
     6a2:	c7 44 24 04 28 12 00 	movl   $0x1228,0x4(%esp)
     6a9:	00 
     6aa:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     6b1:	e8 ba 07 00 00       	call   e70 <printf>
          exit();
     6b6:	e8 67 06 00 00       	call   d22 <exit>
          printf(2,"cp: cannot stat '%s' No such file or directory\n",path);
     6bb:	89 74 24 08          	mov    %esi,0x8(%esp)
     6bf:	c7 44 24 04 5c 12 00 	movl   $0x125c,0x4(%esp)
     6c6:	00 
     6c7:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     6ce:	e8 9d 07 00 00       	call   e70 <printf>
          exit();
     6d3:	e8 4a 06 00 00       	call   d22 <exit>
          printf(2,"cp: cannot open '%s' No such file or directory\n",path);
     6d8:	89 74 24 08          	mov    %esi,0x8(%esp)
     6dc:	c7 44 24 04 d8 11 00 	movl   $0x11d8,0x4(%esp)
     6e3:	00 
     6e4:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     6eb:	e8 80 07 00 00       	call   e70 <printf>
          exit();
     6f0:	e8 2d 06 00 00       	call   d22 <exit>
              printf(2,"cp: '%s' is not directory\n",path);
     6f5:	89 74 24 08          	mov    %esi,0x8(%esp)
     6f9:	c7 44 24 04 fa 12 00 	movl   $0x12fa,0x4(%esp)
     700:	00 
     701:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     708:	e8 63 07 00 00       	call   e70 <printf>
              exit();
     70d:	e8 10 06 00 00       	call   d22 <exit>
     712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <cp_rek>:
  {
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 4c             	sub    $0x4c,%esp
      buff=(char*)malloc(512*sizeof(char*));
     729:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     730:	e8 bb 09 00 00       	call   10f0 <malloc>
     735:	89 45 b4             	mov    %eax,-0x4c(%ebp)
      if(from[strlen(from)-1]=='/') from[strlen(from)-1]=0;
     738:	8b 45 08             	mov    0x8(%ebp),%eax
     73b:	89 04 24             	mov    %eax,(%esp)
     73e:	e8 3d 04 00 00       	call   b80 <strlen>
     743:	8b 7d 08             	mov    0x8(%ebp),%edi
     746:	80 7c 07 ff 2f       	cmpb   $0x2f,-0x1(%edi,%eax,1)
     74b:	0f 84 47 03 00 00    	je     a98 <cp_rek+0x378>
      if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     751:	8b 45 0c             	mov    0xc(%ebp),%eax
     754:	89 04 24             	mov    %eax,(%esp)
     757:	e8 24 04 00 00       	call   b80 <strlen>
     75c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     75f:	80 7c 03 ff 2f       	cmpb   $0x2f,-0x1(%ebx,%eax,1)
     764:	0f 84 16 03 00 00    	je     a80 <cp_rek+0x360>
      if((fd0=open(from,0))<0)
     76a:	8b 45 08             	mov    0x8(%ebp),%eax
     76d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     774:	00 
     775:	89 04 24             	mov    %eax,(%esp)
     778:	e8 e5 05 00 00       	call   d62 <open>
     77d:	85 c0                	test   %eax,%eax
     77f:	89 c7                	mov    %eax,%edi
     781:	0f 88 36 03 00 00    	js     abd <cp_rek+0x39d>
      if(fstat(fd0,&st)<0)
     787:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     78a:	89 44 24 04          	mov    %eax,0x4(%esp)
     78e:	89 3c 24             	mov    %edi,(%esp)
     791:	e8 e4 05 00 00       	call   d7a <fstat>
     796:	85 c0                	test   %eax,%eax
     798:	0f 88 3f 03 00 00    	js     add <cp_rek+0x3bd>
      temp=(char*)malloc(512*sizeof(char*));
     79e:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
     7a5:	e8 46 09 00 00       	call   10f0 <malloc>
      temp2=(char*)malloc(512*sizeof(char*));
     7aa:	c7 04 24 00 08 00 00 	movl   $0x800,(%esp)
      temp=(char*)malloc(512*sizeof(char*));
     7b1:	89 c3                	mov    %eax,%ebx
      temp2=(char*)malloc(512*sizeof(char*));
     7b3:	e8 38 09 00 00       	call   10f0 <malloc>
     7b8:	89 c6                	mov    %eax,%esi
      switch(st.type)
     7ba:	0f b7 45 d4          	movzwl -0x2c(%ebp),%eax
     7be:	66 83 f8 01          	cmp    $0x1,%ax
     7c2:	74 3c                	je     800 <cp_rek+0xe0>
     7c4:	66 83 f8 02          	cmp    $0x2,%ax
     7c8:	75 12                	jne    7dc <cp_rek+0xbc>
              copy(from,to);
     7ca:	8b 45 0c             	mov    0xc(%ebp),%eax
     7cd:	89 44 24 04          	mov    %eax,0x4(%esp)
     7d1:	8b 45 08             	mov    0x8(%ebp),%eax
     7d4:	89 04 24             	mov    %eax,(%esp)
     7d7:	e8 54 fa ff ff       	call   230 <copy>
      free(temp);
     7dc:	89 1c 24             	mov    %ebx,(%esp)
     7df:	e8 7c 08 00 00       	call   1060 <free>
      free(temp2);
     7e4:	89 34 24             	mov    %esi,(%esp)
     7e7:	e8 74 08 00 00       	call   1060 <free>
      free(buff);
     7ec:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     7ef:	89 04 24             	mov    %eax,(%esp)
     7f2:	e8 69 08 00 00       	call   1060 <free>
  }
     7f7:	83 c4 4c             	add    $0x4c,%esp
     7fa:	5b                   	pop    %ebx
     7fb:	5e                   	pop    %esi
     7fc:	5f                   	pop    %edi
     7fd:	5d                   	pop    %ebp
     7fe:	c3                   	ret    
     7ff:	90                   	nop
              strcpy(buff,to);
     800:	8b 45 0c             	mov    0xc(%ebp),%eax
     803:	89 44 24 04          	mov    %eax,0x4(%esp)
     807:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     80a:	89 04 24             	mov    %eax,(%esp)
     80d:	e8 ee 02 00 00       	call   b00 <strcpy>
      while(*d) ++d;
     812:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     815:	80 38 00             	cmpb   $0x0,(%eax)
     818:	0f 84 97 02 00 00    	je     ab5 <cp_rek+0x395>
     81e:	66 90                	xchg   %ax,%ax
     820:	83 c0 01             	add    $0x1,%eax
     823:	80 38 00             	cmpb   $0x0,(%eax)
     826:	75 f8                	jne    820 <cp_rek+0x100>
      while(*s) *d++=*s++;
     828:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     82b:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     82f:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     832:	80 38 00             	cmpb   $0x0,(%eax)
     835:	0f 84 72 02 00 00    	je     aad <cp_rek+0x38d>
     83b:	90                   	nop
     83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     840:	83 c0 01             	add    $0x1,%eax
     843:	80 38 00             	cmpb   $0x0,(%eax)
     846:	75 f8                	jne    840 <cp_rek+0x120>
      while(*s) *d++=*s++;
     848:	8b 4d 08             	mov    0x8(%ebp),%ecx
     84b:	0f b6 11             	movzbl (%ecx),%edx
     84e:	84 d2                	test   %dl,%dl
     850:	74 16                	je     868 <cp_rek+0x148>
     852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     858:	83 c0 01             	add    $0x1,%eax
     85b:	83 c1 01             	add    $0x1,%ecx
     85e:	88 50 ff             	mov    %dl,-0x1(%eax)
     861:	0f b6 11             	movzbl (%ecx),%edx
     864:	84 d2                	test   %dl,%dl
     866:	75 f0                	jne    858 <cp_rek+0x138>
      *d=0;
     868:	c6 00 00             	movb   $0x0,(%eax)
              if(mkdir(to)>=0)
     86b:	8b 45 0c             	mov    0xc(%ebp),%eax
     86e:	89 04 24             	mov    %eax,(%esp)
     871:	e8 14 05 00 00       	call   d8a <mkdir>
     876:	85 c0                	test   %eax,%eax
     878:	0f 88 a9 01 00 00    	js     a27 <cp_rek+0x307>
     87e:	66 90                	xchg   %ax,%ax
                  while(read(fd0,&de,sizeof(de))==sizeof(de))
     880:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     883:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     88a:	00 
     88b:	89 44 24 04          	mov    %eax,0x4(%esp)
     88f:	89 3c 24             	mov    %edi,(%esp)
     892:	e8 a3 04 00 00       	call   d3a <read>
     897:	83 f8 10             	cmp    $0x10,%eax
     89a:	0f 85 3c ff ff ff    	jne    7dc <cp_rek+0xbc>
                      if(de.inum==0 || de.name[0]=='.') 
     8a0:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     8a5:	74 d9                	je     880 <cp_rek+0x160>
     8a7:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     8ab:	74 d3                	je     880 <cp_rek+0x160>
                      strcpy(temp,from);
     8ad:	8b 45 08             	mov    0x8(%ebp),%eax
     8b0:	89 1c 24             	mov    %ebx,(%esp)
     8b3:	89 44 24 04          	mov    %eax,0x4(%esp)
     8b7:	e8 44 02 00 00       	call   b00 <strcpy>
      while(*d) ++d;
     8bc:	89 d8                	mov    %ebx,%eax
     8be:	80 3b 00             	cmpb   $0x0,(%ebx)
     8c1:	74 0d                	je     8d0 <cp_rek+0x1b0>
     8c3:	90                   	nop
     8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8c8:	83 c0 01             	add    $0x1,%eax
     8cb:	80 38 00             	cmpb   $0x0,(%eax)
     8ce:	75 f8                	jne    8c8 <cp_rek+0x1a8>
      while(*s) *d++=*s++;
     8d0:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     8d3:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     8d7:	89 d8                	mov    %ebx,%eax
     8d9:	80 3b 00             	cmpb   $0x0,(%ebx)
     8dc:	74 0a                	je     8e8 <cp_rek+0x1c8>
     8de:	66 90                	xchg   %ax,%ax
     8e0:	83 c0 01             	add    $0x1,%eax
     8e3:	80 38 00             	cmpb   $0x0,(%eax)
     8e6:	75 f8                	jne    8e0 <cp_rek+0x1c0>
      while(*s) *d++=*s++;
     8e8:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     8ec:	84 d2                	test   %dl,%dl
     8ee:	74 18                	je     908 <cp_rek+0x1e8>
     8f0:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     8f3:	90                   	nop
     8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8f8:	83 c0 01             	add    $0x1,%eax
     8fb:	83 c1 01             	add    $0x1,%ecx
     8fe:	88 50 ff             	mov    %dl,-0x1(%eax)
     901:	0f b6 11             	movzbl (%ecx),%edx
     904:	84 d2                	test   %dl,%dl
     906:	75 f0                	jne    8f8 <cp_rek+0x1d8>
      *d=0;
     908:	c6 00 00             	movb   $0x0,(%eax)
                      strcpy(temp2,to);
     90b:	8b 45 0c             	mov    0xc(%ebp),%eax
     90e:	89 34 24             	mov    %esi,(%esp)
     911:	89 44 24 04          	mov    %eax,0x4(%esp)
     915:	e8 e6 01 00 00       	call   b00 <strcpy>
      while(*d) ++d;
     91a:	89 f0                	mov    %esi,%eax
     91c:	80 3e 00             	cmpb   $0x0,(%esi)
     91f:	74 0f                	je     930 <cp_rek+0x210>
     921:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     928:	83 c0 01             	add    $0x1,%eax
     92b:	80 38 00             	cmpb   $0x0,(%eax)
     92e:	75 f8                	jne    928 <cp_rek+0x208>
      while(*s) *d++=*s++;
     930:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     933:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     937:	89 f0                	mov    %esi,%eax
     939:	80 3e 00             	cmpb   $0x0,(%esi)
     93c:	74 0a                	je     948 <cp_rek+0x228>
     93e:	66 90                	xchg   %ax,%ax
     940:	83 c0 01             	add    $0x1,%eax
     943:	80 38 00             	cmpb   $0x0,(%eax)
     946:	75 f8                	jne    940 <cp_rek+0x220>
      while(*s) *d++=*s++;
     948:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     94c:	84 d2                	test   %dl,%dl
     94e:	74 18                	je     968 <cp_rek+0x248>
     950:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     953:	90                   	nop
     954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     958:	83 c0 01             	add    $0x1,%eax
     95b:	83 c1 01             	add    $0x1,%ecx
     95e:	88 50 ff             	mov    %dl,-0x1(%eax)
     961:	0f b6 11             	movzbl (%ecx),%edx
     964:	84 d2                	test   %dl,%dl
     966:	75 f0                	jne    958 <cp_rek+0x238>
      *d=0;
     968:	c6 00 00             	movb   $0x0,(%eax)
                      cp_rek(temp,temp2);
     96b:	89 74 24 04          	mov    %esi,0x4(%esp)
     96f:	89 1c 24             	mov    %ebx,(%esp)
     972:	e8 a9 fd ff ff       	call   720 <cp_rek>
     977:	e9 04 ff ff ff       	jmp    880 <cp_rek+0x160>
     97c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(*s) *d++=*s++;
     980:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     983:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     987:	89 d8                	mov    %ebx,%eax
     989:	80 3b 00             	cmpb   $0x0,(%ebx)
     98c:	74 0a                	je     998 <cp_rek+0x278>
     98e:	66 90                	xchg   %ax,%ax
     990:	83 c0 01             	add    $0x1,%eax
     993:	80 38 00             	cmpb   $0x0,(%eax)
     996:	75 f8                	jne    990 <cp_rek+0x270>
      while(*s) *d++=*s++;
     998:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     99c:	84 d2                	test   %dl,%dl
     99e:	74 18                	je     9b8 <cp_rek+0x298>
     9a0:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     9a3:	90                   	nop
     9a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9a8:	83 c0 01             	add    $0x1,%eax
     9ab:	83 c1 01             	add    $0x1,%ecx
     9ae:	88 50 ff             	mov    %dl,-0x1(%eax)
     9b1:	0f b6 11             	movzbl (%ecx),%edx
     9b4:	84 d2                	test   %dl,%dl
     9b6:	75 f0                	jne    9a8 <cp_rek+0x288>
      *d=0;
     9b8:	c6 00 00             	movb   $0x0,(%eax)
                      strcpy(temp2,buff);
     9bb:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     9be:	89 34 24             	mov    %esi,(%esp)
     9c1:	89 44 24 04          	mov    %eax,0x4(%esp)
     9c5:	e8 36 01 00 00       	call   b00 <strcpy>
      while(*d) ++d;
     9ca:	89 f0                	mov    %esi,%eax
     9cc:	80 3e 00             	cmpb   $0x0,(%esi)
     9cf:	74 0f                	je     9e0 <cp_rek+0x2c0>
     9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     9d8:	83 c0 01             	add    $0x1,%eax
     9db:	80 38 00             	cmpb   $0x0,(%eax)
     9de:	75 f8                	jne    9d8 <cp_rek+0x2b8>
      while(*s) *d++=*s++;
     9e0:	c6 00 2f             	movb   $0x2f,(%eax)
      *d=0;
     9e3:	c6 40 01 00          	movb   $0x0,0x1(%eax)
      while(*d) ++d;
     9e7:	89 f0                	mov    %esi,%eax
     9e9:	80 3e 00             	cmpb   $0x0,(%esi)
     9ec:	74 0a                	je     9f8 <cp_rek+0x2d8>
     9ee:	66 90                	xchg   %ax,%ax
     9f0:	83 c0 01             	add    $0x1,%eax
     9f3:	80 38 00             	cmpb   $0x0,(%eax)
     9f6:	75 f8                	jne    9f0 <cp_rek+0x2d0>
      while(*s) *d++=*s++;
     9f8:	0f b6 55 c6          	movzbl -0x3a(%ebp),%edx
     9fc:	84 d2                	test   %dl,%dl
     9fe:	74 18                	je     a18 <cp_rek+0x2f8>
     a00:	8d 4d c6             	lea    -0x3a(%ebp),%ecx
     a03:	90                   	nop
     a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a08:	83 c0 01             	add    $0x1,%eax
     a0b:	83 c1 01             	add    $0x1,%ecx
     a0e:	88 50 ff             	mov    %dl,-0x1(%eax)
     a11:	0f b6 11             	movzbl (%ecx),%edx
     a14:	84 d2                	test   %dl,%dl
     a16:	75 f0                	jne    a08 <cp_rek+0x2e8>
      *d=0;
     a18:	c6 00 00             	movb   $0x0,(%eax)
                      cp_rek(temp,temp2);
     a1b:	89 74 24 04          	mov    %esi,0x4(%esp)
     a1f:	89 1c 24             	mov    %ebx,(%esp)
     a22:	e8 f9 fc ff ff       	call   720 <cp_rek>
                  while(read(fd0,&de,sizeof(de))==sizeof(de))
     a27:	8d 45 c4             	lea    -0x3c(%ebp),%eax
     a2a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
     a31:	00 
     a32:	89 44 24 04          	mov    %eax,0x4(%esp)
     a36:	89 3c 24             	mov    %edi,(%esp)
     a39:	e8 fc 02 00 00       	call   d3a <read>
     a3e:	83 f8 10             	cmp    $0x10,%eax
     a41:	0f 85 95 fd ff ff    	jne    7dc <cp_rek+0xbc>
                      if(de.inum==0 || de.name[0]=='.') 
     a47:	66 83 7d c4 00       	cmpw   $0x0,-0x3c(%ebp)
     a4c:	74 d9                	je     a27 <cp_rek+0x307>
     a4e:	80 7d c6 2e          	cmpb   $0x2e,-0x3a(%ebp)
     a52:	74 d3                	je     a27 <cp_rek+0x307>
                      strcpy(temp,from);
     a54:	8b 45 08             	mov    0x8(%ebp),%eax
     a57:	89 1c 24             	mov    %ebx,(%esp)
     a5a:	89 44 24 04          	mov    %eax,0x4(%esp)
     a5e:	e8 9d 00 00 00       	call   b00 <strcpy>
      while(*d) ++d;
     a63:	89 d8                	mov    %ebx,%eax
     a65:	80 3b 00             	cmpb   $0x0,(%ebx)
     a68:	0f 84 12 ff ff ff    	je     980 <cp_rek+0x260>
     a6e:	66 90                	xchg   %ax,%ax
     a70:	83 c0 01             	add    $0x1,%eax
     a73:	80 38 00             	cmpb   $0x0,(%eax)
     a76:	75 f8                	jne    a70 <cp_rek+0x350>
     a78:	e9 03 ff ff ff       	jmp    980 <cp_rek+0x260>
     a7d:	8d 76 00             	lea    0x0(%esi),%esi
      if(to[strlen(to)-1]=='/') to[strlen(to)-1]=0;
     a80:	89 1c 24             	mov    %ebx,(%esp)
     a83:	e8 f8 00 00 00       	call   b80 <strlen>
     a88:	8b 75 0c             	mov    0xc(%ebp),%esi
     a8b:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
     a90:	e9 d5 fc ff ff       	jmp    76a <cp_rek+0x4a>
     a95:	8d 76 00             	lea    0x0(%esi),%esi
      if(from[strlen(from)-1]=='/') from[strlen(from)-1]=0;
     a98:	89 3c 24             	mov    %edi,(%esp)
     a9b:	e8 e0 00 00 00       	call   b80 <strlen>
     aa0:	8b 75 08             	mov    0x8(%ebp),%esi
     aa3:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
     aa8:	e9 a4 fc ff ff       	jmp    751 <cp_rek+0x31>
      while(*d) ++d;
     aad:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     ab0:	e9 93 fd ff ff       	jmp    848 <cp_rek+0x128>
     ab5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
     ab8:	e9 6b fd ff ff       	jmp    828 <cp_rek+0x108>
          printf(2,"cp: cannot open '%s' No such file or directory\n",from);
     abd:	8b 45 08             	mov    0x8(%ebp),%eax
     ac0:	c7 44 24 04 d8 11 00 	movl   $0x11d8,0x4(%esp)
     ac7:	00 
     ac8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     acf:	89 44 24 08          	mov    %eax,0x8(%esp)
     ad3:	e8 98 03 00 00       	call   e70 <printf>
          exit();
     ad8:	e8 45 02 00 00       	call   d22 <exit>
          printf(2,"cp: cannot stat '%s' No such file or directory\n",from);
     add:	8b 45 08             	mov    0x8(%ebp),%eax
     ae0:	c7 44 24 04 5c 12 00 	movl   $0x125c,0x4(%esp)
     ae7:	00 
     ae8:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     aef:	89 44 24 08          	mov    %eax,0x8(%esp)
     af3:	e8 78 03 00 00       	call   e70 <printf>
          exit();
     af8:	e8 25 02 00 00       	call   d22 <exit>
     afd:	66 90                	xchg   %ax,%ax
     aff:	90                   	nop

00000b00 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	8b 45 08             	mov    0x8(%ebp),%eax
     b06:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     b09:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b0a:	89 c2                	mov    %eax,%edx
     b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b10:	83 c1 01             	add    $0x1,%ecx
     b13:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     b17:	83 c2 01             	add    $0x1,%edx
     b1a:	84 db                	test   %bl,%bl
     b1c:	88 5a ff             	mov    %bl,-0x1(%edx)
     b1f:	75 ef                	jne    b10 <strcpy+0x10>
    ;
  return os;
}
     b21:	5b                   	pop    %ebx
     b22:	5d                   	pop    %ebp
     b23:	c3                   	ret    
     b24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b30:	55                   	push   %ebp
     b31:	89 e5                	mov    %esp,%ebp
     b33:	8b 55 08             	mov    0x8(%ebp),%edx
     b36:	53                   	push   %ebx
     b37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b3a:	0f b6 02             	movzbl (%edx),%eax
     b3d:	84 c0                	test   %al,%al
     b3f:	74 2d                	je     b6e <strcmp+0x3e>
     b41:	0f b6 19             	movzbl (%ecx),%ebx
     b44:	38 d8                	cmp    %bl,%al
     b46:	74 0e                	je     b56 <strcmp+0x26>
     b48:	eb 2b                	jmp    b75 <strcmp+0x45>
     b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b50:	38 c8                	cmp    %cl,%al
     b52:	75 15                	jne    b69 <strcmp+0x39>
    p++, q++;
     b54:	89 d9                	mov    %ebx,%ecx
     b56:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b59:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b5c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     b5f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
     b63:	84 c0                	test   %al,%al
     b65:	75 e9                	jne    b50 <strcmp+0x20>
     b67:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b69:	29 c8                	sub    %ecx,%eax
}
     b6b:	5b                   	pop    %ebx
     b6c:	5d                   	pop    %ebp
     b6d:	c3                   	ret    
     b6e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
     b71:	31 c0                	xor    %eax,%eax
     b73:	eb f4                	jmp    b69 <strcmp+0x39>
     b75:	0f b6 cb             	movzbl %bl,%ecx
     b78:	eb ef                	jmp    b69 <strcmp+0x39>
     b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b80 <strlen>:

uint
strlen(const char *s)
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b86:	80 39 00             	cmpb   $0x0,(%ecx)
     b89:	74 12                	je     b9d <strlen+0x1d>
     b8b:	31 d2                	xor    %edx,%edx
     b8d:	8d 76 00             	lea    0x0(%esi),%esi
     b90:	83 c2 01             	add    $0x1,%edx
     b93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b97:	89 d0                	mov    %edx,%eax
     b99:	75 f5                	jne    b90 <strlen+0x10>
    ;
  return n;
}
     b9b:	5d                   	pop    %ebp
     b9c:	c3                   	ret    
  for(n = 0; s[n]; n++)
     b9d:	31 c0                	xor    %eax,%eax
}
     b9f:	5d                   	pop    %ebp
     ba0:	c3                   	ret    
     ba1:	eb 0d                	jmp    bb0 <memset>
     ba3:	90                   	nop
     ba4:	90                   	nop
     ba5:	90                   	nop
     ba6:	90                   	nop
     ba7:	90                   	nop
     ba8:	90                   	nop
     ba9:	90                   	nop
     baa:	90                   	nop
     bab:	90                   	nop
     bac:	90                   	nop
     bad:	90                   	nop
     bae:	90                   	nop
     baf:	90                   	nop

00000bb0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	8b 55 08             	mov    0x8(%ebp),%edx
     bb6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     bb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     bba:	8b 45 0c             	mov    0xc(%ebp),%eax
     bbd:	89 d7                	mov    %edx,%edi
     bbf:	fc                   	cld    
     bc0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     bc2:	89 d0                	mov    %edx,%eax
     bc4:	5f                   	pop    %edi
     bc5:	5d                   	pop    %ebp
     bc6:	c3                   	ret    
     bc7:	89 f6                	mov    %esi,%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <strchr>:

char*
strchr(const char *s, char c)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	8b 45 08             	mov    0x8(%ebp),%eax
     bd6:	53                   	push   %ebx
     bd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     bda:	0f b6 18             	movzbl (%eax),%ebx
     bdd:	84 db                	test   %bl,%bl
     bdf:	74 1d                	je     bfe <strchr+0x2e>
    if(*s == c)
     be1:	38 d3                	cmp    %dl,%bl
     be3:	89 d1                	mov    %edx,%ecx
     be5:	75 0d                	jne    bf4 <strchr+0x24>
     be7:	eb 17                	jmp    c00 <strchr+0x30>
     be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bf0:	38 ca                	cmp    %cl,%dl
     bf2:	74 0c                	je     c00 <strchr+0x30>
  for(; *s; s++)
     bf4:	83 c0 01             	add    $0x1,%eax
     bf7:	0f b6 10             	movzbl (%eax),%edx
     bfa:	84 d2                	test   %dl,%dl
     bfc:	75 f2                	jne    bf0 <strchr+0x20>
      return (char*)s;
  return 0;
     bfe:	31 c0                	xor    %eax,%eax
}
     c00:	5b                   	pop    %ebx
     c01:	5d                   	pop    %ebp
     c02:	c3                   	ret    
     c03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c10 <gets>:

char*
gets(char *buf, int max)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	57                   	push   %edi
     c14:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c15:	31 f6                	xor    %esi,%esi
{
     c17:	53                   	push   %ebx
     c18:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
     c1b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     c1e:	eb 31                	jmp    c51 <gets+0x41>
    cc = read(0, &c, 1);
     c20:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c27:	00 
     c28:	89 7c 24 04          	mov    %edi,0x4(%esp)
     c2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     c33:	e8 02 01 00 00       	call   d3a <read>
    if(cc < 1)
     c38:	85 c0                	test   %eax,%eax
     c3a:	7e 1d                	jle    c59 <gets+0x49>
      break;
    buf[i++] = c;
     c3c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
     c40:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
     c42:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
     c45:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
     c47:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     c4b:	74 0c                	je     c59 <gets+0x49>
     c4d:	3c 0a                	cmp    $0xa,%al
     c4f:	74 08                	je     c59 <gets+0x49>
  for(i=0; i+1 < max; ){
     c51:	8d 5e 01             	lea    0x1(%esi),%ebx
     c54:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c57:	7c c7                	jl     c20 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     c59:	8b 45 08             	mov    0x8(%ebp),%eax
     c5c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c60:	83 c4 2c             	add    $0x2c,%esp
     c63:	5b                   	pop    %ebx
     c64:	5e                   	pop    %esi
     c65:	5f                   	pop    %edi
     c66:	5d                   	pop    %ebp
     c67:	c3                   	ret    
     c68:	90                   	nop
     c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c70 <stat>:

int
stat(const char *n, struct stat *st)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
     c75:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c78:	8b 45 08             	mov    0x8(%ebp),%eax
     c7b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c82:	00 
     c83:	89 04 24             	mov    %eax,(%esp)
     c86:	e8 d7 00 00 00       	call   d62 <open>
  if(fd < 0)
     c8b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
     c8d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     c8f:	78 27                	js     cb8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
     c91:	8b 45 0c             	mov    0xc(%ebp),%eax
     c94:	89 1c 24             	mov    %ebx,(%esp)
     c97:	89 44 24 04          	mov    %eax,0x4(%esp)
     c9b:	e8 da 00 00 00       	call   d7a <fstat>
  close(fd);
     ca0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     ca3:	89 c6                	mov    %eax,%esi
  close(fd);
     ca5:	e8 a0 00 00 00       	call   d4a <close>
  return r;
     caa:	89 f0                	mov    %esi,%eax
}
     cac:	83 c4 10             	add    $0x10,%esp
     caf:	5b                   	pop    %ebx
     cb0:	5e                   	pop    %esi
     cb1:	5d                   	pop    %ebp
     cb2:	c3                   	ret    
     cb3:	90                   	nop
     cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     cb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     cbd:	eb ed                	jmp    cac <stat+0x3c>
     cbf:	90                   	nop

00000cc0 <atoi>:

int
atoi(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     cc6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cc7:	0f be 11             	movsbl (%ecx),%edx
     cca:	8d 42 d0             	lea    -0x30(%edx),%eax
     ccd:	3c 09                	cmp    $0x9,%al
  n = 0;
     ccf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cd4:	77 17                	ja     ced <atoi+0x2d>
     cd6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     cd8:	83 c1 01             	add    $0x1,%ecx
     cdb:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cde:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     ce2:	0f be 11             	movsbl (%ecx),%edx
     ce5:	8d 5a d0             	lea    -0x30(%edx),%ebx
     ce8:	80 fb 09             	cmp    $0x9,%bl
     ceb:	76 eb                	jbe    cd8 <atoi+0x18>
  return n;
}
     ced:	5b                   	pop    %ebx
     cee:	5d                   	pop    %ebp
     cef:	c3                   	ret    

00000cf0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     cf0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cf1:	31 d2                	xor    %edx,%edx
{
     cf3:	89 e5                	mov    %esp,%ebp
     cf5:	56                   	push   %esi
     cf6:	8b 45 08             	mov    0x8(%ebp),%eax
     cf9:	53                   	push   %ebx
     cfa:	8b 5d 10             	mov    0x10(%ebp),%ebx
     cfd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
     d00:	85 db                	test   %ebx,%ebx
     d02:	7e 12                	jle    d16 <memmove+0x26>
     d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d08:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d0c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d0f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d12:	39 da                	cmp    %ebx,%edx
     d14:	75 f2                	jne    d08 <memmove+0x18>
  return vdst;
}
     d16:	5b                   	pop    %ebx
     d17:	5e                   	pop    %esi
     d18:	5d                   	pop    %ebp
     d19:	c3                   	ret    

00000d1a <fork>:
     d1a:	b8 01 00 00 00       	mov    $0x1,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <exit>:
     d22:	b8 02 00 00 00       	mov    $0x2,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <wait>:
     d2a:	b8 03 00 00 00       	mov    $0x3,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <pipe>:
     d32:	b8 04 00 00 00       	mov    $0x4,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <read>:
     d3a:	b8 05 00 00 00       	mov    $0x5,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <write>:
     d42:	b8 10 00 00 00       	mov    $0x10,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <close>:
     d4a:	b8 15 00 00 00       	mov    $0x15,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <kill>:
     d52:	b8 06 00 00 00       	mov    $0x6,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <exec>:
     d5a:	b8 07 00 00 00       	mov    $0x7,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <open>:
     d62:	b8 0f 00 00 00       	mov    $0xf,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <mknod>:
     d6a:	b8 11 00 00 00       	mov    $0x11,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <unlink>:
     d72:	b8 12 00 00 00       	mov    $0x12,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <fstat>:
     d7a:	b8 08 00 00 00       	mov    $0x8,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <link>:
     d82:	b8 13 00 00 00       	mov    $0x13,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <mkdir>:
     d8a:	b8 14 00 00 00       	mov    $0x14,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <chdir>:
     d92:	b8 09 00 00 00       	mov    $0x9,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <dup>:
     d9a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <getpid>:
     da2:	b8 0b 00 00 00       	mov    $0xb,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <sbrk>:
     daa:	b8 0c 00 00 00       	mov    $0xc,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <sleep>:
     db2:	b8 0d 00 00 00       	mov    $0xd,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <uptime>:
     dba:	b8 0e 00 00 00       	mov    $0xe,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    
     dc2:	66 90                	xchg   %ax,%ax
     dc4:	66 90                	xchg   %ax,%ax
     dc6:	66 90                	xchg   %ax,%ax
     dc8:	66 90                	xchg   %ax,%ax
     dca:	66 90                	xchg   %ax,%ax
     dcc:	66 90                	xchg   %ax,%ax
     dce:	66 90                	xchg   %ax,%ax

00000dd0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
     dd5:	89 c6                	mov    %eax,%esi
     dd7:	53                   	push   %ebx
     dd8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ddb:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dde:	85 db                	test   %ebx,%ebx
     de0:	74 09                	je     deb <printint+0x1b>
     de2:	89 d0                	mov    %edx,%eax
     de4:	c1 e8 1f             	shr    $0x1f,%eax
     de7:	84 c0                	test   %al,%al
     de9:	75 75                	jne    e60 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     deb:	89 d0                	mov    %edx,%eax
  neg = 0;
     ded:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     df4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
     df7:	31 ff                	xor    %edi,%edi
     df9:	89 ce                	mov    %ecx,%esi
     dfb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     dfe:	eb 02                	jmp    e02 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
     e00:	89 cf                	mov    %ecx,%edi
     e02:	31 d2                	xor    %edx,%edx
     e04:	f7 f6                	div    %esi
     e06:	8d 4f 01             	lea    0x1(%edi),%ecx
     e09:	0f b6 92 29 13 00 00 	movzbl 0x1329(%edx),%edx
  }while((x /= base) != 0);
     e10:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e12:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     e15:	75 e9                	jne    e00 <printint+0x30>
  if(neg)
     e17:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
     e1a:	89 c8                	mov    %ecx,%eax
     e1c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
     e1f:	85 d2                	test   %edx,%edx
     e21:	74 08                	je     e2b <printint+0x5b>
    buf[i++] = '-';
     e23:	8d 4f 02             	lea    0x2(%edi),%ecx
     e26:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
     e2b:	8d 79 ff             	lea    -0x1(%ecx),%edi
     e2e:	66 90                	xchg   %ax,%ax
     e30:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
     e35:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
     e38:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e3f:	00 
     e40:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     e44:	89 34 24             	mov    %esi,(%esp)
     e47:	88 45 d7             	mov    %al,-0x29(%ebp)
     e4a:	e8 f3 fe ff ff       	call   d42 <write>
  while(--i >= 0)
     e4f:	83 ff ff             	cmp    $0xffffffff,%edi
     e52:	75 dc                	jne    e30 <printint+0x60>
    putc(fd, buf[i]);
}
     e54:	83 c4 4c             	add    $0x4c,%esp
     e57:	5b                   	pop    %ebx
     e58:	5e                   	pop    %esi
     e59:	5f                   	pop    %edi
     e5a:	5d                   	pop    %ebp
     e5b:	c3                   	ret    
     e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
     e60:	89 d0                	mov    %edx,%eax
     e62:	f7 d8                	neg    %eax
    neg = 1;
     e64:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     e6b:	eb 87                	jmp    df4 <printint+0x24>
     e6d:	8d 76 00             	lea    0x0(%esi),%esi

00000e70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     e70:	55                   	push   %ebp
     e71:	89 e5                	mov    %esp,%ebp
     e73:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     e74:	31 ff                	xor    %edi,%edi
{
     e76:	56                   	push   %esi
     e77:	53                   	push   %ebx
     e78:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e7b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
     e7e:	8d 45 10             	lea    0x10(%ebp),%eax
{
     e81:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
     e84:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     e87:	0f b6 13             	movzbl (%ebx),%edx
     e8a:	83 c3 01             	add    $0x1,%ebx
     e8d:	84 d2                	test   %dl,%dl
     e8f:	75 39                	jne    eca <printf+0x5a>
     e91:	e9 c2 00 00 00       	jmp    f58 <printf+0xe8>
     e96:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e98:	83 fa 25             	cmp    $0x25,%edx
     e9b:	0f 84 bf 00 00 00    	je     f60 <printf+0xf0>
  write(fd, &c, 1);
     ea1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     ea4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     eab:	00 
     eac:	89 44 24 04          	mov    %eax,0x4(%esp)
     eb0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
     eb3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
     eb6:	e8 87 fe ff ff       	call   d42 <write>
     ebb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
     ebe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     ec2:	84 d2                	test   %dl,%dl
     ec4:	0f 84 8e 00 00 00    	je     f58 <printf+0xe8>
    if(state == 0){
     eca:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     ecc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
     ecf:	74 c7                	je     e98 <printf+0x28>
      }
    } else if(state == '%'){
     ed1:	83 ff 25             	cmp    $0x25,%edi
     ed4:	75 e5                	jne    ebb <printf+0x4b>
      if(c == 'd'){
     ed6:	83 fa 64             	cmp    $0x64,%edx
     ed9:	0f 84 31 01 00 00    	je     1010 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     edf:	25 f7 00 00 00       	and    $0xf7,%eax
     ee4:	83 f8 70             	cmp    $0x70,%eax
     ee7:	0f 84 83 00 00 00    	je     f70 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     eed:	83 fa 73             	cmp    $0x73,%edx
     ef0:	0f 84 a2 00 00 00    	je     f98 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     ef6:	83 fa 63             	cmp    $0x63,%edx
     ef9:	0f 84 35 01 00 00    	je     1034 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     eff:	83 fa 25             	cmp    $0x25,%edx
     f02:	0f 84 e0 00 00 00    	je     fe8 <printf+0x178>
  write(fd, &c, 1);
     f08:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f0b:	83 c3 01             	add    $0x1,%ebx
     f0e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f15:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f16:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     f18:	89 44 24 04          	mov    %eax,0x4(%esp)
     f1c:	89 34 24             	mov    %esi,(%esp)
     f1f:	89 55 d0             	mov    %edx,-0x30(%ebp)
     f22:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
     f26:	e8 17 fe ff ff       	call   d42 <write>
        putc(fd, c);
     f2b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
     f2e:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f31:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f38:	00 
     f39:	89 44 24 04          	mov    %eax,0x4(%esp)
     f3d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
     f40:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
     f43:	e8 fa fd ff ff       	call   d42 <write>
  for(i = 0; fmt[i]; i++){
     f48:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     f4c:	84 d2                	test   %dl,%dl
     f4e:	0f 85 76 ff ff ff    	jne    eca <printf+0x5a>
     f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
     f58:	83 c4 3c             	add    $0x3c,%esp
     f5b:	5b                   	pop    %ebx
     f5c:	5e                   	pop    %esi
     f5d:	5f                   	pop    %edi
     f5e:	5d                   	pop    %ebp
     f5f:	c3                   	ret    
        state = '%';
     f60:	bf 25 00 00 00       	mov    $0x25,%edi
     f65:	e9 51 ff ff ff       	jmp    ebb <printf+0x4b>
     f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     f70:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f73:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
     f78:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
     f7a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     f81:	8b 10                	mov    (%eax),%edx
     f83:	89 f0                	mov    %esi,%eax
     f85:	e8 46 fe ff ff       	call   dd0 <printint>
        ap++;
     f8a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
     f8e:	e9 28 ff ff ff       	jmp    ebb <printf+0x4b>
     f93:	90                   	nop
     f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     f98:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
     f9b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
     f9f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
     fa1:	b8 22 13 00 00       	mov    $0x1322,%eax
     fa6:	85 ff                	test   %edi,%edi
     fa8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
     fab:	0f b6 07             	movzbl (%edi),%eax
     fae:	84 c0                	test   %al,%al
     fb0:	74 2a                	je     fdc <printf+0x16c>
     fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fb8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     fbb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
     fbe:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
     fc1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     fc8:	00 
     fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
     fcd:	89 34 24             	mov    %esi,(%esp)
     fd0:	e8 6d fd ff ff       	call   d42 <write>
        while(*s != 0){
     fd5:	0f b6 07             	movzbl (%edi),%eax
     fd8:	84 c0                	test   %al,%al
     fda:	75 dc                	jne    fb8 <printf+0x148>
      state = 0;
     fdc:	31 ff                	xor    %edi,%edi
     fde:	e9 d8 fe ff ff       	jmp    ebb <printf+0x4b>
     fe3:	90                   	nop
     fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
     fe8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
     feb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     fed:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ff4:	00 
     ff5:	89 44 24 04          	mov    %eax,0x4(%esp)
     ff9:	89 34 24             	mov    %esi,(%esp)
     ffc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    1000:	e8 3d fd ff ff       	call   d42 <write>
    1005:	e9 b1 fe ff ff       	jmp    ebb <printf+0x4b>
    100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1010:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1013:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
    1018:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
    101b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1022:	8b 10                	mov    (%eax),%edx
    1024:	89 f0                	mov    %esi,%eax
    1026:	e8 a5 fd ff ff       	call   dd0 <printint>
        ap++;
    102b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    102f:	e9 87 fe ff ff       	jmp    ebb <printf+0x4b>
        putc(fd, *ap);
    1034:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
    1037:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
    1039:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    103b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1042:	00 
    1043:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
    1046:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1049:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    104c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1050:	e8 ed fc ff ff       	call   d42 <write>
        ap++;
    1055:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1059:	e9 5d fe ff ff       	jmp    ebb <printf+0x4b>
    105e:	66 90                	xchg   %ax,%ax

00001060 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1060:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1061:	a1 a0 18 00 00       	mov    0x18a0,%eax
{
    1066:	89 e5                	mov    %esp,%ebp
    1068:	57                   	push   %edi
    1069:	56                   	push   %esi
    106a:	53                   	push   %ebx
    106b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    106e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
    1070:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1073:	39 d0                	cmp    %edx,%eax
    1075:	72 11                	jb     1088 <free+0x28>
    1077:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1078:	39 c8                	cmp    %ecx,%eax
    107a:	72 04                	jb     1080 <free+0x20>
    107c:	39 ca                	cmp    %ecx,%edx
    107e:	72 10                	jb     1090 <free+0x30>
    1080:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1082:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1084:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1086:	73 f0                	jae    1078 <free+0x18>
    1088:	39 ca                	cmp    %ecx,%edx
    108a:	72 04                	jb     1090 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    108c:	39 c8                	cmp    %ecx,%eax
    108e:	72 f0                	jb     1080 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1090:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1093:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    1096:	39 cf                	cmp    %ecx,%edi
    1098:	74 1e                	je     10b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    109a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    109d:	8b 48 04             	mov    0x4(%eax),%ecx
    10a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    10a3:	39 f2                	cmp    %esi,%edx
    10a5:	74 28                	je     10cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10a7:	89 10                	mov    %edx,(%eax)
  freep = p;
    10a9:	a3 a0 18 00 00       	mov    %eax,0x18a0
}
    10ae:	5b                   	pop    %ebx
    10af:	5e                   	pop    %esi
    10b0:	5f                   	pop    %edi
    10b1:	5d                   	pop    %ebp
    10b2:	c3                   	ret    
    10b3:	90                   	nop
    10b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    10b8:	03 71 04             	add    0x4(%ecx),%esi
    10bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    10be:	8b 08                	mov    (%eax),%ecx
    10c0:	8b 09                	mov    (%ecx),%ecx
    10c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10c5:	8b 48 04             	mov    0x4(%eax),%ecx
    10c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    10cb:	39 f2                	cmp    %esi,%edx
    10cd:	75 d8                	jne    10a7 <free+0x47>
    p->s.size += bp->s.size;
    10cf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
    10d2:	a3 a0 18 00 00       	mov    %eax,0x18a0
    p->s.size += bp->s.size;
    10d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10da:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10dd:	89 10                	mov    %edx,(%eax)
}
    10df:	5b                   	pop    %ebx
    10e0:	5e                   	pop    %esi
    10e1:	5f                   	pop    %edi
    10e2:	5d                   	pop    %ebp
    10e3:	c3                   	ret    
    10e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    10ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	57                   	push   %edi
    10f4:	56                   	push   %esi
    10f5:	53                   	push   %ebx
    10f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10fc:	8b 1d a0 18 00 00    	mov    0x18a0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1102:	8d 48 07             	lea    0x7(%eax),%ecx
    1105:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
    1108:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    110a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
    110d:	0f 84 9b 00 00 00    	je     11ae <malloc+0xbe>
    1113:	8b 13                	mov    (%ebx),%edx
    1115:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1118:	39 fe                	cmp    %edi,%esi
    111a:	76 64                	jbe    1180 <malloc+0x90>
    111c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
    1123:	bb 00 80 00 00       	mov    $0x8000,%ebx
    1128:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    112b:	eb 0e                	jmp    113b <malloc+0x4b>
    112d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1130:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1132:	8b 78 04             	mov    0x4(%eax),%edi
    1135:	39 fe                	cmp    %edi,%esi
    1137:	76 4f                	jbe    1188 <malloc+0x98>
    1139:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    113b:	3b 15 a0 18 00 00    	cmp    0x18a0,%edx
    1141:	75 ed                	jne    1130 <malloc+0x40>
  if(nu < 4096)
    1143:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1146:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    114c:	bf 00 10 00 00       	mov    $0x1000,%edi
    1151:	0f 43 fe             	cmovae %esi,%edi
    1154:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
    1157:	89 04 24             	mov    %eax,(%esp)
    115a:	e8 4b fc ff ff       	call   daa <sbrk>
  if(p == (char*)-1)
    115f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1162:	74 18                	je     117c <malloc+0x8c>
  hp->s.size = nu;
    1164:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1167:	83 c0 08             	add    $0x8,%eax
    116a:	89 04 24             	mov    %eax,(%esp)
    116d:	e8 ee fe ff ff       	call   1060 <free>
  return freep;
    1172:	8b 15 a0 18 00 00    	mov    0x18a0,%edx
      if((p = morecore(nunits)) == 0)
    1178:	85 d2                	test   %edx,%edx
    117a:	75 b4                	jne    1130 <malloc+0x40>
        return 0;
    117c:	31 c0                	xor    %eax,%eax
    117e:	eb 20                	jmp    11a0 <malloc+0xb0>
    if(p->s.size >= nunits){
    1180:	89 d0                	mov    %edx,%eax
    1182:	89 da                	mov    %ebx,%edx
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    1188:	39 fe                	cmp    %edi,%esi
    118a:	74 1c                	je     11a8 <malloc+0xb8>
        p->s.size -= nunits;
    118c:	29 f7                	sub    %esi,%edi
    118e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    1191:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    1194:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    1197:	89 15 a0 18 00 00    	mov    %edx,0x18a0
      return (void*)(p + 1);
    119d:	83 c0 08             	add    $0x8,%eax
  }
}
    11a0:	83 c4 1c             	add    $0x1c,%esp
    11a3:	5b                   	pop    %ebx
    11a4:	5e                   	pop    %esi
    11a5:	5f                   	pop    %edi
    11a6:	5d                   	pop    %ebp
    11a7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    11a8:	8b 08                	mov    (%eax),%ecx
    11aa:	89 0a                	mov    %ecx,(%edx)
    11ac:	eb e9                	jmp    1197 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
    11ae:	c7 05 a0 18 00 00 a4 	movl   $0x18a4,0x18a0
    11b5:	18 00 00 
    base.s.size = 0;
    11b8:	ba a4 18 00 00       	mov    $0x18a4,%edx
    base.s.ptr = freep = prevp = &base;
    11bd:	c7 05 a4 18 00 00 a4 	movl   $0x18a4,0x18a4
    11c4:	18 00 00 
    base.s.size = 0;
    11c7:	c7 05 a8 18 00 00 00 	movl   $0x0,0x18a8
    11ce:	00 00 00 
    11d1:	e9 46 ff ff ff       	jmp    111c <malloc+0x2c>
