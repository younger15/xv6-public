
_du:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	81 ec 40 04 00 00    	sub    $0x440,%esp
  17:	8b 41 04             	mov    0x4(%ecx),%eax


	int fd = open("UserList", O_RDONLY);
  1a:	6a 00                	push   $0x0
  1c:	68 30 09 00 00       	push   $0x930
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
  21:	89 85 c4 fb ff ff    	mov    %eax,-0x43c(%ebp)


	int fd = open("UserList", O_RDONLY);
  27:	e8 b6 04 00 00       	call   4e2 <open>
  2c:	89 c3                	mov    %eax,%ebx
	char c;
	char name[32];
	int nameFound = 0;
	//char *names = nameList;
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
  2e:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
  34:	83 c4 0c             	add    $0xc,%esp
  37:	68 00 04 00 00       	push   $0x400
  3c:	50                   	push   %eax
  3d:	53                   	push   %ebx
  3e:	e8 77 04 00 00       	call   4ba <read>
  43:	89 c6                	mov    %eax,%esi
	close(fd);
  45:	89 1c 24             	mov    %ebx,(%esp)
  48:	e8 7d 04 00 00       	call   4ca <close>
	if(checkReadFile < 0)
  4d:	83 c4 10             	add    $0x10,%esp
  50:	85 f6                	test   %esi,%esi
  52:	0f 88 d5 01 00 00    	js     22d <main+0x22d>
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		if (strcmp(argv[1],"Admin")==0)
  58:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  5e:	83 ec 08             	sub    $0x8,%esp
  61:	68 4f 09 00 00       	push   $0x94f
  66:	ff 70 04             	pushl  0x4(%eax)
  69:	e8 22 02 00 00       	call   290 <strcmp>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	85 c0                	test   %eax,%eax
  73:	0f 84 c7 01 00 00    	je     240 <main+0x240>
  79:	31 f6                	xor    %esi,%esi
  7b:	31 d2                	xor    %edx,%edx
		}
		else
		{
			do
			{
				c = buf[i];
  7d:	0f b6 84 35 e8 fb ff 	movzbl -0x418(%ebp,%esi,1),%eax
  84:	ff 
				i++;
  85:	8d 7e 01             	lea    0x1(%esi),%edi
				if (c == ':')
  88:	3c 3a                	cmp    $0x3a,%al
  8a:	74 27                	je     b3 <main+0xb3>
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				
					j = 0;
				}
			else
			{
				name[j] = c;
  90:	88 84 15 c8 fb ff ff 	mov    %al,-0x438(%ebp,%edx,1)
				j++;
  97:	83 c2 01             	add    $0x1,%edx
			}

		}while (c != '\0');
  9a:	84 c0                	test   %al,%al
  9c:	0f 84 2f 01 00 00    	je     1d1 <main+0x1d1>
  a2:	89 fe                	mov    %edi,%esi
		}
		else
		{
			do
			{
				c = buf[i];
  a4:	0f b6 84 35 e8 fb ff 	movzbl -0x418(%ebp,%esi,1),%eax
  ab:	ff 
				i++;
  ac:	8d 7e 01             	lea    0x1(%esi),%edi
				if (c == ':')
  af:	3c 3a                	cmp    $0x3a,%al
  b1:	75 dd                	jne    90 <main+0x90>
				{
					char* p = argv[1];
  b3:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
					char* q	= name;
					while (j > 0 && *p && *p == *q)
  b9:	85 d2                	test   %edx,%edx
			{
				c = buf[i];
				i++;
				if (c == ':')
				{
					char* p = argv[1];
  bb:	8b 58 04             	mov    0x4(%eax),%ebx
					char* q	= name;
					while (j > 0 && *p && *p == *q)
  be:	74 54                	je     114 <main+0x114>
  c0:	0f b6 03             	movzbl (%ebx),%eax
  c3:	84 c0                	test   %al,%al
  c5:	0f 84 fd 00 00 00    	je     1c8 <main+0x1c8>
  cb:	3a 85 c8 fb ff ff    	cmp    -0x438(%ebp),%al
  d1:	0f 85 f1 00 00 00    	jne    1c8 <main+0x1c8>
  d7:	8d 43 01             	lea    0x1(%ebx),%eax
  da:	01 d3                	add    %edx,%ebx
  dc:	8d 95 c8 fb ff ff    	lea    -0x438(%ebp),%edx
  e2:	eb 1a                	jmp    fe <main+0xfe>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e8:	0f b6 08             	movzbl (%eax),%ecx
  eb:	84 c9                	test   %cl,%cl
  ed:	0f 84 d5 00 00 00    	je     1c8 <main+0x1c8>
  f3:	83 c0 01             	add    $0x1,%eax
  f6:	3a 0a                	cmp    (%edx),%cl
  f8:	0f 85 ca 00 00 00    	jne    1c8 <main+0x1c8>
					{
						p++;
						q++;
  fe:	83 c2 01             	add    $0x1,%edx
				i++;
				if (c == ':')
				{
					char* p = argv[1];
					char* q	= name;
					while (j > 0 && *p && *p == *q)
 101:	39 d8                	cmp    %ebx,%eax
 103:	75 e3                	jne    e8 <main+0xe8>
 105:	eb 0d                	jmp    114 <main+0x114>
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
					if (j == 0)
					{
						// name found
						nameFound = 1;	
						i-=2;
						while (buf[i] != ':' && i > 0)  // return to the last ':'
 110:	85 f6                	test   %esi,%esi
 112:	7e 0d                	jle    121 <main+0x121>
					}
					if (j == 0)
					{
						// name found
						nameFound = 1;	
						i-=2;
 114:	83 ee 01             	sub    $0x1,%esi
						while (buf[i] != ':' && i > 0)  // return to the last ':'
 117:	80 bc 35 e8 fb ff ff 	cmpb   $0x3a,-0x418(%ebp,%esi,1)
 11e:	3a 
 11f:	75 ef                	jne    110 <main+0x110>
							i--;
						i++;
 121:	8d 4e 01             	lea    0x1(%esi),%ecx
 124:	8d 5e 02             	lea    0x2(%esi),%ebx
 127:	0f b6 84 0d e8 fb ff 	movzbl -0x418(%ebp,%ecx,1),%eax
 12e:	ff 
						while (buf[i] != ':')	
 12f:	3c 3a                	cmp    $0x3a,%al
 131:	74 30                	je     163 <main+0x163>
						{
							int k = i;
							while (buf[k] != '\0')
 133:	84 c0                	test   %al,%al
 135:	0f 84 18 01 00 00    	je     253 <main+0x253>
 13b:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 141:	01 d8                	add    %ebx,%eax
 143:	90                   	nop
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
							{
								buf[k] = buf[k+1];
 148:	0f b6 10             	movzbl (%eax),%edx
 14b:	83 c0 01             	add    $0x1,%eax
 14e:	88 50 fe             	mov    %dl,-0x2(%eax)
							i--;
						i++;
						while (buf[i] != ':')	
						{
							int k = i;
							while (buf[k] != '\0')
 151:	80 78 ff 00          	cmpb   $0x0,-0x1(%eax)
 155:	75 f1                	jne    148 <main+0x148>
 157:	0f b6 84 0d e8 fb ff 	movzbl -0x418(%ebp,%ecx,1),%eax
 15e:	ff 
						nameFound = 1;	
						i-=2;
						while (buf[i] != ':' && i > 0)  // return to the last ':'
							i--;
						i++;
						while (buf[i] != ':')	
 15f:	3c 3a                	cmp    $0x3a,%al
 161:	75 d0                	jne    133 <main+0x133>
							}	
		
						}
						i--;
						int k = i;
						while (buf[k] != '\0')
 163:	80 bc 35 e8 fb ff ff 	cmpb   $0x0,-0x418(%ebp,%esi,1)
 16a:	00 
 16b:	74 42                	je     1af <main+0x1af>
 16d:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 173:	01 c8                	add    %ecx,%eax
 175:	89 c1                	mov    %eax,%ecx
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
						{
							buf[k] = buf[k+1];
 180:	0f b6 11             	movzbl (%ecx),%edx
 183:	83 c1 01             	add    $0x1,%ecx
 186:	88 51 fe             	mov    %dl,-0x2(%ecx)
							}	
		
						}
						i--;
						int k = i;
						while (buf[k] != '\0')
 189:	80 79 ff 00          	cmpb   $0x0,-0x1(%ecx)
 18d:	75 f1                	jne    180 <main+0x180>
						{
							buf[k] = buf[k+1];
							k++;
						}
						k = i;
						while (buf[k] != '\0')
 18f:	80 bc 35 e8 fb ff ff 	cmpb   $0x0,-0x418(%ebp,%esi,1)
 196:	00 
 197:	74 16                	je     1af <main+0x1af>
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
						{
							buf[k] = buf[k+1];
 1a0:	0f b6 10             	movzbl (%eax),%edx
 1a3:	83 c0 01             	add    $0x1,%eax
 1a6:	88 50 fe             	mov    %dl,-0x2(%eax)
						{
							buf[k] = buf[k+1];
							k++;
						}
						k = i;
						while (buf[k] != '\0')
 1a9:	80 78 ff 00          	cmpb   $0x0,-0x1(%eax)
 1ad:	75 f1                	jne    1a0 <main+0x1a0>
				j++;
			}

		}while (c != '\0');
		if (nameFound == 1)
			printf(1,"User deleted\n");
 1af:	52                   	push   %edx
 1b0:	52                   	push   %edx
 1b1:	68 6a 09 00 00       	push   $0x96a
 1b6:	6a 01                	push   $0x1
 1b8:	e8 53 04 00 00       	call   610 <printf>
 1bd:	83 c4 10             	add    $0x10,%esp
 1c0:	eb 20                	jmp    1e2 <main+0x1e2>
 1c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c8:	31 d2                	xor    %edx,%edx
 1ca:	89 fe                	mov    %edi,%esi
 1cc:	e9 d3 fe ff ff       	jmp    a4 <main+0xa4>
		else
			printf(1,"User name not found\n");
 1d1:	50                   	push   %eax
 1d2:	50                   	push   %eax
 1d3:	68 78 09 00 00       	push   $0x978
 1d8:	6a 01                	push   $0x1
 1da:	e8 31 04 00 00       	call   610 <printf>
 1df:	83 c4 10             	add    $0x10,%esp
		}
		
	}
	fd = open("UserList", O_RDWR);
 1e2:	83 ec 08             	sub    $0x8,%esp
 1e5:	6a 02                	push   $0x2
 1e7:	68 30 09 00 00       	push   $0x930
 1ec:	e8 f1 02 00 00       	call   4e2 <open>
	if(fd >= 0)
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	85 c0                	test   %eax,%eax
		else
			printf(1,"User name not found\n");
		}
		
	}
	fd = open("UserList", O_RDWR);
 1f6:	89 c3                	mov    %eax,%ebx
	if(fd >= 0)
 1f8:	78 2e                	js     228 <main+0x228>
	{
		write(fd,buf,strlen(buf)+1);
 1fa:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 200:	83 ec 0c             	sub    $0xc,%esp
 203:	50                   	push   %eax
 204:	e8 d7 00 00 00       	call   2e0 <strlen>
 209:	83 c4 0c             	add    $0xc,%esp
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	50                   	push   %eax
 210:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 216:	50                   	push   %eax
 217:	53                   	push   %ebx
 218:	e8 a5 02 00 00       	call   4c2 <write>
		close(fd);		
 21d:	89 1c 24             	mov    %ebx,(%esp)
 220:	e8 a5 02 00 00       	call   4ca <close>
 225:	83 c4 10             	add    $0x10,%esp
	}
		
	
	exit();
 228:	e8 75 02 00 00       	call   4a2 <exit>
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	close(fd);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
 22d:	53                   	push   %ebx
 22e:	53                   	push   %ebx
 22f:	68 39 09 00 00       	push   $0x939
 234:	6a 01                	push   $0x1
 236:	e8 d5 03 00 00       	call   610 <printf>
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	eb a2                	jmp    1e2 <main+0x1e2>
	}
	else
	{
		if (strcmp(argv[1],"Admin")==0)
		{
			printf(1,"Cannot delete Admin\n");
 240:	51                   	push   %ecx
 241:	51                   	push   %ecx
 242:	68 55 09 00 00       	push   $0x955
 247:	6a 01                	push   $0x1
 249:	e8 c2 03 00 00       	call   610 <printf>
 24e:	83 c4 10             	add    $0x10,%esp
 251:	eb 8f                	jmp    1e2 <main+0x1e2>
 253:	eb fe                	jmp    253 <main+0x253>
 255:	66 90                	xchg   %ax,%ax
 257:	66 90                	xchg   %ax,%ax
 259:	66 90                	xchg   %ax,%ax
 25b:	66 90                	xchg   %ax,%ax
 25d:	66 90                	xchg   %ax,%ax
 25f:	90                   	nop

00000260 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 26a:	89 c2                	mov    %eax,%edx
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 270:	83 c1 01             	add    $0x1,%ecx
 273:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 277:	83 c2 01             	add    $0x1,%edx
 27a:	84 db                	test   %bl,%bl
 27c:	88 5a ff             	mov    %bl,-0x1(%edx)
 27f:	75 ef                	jne    270 <strcpy+0x10>
    ;
  return os;
}
 281:	5b                   	pop    %ebx
 282:	5d                   	pop    %ebp
 283:	c3                   	ret    
 284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 28a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000290 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 55 08             	mov    0x8(%ebp),%edx
 298:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 29b:	0f b6 02             	movzbl (%edx),%eax
 29e:	0f b6 19             	movzbl (%ecx),%ebx
 2a1:	84 c0                	test   %al,%al
 2a3:	75 1e                	jne    2c3 <strcmp+0x33>
 2a5:	eb 29                	jmp    2d0 <strcmp+0x40>
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2b0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2b6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2bd:	84 c0                	test   %al,%al
 2bf:	74 0f                	je     2d0 <strcmp+0x40>
 2c1:	89 f1                	mov    %esi,%ecx
 2c3:	38 d8                	cmp    %bl,%al
 2c5:	74 e9                	je     2b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2c7:	29 d8                	sub    %ebx,%eax
}
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2d2:	29 d8                	sub    %ebx,%eax
}
 2d4:	5b                   	pop    %ebx
 2d5:	5e                   	pop    %esi
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <strlen>:

uint
strlen(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2e6:	80 39 00             	cmpb   $0x0,(%ecx)
 2e9:	74 12                	je     2fd <strlen+0x1d>
 2eb:	31 d2                	xor    %edx,%edx
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2f7:	89 d0                	mov    %edx,%eax
 2f9:	75 f5                	jne    2f0 <strlen+0x10>
    ;
  return n;
}
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 2fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 2ff:	5d                   	pop    %ebp
 300:	c3                   	ret    
 301:	eb 0d                	jmp    310 <memset>
 303:	90                   	nop
 304:	90                   	nop
 305:	90                   	nop
 306:	90                   	nop
 307:	90                   	nop
 308:	90                   	nop
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 317:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31a:	8b 45 0c             	mov    0xc(%ebp),%eax
 31d:	89 d7                	mov    %edx,%edi
 31f:	fc                   	cld    
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	89 d0                	mov    %edx,%eax
 324:	5f                   	pop    %edi
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 33a:	0f b6 10             	movzbl (%eax),%edx
 33d:	84 d2                	test   %dl,%dl
 33f:	74 1d                	je     35e <strchr+0x2e>
    if(*s == c)
 341:	38 d3                	cmp    %dl,%bl
 343:	89 d9                	mov    %ebx,%ecx
 345:	75 0d                	jne    354 <strchr+0x24>
 347:	eb 17                	jmp    360 <strchr+0x30>
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 350:	38 ca                	cmp    %cl,%dl
 352:	74 0c                	je     360 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 354:	83 c0 01             	add    $0x1,%eax
 357:	0f b6 10             	movzbl (%eax),%edx
 35a:	84 d2                	test   %dl,%dl
 35c:	75 f2                	jne    350 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 35e:	31 c0                	xor    %eax,%eax
}
 360:	5b                   	pop    %ebx
 361:	5d                   	pop    %ebp
 362:	c3                   	ret    
 363:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <gets>:

