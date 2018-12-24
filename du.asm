
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
  1c:	68 50 09 00 00       	push   $0x950
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
  21:	89 85 c4 fb ff ff    	mov    %eax,-0x43c(%ebp)


	int fd = open("UserList", O_RDONLY);
  27:	e8 d6 04 00 00       	call   502 <open>
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
  3e:	e8 97 04 00 00       	call   4da <read>
  43:	89 c6                	mov    %eax,%esi
	close(fd);
  45:	89 1c 24             	mov    %ebx,(%esp)
  48:	e8 9d 04 00 00       	call   4ea <close>
	if(checkReadFile < 0)
  4d:	83 c4 10             	add    $0x10,%esp
  50:	85 f6                	test   %esi,%esi
  52:	0f 88 fd 01 00 00    	js     255 <main+0x255>
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		if (strcmp(argv[1],"Admin")==0)
  58:	8b 85 c4 fb ff ff    	mov    -0x43c(%ebp),%eax
  5e:	83 ec 08             	sub    $0x8,%esp
  61:	68 6f 09 00 00       	push   $0x96f
  66:	ff 70 04             	pushl  0x4(%eax)
  69:	e8 42 02 00 00       	call   2b0 <strcmp>
  6e:	83 c4 10             	add    $0x10,%esp
  71:	85 c0                	test   %eax,%eax
  73:	0f 84 ef 01 00 00    	je     268 <main+0x268>
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
  9c:	0f 84 57 01 00 00    	je     1f9 <main+0x1f9>
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
  c5:	0f 84 25 01 00 00    	je     1f0 <main+0x1f0>
  cb:	3a 85 c8 fb ff ff    	cmp    -0x438(%ebp),%al
  d1:	0f 85 19 01 00 00    	jne    1f0 <main+0x1f0>
  d7:	8d 43 01             	lea    0x1(%ebx),%eax
  da:	01 d3                	add    %edx,%ebx
  dc:	8d 95 c8 fb ff ff    	lea    -0x438(%ebp),%edx
  e2:	eb 1a                	jmp    fe <main+0xfe>
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  e8:	0f b6 08             	movzbl (%eax),%ecx
  eb:	84 c9                	test   %cl,%cl
  ed:	0f 84 fd 00 00 00    	je     1f0 <main+0x1f0>
  f3:	83 c0 01             	add    $0x1,%eax
  f6:	3a 0a                	cmp    (%edx),%cl
  f8:	0f 85 f2 00 00 00    	jne    1f0 <main+0x1f0>
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
 121:	8d 56 01             	lea    0x1(%esi),%edx
 124:	8d 4e 02             	lea    0x2(%esi),%ecx
 127:	0f b6 84 15 e8 fb ff 	movzbl -0x418(%ebp,%edx,1),%eax
 12e:	ff 
						while (buf[i] != ':')	
 12f:	3c 3a                	cmp    $0x3a,%al
 131:	74 30                	je     163 <main+0x163>
						{
							int k = i;
							while (buf[k] != '\0')
 133:	84 c0                	test   %al,%al
 135:	0f 84 40 01 00 00    	je     27b <main+0x27b>
 13b:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 141:	01 c8                	add    %ecx,%eax
 143:	90                   	nop
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
							{
								buf[k] = buf[k+1];
 148:	0f b6 18             	movzbl (%eax),%ebx
 14b:	83 c0 01             	add    $0x1,%eax
 14e:	88 58 fe             	mov    %bl,-0x2(%eax)
							i--;
						i++;
						while (buf[i] != ':')	
						{
							int k = i;
							while (buf[k] != '\0')
 151:	80 78 ff 00          	cmpb   $0x0,-0x1(%eax)
 155:	75 f1                	jne    148 <main+0x148>
 157:	0f b6 84 15 e8 fb ff 	movzbl -0x418(%ebp,%edx,1),%eax
 15e:	ff 
						nameFound = 1;	
						i-=2;
						while (buf[i] != ':' && i > 0)  // return to the last ':'
							i--;
						i++;
						while (buf[i] != ':')	
 15f:	3c 3a                	cmp    $0x3a,%al
 161:	75 d0                	jne    133 <main+0x133>
 163:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 169:	01 c1                	add    %eax,%ecx
 16b:	89 cb                	mov    %ecx,%ebx
 16d:	8d 76 00             	lea    0x0(%esi),%esi
						}
						int k = i;
						// delete ':'
						while (buf[k] != '\0')
						{
							buf[k] = buf[k+1];
 170:	0f b6 03             	movzbl (%ebx),%eax
 173:	83 c3 01             	add    $0x1,%ebx
 176:	88 43 fe             	mov    %al,-0x2(%ebx)
							}	
		
						}
						int k = i;
						// delete ':'
						while (buf[k] != '\0')
 179:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
 17d:	75 f1                	jne    170 <main+0x170>
 17f:	0f b6 84 15 e8 fb ff 	movzbl -0x418(%ebp,%edx,1),%eax
 186:	ff 
						{
							buf[k] = buf[k+1];
							k++;
						}
						while (buf[i] != ':')	
 187:	3c 3a                	cmp    $0x3a,%al
 189:	74 28                	je     1b3 <main+0x1b3>
						{
							int k = i;
							while (buf[k] != '\0')
 18b:	84 c0                	test   %al,%al
 18d:	0f 84 ea 00 00 00    	je     27d <main+0x27d>
 193:	89 c8                	mov    %ecx,%eax
 195:	8d 76 00             	lea    0x0(%esi),%esi
							{
								buf[k] = buf[k+1];
 198:	0f b6 18             	movzbl (%eax),%ebx
 19b:	83 c0 01             	add    $0x1,%eax
 19e:	88 58 fe             	mov    %bl,-0x2(%eax)
							k++;
						}
						while (buf[i] != ':')	
						{
							int k = i;
							while (buf[k] != '\0')
 1a1:	80 78 ff 00          	cmpb   $0x0,-0x1(%eax)
 1a5:	75 f1                	jne    198 <main+0x198>
 1a7:	0f b6 84 15 e8 fb ff 	movzbl -0x418(%ebp,%edx,1),%eax
 1ae:	ff 
						while (buf[k] != '\0')
						{
							buf[k] = buf[k+1];
							k++;
						}
						while (buf[i] != ':')	
 1af:	3c 3a                	cmp    $0x3a,%al
 1b1:	75 d8                	jne    18b <main+0x18b>
		
						}
						i--;
						// delete ':'
						k = i;
						while (buf[k] != '\0')
 1b3:	80 bc 35 e8 fb ff ff 	cmpb   $0x0,-0x418(%ebp,%esi,1)
 1ba:	00 
 1bb:	74 1a                	je     1d7 <main+0x1d7>
 1bd:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 1c3:	01 c2                	add    %eax,%edx
 1c5:	8d 76 00             	lea    0x0(%esi),%esi
						{
							buf[k] = buf[k+1];
 1c8:	0f b6 02             	movzbl (%edx),%eax
 1cb:	83 c2 01             	add    $0x1,%edx
 1ce:	88 42 fe             	mov    %al,-0x2(%edx)
		
						}
						i--;
						// delete ':'
						k = i;
						while (buf[k] != '\0')
 1d1:	80 7a ff 00          	cmpb   $0x0,-0x1(%edx)
 1d5:	75 f1                	jne    1c8 <main+0x1c8>
				j++;
			}

		}while (c != '\0');
		if (nameFound == 1)
			printf(1,"User deleted\n");
 1d7:	52                   	push   %edx
 1d8:	52                   	push   %edx
 1d9:	68 8a 09 00 00       	push   $0x98a
 1de:	6a 01                	push   $0x1
 1e0:	e8 4b 04 00 00       	call   630 <printf>
 1e5:	83 c4 10             	add    $0x10,%esp
 1e8:	eb 20                	jmp    20a <main+0x20a>
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f0:	31 d2                	xor    %edx,%edx
 1f2:	89 fe                	mov    %edi,%esi
 1f4:	e9 ab fe ff ff       	jmp    a4 <main+0xa4>
		else
			printf(1,"User name not found\n");
 1f9:	50                   	push   %eax
 1fa:	50                   	push   %eax
 1fb:	68 98 09 00 00       	push   $0x998
 200:	6a 01                	push   $0x1
 202:	e8 29 04 00 00       	call   630 <printf>
 207:	83 c4 10             	add    $0x10,%esp
		}
		
	}
	fd = open("UserList", O_RDWR);
 20a:	83 ec 08             	sub    $0x8,%esp
 20d:	6a 02                	push   $0x2
 20f:	68 50 09 00 00       	push   $0x950
 214:	e8 e9 02 00 00       	call   502 <open>
	if(fd >= 0)
 219:	83 c4 10             	add    $0x10,%esp
 21c:	85 c0                	test   %eax,%eax
		else
			printf(1,"User name not found\n");
		}
		
	}
	fd = open("UserList", O_RDWR);
 21e:	89 c3                	mov    %eax,%ebx
	if(fd >= 0)
 220:	78 2e                	js     250 <main+0x250>
	{
		write(fd,buf,strlen(buf)+1);
 222:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 228:	83 ec 0c             	sub    $0xc,%esp
 22b:	50                   	push   %eax
 22c:	e8 cf 00 00 00       	call   300 <strlen>
 231:	83 c4 0c             	add    $0xc,%esp
 234:	83 c0 01             	add    $0x1,%eax
 237:	50                   	push   %eax
 238:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	53                   	push   %ebx
 240:	e8 9d 02 00 00       	call   4e2 <write>
		close(fd);		
 245:	89 1c 24             	mov    %ebx,(%esp)
 248:	e8 9d 02 00 00       	call   4ea <close>
 24d:	83 c4 10             	add    $0x10,%esp
	}
		
	
	exit();
 250:	e8 6d 02 00 00       	call   4c2 <exit>
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	close(fd);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
 255:	53                   	push   %ebx
 256:	53                   	push   %ebx
 257:	68 59 09 00 00       	push   $0x959
 25c:	6a 01                	push   $0x1
 25e:	e8 cd 03 00 00       	call   630 <printf>
 263:	83 c4 10             	add    $0x10,%esp
 266:	eb a2                	jmp    20a <main+0x20a>
	}
	else
	{
		if (strcmp(argv[1],"Admin")==0)
		{
			printf(1,"Cannot delete Admin\n");
 268:	51                   	push   %ecx
 269:	51                   	push   %ecx
 26a:	68 75 09 00 00       	push   $0x975
 26f:	6a 01                	push   $0x1
 271:	e8 ba 03 00 00       	call   630 <printf>
 276:	83 c4 10             	add    $0x10,%esp
 279:	eb 8f                	jmp    20a <main+0x20a>
 27b:	eb fe                	jmp    27b <main+0x27b>
 27d:	eb fe                	jmp    27d <main+0x27d>
 27f:	90                   	nop

00000280 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 28a:	89 c2                	mov    %eax,%edx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 290:	83 c1 01             	add    $0x1,%ecx
 293:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 297:	83 c2 01             	add    $0x1,%edx
 29a:	84 db                	test   %bl,%bl
 29c:	88 5a ff             	mov    %bl,-0x1(%edx)
 29f:	75 ef                	jne    290 <strcpy+0x10>
    ;
  return os;
}
 2a1:	5b                   	pop    %ebx
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 55 08             	mov    0x8(%ebp),%edx
 2b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2bb:	0f b6 02             	movzbl (%edx),%eax
 2be:	0f b6 19             	movzbl (%ecx),%ebx
 2c1:	84 c0                	test   %al,%al
 2c3:	75 1e                	jne    2e3 <strcmp+0x33>
 2c5:	eb 29                	jmp    2f0 <strcmp+0x40>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2dd:	84 c0                	test   %al,%al
 2df:	74 0f                	je     2f0 <strcmp+0x40>
 2e1:	89 f1                	mov    %esi,%ecx
 2e3:	38 d8                	cmp    %bl,%al
 2e5:	74 e9                	je     2d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2e7:	29 d8                	sub    %ebx,%eax
}
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2f2:	29 d8                	sub    %ebx,%eax
}
 2f4:	5b                   	pop    %ebx
 2f5:	5e                   	pop    %esi
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	90                   	nop
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <strlen>:

uint
strlen(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 306:	80 39 00             	cmpb   $0x0,(%ecx)
 309:	74 12                	je     31d <strlen+0x1d>
 30b:	31 d2                	xor    %edx,%edx
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	83 c2 01             	add    $0x1,%edx
 313:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 317:	89 d0                	mov    %edx,%eax
 319:	75 f5                	jne    310 <strlen+0x10>
    ;
  return n;
}
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 31d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 31f:	5d                   	pop    %ebp
 320:	c3                   	ret    
 321:	eb 0d                	jmp    330 <memset>
 323:	90                   	nop
 324:	90                   	nop
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop
 328:	90                   	nop
 329:	90                   	nop
 32a:	90                   	nop
 32b:	90                   	nop
 32c:	90                   	nop
 32d:	90                   	nop
 32e:	90                   	nop
 32f:	90                   	nop

00000330 <memset>:

void*
memset(void *dst, int c, uint n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 337:	8b 4d 10             	mov    0x10(%ebp),%ecx
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 d7                	mov    %edx,%edi
 33f:	fc                   	cld    
 340:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 342:	89 d0                	mov    %edx,%eax
 344:	5f                   	pop    %edi
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <strchr>:

char*
strchr(const char *s, char c)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 35a:	0f b6 10             	movzbl (%eax),%edx
 35d:	84 d2                	test   %dl,%dl
 35f:	74 1d                	je     37e <strchr+0x2e>
    if(*s == c)
 361:	38 d3                	cmp    %dl,%bl
 363:	89 d9                	mov    %ebx,%ecx
 365:	75 0d                	jne    374 <strchr+0x24>
 367:	eb 17                	jmp    380 <strchr+0x30>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 370:	38 ca                	cmp    %cl,%dl
 372:	74 0c                	je     380 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 374:	83 c0 01             	add    $0x1,%eax
 377:	0f b6 10             	movzbl (%eax),%edx
 37a:	84 d2                	test   %dl,%dl
 37c:	75 f2                	jne    370 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 37e:	31 c0                	xor    %eax,%eax
}
 380:	5b                   	pop    %ebx
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
 383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <gets>:

char*
gets(char *buf, int max)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 398:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 39b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39e:	eb 29                	jmp    3c9 <gets+0x39>
    cc = read(0, &c, 1);
 3a0:	83 ec 04             	sub    $0x4,%esp
 3a3:	6a 01                	push   $0x1
 3a5:	57                   	push   %edi
 3a6:	6a 00                	push   $0x0
 3a8:	e8 2d 01 00 00       	call   4da <read>
    if(cc < 1)
 3ad:	83 c4 10             	add    $0x10,%esp
 3b0:	85 c0                	test   %eax,%eax
 3b2:	7e 1d                	jle    3d1 <gets+0x41>
      break;
    buf[i++] = c;
 3b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3b8:	8b 55 08             	mov    0x8(%ebp),%edx
 3bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3c3:	74 1b                	je     3e0 <gets+0x50>
 3c5:	3c 0d                	cmp    $0xd,%al
 3c7:	74 17                	je     3e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3cf:	7c cf                	jl     3a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3db:	5b                   	pop    %ebx
 3dc:	5e                   	pop    %esi
 3dd:	5f                   	pop    %edi
 3de:	5d                   	pop    %ebp
 3df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5f                   	pop    %edi
 3ef:	5d                   	pop    %ebp
 3f0:	c3                   	ret    
 3f1:	eb 0d                	jmp    400 <stat>
 3f3:	90                   	nop
 3f4:	90                   	nop
 3f5:	90                   	nop
 3f6:	90                   	nop
 3f7:	90                   	nop
 3f8:	90                   	nop
 3f9:	90                   	nop
 3fa:	90                   	nop
 3fb:	90                   	nop
 3fc:	90                   	nop
 3fd:	90                   	nop
 3fe:	90                   	nop
 3ff:	90                   	nop

