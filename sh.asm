
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	56                   	push   %esi
       e:	53                   	push   %ebx
       f:	51                   	push   %ecx
      10:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      16:	eb 11                	jmp    29 <main+0x29>
      18:	90                   	nop
      19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      20:	83 f8 02             	cmp    $0x2,%eax
      23:	0f 8f 3b 01 00 00    	jg     164 <main+0x164>
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      29:	83 ec 08             	sub    $0x8,%esp
      2c:	6a 02                	push   $0x2
      2e:	68 1f 15 00 00       	push   $0x151f
      33:	e8 ba 0f 00 00       	call   ff2 <open>
      38:	83 c4 10             	add    $0x10,%esp
      3b:	85 c0                	test   %eax,%eax
      3d:	79 e1                	jns    20 <main+0x20>
    }
  }

  // Login process
  static int isLogin = 0;
  if (isLogin == 0)
      3f:	8b 0d 44 1c 00 00    	mov    0x1c44,%ecx
      45:	85 c9                	test   %ecx,%ecx
      47:	0f 85 9a 00 00 00    	jne    e7 <main+0xe7>
      4d:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
      53:	8d 5d a8             	lea    -0x58(%ebp),%ebx
      56:	8d 76 00             	lea    0x0(%esi),%esi
      59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  {  
     	char name[64];
	char password[64];
	do
 	{
		printf(1,"Please enter your user name & password.\n");
      60:	83 ec 08             	sub    $0x8,%esp
      63:	68 a4 15 00 00       	push   $0x15a4
      68:	6a 01                	push   $0x1
      6a:	e8 b1 10 00 00       	call   1120 <printf>
		printf(1,"User name: ");
      6f:	5a                   	pop    %edx
      70:	59                   	pop    %ecx
      71:	68 27 15 00 00       	push   $0x1527
      76:	6a 01                	push   $0x1
      78:	e8 a3 10 00 00       	call   1120 <printf>
		gets(name,sizeof(name));
      7d:	58                   	pop    %eax
      7e:	5a                   	pop    %edx
      7f:	6a 40                	push   $0x40
      81:	56                   	push   %esi
      82:	e8 f9 0d 00 00       	call   e80 <gets>
		printf(1,"Password: ");
      87:	59                   	pop    %ecx
      88:	58                   	pop    %eax
      89:	68 33 15 00 00       	push   $0x1533
      8e:	6a 01                	push   $0x1
      90:	e8 8b 10 00 00       	call   1120 <printf>
		gets(password,sizeof(password));
      95:	58                   	pop    %eax
      96:	5a                   	pop    %edx
      97:	6a 40                	push   $0x40
      99:	53                   	push   %ebx
      9a:	e8 e1 0d 00 00       	call   e80 <gets>
	} while (cu(3,name,password) != 1);
      9f:	83 c4 0c             	add    $0xc,%esp
      a2:	53                   	push   %ebx
      a3:	56                   	push   %esi
      a4:	6a 03                	push   $0x3
      a6:	e8 b5 0a 00 00       	call   b60 <cu>
      ab:	83 c4 10             	add    $0x10,%esp
      ae:	83 f8 01             	cmp    $0x1,%eax
      b1:	75 ad                	jne    60 <main+0x60>
	isLogin = 1;
      b3:	c7 05 44 1c 00 00 01 	movl   $0x1,0x1c44
      ba:	00 00 00 
      bd:	eb 28                	jmp    e7 <main+0xe7>
      bf:	90                   	nop
  }
*/

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      c0:	80 3d e2 1b 00 00 20 	cmpb   $0x20,0x1be2
      c7:	74 5d                	je     126 <main+0x126>
      c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      d0:	e8 d5 0e 00 00       	call   faa <fork>
  if(pid == -1)
      d5:	83 f8 ff             	cmp    $0xffffffff,%eax
      d8:	74 3f                	je     119 <main+0x119>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      da:	85 c0                	test   %eax,%eax
      dc:	0f 84 98 00 00 00    	je     17a <main+0x17a>
      runcmd(parsecmd(buf));
    wait();
      e2:	e8 d3 0e 00 00       	call   fba <wait>
    wait();
  }
*/

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      e7:	83 ec 08             	sub    $0x8,%esp
      ea:	6a 64                	push   $0x64
      ec:	68 e0 1b 00 00       	push   $0x1be0
      f1:	e8 9a 00 00 00       	call   190 <getcmd>
      f6:	83 c4 10             	add    $0x10,%esp
      f9:	85 c0                	test   %eax,%eax
      fb:	78 78                	js     175 <main+0x175>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      fd:	80 3d e0 1b 00 00 63 	cmpb   $0x63,0x1be0
     104:	75 ca                	jne    d0 <main+0xd0>
     106:	80 3d e1 1b 00 00 64 	cmpb   $0x64,0x1be1
     10d:	74 b1                	je     c0 <main+0xc0>
int
fork1(void)
{
  int pid;

  pid = fork();
     10f:	e8 96 0e 00 00       	call   faa <fork>
  if(pid == -1)
     114:	83 f8 ff             	cmp    $0xffffffff,%eax
     117:	75 c1                	jne    da <main+0xda>
    panic("fork");
     119:	83 ec 0c             	sub    $0xc,%esp
     11c:	68 6a 14 00 00       	push   $0x146a
     121:	e8 ba 00 00 00       	call   1e0 <panic>

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     126:	83 ec 0c             	sub    $0xc,%esp
     129:	68 e0 1b 00 00       	push   $0x1be0
     12e:	e8 bd 0c 00 00       	call   df0 <strlen>
      if(chdir(buf+3) < 0)
     133:	c7 04 24 e3 1b 00 00 	movl   $0x1be3,(%esp)

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     13a:	c6 80 df 1b 00 00 00 	movb   $0x0,0x1bdf(%eax)
      if(chdir(buf+3) < 0)
     141:	e8 dc 0e 00 00       	call   1022 <chdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	79 9a                	jns    e7 <main+0xe7>
        printf(2, "cannot cd %s\n", buf+3);
     14d:	50                   	push   %eax
     14e:	68 e3 1b 00 00       	push   $0x1be3
     153:	68 3e 15 00 00       	push   $0x153e
     158:	6a 02                	push   $0x2
     15a:	e8 c1 0f 00 00       	call   1120 <printf>
     15f:	83 c4 10             	add    $0x10,%esp
     162:	eb 83                	jmp    e7 <main+0xe7>
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
     164:	83 ec 0c             	sub    $0xc,%esp
     167:	50                   	push   %eax
     168:	e8 6d 0e 00 00       	call   fda <close>
      break;
     16d:	83 c4 10             	add    $0x10,%esp
     170:	e9 ca fe ff ff       	jmp    3f <main+0x3f>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     175:	e8 38 0e 00 00       	call   fb2 <exit>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
     17a:	83 ec 0c             	sub    $0xc,%esp
     17d:	68 e0 1b 00 00       	push   $0x1be0
     182:	e8 69 09 00 00       	call   af0 <parsecmd>
     187:	89 04 24             	mov    %eax,(%esp)
     18a:	e8 71 00 00 00       	call   200 <runcmd>
     18f:	90                   	nop

00000190 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	56                   	push   %esi
     194:	53                   	push   %ebx
     195:	8b 75 0c             	mov    0xc(%ebp),%esi
     198:	8b 5d 08             	mov    0x8(%ebp),%ebx
  getUser();
     19b:	e8 ca 0e 00 00       	call   106a <getUser>
  printf(2, "$ ");//output for shell
     1a0:	83 ec 08             	sub    $0x8,%esp
     1a3:	68 40 14 00 00       	push   $0x1440
     1a8:	6a 02                	push   $0x2
     1aa:	e8 71 0f 00 00       	call   1120 <printf>
  memset(buf, 0, nbuf);
     1af:	83 c4 0c             	add    $0xc,%esp
     1b2:	56                   	push   %esi
     1b3:	6a 00                	push   $0x0
     1b5:	53                   	push   %ebx
     1b6:	e8 65 0c 00 00       	call   e20 <memset>
  gets(buf, nbuf);
     1bb:	58                   	pop    %eax
     1bc:	5a                   	pop    %edx
     1bd:	56                   	push   %esi
     1be:	53                   	push   %ebx
     1bf:	e8 bc 0c 00 00       	call   e80 <gets>
     1c4:	83 c4 10             	add    $0x10,%esp
     1c7:	31 c0                	xor    %eax,%eax
     1c9:	80 3b 00             	cmpb   $0x0,(%ebx)
     1cc:	0f 94 c0             	sete   %al
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     1cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1d2:	f7 d8                	neg    %eax
     1d4:	5b                   	pop    %ebx
     1d5:	5e                   	pop    %esi
     1d6:	5d                   	pop    %ebp
     1d7:	c3                   	ret    
     1d8:	90                   	nop
     1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <panic>:
  exit();
}

