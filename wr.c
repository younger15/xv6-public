#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
	int fd = open(argv[1], O_RDONLY);
	char buf[2048];
	int checkReadFile = read(fd, buf,sizeof buf);
	close(fd);
	if(checkReadFile < 0)
	{
		printf(1,"Can't open file.\n");
	}
	else
	{
		fd = open(argv[1], O_RDWR);
		if(fd >= 0)
		{
			write(fd,argv[2],strlen(argv[2])+1);
			close(fd);
		}
		printf(1,"File written.\n");
	}
	
	exit();


}