00000400 <stat>:

int
stat(const char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 405:	83 ec 08             	sub    $0x8,%esp
 408:	6a 00                	push   $0x0
 40a:	ff 75 08             	pushl  0x8(%ebp)
 40d:	e8 f0 00 00 00       	call   502 <open>
  if(fd < 0)
 412:	83 c4 10             	add    $0x10,%esp
 415:	85 c0                	test   %eax,%eax
 417:	78 27                	js     440 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 419:	83 ec 08             	sub    $0x8,%esp
 41c:	ff 75 0c             	pushl  0xc(%ebp)
 41f:	89 c3                	mov    %eax,%ebx
 421:	50                   	push   %eax
 422:	e8 f3 00 00 00       	call   51a <fstat>
 427:	89 c6                	mov    %eax,%esi
  close(fd);
 429:	89 1c 24             	mov    %ebx,(%esp)
 42c:	e8 b9 00 00 00       	call   4ea <close>
  return r;
 431:	83 c4 10             	add    $0x10,%esp
 434:	89 f0                	mov    %esi,%eax
}
 436:	8d 65 f8             	lea    -0x8(%ebp),%esp
 439:	5b                   	pop    %ebx
 43a:	5e                   	pop    %esi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 445:	eb ef                	jmp    436 <stat+0x36>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 457:	0f be 11             	movsbl (%ecx),%edx
 45a:	8d 42 d0             	lea    -0x30(%edx),%eax
 45d:	3c 09                	cmp    $0x9,%al
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
 464:	77 1f                	ja     485 <atoi+0x35>
 466:	8d 76 00             	lea    0x0(%esi),%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 470:	8d 04 80             	lea    (%eax,%eax,4),%eax
 473:	83 c1 01             	add    $0x1,%ecx
 476:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 47a:	0f be 11             	movsbl (%ecx),%edx
 47d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 480:	80 fb 09             	cmp    $0x9,%bl
 483:	76 eb                	jbe    470 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 485:	5b                   	pop    %ebx
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	56                   	push   %esi
 494:	53                   	push   %ebx
 495:	8b 5d 10             	mov    0x10(%ebp),%ebx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 49e:	85 db                	test   %ebx,%ebx
 4a0:	7e 14                	jle    4b6 <memmove+0x26>
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4af:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4b2:	39 da                	cmp    %ebx,%edx
 4b4:	75 f2                	jne    4a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    