char*
gets(char *buf, int max)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 376:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 378:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 37b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 37e:	eb 29                	jmp    3a9 <gets+0x39>
    cc = read(0, &c, 1);
 380:	83 ec 04             	sub    $0x4,%esp
 383:	6a 01                	push   $0x1
 385:	57                   	push   %edi
 386:	6a 00                	push   $0x0
 388:	e8 2d 01 00 00       	call   4ba <read>
    if(cc < 1)
 38d:	83 c4 10             	add    $0x10,%esp
 390:	85 c0                	test   %eax,%eax
 392:	7e 1d                	jle    3b1 <gets+0x41>
      break;
    buf[i++] = c;
 394:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 398:	8b 55 08             	mov    0x8(%ebp),%edx
 39b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 39d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 39f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3a3:	74 1b                	je     3c0 <gets+0x50>
 3a5:	3c 0d                	cmp    $0xd,%al
 3a7:	74 17                	je     3c0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3af:	7c cf                	jl     380 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3b1:	8b 45 08             	mov    0x8(%ebp),%eax
 3b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bb:	5b                   	pop    %ebx
 3bc:	5e                   	pop    %esi
 3bd:	5f                   	pop    %edi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cc:	5b                   	pop    %ebx
 3cd:	5e                   	pop    %esi
 3ce:	5f                   	pop    %edi
 3cf:	5d                   	pop    %ebp
 3d0:	c3                   	ret    
 3d1:	eb 0d                	jmp    3e0 <stat>
 3d3:	90                   	nop
 3d4:	90                   	nop
 3d5:	90                   	nop
 3d6:	90                   	nop
 3d7:	90                   	nop
 3d8:	90                   	nop
 3d9:	90                   	nop
 3da:	90                   	nop
 3db:	90                   	nop
 3dc:	90                   	nop
 3dd:	90                   	nop
 3de:	90                   	nop
 3df:	90                   	nop

