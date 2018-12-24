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
			char buf[2048];
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
			if(strlen(argv[3]) > 0)
			{
				int n = write(fd, argv[3], strlen(argv[3]) + 1);
				if(n >= 0)
				{
					printf(1,"File update succeed\n");
				}
			}
			close(fd);
		}
	}
	else if(strcmp(argv[2], "ins") == 0)
	{
		fd = open(argv[1], O_RDWR);		
		if (fd >= 0)
		{
			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				int originalBufLen = strlen(buf);
				int insertPosition = atoi(argv[3]);
				if (insertPosition < originalBufLen)
				{
					int i = 0;
					for (i = 0; i < strlen(argv[4]);i++)
					{
						buf[i+insertPosition] = argv[4][i];
					}
					if (insertPosition+strlen(argv[4]) > originalBufLen)
					{
						buf[i+insertPosition] = '\0';
					}		
				}
				else
				{
					printf(1,"Illegal insert position.\n");
				}
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
			n = write(fd, buf, strlen(buf) + 1);
			if (n >= 0)
			{
				printf(1,"File update succeed\n");
			}
			
		}
		close(fd);
		
	}
	else if(strcmp(argv[2], "app") == 0)
	{
		fd = open(argv[1], O_RDWR);		
		if (fd >= 0)
		{			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				
				int insertPosition = strlen(buf);
				int i = 0;
				for (i = 0; i < strlen(buf);i++)
				{
					buf[i+insertPosition] = argv[3][i];
				}
				buf[i+insertPosition] = '\0';
					
				
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
			n = write(fd, buf, strlen(buf) + 1);
			if (n >= 0)
			{
				printf(1,"File update succeed\n");
			}
			
		}
		close(fd);
		
	}
	else if(strcmp(argv[2], "del") == 0)
	{
		fd = open(argv[1], O_RDWR);		
		if (fd >= 0)
		{
			
			char buf[2048];
			int n = read(fd, buf, sizeof buf);
			if (n >= 0)
			{
				int originalBufLen = strlen(buf);
				int deletePosition = atoi(argv[3]);
				int deleteAmount = atoi(argv[4]);
				if (deletePosition < originalBufLen)
				{
					int i = 0;
					int j = 0;
					for (i = 0; i < deleteAmount;i++)
					{
						for (j = deletePosition; buf[j]; j++)
						{
							buf[j] = buf[j+1];
						}
					}
	
				}
				else
				{
					printf(1,"Illegal delete position.\n");
				}
			}
			close(fd);
			fd = open(argv[1], O_RDWR);	
			n = write(fd, buf, strlen(buf) + 1);
			if (n >= 0)
			{
				printf(1,"File update succeed\n");
			}
			
		}
		close(fd);
		
	}	
	
	else
	{
		printf(1,"There is no such method in 'ef'.\n");
	}
	
	exit();
}