000004ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ba:	b8 01 00 00 00       	mov    $0x1,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <exit>:
SYSCALL(exit)
 4c2:	b8 02 00 00 00       	mov    $0x2,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <wait>:
SYSCALL(wait)
 4ca:	b8 03 00 00 00       	mov    $0x3,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <pipe>:
SYSCALL(pipe)
 4d2:	b8 04 00 00 00       	mov    $0x4,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <read>:
SYSCALL(read)
 4da:	b8 05 00 00 00       	mov    $0x5,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <write>:
SYSCALL(write)
 4e2:	b8 10 00 00 00       	mov    $0x10,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <close>:
SYSCALL(close)
 4ea:	b8 15 00 00 00       	mov    $0x15,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kill>:
SYSCALL(kill)
 4f2:	b8 06 00 00 00       	mov    $0x6,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <exec>:
SYSCALL(exec)
 4fa:	b8 07 00 00 00       	mov    $0x7,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <open>:
SYSCALL(open)
 502:	b8 0f 00 00 00       	mov    $0xf,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mknod>:
SYSCALL(mknod)
 50a:	b8 11 00 00 00       	mov    $0x11,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <unlink>:
SYSCALL(unlink)
 512:	b8 12 00 00 00       	mov    $0x12,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <fstat>:
SYSCALL(fstat)
 51a:	b8 08 00 00 00       	mov    $0x8,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <link>:
SYSCALL(link)
 522:	b8 13 00 00 00       	mov    $0x13,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <mkdir>:
SYSCALL(mkdir)
 52a:	b8 14 00 00 00       	mov    $0x14,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <chdir>:
SYSCALL(chdir)
 532:	b8 09 00 00 00       	mov    $0x9,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <dup>:
SYSCALL(dup)
 53a:	b8 0a 00 00 00       	mov    $0xa,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <getpid>:
SYSCALL(getpid)
 542:	b8 0b 00 00 00       	mov    $0xb,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <sbrk>:
SYSCALL(sbrk)
 54a:	b8 0c 00 00 00       	mov    $0xc,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <sleep>:
SYSCALL(sleep)
 552:	b8 0d 00 00 00       	mov    $0xd,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <uptime>:
SYSCALL(uptime)
 55a:	b8 0e 00 00 00       	mov    $0xe,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <cps>:
SYSCALL(cps)
 562:	b8 16 00 00 00       	mov    $0x16,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <userTag>:
SYSCALL(userTag)
 56a:	b8 17 00 00 00       	mov    $0x17,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <changeUser>:
SYSCALL(changeUser)
 572:	b8 18 00 00 00       	mov    $0x18,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <getUser>:
SYSCALL(getUser)
 57a:	b8 19 00 00 00       	mov    $0x19,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <changeOwner>:
SYSCALL(changeOwner)
 582:	b8 1a 00 00 00       	mov    $0x1a,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    
 58a:	66 90                	xchg   %ax,%ax
 58c:	66 90                	xchg   %ax,%ax
 58e:	66 90                	xchg   %ax,%ax