000003e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e5:	83 ec 08             	sub    $0x8,%esp
 3e8:	6a 00                	push   $0x0
 3ea:	ff 75 08             	pushl  0x8(%ebp)
 3ed:	e8 f0 00 00 00       	call   4e2 <open>
  if(fd < 0)
 3f2:	83 c4 10             	add    $0x10,%esp
 3f5:	85 c0                	test   %eax,%eax
 3f7:	78 27                	js     420 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3f9:	83 ec 08             	sub    $0x8,%esp
 3fc:	ff 75 0c             	pushl  0xc(%ebp)
 3ff:	89 c3                	mov    %eax,%ebx
 401:	50                   	push   %eax
 402:	e8 f3 00 00 00       	call   4fa <fstat>
 407:	89 c6                	mov    %eax,%esi
  close(fd);
 409:	89 1c 24             	mov    %ebx,(%esp)
 40c:	e8 b9 00 00 00       	call   4ca <close>
  return r;
 411:	83 c4 10             	add    $0x10,%esp
 414:	89 f0                	mov    %esi,%eax
}
 416:	8d 65 f8             	lea    -0x8(%ebp),%esp
 419:	5b                   	pop    %ebx
 41a:	5e                   	pop    %esi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 425:	eb ef                	jmp    416 <stat+0x36>
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 437:	0f be 11             	movsbl (%ecx),%edx
 43a:	8d 42 d0             	lea    -0x30(%edx),%eax
 43d:	3c 09                	cmp    $0x9,%al
 43f:	b8 00 00 00 00       	mov    $0x0,%eax
 444:	77 1f                	ja     465 <atoi+0x35>
 446:	8d 76 00             	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 450:	8d 04 80             	lea    (%eax,%eax,4),%eax
 453:	83 c1 01             	add    $0x1,%ecx
 456:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45a:	0f be 11             	movsbl (%ecx),%edx
 45d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 460:	80 fb 09             	cmp    $0x9,%bl
 463:	76 eb                	jbe    450 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 465:	5b                   	pop    %ebx
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
 468:	90                   	nop
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000470 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	8b 5d 10             	mov    0x10(%ebp),%ebx
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	85 db                	test   %ebx,%ebx
 480:	7e 14                	jle    496 <memmove+0x26>
 482:	31 d2                	xor    %edx,%edx
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 488:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 48c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 48f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 492:	39 da                	cmp    %ebx,%edx
 494:	75 f2                	jne    488 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    

