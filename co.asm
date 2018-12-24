
_co:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// example app call custom system call
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
  11:	81 ec a0 04 00 00    	sub    $0x4a0,%esp
  17:	8b 41 04             	mov    0x4(%ecx),%eax


	int co = changeOwner(argv[1], argv[2]);
  1a:	ff 70 08             	pushl  0x8(%eax)
  1d:	ff 70 04             	pushl  0x4(%eax)
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// example app call custom system call
int main(int argc, char *argv[])
{
  20:	89 85 6c fb ff ff    	mov    %eax,-0x494(%ebp)


	int co = changeOwner(argv[1], argv[2]);
  26:	e8 77 06 00 00       	call   6a2 <changeOwner>
	if(co == 0)
  2b:	83 c4 10             	add    $0x10,%esp
  2e:	85 c0                	test   %eax,%eax
  30:	74 05                	je     37 <main+0x37>
			}
		close(fd);
		}
		
	}
	exit();
  32:	e8 ab 05 00 00       	call   5e2 <exit>


	int co = changeOwner(argv[1], argv[2]);
	if(co == 0)
	{
		int fd = open("FileAppendix", O_RDONLY);
  37:	50                   	push   %eax
  38:	50                   	push   %eax
  39:	6a 00                	push   $0x0
  3b:	68 70 0a 00 00       	push   $0xa70
  40:	e8 dd 05 00 00       	call   622 <open>
		if(fd >= 0)
  45:	83 c4 10             	add    $0x10,%esp
  48:	85 c0                	test   %eax,%eax


	int co = changeOwner(argv[1], argv[2]);
	if(co == 0)
	{
		int fd = open("FileAppendix", O_RDONLY);
  4a:	89 c6                	mov    %eax,%esi
		if(fd >= 0)
  4c:	78 e4                	js     32 <main+0x32>
		{
			char buf[1024];
			int n = read(fd, buf, sizeof buf);
  4e:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
  54:	57                   	push   %edi
  55:	68 00 04 00 00       	push   $0x400
  5a:	50                   	push   %eax
  5b:	56                   	push   %esi
  5c:	89 85 74 fb ff ff    	mov    %eax,-0x48c(%ebp)
  62:	e8 93 05 00 00       	call   5fa <read>
  67:	89 c7                	mov    %eax,%edi
			close(fd);
  69:	89 34 24             	mov    %esi,(%esp)
  6c:	e8 99 05 00 00       	call   60a <close>
			if(n >= 0)
  71:	83 c4 10             	add    $0x10,%esp
  74:	85 ff                	test   %edi,%edi
  76:	0f 88 84 01 00 00    	js     200 <main+0x200>
  7c:	31 c9                	xor    %ecx,%ecx
  7e:	31 f6                	xor    %esi,%esi
				int i = 0; // buffer iterator
				int j = 0; // file name buffer iterator
				int fileOwnerFound = 0;
				do
				{
					c = buf[i];
  80:	0f b6 94 35 e8 fb ff 	movzbl -0x418(%ebp,%esi,1),%edx
  87:	ff 
					i++;
  88:	8d 46 01             	lea    0x1(%esi),%eax
  8b:	89 85 70 fb ff ff    	mov    %eax,-0x490(%ebp)
					if (c == ':')
  91:	80 fa 3a             	cmp    $0x3a,%dl
  94:	0f 84 77 01 00 00    	je     211 <main+0x211>

						j = 0;
					}
					else
					{
						fileNameBuf[j] = c;
  9a:	88 94 0d 88 fb ff ff 	mov    %dl,-0x478(%ebp,%ecx,1)
						j++;
  a1:	83 c1 01             	add    $0x1,%ecx
					}

				} while (c!='\0');
  a4:	84 d2                	test   %dl,%dl
  a6:	74 04                	je     ac <main+0xac>
							} while (c != ':');
								
							
						}

						j = 0;
  a8:	89 c6                	mov    %eax,%esi
  aa:	eb d4                	jmp    80 <main+0x80>
				if(fileOwnerFound == 0)
				{
					if (buf[i-1] == '\n')
						i--;
					char groupName[8] = "group1";
					int fileNameLen = strlen(argv[1]);
  ac:	8b 9d 6c fb ff ff    	mov    -0x494(%ebp),%ebx
  b2:	83 ec 0c             	sub    $0xc,%esp
				
				if(fileOwnerFound == 0)
				{
					if (buf[i-1] == '\n')
						i--;
					char groupName[8] = "group1";
  b5:	c7 85 80 fb ff ff 67 	movl   $0x756f7267,-0x480(%ebp)
  bc:	72 6f 75 
  bf:	c7 85 84 fb ff ff 70 	movl   $0x3170,-0x47c(%ebp)
  c6:	31 00 00 
					int fileNameLen = strlen(argv[1]);
  c9:	ff 73 04             	pushl  0x4(%ebx)
  cc:	e8 4f 03 00 00       	call   420 <strlen>
  d1:	89 c7                	mov    %eax,%edi
					int ownerNameLen = strlen(argv[2]);
  d3:	58                   	pop    %eax
  d4:	ff 73 08             	pushl  0x8(%ebx)
  d7:	e8 44 03 00 00       	call   420 <strlen>
  dc:	89 85 64 fb ff ff    	mov    %eax,-0x49c(%ebp)
					int groupNameLen = strlen(groupName);
  e2:	8d 85 80 fb ff ff    	lea    -0x480(%ebp),%eax
  e8:	89 04 24             	mov    %eax,(%esp)
  eb:	e8 30 03 00 00       	call   420 <strlen>
					i--;
					int s = 0;
					for (s = 0; s < fileNameLen; s++)
  f0:	83 c4 10             	add    $0x10,%esp
  f3:	85 ff                	test   %edi,%edi
					if (buf[i-1] == '\n')
						i--;
					char groupName[8] = "group1";
					int fileNameLen = strlen(argv[1]);
					int ownerNameLen = strlen(argv[2]);
					int groupNameLen = strlen(groupName);
  f5:	89 85 68 fb ff ff    	mov    %eax,-0x498(%ebp)
					i--;
					int s = 0;
					for (s = 0; s < fileNameLen; s++)
  fb:	7e 35                	jle    132 <main+0x132>
  fd:	8b 85 6c fb ff ff    	mov    -0x494(%ebp),%eax
					{
						buf[i] = argv[1][s];
 103:	8b 95 70 fb ff ff    	mov    -0x490(%ebp),%edx
 109:	03 95 74 fb ff ff    	add    -0x48c(%ebp),%edx
 10f:	8b 48 04             	mov    0x4(%eax),%ecx
					int fileNameLen = strlen(argv[1]);
					int ownerNameLen = strlen(argv[2]);
					int groupNameLen = strlen(groupName);
					i--;
					int s = 0;
					for (s = 0; s < fileNameLen; s++)
 112:	31 c0                	xor    %eax,%eax
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					{
						buf[i] = argv[1][s];
 118:	0f b6 1c 01          	movzbl (%ecx,%eax,1),%ebx
 11c:	88 5c 02 ff          	mov    %bl,-0x1(%edx,%eax,1)
					int fileNameLen = strlen(argv[1]);
					int ownerNameLen = strlen(argv[2]);
					int groupNameLen = strlen(groupName);
					i--;
					int s = 0;
					for (s = 0; s < fileNameLen; s++)
 120:	83 c0 01             	add    $0x1,%eax
 123:	39 c7                	cmp    %eax,%edi
 125:	75 f1                	jne    118 <main+0x118>
 127:	01 fe                	add    %edi,%esi
 129:	8d 46 01             	lea    0x1(%esi),%eax
 12c:	89 85 70 fb ff ff    	mov    %eax,-0x490(%ebp)
						buf[i] = argv[1][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < ownerNameLen; s++)
 132:	8b 9d 64 fb ff ff    	mov    -0x49c(%ebp),%ebx
					for (s = 0; s < fileNameLen; s++)
					{
						buf[i] = argv[1][s];
						i++;
					}
					buf[i] = ':';
 138:	c6 84 35 e8 fb ff ff 	movb   $0x3a,-0x418(%ebp,%esi,1)
 13f:	3a 
					i++;
 140:	8b 85 70 fb ff ff    	mov    -0x490(%ebp),%eax
					for (s = 0; s < ownerNameLen; s++)
 146:	85 db                	test   %ebx,%ebx
 148:	7e 31                	jle    17b <main+0x17b>
 14a:	8b 85 6c fb ff ff    	mov    -0x494(%ebp),%eax
					{
						buf[i] = argv[2][s];
 150:	03 b5 74 fb ff ff    	add    -0x48c(%ebp),%esi
 156:	89 df                	mov    %ebx,%edi
 158:	8b 50 08             	mov    0x8(%eax),%edx
						buf[i] = argv[1][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < ownerNameLen; s++)
 15b:	31 c0                	xor    %eax,%eax
 15d:	8d 76 00             	lea    0x0(%esi),%esi
					{
						buf[i] = argv[2][s];
 160:	0f b6 0c 02          	movzbl (%edx,%eax,1),%ecx
 164:	88 4c 06 01          	mov    %cl,0x1(%esi,%eax,1)
						buf[i] = argv[1][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < ownerNameLen; s++)
 168:	83 c0 01             	add    $0x1,%eax
 16b:	39 c7                	cmp    %eax,%edi
 16d:	75 f1                	jne    160 <main+0x160>
 16f:	8b 85 70 fb ff ff    	mov    -0x490(%ebp),%eax
 175:	03 85 64 fb ff ff    	add    -0x49c(%ebp),%eax
					{
						buf[i] = argv[2][s];
						i++;
					}
					buf[i] = ':';
 17b:	c6 84 05 e8 fb ff ff 	movb   $0x3a,-0x418(%ebp,%eax,1)
 182:	3a 
					i++;
 183:	8d 48 01             	lea    0x1(%eax),%ecx
					for (s = 0; s < groupNameLen; s++)
 186:	31 d2                	xor    %edx,%edx
					{
						buf[i] = groupName[s];
 188:	03 85 74 fb ff ff    	add    -0x48c(%ebp),%eax
						buf[i] = argv[2][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < groupNameLen; s++)
 18e:	eb 0f                	jmp    19f <main+0x19f>
					{
						buf[i] = groupName[s];
 190:	0f b6 9c 15 80 fb ff 	movzbl -0x480(%ebp,%edx,1),%ebx
 197:	ff 
 198:	88 5c 10 01          	mov    %bl,0x1(%eax,%edx,1)
						buf[i] = argv[2][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < groupNameLen; s++)
 19c:	83 c2 01             	add    $0x1,%edx
 19f:	3b 95 68 fb ff ff    	cmp    -0x498(%ebp),%edx
 1a5:	7c e9                	jl     190 <main+0x190>
 1a7:	8b 9d 68 fb ff ff    	mov    -0x498(%ebp),%ebx
 1ad:	b8 00 00 00 00       	mov    $0x0,%eax
 1b2:	85 db                	test   %ebx,%ebx
 1b4:	0f 49 c3             	cmovns %ebx,%eax
 1b7:	01 c1                	add    %eax,%ecx
					{
						buf[i] = groupName[s];
						i++;
					}
					buf[i] = ':';
 1b9:	c6 84 0d e8 fb ff ff 	movb   $0x3a,-0x418(%ebp,%ecx,1)
 1c0:	3a 
					i++;
					buf[i] = '\0';
 1c1:	c6 84 0d e9 fb ff ff 	movb   $0x0,-0x417(%ebp,%ecx,1)
 1c8:	00 
				}
				//printf(1,"buf: %s\n",buf);
				fd = open("FileAppendix", O_RDWR);
 1c9:	56                   	push   %esi
 1ca:	56                   	push   %esi
 1cb:	6a 02                	push   $0x2
 1cd:	68 70 0a 00 00       	push   $0xa70
 1d2:	e8 4b 04 00 00       	call   622 <open>
				if(fd >= 0)
 1d7:	83 c4 10             	add    $0x10,%esp
 1da:	85 c0                	test   %eax,%eax
					buf[i] = ':';
					i++;
					buf[i] = '\0';
				}
				//printf(1,"buf: %s\n",buf);
				fd = open("FileAppendix", O_RDWR);
 1dc:	89 c6                	mov    %eax,%esi
				if(fd >= 0)
 1de:	78 20                	js     200 <main+0x200>
				{
					int m = write(fd, buf, sizeof buf);
 1e0:	53                   	push   %ebx
 1e1:	68 00 04 00 00       	push   $0x400
 1e6:	ff b5 74 fb ff ff    	pushl  -0x48c(%ebp)
 1ec:	50                   	push   %eax
 1ed:	e8 10 04 00 00       	call   602 <write>
					//printf(1, "co: writing: %d %d\n", m, sizeof buf);
					if(m == sizeof buf)
 1f2:	83 c4 10             	add    $0x10,%esp
 1f5:	3d 00 04 00 00       	cmp    $0x400,%eax
 1fa:	0f 84 74 01 00 00    	je     374 <main+0x374>
						close(fd);
						printf(1, "co: File owner changed succeed\n");
					}
				}
			}
		close(fd);
 200:	83 ec 0c             	sub    $0xc,%esp
 203:	56                   	push   %esi
 204:	e8 01 04 00 00       	call   60a <close>
 209:	83 c4 10             	add    $0x10,%esp
 20c:	e9 21 fe ff ff       	jmp    32 <main+0x32>
					i++;
					if (c == ':')
					{
						// got a complete file name
						// compare with argv[1]
						char* k = argv[1];
 211:	8b 9d 6c fb ff ff    	mov    -0x494(%ebp),%ebx
						char* l = fileNameBuf;
						while (j > 0 && *k && *k == *l)
 217:	85 c9                	test   %ecx,%ecx
					i++;
					if (c == ':')
					{
						// got a complete file name
						// compare with argv[1]
						char* k = argv[1];
 219:	8b 7b 04             	mov    0x4(%ebx),%edi
						char* l = fileNameBuf;
						while (j > 0 && *k && *k == *l)
 21c:	0f 84 b9 00 00 00    	je     2db <main+0x2db>
 222:	0f b6 17             	movzbl (%edi),%edx
 225:	84 d2                	test   %dl,%dl
 227:	74 7f                	je     2a8 <main+0x2a8>
 229:	38 95 88 fb ff ff    	cmp    %dl,-0x478(%ebp)
 22f:	75 77                	jne    2a8 <main+0x2a8>
 231:	8d 57 01             	lea    0x1(%edi),%edx
 234:	89 c6                	mov    %eax,%esi
 236:	01 cf                	add    %ecx,%edi
 238:	8d 8d 88 fb ff ff    	lea    -0x478(%ebp),%ecx
 23e:	eb 0e                	jmp    24e <main+0x24e>
 240:	0f b6 02             	movzbl (%edx),%eax
 243:	84 c0                	test   %al,%al
 245:	74 58                	je     29f <main+0x29f>
 247:	83 c2 01             	add    $0x1,%edx
 24a:	3a 01                	cmp    (%ecx),%al
 24c:	75 51                	jne    29f <main+0x29f>
						{
							k++;
							l++;
 24e:	83 c1 01             	add    $0x1,%ecx
					{
						// got a complete file name
						// compare with argv[1]
						char* k = argv[1];
						char* l = fileNameBuf;
						while (j > 0 && *k && *k == *l)
 251:	39 fa                	cmp    %edi,%edx
 253:	75 eb                	jne    240 <main+0x240>
 255:	8b 9d 70 fb ff ff    	mov    -0x490(%ebp),%ebx
 25b:	89 f0                	mov    %esi,%eax
 25d:	0f b6 8c 1d e8 fb ff 	movzbl -0x418(%ebp,%ebx,1),%ecx
 264:	ff 
 265:	8b 9d 70 fb ff ff    	mov    -0x490(%ebp),%ebx
 26b:	8d 73 01             	lea    0x1(%ebx),%esi
						}
						if (j == 0) 
						{
							// found file
							// kill original owner name
							while (buf[i] != ':')
 26e:	80 f9 3a             	cmp    $0x3a,%cl
 271:	74 72                	je     2e5 <main+0x2e5>
 273:	8b bd 74 fb ff ff    	mov    -0x48c(%ebp),%edi
							{
								int m = i;
								
								while(buf[m] != '\0')
 279:	84 c9                	test   %cl,%cl
 27b:	8d 14 37             	lea    (%edi,%esi,1),%edx
 27e:	74 f3                	je     273 <main+0x273>
								{
									buf[m] = buf[m+1];
 280:	0f b6 0a             	movzbl (%edx),%ecx
 283:	83 c2 01             	add    $0x1,%edx
 286:	88 4a fe             	mov    %cl,-0x2(%edx)
							// kill original owner name
							while (buf[i] != ':')
							{
								int m = i;
								
								while(buf[m] != '\0')
 289:	80 7a ff 00          	cmpb   $0x0,-0x1(%edx)
 28d:	75 f1                	jne    280 <main+0x280>
 28f:	8b 9d 70 fb ff ff    	mov    -0x490(%ebp),%ebx
 295:	0f b6 8c 1d e8 fb ff 	movzbl -0x418(%ebp,%ebx,1),%ecx
 29c:	ff 
 29d:	eb cf                	jmp    26e <main+0x26e>
 29f:	89 f0                	mov    %esi,%eax
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
						{
							// not this file
							// skip two semi-colon
							do
							{		
							c = buf[i];
 2a8:	8b bd 74 fb ff ff    	mov    -0x48c(%ebp),%edi
 2ae:	0f b6 14 07          	movzbl (%edi,%eax,1),%edx
							i++;
 2b2:	83 c0 01             	add    $0x1,%eax
							} while (c != ':');
 2b5:	80 fa 3a             	cmp    $0x3a,%dl
 2b8:	75 ee                	jne    2a8 <main+0x2a8>
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
							do
							{
								c = buf[i];
 2c0:	8b b5 74 fb ff ff    	mov    -0x48c(%ebp),%esi
 2c6:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
								i++;
 2ca:	83 c0 01             	add    $0x1,%eax
							} while (c != ':');
 2cd:	80 fa 3a             	cmp    $0x3a,%dl
 2d0:	75 ee                	jne    2c0 <main+0x2c0>
								
							
						}

						j = 0;
 2d2:	31 c9                	xor    %ecx,%ecx
 2d4:	89 c6                	mov    %eax,%esi
 2d6:	e9 a5 fd ff ff       	jmp    80 <main+0x80>
 2db:	0f b6 8c 05 e8 fb ff 	movzbl -0x418(%ebp,%eax,1),%ecx
 2e2:	ff 
 2e3:	eb 80                	jmp    265 <main+0x265>
									buf[m] = buf[m+1];
									m++;
								}
							}
							// insert new owner name
							char* o = argv[2];
 2e5:	8b 9d 6c fb ff ff    	mov    -0x494(%ebp),%ebx
							int nameLen = 0;							
 2eb:	31 f6                	xor    %esi,%esi
									buf[m] = buf[m+1];
									m++;
								}
							}
							// insert new owner name
							char* o = argv[2];
 2ed:	8b 7b 08             	mov    0x8(%ebx),%edi
							int nameLen = 0;							
							while (*o)
 2f0:	eb 03                	jmp    2f5 <main+0x2f5>
							{
								o++;
								nameLen++;
 2f2:	83 c6 01             	add    $0x1,%esi
								}
							}
							// insert new owner name
							char* o = argv[2];
							int nameLen = 0;							
							while (*o)
 2f5:	80 3c 37 00          	cmpb   $0x0,(%edi,%esi,1)
 2f9:	75 f7                	jne    2f2 <main+0x2f2>
							{
								o++;
								nameLen++;
							}
							int p = 0;
							for (p = 0; p < nameLen; p++)
 2fb:	85 f6                	test   %esi,%esi
 2fd:	0f 84 c6 fe ff ff    	je     1c9 <main+0x1c9>
 303:	8b 9d 70 fb ff ff    	mov    -0x490(%ebp),%ebx
 309:	8b 8d 74 fb ff ff    	mov    -0x48c(%ebp),%ecx
 30f:	8d 4c 19 ff          	lea    -0x1(%ecx,%ebx,1),%ecx
 313:	01 de                	add    %ebx,%esi
								while(q > i)
								{
									buf[q] = buf[q-1];
									q--;
								}								
								buf[i] = argv[2][p];  // insert the new name char								
 315:	29 df                	sub    %ebx,%edi
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
							}
							int p = 0;
							for (p = 0; p < nameLen; p++)
							{
								int q = i;
								while (buf[q]!='\0')
 320:	80 79 01 00          	cmpb   $0x0,0x1(%ecx)
 324:	89 c2                	mov    %eax,%edx
 326:	74 17                	je     33f <main+0x33f>
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 330:	8b 9d 74 fb ff ff    	mov    -0x48c(%ebp),%ebx
									q++;
 336:	83 c2 01             	add    $0x1,%edx
							}
							int p = 0;
							for (p = 0; p < nameLen; p++)
							{
								int q = i;
								while (buf[q]!='\0')
 339:	80 3c 13 00          	cmpb   $0x0,(%ebx,%edx,1)
 33d:	75 f1                	jne    330 <main+0x330>
									q++;
								q++;
								while(q > i)
 33f:	39 d0                	cmp    %edx,%eax
 341:	7f 1c                	jg     35f <main+0x35f>
 343:	03 95 74 fb ff ff    	add    -0x48c(%ebp),%edx
 349:	89 c3                	mov    %eax,%ebx
 34b:	90                   	nop
 34c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
								{
									buf[q] = buf[q-1];
 350:	0f b6 02             	movzbl (%edx),%eax
 353:	83 ea 01             	sub    $0x1,%edx
 356:	88 42 02             	mov    %al,0x2(%edx)
							{
								int q = i;
								while (buf[q]!='\0')
									q++;
								q++;
								while(q > i)
 359:	39 ca                	cmp    %ecx,%edx
 35b:	75 f3                	jne    350 <main+0x350>
 35d:	89 d8                	mov    %ebx,%eax
								{
									buf[q] = buf[q-1];
									q--;
								}								
								buf[i] = argv[2][p];  // insert the new name char								
 35f:	0f b6 14 07          	movzbl (%edi,%eax,1),%edx
								i++;
 363:	83 c0 01             	add    $0x1,%eax
 366:	83 c1 01             	add    $0x1,%ecx
								while(q > i)
								{
									buf[q] = buf[q-1];
									q--;
								}								
								buf[i] = argv[2][p];  // insert the new name char								
 369:	88 11                	mov    %dl,(%ecx)
							{
								o++;
								nameLen++;
							}
							int p = 0;
							for (p = 0; p < nameLen; p++)
 36b:	39 f0                	cmp    %esi,%eax
 36d:	75 b1                	jne    320 <main+0x320>
 36f:	e9 55 fe ff ff       	jmp    1c9 <main+0x1c9>
				{
					int m = write(fd, buf, sizeof buf);
					//printf(1, "co: writing: %d %d\n", m, sizeof buf);
					if(m == sizeof buf)
					{
						close(fd);
 374:	83 ec 0c             	sub    $0xc,%esp
 377:	56                   	push   %esi
 378:	e8 8d 02 00 00       	call   60a <close>
						printf(1, "co: File owner changed succeed\n");
 37d:	5a                   	pop    %edx
 37e:	59                   	pop    %ecx
 37f:	68 80 0a 00 00       	push   $0xa80
 384:	6a 01                	push   $0x1
 386:	e8 c5 03 00 00       	call   750 <printf>
 38b:	83 c4 10             	add    $0x10,%esp
 38e:	e9 6d fe ff ff       	jmp    200 <main+0x200>
 393:	66 90                	xchg   %ax,%ax
 395:	66 90                	xchg   %ax,%ax
 397:	66 90                	xchg   %ax,%ax
 399:	66 90                	xchg   %ax,%ax
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3aa:	89 c2                	mov    %eax,%edx
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b0:	83 c1 01             	add    $0x1,%ecx
 3b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3b7:	83 c2 01             	add    $0x1,%edx
 3ba:	84 db                	test   %bl,%bl
 3bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 3bf:	75 ef                	jne    3b0 <strcpy+0x10>
    ;
  return os;
}
 3c1:	5b                   	pop    %ebx
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    
 3c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	53                   	push   %ebx
 3d5:	8b 55 08             	mov    0x8(%ebp),%edx
 3d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3db:	0f b6 02             	movzbl (%edx),%eax
 3de:	0f b6 19             	movzbl (%ecx),%ebx
 3e1:	84 c0                	test   %al,%al
 3e3:	75 1e                	jne    403 <strcmp+0x33>
 3e5:	eb 29                	jmp    410 <strcmp+0x40>
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 3f0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 3f6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3f9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3fd:	84 c0                	test   %al,%al
 3ff:	74 0f                	je     410 <strcmp+0x40>
 401:	89 f1                	mov    %esi,%ecx
 403:	38 d8                	cmp    %bl,%al
 405:	74 e9                	je     3f0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 407:	29 d8                	sub    %ebx,%eax
}
 409:	5b                   	pop    %ebx
 40a:	5e                   	pop    %esi
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
 40d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 410:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 412:	29 d8                	sub    %ebx,%eax
}
 414:	5b                   	pop    %ebx
 415:	5e                   	pop    %esi
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
 418:	90                   	nop
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000420 <strlen>:

uint
strlen(const char *s)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 426:	80 39 00             	cmpb   $0x0,(%ecx)
 429:	74 12                	je     43d <strlen+0x1d>
 42b:	31 d2                	xor    %edx,%edx
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	83 c2 01             	add    $0x1,%edx
 433:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 437:	89 d0                	mov    %edx,%eax
 439:	75 f5                	jne    430 <strlen+0x10>
    ;
  return n;
}
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 43d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 43f:	5d                   	pop    %ebp
 440:	c3                   	ret    
 441:	eb 0d                	jmp    450 <memset>
 443:	90                   	nop
 444:	90                   	nop
 445:	90                   	nop
 446:	90                   	nop
 447:	90                   	nop
 448:	90                   	nop
 449:	90                   	nop
 44a:	90                   	nop
 44b:	90                   	nop
 44c:	90                   	nop
 44d:	90                   	nop
 44e:	90                   	nop
 44f:	90                   	nop

00000450 <memset>:

void*
memset(void *dst, int c, uint n)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	57                   	push   %edi
 454:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 457:	8b 4d 10             	mov    0x10(%ebp),%ecx
 45a:	8b 45 0c             	mov    0xc(%ebp),%eax
 45d:	89 d7                	mov    %edx,%edi
 45f:	fc                   	cld    
 460:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 462:	89 d0                	mov    %edx,%eax
 464:	5f                   	pop    %edi
 465:	5d                   	pop    %ebp
 466:	c3                   	ret    
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <strchr>:

char*
strchr(const char *s, char c)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	53                   	push   %ebx
 474:	8b 45 08             	mov    0x8(%ebp),%eax
 477:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 47a:	0f b6 10             	movzbl (%eax),%edx
 47d:	84 d2                	test   %dl,%dl
 47f:	74 1d                	je     49e <strchr+0x2e>
    if(*s == c)
 481:	38 d3                	cmp    %dl,%bl
 483:	89 d9                	mov    %ebx,%ecx
 485:	75 0d                	jne    494 <strchr+0x24>
 487:	eb 17                	jmp    4a0 <strchr+0x30>
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 490:	38 ca                	cmp    %cl,%dl
 492:	74 0c                	je     4a0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 494:	83 c0 01             	add    $0x1,%eax
 497:	0f b6 10             	movzbl (%eax),%edx
 49a:	84 d2                	test   %dl,%dl
 49c:	75 f2                	jne    490 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 49e:	31 c0                	xor    %eax,%eax
}
 4a0:	5b                   	pop    %ebx
 4a1:	5d                   	pop    %ebp
 4a2:	c3                   	ret    
 4a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <gets>:

char*
gets(char *buf, int max)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4b6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 4b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 4bb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4be:	eb 29                	jmp    4e9 <gets+0x39>
    cc = read(0, &c, 1);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	6a 01                	push   $0x1
 4c5:	57                   	push   %edi
 4c6:	6a 00                	push   $0x0
 4c8:	e8 2d 01 00 00       	call   5fa <read>
    if(cc < 1)
 4cd:	83 c4 10             	add    $0x10,%esp
 4d0:	85 c0                	test   %eax,%eax
 4d2:	7e 1d                	jle    4f1 <gets+0x41>
      break;
    buf[i++] = c;
 4d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4d8:	8b 55 08             	mov    0x8(%ebp),%edx
 4db:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 4dd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 4df:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 4e3:	74 1b                	je     500 <gets+0x50>
 4e5:	3c 0d                	cmp    $0xd,%al
 4e7:	74 17                	je     500 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4e9:	8d 5e 01             	lea    0x1(%esi),%ebx
 4ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4ef:	7c cf                	jl     4c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4fb:	5b                   	pop    %ebx
 4fc:	5e                   	pop    %esi
 4fd:	5f                   	pop    %edi
 4fe:	5d                   	pop    %ebp
 4ff:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 500:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 503:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 505:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 509:	8d 65 f4             	lea    -0xc(%ebp),%esp
 50c:	5b                   	pop    %ebx
 50d:	5e                   	pop    %esi
 50e:	5f                   	pop    %edi
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret    
 511:	eb 0d                	jmp    520 <stat>
 513:	90                   	nop
 514:	90                   	nop
 515:	90                   	nop
 516:	90                   	nop
 517:	90                   	nop
 518:	90                   	nop
 519:	90                   	nop
 51a:	90                   	nop
 51b:	90                   	nop
 51c:	90                   	nop
 51d:	90                   	nop
 51e:	90                   	nop
 51f:	90                   	nop

00000520 <stat>:

int
stat(const char *n, struct stat *st)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	56                   	push   %esi
 524:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 525:	83 ec 08             	sub    $0x8,%esp
 528:	6a 00                	push   $0x0
 52a:	ff 75 08             	pushl  0x8(%ebp)
 52d:	e8 f0 00 00 00       	call   622 <open>
  if(fd < 0)
 532:	83 c4 10             	add    $0x10,%esp
 535:	85 c0                	test   %eax,%eax
 537:	78 27                	js     560 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 539:	83 ec 08             	sub    $0x8,%esp
 53c:	ff 75 0c             	pushl  0xc(%ebp)
 53f:	89 c3                	mov    %eax,%ebx
 541:	50                   	push   %eax
 542:	e8 f3 00 00 00       	call   63a <fstat>
 547:	89 c6                	mov    %eax,%esi
  close(fd);
 549:	89 1c 24             	mov    %ebx,(%esp)
 54c:	e8 b9 00 00 00       	call   60a <close>
  return r;
 551:	83 c4 10             	add    $0x10,%esp
 554:	89 f0                	mov    %esi,%eax
}
 556:	8d 65 f8             	lea    -0x8(%ebp),%esp
 559:	5b                   	pop    %ebx
 55a:	5e                   	pop    %esi
 55b:	5d                   	pop    %ebp
 55c:	c3                   	ret    
 55d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 565:	eb ef                	jmp    556 <stat+0x36>
 567:	89 f6                	mov    %esi,%esi
 569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000570 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	53                   	push   %ebx
 574:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 577:	0f be 11             	movsbl (%ecx),%edx
 57a:	8d 42 d0             	lea    -0x30(%edx),%eax
 57d:	3c 09                	cmp    $0x9,%al
 57f:	b8 00 00 00 00       	mov    $0x0,%eax
 584:	77 1f                	ja     5a5 <atoi+0x35>
 586:	8d 76 00             	lea    0x0(%esi),%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 590:	8d 04 80             	lea    (%eax,%eax,4),%eax
 593:	83 c1 01             	add    $0x1,%ecx
 596:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 59a:	0f be 11             	movsbl (%ecx),%edx
 59d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5a0:	80 fb 09             	cmp    $0x9,%bl
 5a3:	76 eb                	jbe    590 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 5a5:	5b                   	pop    %ebx
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret    
 5a8:	90                   	nop
 5a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	56                   	push   %esi
 5b4:	53                   	push   %ebx
 5b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5b8:	8b 45 08             	mov    0x8(%ebp),%eax
 5bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5be:	85 db                	test   %ebx,%ebx
 5c0:	7e 14                	jle    5d6 <memmove+0x26>
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 5c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5cf:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5d2:	39 da                	cmp    %ebx,%edx
 5d4:	75 f2                	jne    5c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 5d6:	5b                   	pop    %ebx
 5d7:	5e                   	pop    %esi
 5d8:	5d                   	pop    %ebp
 5d9:	c3                   	ret    

000005da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5da:	b8 01 00 00 00       	mov    $0x1,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <exit>:
SYSCALL(exit)
 5e2:	b8 02 00 00 00       	mov    $0x2,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <wait>:
SYSCALL(wait)
 5ea:	b8 03 00 00 00       	mov    $0x3,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <pipe>:
SYSCALL(pipe)
 5f2:	b8 04 00 00 00       	mov    $0x4,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <read>:
SYSCALL(read)
 5fa:	b8 05 00 00 00       	mov    $0x5,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <write>:
SYSCALL(write)
 602:	b8 10 00 00 00       	mov    $0x10,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <close>:
SYSCALL(close)
 60a:	b8 15 00 00 00       	mov    $0x15,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <kill>:
SYSCALL(kill)
 612:	b8 06 00 00 00       	mov    $0x6,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <exec>:
SYSCALL(exec)
 61a:	b8 07 00 00 00       	mov    $0x7,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <open>:
SYSCALL(open)
 622:	b8 0f 00 00 00       	mov    $0xf,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <mknod>:
SYSCALL(mknod)
 62a:	b8 11 00 00 00       	mov    $0x11,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <unlink>:
SYSCALL(unlink)
 632:	b8 12 00 00 00       	mov    $0x12,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <fstat>:
SYSCALL(fstat)
 63a:	b8 08 00 00 00       	mov    $0x8,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <link>:
SYSCALL(link)
 642:	b8 13 00 00 00       	mov    $0x13,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <mkdir>:
SYSCALL(mkdir)
 64a:	b8 14 00 00 00       	mov    $0x14,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <chdir>:
SYSCALL(chdir)
 652:	b8 09 00 00 00       	mov    $0x9,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <dup>:
SYSCALL(dup)
 65a:	b8 0a 00 00 00       	mov    $0xa,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <getpid>:
SYSCALL(getpid)
 662:	b8 0b 00 00 00       	mov    $0xb,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <sbrk>:
SYSCALL(sbrk)
 66a:	b8 0c 00 00 00       	mov    $0xc,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <sleep>:
SYSCALL(sleep)
 672:	b8 0d 00 00 00       	mov    $0xd,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <uptime>:
SYSCALL(uptime)
 67a:	b8 0e 00 00 00       	mov    $0xe,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <cps>:
SYSCALL(cps)
 682:	b8 16 00 00 00       	mov    $0x16,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <userTag>:
SYSCALL(userTag)
 68a:	b8 17 00 00 00       	mov    $0x17,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <changeUser>:
SYSCALL(changeUser)
 692:	b8 18 00 00 00       	mov    $0x18,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <getUser>:
SYSCALL(getUser)
 69a:	b8 19 00 00 00       	mov    $0x19,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <changeOwner>:
SYSCALL(changeOwner)
 6a2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	89 c6                	mov    %eax,%esi
 6b8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6be:	85 db                	test   %ebx,%ebx
 6c0:	74 7e                	je     740 <printint+0x90>
 6c2:	89 d0                	mov    %edx,%eax
 6c4:	c1 e8 1f             	shr    $0x1f,%eax
 6c7:	84 c0                	test   %al,%al
 6c9:	74 75                	je     740 <printint+0x90>
    neg = 1;
    x = -xx;
 6cb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 6cd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 6d4:	f7 d8                	neg    %eax
 6d6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 6d9:	31 ff                	xor    %edi,%edi
 6db:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 6de:	89 ce                	mov    %ecx,%esi
 6e0:	eb 08                	jmp    6ea <printint+0x3a>
 6e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6e8:	89 cf                	mov    %ecx,%edi
 6ea:	31 d2                	xor    %edx,%edx
 6ec:	8d 4f 01             	lea    0x1(%edi),%ecx
 6ef:	f7 f6                	div    %esi
 6f1:	0f b6 92 a8 0a 00 00 	movzbl 0xaa8(%edx),%edx
  }while((x /= base) != 0);
 6f8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 6fa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 6fd:	75 e9                	jne    6e8 <printint+0x38>
  if(neg)
 6ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 702:	8b 75 c0             	mov    -0x40(%ebp),%esi
 705:	85 c0                	test   %eax,%eax
 707:	74 08                	je     711 <printint+0x61>
    buf[i++] = '-';
 709:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 70e:	8d 4f 02             	lea    0x2(%edi),%ecx
 711:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 715:	8d 76 00             	lea    0x0(%esi),%esi
 718:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 71b:	83 ec 04             	sub    $0x4,%esp
 71e:	83 ef 01             	sub    $0x1,%edi
 721:	6a 01                	push   $0x1
 723:	53                   	push   %ebx
 724:	56                   	push   %esi
 725:	88 45 d7             	mov    %al,-0x29(%ebp)
 728:	e8 d5 fe ff ff       	call   602 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 72d:	83 c4 10             	add    $0x10,%esp
 730:	39 df                	cmp    %ebx,%edi
 732:	75 e4                	jne    718 <printint+0x68>
    putc(fd, buf[i]);
}
 734:	8d 65 f4             	lea    -0xc(%ebp),%esp
 737:	5b                   	pop    %ebx
 738:	5e                   	pop    %esi
 739:	5f                   	pop    %edi
 73a:	5d                   	pop    %ebp
 73b:	c3                   	ret    
 73c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 740:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 742:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 749:	eb 8b                	jmp    6d6 <printint+0x26>
 74b:	90                   	nop
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000750 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 756:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 759:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 75c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 75f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 762:	89 45 d0             	mov    %eax,-0x30(%ebp)
 765:	0f b6 1e             	movzbl (%esi),%ebx
 768:	83 c6 01             	add    $0x1,%esi
 76b:	84 db                	test   %bl,%bl
 76d:	0f 84 b0 00 00 00    	je     823 <printf+0xd3>
 773:	31 d2                	xor    %edx,%edx
 775:	eb 39                	jmp    7b0 <printf+0x60>
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 780:	83 f8 25             	cmp    $0x25,%eax
 783:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 786:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 78b:	74 18                	je     7a5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 78d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 790:	83 ec 04             	sub    $0x4,%esp
 793:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 796:	6a 01                	push   $0x1
 798:	50                   	push   %eax
 799:	57                   	push   %edi
 79a:	e8 63 fe ff ff       	call   602 <write>
 79f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 7a2:	83 c4 10             	add    $0x10,%esp
 7a5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7a8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 7ac:	84 db                	test   %bl,%bl
 7ae:	74 73                	je     823 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 7b0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 7b2:	0f be cb             	movsbl %bl,%ecx
 7b5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7b8:	74 c6                	je     780 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7ba:	83 fa 25             	cmp    $0x25,%edx
 7bd:	75 e6                	jne    7a5 <printf+0x55>
      if(c == 'd'){
 7bf:	83 f8 64             	cmp    $0x64,%eax
 7c2:	0f 84 f8 00 00 00    	je     8c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7c8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7ce:	83 f9 70             	cmp    $0x70,%ecx
 7d1:	74 5d                	je     830 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7d3:	83 f8 73             	cmp    $0x73,%eax
 7d6:	0f 84 84 00 00 00    	je     860 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7dc:	83 f8 63             	cmp    $0x63,%eax
 7df:	0f 84 ea 00 00 00    	je     8cf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7e5:	83 f8 25             	cmp    $0x25,%eax
 7e8:	0f 84 c2 00 00 00    	je     8b0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ee:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7f1:	83 ec 04             	sub    $0x4,%esp
 7f4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 7f8:	6a 01                	push   $0x1
 7fa:	50                   	push   %eax
 7fb:	57                   	push   %edi
 7fc:	e8 01 fe ff ff       	call   602 <write>
 801:	83 c4 0c             	add    $0xc,%esp
 804:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 807:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 80a:	6a 01                	push   $0x1
 80c:	50                   	push   %eax
 80d:	57                   	push   %edi
 80e:	83 c6 01             	add    $0x1,%esi
 811:	e8 ec fd ff ff       	call   602 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 816:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 81a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 81d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 81f:	84 db                	test   %bl,%bl
 821:	75 8d                	jne    7b0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 823:	8d 65 f4             	lea    -0xc(%ebp),%esp
 826:	5b                   	pop    %ebx
 827:	5e                   	pop    %esi
 828:	5f                   	pop    %edi
 829:	5d                   	pop    %ebp
 82a:	c3                   	ret    
 82b:	90                   	nop
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 830:	83 ec 0c             	sub    $0xc,%esp
 833:	b9 10 00 00 00       	mov    $0x10,%ecx
 838:	6a 00                	push   $0x0
 83a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 83d:	89 f8                	mov    %edi,%eax
 83f:	8b 13                	mov    (%ebx),%edx
 841:	e8 6a fe ff ff       	call   6b0 <printint>
        ap++;
 846:	89 d8                	mov    %ebx,%eax
 848:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 84b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 84d:	83 c0 04             	add    $0x4,%eax
 850:	89 45 d0             	mov    %eax,-0x30(%ebp)
 853:	e9 4d ff ff ff       	jmp    7a5 <printf+0x55>
 858:	90                   	nop
 859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 860:	8b 45 d0             	mov    -0x30(%ebp),%eax
 863:	8b 18                	mov    (%eax),%ebx
        ap++;
 865:	83 c0 04             	add    $0x4,%eax
 868:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 86b:	b8 a0 0a 00 00       	mov    $0xaa0,%eax
 870:	85 db                	test   %ebx,%ebx
 872:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 875:	0f b6 03             	movzbl (%ebx),%eax
 878:	84 c0                	test   %al,%al
 87a:	74 23                	je     89f <printf+0x14f>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 883:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 886:	83 ec 04             	sub    $0x4,%esp
 889:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 88b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 88e:	50                   	push   %eax
 88f:	57                   	push   %edi
 890:	e8 6d fd ff ff       	call   602 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 895:	0f b6 03             	movzbl (%ebx),%eax
 898:	83 c4 10             	add    $0x10,%esp
 89b:	84 c0                	test   %al,%al
 89d:	75 e1                	jne    880 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 89f:	31 d2                	xor    %edx,%edx
 8a1:	e9 ff fe ff ff       	jmp    7a5 <printf+0x55>
 8a6:	8d 76 00             	lea    0x0(%esi),%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8b0:	83 ec 04             	sub    $0x4,%esp
 8b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 8b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 8b9:	6a 01                	push   $0x1
 8bb:	e9 4c ff ff ff       	jmp    80c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 8c0:	83 ec 0c             	sub    $0xc,%esp
 8c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 8c8:	6a 01                	push   $0x1
 8ca:	e9 6b ff ff ff       	jmp    83a <printf+0xea>
 8cf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8d2:	83 ec 04             	sub    $0x4,%esp
 8d5:	8b 03                	mov    (%ebx),%eax
 8d7:	6a 01                	push   $0x1
 8d9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 8dc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8df:	50                   	push   %eax
 8e0:	57                   	push   %edi
 8e1:	e8 1c fd ff ff       	call   602 <write>
 8e6:	e9 5b ff ff ff       	jmp    846 <printf+0xf6>
 8eb:	66 90                	xchg   %ax,%ax
 8ed:	66 90                	xchg   %ax,%ax
 8ef:	90                   	nop

000008f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f1:	a1 4c 0d 00 00       	mov    0xd4c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8f6:	89 e5                	mov    %esp,%ebp
 8f8:	57                   	push   %edi
 8f9:	56                   	push   %esi
 8fa:	53                   	push   %ebx
 8fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 900:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 903:	39 c8                	cmp    %ecx,%eax
 905:	73 19                	jae    920 <free+0x30>
 907:	89 f6                	mov    %esi,%esi
 909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 910:	39 d1                	cmp    %edx,%ecx
 912:	72 1c                	jb     930 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 914:	39 d0                	cmp    %edx,%eax
 916:	73 18                	jae    930 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 918:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91e:	72 f0                	jb     910 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 920:	39 d0                	cmp    %edx,%eax
 922:	72 f4                	jb     918 <free+0x28>
 924:	39 d1                	cmp    %edx,%ecx
 926:	73 f0                	jae    918 <free+0x28>
 928:	90                   	nop
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 930:	8b 73 fc             	mov    -0x4(%ebx),%esi
 933:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 936:	39 d7                	cmp    %edx,%edi
 938:	74 19                	je     953 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 93a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 93d:	8b 50 04             	mov    0x4(%eax),%edx
 940:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 943:	39 f1                	cmp    %esi,%ecx
 945:	74 23                	je     96a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 947:	89 08                	mov    %ecx,(%eax)
  freep = p;
 949:	a3 4c 0d 00 00       	mov    %eax,0xd4c
}
 94e:	5b                   	pop    %ebx
 94f:	5e                   	pop    %esi
 950:	5f                   	pop    %edi
 951:	5d                   	pop    %ebp
 952:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 953:	03 72 04             	add    0x4(%edx),%esi
 956:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 959:	8b 10                	mov    (%eax),%edx
 95b:	8b 12                	mov    (%edx),%edx
 95d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 960:	8b 50 04             	mov    0x4(%eax),%edx
 963:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 966:	39 f1                	cmp    %esi,%ecx
 968:	75 dd                	jne    947 <free+0x57>
    p->s.size += bp->s.size;
 96a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 96d:	a3 4c 0d 00 00       	mov    %eax,0xd4c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 972:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 975:	8b 53 f8             	mov    -0x8(%ebx),%edx
 978:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 97a:	5b                   	pop    %ebx
 97b:	5e                   	pop    %esi
 97c:	5f                   	pop    %edi
 97d:	5d                   	pop    %ebp
 97e:	c3                   	ret    
 97f:	90                   	nop

00000980 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	57                   	push   %edi
 984:	56                   	push   %esi
 985:	53                   	push   %ebx
 986:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 989:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 98c:	8b 15 4c 0d 00 00    	mov    0xd4c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 992:	8d 78 07             	lea    0x7(%eax),%edi
 995:	c1 ef 03             	shr    $0x3,%edi
 998:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 99b:	85 d2                	test   %edx,%edx
 99d:	0f 84 a3 00 00 00    	je     a46 <malloc+0xc6>
 9a3:	8b 02                	mov    (%edx),%eax
 9a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 9a8:	39 cf                	cmp    %ecx,%edi
 9aa:	76 74                	jbe    a20 <malloc+0xa0>
 9ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 9b2:	be 00 10 00 00       	mov    $0x1000,%esi
 9b7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 9be:	0f 43 f7             	cmovae %edi,%esi
 9c1:	ba 00 80 00 00       	mov    $0x8000,%edx
 9c6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 9cc:	0f 46 da             	cmovbe %edx,%ebx
 9cf:	eb 10                	jmp    9e1 <malloc+0x61>
 9d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 9da:	8b 48 04             	mov    0x4(%eax),%ecx
 9dd:	39 cf                	cmp    %ecx,%edi
 9df:	76 3f                	jbe    a20 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9e1:	39 05 4c 0d 00 00    	cmp    %eax,0xd4c
 9e7:	89 c2                	mov    %eax,%edx
 9e9:	75 ed                	jne    9d8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9eb:	83 ec 0c             	sub    $0xc,%esp
 9ee:	53                   	push   %ebx
 9ef:	e8 76 fc ff ff       	call   66a <sbrk>
  if(p == (char*)-1)
 9f4:	83 c4 10             	add    $0x10,%esp
 9f7:	83 f8 ff             	cmp    $0xffffffff,%eax
 9fa:	74 1c                	je     a18 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9fc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 9ff:	83 ec 0c             	sub    $0xc,%esp
 a02:	83 c0 08             	add    $0x8,%eax
 a05:	50                   	push   %eax
 a06:	e8 e5 fe ff ff       	call   8f0 <free>
  return freep;
 a0b:	8b 15 4c 0d 00 00    	mov    0xd4c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 a11:	83 c4 10             	add    $0x10,%esp
 a14:	85 d2                	test   %edx,%edx
 a16:	75 c0                	jne    9d8 <malloc+0x58>
        return 0;
 a18:	31 c0                	xor    %eax,%eax
 a1a:	eb 1c                	jmp    a38 <malloc+0xb8>
 a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a20:	39 cf                	cmp    %ecx,%edi
 a22:	74 1c                	je     a40 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a24:	29 f9                	sub    %edi,%ecx
 a26:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 a29:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 a2c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 a2f:	89 15 4c 0d 00 00    	mov    %edx,0xd4c
      return (void*)(p + 1);
 a35:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a38:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a3b:	5b                   	pop    %ebx
 a3c:	5e                   	pop    %esi
 a3d:	5f                   	pop    %edi
 a3e:	5d                   	pop    %ebp
 a3f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a40:	8b 08                	mov    (%eax),%ecx
 a42:	89 0a                	mov    %ecx,(%edx)
 a44:	eb e9                	jmp    a2f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a46:	c7 05 4c 0d 00 00 50 	movl   $0xd50,0xd4c
 a4d:	0d 00 00 
 a50:	c7 05 50 0d 00 00 50 	movl   $0xd50,0xd50
 a57:	0d 00 00 
    base.s.size = 0;
 a5a:	b8 50 0d 00 00       	mov    $0xd50,%eax
 a5f:	c7 05 54 0d 00 00 00 	movl   $0x0,0xd54
 a66:	00 00 00 
 a69:	e9 3e ff ff ff       	jmp    9ac <malloc+0x2c>
