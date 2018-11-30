#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
	//int n;
	//char buf[1024];
	
	/*if(fd >= 0)
	{
		n = read(fd, buf,sizeof buf);
		printf(1, "n=%d\n",n);		

		if(n < 0)
		{
			printf(1, "read fail\n");
		}
		else
		{
			printf(1, "result: %s\n", buf);
		}
	}
	else
	{
		printf(1, "file not found\n");
	}*/ 
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
	//printf(1,"user: %s\n", targetUser);
	char nameList[128];
	//char *names = nameList;
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	//changeUser(argv[1]);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		int i = 0; // buffer iterator
		int n = 0; // name iterator
		char c;
		//int nameChanged = 0;
		do
		{
			c=buf[i];		
			i++;
			
			if(c==':')
			{
				// compare string
				//printf(1, "names: %s\n", names);
				char* j = targetUser;
				char* k = nameList;
				while(n > 0 && *j && *j == *k)
				{
					//printf(1,"n=%d\n",n);
					n--;
					j++;
					k++;
  				}
				
				if(n == 0)
    				{
					//printf(1, "name found\n");
					changeUser(argv[1]);
					//close(fd);
					//exit();
					//printf(1,"test\n");
					//nameChanged = 1;					
					break;
				}
				n = 0;
			}
			else
			{
				//printf(1,"n: %d\n",n);
				nameList[n]=c;
				n++;
			}
			/*if(nameChanged == 1)
			{
				printf(1,"break\n");
				break;
			}*/		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
		}
	}
	
	close(fd);	
	exit();
}