00000590 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	89 c6                	mov    %eax,%esi
 598:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 59e:	85 db                	test   %ebx,%ebx
 5a0:	74 7e                	je     620 <printint+0x90>
 5a2:	89 d0                	mov    %edx,%eax
 5a4:	c1 e8 1f             	shr    $0x1f,%eax
 5a7:	84 c0                	test   %al,%al
 5a9:	74 75                	je     620 <printint+0x90>
    neg = 1;
    x = -xx;
 5ab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5ad:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5b4:	f7 d8                	neg    %eax
 5b6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5b9:	31 ff                	xor    %edi,%edi
 5bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5be:	89 ce                	mov    %ecx,%esi
 5c0:	eb 08                	jmp    5ca <printint+0x3a>
 5c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5c8:	89 cf                	mov    %ecx,%edi
 5ca:	31 d2                	xor    %edx,%edx
 5cc:	8d 4f 01             	lea    0x1(%edi),%ecx
 5cf:	f7 f6                	div    %esi
 5d1:	0f b6 92 b4 09 00 00 	movzbl 0x9b4(%edx),%edx
  }while((x /= base) != 0);
 5d8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5da:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5dd:	75 e9                	jne    5c8 <printint+0x38>
  if(neg)
 5df:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5e2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5e5:	85 c0                	test   %eax,%eax
 5e7:	74 08                	je     5f1 <printint+0x61>
    buf[i++] = '-';
 5e9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5ee:	8d 4f 02             	lea    0x2(%edi),%ecx
 5f1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5f5:	8d 76 00             	lea    0x0(%esi),%esi
 5f8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fb:	83 ec 04             	sub    $0x4,%esp
 5fe:	83 ef 01             	sub    $0x1,%edi
 601:	6a 01                	push   $0x1
 603:	53                   	push   %ebx
 604:	56                   	push   %esi
 605:	88 45 d7             	mov    %al,-0x29(%ebp)
 608:	e8 d5 fe ff ff       	call   4e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 60d:	83 c4 10             	add    $0x10,%esp
 610:	39 df                	cmp    %ebx,%edi
 612:	75 e4                	jne    5f8 <printint+0x68>
    putc(fd, buf[i]);
}
 614:	8d 65 f4             	lea    -0xc(%ebp),%esp
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret    
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 620:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 622:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 629:	eb 8b                	jmp    5b6 <printint+0x26>
 62b:	90                   	nop
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000630 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
 634:	56                   	push   %esi
 635:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 636:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 639:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 63f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 642:	89 45 d0             	mov    %eax,-0x30(%ebp)
 645:	0f b6 1e             	movzbl (%esi),%ebx
 648:	83 c6 01             	add    $0x1,%esi
 64b:	84 db                	test   %bl,%bl
 64d:	0f 84 b0 00 00 00    	je     703 <printf+0xd3>
 653:	31 d2                	xor    %edx,%edx
 655:	eb 39                	jmp    690 <printf+0x60>
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 660:	83 f8 25             	cmp    $0x25,%eax
 663:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 666:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 66b:	74 18                	je     685 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 670:	83 ec 04             	sub    $0x4,%esp
 673:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 676:	6a 01                	push   $0x1
 678:	50                   	push   %eax
 679:	57                   	push   %edi
 67a:	e8 63 fe ff ff       	call   4e2 <write>
 67f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 682:	83 c4 10             	add    $0x10,%esp
 685:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 688:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 68c:	84 db                	test   %bl,%bl
 68e:	74 73                	je     703 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 690:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 692:	0f be cb             	movsbl %bl,%ecx
 695:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 698:	74 c6                	je     660 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 69a:	83 fa 25             	cmp    $0x25,%edx
 69d:	75 e6                	jne    685 <printf+0x55>
      if(c == 'd'){
 69f:	83 f8 64             	cmp    $0x64,%eax
 6a2:	0f 84 f8 00 00 00    	je     7a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6a8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6ae:	83 f9 70             	cmp    $0x70,%ecx
 6b1:	74 5d                	je     710 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6b3:	83 f8 73             	cmp    $0x73,%eax
 6b6:	0f 84 84 00 00 00    	je     740 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bc:	83 f8 63             	cmp    $0x63,%eax
 6bf:	0f 84 ea 00 00 00    	je     7af <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6c5:	83 f8 25             	cmp    $0x25,%eax
 6c8:	0f 84 c2 00 00 00    	je     790 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6d1:	83 ec 04             	sub    $0x4,%esp
 6d4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6d8:	6a 01                	push   $0x1
 6da:	50                   	push   %eax
 6db:	57                   	push   %edi
 6dc:	e8 01 fe ff ff       	call   4e2 <write>
 6e1:	83 c4 0c             	add    $0xc,%esp
 6e4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6e7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ea:	6a 01                	push   $0x1
 6ec:	50                   	push   %eax
 6ed:	57                   	push   %edi
 6ee:	83 c6 01             	add    $0x1,%esi
 6f1:	e8 ec fd ff ff       	call   4e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6f6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6fa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ff:	84 db                	test   %bl,%bl
 701:	75 8d                	jne    690 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 703:	8d 65 f4             	lea    -0xc(%ebp),%esp
 706:	5b                   	pop    %ebx
 707:	5e                   	pop    %esi
 708:	5f                   	pop    %edi
 709:	5d                   	pop    %ebp
 70a:	c3                   	ret    
 70b:	90                   	nop
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 10 00 00 00       	mov    $0x10,%ecx
 718:	6a 00                	push   $0x0
 71a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 71d:	89 f8                	mov    %edi,%eax
 71f:	8b 13                	mov    (%ebx),%edx
 721:	e8 6a fe ff ff       	call   590 <printint>
        ap++;
 726:	89 d8                	mov    %ebx,%eax
 728:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 72b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 72d:	83 c0 04             	add    $0x4,%eax
 730:	89 45 d0             	mov    %eax,-0x30(%ebp)
 733:	e9 4d ff ff ff       	jmp    685 <printf+0x55>
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 740:	8b 45 d0             	mov    -0x30(%ebp),%eax
 743:	8b 18                	mov    (%eax),%ebx
        ap++;
 745:	83 c0 04             	add    $0x4,%eax
 748:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 74b:	b8 ad 09 00 00       	mov    $0x9ad,%eax
 750:	85 db                	test   %ebx,%ebx
 752:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 755:	0f b6 03             	movzbl (%ebx),%eax
 758:	84 c0                	test   %al,%al
 75a:	74 23                	je     77f <printf+0x14f>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 760:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 763:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 766:	83 ec 04             	sub    $0x4,%esp
 769:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 76b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 76e:	50                   	push   %eax
 76f:	57                   	push   %edi
 770:	e8 6d fd ff ff       	call   4e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 775:	0f b6 03             	movzbl (%ebx),%eax
 778:	83 c4 10             	add    $0x10,%esp
 77b:	84 c0                	test   %al,%al
 77d:	75 e1                	jne    760 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 77f:	31 d2                	xor    %edx,%edx
 781:	e9 ff fe ff ff       	jmp    685 <printf+0x55>
 786:	8d 76 00             	lea    0x0(%esi),%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 790:	83 ec 04             	sub    $0x4,%esp
 793:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 796:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 799:	6a 01                	push   $0x1
 79b:	e9 4c ff ff ff       	jmp    6ec <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7a0:	83 ec 0c             	sub    $0xc,%esp
 7a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7a8:	6a 01                	push   $0x1
 7aa:	e9 6b ff ff ff       	jmp    71a <printf+0xea>
 7af:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7b2:	83 ec 04             	sub    $0x4,%esp
 7b5:	8b 03                	mov    (%ebx),%eax
 7b7:	6a 01                	push   $0x1
 7b9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 7bc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7bf:	50                   	push   %eax
 7c0:	57                   	push   %edi
 7c1:	e8 1c fd ff ff       	call   4e2 <write>
 7c6:	e9 5b ff ff ff       	jmp    726 <printf+0xf6>
 7cb:	66 90                	xchg   %ax,%ax
 7cd:	66 90                	xchg   %ax,%ax
 7cf:	90                   	nop

000007d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d1:	a1 58 0c 00 00       	mov    0xc58,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7d6:	89 e5                	mov    %esp,%ebp
 7d8:	57                   	push   %edi
 7d9:	56                   	push   %esi
 7da:	53                   	push   %ebx
 7db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7de:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7e0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e3:	39 c8                	cmp    %ecx,%eax
 7e5:	73 19                	jae    800 <free+0x30>
 7e7:	89 f6                	mov    %esi,%esi
 7e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7f0:	39 d1                	cmp    %edx,%ecx
 7f2:	72 1c                	jb     810 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f4:	39 d0                	cmp    %edx,%eax
 7f6:	73 18                	jae    810 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7fe:	72 f0                	jb     7f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 800:	39 d0                	cmp    %edx,%eax
 802:	72 f4                	jb     7f8 <free+0x28>
 804:	39 d1                	cmp    %edx,%ecx
 806:	73 f0                	jae    7f8 <free+0x28>
 808:	90                   	nop
 809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 810:	8b 73 fc             	mov    -0x4(%ebx),%esi
 813:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 816:	39 d7                	cmp    %edx,%edi
 818:	74 19                	je     833 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 81a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 81d:	8b 50 04             	mov    0x4(%eax),%edx
 820:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 823:	39 f1                	cmp    %esi,%ecx
 825:	74 23                	je     84a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 827:	89 08                	mov    %ecx,(%eax)
  freep = p;
 829:	a3 58 0c 00 00       	mov    %eax,0xc58
}
 82e:	5b                   	pop    %ebx
 82f:	5e                   	pop    %esi
 830:	5f                   	pop    %edi
 831:	5d                   	pop    %ebp
 832:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 833:	03 72 04             	add    0x4(%edx),%esi
 836:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 839:	8b 10                	mov    (%eax),%edx
 83b:	8b 12                	mov    (%edx),%edx
 83d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 840:	8b 50 04             	mov    0x4(%eax),%edx
 843:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 846:	39 f1                	cmp    %esi,%ecx
 848:	75 dd                	jne    827 <free+0x57>
    p->s.size += bp->s.size;
 84a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 84d:	a3 58 0c 00 00       	mov    %eax,0xc58
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 852:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 855:	8b 53 f8             	mov    -0x8(%ebx),%edx
 858:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 85a:	5b                   	pop    %ebx
 85b:	5e                   	pop    %esi
 85c:	5f                   	pop    %edi
 85d:	5d                   	pop    %ebp
 85e:	c3                   	ret    
 85f:	90                   	nop