void
panic(char *s)
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     1e6:	ff 75 08             	pushl  0x8(%ebp)
     1e9:	68 dd 14 00 00       	push   $0x14dd
     1ee:	6a 02                	push   $0x2
     1f0:	e8 2b 0f 00 00       	call   1120 <printf>
  exit();
     1f5:	e8 b8 0d 00 00       	call   fb2 <exit>
     1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	53                   	push   %ebx
     204:	83 ec 14             	sub    $0x14,%esp
     207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     20a:	85 db                	test   %ebx,%ebx
     20c:	74 76                	je     284 <runcmd+0x84>
    exit();

  switch(cmd->type){
     20e:	83 3b 05             	cmpl   $0x5,(%ebx)
     211:	0f 87 f8 00 00 00    	ja     30f <runcmd+0x10f>
     217:	8b 03                	mov    (%ebx),%eax
     219:	ff 24 85 4c 15 00 00 	jmp    *0x154c(,%eax,4)
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     220:	8d 45 f0             	lea    -0x10(%ebp),%eax
     223:	83 ec 0c             	sub    $0xc,%esp
     226:	50                   	push   %eax
     227:	e8 96 0d 00 00       	call   fc2 <pipe>
     22c:	83 c4 10             	add    $0x10,%esp
     22f:	85 c0                	test   %eax,%eax
     231:	0f 88 07 01 00 00    	js     33e <runcmd+0x13e>
int
fork1(void)
{
  int pid;

  pid = fork();
     237:	e8 6e 0d 00 00       	call   faa <fork>
  if(pid == -1)
     23c:	83 f8 ff             	cmp    $0xffffffff,%eax
     23f:	0f 84 d7 00 00 00    	je     31c <runcmd+0x11c>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
     245:	85 c0                	test   %eax,%eax
     247:	0f 84 fe 00 00 00    	je     34b <runcmd+0x14b>
int
fork1(void)
{
  int pid;

  pid = fork();
     24d:	e8 58 0d 00 00       	call   faa <fork>
  if(pid == -1)
     252:	83 f8 ff             	cmp    $0xffffffff,%eax
     255:	0f 84 c1 00 00 00    	je     31c <runcmd+0x11c>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     25b:	85 c0                	test   %eax,%eax
     25d:	0f 84 16 01 00 00    	je     379 <runcmd+0x179>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     263:	83 ec 0c             	sub    $0xc,%esp
     266:	ff 75 f0             	pushl  -0x10(%ebp)
     269:	e8 6c 0d 00 00       	call   fda <close>
    close(p[1]);
     26e:	58                   	pop    %eax
     26f:	ff 75 f4             	pushl  -0xc(%ebp)
     272:	e8 63 0d 00 00       	call   fda <close>
    wait();
     277:	e8 3e 0d 00 00       	call   fba <wait>
    wait();
     27c:	e8 39 0d 00 00       	call   fba <wait>
    break;
     281:	83 c4 10             	add    $0x10,%esp
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();
     284:	e8 29 0d 00 00       	call   fb2 <exit>
int
fork1(void)
{
  int pid;

  pid = fork();
     289:	e8 1c 0d 00 00       	call   faa <fork>
  if(pid == -1)
     28e:	83 f8 ff             	cmp    $0xffffffff,%eax
     291:	0f 84 85 00 00 00    	je     31c <runcmd+0x11c>
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     297:	85 c0                	test   %eax,%eax
     299:	75 e9                	jne    284 <runcmd+0x84>
     29b:	eb 49                	jmp    2e6 <runcmd+0xe6>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     29d:	8b 43 04             	mov    0x4(%ebx),%eax
     2a0:	85 c0                	test   %eax,%eax
     2a2:	74 e0                	je     284 <runcmd+0x84>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     2a4:	52                   	push   %edx
     2a5:	52                   	push   %edx
     2a6:	8d 53 04             	lea    0x4(%ebx),%edx
     2a9:	52                   	push   %edx
     2aa:	50                   	push   %eax
     2ab:	e8 3a 0d 00 00       	call   fea <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     2b0:	83 c4 0c             	add    $0xc,%esp
     2b3:	ff 73 04             	pushl  0x4(%ebx)
     2b6:	68 4a 14 00 00       	push   $0x144a
     2bb:	6a 02                	push   $0x2
     2bd:	e8 5e 0e 00 00       	call   1120 <printf>
    break;
     2c2:	83 c4 10             	add    $0x10,%esp
     2c5:	eb bd                	jmp    284 <runcmd+0x84>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     2c7:	83 ec 0c             	sub    $0xc,%esp
     2ca:	ff 73 14             	pushl  0x14(%ebx)
     2cd:	e8 08 0d 00 00       	call   fda <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2d2:	59                   	pop    %ecx
     2d3:	58                   	pop    %eax
     2d4:	ff 73 10             	pushl  0x10(%ebx)
     2d7:	ff 73 08             	pushl  0x8(%ebx)
     2da:	e8 13 0d 00 00       	call   ff2 <open>
     2df:	83 c4 10             	add    $0x10,%esp
     2e2:	85 c0                	test   %eax,%eax
     2e4:	78 43                	js     329 <runcmd+0x129>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     2e6:	83 ec 0c             	sub    $0xc,%esp
     2e9:	ff 73 04             	pushl  0x4(%ebx)
     2ec:	e8 0f ff ff ff       	call   200 <runcmd>
int
fork1(void)
{
  int pid;

  pid = fork();
     2f1:	e8 b4 0c 00 00       	call   faa <fork>
  if(pid == -1)
     2f6:	83 f8 ff             	cmp    $0xffffffff,%eax
     2f9:	74 21                	je     31c <runcmd+0x11c>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     2fb:	85 c0                	test   %eax,%eax
     2fd:	74 e7                	je     2e6 <runcmd+0xe6>
      runcmd(lcmd->left);
    wait();
     2ff:	e8 b6 0c 00 00       	call   fba <wait>
    runcmd(lcmd->right);
     304:	83 ec 0c             	sub    $0xc,%esp
     307:	ff 73 08             	pushl  0x8(%ebx)
     30a:	e8 f1 fe ff ff       	call   200 <runcmd>
  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");
     30f:	83 ec 0c             	sub    $0xc,%esp
     312:	68 43 14 00 00       	push   $0x1443
     317:	e8 c4 fe ff ff       	call   1e0 <panic>
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     31c:	83 ec 0c             	sub    $0xc,%esp
     31f:	68 6a 14 00 00       	push   $0x146a
     324:	e8 b7 fe ff ff       	call   1e0 <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     329:	52                   	push   %edx
     32a:	ff 73 08             	pushl  0x8(%ebx)
     32d:	68 5a 14 00 00       	push   $0x145a
     332:	6a 02                	push   $0x2
     334:	e8 e7 0d 00 00       	call   1120 <printf>
      exit();
     339:	e8 74 0c 00 00       	call   fb2 <exit>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     33e:	83 ec 0c             	sub    $0xc,%esp
     341:	68 6f 14 00 00       	push   $0x146f
     346:	e8 95 fe ff ff       	call   1e0 <panic>
    if(fork1() == 0){
      close(1);
     34b:	83 ec 0c             	sub    $0xc,%esp
     34e:	6a 01                	push   $0x1
     350:	e8 85 0c 00 00       	call   fda <close>
      dup(p[1]);
     355:	58                   	pop    %eax
     356:	ff 75 f4             	pushl  -0xc(%ebp)
     359:	e8 cc 0c 00 00       	call   102a <dup>
      close(p[0]);
     35e:	58                   	pop    %eax
     35f:	ff 75 f0             	pushl  -0x10(%ebp)
     362:	e8 73 0c 00 00       	call   fda <close>
      close(p[1]);
     367:	58                   	pop    %eax
     368:	ff 75 f4             	pushl  -0xc(%ebp)
     36b:	e8 6a 0c 00 00       	call   fda <close>
      runcmd(pcmd->left);
     370:	58                   	pop    %eax
     371:	ff 73 04             	pushl  0x4(%ebx)
     374:	e8 87 fe ff ff       	call   200 <runcmd>
    }
    if(fork1() == 0){
      close(0);
     379:	83 ec 0c             	sub    $0xc,%esp
     37c:	6a 00                	push   $0x0
     37e:	e8 57 0c 00 00       	call   fda <close>
      dup(p[0]);
     383:	5a                   	pop    %edx
     384:	ff 75 f0             	pushl  -0x10(%ebp)
     387:	e8 9e 0c 00 00       	call   102a <dup>
      close(p[0]);
     38c:	59                   	pop    %ecx
     38d:	ff 75 f0             	pushl  -0x10(%ebp)
     390:	e8 45 0c 00 00       	call   fda <close>
      close(p[1]);
     395:	58                   	pop    %eax
     396:	ff 75 f4             	pushl  -0xc(%ebp)
     399:	e8 3c 0c 00 00       	call   fda <close>
      runcmd(pcmd->right);
     39e:	58                   	pop    %eax
     39f:	ff 73 08             	pushl  0x8(%ebx)
     3a2:	e8 59 fe ff ff       	call   200 <runcmd>
     3a7:	89 f6                	mov    %esi,%esi
     3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <fork1>:
  exit();
}

int
fork1(void)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	83 ec 08             	sub    $0x8,%esp
  int pid;

  pid = fork();
     3b6:	e8 ef 0b 00 00       	call   faa <fork>
  if(pid == -1)
     3bb:	83 f8 ff             	cmp    $0xffffffff,%eax
     3be:	74 02                	je     3c2 <fork1+0x12>
    panic("fork");
  return pid;
}
     3c0:	c9                   	leave  
     3c1:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     3c2:	83 ec 0c             	sub    $0xc,%esp
     3c5:	68 6a 14 00 00       	push   $0x146a
     3ca:	e8 11 fe ff ff       	call   1e0 <panic>
     3cf:	90                   	nop

000003d0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	6a 54                	push   $0x54
     3d9:	e8 72 0f 00 00       	call   1350 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3de:	83 c4 0c             	add    $0xc,%esp
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3e3:	6a 54                	push   $0x54
     3e5:	6a 00                	push   $0x0
     3e7:	50                   	push   %eax
     3e8:	e8 33 0a 00 00       	call   e20 <memset>
  cmd->type = EXEC;
     3ed:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     3f3:	89 d8                	mov    %ebx,%eax
     3f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f8:	c9                   	leave  
     3f9:	c3                   	ret    
     3fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000400 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	6a 18                	push   $0x18
     409:	e8 42 0f 00 00       	call   1350 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     411:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     413:	6a 18                	push   $0x18
     415:	6a 00                	push   $0x0
     417:	50                   	push   %eax
     418:	e8 03 0a 00 00       	call   e20 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     420:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     426:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     429:	8b 45 0c             	mov    0xc(%ebp),%eax
     42c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     42f:	8b 45 10             	mov    0x10(%ebp),%eax
     432:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     435:	8b 45 14             	mov    0x14(%ebp),%eax
     438:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     43b:	8b 45 18             	mov    0x18(%ebp),%eax
     43e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     441:	89 d8                	mov    %ebx,%eax
     443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     446:	c9                   	leave  
     447:	c3                   	ret    
     448:	90                   	nop
     449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000450 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	6a 0c                	push   $0xc
     459:	e8 f2 0e 00 00       	call   1350 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     45e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     461:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     463:	6a 0c                	push   $0xc
     465:	6a 00                	push   $0x0
     467:	50                   	push   %eax
     468:	e8 b3 09 00 00       	call   e20 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     470:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     479:	8b 45 0c             	mov    0xc(%ebp),%eax
     47c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     47f:	89 d8                	mov    %ebx,%eax
     481:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     484:	c9                   	leave  
     485:	c3                   	ret    
     486:	8d 76 00             	lea    0x0(%esi),%esi
     489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     497:	6a 0c                	push   $0xc
     499:	e8 b2 0e 00 00       	call   1350 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     49e:	83 c4 0c             	add    $0xc,%esp
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4a3:	6a 0c                	push   $0xc
     4a5:	6a 00                	push   $0x0
     4a7:	50                   	push   %eax
     4a8:	e8 73 09 00 00       	call   e20 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4ad:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     4b0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4bc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4bf:	89 d8                	mov    %ebx,%eax
     4c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4c4:	c9                   	leave  
     4c5:	c3                   	ret    
     4c6:	8d 76 00             	lea    0x0(%esi),%esi
     4c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004d0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	53                   	push   %ebx
     4d4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4d7:	6a 08                	push   $0x8
     4d9:	e8 72 0e 00 00       	call   1350 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4de:	83 c4 0c             	add    $0xc,%esp
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4e3:	6a 08                	push   $0x8
     4e5:	6a 00                	push   $0x0
     4e7:	50                   	push   %eax
     4e8:	e8 33 09 00 00       	call   e20 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4ed:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     4f0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     4f6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     4f9:	89 d8                	mov    %ebx,%eax
     4fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     4fe:	c9                   	leave  
     4ff:	c3                   	ret    

00000500 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	57                   	push   %edi
     504:	56                   	push   %esi
     505:	53                   	push   %ebx
     506:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     509:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     50c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     50f:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     512:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     514:	39 df                	cmp    %ebx,%edi
     516:	72 13                	jb     52b <gettoken+0x2b>
     518:	eb 29                	jmp    543 <gettoken+0x43>
     51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     520:	83 c7 01             	add    $0x1,%edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     523:	39 fb                	cmp    %edi,%ebx
     525:	0f 84 ed 00 00 00    	je     618 <gettoken+0x118>
     52b:	0f be 07             	movsbl (%edi),%eax
     52e:	83 ec 08             	sub    $0x8,%esp
     531:	50                   	push   %eax
     532:	68 c8 1b 00 00       	push   $0x1bc8
     537:	e8 04 09 00 00       	call   e40 <strchr>
     53c:	83 c4 10             	add    $0x10,%esp
     53f:	85 c0                	test   %eax,%eax
     541:	75 dd                	jne    520 <gettoken+0x20>
    s++;
  if(q)
     543:	85 f6                	test   %esi,%esi
     545:	74 02                	je     549 <gettoken+0x49>
    *q = s;
     547:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     549:	0f be 37             	movsbl (%edi),%esi
     54c:	89 f1                	mov    %esi,%ecx
     54e:	89 f0                	mov    %esi,%eax
  switch(*s){
     550:	80 f9 29             	cmp    $0x29,%cl
     553:	7f 5b                	jg     5b0 <gettoken+0xb0>
     555:	80 f9 28             	cmp    $0x28,%cl
     558:	7d 61                	jge    5bb <gettoken+0xbb>
     55a:	84 c9                	test   %cl,%cl
     55c:	0f 85 de 00 00 00    	jne    640 <gettoken+0x140>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     562:	8b 55 14             	mov    0x14(%ebp),%edx
     565:	85 d2                	test   %edx,%edx
     567:	74 05                	je     56e <gettoken+0x6e>
    *eq = s;
     569:	8b 45 14             	mov    0x14(%ebp),%eax
     56c:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     56e:	39 fb                	cmp    %edi,%ebx
     570:	77 0d                	ja     57f <gettoken+0x7f>
     572:	eb 23                	jmp    597 <gettoken+0x97>
     574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     578:	83 c7 01             	add    $0x1,%edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     57b:	39 fb                	cmp    %edi,%ebx
     57d:	74 18                	je     597 <gettoken+0x97>
     57f:	0f be 07             	movsbl (%edi),%eax
     582:	83 ec 08             	sub    $0x8,%esp
     585:	50                   	push   %eax
     586:	68 c8 1b 00 00       	push   $0x1bc8
     58b:	e8 b0 08 00 00       	call   e40 <strchr>
     590:	83 c4 10             	add    $0x10,%esp
     593:	85 c0                	test   %eax,%eax
     595:	75 e1                	jne    578 <gettoken+0x78>
    s++;
  *ps = s;
     597:	8b 45 08             	mov    0x8(%ebp),%eax
     59a:	89 38                	mov    %edi,(%eax)
  return ret;
}
     59c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     59f:	89 f0                	mov    %esi,%eax
     5a1:	5b                   	pop    %ebx
     5a2:	5e                   	pop    %esi
     5a3:	5f                   	pop    %edi
     5a4:	5d                   	pop    %ebp
     5a5:	c3                   	ret    
     5a6:	8d 76 00             	lea    0x0(%esi),%esi
     5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5b0:	80 f9 3e             	cmp    $0x3e,%cl
     5b3:	75 0b                	jne    5c0 <gettoken+0xc0>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     5b5:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     5b9:	74 75                	je     630 <gettoken+0x130>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     5bb:	83 c7 01             	add    $0x1,%edi
     5be:	eb a2                	jmp    562 <gettoken+0x62>
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5c0:	7f 5e                	jg     620 <gettoken+0x120>
     5c2:	83 e9 3b             	sub    $0x3b,%ecx
     5c5:	80 f9 01             	cmp    $0x1,%cl
     5c8:	76 f1                	jbe    5bb <gettoken+0xbb>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5ca:	39 fb                	cmp    %edi,%ebx
     5cc:	77 24                	ja     5f2 <gettoken+0xf2>
     5ce:	eb 7c                	jmp    64c <gettoken+0x14c>
     5d0:	0f be 07             	movsbl (%edi),%eax
     5d3:	83 ec 08             	sub    $0x8,%esp
     5d6:	50                   	push   %eax
     5d7:	68 c0 1b 00 00       	push   $0x1bc0
     5dc:	e8 5f 08 00 00       	call   e40 <strchr>
     5e1:	83 c4 10             	add    $0x10,%esp
     5e4:	85 c0                	test   %eax,%eax
     5e6:	75 1f                	jne    607 <gettoken+0x107>
      s++;
     5e8:	83 c7 01             	add    $0x1,%edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5eb:	39 fb                	cmp    %edi,%ebx
     5ed:	74 5b                	je     64a <gettoken+0x14a>
     5ef:	0f be 07             	movsbl (%edi),%eax
     5f2:	83 ec 08             	sub    $0x8,%esp
     5f5:	50                   	push   %eax
     5f6:	68 c8 1b 00 00       	push   $0x1bc8
     5fb:	e8 40 08 00 00       	call   e40 <strchr>
     600:	83 c4 10             	add    $0x10,%esp
     603:	85 c0                	test   %eax,%eax
     605:	74 c9                	je     5d0 <gettoken+0xd0>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     607:	be 61 00 00 00       	mov    $0x61,%esi
     60c:	e9 51 ff ff ff       	jmp    562 <gettoken+0x62>
     611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     618:	89 df                	mov    %ebx,%edi
     61a:	e9 24 ff ff ff       	jmp    543 <gettoken+0x43>
     61f:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     620:	80 f9 7c             	cmp    $0x7c,%cl
     623:	74 96                	je     5bb <gettoken+0xbb>
     625:	eb a3                	jmp    5ca <gettoken+0xca>
     627:	89 f6                	mov    %esi,%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
     630:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     633:	be 2b 00 00 00       	mov    $0x2b,%esi
     638:	e9 25 ff ff ff       	jmp    562 <gettoken+0x62>
     63d:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     640:	80 f9 26             	cmp    $0x26,%cl
     643:	75 85                	jne    5ca <gettoken+0xca>
     645:	e9 71 ff ff ff       	jmp    5bb <gettoken+0xbb>
     64a:	89 df                	mov    %ebx,%edi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     64c:	8b 45 14             	mov    0x14(%ebp),%eax
     64f:	be 61 00 00 00       	mov    $0x61,%esi
     654:	85 c0                	test   %eax,%eax
     656:	0f 85 0d ff ff ff    	jne    569 <gettoken+0x69>
     65c:	e9 36 ff ff ff       	jmp    597 <gettoken+0x97>
     661:	eb 0d                	jmp    670 <peek>
     663:	90                   	nop
     664:	90                   	nop
     665:	90                   	nop
     666:	90                   	nop
     667:	90                   	nop
     668:	90                   	nop
     669:	90                   	nop
     66a:	90                   	nop
     66b:	90                   	nop
     66c:	90                   	nop
     66d:	90                   	nop
     66e:	90                   	nop
     66f:	90                   	nop

00000670 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	57                   	push   %edi
     674:	56                   	push   %esi
     675:	53                   	push   %ebx
     676:	83 ec 0c             	sub    $0xc,%esp
     679:	8b 7d 08             	mov    0x8(%ebp),%edi
     67c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     67f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     681:	39 f3                	cmp    %esi,%ebx
     683:	72 12                	jb     697 <peek+0x27>
     685:	eb 28                	jmp    6af <peek+0x3f>
     687:	89 f6                	mov    %esi,%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     690:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     693:	39 de                	cmp    %ebx,%esi
     695:	74 18                	je     6af <peek+0x3f>
     697:	0f be 03             	movsbl (%ebx),%eax
     69a:	83 ec 08             	sub    $0x8,%esp
     69d:	50                   	push   %eax
     69e:	68 c8 1b 00 00       	push   $0x1bc8
     6a3:	e8 98 07 00 00       	call   e40 <strchr>
     6a8:	83 c4 10             	add    $0x10,%esp
     6ab:	85 c0                	test   %eax,%eax
     6ad:	75 e1                	jne    690 <peek+0x20>
    s++;
  *ps = s;
     6af:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6b1:	0f be 13             	movsbl (%ebx),%edx
     6b4:	31 c0                	xor    %eax,%eax
     6b6:	84 d2                	test   %dl,%dl
     6b8:	74 17                	je     6d1 <peek+0x61>
     6ba:	83 ec 08             	sub    $0x8,%esp
     6bd:	52                   	push   %edx
     6be:	ff 75 10             	pushl  0x10(%ebp)
     6c1:	e8 7a 07 00 00       	call   e40 <strchr>
     6c6:	83 c4 10             	add    $0x10,%esp
     6c9:	85 c0                	test   %eax,%eax
     6cb:	0f 95 c0             	setne  %al
     6ce:	0f b6 c0             	movzbl %al,%eax
}
     6d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6d4:	5b                   	pop    %ebx
     6d5:	5e                   	pop    %esi
     6d6:	5f                   	pop    %edi
     6d7:	5d                   	pop    %ebp
     6d8:	c3                   	ret    
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006e0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6e0:	55                   	push   %ebp
     6e1:	89 e5                	mov    %esp,%ebp
     6e3:	57                   	push   %edi
     6e4:	56                   	push   %esi
     6e5:	53                   	push   %ebx
     6e6:	83 ec 1c             	sub    $0x1c,%esp
     6e9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6ef:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6f0:	83 ec 04             	sub    $0x4,%esp
     6f3:	68 91 14 00 00       	push   $0x1491
     6f8:	53                   	push   %ebx
     6f9:	56                   	push   %esi
     6fa:	e8 71 ff ff ff       	call   670 <peek>
     6ff:	83 c4 10             	add    $0x10,%esp
     702:	85 c0                	test   %eax,%eax
     704:	74 6a                	je     770 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     706:	6a 00                	push   $0x0
     708:	6a 00                	push   $0x0
     70a:	53                   	push   %ebx
     70b:	56                   	push   %esi
     70c:	e8 ef fd ff ff       	call   500 <gettoken>
     711:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     713:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     716:	50                   	push   %eax
     717:	8d 45 e0             	lea    -0x20(%ebp),%eax
     71a:	50                   	push   %eax
     71b:	53                   	push   %ebx
     71c:	56                   	push   %esi
     71d:	e8 de fd ff ff       	call   500 <gettoken>
     722:	83 c4 20             	add    $0x20,%esp
     725:	83 f8 61             	cmp    $0x61,%eax
     728:	75 51                	jne    77b <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     72a:	83 ff 3c             	cmp    $0x3c,%edi
     72d:	74 31                	je     760 <parseredirs+0x80>
     72f:	83 ff 3e             	cmp    $0x3e,%edi
     732:	74 05                	je     739 <parseredirs+0x59>
     734:	83 ff 2b             	cmp    $0x2b,%edi
     737:	75 b7                	jne    6f0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     739:	83 ec 0c             	sub    $0xc,%esp
     73c:	6a 01                	push   $0x1
     73e:	68 01 02 00 00       	push   $0x201
     743:	ff 75 e4             	pushl  -0x1c(%ebp)
     746:	ff 75 e0             	pushl  -0x20(%ebp)
     749:	ff 75 08             	pushl  0x8(%ebp)
     74c:	e8 af fc ff ff       	call   400 <redircmd>
      break;
     751:	83 c4 20             	add    $0x20,%esp
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     754:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     757:	eb 97                	jmp    6f0 <parseredirs+0x10>
     759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     760:	83 ec 0c             	sub    $0xc,%esp
     763:	6a 00                	push   $0x0
     765:	6a 00                	push   $0x0
     767:	eb da                	jmp    743 <parseredirs+0x63>
     769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     770:	8b 45 08             	mov    0x8(%ebp),%eax
     773:	8d 65 f4             	lea    -0xc(%ebp),%esp
     776:	5b                   	pop    %ebx
     777:	5e                   	pop    %esi
     778:	5f                   	pop    %edi
     779:	5d                   	pop    %ebp
     77a:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
     77b:	83 ec 0c             	sub    $0xc,%esp
     77e:	68 74 14 00 00       	push   $0x1474
     783:	e8 58 fa ff ff       	call   1e0 <panic>
     788:	90                   	nop
     789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     790:	55                   	push   %ebp
     791:	89 e5                	mov    %esp,%ebp
     793:	57                   	push   %edi
     794:	56                   	push   %esi
     795:	53                   	push   %ebx
     796:	83 ec 30             	sub    $0x30,%esp
     799:	8b 75 08             	mov    0x8(%ebp),%esi
     79c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     79f:	68 94 14 00 00       	push   $0x1494
     7a4:	57                   	push   %edi
     7a5:	56                   	push   %esi
     7a6:	e8 c5 fe ff ff       	call   670 <peek>
     7ab:	83 c4 10             	add    $0x10,%esp
     7ae:	85 c0                	test   %eax,%eax
     7b0:	0f 85 9a 00 00 00    	jne    850 <parseexec+0xc0>
    return parseblock(ps, es);

  ret = execcmd();
     7b6:	e8 15 fc ff ff       	call   3d0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7bb:	83 ec 04             	sub    $0x4,%esp
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     7be:	89 c3                	mov    %eax,%ebx
     7c0:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7c3:	57                   	push   %edi
     7c4:	56                   	push   %esi
     7c5:	8d 5b 04             	lea    0x4(%ebx),%ebx
     7c8:	50                   	push   %eax
     7c9:	e8 12 ff ff ff       	call   6e0 <parseredirs>
     7ce:	83 c4 10             	add    $0x10,%esp
     7d1:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
     7d4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     7db:	eb 16                	jmp    7f3 <parseexec+0x63>
     7dd:	8d 76 00             	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     7e0:	83 ec 04             	sub    $0x4,%esp
     7e3:	57                   	push   %edi
     7e4:	56                   	push   %esi
     7e5:	ff 75 d0             	pushl  -0x30(%ebp)
     7e8:	e8 f3 fe ff ff       	call   6e0 <parseredirs>
     7ed:	83 c4 10             	add    $0x10,%esp
     7f0:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     7f3:	83 ec 04             	sub    $0x4,%esp
     7f6:	68 ab 14 00 00       	push   $0x14ab
     7fb:	57                   	push   %edi
     7fc:	56                   	push   %esi
     7fd:	e8 6e fe ff ff       	call   670 <peek>
     802:	83 c4 10             	add    $0x10,%esp
     805:	85 c0                	test   %eax,%eax
     807:	75 5f                	jne    868 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     809:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     80c:	50                   	push   %eax
     80d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     810:	50                   	push   %eax
     811:	57                   	push   %edi
     812:	56                   	push   %esi
     813:	e8 e8 fc ff ff       	call   500 <gettoken>
     818:	83 c4 10             	add    $0x10,%esp
     81b:	85 c0                	test   %eax,%eax
     81d:	74 49                	je     868 <parseexec+0xd8>
      break;
    if(tok != 'a')
     81f:	83 f8 61             	cmp    $0x61,%eax
     822:	75 66                	jne    88a <parseexec+0xfa>
      panic("syntax");
    cmd->argv[argc] = q;
     824:	8b 45 e0             	mov    -0x20(%ebp),%eax
    cmd->eargv[argc] = eq;
    argc++;
     827:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
     82b:	83 c3 04             	add    $0x4,%ebx
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
     82e:	89 43 fc             	mov    %eax,-0x4(%ebx)
    cmd->eargv[argc] = eq;
     831:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     834:	89 43 24             	mov    %eax,0x24(%ebx)
    argc++;
     837:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    if(argc >= MAXARGS)
     83a:	83 f8 0a             	cmp    $0xa,%eax
     83d:	75 a1                	jne    7e0 <parseexec+0x50>
      panic("too many args");
     83f:	83 ec 0c             	sub    $0xc,%esp
     842:	68 9d 14 00 00       	push   $0x149d
     847:	e8 94 f9 ff ff       	call   1e0 <panic>
     84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
     850:	83 ec 08             	sub    $0x8,%esp
     853:	57                   	push   %edi
     854:	56                   	push   %esi
     855:	e8 56 01 00 00       	call   9b0 <parseblock>
     85a:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     85d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     860:	5b                   	pop    %ebx
     861:	5e                   	pop    %esi
     862:	5f                   	pop    %edi
     863:	5d                   	pop    %ebp
     864:	c3                   	ret    
     865:	8d 76 00             	lea    0x0(%esi),%esi
     868:	8b 45 cc             	mov    -0x34(%ebp),%eax
     86b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     86e:	8d 04 90             	lea    (%eax,%edx,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     871:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     878:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
     87f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  return ret;
}
     882:	8d 65 f4             	lea    -0xc(%ebp),%esp
     885:	5b                   	pop    %ebx
     886:	5e                   	pop    %esi
     887:	5f                   	pop    %edi
     888:	5d                   	pop    %ebp
     889:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
     88a:	83 ec 0c             	sub    $0xc,%esp
     88d:	68 96 14 00 00       	push   $0x1496
     892:	e8 49 f9 ff ff       	call   1e0 <panic>
     897:	89 f6                	mov    %esi,%esi
     899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	57                   	push   %edi
     8a4:	56                   	push   %esi
     8a5:	53                   	push   %ebx
     8a6:	83 ec 14             	sub    $0x14,%esp
     8a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     8af:	56                   	push   %esi
     8b0:	53                   	push   %ebx
     8b1:	e8 da fe ff ff       	call   790 <parseexec>
  if(peek(ps, es, "|")){
     8b6:	83 c4 0c             	add    $0xc,%esp
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     8b9:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     8bb:	68 b0 14 00 00       	push   $0x14b0
     8c0:	56                   	push   %esi
     8c1:	53                   	push   %ebx
     8c2:	e8 a9 fd ff ff       	call   670 <peek>
     8c7:	83 c4 10             	add    $0x10,%esp
     8ca:	85 c0                	test   %eax,%eax
     8cc:	75 12                	jne    8e0 <parsepipe+0x40>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     8ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d1:	89 f8                	mov    %edi,%eax
     8d3:	5b                   	pop    %ebx
     8d4:	5e                   	pop    %esi
     8d5:	5f                   	pop    %edi
     8d6:	5d                   	pop    %ebp
     8d7:	c3                   	ret    
     8d8:	90                   	nop
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     8e0:	6a 00                	push   $0x0
     8e2:	6a 00                	push   $0x0
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	e8 15 fc ff ff       	call   500 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8eb:	58                   	pop    %eax
     8ec:	5a                   	pop    %edx
     8ed:	56                   	push   %esi
     8ee:	53                   	push   %ebx
     8ef:	e8 ac ff ff ff       	call   8a0 <parsepipe>
     8f4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8f7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8fa:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     8fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     900:	5b                   	pop    %ebx
     901:	5e                   	pop    %esi
     902:	5f                   	pop    %edi
     903:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     904:	e9 47 fb ff ff       	jmp    450 <pipecmd>
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 14             	sub    $0x14,%esp
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     91f:	56                   	push   %esi
     920:	53                   	push   %ebx
     921:	e8 7a ff ff ff       	call   8a0 <parsepipe>
  while(peek(ps, es, "&")){
     926:	83 c4 10             	add    $0x10,%esp
struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     929:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     92b:	eb 1b                	jmp    948 <parseline+0x38>
     92d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     930:	6a 00                	push   $0x0
     932:	6a 00                	push   $0x0
     934:	56                   	push   %esi
     935:	53                   	push   %ebx
     936:	e8 c5 fb ff ff       	call   500 <gettoken>
    cmd = backcmd(cmd);
     93b:	89 3c 24             	mov    %edi,(%esp)
     93e:	e8 8d fb ff ff       	call   4d0 <backcmd>
     943:	83 c4 10             	add    $0x10,%esp
     946:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     948:	83 ec 04             	sub    $0x4,%esp
     94b:	68 b2 14 00 00       	push   $0x14b2
     950:	56                   	push   %esi
     951:	53                   	push   %ebx
     952:	e8 19 fd ff ff       	call   670 <peek>
     957:	83 c4 10             	add    $0x10,%esp
     95a:	85 c0                	test   %eax,%eax
     95c:	75 d2                	jne    930 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     95e:	83 ec 04             	sub    $0x4,%esp
     961:	68 ae 14 00 00       	push   $0x14ae
     966:	56                   	push   %esi
     967:	53                   	push   %ebx
     968:	e8 03 fd ff ff       	call   670 <peek>
     96d:	83 c4 10             	add    $0x10,%esp
     970:	85 c0                	test   %eax,%eax
     972:	75 0c                	jne    980 <parseline+0x70>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     974:	8d 65 f4             	lea    -0xc(%ebp),%esp
     977:	89 f8                	mov    %edi,%eax
     979:	5b                   	pop    %ebx
     97a:	5e                   	pop    %esi
     97b:	5f                   	pop    %edi
     97c:	5d                   	pop    %ebp
     97d:	c3                   	ret    
     97e:	66 90                	xchg   %ax,%ax
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     980:	6a 00                	push   $0x0
     982:	6a 00                	push   $0x0
     984:	56                   	push   %esi
     985:	53                   	push   %ebx
     986:	e8 75 fb ff ff       	call   500 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     98b:	58                   	pop    %eax
     98c:	5a                   	pop    %edx
     98d:	56                   	push   %esi
     98e:	53                   	push   %ebx
     98f:	e8 7c ff ff ff       	call   910 <parseline>
     994:	89 7d 08             	mov    %edi,0x8(%ebp)
     997:	89 45 0c             	mov    %eax,0xc(%ebp)
     99a:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     99d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9a0:	5b                   	pop    %ebx
     9a1:	5e                   	pop    %esi
     9a2:	5f                   	pop    %edi
     9a3:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     9a4:	e9 e7 fa ff ff       	jmp    490 <listcmd>
     9a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009b0 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	57                   	push   %edi
     9b4:	56                   	push   %esi
     9b5:	53                   	push   %ebx
     9b6:	83 ec 10             	sub    $0x10,%esp
     9b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     9bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9bf:	68 94 14 00 00       	push   $0x1494
     9c4:	56                   	push   %esi
     9c5:	53                   	push   %ebx
     9c6:	e8 a5 fc ff ff       	call   670 <peek>
     9cb:	83 c4 10             	add    $0x10,%esp
     9ce:	85 c0                	test   %eax,%eax
     9d0:	74 4a                	je     a1c <parseblock+0x6c>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     9d2:	6a 00                	push   $0x0
     9d4:	6a 00                	push   $0x0
     9d6:	56                   	push   %esi
     9d7:	53                   	push   %ebx
     9d8:	e8 23 fb ff ff       	call   500 <gettoken>
  cmd = parseline(ps, es);
     9dd:	58                   	pop    %eax
     9de:	5a                   	pop    %edx
     9df:	56                   	push   %esi
     9e0:	53                   	push   %ebx
     9e1:	e8 2a ff ff ff       	call   910 <parseline>
  if(!peek(ps, es, ")"))
     9e6:	83 c4 0c             	add    $0xc,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     9e9:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9eb:	68 d0 14 00 00       	push   $0x14d0
     9f0:	56                   	push   %esi
     9f1:	53                   	push   %ebx
     9f2:	e8 79 fc ff ff       	call   670 <peek>
     9f7:	83 c4 10             	add    $0x10,%esp
     9fa:	85 c0                	test   %eax,%eax
     9fc:	74 2b                	je     a29 <parseblock+0x79>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
     9fe:	6a 00                	push   $0x0
     a00:	6a 00                	push   $0x0
     a02:	56                   	push   %esi
     a03:	53                   	push   %ebx
     a04:	e8 f7 fa ff ff       	call   500 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     a09:	83 c4 0c             	add    $0xc,%esp
     a0c:	56                   	push   %esi
     a0d:	53                   	push   %ebx
     a0e:	57                   	push   %edi
     a0f:	e8 cc fc ff ff       	call   6e0 <parseredirs>
  return cmd;
}
     a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a17:	5b                   	pop    %ebx
     a18:	5e                   	pop    %esi
     a19:	5f                   	pop    %edi
     a1a:	5d                   	pop    %ebp
     a1b:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     a1c:	83 ec 0c             	sub    $0xc,%esp
     a1f:	68 b4 14 00 00       	push   $0x14b4
     a24:	e8 b7 f7 ff ff       	call   1e0 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
     a29:	83 ec 0c             	sub    $0xc,%esp
     a2c:	68 bf 14 00 00       	push   $0x14bf
     a31:	e8 aa f7 ff ff       	call   1e0 <panic>
     a36:	8d 76 00             	lea    0x0(%esi),%esi
     a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a40 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	53                   	push   %ebx
     a44:	83 ec 04             	sub    $0x4,%esp
     a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a4a:	85 db                	test   %ebx,%ebx
     a4c:	0f 84 96 00 00 00    	je     ae8 <nulterminate+0xa8>
    return 0;

  switch(cmd->type){
     a52:	83 3b 05             	cmpl   $0x5,(%ebx)
     a55:	77 48                	ja     a9f <nulterminate+0x5f>
     a57:	8b 03                	mov    (%ebx),%eax
     a59:	ff 24 85 64 15 00 00 	jmp    *0x1564(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a60:	83 ec 0c             	sub    $0xc,%esp
     a63:	ff 73 04             	pushl  0x4(%ebx)
     a66:	e8 d5 ff ff ff       	call   a40 <nulterminate>
    nulterminate(lcmd->right);
     a6b:	58                   	pop    %eax
     a6c:	ff 73 08             	pushl  0x8(%ebx)
     a6f:	e8 cc ff ff ff       	call   a40 <nulterminate>
    break;
     a74:	83 c4 10             	add    $0x10,%esp
     a77:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a79:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a7c:	c9                   	leave  
     a7d:	c3                   	ret    
     a7e:	66 90                	xchg   %ax,%ax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a80:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a83:	8d 43 2c             	lea    0x2c(%ebx),%eax
     a86:	85 c9                	test   %ecx,%ecx
     a88:	74 15                	je     a9f <nulterminate+0x5f>
     a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a90:	8b 10                	mov    (%eax),%edx
     a92:	83 c0 04             	add    $0x4,%eax
     a95:	c6 02 00             	movb   $0x0,(%edx)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a98:	8b 50 d8             	mov    -0x28(%eax),%edx
     a9b:	85 d2                	test   %edx,%edx
     a9d:	75 f1                	jne    a90 <nulterminate+0x50>
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
     a9f:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     aa1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     aa4:	c9                   	leave  
     aa5:	c3                   	ret    
     aa6:	8d 76 00             	lea    0x0(%esi),%esi
     aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     ab0:	83 ec 0c             	sub    $0xc,%esp
     ab3:	ff 73 04             	pushl  0x4(%ebx)
     ab6:	e8 85 ff ff ff       	call   a40 <nulterminate>
    break;
     abb:	89 d8                	mov    %ebx,%eax
     abd:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     ac0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ac3:	c9                   	leave  
     ac4:	c3                   	ret    
     ac5:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     ac8:	83 ec 0c             	sub    $0xc,%esp
     acb:	ff 73 04             	pushl  0x4(%ebx)
     ace:	e8 6d ff ff ff       	call   a40 <nulterminate>
    *rcmd->efile = 0;
     ad3:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     ad6:	83 c4 10             	add    $0x10,%esp
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
     ad9:	c6 00 00             	movb   $0x0,(%eax)
    break;
     adc:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     ade:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ae1:	c9                   	leave  
     ae2:	c3                   	ret    
     ae3:	90                   	nop
     ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
     ae8:	31 c0                	xor    %eax,%eax
     aea:	eb 8d                	jmp    a79 <nulterminate+0x39>
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000af0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	56                   	push   %esi
     af4:	53                   	push   %ebx
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     af8:	83 ec 0c             	sub    $0xc,%esp
     afb:	53                   	push   %ebx
     afc:	e8 ef 02 00 00       	call   df0 <strlen>
  cmd = parseline(&s, es);
     b01:	59                   	pop    %ecx
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     b02:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b04:	8d 45 08             	lea    0x8(%ebp),%eax
     b07:	5e                   	pop    %esi
     b08:	53                   	push   %ebx
     b09:	50                   	push   %eax
     b0a:	e8 01 fe ff ff       	call   910 <parseline>
     b0f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     b11:	8d 45 08             	lea    0x8(%ebp),%eax
     b14:	83 c4 0c             	add    $0xc,%esp
     b17:	68 0e 15 00 00       	push   $0x150e
     b1c:	53                   	push   %ebx
     b1d:	50                   	push   %eax
     b1e:	e8 4d fb ff ff       	call   670 <peek>
  if(s != es){
     b23:	8b 45 08             	mov    0x8(%ebp),%eax
     b26:	83 c4 10             	add    $0x10,%esp
     b29:	39 c3                	cmp    %eax,%ebx
     b2b:	75 12                	jne    b3f <parsecmd+0x4f>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
     b2d:	83 ec 0c             	sub    $0xc,%esp
     b30:	56                   	push   %esi
     b31:	e8 0a ff ff ff       	call   a40 <nulterminate>
  return cmd;
}
     b36:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b39:	89 f0                	mov    %esi,%eax
     b3b:	5b                   	pop    %ebx
     b3c:	5e                   	pop    %esi
     b3d:	5d                   	pop    %ebp
     b3e:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
     b3f:	52                   	push   %edx
     b40:	50                   	push   %eax
     b41:	68 d2 14 00 00       	push   $0x14d2
     b46:	6a 02                	push   $0x2
     b48:	e8 d3 05 00 00       	call   1120 <printf>
    panic("syntax");
     b4d:	c7 04 24 96 14 00 00 	movl   $0x1496,(%esp)
     b54:	e8 87 f6 ff ff       	call   1e0 <panic>
     b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b60 <cu>:
  }
  return cmd;
}

int cu(int argc, char* argv1, char* argv2)
{	
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
     b65:	53                   	push   %ebx
	int loginSuccess = 0;
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv1;
	char nameList[128];
	char buf[512];
	int checkReadFile = read(fd, buf,sizeof buf);
     b66:	8d 9d e8 fd ff ff    	lea    -0x218(%ebp),%ebx
  }
  return cmd;
}

int cu(int argc, char* argv1, char* argv2)
{	
     b6c:	81 ec 24 03 00 00    	sub    $0x324,%esp
	int loginSuccess = 0;
	int fd = open("UserList", O_RDONLY);
     b72:	6a 00                	push   $0x0
     b74:	68 e1 14 00 00       	push   $0x14e1
     b79:	e8 74 04 00 00       	call   ff2 <open>
	char *targetUser = argv1;
	char nameList[128];
	char buf[512];
	int checkReadFile = read(fd, buf,sizeof buf);
     b7e:	83 c4 0c             	add    $0xc,%esp
}

int cu(int argc, char* argv1, char* argv2)
{	
	int loginSuccess = 0;
	int fd = open("UserList", O_RDONLY);
     b81:	89 85 e0 fc ff ff    	mov    %eax,-0x320(%ebp)
	char *targetUser = argv1;
	char nameList[128];
	char buf[512];
	int checkReadFile = read(fd, buf,sizeof buf);
     b87:	68 00 02 00 00       	push   $0x200
     b8c:	53                   	push   %ebx
     b8d:	50                   	push   %eax
     b8e:	e8 37 04 00 00       	call   fca <read>
	if(checkReadFile < 0)
     b93:	83 c4 10             	add    $0x10,%esp
     b96:	85 c0                	test   %eax,%eax
     b98:	0f 88 89 01 00 00    	js     d27 <cu+0x1c7>
     b9e:	31 ff                	xor    %edi,%edi
     ba0:	c7 85 e4 fc ff ff 00 	movl   $0x0,-0x31c(%ebp)
     ba7:	00 00 00 
     baa:	eb 1c                	jmp    bc8 <cu+0x68>
     bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				n = 0;
			}
			else
			{
				//printf(1,"n: %d\n",n);
				nameList[n]=c;
     bb0:	88 94 3d e8 fc ff ff 	mov    %dl,-0x318(%ebp,%edi,1)
				n++;
     bb7:	83 c7 01             	add    $0x1,%edi
			}
			
		
		}while(c != '\0');
     bba:	84 d2                	test   %dl,%dl
     bbc:	0f 84 39 01 00 00    	je     cfb <cu+0x19b>
					{
						c = buf[i];
						i++;
					} while (c != ':');
				}
				n = 0;
     bc2:	89 85 e4 fc ff ff    	mov    %eax,-0x31c(%ebp)
		int i = 0; // buffer iterator
		int n = 0; // name iterator
		char c;
		do
		{
			c=buf[i];		
     bc8:	8b 85 e4 fc ff ff    	mov    -0x31c(%ebp),%eax
     bce:	0f b6 94 05 e8 fd ff 	movzbl -0x218(%ebp,%eax,1),%edx
     bd5:	ff 
			i++;
     bd6:	83 c0 01             	add    $0x1,%eax
			
			if(c==':')
     bd9:	80 fa 3a             	cmp    $0x3a,%dl
     bdc:	75 d2                	jne    bb0 <cu+0x50>
			{
				// compare string
				//printf(1, "names: %s\n", names);
				char* j = targetUser;
				char* k = nameList;
				while(n > 0 && *j && *j == *k)
     bde:	85 ff                	test   %edi,%edi
     be0:	74 4d                	je     c2f <cu+0xcf>
     be2:	8b 75 0c             	mov    0xc(%ebp),%esi
     be5:	0f b6 16             	movzbl (%esi),%edx
     be8:	84 d2                	test   %dl,%dl
     bea:	0f 84 f8 00 00 00    	je     ce8 <cu+0x188>
     bf0:	3a 95 e8 fc ff ff    	cmp    -0x318(%ebp),%dl
     bf6:	0f 85 ec 00 00 00    	jne    ce8 <cu+0x188>
     bfc:	8d 56 01             	lea    0x1(%esi),%edx
     bff:	01 f7                	add    %esi,%edi
     c01:	8d 8d e8 fc ff ff    	lea    -0x318(%ebp),%ecx
     c07:	89 c6                	mov    %eax,%esi
     c09:	eb 1b                	jmp    c26 <cu+0xc6>
     c0b:	90                   	nop
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c10:	0f b6 02             	movzbl (%edx),%eax
     c13:	84 c0                	test   %al,%al
     c15:	0f 84 c5 00 00 00    	je     ce0 <cu+0x180>
     c1b:	83 c2 01             	add    $0x1,%edx
     c1e:	3a 01                	cmp    (%ecx),%al
     c20:	0f 85 ba 00 00 00    	jne    ce0 <cu+0x180>
				{
					//printf(1,"n=%d\n",n);
					n--;
					j++;
					k++;
     c26:	83 c1 01             	add    $0x1,%ecx
			{
				// compare string
				//printf(1, "names: %s\n", names);
				char* j = targetUser;
				char* k = nameList;
				while(n > 0 && *j && *j == *k)
     c29:	39 fa                	cmp    %edi,%edx
     c2b:	75 e3                	jne    c10 <cu+0xb0>
     c2d:	89 f0                	mov    %esi,%eax
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
     c2f:	0f b6 94 05 e8 fd ff 	movzbl -0x218(%ebp,%eax,1),%edx
     c36:	ff 
						i++;

						if (c == ':')
     c37:	80 fa 3a             	cmp    $0x3a,%dl
     c3a:	74 61                	je     c9d <cu+0x13d>
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
     c3c:	03 9d e4 fc ff ff    	add    -0x31c(%ebp),%ebx
						i++;

						if (c == ':')
     c42:	31 c0                	xor    %eax,%eax
							}
							break;
						}
						else
						{
							password[p] = c;
     c44:	88 94 05 68 fd ff ff 	mov    %dl,-0x298(%ebp,%eax,1)
							p++;
     c4b:	83 c0 01             	add    $0x1,%eax
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
     c4e:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
						i++;

						if (c == ':')
     c53:	80 fa 3a             	cmp    $0x3a,%dl
     c56:	75 ec                	jne    c44 <cu+0xe4>
						{
							// compare password string
							j = argv2;
							k = password;
							while (p > 0 && *j && *j == *k)
     c58:	8b 75 10             	mov    0x10(%ebp),%esi
     c5b:	0f b6 16             	movzbl (%esi),%edx
     c5e:	84 d2                	test   %dl,%dl
     c60:	0f 84 d7 00 00 00    	je     d3d <cu+0x1dd>
     c66:	3a 95 68 fd ff ff    	cmp    -0x298(%ebp),%dl
     c6c:	0f 85 cb 00 00 00    	jne    d3d <cu+0x1dd>
     c72:	01 f0                	add    %esi,%eax
     c74:	8d 95 68 fd ff ff    	lea    -0x298(%ebp),%edx
     c7a:	89 f1                	mov    %esi,%ecx
     c7c:	eb 15                	jmp    c93 <cu+0x133>
     c7e:	66 90                	xchg   %ax,%ax
     c80:	0f b6 19             	movzbl (%ecx),%ebx
     c83:	84 db                	test   %bl,%bl
     c85:	0f 84 b2 00 00 00    	je     d3d <cu+0x1dd>
     c8b:	3a 1a                	cmp    (%edx),%bl
     c8d:	0f 85 aa 00 00 00    	jne    d3d <cu+0x1dd>
							{
								p--;
								j++;
     c93:	83 c1 01             	add    $0x1,%ecx
								k++;
     c96:	83 c2 01             	add    $0x1,%edx
						if (c == ':')
						{
							// compare password string
							j = argv2;
							k = password;
							while (p > 0 && *j && *j == *k)
     c99:	39 c1                	cmp    %eax,%ecx
     c9b:	75 e3                	jne    c80 <cu+0x120>
								j++;
								k++;
							} 
							if (p == 0)
							{
								if (argv1[strlen(argv1)-1] == '\n')
     c9d:	83 ec 0c             	sub    $0xc,%esp
     ca0:	ff 75 0c             	pushl  0xc(%ebp)
     ca3:	e8 48 01 00 00       	call   df0 <strlen>
     ca8:	8b 75 0c             	mov    0xc(%ebp),%esi
     cab:	83 c4 10             	add    $0x10,%esp
     cae:	80 7c 06 ff 0a       	cmpb   $0xa,-0x1(%esi,%eax,1)
     cb3:	0f 84 9a 00 00 00    	je     d53 <cu+0x1f3>
								{
									argv1[strlen(argv1)-1] = '\0';
								}
								changeUser(argv1);
     cb9:	83 ec 0c             	sub    $0xc,%esp
     cbc:	ff 75 0c             	pushl  0xc(%ebp)
								printf(1,"User changed.\n");
								loginSuccess = 1;
     cbf:	bb 01 00 00 00       	mov    $0x1,%ebx
							{
								if (argv1[strlen(argv1)-1] == '\n')
								{
									argv1[strlen(argv1)-1] = '\0';
								}
								changeUser(argv1);
     cc4:	e8 99 03 00 00       	call   1062 <changeUser>
								printf(1,"User changed.\n");
     cc9:	58                   	pop    %eax
     cca:	5a                   	pop    %edx
     ccb:	68 00 15 00 00       	push   $0x1500
     cd0:	6a 01                	push   $0x1
     cd2:	e8 49 04 00 00       	call   1120 <printf>
     cd7:	83 c4 10             	add    $0x10,%esp
     cda:	eb 33                	jmp    d0f <cu+0x1af>
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ce0:	89 f0                	mov    %esi,%eax
     ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				else
				{
					// skip the password part
					do
					{
						c = buf[i];
     ce8:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
						i++;
     cec:	83 c0 01             	add    $0x1,%eax
					} while (c != ':');
     cef:	80 fa 3a             	cmp    $0x3a,%dl
     cf2:	75 f4                	jne    ce8 <cu+0x188>
				}
				n = 0;
     cf4:	31 ff                	xor    %edi,%edi
     cf6:	e9 c7 fe ff ff       	jmp    bc2 <cu+0x62>
			
		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
     cfb:	83 ec 08             	sub    $0x8,%esp
  return cmd;
}

int cu(int argc, char* argv1, char* argv2)
{	
	int loginSuccess = 0;
     cfe:	31 db                	xor    %ebx,%ebx
			
		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
     d00:	68 0f 15 00 00       	push   $0x150f
     d05:	6a 01                	push   $0x1
     d07:	e8 14 04 00 00       	call   1120 <printf>
     d0c:	83 c4 10             	add    $0x10,%esp
		}
	}
	
	close(fd);
     d0f:	83 ec 0c             	sub    $0xc,%esp
     d12:	ff b5 e0 fc ff ff    	pushl  -0x320(%ebp)
     d18:	e8 bd 02 00 00       	call   fda <close>


		
	return loginSuccess;
}
     d1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d20:	89 d8                	mov    %ebx,%eax
     d22:	5b                   	pop    %ebx
     d23:	5e                   	pop    %esi
     d24:	5f                   	pop    %edi
     d25:	5d                   	pop    %ebp
     d26:	c3                   	ret    
	char nameList[128];
	char buf[512];
	int checkReadFile = read(fd, buf,sizeof buf);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
     d27:	83 ec 08             	sub    $0x8,%esp
  return cmd;
}

int cu(int argc, char* argv1, char* argv2)
{	
	int loginSuccess = 0;
     d2a:	31 db                	xor    %ebx,%ebx
	char nameList[128];
	char buf[512];
	int checkReadFile = read(fd, buf,sizeof buf);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
     d2c:	68 ea 14 00 00       	push   $0x14ea
     d31:	6a 01                	push   $0x1
     d33:	e8 e8 03 00 00       	call   1120 <printf>
     d38:	83 c4 10             	add    $0x10,%esp
     d3b:	eb d2                	jmp    d0f <cu+0x1af>
								printf(1,"User changed.\n");
								loginSuccess = 1;
							}
							else
							{
								printf(1,"Incorrect password. Please try again.\n");
     d3d:	83 ec 08             	sub    $0x8,%esp
  return cmd;
}

int cu(int argc, char* argv1, char* argv2)
{	
	int loginSuccess = 0;
     d40:	31 db                	xor    %ebx,%ebx
								printf(1,"User changed.\n");
								loginSuccess = 1;
							}
							else
							{
								printf(1,"Incorrect password. Please try again.\n");
     d42:	68 7c 15 00 00       	push   $0x157c
     d47:	6a 01                	push   $0x1
     d49:	e8 d2 03 00 00       	call   1120 <printf>
     d4e:	83 c4 10             	add    $0x10,%esp
     d51:	eb bc                	jmp    d0f <cu+0x1af>
							} 
							if (p == 0)
							{
								if (argv1[strlen(argv1)-1] == '\n')
								{
									argv1[strlen(argv1)-1] = '\0';
     d53:	83 ec 0c             	sub    $0xc,%esp
     d56:	ff 75 0c             	pushl  0xc(%ebp)
     d59:	e8 92 00 00 00       	call   df0 <strlen>
     d5e:	8b 75 0c             	mov    0xc(%ebp),%esi
     d61:	83 c4 10             	add    $0x10,%esp
     d64:	c6 44 06 ff 00       	movb   $0x0,-0x1(%esi,%eax,1)
     d69:	e9 4b ff ff ff       	jmp    cb9 <cu+0x159>
     d6e:	66 90                	xchg   %ax,%ax

00000d70 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	53                   	push   %ebx
     d74:	8b 45 08             	mov    0x8(%ebp),%eax
     d77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d7a:	89 c2                	mov    %eax,%edx
     d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d80:	83 c1 01             	add    $0x1,%ecx
     d83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     d87:	83 c2 01             	add    $0x1,%edx
     d8a:	84 db                	test   %bl,%bl
     d8c:	88 5a ff             	mov    %bl,-0x1(%edx)
     d8f:	75 ef                	jne    d80 <strcpy+0x10>
    ;
  return os;
}
     d91:	5b                   	pop    %ebx
     d92:	5d                   	pop    %ebp
     d93:	c3                   	ret    
     d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000da0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	56                   	push   %esi
     da4:	53                   	push   %ebx
     da5:	8b 55 08             	mov    0x8(%ebp),%edx
     da8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     dab:	0f b6 02             	movzbl (%edx),%eax
     dae:	0f b6 19             	movzbl (%ecx),%ebx
     db1:	84 c0                	test   %al,%al
     db3:	75 1e                	jne    dd3 <strcmp+0x33>
     db5:	eb 29                	jmp    de0 <strcmp+0x40>
     db7:	89 f6                	mov    %esi,%esi
     db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     dc0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     dc3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     dc6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     dc9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     dcd:	84 c0                	test   %al,%al
     dcf:	74 0f                	je     de0 <strcmp+0x40>
     dd1:	89 f1                	mov    %esi,%ecx
     dd3:	38 d8                	cmp    %bl,%al
     dd5:	74 e9                	je     dc0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     dd7:	29 d8                	sub    %ebx,%eax
}
     dd9:	5b                   	pop    %ebx
     dda:	5e                   	pop    %esi
     ddb:	5d                   	pop    %ebp
     ddc:	c3                   	ret    
     ddd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     de0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     de2:	29 d8                	sub    %ebx,%eax
}
     de4:	5b                   	pop    %ebx
     de5:	5e                   	pop    %esi
     de6:	5d                   	pop    %ebp
     de7:	c3                   	ret    
     de8:	90                   	nop
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000df0 <strlen>:

uint
strlen(const char *s)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     df6:	80 39 00             	cmpb   $0x0,(%ecx)
     df9:	74 12                	je     e0d <strlen+0x1d>
     dfb:	31 d2                	xor    %edx,%edx
     dfd:	8d 76 00             	lea    0x0(%esi),%esi
     e00:	83 c2 01             	add    $0x1,%edx
     e03:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     e07:	89 d0                	mov    %edx,%eax
     e09:	75 f5                	jne    e00 <strlen+0x10>
    ;
  return n;
}
     e0b:	5d                   	pop    %ebp
     e0c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     e0d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     e0f:	5d                   	pop    %ebp
     e10:	c3                   	ret    
     e11:	eb 0d                	jmp    e20 <memset>
     e13:	90                   	nop
     e14:	90                   	nop
     e15:	90                   	nop
     e16:	90                   	nop
     e17:	90                   	nop
     e18:	90                   	nop
     e19:	90                   	nop
     e1a:	90                   	nop
     e1b:	90                   	nop
     e1c:	90                   	nop
     e1d:	90                   	nop
     e1e:	90                   	nop
     e1f:	90                   	nop

00000e20 <memset>:

void*
memset(void *dst, int c, uint n)
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     e27:	8b 4d 10             	mov    0x10(%ebp),%ecx
     e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     e2d:	89 d7                	mov    %edx,%edi
     e2f:	fc                   	cld    
     e30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     e32:	89 d0                	mov    %edx,%eax
     e34:	5f                   	pop    %edi
     e35:	5d                   	pop    %ebp
     e36:	c3                   	ret    
     e37:	89 f6                	mov    %esi,%esi
     e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e40 <strchr>:

char*
strchr(const char *s, char c)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	53                   	push   %ebx
     e44:	8b 45 08             	mov    0x8(%ebp),%eax
     e47:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     e4a:	0f b6 10             	movzbl (%eax),%edx
     e4d:	84 d2                	test   %dl,%dl
     e4f:	74 1d                	je     e6e <strchr+0x2e>
    if(*s == c)
     e51:	38 d3                	cmp    %dl,%bl
     e53:	89 d9                	mov    %ebx,%ecx
     e55:	75 0d                	jne    e64 <strchr+0x24>
     e57:	eb 17                	jmp    e70 <strchr+0x30>
     e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e60:	38 ca                	cmp    %cl,%dl
     e62:	74 0c                	je     e70 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     e64:	83 c0 01             	add    $0x1,%eax
     e67:	0f b6 10             	movzbl (%eax),%edx
     e6a:	84 d2                	test   %dl,%dl
     e6c:	75 f2                	jne    e60 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
     e6e:	31 c0                	xor    %eax,%eax
}
     e70:	5b                   	pop    %ebx
     e71:	5d                   	pop    %ebp
     e72:	c3                   	ret    
     e73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e80 <gets>:

char*
gets(char *buf, int max)
{
     e80:	55                   	push   %ebp
     e81:	89 e5                	mov    %esp,%ebp
     e83:	57                   	push   %edi
     e84:	56                   	push   %esi
     e85:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e86:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     e88:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
     e8b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e8e:	eb 29                	jmp    eb9 <gets+0x39>
    cc = read(0, &c, 1);
     e90:	83 ec 04             	sub    $0x4,%esp
     e93:	6a 01                	push   $0x1
     e95:	57                   	push   %edi
     e96:	6a 00                	push   $0x0
     e98:	e8 2d 01 00 00       	call   fca <read>
    if(cc < 1)
     e9d:	83 c4 10             	add    $0x10,%esp
     ea0:	85 c0                	test   %eax,%eax
     ea2:	7e 1d                	jle    ec1 <gets+0x41>
      break;
    buf[i++] = c;
     ea4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     ea8:	8b 55 08             	mov    0x8(%ebp),%edx
     eab:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
     ead:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     eaf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     eb3:	74 1b                	je     ed0 <gets+0x50>
     eb5:	3c 0d                	cmp    $0xd,%al
     eb7:	74 17                	je     ed0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     eb9:	8d 5e 01             	lea    0x1(%esi),%ebx
     ebc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     ebf:	7c cf                	jl     e90 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ec1:	8b 45 08             	mov    0x8(%ebp),%eax
     ec4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ec8:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ecb:	5b                   	pop    %ebx
     ecc:	5e                   	pop    %esi
     ecd:	5f                   	pop    %edi
     ece:	5d                   	pop    %ebp
     ecf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ed0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     ed3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     ed5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     ed9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     edc:	5b                   	pop    %ebx
     edd:	5e                   	pop    %esi
     ede:	5f                   	pop    %edi
     edf:	5d                   	pop    %ebp
     ee0:	c3                   	ret    
     ee1:	eb 0d                	jmp    ef0 <stat>
     ee3:	90                   	nop
     ee4:	90                   	nop
     ee5:	90                   	nop
     ee6:	90                   	nop
     ee7:	90                   	nop
     ee8:	90                   	nop
     ee9:	90                   	nop
     eea:	90                   	nop
     eeb:	90                   	nop
     eec:	90                   	nop
     eed:	90                   	nop
     eee:	90                   	nop
     eef:	90                   	nop

00000ef0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	56                   	push   %esi
     ef4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ef5:	83 ec 08             	sub    $0x8,%esp
     ef8:	6a 00                	push   $0x0
     efa:	ff 75 08             	pushl  0x8(%ebp)
     efd:	e8 f0 00 00 00       	call   ff2 <open>
  if(fd < 0)
     f02:	83 c4 10             	add    $0x10,%esp
     f05:	85 c0                	test   %eax,%eax
     f07:	78 27                	js     f30 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     f09:	83 ec 08             	sub    $0x8,%esp
     f0c:	ff 75 0c             	pushl  0xc(%ebp)
     f0f:	89 c3                	mov    %eax,%ebx
     f11:	50                   	push   %eax
     f12:	e8 f3 00 00 00       	call   100a <fstat>
     f17:	89 c6                	mov    %eax,%esi
  close(fd);
     f19:	89 1c 24             	mov    %ebx,(%esp)
     f1c:	e8 b9 00 00 00       	call   fda <close>
  return r;
     f21:	83 c4 10             	add    $0x10,%esp
     f24:	89 f0                	mov    %esi,%eax
}
     f26:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f29:	5b                   	pop    %ebx
     f2a:	5e                   	pop    %esi
     f2b:	5d                   	pop    %ebp
     f2c:	c3                   	ret    
     f2d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     f35:	eb ef                	jmp    f26 <stat+0x36>
     f37:	89 f6                	mov    %esi,%esi
     f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000f40 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	53                   	push   %ebx
     f44:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f47:	0f be 11             	movsbl (%ecx),%edx
     f4a:	8d 42 d0             	lea    -0x30(%edx),%eax
     f4d:	3c 09                	cmp    $0x9,%al
     f4f:	b8 00 00 00 00       	mov    $0x0,%eax
     f54:	77 1f                	ja     f75 <atoi+0x35>
     f56:	8d 76 00             	lea    0x0(%esi),%esi
     f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     f60:	8d 04 80             	lea    (%eax,%eax,4),%eax
     f63:	83 c1 01             	add    $0x1,%ecx
     f66:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f6a:	0f be 11             	movsbl (%ecx),%edx
     f6d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     f70:	80 fb 09             	cmp    $0x9,%bl
     f73:	76 eb                	jbe    f60 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
     f75:	5b                   	pop    %ebx
     f76:	5d                   	pop    %ebp
     f77:	c3                   	ret    
     f78:	90                   	nop
     f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f80 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	56                   	push   %esi
     f84:	53                   	push   %ebx
     f85:	8b 5d 10             	mov    0x10(%ebp),%ebx
     f88:	8b 45 08             	mov    0x8(%ebp),%eax
     f8b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     f8e:	85 db                	test   %ebx,%ebx
     f90:	7e 14                	jle    fa6 <memmove+0x26>
     f92:	31 d2                	xor    %edx,%edx
     f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     f98:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     f9c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     f9f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     fa2:	39 da                	cmp    %ebx,%edx
     fa4:	75 f2                	jne    f98 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     fa6:	5b                   	pop    %ebx
     fa7:	5e                   	pop    %esi
     fa8:	5d                   	pop    %ebp
     fa9:	c3                   	ret    

00000faa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     faa:	b8 01 00 00 00       	mov    $0x1,%eax
     faf:	cd 40                	int    $0x40
     fb1:	c3                   	ret    

00000fb2 <exit>:
SYSCALL(exit)
     fb2:	b8 02 00 00 00       	mov    $0x2,%eax
     fb7:	cd 40                	int    $0x40
     fb9:	c3                   	ret    

00000fba <wait>:
SYSCALL(wait)
     fba:	b8 03 00 00 00       	mov    $0x3,%eax
     fbf:	cd 40                	int    $0x40
     fc1:	c3                   	ret    

00000fc2 <pipe>:
SYSCALL(pipe)
     fc2:	b8 04 00 00 00       	mov    $0x4,%eax
     fc7:	cd 40                	int    $0x40
     fc9:	c3                   	ret    

00000fca <read>:
SYSCALL(read)
     fca:	b8 05 00 00 00       	mov    $0x5,%eax
     fcf:	cd 40                	int    $0x40
     fd1:	c3                   	ret    

00000fd2 <write>:
SYSCALL(write)
     fd2:	b8 10 00 00 00       	mov    $0x10,%eax
     fd7:	cd 40                	int    $0x40
     fd9:	c3                   	ret    

00000fda <close>:
SYSCALL(close)
     fda:	b8 15 00 00 00       	mov    $0x15,%eax
     fdf:	cd 40                	int    $0x40
     fe1:	c3                   	ret    

00000fe2 <kill>:
SYSCALL(kill)
     fe2:	b8 06 00 00 00       	mov    $0x6,%eax
     fe7:	cd 40                	int    $0x40
     fe9:	c3                   	ret    

00000fea <exec>:
SYSCALL(exec)
     fea:	b8 07 00 00 00       	mov    $0x7,%eax
     fef:	cd 40                	int    $0x40
     ff1:	c3                   	ret    

00000ff2 <open>:
SYSCALL(open)
     ff2:	b8 0f 00 00 00       	mov    $0xf,%eax
     ff7:	cd 40                	int    $0x40
     ff9:	c3                   	ret    

00000ffa <mknod>:
SYSCALL(mknod)
     ffa:	b8 11 00 00 00       	mov    $0x11,%eax
     fff:	cd 40                	int    $0x40
    1001:	c3                   	ret    

00001002 <unlink>:
SYSCALL(unlink)
    1002:	b8 12 00 00 00       	mov    $0x12,%eax
    1007:	cd 40                	int    $0x40
    1009:	c3                   	ret    

0000100a <fstat>:
SYSCALL(fstat)
    100a:	b8 08 00 00 00       	mov    $0x8,%eax
    100f:	cd 40                	int    $0x40
    1011:	c3                   	ret    

00001012 <link>:
SYSCALL(link)
    1012:	b8 13 00 00 00       	mov    $0x13,%eax
    1017:	cd 40                	int    $0x40
    1019:	c3                   	ret    

0000101a <mkdir>:
SYSCALL(mkdir)
    101a:	b8 14 00 00 00       	mov    $0x14,%eax
    101f:	cd 40                	int    $0x40
    1021:	c3                   	ret    

00001022 <chdir>:
SYSCALL(chdir)
    1022:	b8 09 00 00 00       	mov    $0x9,%eax
    1027:	cd 40                	int    $0x40
    1029:	c3                   	ret    

0000102a <dup>:
SYSCALL(dup)
    102a:	b8 0a 00 00 00       	mov    $0xa,%eax
    102f:	cd 40                	int    $0x40
    1031:	c3                   	ret    

00001032 <getpid>:
SYSCALL(getpid)
    1032:	b8 0b 00 00 00       	mov    $0xb,%eax
    1037:	cd 40                	int    $0x40
    1039:	c3                   	ret    

0000103a <sbrk>:
SYSCALL(sbrk)
    103a:	b8 0c 00 00 00       	mov    $0xc,%eax
    103f:	cd 40                	int    $0x40
    1041:	c3                   	ret    

00001042 <sleep>:
SYSCALL(sleep)
    1042:	b8 0d 00 00 00       	mov    $0xd,%eax
    1047:	cd 40                	int    $0x40
    1049:	c3                   	ret    

0000104a <uptime>:
SYSCALL(uptime)
    104a:	b8 0e 00 00 00       	mov    $0xe,%eax
    104f:	cd 40                	int    $0x40
    1051:	c3                   	ret    

00001052 <cps>:
SYSCALL(cps)
    1052:	b8 16 00 00 00       	mov    $0x16,%eax
    1057:	cd 40                	int    $0x40
    1059:	c3                   	ret    

0000105a <userTag>:
SYSCALL(userTag)
    105a:	b8 17 00 00 00       	mov    $0x17,%eax
    105f:	cd 40                	int    $0x40
    1061:	c3                   	ret    

00001062 <changeUser>:
SYSCALL(changeUser)
    1062:	b8 18 00 00 00       	mov    $0x18,%eax
    1067:	cd 40                	int    $0x40
    1069:	c3                   	ret    

0000106a <getUser>:
SYSCALL(getUser)
    106a:	b8 19 00 00 00       	mov    $0x19,%eax
    106f:	cd 40                	int    $0x40
    1071:	c3                   	ret    

00001072 <changeOwner>:
SYSCALL(changeOwner)
    1072:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1077:	cd 40                	int    $0x40
    1079:	c3                   	ret    
    107a:	66 90                	xchg   %ax,%ax
    107c:	66 90                	xchg   %ax,%ax
    107e:	66 90                	xchg   %ax,%ax

00001080 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1080:	55                   	push   %ebp
    1081:	89 e5                	mov    %esp,%ebp
    1083:	57                   	push   %edi
    1084:	56                   	push   %esi
    1085:	53                   	push   %ebx
    1086:	89 c6                	mov    %eax,%esi
    1088:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    108b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    108e:	85 db                	test   %ebx,%ebx
    1090:	74 7e                	je     1110 <printint+0x90>
    1092:	89 d0                	mov    %edx,%eax
    1094:	c1 e8 1f             	shr    $0x1f,%eax
    1097:	84 c0                	test   %al,%al
    1099:	74 75                	je     1110 <printint+0x90>
    neg = 1;
    x = -xx;
    109b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    109d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    10a4:	f7 d8                	neg    %eax
    10a6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    10a9:	31 ff                	xor    %edi,%edi
    10ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    10ae:	89 ce                	mov    %ecx,%esi
    10b0:	eb 08                	jmp    10ba <printint+0x3a>
    10b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    10b8:	89 cf                	mov    %ecx,%edi
    10ba:	31 d2                	xor    %edx,%edx
    10bc:	8d 4f 01             	lea    0x1(%edi),%ecx
    10bf:	f7 f6                	div    %esi
    10c1:	0f b6 92 d8 15 00 00 	movzbl 0x15d8(%edx),%edx
  }while((x /= base) != 0);
    10c8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    10ca:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    10cd:	75 e9                	jne    10b8 <printint+0x38>
  if(neg)
    10cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    10d2:	8b 75 c0             	mov    -0x40(%ebp),%esi
    10d5:	85 c0                	test   %eax,%eax
    10d7:	74 08                	je     10e1 <printint+0x61>
    buf[i++] = '-';
    10d9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    10de:	8d 4f 02             	lea    0x2(%edi),%ecx
    10e1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    10e5:	8d 76 00             	lea    0x0(%esi),%esi
    10e8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10eb:	83 ec 04             	sub    $0x4,%esp
    10ee:	83 ef 01             	sub    $0x1,%edi
    10f1:	6a 01                	push   $0x1
    10f3:	53                   	push   %ebx
    10f4:	56                   	push   %esi
    10f5:	88 45 d7             	mov    %al,-0x29(%ebp)
    10f8:	e8 d5 fe ff ff       	call   fd2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    10fd:	83 c4 10             	add    $0x10,%esp
    1100:	39 df                	cmp    %ebx,%edi
    1102:	75 e4                	jne    10e8 <printint+0x68>
    putc(fd, buf[i]);
}
    1104:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1107:	5b                   	pop    %ebx
    1108:	5e                   	pop    %esi
    1109:	5f                   	pop    %edi
    110a:	5d                   	pop    %ebp
    110b:	c3                   	ret    
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1110:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1112:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1119:	eb 8b                	jmp    10a6 <printint+0x26>
    111b:	90                   	nop
    111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001120 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	56                   	push   %esi
    1125:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1126:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1129:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    112c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    112f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1132:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1135:	0f b6 1e             	movzbl (%esi),%ebx
    1138:	83 c6 01             	add    $0x1,%esi
    113b:	84 db                	test   %bl,%bl
    113d:	0f 84 b0 00 00 00    	je     11f3 <printf+0xd3>
    1143:	31 d2                	xor    %edx,%edx
    1145:	eb 39                	jmp    1180 <printf+0x60>
    1147:	89 f6                	mov    %esi,%esi
    1149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1150:	83 f8 25             	cmp    $0x25,%eax
    1153:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1156:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    115b:	74 18                	je     1175 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    115d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1160:	83 ec 04             	sub    $0x4,%esp
    1163:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1166:	6a 01                	push   $0x1
    1168:	50                   	push   %eax
    1169:	57                   	push   %edi
    116a:	e8 63 fe ff ff       	call   fd2 <write>
    116f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1172:	83 c4 10             	add    $0x10,%esp
    1175:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1178:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    117c:	84 db                	test   %bl,%bl
    117e:	74 73                	je     11f3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1180:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1182:	0f be cb             	movsbl %bl,%ecx
    1185:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1188:	74 c6                	je     1150 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    118a:	83 fa 25             	cmp    $0x25,%edx
    118d:	75 e6                	jne    1175 <printf+0x55>
      if(c == 'd'){
    118f:	83 f8 64             	cmp    $0x64,%eax
    1192:	0f 84 f8 00 00 00    	je     1290 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1198:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    119e:	83 f9 70             	cmp    $0x70,%ecx
    11a1:	74 5d                	je     1200 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    11a3:	83 f8 73             	cmp    $0x73,%eax
    11a6:	0f 84 84 00 00 00    	je     1230 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    11ac:	83 f8 63             	cmp    $0x63,%eax
    11af:	0f 84 ea 00 00 00    	je     129f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    11b5:	83 f8 25             	cmp    $0x25,%eax
    11b8:	0f 84 c2 00 00 00    	je     1280 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    11be:	8d 45 e7             	lea    -0x19(%ebp),%eax
    11c1:	83 ec 04             	sub    $0x4,%esp
    11c4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    11c8:	6a 01                	push   $0x1
    11ca:	50                   	push   %eax
    11cb:	57                   	push   %edi
    11cc:	e8 01 fe ff ff       	call   fd2 <write>
    11d1:	83 c4 0c             	add    $0xc,%esp
    11d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    11d7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    11da:	6a 01                	push   $0x1
    11dc:	50                   	push   %eax
    11dd:	57                   	push   %edi
    11de:	83 c6 01             	add    $0x1,%esi
    11e1:	e8 ec fd ff ff       	call   fd2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11e6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    11ea:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    11ed:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11ef:	84 db                	test   %bl,%bl
    11f1:	75 8d                	jne    1180 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    11f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11f6:	5b                   	pop    %ebx
    11f7:	5e                   	pop    %esi
    11f8:	5f                   	pop    %edi
    11f9:	5d                   	pop    %ebp
    11fa:	c3                   	ret    
    11fb:	90                   	nop
    11fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1200:	83 ec 0c             	sub    $0xc,%esp
    1203:	b9 10 00 00 00       	mov    $0x10,%ecx
    1208:	6a 00                	push   $0x0
    120a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    120d:	89 f8                	mov    %edi,%eax
    120f:	8b 13                	mov    (%ebx),%edx
    1211:	e8 6a fe ff ff       	call   1080 <printint>
        ap++;
    1216:	89 d8                	mov    %ebx,%eax
    1218:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    121b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    121d:	83 c0 04             	add    $0x4,%eax
    1220:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1223:	e9 4d ff ff ff       	jmp    1175 <printf+0x55>
    1228:	90                   	nop
    1229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1230:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1233:	8b 18                	mov    (%eax),%ebx
        ap++;
    1235:	83 c0 04             	add    $0x4,%eax
    1238:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    123b:	b8 d0 15 00 00       	mov    $0x15d0,%eax
    1240:	85 db                	test   %ebx,%ebx
    1242:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1245:	0f b6 03             	movzbl (%ebx),%eax
    1248:	84 c0                	test   %al,%al
    124a:	74 23                	je     126f <printf+0x14f>
    124c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1250:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1253:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1256:	83 ec 04             	sub    $0x4,%esp
    1259:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    125b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    125e:	50                   	push   %eax
    125f:	57                   	push   %edi
    1260:	e8 6d fd ff ff       	call   fd2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1265:	0f b6 03             	movzbl (%ebx),%eax
    1268:	83 c4 10             	add    $0x10,%esp
    126b:	84 c0                	test   %al,%al
    126d:	75 e1                	jne    1250 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    126f:	31 d2                	xor    %edx,%edx
    1271:	e9 ff fe ff ff       	jmp    1175 <printf+0x55>
    1276:	8d 76 00             	lea    0x0(%esi),%esi
    1279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1280:	83 ec 04             	sub    $0x4,%esp
    1283:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1286:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1289:	6a 01                	push   $0x1
    128b:	e9 4c ff ff ff       	jmp    11dc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1290:	83 ec 0c             	sub    $0xc,%esp
    1293:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1298:	6a 01                	push   $0x1
    129a:	e9 6b ff ff ff       	jmp    120a <printf+0xea>
    129f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    12a2:	83 ec 04             	sub    $0x4,%esp
    12a5:	8b 03                	mov    (%ebx),%eax
    12a7:	6a 01                	push   $0x1
    12a9:	88 45 e4             	mov    %al,-0x1c(%ebp)
    12ac:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    12af:	50                   	push   %eax
    12b0:	57                   	push   %edi
    12b1:	e8 1c fd ff ff       	call   fd2 <write>
    12b6:	e9 5b ff ff ff       	jmp    1216 <printf+0xf6>
    12bb:	66 90                	xchg   %ax,%ax
    12bd:	66 90                	xchg   %ax,%ax
    12bf:	90                   	nop

000012c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    12c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12c1:	a1 48 1c 00 00       	mov    0x1c48,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    12c6:	89 e5                	mov    %esp,%ebp
    12c8:	57                   	push   %edi
    12c9:	56                   	push   %esi
    12ca:	53                   	push   %ebx
    12cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12ce:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    12d0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12d3:	39 c8                	cmp    %ecx,%eax
    12d5:	73 19                	jae    12f0 <free+0x30>
    12d7:	89 f6                	mov    %esi,%esi
    12d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    12e0:	39 d1                	cmp    %edx,%ecx
    12e2:	72 1c                	jb     1300 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12e4:	39 d0                	cmp    %edx,%eax
    12e6:	73 18                	jae    1300 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    12e8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12ea:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12ec:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    12ee:	72 f0                	jb     12e0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    12f0:	39 d0                	cmp    %edx,%eax
    12f2:	72 f4                	jb     12e8 <free+0x28>
    12f4:	39 d1                	cmp    %edx,%ecx
    12f6:	73 f0                	jae    12e8 <free+0x28>
    12f8:	90                   	nop
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1300:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1303:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1306:	39 d7                	cmp    %edx,%edi
    1308:	74 19                	je     1323 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    130a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    130d:	8b 50 04             	mov    0x4(%eax),%edx
    1310:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1313:	39 f1                	cmp    %esi,%ecx
    1315:	74 23                	je     133a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1317:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1319:	a3 48 1c 00 00       	mov    %eax,0x1c48
}
    131e:	5b                   	pop    %ebx
    131f:	5e                   	pop    %esi
    1320:	5f                   	pop    %edi
    1321:	5d                   	pop    %ebp
    1322:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1323:	03 72 04             	add    0x4(%edx),%esi
    1326:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1329:	8b 10                	mov    (%eax),%edx
    132b:	8b 12                	mov    (%edx),%edx
    132d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1330:	8b 50 04             	mov    0x4(%eax),%edx
    1333:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1336:	39 f1                	cmp    %esi,%ecx
    1338:	75 dd                	jne    1317 <free+0x57>
    p->s.size += bp->s.size;
    133a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    133d:	a3 48 1c 00 00       	mov    %eax,0x1c48
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1342:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1345:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1348:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    134a:	5b                   	pop    %ebx
    134b:	5e                   	pop    %esi
    134c:	5f                   	pop    %edi
    134d:	5d                   	pop    %ebp
    134e:	c3                   	ret    
    134f:	90                   	nop

