#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
// example app call custom system call
int main(int argc, char *argv[])
{


	int co = changeOwner(argv[1], argv[2]);
	if(co == 0)
	{
		int fd = open("FileAppendix", O_RDONLY);
		if(fd >= 0)
		{
			char buf[1024];
			int n = read(fd, buf, sizeof buf);
			close(fd);
			if(n >= 0)
			{
				// change owner name
				char c;
				char fileNameBuf[96];
				int i = 0; // buffer iterator
				int j = 0; // file name buffer iterator
				int fileOwnerFound = 0;
				do
				{
					c = buf[i];
					i++;
					if (c == ':')
					{
						// got a complete file name
						// compare with argv[1]
						char* k = argv[1];
						char* l = fileNameBuf;
						while (j > 0 && *k && *k == *l)
						{
							k++;
							l++;
							j--;
						}
						if (j == 0) 
						{
							// found file
							// kill original owner name
							while (buf[i] != ':')
							{
								int m = i;
								
								while(buf[m] != '\0')
								{
									buf[m] = buf[m+1];
									m++;
								}
							}
							// insert new owner name
							char* o = argv[2];
							int nameLen = 0;							
							while (*o)
							{
								o++;
								nameLen++;
							}
							int p = 0;
							for (p = 0; p < nameLen; p++)
							{
								int q = i;
								while (buf[q]!='\0')
									q++;
								q++;
								while(q > i)
								{
									buf[q] = buf[q-1];
									q--;
								}								
								buf[i] = argv[2][p];  // insert the new name char								
								i++;
							}
							//printf(1,"buf: %s\n",buf);
							fileOwnerFound = 1;
							break;
						}
						else
						{
							// not this file
							// skip two semi-colon
							do
							{		
							c = buf[i];
							i++;
							} while (c != ':');
							do
							{
								c = buf[i];
								i++;
							} while (c != ':');
								
							
						}

						j = 0;
					}
					else
					{
						fileNameBuf[j] = c;
						j++;
					}

				} while (c!='\0');

				
				if(fileOwnerFound == 0)
				{
					if (buf[i-1] == '\n')
						i--;
					char groupName[8] = "group1";
					int fileNameLen = strlen(argv[1]);
					int ownerNameLen = strlen(argv[2]);
					int groupNameLen = strlen(groupName);
					i--;
					int s = 0;
					for (s = 0; s < fileNameLen; s++)
					{
						buf[i] = argv[1][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < ownerNameLen; s++)
					{
						buf[i] = argv[2][s];
						i++;
					}
					buf[i] = ':';
					i++;
					for (s = 0; s < groupNameLen; s++)
					{
						buf[i] = groupName[s];
						i++;
					}
					buf[i] = ':';
					i++;
					buf[i] = '\0';
				}
				//printf(1,"buf: %s\n",buf);
				fd = open("FileAppendix", O_RDWR);
				if(fd >= 0)
				{
					int m = write(fd, buf, sizeof buf);
					//printf(1, "co: writing: %d %d\n", m, sizeof buf);
					if(m == sizeof buf)
					{
						close(fd);
						printf(1, "co: File owner changed succeed\n");
					}
				}
			}
		close(fd);
		}
		
	}
	exit();
}
