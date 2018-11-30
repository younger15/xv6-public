
_fe:     file format elf32-i386


Disassembly of section .text:

00000000 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	8b 45 08             	mov    0x8(%ebp),%eax
   7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
   a:	89 c2                	mov    %eax,%edx
   c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  10:	83 c1 01             	add    $0x1,%ecx
  13:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  17:	83 c2 01             	add    $0x1,%edx
  1a:	84 db                	test   %bl,%bl
  1c:	88 5a ff             	mov    %bl,-0x1(%edx)
  1f:	75 ef                	jne    10 <strcpy+0x10>
    ;
  return os;
}
  21:	5b                   	pop    %ebx
  22:	5d                   	pop    %ebp
  23:	c3                   	ret    
  24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000030 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	56                   	push   %esi
  34:	53                   	push   %ebx
  35:	8b 55 08             	mov    0x8(%ebp),%edx
  38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  3b:	0f b6 02             	movzbl (%edx),%eax
  3e:	0f b6 19             	movzbl (%ecx),%ebx
  41:	84 c0                	test   %al,%al
  43:	75 1e                	jne    63 <strcmp+0x33>
  45:	eb 29                	jmp    70 <strcmp+0x40>
  47:	89 f6                	mov    %esi,%esi
  49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  50:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  53:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  56:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  59:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  5d:	84 c0                	test   %al,%al
  5f:	74 0f                	je     70 <strcmp+0x40>
  61:	89 f1                	mov    %esi,%ecx
  63:	38 d8                	cmp    %bl,%al
  65:	74 e9                	je     50 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  67:	29 d8                	sub    %ebx,%eax
}
  69:	5b                   	pop    %ebx
  6a:	5e                   	pop    %esi
  6b:	5d                   	pop    %ebp
  6c:	c3                   	ret    
  6d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  70:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  72:	29 d8                	sub    %ebx,%eax
}
  74:	5b                   	pop    %ebx
  75:	5e                   	pop    %esi
  76:	5d                   	pop    %ebp
  77:	c3                   	ret    
  78:	90                   	nop
  79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000080 <strlen>:

uint
strlen(const char *s)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  86:	80 39 00             	cmpb   $0x0,(%ecx)
  89:	74 12                	je     9d <strlen+0x1d>
  8b:	31 d2                	xor    %edx,%edx
  8d:	8d 76 00             	lea    0x0(%esi),%esi
  90:	83 c2 01             	add    $0x1,%edx
  93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  97:	89 d0                	mov    %edx,%eax
  99:	75 f5                	jne    90 <strlen+0x10>
    ;
  return n;
}
  9b:	5d                   	pop    %ebp
  9c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  9d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  9f:	5d                   	pop    %ebp
  a0:	c3                   	ret    
  a1:	eb 0d                	jmp    b0 <memset>
  a3:	90                   	nop
  a4:	90                   	nop
  a5:	90                   	nop
  a6:	90                   	nop
  a7:	90                   	nop
  a8:	90                   	nop
  a9:	90                   	nop
  aa:	90                   	nop
  ab:	90                   	nop
  ac:	90                   	nop
  ad:	90                   	nop
  ae:	90                   	nop
  af:	90                   	nop

000000b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	57                   	push   %edi
  b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  bd:	89 d7                	mov    %edx,%edi
  bf:	fc                   	cld    
  c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c2:	89 d0                	mov    %edx,%eax
  c4:	5f                   	pop    %edi
  c5:	5d                   	pop    %ebp
  c6:	c3                   	ret    
  c7:	89 f6                	mov    %esi,%esi
  c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000d0 <strchr>:

char*
strchr(const char *s, char c)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	53                   	push   %ebx
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  da:	0f b6 10             	movzbl (%eax),%edx
  dd:	84 d2                	test   %dl,%dl
  df:	74 1d                	je     fe <strchr+0x2e>
    if(*s == c)
  e1:	38 d3                	cmp    %dl,%bl
  e3:	89 d9                	mov    %ebx,%ecx
  e5:	75 0d                	jne    f4 <strchr+0x24>
  e7:	eb 17                	jmp    100 <strchr+0x30>
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  f0:	38 ca                	cmp    %cl,%dl
  f2:	74 0c                	je     100 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
  f4:	83 c0 01             	add    $0x1,%eax
  f7:	0f b6 10             	movzbl (%eax),%edx
  fa:	84 d2                	test   %dl,%dl
  fc:	75 f2                	jne    f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
  fe:	31 c0                	xor    %eax,%eax
}
 100:	5b                   	pop    %ebx
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <gets>:

