
_cu:     file format elf32-i386


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
	
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
  11:	8d 9d e8 fb ff ff    	lea    -0x418(%ebp),%ebx
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{	
  17:	81 ec 20 05 00 00    	sub    $0x520,%esp
  1d:	8b 41 04             	mov    0x4(%ecx),%eax
	
	int fd = open("UserList", O_RDONLY);
  20:	6a 00                	push   $0x0
  22:	68 d0 08 00 00       	push   $0x8d0
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{	
  27:	89 c6                	mov    %eax,%esi
  29:	89 85 d8 fa ff ff    	mov    %eax,-0x528(%ebp)
	
	int fd = open("UserList", O_RDONLY);
  2f:	e8 4e 04 00 00       	call   482 <open>
	char *targetUser = argv[1];
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
  34:	83 c4 0c             	add    $0xc,%esp

int main(int argc, char *argv[])
{	
	
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
  37:	8b 76 04             	mov    0x4(%esi),%esi
#include "fcntl.h"

int main(int argc, char *argv[])
{	
	
	int fd = open("UserList", O_RDONLY);
  3a:	89 85 dc fa ff ff    	mov    %eax,-0x524(%ebp)
	char *targetUser = argv[1];
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
  40:	68 00 04 00 00       	push   $0x400
  45:	53                   	push   %ebx
  46:	50                   	push   %eax

int main(int argc, char *argv[])
{	
	
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
  47:	89 b5 e0 fa ff ff    	mov    %esi,-0x520(%ebp)
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
  4d:	e8 08 04 00 00       	call   45a <read>
	if(checkReadFile < 0)
  52:	83 c4 10             	add    $0x10,%esp
  55:	85 c0                	test   %eax,%eax
  57:	0f 88 73 01 00 00    	js     1d0 <main+0x1d0>
  5d:	31 ff                	xor    %edi,%edi
  5f:	c7 85 e4 fa ff ff 00 	movl   $0x0,-0x51c(%ebp)
  66:	00 00 00 
  69:	eb 1d                	jmp    88 <main+0x88>
  6b:	90                   	nop
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				n = 0;
			}
			else
			{
				//printf(1,"n: %d\n",n);
				nameList[n]=c;
  70:	88 94 3d e8 fa ff ff 	mov    %dl,-0x518(%ebp,%edi,1)
				n++;
  77:	83 c7 01             	add    $0x1,%edi
			}
			
		
		}while(c != '\0');
  7a:	84 d2                	test   %dl,%dl
  7c:	0f 84 29 01 00 00    	je     1ab <main+0x1ab>
					{
						c = buf[i];
						i++;
					} while (c != ':');
				}
				n = 0;
  82:	89 85 e4 fa ff ff    	mov    %eax,-0x51c(%ebp)
		int i = 0; // buffer iterator
		int n = 0; // name iterator
		char c;
		do
		{
			c=buf[i];		
  88:	8b 85 e4 fa ff ff    	mov    -0x51c(%ebp),%eax
  8e:	0f b6 94 05 e8 fb ff 	movzbl -0x418(%ebp,%eax,1),%edx
  95:	ff 
			i++;
  96:	83 c0 01             	add    $0x1,%eax
			
			if(c==':')
  99:	80 fa 3a             	cmp    $0x3a,%dl
  9c:	75 d2                	jne    70 <main+0x70>
			{
				// compare string
				//printf(1, "names: %s\n", names);
				char* j = targetUser;
				char* k = nameList;
				while(n > 0 && *j && *j == *k)
  9e:	85 ff                	test   %edi,%edi
  a0:	74 4d                	je     ef <main+0xef>
  a2:	8b b5 e0 fa ff ff    	mov    -0x520(%ebp),%esi
  a8:	0f b6 16             	movzbl (%esi),%edx
  ab:	84 d2                	test   %dl,%dl
  ad:	0f 84 e5 00 00 00    	je     198 <main+0x198>
  b3:	38 95 e8 fa ff ff    	cmp    %dl,-0x518(%ebp)
  b9:	0f 85 d9 00 00 00    	jne    198 <main+0x198>
  bf:	8d 56 01             	lea    0x1(%esi),%edx
  c2:	01 f7                	add    %esi,%edi
  c4:	8d 8d e8 fa ff ff    	lea    -0x518(%ebp),%ecx
  ca:	89 c6                	mov    %eax,%esi
  cc:	eb 18                	jmp    e6 <main+0xe6>
  ce:	66 90                	xchg   %ax,%ax
  d0:	0f b6 02             	movzbl (%edx),%eax
  d3:	84 c0                	test   %al,%al
  d5:	0f 84 b5 00 00 00    	je     190 <main+0x190>
  db:	83 c2 01             	add    $0x1,%edx
  de:	3a 01                	cmp    (%ecx),%al
  e0:	0f 85 aa 00 00 00    	jne    190 <main+0x190>
				{
					//printf(1,"n=%d\n",n);
					n--;
					j++;
					k++;
  e6:	83 c1 01             	add    $0x1,%ecx
			{
				// compare string
				//printf(1, "names: %s\n", names);
				char* j = targetUser;
				char* k = nameList;
				while(n > 0 && *j && *j == *k)
  e9:	39 d7                	cmp    %edx,%edi
  eb:	75 e3                	jne    d0 <main+0xd0>
  ed:	89 f0                	mov    %esi,%eax
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
  ef:	0f b6 94 05 e8 fb ff 	movzbl -0x418(%ebp,%eax,1),%edx
  f6:	ff 
						i++;

						if (c == ':')
  f7:	80 fa 3a             	cmp    $0x3a,%dl
  fa:	74 69                	je     165 <main+0x165>
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
  fc:	03 9d e4 fa ff ff    	add    -0x51c(%ebp),%ebx
						i++;

						if (c == ':')
 102:	31 c0                	xor    %eax,%eax
							}
							break;
						}
						else
						{
							password[p] = c;
 104:	88 94 05 68 fb ff ff 	mov    %dl,-0x498(%ebp,%eax,1)
							p++;
 10b:	83 c0 01             	add    $0x1,%eax
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
 10e:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
						i++;

						if (c == ':')
 113:	80 fa 3a             	cmp    $0x3a,%dl
 116:	75 ec                	jne    104 <main+0x104>
						{
							// compare password string
							j = argv[2];
 118:	8b b5 d8 fa ff ff    	mov    -0x528(%ebp),%esi
 11e:	8b 56 08             	mov    0x8(%esi),%edx
							k = password;
							while (p > 0 && *j && *j == *k)
 121:	0f b6 0a             	movzbl (%edx),%ecx
 124:	84 c9                	test   %cl,%cl
 126:	0f 84 b7 00 00 00    	je     1e3 <main+0x1e3>
 12c:	38 8d 68 fb ff ff    	cmp    %cl,-0x498(%ebp)
 132:	0f 85 ab 00 00 00    	jne    1e3 <main+0x1e3>
 138:	01 d0                	add    %edx,%eax
 13a:	8d 8d 68 fb ff ff    	lea    -0x498(%ebp),%ecx
 140:	eb 19                	jmp    15b <main+0x15b>
 142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 148:	0f b6 1a             	movzbl (%edx),%ebx
 14b:	84 db                	test   %bl,%bl
 14d:	0f 84 90 00 00 00    	je     1e3 <main+0x1e3>
 153:	3a 19                	cmp    (%ecx),%bl
 155:	0f 85 88 00 00 00    	jne    1e3 <main+0x1e3>
							{
								p--;
								j++;
 15b:	83 c2 01             	add    $0x1,%edx
								k++;
 15e:	83 c1 01             	add    $0x1,%ecx
						if (c == ':')
						{
							// compare password string
							j = argv[2];
							k = password;
							while (p > 0 && *j && *j == *k)
 161:	39 d0                	cmp    %edx,%eax
 163:	75 e3                	jne    148 <main+0x148>
								j++;
								k++;
							} 
							if (p == 0)
							{
								changeUser(argv[1]);
 165:	8b 85 d8 fa ff ff    	mov    -0x528(%ebp),%eax
 16b:	83 ec 0c             	sub    $0xc,%esp
 16e:	ff 70 04             	pushl  0x4(%eax)
 171:	e8 7c 03 00 00       	call   4f2 <changeUser>
								printf(1,"User changed.\n");
 176:	5a                   	pop    %edx
 177:	59                   	pop    %ecx
 178:	68 ef 08 00 00       	push   $0x8ef
 17d:	6a 01                	push   $0x1
 17f:	e8 2c 04 00 00       	call   5b0 <printf>
 184:	83 c4 10             	add    $0x10,%esp
 187:	eb 34                	jmp    1bd <main+0x1bd>
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	89 f0                	mov    %esi,%eax
 192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				else
				{
					// skip the password part
					do
					{
						c = buf[i];
 198:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
						i++;
 19c:	83 c0 01             	add    $0x1,%eax
					} while (c != ':');
 19f:	80 fa 3a             	cmp    $0x3a,%dl
 1a2:	75 f4                	jne    198 <main+0x198>
				}
				n = 0;
 1a4:	31 ff                	xor    %edi,%edi
 1a6:	e9 d7 fe ff ff       	jmp    82 <main+0x82>
			
		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
 1ab:	83 ec 08             	sub    $0x8,%esp
 1ae:	68 fe 08 00 00       	push   $0x8fe
 1b3:	6a 01                	push   $0x1
 1b5:	e8 f6 03 00 00       	call   5b0 <printf>
 1ba:	83 c4 10             	add    $0x10,%esp
		}
	}
	
	close(fd);
 1bd:	83 ec 0c             	sub    $0xc,%esp
 1c0:	ff b5 dc fa ff ff    	pushl  -0x524(%ebp)
 1c6:	e8 9f 02 00 00       	call   46a <close>
	
	close(fd);
	*/

		
	exit();
 1cb:	e8 72 02 00 00       	call   442 <exit>
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
 1d0:	53                   	push   %ebx
 1d1:	53                   	push   %ebx
 1d2:	68 d9 08 00 00       	push   $0x8d9
 1d7:	6a 01                	push   $0x1
 1d9:	e8 d2 03 00 00       	call   5b0 <printf>
 1de:	83 c4 10             	add    $0x10,%esp
 1e1:	eb da                	jmp    1bd <main+0x1bd>
								printf(1,"User changed.\n");
								
							}
							else
							{
								printf(1,"Incorrect password. Please try again.\n");
 1e3:	50                   	push   %eax
 1e4:	50                   	push   %eax
 1e5:	68 10 09 00 00       	push   $0x910
 1ea:	6a 01                	push   $0x1
 1ec:	e8 bf 03 00 00       	call   5b0 <printf>
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	eb c7                	jmp    1bd <main+0x1bd>
 1f6:	66 90                	xchg   %ax,%ax
 1f8:	66 90                	xchg   %ax,%ax
 1fa:	66 90                	xchg   %ax,%ax
 1fc:	66 90                	xchg   %ax,%ax
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20a:	89 c2                	mov    %eax,%edx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	83 c1 01             	add    $0x1,%ecx
 213:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 217:	83 c2 01             	add    $0x1,%edx
 21a:	84 db                	test   %bl,%bl
 21c:	88 5a ff             	mov    %bl,-0x1(%edx)
 21f:	75 ef                	jne    210 <strcpy+0x10>
    ;
  return os;
}
 221:	5b                   	pop    %ebx
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	8b 55 08             	mov    0x8(%ebp),%edx
 238:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23b:	0f b6 02             	movzbl (%edx),%eax
 23e:	0f b6 19             	movzbl (%ecx),%ebx
 241:	84 c0                	test   %al,%al
 243:	75 1e                	jne    263 <strcmp+0x33>
 245:	eb 29                	jmp    270 <strcmp+0x40>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 250:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 253:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 256:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 259:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 25d:	84 c0                	test   %al,%al
 25f:	74 0f                	je     270 <strcmp+0x40>
 261:	89 f1                	mov    %esi,%ecx
 263:	38 d8                	cmp    %bl,%al
 265:	74 e9                	je     250 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 267:	29 d8                	sub    %ebx,%eax
}
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 270:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 272:	29 d8                	sub    %ebx,%eax
}
 274:	5b                   	pop    %ebx
 275:	5e                   	pop    %esi
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <strlen>:

uint
strlen(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 286:	80 39 00             	cmpb   $0x0,(%ecx)
 289:	74 12                	je     29d <strlen+0x1d>
 28b:	31 d2                	xor    %edx,%edx
 28d:	8d 76 00             	lea    0x0(%esi),%esi
 290:	83 c2 01             	add    $0x1,%edx
 293:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 297:	89 d0                	mov    %edx,%eax
 299:	75 f5                	jne    290 <strlen+0x10>
    ;
  return n;
}
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 29d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	eb 0d                	jmp    2b0 <memset>
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 d7                	mov    %edx,%edi
 2bf:	fc                   	cld    
 2c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	5f                   	pop    %edi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2da:	0f b6 10             	movzbl (%eax),%edx
 2dd:	84 d2                	test   %dl,%dl
 2df:	74 1d                	je     2fe <strchr+0x2e>
    if(*s == c)
 2e1:	38 d3                	cmp    %dl,%bl
 2e3:	89 d9                	mov    %ebx,%ecx
 2e5:	75 0d                	jne    2f4 <strchr+0x24>
 2e7:	eb 17                	jmp    300 <strchr+0x30>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	38 ca                	cmp    %cl,%dl
 2f2:	74 0c                	je     300 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2f4:	83 c0 01             	add    $0x1,%eax
 2f7:	0f b6 10             	movzbl (%eax),%edx
 2fa:	84 d2                	test   %dl,%dl
 2fc:	75 f2                	jne    2f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 2fe:	31 c0                	xor    %eax,%eax
}
 300:	5b                   	pop    %ebx
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <gets>:

char*
gets(char *buf, int max)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 318:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 31b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	eb 29                	jmp    349 <gets+0x39>
    cc = read(0, &c, 1);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	6a 01                	push   $0x1
 325:	57                   	push   %edi
 326:	6a 00                	push   $0x0
 328:	e8 2d 01 00 00       	call   45a <read>
    if(cc < 1)
 32d:	83 c4 10             	add    $0x10,%esp
 330:	85 c0                	test   %eax,%eax
 332:	7e 1d                	jle    351 <gets+0x41>
      break;
    buf[i++] = c;
 334:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 33d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 33f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 343:	74 1b                	je     360 <gets+0x50>
 345:	3c 0d                	cmp    $0xd,%al
 347:	74 17                	je     360 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 349:	8d 5e 01             	lea    0x1(%esi),%ebx
 34c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 34f:	7c cf                	jl     320 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 351:	8b 45 08             	mov    0x8(%ebp),%eax
 354:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 358:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35b:	5b                   	pop    %ebx
 35c:	5e                   	pop    %esi
 35d:	5f                   	pop    %edi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 360:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 363:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 365:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 369:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5f                   	pop    %edi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
 371:	eb 0d                	jmp    380 <stat>
 373:	90                   	nop
 374:	90                   	nop
 375:	90                   	nop
 376:	90                   	nop
 377:	90                   	nop
 378:	90                   	nop
 379:	90                   	nop
 37a:	90                   	nop
 37b:	90                   	nop
 37c:	90                   	nop
 37d:	90                   	nop
 37e:	90                   	nop
 37f:	90                   	nop

00000380 <stat>:

int
stat(const char *n, struct stat *st)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	56                   	push   %esi
 384:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 385:	83 ec 08             	sub    $0x8,%esp
 388:	6a 00                	push   $0x0
 38a:	ff 75 08             	pushl  0x8(%ebp)
 38d:	e8 f0 00 00 00       	call   482 <open>
  if(fd < 0)
 392:	83 c4 10             	add    $0x10,%esp
 395:	85 c0                	test   %eax,%eax
 397:	78 27                	js     3c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	ff 75 0c             	pushl  0xc(%ebp)
 39f:	89 c3                	mov    %eax,%ebx
 3a1:	50                   	push   %eax
 3a2:	e8 f3 00 00 00       	call   49a <fstat>
 3a7:	89 c6                	mov    %eax,%esi
  close(fd);
 3a9:	89 1c 24             	mov    %ebx,(%esp)
 3ac:	e8 b9 00 00 00       	call   46a <close>
  return r;
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	89 f0                	mov    %esi,%eax
}
 3b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3b9:	5b                   	pop    %ebx
 3ba:	5e                   	pop    %esi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3c5:	eb ef                	jmp    3b6 <stat+0x36>
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d7:	0f be 11             	movsbl (%ecx),%edx
 3da:	8d 42 d0             	lea    -0x30(%edx),%eax
 3dd:	3c 09                	cmp    $0x9,%al
 3df:	b8 00 00 00 00       	mov    $0x0,%eax
 3e4:	77 1f                	ja     405 <atoi+0x35>
 3e6:	8d 76 00             	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3f3:	83 c1 01             	add    $0x1,%ecx
 3f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fa:	0f be 11             	movsbl (%ecx),%edx
 3fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 400:	80 fb 09             	cmp    $0x9,%bl
 403:	76 eb                	jbe    3f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 405:	5b                   	pop    %ebx
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	8b 5d 10             	mov    0x10(%ebp),%ebx
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 41e:	85 db                	test   %ebx,%ebx
 420:	7e 14                	jle    436 <memmove+0x26>
 422:	31 d2                	xor    %edx,%edx
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 428:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 42c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 42f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 432:	39 da                	cmp    %ebx,%edx
 434:	75 f2                	jne    428 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5d                   	pop    %ebp
 439:	c3                   	ret    

0000043a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <exit>:
SYSCALL(exit)
 442:	b8 02 00 00 00       	mov    $0x2,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <wait>:
SYSCALL(wait)
 44a:	b8 03 00 00 00       	mov    $0x3,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <pipe>:
SYSCALL(pipe)
 452:	b8 04 00 00 00       	mov    $0x4,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <read>:
SYSCALL(read)
 45a:	b8 05 00 00 00       	mov    $0x5,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <write>:
SYSCALL(write)
 462:	b8 10 00 00 00       	mov    $0x10,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <close>:
SYSCALL(close)
 46a:	b8 15 00 00 00       	mov    $0x15,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kill>:
SYSCALL(kill)
 472:	b8 06 00 00 00       	mov    $0x6,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <exec>:
SYSCALL(exec)
 47a:	b8 07 00 00 00       	mov    $0x7,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <open>:
SYSCALL(open)
 482:	b8 0f 00 00 00       	mov    $0xf,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mknod>:
SYSCALL(mknod)
 48a:	b8 11 00 00 00       	mov    $0x11,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <unlink>:
SYSCALL(unlink)
 492:	b8 12 00 00 00       	mov    $0x12,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <fstat>:
SYSCALL(fstat)
 49a:	b8 08 00 00 00       	mov    $0x8,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <link>:
SYSCALL(link)
 4a2:	b8 13 00 00 00       	mov    $0x13,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <mkdir>:
SYSCALL(mkdir)
 4aa:	b8 14 00 00 00       	mov    $0x14,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <chdir>:
SYSCALL(chdir)
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <dup>:
SYSCALL(dup)
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <getpid>:
SYSCALL(getpid)
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <sbrk>:
SYSCALL(sbrk)
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <sleep>:
SYSCALL(sleep)
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <uptime>:
SYSCALL(uptime)
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <cps>:
SYSCALL(cps)
 4e2:	b8 16 00 00 00       	mov    $0x16,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <userTag>:
SYSCALL(userTag)
 4ea:	b8 17 00 00 00       	mov    $0x17,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <changeUser>:
SYSCALL(changeUser)
 4f2:	b8 18 00 00 00       	mov    $0x18,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <getUser>:
SYSCALL(getUser)
 4fa:	b8 19 00 00 00       	mov    $0x19,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <changeOwner>:
SYSCALL(changeOwner)
 502:	b8 1a 00 00 00       	mov    $0x1a,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    
 50a:	66 90                	xchg   %ax,%ax
 50c:	66 90                	xchg   %ax,%ax
 50e:	66 90                	xchg   %ax,%ax

00000510 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	57                   	push   %edi
 514:	56                   	push   %esi
 515:	53                   	push   %ebx
 516:	89 c6                	mov    %eax,%esi
 518:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 51b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 51e:	85 db                	test   %ebx,%ebx
 520:	74 7e                	je     5a0 <printint+0x90>
 522:	89 d0                	mov    %edx,%eax
 524:	c1 e8 1f             	shr    $0x1f,%eax
 527:	84 c0                	test   %al,%al
 529:	74 75                	je     5a0 <printint+0x90>
    neg = 1;
    x = -xx;
 52b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 52d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 534:	f7 d8                	neg    %eax
 536:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 539:	31 ff                	xor    %edi,%edi
 53b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 53e:	89 ce                	mov    %ecx,%esi
 540:	eb 08                	jmp    54a <printint+0x3a>
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 548:	89 cf                	mov    %ecx,%edi
 54a:	31 d2                	xor    %edx,%edx
 54c:	8d 4f 01             	lea    0x1(%edi),%ecx
 54f:	f7 f6                	div    %esi
 551:	0f b6 92 40 09 00 00 	movzbl 0x940(%edx),%edx
  }while((x /= base) != 0);
 558:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 55a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 55d:	75 e9                	jne    548 <printint+0x38>
  if(neg)
 55f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 562:	8b 75 c0             	mov    -0x40(%ebp),%esi
 565:	85 c0                	test   %eax,%eax
 567:	74 08                	je     571 <printint+0x61>
    buf[i++] = '-';
 569:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 56e:	8d 4f 02             	lea    0x2(%edi),%ecx
 571:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 575:	8d 76 00             	lea    0x0(%esi),%esi
 578:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 57b:	83 ec 04             	sub    $0x4,%esp
 57e:	83 ef 01             	sub    $0x1,%edi
 581:	6a 01                	push   $0x1
 583:	53                   	push   %ebx
 584:	56                   	push   %esi
 585:	88 45 d7             	mov    %al,-0x29(%ebp)
 588:	e8 d5 fe ff ff       	call   462 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 58d:	83 c4 10             	add    $0x10,%esp
 590:	39 df                	cmp    %ebx,%edi
 592:	75 e4                	jne    578 <printint+0x68>
    putc(fd, buf[i]);
}
 594:	8d 65 f4             	lea    -0xc(%ebp),%esp
 597:	5b                   	pop    %ebx
 598:	5e                   	pop    %esi
 599:	5f                   	pop    %edi
 59a:	5d                   	pop    %ebp
 59b:	c3                   	ret    
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5a0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5a2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5a9:	eb 8b                	jmp    536 <printint+0x26>
 5ab:	90                   	nop
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5b9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5bf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5c5:	0f b6 1e             	movzbl (%esi),%ebx
 5c8:	83 c6 01             	add    $0x1,%esi
 5cb:	84 db                	test   %bl,%bl
 5cd:	0f 84 b0 00 00 00    	je     683 <printf+0xd3>
 5d3:	31 d2                	xor    %edx,%edx
 5d5:	eb 39                	jmp    610 <printf+0x60>
 5d7:	89 f6                	mov    %esi,%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e0:	83 f8 25             	cmp    $0x25,%eax
 5e3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 5e6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5eb:	74 18                	je     605 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ed:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5f6:	6a 01                	push   $0x1
 5f8:	50                   	push   %eax
 5f9:	57                   	push   %edi
 5fa:	e8 63 fe ff ff       	call   462 <write>
 5ff:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 602:	83 c4 10             	add    $0x10,%esp
 605:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 608:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 60c:	84 db                	test   %bl,%bl
 60e:	74 73                	je     683 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 610:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 612:	0f be cb             	movsbl %bl,%ecx
 615:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 618:	74 c6                	je     5e0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 61a:	83 fa 25             	cmp    $0x25,%edx
 61d:	75 e6                	jne    605 <printf+0x55>
      if(c == 'd'){
 61f:	83 f8 64             	cmp    $0x64,%eax
 622:	0f 84 f8 00 00 00    	je     720 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 628:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 62e:	83 f9 70             	cmp    $0x70,%ecx
 631:	74 5d                	je     690 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 633:	83 f8 73             	cmp    $0x73,%eax
 636:	0f 84 84 00 00 00    	je     6c0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 63c:	83 f8 63             	cmp    $0x63,%eax
 63f:	0f 84 ea 00 00 00    	je     72f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 645:	83 f8 25             	cmp    $0x25,%eax
 648:	0f 84 c2 00 00 00    	je     710 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 651:	83 ec 04             	sub    $0x4,%esp
 654:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 658:	6a 01                	push   $0x1
 65a:	50                   	push   %eax
 65b:	57                   	push   %edi
 65c:	e8 01 fe ff ff       	call   462 <write>
 661:	83 c4 0c             	add    $0xc,%esp
 664:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 667:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 66a:	6a 01                	push   $0x1
 66c:	50                   	push   %eax
 66d:	57                   	push   %edi
 66e:	83 c6 01             	add    $0x1,%esi
 671:	e8 ec fd ff ff       	call   462 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 676:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 67a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 67f:	84 db                	test   %bl,%bl
 681:	75 8d                	jne    610 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 683:	8d 65 f4             	lea    -0xc(%ebp),%esp
 686:	5b                   	pop    %ebx
 687:	5e                   	pop    %esi
 688:	5f                   	pop    %edi
 689:	5d                   	pop    %ebp
 68a:	c3                   	ret    
 68b:	90                   	nop
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 10 00 00 00       	mov    $0x10,%ecx
 698:	6a 00                	push   $0x0
 69a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 69d:	89 f8                	mov    %edi,%eax
 69f:	8b 13                	mov    (%ebx),%edx
 6a1:	e8 6a fe ff ff       	call   510 <printint>
        ap++;
 6a6:	89 d8                	mov    %ebx,%eax
 6a8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ab:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6ad:	83 c0 04             	add    $0x4,%eax
 6b0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6b3:	e9 4d ff ff ff       	jmp    605 <printf+0x55>
 6b8:	90                   	nop
 6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 6c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6c5:	83 c0 04             	add    $0x4,%eax
 6c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 6cb:	b8 38 09 00 00       	mov    $0x938,%eax
 6d0:	85 db                	test   %ebx,%ebx
 6d2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 6d5:	0f b6 03             	movzbl (%ebx),%eax
 6d8:	84 c0                	test   %al,%al
 6da:	74 23                	je     6ff <printf+0x14f>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6e6:	83 ec 04             	sub    $0x4,%esp
 6e9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6eb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ee:	50                   	push   %eax
 6ef:	57                   	push   %edi
 6f0:	e8 6d fd ff ff       	call   462 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f5:	0f b6 03             	movzbl (%ebx),%eax
 6f8:	83 c4 10             	add    $0x10,%esp
 6fb:	84 c0                	test   %al,%al
 6fd:	75 e1                	jne    6e0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 ff fe ff ff       	jmp    605 <printf+0x55>
 706:	8d 76 00             	lea    0x0(%esi),%esi
 709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 716:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 719:	6a 01                	push   $0x1
 71b:	e9 4c ff ff ff       	jmp    66c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 720:	83 ec 0c             	sub    $0xc,%esp
 723:	b9 0a 00 00 00       	mov    $0xa,%ecx
 728:	6a 01                	push   $0x1
 72a:	e9 6b ff ff ff       	jmp    69a <printf+0xea>
 72f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 732:	83 ec 04             	sub    $0x4,%esp
 735:	8b 03                	mov    (%ebx),%eax
 737:	6a 01                	push   $0x1
 739:	88 45 e4             	mov    %al,-0x1c(%ebp)
 73c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 73f:	50                   	push   %eax
 740:	57                   	push   %edi
 741:	e8 1c fd ff ff       	call   462 <write>
 746:	e9 5b ff ff ff       	jmp    6a6 <printf+0xf6>
 74b:	66 90                	xchg   %ax,%ax
 74d:	66 90                	xchg   %ax,%ax
 74f:	90                   	nop

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 e4 0b 00 00       	mov    0xbe4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 760:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 763:	39 c8                	cmp    %ecx,%eax
 765:	73 19                	jae    780 <free+0x30>
 767:	89 f6                	mov    %esi,%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 770:	39 d1                	cmp    %edx,%ecx
 772:	72 1c                	jb     790 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 774:	39 d0                	cmp    %edx,%eax
 776:	73 18                	jae    790 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 778:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77e:	72 f0                	jb     770 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 d0                	cmp    %edx,%eax
 782:	72 f4                	jb     778 <free+0x28>
 784:	39 d1                	cmp    %edx,%ecx
 786:	73 f0                	jae    778 <free+0x28>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 790:	8b 73 fc             	mov    -0x4(%ebx),%esi
 793:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 796:	39 d7                	cmp    %edx,%edi
 798:	74 19                	je     7b3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	74 23                	je     7ca <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7a7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7a9:	a3 e4 0b 00 00       	mov    %eax,0xbe4
}
 7ae:	5b                   	pop    %ebx
 7af:	5e                   	pop    %esi
 7b0:	5f                   	pop    %edi
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7b3:	03 72 04             	add    0x4(%edx),%esi
 7b6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	8b 12                	mov    (%edx),%edx
 7bd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7c0:	8b 50 04             	mov    0x4(%eax),%edx
 7c3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c6:	39 f1                	cmp    %esi,%ecx
 7c8:	75 dd                	jne    7a7 <free+0x57>
    p->s.size += bp->s.size;
 7ca:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7cd:	a3 e4 0b 00 00       	mov    %eax,0xbe4
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7d2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7d5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7d8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7da:	5b                   	pop    %ebx
 7db:	5e                   	pop    %esi
 7dc:	5f                   	pop    %edi
 7dd:	5d                   	pop    %ebp
 7de:	c3                   	ret    
 7df:	90                   	nop

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 15 e4 0b 00 00    	mov    0xbe4,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 78 07             	lea    0x7(%eax),%edi
 7f5:	c1 ef 03             	shr    $0x3,%edi
 7f8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7fb:	85 d2                	test   %edx,%edx
 7fd:	0f 84 a3 00 00 00    	je     8a6 <malloc+0xc6>
 803:	8b 02                	mov    (%edx),%eax
 805:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 808:	39 cf                	cmp    %ecx,%edi
 80a:	76 74                	jbe    880 <malloc+0xa0>
 80c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 812:	be 00 10 00 00       	mov    $0x1000,%esi
 817:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 81e:	0f 43 f7             	cmovae %edi,%esi
 821:	ba 00 80 00 00       	mov    $0x8000,%edx
 826:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 82c:	0f 46 da             	cmovbe %edx,%ebx
 82f:	eb 10                	jmp    841 <malloc+0x61>
 831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 838:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 83a:	8b 48 04             	mov    0x4(%eax),%ecx
 83d:	39 cf                	cmp    %ecx,%edi
 83f:	76 3f                	jbe    880 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 841:	39 05 e4 0b 00 00    	cmp    %eax,0xbe4
 847:	89 c2                	mov    %eax,%edx
 849:	75 ed                	jne    838 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 84b:	83 ec 0c             	sub    $0xc,%esp
 84e:	53                   	push   %ebx
 84f:	e8 76 fc ff ff       	call   4ca <sbrk>
  if(p == (char*)-1)
 854:	83 c4 10             	add    $0x10,%esp
 857:	83 f8 ff             	cmp    $0xffffffff,%eax
 85a:	74 1c                	je     878 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 85c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 85f:	83 ec 0c             	sub    $0xc,%esp
 862:	83 c0 08             	add    $0x8,%eax
 865:	50                   	push   %eax
 866:	e8 e5 fe ff ff       	call   750 <free>
  return freep;
 86b:	8b 15 e4 0b 00 00    	mov    0xbe4,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 871:	83 c4 10             	add    $0x10,%esp
 874:	85 d2                	test   %edx,%edx
 876:	75 c0                	jne    838 <malloc+0x58>
        return 0;
 878:	31 c0                	xor    %eax,%eax
 87a:	eb 1c                	jmp    898 <malloc+0xb8>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 880:	39 cf                	cmp    %ecx,%edi
 882:	74 1c                	je     8a0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 884:	29 f9                	sub    %edi,%ecx
 886:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 889:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 88c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 88f:	89 15 e4 0b 00 00    	mov    %edx,0xbe4
      return (void*)(p + 1);
 895:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 898:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89b:	5b                   	pop    %ebx
 89c:	5e                   	pop    %esi
 89d:	5f                   	pop    %edi
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb e9                	jmp    88f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8a6:	c7 05 e4 0b 00 00 e8 	movl   $0xbe8,0xbe4
 8ad:	0b 00 00 
 8b0:	c7 05 e8 0b 00 00 e8 	movl   $0xbe8,0xbe8
 8b7:	0b 00 00 
    base.s.size = 0;
 8ba:	b8 e8 0b 00 00       	mov    $0xbe8,%eax
 8bf:	c7 05 ec 0b 00 00 00 	movl   $0x0,0xbec
 8c6:	00 00 00 
 8c9:	e9 3e ff ff ff       	jmp    80c <malloc+0x2c>
