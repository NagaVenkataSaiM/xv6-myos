
_getpinfo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  getpinfo ();
   6:	e8 c7 02 00 00       	call   2d2 <getpinfo>
  exit();
   b:	e8 22 02 00 00       	call   232 <exit>

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	8b 45 08             	mov    0x8(%ebp),%eax
  16:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  19:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  1a:	89 c2                	mov    %eax,%edx
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  20:	83 c1 01             	add    $0x1,%ecx
  23:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  27:	83 c2 01             	add    $0x1,%edx
  2a:	84 db                	test   %bl,%bl
  2c:	88 5a ff             	mov    %bl,-0x1(%edx)
  2f:	75 ef                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  31:	5b                   	pop    %ebx
  32:	5d                   	pop    %ebp
  33:	c3                   	ret    
  34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	8b 55 08             	mov    0x8(%ebp),%edx
  46:	53                   	push   %ebx
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  4a:	0f b6 02             	movzbl (%edx),%eax
  4d:	84 c0                	test   %al,%al
  4f:	74 2d                	je     7e <strcmp+0x3e>
  51:	0f b6 19             	movzbl (%ecx),%ebx
  54:	38 d8                	cmp    %bl,%al
  56:	74 0e                	je     66 <strcmp+0x26>
  58:	eb 2b                	jmp    85 <strcmp+0x45>
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  60:	38 c8                	cmp    %cl,%al
  62:	75 15                	jne    79 <strcmp+0x39>
    p++, q++;
  64:	89 d9                	mov    %ebx,%ecx
  66:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  69:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  6c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  6f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  73:	84 c0                	test   %al,%al
  75:	75 e9                	jne    60 <strcmp+0x20>
  77:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  79:	29 c8                	sub    %ecx,%eax
}
  7b:	5b                   	pop    %ebx
  7c:	5d                   	pop    %ebp
  7d:	c3                   	ret    
  7e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  81:	31 c0                	xor    %eax,%eax
  83:	eb f4                	jmp    79 <strcmp+0x39>
  85:	0f b6 cb             	movzbl %bl,%ecx
  88:	eb ef                	jmp    79 <strcmp+0x39>
  8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 39 00             	cmpb   $0x0,(%ecx)
  99:	74 12                	je     ad <strlen+0x1d>
  9b:	31 d2                	xor    %edx,%edx
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	83 c2 01             	add    $0x1,%edx
  a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  a7:	89 d0                	mov    %edx,%eax
  a9:	75 f5                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  for(n = 0; s[n]; n++)
  ad:	31 c0                	xor    %eax,%eax
}
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    
  b1:	eb 0d                	jmp    c0 <memset>
  b3:	90                   	nop
  b4:	90                   	nop
  b5:	90                   	nop
  b6:	90                   	nop
  b7:	90                   	nop
  b8:	90                   	nop
  b9:	90                   	nop
  ba:	90                   	nop
  bb:	90                   	nop
  bc:	90                   	nop
  bd:	90                   	nop
  be:	90                   	nop
  bf:	90                   	nop

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	89 d0                	mov    %edx,%eax
  d4:	5f                   	pop    %edi
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	53                   	push   %ebx
  e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  ea:	0f b6 18             	movzbl (%eax),%ebx
  ed:	84 db                	test   %bl,%bl
  ef:	74 1d                	je     10e <strchr+0x2e>
    if(*s == c)
  f1:	38 d3                	cmp    %dl,%bl
  f3:	89 d1                	mov    %edx,%ecx
  f5:	75 0d                	jne    104 <strchr+0x24>
  f7:	eb 17                	jmp    110 <strchr+0x30>
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 100:	38 ca                	cmp    %cl,%dl
 102:	74 0c                	je     110 <strchr+0x30>
  for(; *s; s++)
 104:	83 c0 01             	add    $0x1,%eax
 107:	0f b6 10             	movzbl (%eax),%edx
 10a:	84 d2                	test   %dl,%dl
 10c:	75 f2                	jne    100 <strchr+0x20>
      return (char*)s;
  return 0;
 10e:	31 c0                	xor    %eax,%eax
}
 110:	5b                   	pop    %ebx
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
{
 127:	53                   	push   %ebx
 128:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 12b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 12e:	eb 31                	jmp    161 <gets+0x41>
    cc = read(0, &c, 1);
 130:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 137:	00 
 138:	89 7c 24 04          	mov    %edi,0x4(%esp)
 13c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 143:	e8 02 01 00 00       	call   24a <read>
    if(cc < 1)
 148:	85 c0                	test   %eax,%eax
 14a:	7e 1d                	jle    169 <gets+0x49>
      break;
    buf[i++] = c;
 14c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 150:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 152:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 155:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 157:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 15b:	74 0c                	je     169 <gets+0x49>
 15d:	3c 0a                	cmp    $0xa,%al
 15f:	74 08                	je     169 <gets+0x49>
  for(i=0; i+1 < max; ){
 161:	8d 5e 01             	lea    0x1(%esi),%ebx
 164:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 167:	7c c7                	jl     130 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 170:	83 c4 2c             	add    $0x2c,%esp
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
 185:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 192:	00 
 193:	89 04 24             	mov    %eax,(%esp)
 196:	e8 d7 00 00 00       	call   272 <open>
  if(fd < 0)
 19b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 19d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 19f:	78 27                	js     1c8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a4:	89 1c 24             	mov    %ebx,(%esp)
 1a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ab:	e8 da 00 00 00       	call   28a <fstat>
  close(fd);
 1b0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1b3:	89 c6                	mov    %eax,%esi
  close(fd);
 1b5:	e8 a0 00 00 00       	call   25a <close>
  return r;
 1ba:	89 f0                	mov    %esi,%eax
}
 1bc:	83 c4 10             	add    $0x10,%esp
 1bf:	5b                   	pop    %ebx
 1c0:	5e                   	pop    %esi
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	90                   	nop
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1cd:	eb ed                	jmp    1bc <stat+0x3c>
 1cf:	90                   	nop

000001d0 <atoi>:

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 11             	movsbl (%ecx),%edx
 1da:	8d 42 d0             	lea    -0x30(%edx),%eax
 1dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 1df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1e4:	77 17                	ja     1fd <atoi+0x2d>
 1e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1e8:	83 c1 01             	add    $0x1,%ecx
 1eb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1ee:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1f2:	0f be 11             	movsbl (%ecx),%edx
 1f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1f8:	80 fb 09             	cmp    $0x9,%bl
 1fb:	76 eb                	jbe    1e8 <atoi+0x18>
  return n;
}
 1fd:	5b                   	pop    %ebx
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    