0000049a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 49a:	b8 01 00 00 00       	mov    $0x1,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <exit>:
SYSCALL(exit)
 4a2:	b8 02 00 00 00       	mov    $0x2,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <wait>:
SYSCALL(wait)
 4aa:	b8 03 00 00 00       	mov    $0x3,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <pipe>:
SYSCALL(pipe)
 4b2:	b8 04 00 00 00       	mov    $0x4,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <read>:
SYSCALL(read)
 4ba:	b8 05 00 00 00       	mov    $0x5,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <write>:
SYSCALL(write)
 4c2:	b8 10 00 00 00       	mov    $0x10,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <close>:
SYSCALL(close)
 4ca:	b8 15 00 00 00       	mov    $0x15,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kill>:
SYSCALL(kill)
 4d2:	b8 06 00 00 00       	mov    $0x6,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <exec>:
SYSCALL(exec)
 4da:	b8 07 00 00 00       	mov    $0x7,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <open>:
SYSCALL(open)
 4e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <mknod>:
SYSCALL(mknod)
 4ea:	b8 11 00 00 00       	mov    $0x11,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <unlink>:
SYSCALL(unlink)
 4f2:	b8 12 00 00 00       	mov    $0x12,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <fstat>:
SYSCALL(fstat)
 4fa:	b8 08 00 00 00       	mov    $0x8,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <link>:
SYSCALL(link)
 502:	b8 13 00 00 00       	mov    $0x13,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mkdir>:
SYSCALL(mkdir)
 50a:	b8 14 00 00 00       	mov    $0x14,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <chdir>:
SYSCALL(chdir)
 512:	b8 09 00 00 00       	mov    $0x9,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <dup>:
SYSCALL(dup)
 51a:	b8 0a 00 00 00       	mov    $0xa,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <getpid>:
SYSCALL(getpid)
 522:	b8 0b 00 00 00       	mov    $0xb,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <sbrk>:
SYSCALL(sbrk)
 52a:	b8 0c 00 00 00       	mov    $0xc,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <sleep>:
SYSCALL(sleep)
 532:	b8 0d 00 00 00       	mov    $0xd,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <uptime>:
SYSCALL(uptime)
 53a:	b8 0e 00 00 00       	mov    $0xe,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <cps>:
SYSCALL(cps)
 542:	b8 16 00 00 00       	mov    $0x16,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <userTag>:
SYSCALL(userTag)
 54a:	b8 17 00 00 00       	mov    $0x17,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <changeUser>:
SYSCALL(changeUser)
 552:	b8 18 00 00 00       	mov    $0x18,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <getUser>:
SYSCALL(getUser)
 55a:	b8 19 00 00 00       	mov    $0x19,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <changeOwner>:
SYSCALL(changeOwner)
 562:	b8 1a 00 00 00       	mov    $0x1a,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    
 56a:	66 90                	xchg   %ax,%ax
 56c:	66 90                	xchg   %ax,%ax
 56e:	66 90                	xchg   %ax,%ax

00000570 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	57                   	push   %edi
 574:	56                   	push   %esi
 575:	53                   	push   %ebx
 576:	89 c6                	mov    %eax,%esi
 578:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 57e:	85 db                	test   %ebx,%ebx
 580:	74 7e                	je     600 <printint+0x90>
 582:	89 d0                	mov    %edx,%eax
 584:	c1 e8 1f             	shr    $0x1f,%eax
 587:	84 c0                	test   %al,%al
 589:	74 75                	je     600 <printint+0x90>
    neg = 1;
    x = -xx;
 58b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 58d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 594:	f7 d8                	neg    %eax
 596:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 599:	31 ff                	xor    %edi,%edi
 59b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 59e:	89 ce                	mov    %ecx,%esi
 5a0:	eb 08                	jmp    5aa <printint+0x3a>
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5a8:	89 cf                	mov    %ecx,%edi
 5aa:	31 d2                	xor    %edx,%edx
 5ac:	8d 4f 01             	lea    0x1(%edi),%ecx
 5af:	f7 f6                	div    %esi
 5b1:	0f b6 92 94 09 00 00 	movzbl 0x994(%edx),%edx
  }while((x /= base) != 0);
 5b8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5bd:	75 e9                	jne    5a8 <printint+0x38>
  if(neg)
 5bf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5c2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5c5:	85 c0                	test   %eax,%eax
 5c7:	74 08                	je     5d1 <printint+0x61>
    buf[i++] = '-';
 5c9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5ce:	8d 4f 02             	lea    0x2(%edi),%ecx
 5d1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5d5:	8d 76 00             	lea    0x0(%esi),%esi
 5d8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5db:	83 ec 04             	sub    $0x4,%esp
 5de:	83 ef 01             	sub    $0x1,%edi
 5e1:	6a 01                	push   $0x1
 5e3:	53                   	push   %ebx
 5e4:	56                   	push   %esi
 5e5:	88 45 d7             	mov    %al,-0x29(%ebp)
 5e8:	e8 d5 fe ff ff       	call   4c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ed:	83 c4 10             	add    $0x10,%esp
 5f0:	39 df                	cmp    %ebx,%edi
 5f2:	75 e4                	jne    5d8 <printint+0x68>
    putc(fd, buf[i]);
}
 5f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f7:	5b                   	pop    %ebx
 5f8:	5e                   	pop    %esi
 5f9:	5f                   	pop    %edi
 5fa:	5d                   	pop    %ebp
 5fb:	c3                   	ret    
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 600:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 602:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 609:	eb 8b                	jmp    596 <printint+0x26>
 60b:	90                   	nop
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000610 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	56                   	push   %esi
 615:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 616:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 619:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 61c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 61f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 622:	89 45 d0             	mov    %eax,-0x30(%ebp)
 625:	0f b6 1e             	movzbl (%esi),%ebx
 628:	83 c6 01             	add    $0x1,%esi
 62b:	84 db                	test   %bl,%bl
 62d:	0f 84 b0 00 00 00    	je     6e3 <printf+0xd3>
 633:	31 d2                	xor    %edx,%edx
 635:	eb 39                	jmp    670 <printf+0x60>
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 640:	83 f8 25             	cmp    $0x25,%eax
 643:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 646:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 64b:	74 18                	je     665 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 656:	6a 01                	push   $0x1
 658:	50                   	push   %eax
 659:	57                   	push   %edi
 65a:	e8 63 fe ff ff       	call   4c2 <write>
 65f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 662:	83 c4 10             	add    $0x10,%esp
 665:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 668:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 66c:	84 db                	test   %bl,%bl
 66e:	74 73                	je     6e3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 670:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 672:	0f be cb             	movsbl %bl,%ecx
 675:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 678:	74 c6                	je     640 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 67a:	83 fa 25             	cmp    $0x25,%edx
 67d:	75 e6                	jne    665 <printf+0x55>
      if(c == 'd'){
 67f:	83 f8 64             	cmp    $0x64,%eax
 682:	0f 84 f8 00 00 00    	je     780 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 688:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 68e:	83 f9 70             	cmp    $0x70,%ecx
 691:	74 5d                	je     6f0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 693:	83 f8 73             	cmp    $0x73,%eax
 696:	0f 84 84 00 00 00    	je     720 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 69c:	83 f8 63             	cmp    $0x63,%eax
 69f:	0f 84 ea 00 00 00    	je     78f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6a5:	83 f8 25             	cmp    $0x25,%eax
 6a8:	0f 84 c2 00 00 00    	je     770 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6b1:	83 ec 04             	sub    $0x4,%esp
 6b4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6b8:	6a 01                	push   $0x1
 6ba:	50                   	push   %eax
 6bb:	57                   	push   %edi
 6bc:	e8 01 fe ff ff       	call   4c2 <write>
 6c1:	83 c4 0c             	add    $0xc,%esp
 6c4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6c7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ca:	6a 01                	push   $0x1
 6cc:	50                   	push   %eax
 6cd:	57                   	push   %edi
 6ce:	83 c6 01             	add    $0x1,%esi
 6d1:	e8 ec fd ff ff       	call   4c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6d6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6da:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6dd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6df:	84 db                	test   %bl,%bl
 6e1:	75 8d                	jne    670 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e6:	5b                   	pop    %ebx
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6f0:	83 ec 0c             	sub    $0xc,%esp
 6f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6f8:	6a 00                	push   $0x0
 6fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6fd:	89 f8                	mov    %edi,%eax
 6ff:	8b 13                	mov    (%ebx),%edx
 701:	e8 6a fe ff ff       	call   570 <printint>
        ap++;
 706:	89 d8                	mov    %ebx,%eax
 708:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 70b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 70d:	83 c0 04             	add    $0x4,%eax
 710:	89 45 d0             	mov    %eax,-0x30(%ebp)
 713:	e9 4d ff ff ff       	jmp    665 <printf+0x55>
 718:	90                   	nop
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 720:	8b 45 d0             	mov    -0x30(%ebp),%eax
 723:	8b 18                	mov    (%eax),%ebx
        ap++;
 725:	83 c0 04             	add    $0x4,%eax
 728:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 72b:	b8 8d 09 00 00       	mov    $0x98d,%eax
 730:	85 db                	test   %ebx,%ebx
 732:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 735:	0f b6 03             	movzbl (%ebx),%eax
 738:	84 c0                	test   %al,%al
 73a:	74 23                	je     75f <printf+0x14f>
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 740:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 743:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 746:	83 ec 04             	sub    $0x4,%esp
 749:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 74b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 74e:	50                   	push   %eax
 74f:	57                   	push   %edi
 750:	e8 6d fd ff ff       	call   4c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 755:	0f b6 03             	movzbl (%ebx),%eax
 758:	83 c4 10             	add    $0x10,%esp
 75b:	84 c0                	test   %al,%al
 75d:	75 e1                	jne    740 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 75f:	31 d2                	xor    %edx,%edx
 761:	e9 ff fe ff ff       	jmp    665 <printf+0x55>
 766:	8d 76 00             	lea    0x0(%esi),%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 776:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 779:	6a 01                	push   $0x1
 77b:	e9 4c ff ff ff       	jmp    6cc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 780:	83 ec 0c             	sub    $0xc,%esp
 783:	b9 0a 00 00 00       	mov    $0xa,%ecx
 788:	6a 01                	push   $0x1
 78a:	e9 6b ff ff ff       	jmp    6fa <printf+0xea>
 78f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 792:	83 ec 04             	sub    $0x4,%esp
 795:	8b 03                	mov    (%ebx),%eax
 797:	6a 01                	push   $0x1
 799:	88 45 e4             	mov    %al,-0x1c(%ebp)
 79c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 79f:	50                   	push   %eax
 7a0:	57                   	push   %edi
 7a1:	e8 1c fd ff ff       	call   4c2 <write>
 7a6:	e9 5b ff ff ff       	jmp    706 <printf+0xf6>
 7ab:	66 90                	xchg   %ax,%ax
 7ad:	66 90                	xchg   %ax,%ax
 7af:	90                   	nop

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 38 0c 00 00       	mov    0xc38,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	57                   	push   %edi
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7be:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c3:	39 c8                	cmp    %ecx,%eax
 7c5:	73 19                	jae    7e0 <free+0x30>
 7c7:	89 f6                	mov    %esi,%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7d0:	39 d1                	cmp    %edx,%ecx
 7d2:	72 1c                	jb     7f0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	39 d0                	cmp    %edx,%eax
 7d6:	73 18                	jae    7f0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7da:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7de:	72 f0                	jb     7d0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e0:	39 d0                	cmp    %edx,%eax
 7e2:	72 f4                	jb     7d8 <free+0x28>
 7e4:	39 d1                	cmp    %edx,%ecx
 7e6:	73 f0                	jae    7d8 <free+0x28>
 7e8:	90                   	nop
 7e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7f3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7f6:	39 d7                	cmp    %edx,%edi
 7f8:	74 19                	je     813 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7fa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7fd:	8b 50 04             	mov    0x4(%eax),%edx
 800:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 803:	39 f1                	cmp    %esi,%ecx
 805:	74 23                	je     82a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 807:	89 08                	mov    %ecx,(%eax)
  freep = p;
 809:	a3 38 0c 00 00       	mov    %eax,0xc38
}
 80e:	5b                   	pop    %ebx
 80f:	5e                   	pop    %esi
 810:	5f                   	pop    %edi
 811:	5d                   	pop    %ebp
 812:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 813:	03 72 04             	add    0x4(%edx),%esi
 816:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 819:	8b 10                	mov    (%eax),%edx
 81b:	8b 12                	mov    (%edx),%edx
 81d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 820:	8b 50 04             	mov    0x4(%eax),%edx
 823:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 826:	39 f1                	cmp    %esi,%ecx
 828:	75 dd                	jne    807 <free+0x57>
    p->s.size += bp->s.size;
 82a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 82d:	a3 38 0c 00 00       	mov    %eax,0xc38
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 832:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 835:	8b 53 f8             	mov    -0x8(%ebx),%edx
 838:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 83a:	5b                   	pop    %ebx
 83b:	5e                   	pop    %esi
 83c:	5f                   	pop    %edi
 83d:	5d                   	pop    %ebp
 83e:	c3                   	ret    
 83f:	90                   	nop

