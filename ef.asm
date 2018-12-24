
_ef:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
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
  11:	81 ec 20 08 00 00    	sub    $0x820,%esp
  17:	8b 59 04             	mov    0x4(%ecx),%ebx
	int fd;
	if(strcmp(argv[2], "rd") == 0)
  1a:	68 40 0b 00 00       	push   $0xb40
  1f:	ff 73 08             	pushl  0x8(%ebx)
  22:	e8 79 04 00 00       	call   4a0 <strcmp>
  27:	83 c4 10             	add    $0x10,%esp
  2a:	85 c0                	test   %eax,%eax
  2c:	75 51                	jne    7f <main+0x7f>
	{

		fd = open(argv[1], O_RDONLY);
  2e:	50                   	push   %eax
  2f:	50                   	push   %eax
  30:	6a 00                	push   $0x0
  32:	ff 73 04             	pushl  0x4(%ebx)
  35:	e8 b8 06 00 00       	call   6f2 <open>
		if(fd >= 0)
  3a:	83 c4 10             	add    $0x10,%esp
  3d:	85 c0                	test   %eax,%eax
{
	int fd;
	if(strcmp(argv[2], "rd") == 0)
	{

		fd = open(argv[1], O_RDONLY);
  3f:	89 c3                	mov    %eax,%ebx
		if(fd >= 0)
  41:	78 37                	js     7a <main+0x7a>
		{
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
  43:	8d b5 e8 f7 ff ff    	lea    -0x818(%ebp),%esi
  49:	50                   	push   %eax
  4a:	68 00 08 00 00       	push   $0x800
  4f:	56                   	push   %esi
  50:	53                   	push   %ebx
  51:	e8 74 06 00 00       	call   6ca <read>
			if(n >= 0)
  56:	83 c4 10             	add    $0x10,%esp
  59:	85 c0                	test   %eax,%eax
  5b:	78 11                	js     6e <main+0x6e>
			{
				printf(1,"%s\n", buf);
  5d:	50                   	push   %eax
  5e:	56                   	push   %esi
  5f:	68 43 0b 00 00       	push   $0xb43
  64:	6a 01                	push   $0x1
  66:	e8 b5 07 00 00       	call   820 <printf>
  6b:	83 c4 10             	add    $0x10,%esp
			}
			close(fd);
  6e:	83 ec 0c             	sub    $0xc,%esp
  71:	53                   	push   %ebx
  72:	e8 63 06 00 00       	call   6da <close>
  77:	83 c4 10             	add    $0x10,%esp
	else
	{
		printf(1,"There is no such method in 'ef'.\n");
	}
	
	exit();
  7a:	e8 33 06 00 00       	call   6b2 <exit>
				printf(1,"%s\n", buf);
			}
			close(fd);
		}	
	}
	else if(strcmp(argv[2], "wr") == 0)
  7f:	50                   	push   %eax
  80:	50                   	push   %eax
  81:	68 47 0b 00 00       	push   $0xb47
  86:	ff 73 08             	pushl  0x8(%ebx)
  89:	e8 12 04 00 00       	call   4a0 <strcmp>
  8e:	83 c4 10             	add    $0x10,%esp
  91:	85 c0                	test   %eax,%eax
  93:	75 39                	jne    ce <main+0xce>
	{
		fd = open(argv[1], O_RDWR);
  95:	57                   	push   %edi
  96:	57                   	push   %edi
  97:	6a 02                	push   $0x2
  99:	ff 73 04             	pushl  0x4(%ebx)
  9c:	e8 51 06 00 00       	call   6f2 <open>
		if(fd >= 0)
  a1:	83 c4 10             	add    $0x10,%esp
  a4:	85 c0                	test   %eax,%eax
			close(fd);
		}	
	}
	else if(strcmp(argv[2], "wr") == 0)
	{
		fd = open(argv[1], O_RDWR);
  a6:	89 c6                	mov    %eax,%esi
		if(fd >= 0)
  a8:	78 d0                	js     7a <main+0x7a>
		{
			if(strlen(argv[3]) > 0)
  aa:	83 ec 0c             	sub    $0xc,%esp
  ad:	ff 73 0c             	pushl  0xc(%ebx)
  b0:	e8 3b 04 00 00       	call   4f0 <strlen>
  b5:	83 c4 10             	add    $0x10,%esp
  b8:	85 c0                	test   %eax,%eax
  ba:	0f 85 10 03 00 00    	jne    3d0 <main+0x3d0>
			{
				printf(1,"File update succeed\n");
			}
			
		}
		close(fd);
  c0:	83 ec 0c             	sub    $0xc,%esp
  c3:	56                   	push   %esi
  c4:	e8 11 06 00 00       	call   6da <close>
  c9:	83 c4 10             	add    $0x10,%esp
  cc:	eb ac                	jmp    7a <main+0x7a>
				}
			}
			close(fd);
		}
	}
	else if(strcmp(argv[2], "ins") == 0)
  ce:	56                   	push   %esi
  cf:	56                   	push   %esi
  d0:	68 5f 0b 00 00       	push   $0xb5f
  d5:	ff 73 08             	pushl  0x8(%ebx)
  d8:	e8 c3 03 00 00       	call   4a0 <strcmp>
  dd:	83 c4 10             	add    $0x10,%esp
  e0:	85 c0                	test   %eax,%eax
  e2:	0f 85 35 01 00 00    	jne    21d <main+0x21d>
	{
		fd = open(argv[1], O_RDWR);		
  e8:	51                   	push   %ecx
  e9:	51                   	push   %ecx
  ea:	6a 02                	push   $0x2
  ec:	ff 73 04             	pushl  0x4(%ebx)
  ef:	e8 fe 05 00 00       	call   6f2 <open>
		if (fd >= 0)
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	85 c0                	test   %eax,%eax
			close(fd);
		}
	}
	else if(strcmp(argv[2], "ins") == 0)
	{
		fd = open(argv[1], O_RDWR);		
  f9:	89 85 e0 f7 ff ff    	mov    %eax,-0x820(%ebp)
		if (fd >= 0)
  ff:	0f 88 02 01 00 00    	js     207 <main+0x207>
		{
			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
 105:	8d 8d e8 f7 ff ff    	lea    -0x818(%ebp),%ecx
 10b:	52                   	push   %edx
 10c:	68 00 08 00 00       	push   $0x800
 111:	51                   	push   %ecx
 112:	50                   	push   %eax
 113:	89 cf                	mov    %ecx,%edi
 115:	89 8d e4 f7 ff ff    	mov    %ecx,-0x81c(%ebp)
 11b:	e8 aa 05 00 00       	call   6ca <read>
			if (n >= 0)
 120:	83 c4 10             	add    $0x10,%esp
 123:	85 c0                	test   %eax,%eax
 125:	0f 88 86 00 00 00    	js     1b1 <main+0x1b1>
			{
				int originalBufLen = strlen(buf);
 12b:	83 ec 0c             	sub    $0xc,%esp
 12e:	57                   	push   %edi
 12f:	e8 bc 03 00 00       	call   4f0 <strlen>
 134:	89 c6                	mov    %eax,%esi
 136:	89 85 dc f7 ff ff    	mov    %eax,-0x824(%ebp)
				int insertPosition = atoi(argv[3]);
 13c:	58                   	pop    %eax
 13d:	ff 73 0c             	pushl  0xc(%ebx)
 140:	e8 fb 04 00 00       	call   640 <atoi>
				if (insertPosition < originalBufLen)
 145:	83 c4 10             	add    $0x10,%esp
 148:	39 c6                	cmp    %eax,%esi
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				int originalBufLen = strlen(buf);
				int insertPosition = atoi(argv[3]);
 14a:	89 c1                	mov    %eax,%ecx
 14c:	89 85 d8 f7 ff ff    	mov    %eax,-0x828(%ebp)
				if (insertPosition < originalBufLen)
 152:	0f 8e ef 02 00 00    	jle    447 <main+0x447>
 158:	8b 43 10             	mov    0x10(%ebx),%eax
 15b:	31 f6                	xor    %esi,%esi
				{
					int i = 0;
					for (i = 0; i < strlen(argv[4]);i++)
					{
						buf[i+insertPosition] = argv[4][i];
 15d:	01 cf                	add    %ecx,%edi
 15f:	eb 14                	jmp    175 <main+0x175>
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 168:	8b 43 10             	mov    0x10(%ebx),%eax
 16b:	0f b6 14 30          	movzbl (%eax,%esi,1),%edx
 16f:	88 14 37             	mov    %dl,(%edi,%esi,1)
				int originalBufLen = strlen(buf);
				int insertPosition = atoi(argv[3]);
				if (insertPosition < originalBufLen)
				{
					int i = 0;
					for (i = 0; i < strlen(argv[4]);i++)
 172:	83 c6 01             	add    $0x1,%esi
 175:	83 ec 0c             	sub    $0xc,%esp
 178:	50                   	push   %eax
 179:	e8 72 03 00 00       	call   4f0 <strlen>
 17e:	83 c4 10             	add    $0x10,%esp
 181:	39 f0                	cmp    %esi,%eax
 183:	77 e3                	ja     168 <main+0x168>
					{
						buf[i+insertPosition] = argv[4][i];
					}
					if (insertPosition+strlen(argv[4]) > originalBufLen)
 185:	83 ec 0c             	sub    $0xc,%esp
 188:	ff 73 10             	pushl  0x10(%ebx)
 18b:	e8 60 03 00 00       	call   4f0 <strlen>
 190:	8b 8d d8 f7 ff ff    	mov    -0x828(%ebp),%ecx
 196:	83 c4 10             	add    $0x10,%esp
 199:	01 c8                	add    %ecx,%eax
 19b:	39 85 dc f7 ff ff    	cmp    %eax,-0x824(%ebp)
 1a1:	73 0e                	jae    1b1 <main+0x1b1>
					{
						buf[i+insertPosition] = '\0';
 1a3:	8d 45 e8             	lea    -0x18(%ebp),%eax
 1a6:	8d 14 30             	lea    (%eax,%esi,1),%edx
 1a9:	c6 84 11 00 f8 ff ff 	movb   $0x0,-0x800(%ecx,%edx,1)
 1b0:	00 
				}
				buf[i+insertPosition] = '\0';
					
				
			}
			close(fd);
 1b1:	83 ec 0c             	sub    $0xc,%esp
 1b4:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
 1ba:	e8 1b 05 00 00       	call   6da <close>
			fd = open(argv[1], O_RDWR);	
 1bf:	5a                   	pop    %edx
 1c0:	59                   	pop    %ecx
 1c1:	6a 02                	push   $0x2
 1c3:	ff 73 04             	pushl  0x4(%ebx)
 1c6:	e8 27 05 00 00       	call   6f2 <open>
			n = write(fd, buf, strlen(buf) + 1);
 1cb:	8b bd e4 f7 ff ff    	mov    -0x81c(%ebp),%edi
				buf[i+insertPosition] = '\0';
					
				
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
 1d1:	89 c3                	mov    %eax,%ebx
 1d3:	89 85 e0 f7 ff ff    	mov    %eax,-0x820(%ebp)
			n = write(fd, buf, strlen(buf) + 1);
 1d9:	89 3c 24             	mov    %edi,(%esp)
 1dc:	e8 0f 03 00 00       	call   4f0 <strlen>
 1e1:	83 c4 0c             	add    $0xc,%esp
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	50                   	push   %eax
 1e8:	57                   	push   %edi
 1e9:	53                   	push   %ebx
 1ea:	e8 e3 04 00 00       	call   6d2 <write>
			if (n >= 0)
 1ef:	83 c4 10             	add    $0x10,%esp
 1f2:	85 c0                	test   %eax,%eax
 1f4:	78 11                	js     207 <main+0x207>
			{
				printf(1,"File update succeed\n");
 1f6:	50                   	push   %eax
 1f7:	50                   	push   %eax
 1f8:	68 4a 0b 00 00       	push   $0xb4a
 1fd:	6a 01                	push   $0x1
 1ff:	e8 1c 06 00 00       	call   820 <printf>
 204:	83 c4 10             	add    $0x10,%esp
			}
			
		}
		close(fd);
 207:	83 ec 0c             	sub    $0xc,%esp
 20a:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
 210:	e8 c5 04 00 00       	call   6da <close>
 215:	83 c4 10             	add    $0x10,%esp
 218:	e9 5d fe ff ff       	jmp    7a <main+0x7a>
			
		}
		close(fd);
		
	}
	else if(strcmp(argv[2], "app") == 0)
 21d:	50                   	push   %eax
 21e:	50                   	push   %eax
 21f:	68 7d 0b 00 00       	push   $0xb7d
 224:	ff 73 08             	pushl  0x8(%ebx)
 227:	e8 74 02 00 00       	call   4a0 <strcmp>
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	85 c0                	test   %eax,%eax
 231:	0f 85 9c 00 00 00    	jne    2d3 <main+0x2d3>
	{
		fd = open(argv[1], O_RDWR);		
 237:	57                   	push   %edi
 238:	57                   	push   %edi
 239:	6a 02                	push   $0x2
 23b:	ff 73 04             	pushl  0x4(%ebx)
 23e:	e8 af 04 00 00       	call   6f2 <open>
		if (fd >= 0)
 243:	83 c4 10             	add    $0x10,%esp
 246:	85 c0                	test   %eax,%eax
		close(fd);
		
	}
	else if(strcmp(argv[2], "app") == 0)
	{
		fd = open(argv[1], O_RDWR);		
 248:	89 85 e0 f7 ff ff    	mov    %eax,-0x820(%ebp)
		if (fd >= 0)
 24e:	78 b7                	js     207 <main+0x207>
		{			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
 250:	8d 8d e8 f7 ff ff    	lea    -0x818(%ebp),%ecx
 256:	56                   	push   %esi
 257:	68 00 08 00 00       	push   $0x800
 25c:	51                   	push   %ecx
 25d:	50                   	push   %eax
 25e:	89 ce                	mov    %ecx,%esi
 260:	89 8d e4 f7 ff ff    	mov    %ecx,-0x81c(%ebp)
 266:	e8 5f 04 00 00       	call   6ca <read>
			if (n >= 0)
 26b:	83 c4 10             	add    $0x10,%esp
 26e:	85 c0                	test   %eax,%eax
 270:	0f 88 3b ff ff ff    	js     1b1 <main+0x1b1>
			{
				
				int insertPosition = strlen(buf);
 276:	83 ec 0c             	sub    $0xc,%esp
				int i = 0;
				for (i = 0; i < strlen(buf);i++)
 279:	31 ff                	xor    %edi,%edi
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				
				int insertPosition = strlen(buf);
 27b:	56                   	push   %esi
 27c:	e8 6f 02 00 00       	call   4f0 <strlen>
				int i = 0;
				for (i = 0; i < strlen(buf);i++)
				{
					buf[i+insertPosition] = argv[3][i];
 281:	01 c6                	add    %eax,%esi
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				
				int insertPosition = strlen(buf);
 283:	89 85 dc f7 ff ff    	mov    %eax,-0x824(%ebp)
				int i = 0;
				for (i = 0; i < strlen(buf);i++)
 289:	83 c4 10             	add    $0x10,%esp
 28c:	89 f0                	mov    %esi,%eax
 28e:	89 fe                	mov    %edi,%esi
 290:	89 c7                	mov    %eax,%edi
 292:	eb 11                	jmp    2a5 <main+0x2a5>
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				{
					buf[i+insertPosition] = argv[3][i];
 298:	8b 43 0c             	mov    0xc(%ebx),%eax
 29b:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
 29f:	88 04 37             	mov    %al,(%edi,%esi,1)
			if (n >= 0)
			{
				
				int insertPosition = strlen(buf);
				int i = 0;
				for (i = 0; i < strlen(buf);i++)
 2a2:	83 c6 01             	add    $0x1,%esi
 2a5:	83 ec 0c             	sub    $0xc,%esp
 2a8:	ff b5 e4 f7 ff ff    	pushl  -0x81c(%ebp)
 2ae:	e8 3d 02 00 00       	call   4f0 <strlen>
 2b3:	83 c4 10             	add    $0x10,%esp
 2b6:	39 f0                	cmp    %esi,%eax
 2b8:	77 de                	ja     298 <main+0x298>
				{
					buf[i+insertPosition] = argv[3][i];
				}
				buf[i+insertPosition] = '\0';
 2ba:	8d 45 e8             	lea    -0x18(%ebp),%eax
 2bd:	8d 14 30             	lea    (%eax,%esi,1),%edx
 2c0:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
 2c6:	c6 84 10 00 f8 ff ff 	movb   $0x0,-0x800(%eax,%edx,1)
 2cd:	00 
 2ce:	e9 de fe ff ff       	jmp    1b1 <main+0x1b1>
			
		}
		close(fd);
		
	}
	else if(strcmp(argv[2], "del") == 0)
 2d3:	50                   	push   %eax
 2d4:	50                   	push   %eax
 2d5:	68 81 0b 00 00       	push   $0xb81
 2da:	ff 73 08             	pushl  0x8(%ebx)
 2dd:	e8 be 01 00 00       	call   4a0 <strcmp>
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	0f 85 cd 00 00 00    	jne    3ba <main+0x3ba>
	{
		fd = open(argv[1], O_RDWR);		
 2ed:	50                   	push   %eax
 2ee:	50                   	push   %eax
 2ef:	6a 02                	push   $0x2
 2f1:	ff 73 04             	pushl  0x4(%ebx)
 2f4:	e8 f9 03 00 00       	call   6f2 <open>
		if (fd >= 0)
 2f9:	83 c4 10             	add    $0x10,%esp
 2fc:	85 c0                	test   %eax,%eax
		close(fd);
		
	}
	else if(strcmp(argv[2], "del") == 0)
	{
		fd = open(argv[1], O_RDWR);		
 2fe:	89 c6                	mov    %eax,%esi
		if (fd >= 0)
 300:	0f 88 ba fd ff ff    	js     c0 <main+0xc0>
		{
			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
 306:	50                   	push   %eax
 307:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
 30d:	68 00 08 00 00       	push   $0x800
 312:	50                   	push   %eax
 313:	56                   	push   %esi
 314:	89 c7                	mov    %eax,%edi
 316:	89 85 e4 f7 ff ff    	mov    %eax,-0x81c(%ebp)
 31c:	e8 a9 03 00 00       	call   6ca <read>
			if (n >= 0)
 321:	83 c4 10             	add    $0x10,%esp
 324:	85 c0                	test   %eax,%eax
 326:	0f 88 ec 00 00 00    	js     418 <main+0x418>
			{
				int originalBufLen = strlen(buf);
 32c:	83 ec 0c             	sub    $0xc,%esp
 32f:	89 bd e4 f7 ff ff    	mov    %edi,-0x81c(%ebp)
 335:	57                   	push   %edi
 336:	e8 b5 01 00 00       	call   4f0 <strlen>
 33b:	89 c7                	mov    %eax,%edi
				int deletePosition = atoi(argv[3]);
 33d:	58                   	pop    %eax
 33e:	ff 73 0c             	pushl  0xc(%ebx)
 341:	e8 fa 02 00 00       	call   640 <atoi>
 346:	89 85 e0 f7 ff ff    	mov    %eax,-0x820(%ebp)
				int deleteAmount = atoi(argv[4]);
 34c:	58                   	pop    %eax
 34d:	ff 73 10             	pushl  0x10(%ebx)
 350:	e8 eb 02 00 00       	call   640 <atoi>
				if (deletePosition < originalBufLen)
 355:	8b 8d e0 f7 ff ff    	mov    -0x820(%ebp),%ecx
 35b:	83 c4 10             	add    $0x10,%esp
 35e:	39 cf                	cmp    %ecx,%edi
 360:	0f 8e f7 00 00 00    	jle    45d <main+0x45d>
 366:	89 b5 dc f7 ff ff    	mov    %esi,-0x824(%ebp)
 36c:	8b b5 e4 f7 ff ff    	mov    -0x81c(%ebp),%esi
 372:	8d 51 01             	lea    0x1(%ecx),%edx
 375:	89 9d d8 f7 ff ff    	mov    %ebx,-0x828(%ebp)
 37b:	31 ff                	xor    %edi,%edi
 37d:	89 c3                	mov    %eax,%ebx
				{
					int i = 0;
					int j = 0;
					for (i = 0; i < deleteAmount;i++)
 37f:	39 df                	cmp    %ebx,%edi
 381:	0f 8d 85 00 00 00    	jge    40c <main+0x40c>
					{
						for (j = deletePosition; buf[j]; j++)
 387:	80 bc 0d e8 f7 ff ff 	cmpb   $0x0,-0x818(%ebp,%ecx,1)
 38e:	00 
 38f:	8d 04 16             	lea    (%esi,%edx,1),%eax
 392:	74 21                	je     3b5 <main+0x3b5>
 394:	89 95 e0 f7 ff ff    	mov    %edx,-0x820(%ebp)
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
						{
							buf[j] = buf[j+1];
 3a0:	0f b6 10             	movzbl (%eax),%edx
 3a3:	83 c0 01             	add    $0x1,%eax
 3a6:	88 50 fe             	mov    %dl,-0x2(%eax)
				{
					int i = 0;
					int j = 0;
					for (i = 0; i < deleteAmount;i++)
					{
						for (j = deletePosition; buf[j]; j++)
 3a9:	80 78 ff 00          	cmpb   $0x0,-0x1(%eax)
 3ad:	75 f1                	jne    3a0 <main+0x3a0>
 3af:	8b 95 e0 f7 ff ff    	mov    -0x820(%ebp),%edx
				int deleteAmount = atoi(argv[4]);
				if (deletePosition < originalBufLen)
				{
					int i = 0;
					int j = 0;
					for (i = 0; i < deleteAmount;i++)
 3b5:	83 c7 01             	add    $0x1,%edi
 3b8:	eb c5                	jmp    37f <main+0x37f>
		
	}	
	
	else
	{
		printf(1,"There is no such method in 'ef'.\n");
 3ba:	50                   	push   %eax
 3bb:	50                   	push   %eax
 3bc:	68 a0 0b 00 00       	push   $0xba0
 3c1:	6a 01                	push   $0x1
 3c3:	e8 58 04 00 00       	call   820 <printf>
 3c8:	83 c4 10             	add    $0x10,%esp
 3cb:	e9 aa fc ff ff       	jmp    7a <main+0x7a>
		fd = open(argv[1], O_RDWR);
		if(fd >= 0)
		{
			if(strlen(argv[3]) > 0)
			{
				int n = write(fd, argv[3], strlen(argv[3]) + 1);
 3d0:	83 ec 0c             	sub    $0xc,%esp
 3d3:	ff 73 0c             	pushl  0xc(%ebx)
 3d6:	e8 15 01 00 00       	call   4f0 <strlen>
 3db:	83 c4 0c             	add    $0xc,%esp
 3de:	83 c0 01             	add    $0x1,%eax
 3e1:	50                   	push   %eax
 3e2:	ff 73 0c             	pushl  0xc(%ebx)
					printf(1,"Illegal delete position.\n");
				}
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
			n = write(fd, buf, strlen(buf) + 1);
 3e5:	56                   	push   %esi
 3e6:	e8 e7 02 00 00       	call   6d2 <write>
			if (n >= 0)
 3eb:	83 c4 10             	add    $0x10,%esp
 3ee:	85 c0                	test   %eax,%eax
 3f0:	0f 88 ca fc ff ff    	js     c0 <main+0xc0>
			{
				printf(1,"File update succeed\n");
 3f6:	52                   	push   %edx
 3f7:	52                   	push   %edx
 3f8:	68 4a 0b 00 00       	push   $0xb4a
 3fd:	6a 01                	push   $0x1
 3ff:	e8 1c 04 00 00       	call   820 <printf>
 404:	83 c4 10             	add    $0x10,%esp
 407:	e9 b4 fc ff ff       	jmp    c0 <main+0xc0>
 40c:	8b b5 dc f7 ff ff    	mov    -0x824(%ebp),%esi
 412:	8b 9d d8 f7 ff ff    	mov    -0x828(%ebp),%ebx
				else
				{
					printf(1,"Illegal delete position.\n");
				}
			}
			close(fd);
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	56                   	push   %esi
 41c:	e8 b9 02 00 00       	call   6da <close>
			fd = open(argv[1], O_RDWR);	
 421:	59                   	pop    %ecx
 422:	5e                   	pop    %esi
 423:	6a 02                	push   $0x2
 425:	ff 73 04             	pushl  0x4(%ebx)
 428:	e8 c5 02 00 00       	call   6f2 <open>
			n = write(fd, buf, strlen(buf) + 1);
 42d:	8b bd e4 f7 ff ff    	mov    -0x81c(%ebp),%edi
				{
					printf(1,"Illegal delete position.\n");
				}
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
 433:	89 c6                	mov    %eax,%esi
			n = write(fd, buf, strlen(buf) + 1);
 435:	89 3c 24             	mov    %edi,(%esp)
 438:	e8 b3 00 00 00       	call   4f0 <strlen>
 43d:	83 c4 0c             	add    $0xc,%esp
 440:	83 c0 01             	add    $0x1,%eax
 443:	50                   	push   %eax
 444:	57                   	push   %edi
 445:	eb 9e                	jmp    3e5 <main+0x3e5>
						buf[i+insertPosition] = '\0';
					}		
				}
				else
				{
					printf(1,"Illegal insert position.\n");
 447:	50                   	push   %eax
 448:	50                   	push   %eax
 449:	68 63 0b 00 00       	push   $0xb63
 44e:	6a 01                	push   $0x1
 450:	e8 cb 03 00 00       	call   820 <printf>
 455:	83 c4 10             	add    $0x10,%esp
 458:	e9 54 fd ff ff       	jmp    1b1 <main+0x1b1>
					}
	
				}
				else
				{
					printf(1,"Illegal delete position.\n");
 45d:	57                   	push   %edi
 45e:	57                   	push   %edi
 45f:	68 85 0b 00 00       	push   $0xb85
 464:	6a 01                	push   $0x1
 466:	e8 b5 03 00 00       	call   820 <printf>
 46b:	83 c4 10             	add    $0x10,%esp
 46e:	eb a8                	jmp    418 <main+0x418>

00000470 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	53                   	push   %ebx
 474:	8b 45 08             	mov    0x8(%ebp),%eax
 477:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 47a:	89 c2                	mov    %eax,%edx
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 480:	83 c1 01             	add    $0x1,%ecx
 483:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 487:	83 c2 01             	add    $0x1,%edx
 48a:	84 db                	test   %bl,%bl
 48c:	88 5a ff             	mov    %bl,-0x1(%edx)
 48f:	75 ef                	jne    480 <strcpy+0x10>
    ;
  return os;
}
 491:	5b                   	pop    %ebx
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 49a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000004a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	56                   	push   %esi
 4a4:	53                   	push   %ebx
 4a5:	8b 55 08             	mov    0x8(%ebp),%edx
 4a8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4ab:	0f b6 02             	movzbl (%edx),%eax
 4ae:	0f b6 19             	movzbl (%ecx),%ebx
 4b1:	84 c0                	test   %al,%al
 4b3:	75 1e                	jne    4d3 <strcmp+0x33>
 4b5:	eb 29                	jmp    4e0 <strcmp+0x40>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 4c0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 4c6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4c9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 4cd:	84 c0                	test   %al,%al
 4cf:	74 0f                	je     4e0 <strcmp+0x40>
 4d1:	89 f1                	mov    %esi,%ecx
 4d3:	38 d8                	cmp    %bl,%al
 4d5:	74 e9                	je     4c0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 4d7:	29 d8                	sub    %ebx,%eax
}
 4d9:	5b                   	pop    %ebx
 4da:	5e                   	pop    %esi
 4db:	5d                   	pop    %ebp
 4dc:	c3                   	ret    
 4dd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 4e0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 4e2:	29 d8                	sub    %ebx,%eax
}
 4e4:	5b                   	pop    %ebx
 4e5:	5e                   	pop    %esi
 4e6:	5d                   	pop    %ebp
 4e7:	c3                   	ret    
 4e8:	90                   	nop
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <strlen>:

uint
strlen(const char *s)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 4f6:	80 39 00             	cmpb   $0x0,(%ecx)
 4f9:	74 12                	je     50d <strlen+0x1d>
 4fb:	31 d2                	xor    %edx,%edx
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	83 c2 01             	add    $0x1,%edx
 503:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 507:	89 d0                	mov    %edx,%eax
 509:	75 f5                	jne    500 <strlen+0x10>
    ;
  return n;
}
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 50d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 50f:	5d                   	pop    %ebp
 510:	c3                   	ret    
 511:	eb 0d                	jmp    520 <memset>
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

00000520 <memset>:

void*
memset(void *dst, int c, uint n)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 527:	8b 4d 10             	mov    0x10(%ebp),%ecx
 52a:	8b 45 0c             	mov    0xc(%ebp),%eax
 52d:	89 d7                	mov    %edx,%edi
 52f:	fc                   	cld    
 530:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 532:	89 d0                	mov    %edx,%eax
 534:	5f                   	pop    %edi
 535:	5d                   	pop    %ebp
 536:	c3                   	ret    
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <strchr>:

char*
strchr(const char *s, char c)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	53                   	push   %ebx
 544:	8b 45 08             	mov    0x8(%ebp),%eax
 547:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 54a:	0f b6 10             	movzbl (%eax),%edx
 54d:	84 d2                	test   %dl,%dl
 54f:	74 1d                	je     56e <strchr+0x2e>
    if(*s == c)
 551:	38 d3                	cmp    %dl,%bl
 553:	89 d9                	mov    %ebx,%ecx
 555:	75 0d                	jne    564 <strchr+0x24>
 557:	eb 17                	jmp    570 <strchr+0x30>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 560:	38 ca                	cmp    %cl,%dl
 562:	74 0c                	je     570 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 564:	83 c0 01             	add    $0x1,%eax
 567:	0f b6 10             	movzbl (%eax),%edx
 56a:	84 d2                	test   %dl,%dl
 56c:	75 f2                	jne    560 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 56e:	31 c0                	xor    %eax,%eax
}
 570:	5b                   	pop    %ebx
 571:	5d                   	pop    %ebp
 572:	c3                   	ret    
 573:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000580 <gets>:

char*
gets(char *buf, int max)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	56                   	push   %esi
 585:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 586:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 588:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 58b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 58e:	eb 29                	jmp    5b9 <gets+0x39>
    cc = read(0, &c, 1);
 590:	83 ec 04             	sub    $0x4,%esp
 593:	6a 01                	push   $0x1
 595:	57                   	push   %edi
 596:	6a 00                	push   $0x0
 598:	e8 2d 01 00 00       	call   6ca <read>
    if(cc < 1)
 59d:	83 c4 10             	add    $0x10,%esp
 5a0:	85 c0                	test   %eax,%eax
 5a2:	7e 1d                	jle    5c1 <gets+0x41>
      break;
    buf[i++] = c;
 5a4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 5a8:	8b 55 08             	mov    0x8(%ebp),%edx
 5ab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 5ad:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 5af:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 5b3:	74 1b                	je     5d0 <gets+0x50>
 5b5:	3c 0d                	cmp    $0xd,%al
 5b7:	74 17                	je     5d0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5b9:	8d 5e 01             	lea    0x1(%esi),%ebx
 5bc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 5bf:	7c cf                	jl     590 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5c1:	8b 45 08             	mov    0x8(%ebp),%eax
 5c4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 5c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5cb:	5b                   	pop    %ebx
 5cc:	5e                   	pop    %esi
 5cd:	5f                   	pop    %edi
 5ce:	5d                   	pop    %ebp
 5cf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5d0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5d3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 5d5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 5d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5dc:	5b                   	pop    %ebx
 5dd:	5e                   	pop    %esi
 5de:	5f                   	pop    %edi
 5df:	5d                   	pop    %ebp
 5e0:	c3                   	ret    
 5e1:	eb 0d                	jmp    5f0 <stat>
 5e3:	90                   	nop
 5e4:	90                   	nop
 5e5:	90                   	nop
 5e6:	90                   	nop
 5e7:	90                   	nop
 5e8:	90                   	nop
 5e9:	90                   	nop
 5ea:	90                   	nop
 5eb:	90                   	nop
 5ec:	90                   	nop
 5ed:	90                   	nop
 5ee:	90                   	nop
 5ef:	90                   	nop

000005f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	56                   	push   %esi
 5f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5f5:	83 ec 08             	sub    $0x8,%esp
 5f8:	6a 00                	push   $0x0
 5fa:	ff 75 08             	pushl  0x8(%ebp)
 5fd:	e8 f0 00 00 00       	call   6f2 <open>
  if(fd < 0)
 602:	83 c4 10             	add    $0x10,%esp
 605:	85 c0                	test   %eax,%eax
 607:	78 27                	js     630 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 609:	83 ec 08             	sub    $0x8,%esp
 60c:	ff 75 0c             	pushl  0xc(%ebp)
 60f:	89 c3                	mov    %eax,%ebx
 611:	50                   	push   %eax
 612:	e8 f3 00 00 00       	call   70a <fstat>
 617:	89 c6                	mov    %eax,%esi
  close(fd);
 619:	89 1c 24             	mov    %ebx,(%esp)
 61c:	e8 b9 00 00 00       	call   6da <close>
  return r;
 621:	83 c4 10             	add    $0x10,%esp
 624:	89 f0                	mov    %esi,%eax
}
 626:	8d 65 f8             	lea    -0x8(%ebp),%esp
 629:	5b                   	pop    %ebx
 62a:	5e                   	pop    %esi
 62b:	5d                   	pop    %ebp
 62c:	c3                   	ret    
 62d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 635:	eb ef                	jmp    626 <stat+0x36>
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	53                   	push   %ebx
 644:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 647:	0f be 11             	movsbl (%ecx),%edx
 64a:	8d 42 d0             	lea    -0x30(%edx),%eax
 64d:	3c 09                	cmp    $0x9,%al
 64f:	b8 00 00 00 00       	mov    $0x0,%eax
 654:	77 1f                	ja     675 <atoi+0x35>
 656:	8d 76 00             	lea    0x0(%esi),%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 660:	8d 04 80             	lea    (%eax,%eax,4),%eax
 663:	83 c1 01             	add    $0x1,%ecx
 666:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 66a:	0f be 11             	movsbl (%ecx),%edx
 66d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 670:	80 fb 09             	cmp    $0x9,%bl
 673:	76 eb                	jbe    660 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 675:	5b                   	pop    %ebx
 676:	5d                   	pop    %ebp
 677:	c3                   	ret    
 678:	90                   	nop
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000680 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	56                   	push   %esi
 684:	53                   	push   %ebx
 685:	8b 5d 10             	mov    0x10(%ebp),%ebx
 688:	8b 45 08             	mov    0x8(%ebp),%eax
 68b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 68e:	85 db                	test   %ebx,%ebx
 690:	7e 14                	jle    6a6 <memmove+0x26>
 692:	31 d2                	xor    %edx,%edx
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 698:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 69c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 69f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6a2:	39 da                	cmp    %ebx,%edx
 6a4:	75 f2                	jne    698 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 6a6:	5b                   	pop    %ebx
 6a7:	5e                   	pop    %esi
 6a8:	5d                   	pop    %ebp
 6a9:	c3                   	ret    

000006aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6aa:	b8 01 00 00 00       	mov    $0x1,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <exit>:
SYSCALL(exit)
 6b2:	b8 02 00 00 00       	mov    $0x2,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <wait>:
SYSCALL(wait)
 6ba:	b8 03 00 00 00       	mov    $0x3,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <pipe>:
SYSCALL(pipe)
 6c2:	b8 04 00 00 00       	mov    $0x4,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <read>:
SYSCALL(read)
 6ca:	b8 05 00 00 00       	mov    $0x5,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <write>:
SYSCALL(write)
 6d2:	b8 10 00 00 00       	mov    $0x10,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <close>:
SYSCALL(close)
 6da:	b8 15 00 00 00       	mov    $0x15,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <kill>:
SYSCALL(kill)
 6e2:	b8 06 00 00 00       	mov    $0x6,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <exec>:
SYSCALL(exec)
 6ea:	b8 07 00 00 00       	mov    $0x7,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <open>:
SYSCALL(open)
 6f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <mknod>:
SYSCALL(mknod)
 6fa:	b8 11 00 00 00       	mov    $0x11,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <unlink>:
SYSCALL(unlink)
 702:	b8 12 00 00 00       	mov    $0x12,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <fstat>:
SYSCALL(fstat)
 70a:	b8 08 00 00 00       	mov    $0x8,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <link>:
SYSCALL(link)
 712:	b8 13 00 00 00       	mov    $0x13,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <mkdir>:
SYSCALL(mkdir)
 71a:	b8 14 00 00 00       	mov    $0x14,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <chdir>:
SYSCALL(chdir)
 722:	b8 09 00 00 00       	mov    $0x9,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <dup>:
SYSCALL(dup)
 72a:	b8 0a 00 00 00       	mov    $0xa,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <getpid>:
SYSCALL(getpid)
 732:	b8 0b 00 00 00       	mov    $0xb,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    

0000073a <sbrk>:
SYSCALL(sbrk)
 73a:	b8 0c 00 00 00       	mov    $0xc,%eax
 73f:	cd 40                	int    $0x40
 741:	c3                   	ret    

00000742 <sleep>:
SYSCALL(sleep)
 742:	b8 0d 00 00 00       	mov    $0xd,%eax
 747:	cd 40                	int    $0x40
 749:	c3                   	ret    

0000074a <uptime>:
SYSCALL(uptime)
 74a:	b8 0e 00 00 00       	mov    $0xe,%eax
 74f:	cd 40                	int    $0x40
 751:	c3                   	ret    

00000752 <cps>:
SYSCALL(cps)
 752:	b8 16 00 00 00       	mov    $0x16,%eax
 757:	cd 40                	int    $0x40
 759:	c3                   	ret    

0000075a <userTag>:
SYSCALL(userTag)
 75a:	b8 17 00 00 00       	mov    $0x17,%eax
 75f:	cd 40                	int    $0x40
 761:	c3                   	ret    

00000762 <changeUser>:
SYSCALL(changeUser)
 762:	b8 18 00 00 00       	mov    $0x18,%eax
 767:	cd 40                	int    $0x40
 769:	c3                   	ret    

0000076a <getUser>:
SYSCALL(getUser)
 76a:	b8 19 00 00 00       	mov    $0x19,%eax
 76f:	cd 40                	int    $0x40
 771:	c3                   	ret    

00000772 <changeOwner>:
SYSCALL(changeOwner)
 772:	b8 1a 00 00 00       	mov    $0x1a,%eax
 777:	cd 40                	int    $0x40
 779:	c3                   	ret    
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	89 c6                	mov    %eax,%esi
 788:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 78e:	85 db                	test   %ebx,%ebx
 790:	74 7e                	je     810 <printint+0x90>
 792:	89 d0                	mov    %edx,%eax
 794:	c1 e8 1f             	shr    $0x1f,%eax
 797:	84 c0                	test   %al,%al
 799:	74 75                	je     810 <printint+0x90>
    neg = 1;
    x = -xx;
 79b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 79d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 7a4:	f7 d8                	neg    %eax
 7a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 7a9:	31 ff                	xor    %edi,%edi
 7ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 7ae:	89 ce                	mov    %ecx,%esi
 7b0:	eb 08                	jmp    7ba <printint+0x3a>
 7b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 7b8:	89 cf                	mov    %ecx,%edi
 7ba:	31 d2                	xor    %edx,%edx
 7bc:	8d 4f 01             	lea    0x1(%edi),%ecx
 7bf:	f7 f6                	div    %esi
 7c1:	0f b6 92 cc 0b 00 00 	movzbl 0xbcc(%edx),%edx
  }while((x /= base) != 0);
 7c8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 7ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 7cd:	75 e9                	jne    7b8 <printint+0x38>
  if(neg)
 7cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 7d5:	85 c0                	test   %eax,%eax
 7d7:	74 08                	je     7e1 <printint+0x61>
    buf[i++] = '-';
 7d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 7de:	8d 4f 02             	lea    0x2(%edi),%ecx
 7e1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 7e5:	8d 76 00             	lea    0x0(%esi),%esi
 7e8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7eb:	83 ec 04             	sub    $0x4,%esp
 7ee:	83 ef 01             	sub    $0x1,%edi
 7f1:	6a 01                	push   $0x1
 7f3:	53                   	push   %ebx
 7f4:	56                   	push   %esi
 7f5:	88 45 d7             	mov    %al,-0x29(%ebp)
 7f8:	e8 d5 fe ff ff       	call   6d2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7fd:	83 c4 10             	add    $0x10,%esp
 800:	39 df                	cmp    %ebx,%edi
 802:	75 e4                	jne    7e8 <printint+0x68>
    putc(fd, buf[i]);
}
 804:	8d 65 f4             	lea    -0xc(%ebp),%esp
 807:	5b                   	pop    %ebx
 808:	5e                   	pop    %esi
 809:	5f                   	pop    %edi
 80a:	5d                   	pop    %ebp
 80b:	c3                   	ret    
 80c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 810:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 812:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 819:	eb 8b                	jmp    7a6 <printint+0x26>
 81b:	90                   	nop
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000820 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	57                   	push   %edi
 824:	56                   	push   %esi
 825:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 826:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 829:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 82c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 82f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 832:	89 45 d0             	mov    %eax,-0x30(%ebp)
 835:	0f b6 1e             	movzbl (%esi),%ebx
 838:	83 c6 01             	add    $0x1,%esi
 83b:	84 db                	test   %bl,%bl
 83d:	0f 84 b0 00 00 00    	je     8f3 <printf+0xd3>
 843:	31 d2                	xor    %edx,%edx
 845:	eb 39                	jmp    880 <printf+0x60>
 847:	89 f6                	mov    %esi,%esi
 849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 850:	83 f8 25             	cmp    $0x25,%eax
 853:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 856:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 85b:	74 18                	je     875 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 85d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 860:	83 ec 04             	sub    $0x4,%esp
 863:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 866:	6a 01                	push   $0x1
 868:	50                   	push   %eax
 869:	57                   	push   %edi
 86a:	e8 63 fe ff ff       	call   6d2 <write>
 86f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 872:	83 c4 10             	add    $0x10,%esp
 875:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 878:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 87c:	84 db                	test   %bl,%bl
 87e:	74 73                	je     8f3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 880:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 882:	0f be cb             	movsbl %bl,%ecx
 885:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 888:	74 c6                	je     850 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 88a:	83 fa 25             	cmp    $0x25,%edx
 88d:	75 e6                	jne    875 <printf+0x55>
      if(c == 'd'){
 88f:	83 f8 64             	cmp    $0x64,%eax
 892:	0f 84 f8 00 00 00    	je     990 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 898:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 89e:	83 f9 70             	cmp    $0x70,%ecx
 8a1:	74 5d                	je     900 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 8a3:	83 f8 73             	cmp    $0x73,%eax
 8a6:	0f 84 84 00 00 00    	je     930 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8ac:	83 f8 63             	cmp    $0x63,%eax
 8af:	0f 84 ea 00 00 00    	je     99f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 8b5:	83 f8 25             	cmp    $0x25,%eax
 8b8:	0f 84 c2 00 00 00    	je     980 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8c1:	83 ec 04             	sub    $0x4,%esp
 8c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8c8:	6a 01                	push   $0x1
 8ca:	50                   	push   %eax
 8cb:	57                   	push   %edi
 8cc:	e8 01 fe ff ff       	call   6d2 <write>
 8d1:	83 c4 0c             	add    $0xc,%esp
 8d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8da:	6a 01                	push   $0x1
 8dc:	50                   	push   %eax
 8dd:	57                   	push   %edi
 8de:	83 c6 01             	add    $0x1,%esi
 8e1:	e8 ec fd ff ff       	call   6d2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ed:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8ef:	84 db                	test   %bl,%bl
 8f1:	75 8d                	jne    880 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8f6:	5b                   	pop    %ebx
 8f7:	5e                   	pop    %esi
 8f8:	5f                   	pop    %edi
 8f9:	5d                   	pop    %ebp
 8fa:	c3                   	ret    
 8fb:	90                   	nop
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 900:	83 ec 0c             	sub    $0xc,%esp
 903:	b9 10 00 00 00       	mov    $0x10,%ecx
 908:	6a 00                	push   $0x0
 90a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 90d:	89 f8                	mov    %edi,%eax
 90f:	8b 13                	mov    (%ebx),%edx
 911:	e8 6a fe ff ff       	call   780 <printint>
        ap++;
 916:	89 d8                	mov    %ebx,%eax
 918:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 91b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 91d:	83 c0 04             	add    $0x4,%eax
 920:	89 45 d0             	mov    %eax,-0x30(%ebp)
 923:	e9 4d ff ff ff       	jmp    875 <printf+0x55>
 928:	90                   	nop
 929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 930:	8b 45 d0             	mov    -0x30(%ebp),%eax
 933:	8b 18                	mov    (%eax),%ebx
        ap++;
 935:	83 c0 04             	add    $0x4,%eax
 938:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 93b:	b8 c4 0b 00 00       	mov    $0xbc4,%eax
 940:	85 db                	test   %ebx,%ebx
 942:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 945:	0f b6 03             	movzbl (%ebx),%eax
 948:	84 c0                	test   %al,%al
 94a:	74 23                	je     96f <printf+0x14f>
 94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 950:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 953:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 956:	83 ec 04             	sub    $0x4,%esp
 959:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 95b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 95e:	50                   	push   %eax
 95f:	57                   	push   %edi
 960:	e8 6d fd ff ff       	call   6d2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 965:	0f b6 03             	movzbl (%ebx),%eax
 968:	83 c4 10             	add    $0x10,%esp
 96b:	84 c0                	test   %al,%al
 96d:	75 e1                	jne    950 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 96f:	31 d2                	xor    %edx,%edx
 971:	e9 ff fe ff ff       	jmp    875 <printf+0x55>
 976:	8d 76 00             	lea    0x0(%esi),%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 980:	83 ec 04             	sub    $0x4,%esp
 983:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 986:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 989:	6a 01                	push   $0x1
 98b:	e9 4c ff ff ff       	jmp    8dc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 990:	83 ec 0c             	sub    $0xc,%esp
 993:	b9 0a 00 00 00       	mov    $0xa,%ecx
 998:	6a 01                	push   $0x1
 99a:	e9 6b ff ff ff       	jmp    90a <printf+0xea>
 99f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 9a2:	83 ec 04             	sub    $0x4,%esp
 9a5:	8b 03                	mov    (%ebx),%eax
 9a7:	6a 01                	push   $0x1
 9a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 9ac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9af:	50                   	push   %eax
 9b0:	57                   	push   %edi
 9b1:	e8 1c fd ff ff       	call   6d2 <write>
 9b6:	e9 5b ff ff ff       	jmp    916 <printf+0xf6>
 9bb:	66 90                	xchg   %ax,%ax
 9bd:	66 90                	xchg   %ax,%ax
 9bf:	90                   	nop

000009c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c1:	a1 70 0e 00 00       	mov    0xe70,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 9c6:	89 e5                	mov    %esp,%ebp
 9c8:	57                   	push   %edi
 9c9:	56                   	push   %esi
 9ca:	53                   	push   %ebx
 9cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d3:	39 c8                	cmp    %ecx,%eax
 9d5:	73 19                	jae    9f0 <free+0x30>
 9d7:	89 f6                	mov    %esi,%esi
 9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 9e0:	39 d1                	cmp    %edx,%ecx
 9e2:	72 1c                	jb     a00 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9e4:	39 d0                	cmp    %edx,%eax
 9e6:	73 18                	jae    a00 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ee:	72 f0                	jb     9e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f0:	39 d0                	cmp    %edx,%eax
 9f2:	72 f4                	jb     9e8 <free+0x28>
 9f4:	39 d1                	cmp    %edx,%ecx
 9f6:	73 f0                	jae    9e8 <free+0x28>
 9f8:	90                   	nop
 9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 a00:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a03:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a06:	39 d7                	cmp    %edx,%edi
 a08:	74 19                	je     a23 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a0d:	8b 50 04             	mov    0x4(%eax),%edx
 a10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a13:	39 f1                	cmp    %esi,%ecx
 a15:	74 23                	je     a3a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a17:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a19:	a3 70 0e 00 00       	mov    %eax,0xe70
}
 a1e:	5b                   	pop    %ebx
 a1f:	5e                   	pop    %esi
 a20:	5f                   	pop    %edi
 a21:	5d                   	pop    %ebp
 a22:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a23:	03 72 04             	add    0x4(%edx),%esi
 a26:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a29:	8b 10                	mov    (%eax),%edx
 a2b:	8b 12                	mov    (%edx),%edx
 a2d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a30:	8b 50 04             	mov    0x4(%eax),%edx
 a33:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a36:	39 f1                	cmp    %esi,%ecx
 a38:	75 dd                	jne    a17 <free+0x57>
    p->s.size += bp->s.size;
 a3a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 a3d:	a3 70 0e 00 00       	mov    %eax,0xe70
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a42:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a45:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a48:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a4a:	5b                   	pop    %ebx
 a4b:	5e                   	pop    %esi
 a4c:	5f                   	pop    %edi
 a4d:	5d                   	pop    %ebp
 a4e:	c3                   	ret    
 a4f:	90                   	nop

00000a50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a5c:	8b 15 70 0e 00 00    	mov    0xe70,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a62:	8d 78 07             	lea    0x7(%eax),%edi
 a65:	c1 ef 03             	shr    $0x3,%edi
 a68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a6b:	85 d2                	test   %edx,%edx
 a6d:	0f 84 a3 00 00 00    	je     b16 <malloc+0xc6>
 a73:	8b 02                	mov    (%edx),%eax
 a75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a78:	39 cf                	cmp    %ecx,%edi
 a7a:	76 74                	jbe    af0 <malloc+0xa0>
 a7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a82:	be 00 10 00 00       	mov    $0x1000,%esi
 a87:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 a8e:	0f 43 f7             	cmovae %edi,%esi
 a91:	ba 00 80 00 00       	mov    $0x8000,%edx
 a96:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 a9c:	0f 46 da             	cmovbe %edx,%ebx
 a9f:	eb 10                	jmp    ab1 <malloc+0x61>
 aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aaa:	8b 48 04             	mov    0x4(%eax),%ecx
 aad:	39 cf                	cmp    %ecx,%edi
 aaf:	76 3f                	jbe    af0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab1:	39 05 70 0e 00 00    	cmp    %eax,0xe70
 ab7:	89 c2                	mov    %eax,%edx
 ab9:	75 ed                	jne    aa8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 abb:	83 ec 0c             	sub    $0xc,%esp
 abe:	53                   	push   %ebx
 abf:	e8 76 fc ff ff       	call   73a <sbrk>
  if(p == (char*)-1)
 ac4:	83 c4 10             	add    $0x10,%esp
 ac7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aca:	74 1c                	je     ae8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 acc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 acf:	83 ec 0c             	sub    $0xc,%esp
 ad2:	83 c0 08             	add    $0x8,%eax
 ad5:	50                   	push   %eax
 ad6:	e8 e5 fe ff ff       	call   9c0 <free>
  return freep;
 adb:	8b 15 70 0e 00 00    	mov    0xe70,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 ae1:	83 c4 10             	add    $0x10,%esp
 ae4:	85 d2                	test   %edx,%edx
 ae6:	75 c0                	jne    aa8 <malloc+0x58>
        return 0;
 ae8:	31 c0                	xor    %eax,%eax
 aea:	eb 1c                	jmp    b08 <malloc+0xb8>
 aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 af0:	39 cf                	cmp    %ecx,%edi
 af2:	74 1c                	je     b10 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 af4:	29 f9                	sub    %edi,%ecx
 af6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 af9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 afc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 aff:	89 15 70 0e 00 00    	mov    %edx,0xe70
      return (void*)(p + 1);
 b05:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b0b:	5b                   	pop    %ebx
 b0c:	5e                   	pop    %esi
 b0d:	5f                   	pop    %edi
 b0e:	5d                   	pop    %ebp
 b0f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 b10:	8b 08                	mov    (%eax),%ecx
 b12:	89 0a                	mov    %ecx,(%edx)
 b14:	eb e9                	jmp    aff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 b16:	c7 05 70 0e 00 00 74 	movl   $0xe74,0xe70
 b1d:	0e 00 00 
 b20:	c7 05 74 0e 00 00 74 	movl   $0xe74,0xe74
 b27:	0e 00 00 
    base.s.size = 0;
 b2a:	b8 74 0e 00 00       	mov    $0xe74,%eax
 b2f:	c7 05 78 0e 00 00 00 	movl   $0x0,0xe78
 b36:	00 00 00 
 b39:	e9 3e ff ff ff       	jmp    a7c <malloc+0x2c>
