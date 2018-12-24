#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{


	int fd = open("UserList", O_RDONLY);
	//char *targetUser = argv[1];
	//printf(1,"user: %s\n", targetUser);
	//char nameList[128];
	//char *names = nameList;
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	close(fd);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
	}
	else
	{

		fd = open("UserList", O_RDWR);
		if(fd >= 0)
		{
			int i = strlen(buf);
			if (buf[i-1] == '\n')
				i--;
			int j = 0;
			int k = 0;
			for(j = 0; j < strlen(argv[1]); j++)
			{
				buf[i] = argv[1][j];
				i++;
			}
			buf[i]=':';
			i++;
			for(k = 0; k < strlen(argv[2]); k++)
			{
				buf[i] = argv[2][k];
				i++;
			}
			buf[i]=':';
			buf[i+1]= '\0';
			//printf(1,"buf: %s\n", buf);
			write(fd,buf,strlen(buf)+1);
			close(fd);
		}
		printf(1,"User added\n");
	}
	
	exit();


}