00001350 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1350:	55                   	push   %ebp
    1351:	89 e5                	mov    %esp,%ebp
    1353:	57                   	push   %edi
    1354:	56                   	push   %esi
    1355:	53                   	push   %ebx
    1356:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1359:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    135c:	8b 15 48 1c 00 00    	mov    0x1c48,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1362:	8d 78 07             	lea    0x7(%eax),%edi
    1365:	c1 ef 03             	shr    $0x3,%edi
    1368:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    136b:	85 d2                	test   %edx,%edx
    136d:	0f 84 a3 00 00 00    	je     1416 <malloc+0xc6>
    1373:	8b 02                	mov    (%edx),%eax
    1375:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1378:	39 cf                	cmp    %ecx,%edi
    137a:	76 74                	jbe    13f0 <malloc+0xa0>
    137c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1382:	be 00 10 00 00       	mov    $0x1000,%esi
    1387:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    138e:	0f 43 f7             	cmovae %edi,%esi
    1391:	ba 00 80 00 00       	mov    $0x8000,%edx
    1396:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    139c:	0f 46 da             	cmovbe %edx,%ebx
    139f:	eb 10                	jmp    13b1 <malloc+0x61>
    13a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    13a8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    13aa:	8b 48 04             	mov    0x4(%eax),%ecx
    13ad:	39 cf                	cmp    %ecx,%edi
    13af:	76 3f                	jbe    13f0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    13b1:	39 05 48 1c 00 00    	cmp    %eax,0x1c48
    13b7:	89 c2                	mov    %eax,%edx
    13b9:	75 ed                	jne    13a8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    13bb:	83 ec 0c             	sub    $0xc,%esp
    13be:	53                   	push   %ebx
    13bf:	e8 76 fc ff ff       	call   103a <sbrk>
  if(p == (char*)-1)
    13c4:	83 c4 10             	add    $0x10,%esp
    13c7:	83 f8 ff             	cmp    $0xffffffff,%eax
    13ca:	74 1c                	je     13e8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    13cc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    13cf:	83 ec 0c             	sub    $0xc,%esp
    13d2:	83 c0 08             	add    $0x8,%eax
    13d5:	50                   	push   %eax
    13d6:	e8 e5 fe ff ff       	call   12c0 <free>
  return freep;
    13db:	8b 15 48 1c 00 00    	mov    0x1c48,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    13e1:	83 c4 10             	add    $0x10,%esp
    13e4:	85 d2                	test   %edx,%edx
    13e6:	75 c0                	jne    13a8 <malloc+0x58>
        return 0;
    13e8:	31 c0                	xor    %eax,%eax
    13ea:	eb 1c                	jmp    1408 <malloc+0xb8>
    13ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    13f0:	39 cf                	cmp    %ecx,%edi
    13f2:	74 1c                	je     1410 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    13f4:	29 f9                	sub    %edi,%ecx
    13f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    13f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    13fc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    13ff:	89 15 48 1c 00 00    	mov    %edx,0x1c48
      return (void*)(p + 1);
    1405:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1408:	8d 65 f4             	lea    -0xc(%ebp),%esp
    140b:	5b                   	pop    %ebx
    140c:	5e                   	pop    %esi
    140d:	5f                   	pop    %edi
    140e:	5d                   	pop    %ebp
    140f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1410:	8b 08                	mov    (%eax),%ecx
    1412:	89 0a                	mov    %ecx,(%edx)
    1414:	eb e9                	jmp    13ff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1416:	c7 05 48 1c 00 00 4c 	movl   $0x1c4c,0x1c48
    141d:	1c 00 00 
    1420:	c7 05 4c 1c 00 00 4c 	movl   $0x1c4c,0x1c4c
    1427:	1c 00 00 
    base.s.size = 0;
    142a:	b8 4c 1c 00 00       	mov    $0x1c4c,%eax
    142f:	c7 05 50 1c 00 00 00 	movl   $0x0,0x1c50
    1436:	00 00 00 
    1439:	e9 3e ff ff ff       	jmp    137c <malloc+0x2c>