00000200 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 200:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 201:	31 d2                	xor    %edx,%edx
{
 203:	89 e5                	mov    %esp,%ebp
 205:	56                   	push   %esi
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	53                   	push   %ebx
 20a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 20d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 210:	85 db                	test   %ebx,%ebx
 212:	7e 12                	jle    226 <memmove+0x26>
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 218:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 21c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 21f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 222:	39 da                	cmp    %ebx,%edx
 224:	75 f2                	jne    218 <memmove+0x18>
  return vdst;
}
 226:	5b                   	pop    %ebx
 227:	5e                   	pop    %esi
 228:	5d                   	pop    %ebp
 229:	c3                   	ret    

0000022a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 22a:	b8 01 00 00 00       	mov    $0x1,%eax
 22f:	cd 40                	int    $0x40
 231:	c3                   	ret    

00000232 <exit>:
SYSCALL(exit)
 232:	b8 02 00 00 00       	mov    $0x2,%eax
 237:	cd 40                	int    $0x40
 239:	c3                   	ret    

0000023a <wait>:
SYSCALL(wait)
 23a:	b8 03 00 00 00       	mov    $0x3,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <pipe>:
SYSCALL(pipe)
 242:	b8 04 00 00 00       	mov    $0x4,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <read>:
SYSCALL(read)
 24a:	b8 05 00 00 00       	mov    $0x5,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <write>:
SYSCALL(write)
 252:	b8 10 00 00 00       	mov    $0x10,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <close>:
SYSCALL(close)
 25a:	b8 15 00 00 00       	mov    $0x15,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <kill>:
SYSCALL(kill)
 262:	b8 06 00 00 00       	mov    $0x6,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <exec>:
SYSCALL(exec)
 26a:	b8 07 00 00 00       	mov    $0x7,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <open>:
SYSCALL(open)
 272:	b8 0f 00 00 00       	mov    $0xf,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <mknod>:
SYSCALL(mknod)
 27a:	b8 11 00 00 00       	mov    $0x11,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <unlink>:
SYSCALL(unlink)
 282:	b8 12 00 00 00       	mov    $0x12,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <fstat>:
SYSCALL(fstat)
 28a:	b8 08 00 00 00       	mov    $0x8,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <link>:
SYSCALL(link)
 292:	b8 13 00 00 00       	mov    $0x13,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <mkdir>:
SYSCALL(mkdir)
 29a:	b8 14 00 00 00       	mov    $0x14,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <chdir>:
SYSCALL(chdir)
 2a2:	b8 09 00 00 00       	mov    $0x9,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <dup>:
SYSCALL(dup)
 2aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <getpid>:
SYSCALL(getpid)
 2b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <sbrk>:
SYSCALL(sbrk)
 2ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <sleep>:
SYSCALL(sleep)
 2c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <uptime>:
SYSCALL(uptime)
 2ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <getpinfo>:
SYSCALL(getpinfo)
 2d2:	b8 16 00 00 00       	mov    $0x16,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    
 2da:	66 90                	xchg   %ax,%ax
 2dc:	66 90                	xchg   %ax,%ax
 2de:	66 90                	xchg   %ax,%ax

