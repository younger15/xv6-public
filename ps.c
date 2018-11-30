#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// example app call custom system call



int main(int argc, char *argv[])
{
	//printf("argv0: %s\nargv1: %s\nargv2: %s\nargv3: %s\nargv4: %s\n", *argv[0],*argv[1],*argv[2],*argv[3],*argv[4]);
	//userTag(argv[1], argv[2], atoi(argv[3]), argv[4]);
	//changeUser(argv[1]);
	//cps();	

	//changeOwner(argv[1], argv[2]);
		
	//close(fd);
	//char buf[512];
	/*int fd = open("FileAppendix", O_RDWR);
	if(fd >= 0)
	{
		int n = read(fd, buf, sizeof buf);
		if(n >= 0)
		{
			printf(1, "%s\n", buf);			
		}
		strcpy(buf, argv[2]);
		write(fd, argv[2], strlen(buf) + 1);
		close(fd);
	}*/
	/*int fd = open("FileAppendix", O_RDONLY);
	if (fd >= 0)
	{
		int n = read(fd, buf, sizeof buf);
		if(n >= 0)
		{
			printf(1, "%s\n", buf);
			
		}
		close(fd);	
	}*/
	userTag(argv[1]);
	
	//getUser();

	exit();
}
