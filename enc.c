#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"


int main(int argc, char *argv[])
{

	int keyLen = strlen(argv[2]);
	int fd;
	fd = open(argv[1],O_RDWR);
	if (fd >= 0)
	{
		char buf[1024];
		char resultBuf[1024];
		int n = read(fd,buf,sizeof buf);
		if (n>=0)
		{
			int i = 0;
			for(i = 0; i < strlen(buf); i++)
			{
				if (i < keyLen)
				{
					resultBuf[i] = (buf[i] + argv[2][i]) % 256;
				}
				else
				{
					resultBuf[i] = (buf[i] + buf[i-keyLen]) % 256;
				}
				 
			}
			resultBuf[i] = '\0';

			close(fd);
			fd = open(argv[1], O_RDWR);	
			n = write(fd, resultBuf, strlen(resultBuf) + 1);
			if (n >= 0)
			{
				printf(1,"File update succeed\n");
			}
		}
		close(fd);
	}
	else
	{
		printf(1,"File open failed.\n");		
	}

	exit();
}