char*
gets(char *buf, int max)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	56                   	push   %esi
 115:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 116:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 118:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 11b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11e:	eb 29                	jmp    149 <gets+0x39>
    cc = read(0, &c, 1);
 120:	83 ec 04             	sub    $0x4,%esp
 123:	6a 01                	push   $0x1
 125:	57                   	push   %edi
 126:	6a 00                	push   $0x0
 128:	e8 2d 01 00 00       	call   25a <read>
    if(cc < 1)
 12d:	83 c4 10             	add    $0x10,%esp
 130:	85 c0                	test   %eax,%eax
 132:	7e 1d                	jle    151 <gets+0x41>
      break;
    buf[i++] = c;
 134:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 138:	8b 55 08             	mov    0x8(%ebp),%edx
 13b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 13d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 13f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 143:	74 1b                	je     160 <gets+0x50>
 145:	3c 0d                	cmp    $0xd,%al
 147:	74 17                	je     160 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 149:	8d 5e 01             	lea    0x1(%esi),%ebx
 14c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 14f:	7c cf                	jl     120 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 151:	8b 45 08             	mov    0x8(%ebp),%eax
 154:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 158:	8d 65 f4             	lea    -0xc(%ebp),%esp
 15b:	5b                   	pop    %ebx
 15c:	5e                   	pop    %esi
 15d:	5f                   	pop    %edi
 15e:	5d                   	pop    %ebp
 15f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 160:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 163:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 165:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 169:	8d 65 f4             	lea    -0xc(%ebp),%esp
 16c:	5b                   	pop    %ebx
 16d:	5e                   	pop    %esi
 16e:	5f                   	pop    %edi
 16f:	5d                   	pop    %ebp
 170:	c3                   	ret    
 171:	eb 0d                	jmp    180 <stat>
 173:	90                   	nop
 174:	90                   	nop
 175:	90                   	nop
 176:	90                   	nop
 177:	90                   	nop
 178:	90                   	nop
 179:	90                   	nop
 17a:	90                   	nop
 17b:	90                   	nop
 17c:	90                   	nop
 17d:	90                   	nop
 17e:	90                   	nop
 17f:	90                   	nop

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 185:	83 ec 08             	sub    $0x8,%esp
 188:	6a 00                	push   $0x0
 18a:	ff 75 08             	pushl  0x8(%ebp)
 18d:	e8 f0 00 00 00       	call   282 <open>
  if(fd < 0)
 192:	83 c4 10             	add    $0x10,%esp
 195:	85 c0                	test   %eax,%eax
 197:	78 27                	js     1c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 199:	83 ec 08             	sub    $0x8,%esp
 19c:	ff 75 0c             	pushl  0xc(%ebp)
 19f:	89 c3                	mov    %eax,%ebx
 1a1:	50                   	push   %eax
 1a2:	e8 f3 00 00 00       	call   29a <fstat>
 1a7:	89 c6                	mov    %eax,%esi
  close(fd);
 1a9:	89 1c 24             	mov    %ebx,(%esp)
 1ac:	e8 b9 00 00 00       	call   26a <close>
  return r;
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	89 f0                	mov    %esi,%eax
}
 1b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1b9:	5b                   	pop    %ebx
 1ba:	5e                   	pop    %esi
 1bb:	5d                   	pop    %ebp
 1bc:	c3                   	ret    
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c5:	eb ef                	jmp    1b6 <stat+0x36>
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 11             	movsbl (%ecx),%edx
 1da:	8d 42 d0             	lea    -0x30(%edx),%eax
 1dd:	3c 09                	cmp    $0x9,%al
 1df:	b8 00 00 00 00       	mov    $0x0,%eax
 1e4:	77 1f                	ja     205 <atoi+0x35>
 1e6:	8d 76 00             	lea    0x0(%esi),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 1f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1f3:	83 c1 01             	add    $0x1,%ecx
 1f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fa:	0f be 11             	movsbl (%ecx),%edx
 1fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 200:	80 fb 09             	cmp    $0x9,%bl
 203:	76 eb                	jbe    1f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 205:	5b                   	pop    %ebx
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	8b 5d 10             	mov    0x10(%ebp),%ebx
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21e:	85 db                	test   %ebx,%ebx
 220:	7e 14                	jle    236 <memmove+0x26>
 222:	31 d2                	xor    %edx,%edx
 224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 228:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 22c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 22f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 232:	39 da                	cmp    %ebx,%edx
 234:	75 f2                	jne    228 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 236:	5b                   	pop    %ebx
 237:	5e                   	pop    %esi
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    

