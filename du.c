#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{


	int fd = open("UserList", O_RDONLY);
	//char *targetUser = argv[1];
	//printf(1,"user: %s\n", targetUser);
	int i = 0;
	int j = 0;
	char c;
	char name[32];
	int nameFound = 0;
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
		if (strcmp(argv[1],"Admin")==0)
		{
			printf(1,"Cannot delete Admin\n");
		}
		else
		{
			do
			{
				c = buf[i];
				i++;
				if (c == ':')
				{
					char* p = argv[1];
					char* q	= name;
					while (j > 0 && *p && *p == *q)
					{
						p++;
						q++;
						j--;
					}
					if (j == 0)
					{
						// name found
						nameFound = 1;	
						i-=2;
						while (buf[i] != ':' && i > 0)  // return to the last ':'
							i--;
						i++;
						while (buf[i] != ':')	
						{
							int k = i;
							while (buf[k] != '\0')
							{
								buf[k] = buf[k+1];
								k++;
							}	
		
						}
						int k = i;
						// delete ':'
						while (buf[k] != '\0')
						{
							buf[k] = buf[k+1];
							k++;
						}
						while (buf[i] != ':')	
						{
							int k = i;
							while (buf[k] != '\0')
							{
								buf[k] = buf[k+1];
								k++;
							}	
		
						}
						i--;
						// delete ':'
						k = i;
						while (buf[k] != '\0')
						{
							buf[k] = buf[k+1];
							k++;
						}
						// printf(1,"buf: %s\n",buf);
						break;
					}
				
					j = 0;
				}
			else
			{
				name[j] = c;
				j++;
			}

		}while (c != '\0');
		if (nameFound == 1)
			printf(1,"User deleted\n");
		else
			printf(1,"User name not found\n");
		}
		
	}
	fd = open("UserList", O_RDWR);
	if(fd >= 0)
	{
		write(fd,buf,strlen(buf)+1);
		close(fd);		
	}
		
	
	exit();


}