00000860 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 860:	55                   	push   %ebp
 861:	89 e5                	mov    %esp,%ebp
 863:	57                   	push   %edi
 864:	56                   	push   %esi
 865:	53                   	push   %ebx
 866:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 869:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 86c:	8b 15 58 0c 00 00    	mov    0xc58,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 872:	8d 78 07             	lea    0x7(%eax),%edi
 875:	c1 ef 03             	shr    $0x3,%edi
 878:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 87b:	85 d2                	test   %edx,%edx
 87d:	0f 84 a3 00 00 00    	je     926 <malloc+0xc6>
 883:	8b 02                	mov    (%edx),%eax
 885:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 888:	39 cf                	cmp    %ecx,%edi
 88a:	76 74                	jbe    900 <malloc+0xa0>
 88c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 892:	be 00 10 00 00       	mov    $0x1000,%esi
 897:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 89e:	0f 43 f7             	cmovae %edi,%esi
 8a1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8a6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8ac:	0f 46 da             	cmovbe %edx,%ebx
 8af:	eb 10                	jmp    8c1 <malloc+0x61>
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ba:	8b 48 04             	mov    0x4(%eax),%ecx
 8bd:	39 cf                	cmp    %ecx,%edi
 8bf:	76 3f                	jbe    900 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c1:	39 05 58 0c 00 00    	cmp    %eax,0xc58
 8c7:	89 c2                	mov    %eax,%edx
 8c9:	75 ed                	jne    8b8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8cb:	83 ec 0c             	sub    $0xc,%esp
 8ce:	53                   	push   %ebx
 8cf:	e8 76 fc ff ff       	call   54a <sbrk>
  if(p == (char*)-1)
 8d4:	83 c4 10             	add    $0x10,%esp
 8d7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8da:	74 1c                	je     8f8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8dc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8df:	83 ec 0c             	sub    $0xc,%esp
 8e2:	83 c0 08             	add    $0x8,%eax
 8e5:	50                   	push   %eax
 8e6:	e8 e5 fe ff ff       	call   7d0 <free>
  return freep;
 8eb:	8b 15 58 0c 00 00    	mov    0xc58,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8f1:	83 c4 10             	add    $0x10,%esp
 8f4:	85 d2                	test   %edx,%edx
 8f6:	75 c0                	jne    8b8 <malloc+0x58>
        return 0;
 8f8:	31 c0                	xor    %eax,%eax
 8fa:	eb 1c                	jmp    918 <malloc+0xb8>
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 900:	39 cf                	cmp    %ecx,%edi
 902:	74 1c                	je     920 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 904:	29 f9                	sub    %edi,%ecx
 906:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 909:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 90c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 90f:	89 15 58 0c 00 00    	mov    %edx,0xc58
      return (void*)(p + 1);
 915:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 918:	8d 65 f4             	lea    -0xc(%ebp),%esp
 91b:	5b                   	pop    %ebx
 91c:	5e                   	pop    %esi
 91d:	5f                   	pop    %edi
 91e:	5d                   	pop    %ebp
 91f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 920:	8b 08                	mov    (%eax),%ecx
 922:	89 0a                	mov    %ecx,(%edx)
 924:	eb e9                	jmp    90f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 926:	c7 05 58 0c 00 00 5c 	movl   $0xc5c,0xc58
 92d:	0c 00 00 
 930:	c7 05 5c 0c 00 00 5c 	movl   $0xc5c,0xc5c
 937:	0c 00 00 
    base.s.size = 0;
 93a:	b8 5c 0c 00 00       	mov    $0xc5c,%eax
 93f:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 946:	00 00 00 
 949:	e9 3e ff ff ff       	jmp    88c <malloc+0x2c>
