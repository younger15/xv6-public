//
// File descriptors
//

#include "types.h"
#include "defs.h"
#include "param.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"


struct devsw devsw[NDEV];
struct {
  struct spinlock lock;
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
  initlock(&ftable.lock, "ftable");
}

// Allocate a file structure.
struct file*
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
/*struct file*
filealloc(struct userProp *owner)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
      strncpy(f->uProp.name, owner->name, strlen(owner->name));
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}*/
/*struct file*
filealloc(char *owner)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
	cprintf("file name: %s\n", f->name);
    if(f->ref == 0){
      f->ref = 1;
      //strncpy(f->uProp.name, owner, strlen(owner));
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}*/

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
  release(&ftable.lock);
  return f;
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
  struct file ff;
  //cprintf("closed: %s\nowner: %s\n",f->name,f->uProp.name);
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_NONE;
  safestrcpy(ff.uProp.name, f->uProp.name, strlen(f->uProp.name) + 1);
  //cprintf("ff owner: %s\n", ff.uProp.name);
  safestrcpy(ff.ip->uProp.name, ff.uProp.name, strlen(ff.uProp.name) + 1);
  //cprintf("ff ip owner: %s\n", ff.ip->uProp.name);
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    //cprintf("closing\n");
    iput(ff.ip);
    end_op();
  }
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
}

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
  	int r;

  	if(f->readable == 0)
    		return -1;
  	if(f->type == FD_PIPE)
    		return piperead(f->pipe, addr, n);
  	if(f->type == FD_INODE){
    		ilock(f->ip);
    	if((r = readi(f->ip, addr, f->off, n)) > 0)
      		f->off += r;
    		iunlock(f->ip);
    		return r;
  	}
  	panic("fileread");
}
/*int
fileread(struct file *f, char *addr, int n, struct userProp *userInfo)
{
  if(userInfo == 0 || userInfo->name == f->uProp.name){
  	int r;

  	if(f->readable == 0)
    		return -1;
  	if(f->type == FD_PIPE)
    		return piperead(f->pipe, addr, n);
  	if(f->type == FD_INODE){
    		ilock(f->ip);
    	if((r = readi(f->ip, addr, f->off, n)) > 0)
      		f->off += r;
    		iunlock(f->ip);
    		return r;
  	}
  	panic("fileread");
  }
  else if(userInfo->group != 0){
	
	struct userGroup *g = userInfo->group;
	struct userGroup *fg = f->uProp.group;
	while(g != 0){
		while(fg != 0){
			if(g->groupName == fg->groupName){
				g = 0;
				int r;

		  		if(f->readable == 0)
		    			return -1;
		  		if(f->type == FD_PIPE)
		    			return piperead(f->pipe, addr, n);
		  		if(f->type == FD_INODE){
		    			ilock(f->ip);
		    			if((r = readi(f->ip, addr, f->off, n)) > 0)
		      				f->off += r;
		    			iunlock(f->ip);
		    			return r;
	  			}
  				panic("fileread");
			}
			fg = fg->nextOne;
		}
		g = g->nextOne;
	}
	return -1;
	panic("fileread denied");
  }
  else{
  	return -1;
	panic("fileread denied");
  }
  panic("fileread");
}*/

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
    // write a few blocks at a time to avoid exceeding
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
	//cprintf("writing\n");
    while(i < n){
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
      ilock(f->ip);
	//cprintf("%s",addr + i);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
	//cprintf("\n");
    return i == n ? n : -1;
  }
  panic("filewrite");
}
/*int
filewrite(struct file *f, char *addr, int n, struct userProp *userInfo)
{
  if(userInfo == 0 || userInfo->name == f->uProp.name){
  	int r;

  	if(f->writable == 0)
    		return -1;
  	if(f->type == FD_PIPE)
    		return pipewrite(f->pipe, addr, n);
  	if(f->type == FD_INODE){
    	// write a few blocks at a time to avoid exceeding
    	// the maximum log transaction size, including
    	// i-node, indirect block, allocation blocks,
    	// and 2 blocks of slop for non-aligned writes.
    	// this really belongs lower down, since writei()
    	// might be writing a device like the console.
    		int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    		int i = 0;
    		while(i < n){
      			int n1 = n - i;
      			if(n1 > max)
        			n1 = max;

      			begin_op();
      			ilock(f->ip);
      			if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        			f->off += r;
      			iunlock(f->ip);
      			end_op();

      			if(r < 0)
	       			break;
	      		if(r != n1)
        			panic("short filewrite");
      			i += r;
    		}
    	return i == n ? n : -1;
  	}
  	panic("filewrite");
  }
  else if(userInfo->group != 0){
  	struct userGroup *g = userInfo->group;
	struct userGroup *fg = f->uProp.group;
	while(g != 0){
		while(fg != 0){
			if(g->groupName == fg->groupName){
				g = 0;
				int r;

		  		if(f->readable == 0)
		    			return -1;
		  		if(f->type == FD_PIPE)
		    			return piperead(f->pipe, addr, n);
		  		if(f->type == FD_INODE){
		    			ilock(f->ip);
		    		if((r = readi(f->ip, addr, f->off, n)) > 0)
		      			f->off += r;
		    			iunlock(f->ip);
		    			return r;
	  			}
  				panic("filewrite");
			}
			fg = fg->nextOne;
		}
		g = g->nextOne;
	}
	return -1;
	panic("filewrite denied");
  }
  else
  {
	return -1;
	panic("filewrite denied");
  }
  panic("filewrite");
}*/

