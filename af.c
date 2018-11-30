#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(int argc, char *argv[])
{
	
	int fd = open(argv[1], O_CREATE);
	if(fd >= 0)
	{
		printf(1,"create succeed\n");
		close(fd);
		//fd = open("FileAppendix", O_RDWR);
		
	}
	exit();
}
