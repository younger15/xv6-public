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
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		//output
		char c;
		int i = 0;
		do
		{
			c = buf[i];
			i++;
			if (c==':')
				printf(1,"\n");
			else
				printf(1,"%c",c);	
		} while (c != '\0');	

	}
close(fd);
exit();


}
