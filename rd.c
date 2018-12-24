#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{

	int fd = open(argv[1],O_RDONLY);
	char buf[2048];
	int checkReadFile = read(fd, buf,sizeof buf);
	close(fd);
	if(checkReadFile < 0)
	{
		printf(1,"Can't open file.\n");
	}
	else
	{
		
		/*fd = open("UserList", O_RDWR);
		if(fd >= 0)
		{
			int i = strlen(buf);
			if (buf[i-1] == '\n')
				i--;
			int j = 0;
			for(j = 0; j < strlen(argv[1]); j++)
			{
				buf[i] = argv[1][j];
				i++;
			}
			buf[i]=':';
			buf[i+1]= '\0';
			//printf(1,"buf: %s\n", buf);
			write(fd,buf,strlen(buf)+1);
			close(fd);
		}*/
		printf(1,buf);
	}	

	exit();


}
