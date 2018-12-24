#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{	
	
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		int i = 0; // buffer iterator
		int n = 0; // name iterator
		char c;
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
					// add password verification here
					char password[128];
					int p = 0; // password iterator
					do
					{
						c = buf[i];
						i++;

						if (c == ':')
						{
							// compare password string
							j = argv[2];
							k = password;
							while (p > 0 && *j && *j == *k)
							{
								p--;
								j++;
								k++;
							} 
							if (p == 0)
							{
								changeUser(argv[1]);
								printf(1,"User changed.\n");
								
							}
							else
							{
								printf(1,"Incorrect password. Please try again.\n");
								
							}
							break;
						}
						else
						{
							password[p] = c;
							p++;
						}

					} while (c != ':');
								
					break;
				}
				else
				{
					// skip the password part
					do
					{
						c = buf[i];
						i++;
					} while (c != ':');
				}
				n = 0;
			}
			else
			{
				//printf(1,"n: %d\n",n);
				nameList[n]=c;
				n++;
			}
			
		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
		}
	}
	
	close(fd);

	// old version of cu below
	/*	
	int fd = open("UserList", O_RDONLY);
	char *targetUser = argv[1];
	char nameList[128];
	char buf[1024];
	int checkReadFile = read(fd, buf,sizeof buf);
	if(checkReadFile < 0)
	{
		printf(1,"Can't find user list\n");
	}
	else
	{
		int i = 0; // buffer iterator
		int n = 0; // name iterator
		char c;
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
			
		
		}while(c != '\0');
		if(c == '\0')
		{
			printf(1,"User not found\n");
		}
	}
	
	close(fd);
	*/

		
	exit();
}