0000023a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 23a:	b8 01 00 00 00       	mov    $0x1,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <exit>:
SYSCALL(exit)
 242:	b8 02 00 00 00       	mov    $0x2,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <wait>:
SYSCALL(wait)
 24a:	b8 03 00 00 00       	mov    $0x3,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <pipe>:
SYSCALL(pipe)
 252:	b8 04 00 00 00       	mov    $0x4,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <read>:
SYSCALL(read)
 25a:	b8 05 00 00 00       	mov    $0x5,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <write>:
SYSCALL(write)
 262:	b8 10 00 00 00       	mov    $0x10,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <close>:
SYSCALL(close)
 26a:	b8 15 00 00 00       	mov    $0x15,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <kill>:
SYSCALL(kill)
 272:	b8 06 00 00 00       	mov    $0x6,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <exec>:
SYSCALL(exec)
 27a:	b8 07 00 00 00       	mov    $0x7,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <open>:
SYSCALL(open)
 282:	b8 0f 00 00 00       	mov    $0xf,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <mknod>:
SYSCALL(mknod)
 28a:	b8 11 00 00 00       	mov    $0x11,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <unlink>:
SYSCALL(unlink)
 292:	b8 12 00 00 00       	mov    $0x12,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <fstat>:
SYSCALL(fstat)
 29a:	b8 08 00 00 00       	mov    $0x8,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <link>:
SYSCALL(link)
 2a2:	b8 13 00 00 00       	mov    $0x13,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <mkdir>:
SYSCALL(mkdir)
 2aa:	b8 14 00 00 00       	mov    $0x14,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <chdir>:
SYSCALL(chdir)
 2b2:	b8 09 00 00 00       	mov    $0x9,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <dup>:
SYSCALL(dup)
 2ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <getpid>:
SYSCALL(getpid)
 2c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <sbrk>:
SYSCALL(sbrk)
 2ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <sleep>:
SYSCALL(sleep)
 2d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <uptime>:
SYSCALL(uptime)
 2da:	b8 0e 00 00 00       	mov    $0xe,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <cps>:
SYSCALL(cps)
 2e2:	b8 16 00 00 00       	mov    $0x16,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <userTag>:
SYSCALL(userTag)
 2ea:	b8 17 00 00 00       	mov    $0x17,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <changeUser>:
SYSCALL(changeUser)
 2f2:	b8 18 00 00 00       	mov    $0x18,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <getUser>:
SYSCALL(getUser)
 2fa:	b8 19 00 00 00       	mov    $0x19,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <changeOwner>:
SYSCALL(changeOwner)
 302:	b8 1a 00 00 00       	mov    $0x1a,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    
 30a:	66 90                	xchg   %ax,%ax
 30c:	66 90                	xchg   %ax,%ax
 30e:	66 90                	xchg   %ax,%ax

