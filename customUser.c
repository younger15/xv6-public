/*#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"
#include "customUser.h"*/
//#include "user.h"
//#include "fcntl.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

//add user concept
//static char currentUser[128];

void
initUser()
{
	//safestrcpy(currentUser,"Admin",5);
	
	/*char buf[1024];
	int fd = open("Filechanged",O_RDONLY);
	read(fd, buf, sizeof(buf));
	printf(1,"Filechanged: %s\n", buf);*/
}