00000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 84c:	8b 15 38 0c 00 00    	mov    0xc38,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 852:	8d 78 07             	lea    0x7(%eax),%edi
 855:	c1 ef 03             	shr    $0x3,%edi
 858:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 85b:	85 d2                	test   %edx,%edx
 85d:	0f 84 a3 00 00 00    	je     906 <malloc+0xc6>
 863:	8b 02                	mov    (%edx),%eax
 865:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 868:	39 cf                	cmp    %ecx,%edi
 86a:	76 74                	jbe    8e0 <malloc+0xa0>
 86c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 872:	be 00 10 00 00       	mov    $0x1000,%esi
 877:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 87e:	0f 43 f7             	cmovae %edi,%esi
 881:	ba 00 80 00 00       	mov    $0x8000,%edx
 886:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 88c:	0f 46 da             	cmovbe %edx,%ebx
 88f:	eb 10                	jmp    8a1 <malloc+0x61>
 891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 898:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 89a:	8b 48 04             	mov    0x4(%eax),%ecx
 89d:	39 cf                	cmp    %ecx,%edi
 89f:	76 3f                	jbe    8e0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8a1:	39 05 38 0c 00 00    	cmp    %eax,0xc38
 8a7:	89 c2                	mov    %eax,%edx
 8a9:	75 ed                	jne    898 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8ab:	83 ec 0c             	sub    $0xc,%esp
 8ae:	53                   	push   %ebx
 8af:	e8 76 fc ff ff       	call   52a <sbrk>
  if(p == (char*)-1)
 8b4:	83 c4 10             	add    $0x10,%esp
 8b7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ba:	74 1c                	je     8d8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8bc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8bf:	83 ec 0c             	sub    $0xc,%esp
 8c2:	83 c0 08             	add    $0x8,%eax
 8c5:	50                   	push   %eax
 8c6:	e8 e5 fe ff ff       	call   7b0 <free>
  return freep;
 8cb:	8b 15 38 0c 00 00    	mov    0xc38,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8d1:	83 c4 10             	add    $0x10,%esp
 8d4:	85 d2                	test   %edx,%edx
 8d6:	75 c0                	jne    898 <malloc+0x58>
        return 0;
 8d8:	31 c0                	xor    %eax,%eax
 8da:	eb 1c                	jmp    8f8 <malloc+0xb8>
 8dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 8e0:	39 cf                	cmp    %ecx,%edi
 8e2:	74 1c                	je     900 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8e4:	29 f9                	sub    %edi,%ecx
 8e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8ec:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 8ef:	89 15 38 0c 00 00    	mov    %edx,0xc38
      return (void*)(p + 1);
 8f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8fb:	5b                   	pop    %ebx
 8fc:	5e                   	pop    %esi
 8fd:	5f                   	pop    %edi
 8fe:	5d                   	pop    %ebp
 8ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 900:	8b 08                	mov    (%eax),%ecx
 902:	89 0a                	mov    %ecx,(%edx)
 904:	eb e9                	jmp    8ef <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 906:	c7 05 38 0c 00 00 3c 	movl   $0xc3c,0xc38
 90d:	0c 00 00 
 910:	c7 05 3c 0c 00 00 3c 	movl   $0xc3c,0xc3c
 917:	0c 00 00 
    base.s.size = 0;
 91a:	b8 3c 0c 00 00       	mov    $0xc3c,%eax
 91f:	c7 05 40 0c 00 00 00 	movl   $0x0,0xc40
 926:	00 00 00 
 929:	e9 3e ff ff ff       	jmp    86c <malloc+0x2c>