00000310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	89 c6                	mov    %eax,%esi
 318:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 31b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 31e:	85 db                	test   %ebx,%ebx
 320:	74 7e                	je     3a0 <printint+0x90>
 322:	89 d0                	mov    %edx,%eax
 324:	c1 e8 1f             	shr    $0x1f,%eax
 327:	84 c0                	test   %al,%al
 329:	74 75                	je     3a0 <printint+0x90>
    neg = 1;
    x = -xx;
 32b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 32d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 334:	f7 d8                	neg    %eax
 336:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 339:	31 ff                	xor    %edi,%edi
 33b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 33e:	89 ce                	mov    %ecx,%esi
 340:	eb 08                	jmp    34a <printint+0x3a>
 342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 348:	89 cf                	mov    %ecx,%edi
 34a:	31 d2                	xor    %edx,%edx
 34c:	8d 4f 01             	lea    0x1(%edi),%ecx
 34f:	f7 f6                	div    %esi
 351:	0f b6 92 d8 06 00 00 	movzbl 0x6d8(%edx),%edx
  }while((x /= base) != 0);
 358:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 35a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 35d:	75 e9                	jne    348 <printint+0x38>
  if(neg)
 35f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 362:	8b 75 c0             	mov    -0x40(%ebp),%esi
 365:	85 c0                	test   %eax,%eax
 367:	74 08                	je     371 <printint+0x61>
    buf[i++] = '-';
 369:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 36e:	8d 4f 02             	lea    0x2(%edi),%ecx
 371:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 375:	8d 76 00             	lea    0x0(%esi),%esi
 378:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 37b:	83 ec 04             	sub    $0x4,%esp
 37e:	83 ef 01             	sub    $0x1,%edi
 381:	6a 01                	push   $0x1
 383:	53                   	push   %ebx
 384:	56                   	push   %esi
 385:	88 45 d7             	mov    %al,-0x29(%ebp)
 388:	e8 d5 fe ff ff       	call   262 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 38d:	83 c4 10             	add    $0x10,%esp
 390:	39 df                	cmp    %ebx,%edi
 392:	75 e4                	jne    378 <printint+0x68>
    putc(fd, buf[i]);
}
 394:	8d 65 f4             	lea    -0xc(%ebp),%esp
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5f                   	pop    %edi
 39a:	5d                   	pop    %ebp
 39b:	c3                   	ret    
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3a0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3a2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3a9:	eb 8b                	jmp    336 <printint+0x26>
 3ab:	90                   	nop
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3b9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3bc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 3bf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 3c5:	0f b6 1e             	movzbl (%esi),%ebx
 3c8:	83 c6 01             	add    $0x1,%esi
 3cb:	84 db                	test   %bl,%bl
 3cd:	0f 84 b0 00 00 00    	je     483 <printf+0xd3>
 3d3:	31 d2                	xor    %edx,%edx
 3d5:	eb 39                	jmp    410 <printf+0x60>
 3d7:	89 f6                	mov    %esi,%esi
 3d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3e0:	83 f8 25             	cmp    $0x25,%eax
 3e3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 3e6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3eb:	74 18                	je     405 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3ed:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3f0:	83 ec 04             	sub    $0x4,%esp
 3f3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 3f6:	6a 01                	push   $0x1
 3f8:	50                   	push   %eax
 3f9:	57                   	push   %edi
 3fa:	e8 63 fe ff ff       	call   262 <write>
 3ff:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 402:	83 c4 10             	add    $0x10,%esp
 405:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 408:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 40c:	84 db                	test   %bl,%bl
 40e:	74 73                	je     483 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 410:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 412:	0f be cb             	movsbl %bl,%ecx
 415:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 418:	74 c6                	je     3e0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 41a:	83 fa 25             	cmp    $0x25,%edx
 41d:	75 e6                	jne    405 <printf+0x55>
      if(c == 'd'){
 41f:	83 f8 64             	cmp    $0x64,%eax
 422:	0f 84 f8 00 00 00    	je     520 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 428:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 42e:	83 f9 70             	cmp    $0x70,%ecx
 431:	74 5d                	je     490 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 433:	83 f8 73             	cmp    $0x73,%eax
 436:	0f 84 84 00 00 00    	je     4c0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 43c:	83 f8 63             	cmp    $0x63,%eax
 43f:	0f 84 ea 00 00 00    	je     52f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 445:	83 f8 25             	cmp    $0x25,%eax
 448:	0f 84 c2 00 00 00    	je     510 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 44e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 451:	83 ec 04             	sub    $0x4,%esp
 454:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 458:	6a 01                	push   $0x1
 45a:	50                   	push   %eax
 45b:	57                   	push   %edi
 45c:	e8 01 fe ff ff       	call   262 <write>
 461:	83 c4 0c             	add    $0xc,%esp
 464:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 467:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 46a:	6a 01                	push   $0x1
 46c:	50                   	push   %eax
 46d:	57                   	push   %edi
 46e:	83 c6 01             	add    $0x1,%esi
 471:	e8 ec fd ff ff       	call   262 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 476:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 47a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 47d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47f:	84 db                	test   %bl,%bl
 481:	75 8d                	jne    410 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 483:	8d 65 f4             	lea    -0xc(%ebp),%esp
 486:	5b                   	pop    %ebx
 487:	5e                   	pop    %esi
 488:	5f                   	pop    %edi
 489:	5d                   	pop    %ebp
 48a:	c3                   	ret    
 48b:	90                   	nop
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 490:	83 ec 0c             	sub    $0xc,%esp
 493:	b9 10 00 00 00       	mov    $0x10,%ecx
 498:	6a 00                	push   $0x0
 49a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 49d:	89 f8                	mov    %edi,%eax
 49f:	8b 13                	mov    (%ebx),%edx
 4a1:	e8 6a fe ff ff       	call   310 <printint>
        ap++;
 4a6:	89 d8                	mov    %ebx,%eax
 4a8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ab:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 4ad:	83 c0 04             	add    $0x4,%eax
 4b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b3:	e9 4d ff ff ff       	jmp    405 <printf+0x55>
 4b8:	90                   	nop
 4b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 4c5:	83 c0 04             	add    $0x4,%eax
 4c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 4cb:	b8 d0 06 00 00       	mov    $0x6d0,%eax
 4d0:	85 db                	test   %ebx,%ebx
 4d2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 4d5:	0f b6 03             	movzbl (%ebx),%eax
 4d8:	84 c0                	test   %al,%al
 4da:	74 23                	je     4ff <printf+0x14f>
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 4e6:	83 ec 04             	sub    $0x4,%esp
 4e9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4eb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ee:	50                   	push   %eax
 4ef:	57                   	push   %edi
 4f0:	e8 6d fd ff ff       	call   262 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f5:	0f b6 03             	movzbl (%ebx),%eax
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	84 c0                	test   %al,%al
 4fd:	75 e1                	jne    4e0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ff:	31 d2                	xor    %edx,%edx
 501:	e9 ff fe ff ff       	jmp    405 <printf+0x55>
 506:	8d 76 00             	lea    0x0(%esi),%esi
 509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 510:	83 ec 04             	sub    $0x4,%esp
 513:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 516:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 519:	6a 01                	push   $0x1
 51b:	e9 4c ff ff ff       	jmp    46c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	b9 0a 00 00 00       	mov    $0xa,%ecx
 528:	6a 01                	push   $0x1
 52a:	e9 6b ff ff ff       	jmp    49a <printf+0xea>
 52f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 532:	83 ec 04             	sub    $0x4,%esp
 535:	8b 03                	mov    (%ebx),%eax
 537:	6a 01                	push   $0x1
 539:	88 45 e4             	mov    %al,-0x1c(%ebp)
 53c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 53f:	50                   	push   %eax
 540:	57                   	push   %edi
 541:	e8 1c fd ff ff       	call   262 <write>
 546:	e9 5b ff ff ff       	jmp    4a6 <printf+0xf6>
 54b:	66 90                	xchg   %ax,%ax
 54d:	66 90                	xchg   %ax,%ax
 54f:	90                   	nop

00000550 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 550:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 551:	a1 4c 09 00 00       	mov    0x94c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 556:	89 e5                	mov    %esp,%ebp
 558:	57                   	push   %edi
 559:	56                   	push   %esi
 55a:	53                   	push   %ebx
 55b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 560:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 563:	39 c8                	cmp    %ecx,%eax
 565:	73 19                	jae    580 <free+0x30>
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 570:	39 d1                	cmp    %edx,%ecx
 572:	72 1c                	jb     590 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 574:	39 d0                	cmp    %edx,%eax
 576:	73 18                	jae    590 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 578:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 57a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 57e:	72 f0                	jb     570 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 580:	39 d0                	cmp    %edx,%eax
 582:	72 f4                	jb     578 <free+0x28>
 584:	39 d1                	cmp    %edx,%ecx
 586:	73 f0                	jae    578 <free+0x28>
 588:	90                   	nop
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 590:	8b 73 fc             	mov    -0x4(%ebx),%esi
 593:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 596:	39 d7                	cmp    %edx,%edi
 598:	74 19                	je     5b3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 59a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 59d:	8b 50 04             	mov    0x4(%eax),%edx
 5a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5a3:	39 f1                	cmp    %esi,%ecx
 5a5:	74 23                	je     5ca <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5a7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5a9:	a3 4c 09 00 00       	mov    %eax,0x94c
}
 5ae:	5b                   	pop    %ebx
 5af:	5e                   	pop    %esi
 5b0:	5f                   	pop    %edi
 5b1:	5d                   	pop    %ebp
 5b2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5b3:	03 72 04             	add    0x4(%edx),%esi
 5b6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5b9:	8b 10                	mov    (%eax),%edx
 5bb:	8b 12                	mov    (%edx),%edx
 5bd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5c0:	8b 50 04             	mov    0x4(%eax),%edx
 5c3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5c6:	39 f1                	cmp    %esi,%ecx
 5c8:	75 dd                	jne    5a7 <free+0x57>
    p->s.size += bp->s.size;
 5ca:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 5cd:	a3 4c 09 00 00       	mov    %eax,0x94c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 5d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5d8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5da:	5b                   	pop    %ebx
 5db:	5e                   	pop    %esi
 5dc:	5f                   	pop    %edi
 5dd:	5d                   	pop    %ebp
 5de:	c3                   	ret    
 5df:	90                   	nop