000002e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
 2e5:	89 c6                	mov    %eax,%esi
 2e7:	53                   	push   %ebx
 2e8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2ee:	85 db                	test   %ebx,%ebx
 2f0:	74 09                	je     2fb <printint+0x1b>
 2f2:	89 d0                	mov    %edx,%eax
 2f4:	c1 e8 1f             	shr    $0x1f,%eax
 2f7:	84 c0                	test   %al,%al
 2f9:	75 75                	jne    370 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 2fb:	89 d0                	mov    %edx,%eax
  neg = 0;
 2fd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 304:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 307:	31 ff                	xor    %edi,%edi
 309:	89 ce                	mov    %ecx,%esi
 30b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 30e:	eb 02                	jmp    312 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 310:	89 cf                	mov    %ecx,%edi
 312:	31 d2                	xor    %edx,%edx
 314:	f7 f6                	div    %esi
 316:	8d 4f 01             	lea    0x1(%edi),%ecx
 319:	0f b6 92 ed 06 00 00 	movzbl 0x6ed(%edx),%edx
  }while((x /= base) != 0);
 320:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 322:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 325:	75 e9                	jne    310 <printint+0x30>
  if(neg)
 327:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 32a:	89 c8                	mov    %ecx,%eax
 32c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 32f:	85 d2                	test   %edx,%edx
 331:	74 08                	je     33b <printint+0x5b>
    buf[i++] = '-';
 333:	8d 4f 02             	lea    0x2(%edi),%ecx
 336:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 33b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 33e:	66 90                	xchg   %ax,%ax
 340:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 345:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 348:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 34f:	00 
 350:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 354:	89 34 24             	mov    %esi,(%esp)
 357:	88 45 d7             	mov    %al,-0x29(%ebp)
 35a:	e8 f3 fe ff ff       	call   252 <write>
  while(--i >= 0)
 35f:	83 ff ff             	cmp    $0xffffffff,%edi
 362:	75 dc                	jne    340 <printint+0x60>
    putc(fd, buf[i]);
}
 364:	83 c4 4c             	add    $0x4c,%esp
 367:	5b                   	pop    %ebx
 368:	5e                   	pop    %esi
 369:	5f                   	pop    %edi
 36a:	5d                   	pop    %ebp
 36b:	c3                   	ret    
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 370:	89 d0                	mov    %edx,%eax
 372:	f7 d8                	neg    %eax
    neg = 1;
 374:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 37b:	eb 87                	jmp    304 <printint+0x24>
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 384:	31 ff                	xor    %edi,%edi
{
 386:	56                   	push   %esi
 387:	53                   	push   %ebx
 388:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 38b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 38e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 391:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 394:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 397:	0f b6 13             	movzbl (%ebx),%edx
 39a:	83 c3 01             	add    $0x1,%ebx
 39d:	84 d2                	test   %dl,%dl
 39f:	75 39                	jne    3da <printf+0x5a>
 3a1:	e9 c2 00 00 00       	jmp    468 <printf+0xe8>
 3a6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3a8:	83 fa 25             	cmp    $0x25,%edx
 3ab:	0f 84 bf 00 00 00    	je     470 <printf+0xf0>
  write(fd, &c, 1);
 3b1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3bb:	00 
 3bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 3c3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
  write(fd, &c, 1);
 3c6:	e8 87 fe ff ff       	call   252 <write>
 3cb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 3ce:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 3d2:	84 d2                	test   %dl,%dl
 3d4:	0f 84 8e 00 00 00    	je     468 <printf+0xe8>
    if(state == 0){
 3da:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 3dc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 3df:	74 c7                	je     3a8 <printf+0x28>
      }
    } else if(state == '%'){
 3e1:	83 ff 25             	cmp    $0x25,%edi
 3e4:	75 e5                	jne    3cb <printf+0x4b>
      if(c == 'd'){
 3e6:	83 fa 64             	cmp    $0x64,%edx
 3e9:	0f 84 31 01 00 00    	je     520 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3ef:	25 f7 00 00 00       	and    $0xf7,%eax
 3f4:	83 f8 70             	cmp    $0x70,%eax
 3f7:	0f 84 83 00 00 00    	je     480 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3fd:	83 fa 73             	cmp    $0x73,%edx
 400:	0f 84 a2 00 00 00    	je     4a8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 406:	83 fa 63             	cmp    $0x63,%edx
 409:	0f 84 35 01 00 00    	je     544 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 40f:	83 fa 25             	cmp    $0x25,%edx
 412:	0f 84 e0 00 00 00    	je     4f8 <printf+0x178>
  write(fd, &c, 1);
 418:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 41b:	83 c3 01             	add    $0x1,%ebx
 41e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 425:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 426:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 428:	89 44 24 04          	mov    %eax,0x4(%esp)
 42c:	89 34 24             	mov    %esi,(%esp)
 42f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 432:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 436:	e8 17 fe ff ff       	call   252 <write>
        putc(fd, c);
 43b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 43e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 441:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 448:	00 
 449:	89 44 24 04          	mov    %eax,0x4(%esp)
 44d:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 450:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 453:	e8 fa fd ff ff       	call   252 <write>
  for(i = 0; fmt[i]; i++){
 458:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 45c:	84 d2                	test   %dl,%dl
 45e:	0f 85 76 ff ff ff    	jne    3da <printf+0x5a>
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }
}
 468:	83 c4 3c             	add    $0x3c,%esp
 46b:	5b                   	pop    %ebx
 46c:	5e                   	pop    %esi
 46d:	5f                   	pop    %edi
 46e:	5d                   	pop    %ebp
 46f:	c3                   	ret    
        state = '%';
 470:	bf 25 00 00 00       	mov    $0x25,%edi
 475:	e9 51 ff ff ff       	jmp    3cb <printf+0x4b>
 47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 480:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 483:	b9 10 00 00 00       	mov    $0x10,%ecx
      state = 0;
 488:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 48a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 491:	8b 10                	mov    (%eax),%edx
 493:	89 f0                	mov    %esi,%eax
 495:	e8 46 fe ff ff       	call   2e0 <printint>
        ap++;
 49a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 49e:	e9 28 ff ff ff       	jmp    3cb <printf+0x4b>
 4a3:	90                   	nop
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 4a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 4ab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 4af:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 4b1:	b8 e6 06 00 00       	mov    $0x6e6,%eax
 4b6:	85 ff                	test   %edi,%edi
 4b8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 4bb:	0f b6 07             	movzbl (%edi),%eax
 4be:	84 c0                	test   %al,%al
 4c0:	74 2a                	je     4ec <printf+0x16c>
 4c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4c8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 4cb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 4ce:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 4d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d8:	00 
 4d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4dd:	89 34 24             	mov    %esi,(%esp)
 4e0:	e8 6d fd ff ff       	call   252 <write>
        while(*s != 0){
 4e5:	0f b6 07             	movzbl (%edi),%eax
 4e8:	84 c0                	test   %al,%al
 4ea:	75 dc                	jne    4c8 <printf+0x148>
      state = 0;
 4ec:	31 ff                	xor    %edi,%edi
 4ee:	e9 d8 fe ff ff       	jmp    3cb <printf+0x4b>
 4f3:	90                   	nop
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4f8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 4fb:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4fd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 504:	00 
 505:	89 44 24 04          	mov    %eax,0x4(%esp)
 509:	89 34 24             	mov    %esi,(%esp)
 50c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 510:	e8 3d fd ff ff       	call   252 <write>
 515:	e9 b1 fe ff ff       	jmp    3cb <printf+0x4b>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 520:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 523:	b9 0a 00 00 00       	mov    $0xa,%ecx
      state = 0;
 528:	66 31 ff             	xor    %di,%di
        printint(fd, *ap, 10, 1);
 52b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 532:	8b 10                	mov    (%eax),%edx
 534:	89 f0                	mov    %esi,%eax
 536:	e8 a5 fd ff ff       	call   2e0 <printint>
        ap++;
 53b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 53f:	e9 87 fe ff ff       	jmp    3cb <printf+0x4b>
        putc(fd, *ap);
 544:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 547:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 549:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 54b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 552:	00 
 553:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 556:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 559:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 55c:	89 44 24 04          	mov    %eax,0x4(%esp)
 560:	e8 ed fc ff ff       	call   252 <write>
        ap++;
 565:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 569:	e9 5d fe ff ff       	jmp    3cb <printf+0x4b>
 56e:	66 90                	xchg   %ax,%ax

00000570 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	a1 64 09 00 00       	mov    0x964,%eax
{
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 580:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 583:	39 d0                	cmp    %edx,%eax
 585:	72 11                	jb     598 <free+0x28>
 587:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 588:	39 c8                	cmp    %ecx,%eax
 58a:	72 04                	jb     590 <free+0x20>
 58c:	39 ca                	cmp    %ecx,%edx
 58e:	72 10                	jb     5a0 <free+0x30>
 590:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 592:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 594:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 596:	73 f0                	jae    588 <free+0x18>
 598:	39 ca                	cmp    %ecx,%edx
 59a:	72 04                	jb     5a0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59c:	39 c8                	cmp    %ecx,%eax
 59e:	72 f0                	jb     590 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5a0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5a3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5a6:	39 cf                	cmp    %ecx,%edi
 5a8:	74 1e                	je     5c8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5aa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5ad:	8b 48 04             	mov    0x4(%eax),%ecx
 5b0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5b3:	39 f2                	cmp    %esi,%edx
 5b5:	74 28                	je     5df <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5b7:	89 10                	mov    %edx,(%eax)
  freep = p;
 5b9:	a3 64 09 00 00       	mov    %eax,0x964
}
 5be:	5b                   	pop    %ebx
 5bf:	5e                   	pop    %esi
 5c0:	5f                   	pop    %edi
 5c1:	5d                   	pop    %ebp
 5c2:	c3                   	ret    
 5c3:	90                   	nop
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 5c8:	03 71 04             	add    0x4(%ecx),%esi
 5cb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5ce:	8b 08                	mov    (%eax),%ecx
 5d0:	8b 09                	mov    (%ecx),%ecx
 5d2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5d5:	8b 48 04             	mov    0x4(%eax),%ecx
 5d8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5db:	39 f2                	cmp    %esi,%edx
 5dd:	75 d8                	jne    5b7 <free+0x47>
    p->s.size += bp->s.size;
 5df:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 5e2:	a3 64 09 00 00       	mov    %eax,0x964
    p->s.size += bp->s.size;
 5e7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5ea:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5ed:	89 10                	mov    %edx,(%eax)
}
 5ef:	5b                   	pop    %ebx
 5f0:	5e                   	pop    %esi
 5f1:	5f                   	pop    %edi
 5f2:	5d                   	pop    %ebp
 5f3:	c3                   	ret    
 5f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 609:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 60c:	8b 1d 64 09 00 00    	mov    0x964,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 612:	8d 48 07             	lea    0x7(%eax),%ecx
 615:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 618:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 61a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 61d:	0f 84 9b 00 00 00    	je     6be <malloc+0xbe>
 623:	8b 13                	mov    (%ebx),%edx
 625:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 628:	39 fe                	cmp    %edi,%esi
 62a:	76 64                	jbe    690 <malloc+0x90>
 62c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 633:	bb 00 80 00 00       	mov    $0x8000,%ebx
 638:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 63b:	eb 0e                	jmp    64b <malloc+0x4b>
 63d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 640:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 642:	8b 78 04             	mov    0x4(%eax),%edi
 645:	39 fe                	cmp    %edi,%esi
 647:	76 4f                	jbe    698 <malloc+0x98>
 649:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 64b:	3b 15 64 09 00 00    	cmp    0x964,%edx
 651:	75 ed                	jne    640 <malloc+0x40>
  if(nu < 4096)
 653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 656:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 65c:	bf 00 10 00 00       	mov    $0x1000,%edi
 661:	0f 43 fe             	cmovae %esi,%edi
 664:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 667:	89 04 24             	mov    %eax,(%esp)
 66a:	e8 4b fc ff ff       	call   2ba <sbrk>
  if(p == (char*)-1)
 66f:	83 f8 ff             	cmp    $0xffffffff,%eax
 672:	74 18                	je     68c <malloc+0x8c>
  hp->s.size = nu;
 674:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 677:	83 c0 08             	add    $0x8,%eax
 67a:	89 04 24             	mov    %eax,(%esp)
 67d:	e8 ee fe ff ff       	call   570 <free>
  return freep;
 682:	8b 15 64 09 00 00    	mov    0x964,%edx
      if((p = morecore(nunits)) == 0)
 688:	85 d2                	test   %edx,%edx
 68a:	75 b4                	jne    640 <malloc+0x40>
        return 0;
 68c:	31 c0                	xor    %eax,%eax
 68e:	eb 20                	jmp    6b0 <malloc+0xb0>
    if(p->s.size >= nunits){
 690:	89 d0                	mov    %edx,%eax
 692:	89 da                	mov    %ebx,%edx
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 698:	39 fe                	cmp    %edi,%esi
 69a:	74 1c                	je     6b8 <malloc+0xb8>
        p->s.size -= nunits;
 69c:	29 f7                	sub    %esi,%edi
 69e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 6a1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 6a4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 6a7:	89 15 64 09 00 00    	mov    %edx,0x964
      return (void*)(p + 1);
 6ad:	83 c0 08             	add    $0x8,%eax
  }
}
 6b0:	83 c4 1c             	add    $0x1c,%esp
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6b8:	8b 08                	mov    (%eax),%ecx
 6ba:	89 0a                	mov    %ecx,(%edx)
 6bc:	eb e9                	jmp    6a7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 6be:	c7 05 64 09 00 00 68 	movl   $0x968,0x964
 6c5:	09 00 00 
    base.s.size = 0;
 6c8:	ba 68 09 00 00       	mov    $0x968,%edx
    base.s.ptr = freep = prevp = &base;
 6cd:	c7 05 68 09 00 00 68 	movl   $0x968,0x968
 6d4:	09 00 00 
    base.s.size = 0;
 6d7:	c7 05 6c 09 00 00 00 	movl   $0x0,0x96c
 6de:	00 00 00 
 6e1:	e9 46 ff ff ff       	jmp    62c <malloc+0x2c>
