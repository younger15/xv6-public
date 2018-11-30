#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
int main(int argc, char *argv[])
{
	int fd;
	if(strcmp(argv[2], "rd") == 0)
	{
		fd = open(argv[1], O_RDONLY);
		if(fd >= 0)
		{
			char buf[1024];
			int n = read(fd, buf, sizeof buf);
			if(n >= 0)
			{
				printf(1,"%s\n", buf);
			}
			close(fd);
		}	
	}
	else if(strcmp(argv[2], "wr") == 0)
	{
		fd = open(argv[1], O_RDWR);
		if(fd >= 0)
		{
			//if(strlen(argv[3]) > 0)
			//{
				int n = write(fd, argv[3], strlen(argv[3]) + 1);
				if(n >= 0)
				{
					printf(1,"File update succeed\n");
				}
			//}
			close(fd);
		}
	}
	
	exit();
}