000005e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
 5e5:	53                   	push   %ebx
 5e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5ec:	8b 15 4c 09 00 00    	mov    0x94c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f2:	8d 78 07             	lea    0x7(%eax),%edi
 5f5:	c1 ef 03             	shr    $0x3,%edi
 5f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 5fb:	85 d2                	test   %edx,%edx
 5fd:	0f 84 a3 00 00 00    	je     6a6 <malloc+0xc6>
 603:	8b 02                	mov    (%edx),%eax
 605:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 608:	39 cf                	cmp    %ecx,%edi
 60a:	76 74                	jbe    680 <malloc+0xa0>
 60c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 612:	be 00 10 00 00       	mov    $0x1000,%esi
 617:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 61e:	0f 43 f7             	cmovae %edi,%esi
 621:	ba 00 80 00 00       	mov    $0x8000,%edx
 626:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 62c:	0f 46 da             	cmovbe %edx,%ebx
 62f:	eb 10                	jmp    641 <malloc+0x61>
 631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 638:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 63a:	8b 48 04             	mov    0x4(%eax),%ecx
 63d:	39 cf                	cmp    %ecx,%edi
 63f:	76 3f                	jbe    680 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 641:	39 05 4c 09 00 00    	cmp    %eax,0x94c
 647:	89 c2                	mov    %eax,%edx
 649:	75 ed                	jne    638 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 64b:	83 ec 0c             	sub    $0xc,%esp
 64e:	53                   	push   %ebx
 64f:	e8 76 fc ff ff       	call   2ca <sbrk>
  if(p == (char*)-1)
 654:	83 c4 10             	add    $0x10,%esp
 657:	83 f8 ff             	cmp    $0xffffffff,%eax
 65a:	74 1c                	je     678 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 65c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 65f:	83 ec 0c             	sub    $0xc,%esp
 662:	83 c0 08             	add    $0x8,%eax
 665:	50                   	push   %eax
 666:	e8 e5 fe ff ff       	call   550 <free>
  return freep;
 66b:	8b 15 4c 09 00 00    	mov    0x94c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 671:	83 c4 10             	add    $0x10,%esp
 674:	85 d2                	test   %edx,%edx
 676:	75 c0                	jne    638 <malloc+0x58>
        return 0;
 678:	31 c0                	xor    %eax,%eax
 67a:	eb 1c                	jmp    698 <malloc+0xb8>
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 680:	39 cf                	cmp    %ecx,%edi
 682:	74 1c                	je     6a0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 684:	29 f9                	sub    %edi,%ecx
 686:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 689:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 68c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 68f:	89 15 4c 09 00 00    	mov    %edx,0x94c
      return (void*)(p + 1);
 695:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 698:	8d 65 f4             	lea    -0xc(%ebp),%esp
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6a0:	8b 08                	mov    (%eax),%ecx
 6a2:	89 0a                	mov    %ecx,(%edx)
 6a4:	eb e9                	jmp    68f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6a6:	c7 05 4c 09 00 00 50 	movl   $0x950,0x94c
 6ad:	09 00 00 
 6b0:	c7 05 50 09 00 00 50 	movl   $0x950,0x950
 6b7:	09 00 00 
    base.s.size = 0;
 6ba:	b8 50 09 00 00       	mov    $0x950,%eax
 6bf:	c7 05 54 09 00 00 00 	movl   $0x0,0x954
 6c6:	00 00 00 
 6c9:	e9 3e ff ff ff       	jmp    60c <malloc+0x2c>
