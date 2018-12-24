
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 90 2f 10 80       	mov    $0x80102f90,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 75 10 80       	push   $0x801075e0
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 75 44 00 00       	call   801044d0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 75 10 80       	push   $0x801075e7
80100097:	50                   	push   %eax
80100098:	e8 03 43 00 00       	call   801043a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 47 45 00 00       	call   80104630 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 79 45 00 00       	call   801046e0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 42 00 00       	call   801043e0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 9d 20 00 00       	call   80102220 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 ee 75 10 80       	push   $0x801075ee
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 cd 42 00 00       	call   80104480 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 57 20 00 00       	jmp    80102220 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 ff 75 10 80       	push   $0x801075ff
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 8c 42 00 00       	call   80104480 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 42 00 00       	call   80104440 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 20 44 00 00       	call   80104630 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 7f 44 00 00       	jmp    801046e0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 76 10 80       	push   $0x80107606
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 8b 15 00 00       	call   80101810 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 9f 43 00 00       	call   80104630 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002a6:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 b5 10 80       	push   $0x8010b520
801002b8:	68 a0 0f 11 80       	push   $0x80110fa0
801002bd:	e8 ee 3b 00 00       	call   80103eb0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 e9 35 00 00       	call   801038c0 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 20 b5 10 80       	push   $0x8010b520
801002e6:	e8 f5 43 00 00       	call   801046e0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 0d 14 00 00       	call   80101700 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 20 0f 11 80 	movsbl -0x7feef0e0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 b5 10 80       	push   $0x8010b520
80100346:	e8 95 43 00 00       	call   801046e0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 ad 13 00 00       	call   80101700 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100379:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
80100380:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100383:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100386:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100389:	e8 92 24 00 00       	call   80102820 <lapicid>
8010038e:	83 ec 08             	sub    $0x8,%esp
80100391:	50                   	push   %eax
80100392:	68 0d 76 10 80       	push   $0x8010760d
80100397:	e8 c4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039c:	58                   	pop    %eax
8010039d:	ff 75 08             	pushl  0x8(%ebp)
801003a0:	e8 bb 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a5:	c7 04 24 4c 7c 10 80 	movl   $0x80107c4c,(%esp)
801003ac:	e8 af 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b1:	5a                   	pop    %edx
801003b2:	8d 45 08             	lea    0x8(%ebp),%eax
801003b5:	59                   	pop    %ecx
801003b6:	53                   	push   %ebx
801003b7:	50                   	push   %eax
801003b8:	e8 33 41 00 00       	call   801044f0 <getcallerpcs>
801003bd:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	ff 33                	pushl  (%ebx)
801003c5:	83 c3 04             	add    $0x4,%ebx
801003c8:	68 21 76 10 80       	push   $0x80107621
801003cd:	e8 8e 02 00 00       	call   80100660 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003d2:	83 c4 10             	add    $0x10,%esp
801003d5:	39 f3                	cmp    %esi,%ebx
801003d7:	75 e7                	jne    801003c0 <panic+0x50>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003d9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
801003e0:	00 00 00 
801003e3:	eb fe                	jmp    801003e3 <panic+0x73>
801003e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801003e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 61 5d 00 00       	call   80106180 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 a8 5c 00 00       	call   80106180 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 9c 5c 00 00       	call   80106180 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 90 5c 00 00       	call   80106180 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 c7 42 00 00       	call   801047e0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 02 42 00 00       	call   80104730 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 25 76 10 80       	push   $0x80107625
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 50 76 10 80 	movzbl -0x7fef89b0(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 fc 11 00 00       	call   80101810 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 10 40 00 00       	call   80104630 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 94 40 00 00       	call   801046e0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 ab 10 00 00       	call   80101700 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 b5 10 80       	push   $0x8010b520
8010070d:	e8 ce 3f 00 00       	call   801046e0 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 38 76 10 80       	mov    $0x80107638,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 b5 10 80       	push   $0x8010b520
801007c8:	e8 63 3e 00 00       	call   80104630 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 3f 76 10 80       	push   $0x8010763f
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 b5 10 80       	push   $0x8010b520
80100803:	e8 28 3e 00 00       	call   80104630 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100836:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 b5 10 80       	push   $0x8010b520
80100868:	e8 73 3e 00 00       	call   801046e0 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
801008f1:	68 a0 0f 11 80       	push   $0x80110fa0
801008f6:	e8 75 37 00 00       	call   80104070 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010090d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100934:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 e4 37 00 00       	jmp    80104160 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 48 76 10 80       	push   $0x80107648
801009ab:	68 20 b5 10 80       	push   $0x8010b520
801009b0:	e8 1b 3b 00 00       	call   801044d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009b5:	58                   	pop    %eax
801009b6:	5a                   	pop    %edx
801009b7:	6a 00                	push   $0x0
801009b9:	6a 01                	push   $0x1
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bb:	c7 05 ec 70 11 80 00 	movl   $0x80100600,0x801170ec
801009c2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c5:	c7 05 e8 70 11 80 70 	movl   $0x80100270,0x801170e8
801009cc:	02 10 80 
  cons.locking = 1;
801009cf:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009d6:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009d9:	e8 f2 19 00 00       	call   801023d0 <ioapicenable>
}
801009de:	83 c4 10             	add    $0x10,%esp
801009e1:	c9                   	leave  
801009e2:	c3                   	ret    
801009e3:	66 90                	xchg   %ax,%ax
801009e5:	66 90                	xchg   %ax,%ax
801009e7:	66 90                	xchg   %ax,%ax
801009e9:	66 90                	xchg   %ax,%ax
801009eb:	66 90                	xchg   %ax,%ax
801009ed:	66 90                	xchg   %ax,%ax
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009fc:	e8 bf 2e 00 00       	call   801038c0 <myproc>
80100a01:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a07:	e8 74 22 00 00       	call   80102c80 <begin_op>

  if((ip = namei(path)) == 0){
80100a0c:	83 ec 0c             	sub    $0xc,%esp
80100a0f:	ff 75 08             	pushl  0x8(%ebp)
80100a12:	e8 d9 15 00 00       	call   80101ff0 <namei>
80100a17:	83 c4 10             	add    $0x10,%esp
80100a1a:	85 c0                	test   %eax,%eax
80100a1c:	0f 84 9c 01 00 00    	je     80100bbe <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a22:	83 ec 0c             	sub    $0xc,%esp
80100a25:	89 c3                	mov    %eax,%ebx
80100a27:	50                   	push   %eax
80100a28:	e8 d3 0c 00 00       	call   80101700 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a2d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a33:	6a 34                	push   $0x34
80100a35:	6a 00                	push   $0x0
80100a37:	50                   	push   %eax
80100a38:	53                   	push   %ebx
80100a39:	e8 32 10 00 00       	call   80101a70 <readi>
80100a3e:	83 c4 20             	add    $0x20,%esp
80100a41:	83 f8 34             	cmp    $0x34,%eax
80100a44:	74 22                	je     80100a68 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	53                   	push   %ebx
80100a4a:	e8 81 0f 00 00       	call   801019d0 <iunlockput>
    end_op();
80100a4f:	e8 9c 22 00 00       	call   80102cf0 <end_op>
80100a54:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a5f:	5b                   	pop    %ebx
80100a60:	5e                   	pop    %esi
80100a61:	5f                   	pop    %edi
80100a62:	5d                   	pop    %ebp
80100a63:	c3                   	ret    
80100a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a68:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a6f:	45 4c 46 
80100a72:	75 d2                	jne    80100a46 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a74:	e8 97 68 00 00       	call   80107310 <setupkvm>
80100a79:	85 c0                	test   %eax,%eax
80100a7b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a81:	74 c3                	je     80100a46 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a83:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a8a:	00 
80100a8b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a91:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a98:	00 00 00 
80100a9b:	0f 84 c5 00 00 00    	je     80100b66 <exec+0x176>
80100aa1:	31 ff                	xor    %edi,%edi
80100aa3:	eb 18                	jmp    80100abd <exec+0xcd>
80100aa5:	8d 76 00             	lea    0x0(%esi),%esi
80100aa8:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aaf:	83 c7 01             	add    $0x1,%edi
80100ab2:	83 c6 20             	add    $0x20,%esi
80100ab5:	39 f8                	cmp    %edi,%eax
80100ab7:	0f 8e a9 00 00 00    	jle    80100b66 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100abd:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100ac3:	6a 20                	push   $0x20
80100ac5:	56                   	push   %esi
80100ac6:	50                   	push   %eax
80100ac7:	53                   	push   %ebx
80100ac8:	e8 a3 0f 00 00       	call   80101a70 <readi>
80100acd:	83 c4 10             	add    $0x10,%esp
80100ad0:	83 f8 20             	cmp    $0x20,%eax
80100ad3:	75 7b                	jne    80100b50 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ad5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100adc:	75 ca                	jne    80100aa8 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
80100ade:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ae4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100aea:	72 64                	jb     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100aec:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100af2:	72 5c                	jb     80100b50 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100af4:	83 ec 04             	sub    $0x4,%esp
80100af7:	50                   	push   %eax
80100af8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
80100afe:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b04:	e8 57 66 00 00       	call   80107160 <allocuvm>
80100b09:	83 c4 10             	add    $0x10,%esp
80100b0c:	85 c0                	test   %eax,%eax
80100b0e:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100b14:	74 3a                	je     80100b50 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b16:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b1c:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b21:	75 2d                	jne    80100b50 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b23:	83 ec 0c             	sub    $0xc,%esp
80100b26:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b2c:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b32:	53                   	push   %ebx
80100b33:	50                   	push   %eax
80100b34:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b3a:	e8 61 65 00 00       	call   801070a0 <loaduvm>
80100b3f:	83 c4 20             	add    $0x20,%esp
80100b42:	85 c0                	test   %eax,%eax
80100b44:	0f 89 5e ff ff ff    	jns    80100aa8 <exec+0xb8>
80100b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b50:	83 ec 0c             	sub    $0xc,%esp
80100b53:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b59:	e8 32 67 00 00       	call   80107290 <freevm>
80100b5e:	83 c4 10             	add    $0x10,%esp
80100b61:	e9 e0 fe ff ff       	jmp    80100a46 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b66:	83 ec 0c             	sub    $0xc,%esp
80100b69:	53                   	push   %ebx
80100b6a:	e8 61 0e 00 00       	call   801019d0 <iunlockput>
  end_op();
80100b6f:	e8 7c 21 00 00       	call   80102cf0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b74:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b7d:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b82:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b87:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b8d:	52                   	push   %edx
80100b8e:	50                   	push   %eax
80100b8f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b95:	e8 c6 65 00 00       	call   80107160 <allocuvm>
80100b9a:	83 c4 10             	add    $0x10,%esp
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	89 c6                	mov    %eax,%esi
80100ba1:	75 3a                	jne    80100bdd <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ba3:	83 ec 0c             	sub    $0xc,%esp
80100ba6:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bac:	e8 df 66 00 00       	call   80107290 <freevm>
80100bb1:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb9:	e9 9e fe ff ff       	jmp    80100a5c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bbe:	e8 2d 21 00 00       	call   80102cf0 <end_op>
    cprintf("exec: fail\n");
80100bc3:	83 ec 0c             	sub    $0xc,%esp
80100bc6:	68 61 76 10 80       	push   $0x80107661
80100bcb:	e8 90 fa ff ff       	call   80100660 <cprintf>
    return -1;
80100bd0:	83 c4 10             	add    $0x10,%esp
80100bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bd8:	e9 7f fe ff ff       	jmp    80100a5c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bdd:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100be3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100be6:	31 ff                	xor    %edi,%edi
80100be8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bea:	50                   	push   %eax
80100beb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bf1:	e8 ba 67 00 00       	call   801073b0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bf6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf9:	83 c4 10             	add    $0x10,%esp
80100bfc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c02:	8b 00                	mov    (%eax),%eax
80100c04:	85 c0                	test   %eax,%eax
80100c06:	74 79                	je     80100c81 <exec+0x291>
80100c08:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c0e:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c14:	eb 13                	jmp    80100c29 <exec+0x239>
80100c16:	8d 76 00             	lea    0x0(%esi),%esi
80100c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100c20:	83 ff 20             	cmp    $0x20,%edi
80100c23:	0f 84 7a ff ff ff    	je     80100ba3 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c29:	83 ec 0c             	sub    $0xc,%esp
80100c2c:	50                   	push   %eax
80100c2d:	e8 3e 3d 00 00       	call   80104970 <strlen>
80100c32:	f7 d0                	not    %eax
80100c34:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c39:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c3a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c3d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c40:	e8 2b 3d 00 00       	call   80104970 <strlen>
80100c45:	83 c0 01             	add    $0x1,%eax
80100c48:	50                   	push   %eax
80100c49:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c4c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4f:	53                   	push   %ebx
80100c50:	56                   	push   %esi
80100c51:	e8 ca 68 00 00       	call   80107520 <copyout>
80100c56:	83 c4 20             	add    $0x20,%esp
80100c59:	85 c0                	test   %eax,%eax
80100c5b:	0f 88 42 ff ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c61:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c64:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c6e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c74:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c77:	85 c0                	test   %eax,%eax
80100c79:	75 a5                	jne    80100c20 <exec+0x230>
80100c7b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c88:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c8a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c91:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c95:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c9c:	ff ff ff 
  ustack[1] = argc;
80100c9f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ca5:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100ca7:	83 c0 0c             	add    $0xc,%eax
80100caa:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cac:	50                   	push   %eax
80100cad:	52                   	push   %edx
80100cae:	53                   	push   %ebx
80100caf:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	e8 60 68 00 00       	call   80107520 <copyout>
80100cc0:	83 c4 10             	add    $0x10,%esp
80100cc3:	85 c0                	test   %eax,%eax
80100cc5:	0f 88 d8 fe ff ff    	js     80100ba3 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80100cce:	0f b6 10             	movzbl (%eax),%edx
80100cd1:	84 d2                	test   %dl,%dl
80100cd3:	74 19                	je     80100cee <exec+0x2fe>
80100cd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cd8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cdb:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cde:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100ce1:	0f 44 c8             	cmove  %eax,%ecx
80100ce4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ce7:	84 d2                	test   %dl,%dl
80100ce9:	75 f0                	jne    80100cdb <exec+0x2eb>
80100ceb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cee:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cf4:	50                   	push   %eax
80100cf5:	6a 10                	push   $0x10
80100cf7:	ff 75 08             	pushl  0x8(%ebp)
80100cfa:	89 f8                	mov    %edi,%eax
80100cfc:	83 c0 6c             	add    $0x6c,%eax
80100cff:	50                   	push   %eax
80100d00:	e8 2b 3c 00 00       	call   80104930 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d05:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100d0b:	89 f8                	mov    %edi,%eax
80100d0d:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80100d10:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80100d12:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d15:	89 c1                	mov    %eax,%ecx
80100d17:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d1d:	8b 40 18             	mov    0x18(%eax),%eax
80100d20:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d23:	8b 41 18             	mov    0x18(%ecx),%eax
80100d26:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d29:	89 0c 24             	mov    %ecx,(%esp)
80100d2c:	e8 df 61 00 00       	call   80106f10 <switchuvm>
  freevm(oldpgdir);
80100d31:	89 3c 24             	mov    %edi,(%esp)
80100d34:	e8 57 65 00 00       	call   80107290 <freevm>
  return 0;
80100d39:	83 c4 10             	add    $0x10,%esp
80100d3c:	31 c0                	xor    %eax,%eax
80100d3e:	e9 19 fd ff ff       	jmp    80100a5c <exec+0x6c>
80100d43:	66 90                	xchg   %ax,%ax
80100d45:	66 90                	xchg   %ax,%ax
80100d47:	66 90                	xchg   %ax,%ax
80100d49:	66 90                	xchg   %ax,%ax
80100d4b:	66 90                	xchg   %ax,%ax
80100d4d:	66 90                	xchg   %ax,%ax
80100d4f:	90                   	nop

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	68 6d 76 10 80       	push   $0x8010766d
80100d5b:	68 c0 0f 11 80       	push   $0x80110fc0
80100d60:	e8 6b 37 00 00       	call   801044d0 <initlock>
}
80100d65:	83 c4 10             	add    $0x10,%esp
80100d68:	c9                   	leave  
80100d69:	c3                   	ret    
80100d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d70 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d74:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d79:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d7c:	68 c0 0f 11 80       	push   $0x80110fc0
80100d81:	e8 aa 38 00 00       	call   80104630 <acquire>
80100d86:	83 c4 10             	add    $0x10,%esp
80100d89:	eb 13                	jmp    80100d9e <filealloc+0x2e>
80100d8b:	90                   	nop
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	81 c3 f8 00 00 00    	add    $0xf8,%ebx
80100d96:	81 fb d4 70 11 80    	cmp    $0x801170d4,%ebx
80100d9c:	74 2a                	je     80100dc8 <filealloc+0x58>
    if(f->ref == 0){
80100d9e:	8b 43 04             	mov    0x4(%ebx),%eax
80100da1:	85 c0                	test   %eax,%eax
80100da3:	75 eb                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da5:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100da8:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100daf:	68 c0 0f 11 80       	push   $0x80110fc0
80100db4:	e8 27 39 00 00       	call   801046e0 <release>
      return f;
80100db9:	89 d8                	mov    %ebx,%eax
80100dbb:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dbe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dc1:	c9                   	leave  
80100dc2:	c3                   	ret    
80100dc3:	90                   	nop
80100dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc8:	83 ec 0c             	sub    $0xc,%esp
80100dcb:	68 c0 0f 11 80       	push   $0x80110fc0
80100dd0:	e8 0b 39 00 00       	call   801046e0 <release>
  return 0;
80100dd5:	83 c4 10             	add    $0x10,%esp
80100dd8:	31 c0                	xor    %eax,%eax
}
80100dda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ddd:	c9                   	leave  
80100dde:	c3                   	ret    
80100ddf:	90                   	nop

80100de0 <filedup>:
}*/

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 10             	sub    $0x10,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	68 c0 0f 11 80       	push   $0x80110fc0
80100def:	e8 3c 38 00 00       	call   80104630 <acquire>
  if(f->ref < 1)
80100df4:	8b 43 04             	mov    0x4(%ebx),%eax
80100df7:	83 c4 10             	add    $0x10,%esp
80100dfa:	85 c0                	test   %eax,%eax
80100dfc:	7e 1a                	jle    80100e18 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dfe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e01:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e04:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e07:	68 c0 0f 11 80       	push   $0x80110fc0
80100e0c:	e8 cf 38 00 00       	call   801046e0 <release>
  return f;
}
80100e11:	89 d8                	mov    %ebx,%eax
80100e13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e16:	c9                   	leave  
80100e17:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	68 74 76 10 80       	push   $0x80107674
80100e20:	e8 4b f5 ff ff       	call   80100370 <panic>
80100e25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	81 ec 18 01 00 00    	sub    $0x118,%esp
80100e3c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;
  //cprintf("closed: %s\nowner: %s\n",f->name,f->uProp.name);
  acquire(&ftable.lock);
80100e3f:	68 c0 0f 11 80       	push   $0x80110fc0
80100e44:	e8 e7 37 00 00       	call   80104630 <acquire>
  if(f->ref < 1)
80100e49:	8b 43 04             	mov    0x4(%ebx),%eax
80100e4c:	83 c4 10             	add    $0x10,%esp
80100e4f:	85 c0                	test   %eax,%eax
80100e51:	0f 8e e7 00 00 00    	jle    80100f3e <fileclose+0x10e>
    panic("fileclose");
  if(--f->ref > 0){
80100e57:	83 e8 01             	sub    $0x1,%eax
80100e5a:	85 c0                	test   %eax,%eax
80100e5c:	89 43 04             	mov    %eax,0x4(%ebx)
80100e5f:	74 1f                	je     80100e80 <fileclose+0x50>
    release(&ftable.lock);
80100e61:	83 ec 0c             	sub    $0xc,%esp
80100e64:	68 c0 0f 11 80       	push   $0x80110fc0
80100e69:	e8 72 38 00 00       	call   801046e0 <release>
    return;
80100e6e:	83 c4 10             	add    $0x10,%esp
    begin_op();
    //cprintf("closing\n");
    iput(ff.ip);
    end_op();
  }
}
80100e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e74:	5b                   	pop    %ebx
80100e75:	5e                   	pop    %esi
80100e76:	5f                   	pop    %edi
80100e77:	5d                   	pop    %ebp
80100e78:	c3                   	ret    
80100e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
  f->ref = 0;
  f->type = FD_NONE;
  safestrcpy(ff.uProp.name, f->uProp.name, strlen(f->uProp.name) + 1);
80100e80:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e83:	89 de                	mov    %ebx,%esi
80100e85:	8d bd f0 fe ff ff    	lea    -0x110(%ebp),%edi
  f->ref = 0;
  f->type = FD_NONE;
  safestrcpy(ff.uProp.name, f->uProp.name, strlen(f->uProp.name) + 1);
80100e8b:	83 c3 14             	add    $0x14,%ebx
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8e:	b9 3e 00 00 00       	mov    $0x3e,%ecx
80100e93:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  f->ref = 0;
80100e95:	c7 43 f0 00 00 00 00 	movl   $0x0,-0x10(%ebx)
  f->type = FD_NONE;
80100e9c:	c7 43 ec 00 00 00 00 	movl   $0x0,-0x14(%ebx)
  safestrcpy(ff.uProp.name, f->uProp.name, strlen(f->uProp.name) + 1);
80100ea3:	53                   	push   %ebx
80100ea4:	e8 c7 3a 00 00       	call   80104970 <strlen>
80100ea9:	83 c4 0c             	add    $0xc,%esp
80100eac:	83 c0 01             	add    $0x1,%eax
80100eaf:	50                   	push   %eax
80100eb0:	53                   	push   %ebx
80100eb1:	8d 9d 04 ff ff ff    	lea    -0xfc(%ebp),%ebx
80100eb7:	53                   	push   %ebx
80100eb8:	e8 73 3a 00 00       	call   80104930 <safestrcpy>
  //cprintf("ff owner: %s\n", ff.uProp.name);
  safestrcpy(ff.ip->uProp.name, ff.uProp.name, strlen(ff.uProp.name) + 1);
80100ebd:	89 1c 24             	mov    %ebx,(%esp)
80100ec0:	e8 ab 3a 00 00       	call   80104970 <strlen>
80100ec5:	83 c4 0c             	add    $0xc,%esp
80100ec8:	83 c0 01             	add    $0x1,%eax
80100ecb:	50                   	push   %eax
80100ecc:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100ed2:	53                   	push   %ebx
80100ed3:	83 c0 54             	add    $0x54,%eax
80100ed6:	50                   	push   %eax
80100ed7:	e8 54 3a 00 00       	call   80104930 <safestrcpy>
  //cprintf("ff ip owner: %s\n", ff.ip->uProp.name);
  release(&ftable.lock);
80100edc:	c7 04 24 c0 0f 11 80 	movl   $0x80110fc0,(%esp)
80100ee3:	e8 f8 37 00 00       	call   801046e0 <release>
  
  if(ff.type == FD_PIPE)
80100ee8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100eee:	83 c4 10             	add    $0x10,%esp
80100ef1:	83 f8 01             	cmp    $0x1,%eax
80100ef4:	74 2a                	je     80100f20 <fileclose+0xf0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ef6:	83 f8 02             	cmp    $0x2,%eax
80100ef9:	0f 85 72 ff ff ff    	jne    80100e71 <fileclose+0x41>
    begin_op();
80100eff:	e8 7c 1d 00 00       	call   80102c80 <begin_op>
    //cprintf("closing\n");
    iput(ff.ip);
80100f04:	83 ec 0c             	sub    $0xc,%esp
80100f07:	ff b5 00 ff ff ff    	pushl  -0x100(%ebp)
80100f0d:	e8 4e 09 00 00       	call   80101860 <iput>
    end_op();
80100f12:	e8 d9 1d 00 00       	call   80102cf0 <end_op>
80100f17:	83 c4 10             	add    $0x10,%esp
80100f1a:	e9 52 ff ff ff       	jmp    80100e71 <fileclose+0x41>
80100f1f:	90                   	nop
  safestrcpy(ff.ip->uProp.name, ff.uProp.name, strlen(ff.uProp.name) + 1);
  //cprintf("ff ip owner: %s\n", ff.ip->uProp.name);
  release(&ftable.lock);
  
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100f20:	0f be 85 f9 fe ff ff 	movsbl -0x107(%ebp),%eax
80100f27:	83 ec 08             	sub    $0x8,%esp
80100f2a:	50                   	push   %eax
80100f2b:	ff b5 fc fe ff ff    	pushl  -0x104(%ebp)
80100f31:	e8 ea 24 00 00       	call   80103420 <pipeclose>
80100f36:	83 c4 10             	add    $0x10,%esp
80100f39:	e9 33 ff ff ff       	jmp    80100e71 <fileclose+0x41>
{
  struct file ff;
  //cprintf("closed: %s\nowner: %s\n",f->name,f->uProp.name);
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100f3e:	83 ec 0c             	sub    $0xc,%esp
80100f41:	68 7c 76 10 80       	push   $0x8010767c
80100f46:	e8 25 f4 ff ff       	call   80100370 <panic>
80100f4b:	90                   	nop
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 04             	sub    $0x4,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f5a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f5d:	75 31                	jne    80100f90 <filestat+0x40>
    ilock(f->ip);
80100f5f:	83 ec 0c             	sub    $0xc,%esp
80100f62:	ff 73 10             	pushl  0x10(%ebx)
80100f65:	e8 96 07 00 00       	call   80101700 <ilock>
    stati(f->ip, st);
80100f6a:	58                   	pop    %eax
80100f6b:	5a                   	pop    %edx
80100f6c:	ff 75 0c             	pushl  0xc(%ebp)
80100f6f:	ff 73 10             	pushl  0x10(%ebx)
80100f72:	e8 79 0a 00 00       	call   801019f0 <stati>
    iunlock(f->ip);
80100f77:	59                   	pop    %ecx
80100f78:	ff 73 10             	pushl  0x10(%ebx)
80100f7b:	e8 90 08 00 00       	call   80101810 <iunlock>
    return 0;
80100f80:	83 c4 10             	add    $0x10,%esp
80100f83:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f88:	c9                   	leave  
80100f89:	c3                   	ret    
80100f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fa0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fac:	8b 75 0c             	mov    0xc(%ebp),%esi
80100faf:	8b 7d 10             	mov    0x10(%ebp),%edi
  	int r;

  	if(f->readable == 0)
80100fb2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fb6:	74 70                	je     80101028 <fileread+0x88>
    		return -1;
  	if(f->type == FD_PIPE)
80100fb8:	8b 03                	mov    (%ebx),%eax
80100fba:	83 f8 01             	cmp    $0x1,%eax
80100fbd:	74 51                	je     80101010 <fileread+0x70>
    		return piperead(f->pipe, addr, n);
  	if(f->type == FD_INODE){
80100fbf:	83 f8 02             	cmp    $0x2,%eax
80100fc2:	75 6b                	jne    8010102f <fileread+0x8f>
    		ilock(f->ip);
80100fc4:	83 ec 0c             	sub    $0xc,%esp
80100fc7:	ff 73 10             	pushl  0x10(%ebx)
80100fca:	e8 31 07 00 00       	call   80101700 <ilock>
    	if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fcf:	57                   	push   %edi
80100fd0:	ff b3 d4 00 00 00    	pushl  0xd4(%ebx)
80100fd6:	56                   	push   %esi
80100fd7:	ff 73 10             	pushl  0x10(%ebx)
80100fda:	e8 91 0a 00 00       	call   80101a70 <readi>
80100fdf:	83 c4 20             	add    $0x20,%esp
80100fe2:	85 c0                	test   %eax,%eax
80100fe4:	89 c6                	mov    %eax,%esi
80100fe6:	7e 06                	jle    80100fee <fileread+0x4e>
      		f->off += r;
80100fe8:	01 83 d4 00 00 00    	add    %eax,0xd4(%ebx)
    		iunlock(f->ip);
80100fee:	83 ec 0c             	sub    $0xc,%esp
80100ff1:	ff 73 10             	pushl  0x10(%ebx)
80100ff4:	e8 17 08 00 00       	call   80101810 <iunlock>
    		return r;
80100ff9:	83 c4 10             	add    $0x10,%esp
    		return -1;
  	if(f->type == FD_PIPE)
    		return piperead(f->pipe, addr, n);
  	if(f->type == FD_INODE){
    		ilock(f->ip);
    	if((r = readi(f->ip, addr, f->off, n)) > 0)
80100ffc:	89 f0                	mov    %esi,%eax
      		f->off += r;
    		iunlock(f->ip);
    		return r;
  	}
  	panic("fileread");
}
80100ffe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101001:	5b                   	pop    %ebx
80101002:	5e                   	pop    %esi
80101003:	5f                   	pop    %edi
80101004:	5d                   	pop    %ebp
80101005:	c3                   	ret    
80101006:	8d 76 00             	lea    0x0(%esi),%esi
80101009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  	int r;

  	if(f->readable == 0)
    		return -1;
  	if(f->type == FD_PIPE)
    		return piperead(f->pipe, addr, n);
80101010:	8b 43 0c             	mov    0xc(%ebx),%eax
80101013:	89 45 08             	mov    %eax,0x8(%ebp)
      		f->off += r;
    		iunlock(f->ip);
    		return r;
  	}
  	panic("fileread");
}
80101016:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101019:	5b                   	pop    %ebx
8010101a:	5e                   	pop    %esi
8010101b:	5f                   	pop    %edi
8010101c:	5d                   	pop    %ebp
  	int r;

  	if(f->readable == 0)
    		return -1;
  	if(f->type == FD_PIPE)
    		return piperead(f->pipe, addr, n);
8010101d:	e9 9e 25 00 00       	jmp    801035c0 <piperead>
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  	int r;

  	if(f->readable == 0)
    		return -1;
80101028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010102d:	eb cf                	jmp    80100ffe <fileread+0x5e>
    	if((r = readi(f->ip, addr, f->off, n)) > 0)
      		f->off += r;
    		iunlock(f->ip);
    		return r;
  	}
  	panic("fileread");
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	68 86 76 10 80       	push   $0x80107686
80101037:	e8 34 f3 ff ff       	call   80100370 <panic>
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101040 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101040:	55                   	push   %ebp
80101041:	89 e5                	mov    %esp,%ebp
80101043:	57                   	push   %edi
80101044:	56                   	push   %esi
80101045:	53                   	push   %ebx
80101046:	83 ec 1c             	sub    $0x1c,%esp
80101049:	8b 75 08             	mov    0x8(%ebp),%esi
8010104c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010104f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101053:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101056:	8b 45 10             	mov    0x10(%ebp),%eax
80101059:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010105c:	0f 84 b0 00 00 00    	je     80101112 <filewrite+0xd2>
    return -1;
  if(f->type == FD_PIPE)
80101062:	8b 06                	mov    (%esi),%eax
80101064:	83 f8 01             	cmp    $0x1,%eax
80101067:	0f 84 c2 00 00 00    	je     8010112f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010106d:	83 f8 02             	cmp    $0x2,%eax
80101070:	0f 85 d8 00 00 00    	jne    8010114e <filewrite+0x10e>
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
	//cprintf("writing\n");
    while(i < n){
80101076:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101079:	31 ff                	xor    %edi,%edi
8010107b:	85 c0                	test   %eax,%eax
8010107d:	7f 37                	jg     801010b6 <filewrite+0x76>
8010107f:	e9 9c 00 00 00       	jmp    80101120 <filewrite+0xe0>
80101084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
	//cprintf("%s",addr + i);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101088:	01 86 d4 00 00 00    	add    %eax,0xd4(%esi)
      iunlock(f->ip);
8010108e:	83 ec 0c             	sub    $0xc,%esp
80101091:	ff 76 10             	pushl  0x10(%esi)

      begin_op();
      ilock(f->ip);
	//cprintf("%s",addr + i);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101094:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101097:	e8 74 07 00 00       	call   80101810 <iunlock>
      end_op();
8010109c:	e8 4f 1c 00 00       	call   80102cf0 <end_op>
801010a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a4:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801010a7:	39 d8                	cmp    %ebx,%eax
801010a9:	0f 85 92 00 00 00    	jne    80101141 <filewrite+0x101>
        panic("short filewrite");
      i += r;
801010af:	01 c7                	add    %eax,%edi
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
	//cprintf("writing\n");
    while(i < n){
801010b1:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010b4:	7e 6a                	jle    80101120 <filewrite+0xe0>
      int n1 = n - i;
801010b6:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010b9:	b8 00 06 00 00       	mov    $0x600,%eax
801010be:	29 fb                	sub    %edi,%ebx
801010c0:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010c6:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
801010c9:	e8 b2 1b 00 00       	call   80102c80 <begin_op>
      ilock(f->ip);
801010ce:	83 ec 0c             	sub    $0xc,%esp
801010d1:	ff 76 10             	pushl  0x10(%esi)
801010d4:	e8 27 06 00 00       	call   80101700 <ilock>
	//cprintf("%s",addr + i);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010d9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010dc:	53                   	push   %ebx
801010dd:	ff b6 d4 00 00 00    	pushl  0xd4(%esi)
801010e3:	01 f8                	add    %edi,%eax
801010e5:	50                   	push   %eax
801010e6:	ff 76 10             	pushl  0x10(%esi)
801010e9:	e8 82 0a 00 00       	call   80101b70 <writei>
801010ee:	83 c4 20             	add    $0x20,%esp
801010f1:	85 c0                	test   %eax,%eax
801010f3:	7f 93                	jg     80101088 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801010f5:	83 ec 0c             	sub    $0xc,%esp
801010f8:	ff 76 10             	pushl  0x10(%esi)
801010fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010fe:	e8 0d 07 00 00       	call   80101810 <iunlock>
      end_op();
80101103:	e8 e8 1b 00 00       	call   80102cf0 <end_op>

      if(r < 0)
80101108:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010110b:	83 c4 10             	add    $0x10,%esp
8010110e:	85 c0                	test   %eax,%eax
80101110:	74 95                	je     801010a7 <filewrite+0x67>
    }
	//cprintf("\n");
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101112:	8d 65 f4             	lea    -0xc(%ebp),%esp
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
	//cprintf("\n");
    return i == n ? n : -1;
80101115:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010111a:	5b                   	pop    %ebx
8010111b:	5e                   	pop    %esi
8010111c:	5f                   	pop    %edi
8010111d:	5d                   	pop    %ebp
8010111e:	c3                   	ret    
8010111f:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
	//cprintf("\n");
    return i == n ? n : -1;
80101120:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101123:	75 ed                	jne    80101112 <filewrite+0xd2>
  }
  panic("filewrite");
}
80101125:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101128:	89 f8                	mov    %edi,%eax
8010112a:	5b                   	pop    %ebx
8010112b:	5e                   	pop    %esi
8010112c:	5f                   	pop    %edi
8010112d:	5d                   	pop    %ebp
8010112e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010112f:	8b 46 0c             	mov    0xc(%esi),%eax
80101132:	89 45 08             	mov    %eax,0x8(%ebp)
    }
	//cprintf("\n");
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101135:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101138:	5b                   	pop    %ebx
80101139:	5e                   	pop    %esi
8010113a:	5f                   	pop    %edi
8010113b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010113c:	e9 7f 23 00 00       	jmp    801034c0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101141:	83 ec 0c             	sub    $0xc,%esp
80101144:	68 8f 76 10 80       	push   $0x8010768f
80101149:	e8 22 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
	//cprintf("\n");
    return i == n ? n : -1;
  }
  panic("filewrite");
8010114e:	83 ec 0c             	sub    $0xc,%esp
80101151:	68 95 76 10 80       	push   $0x80107695
80101156:	e8 15 f2 ff ff       	call   80100370 <panic>
8010115b:	66 90                	xchg   %ax,%ax
8010115d:	66 90                	xchg   %ax,%ax
8010115f:	90                   	nop

80101160 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101160:	55                   	push   %ebp
80101161:	89 e5                	mov    %esp,%ebp
80101163:	57                   	push   %edi
80101164:	56                   	push   %esi
80101165:	53                   	push   %ebx
80101166:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101169:	8b 0d 40 71 11 80    	mov    0x80117140,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010116f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101172:	85 c9                	test   %ecx,%ecx
80101174:	0f 84 85 00 00 00    	je     801011ff <balloc+0x9f>
8010117a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101181:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101184:	83 ec 08             	sub    $0x8,%esp
80101187:	89 f0                	mov    %esi,%eax
80101189:	c1 f8 0c             	sar    $0xc,%eax
8010118c:	03 05 58 71 11 80    	add    0x80117158,%eax
80101192:	50                   	push   %eax
80101193:	ff 75 d8             	pushl  -0x28(%ebp)
80101196:	e8 35 ef ff ff       	call   801000d0 <bread>
8010119b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010119e:	a1 40 71 11 80       	mov    0x80117140,%eax
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011a9:	31 c0                	xor    %eax,%eax
801011ab:	eb 2d                	jmp    801011da <balloc+0x7a>
801011ad:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011b0:	89 c1                	mov    %eax,%ecx
801011b2:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011b7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801011ba:	83 e1 07             	and    $0x7,%ecx
801011bd:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011bf:	89 c1                	mov    %eax,%ecx
801011c1:	c1 f9 03             	sar    $0x3,%ecx
801011c4:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
801011c9:	85 d7                	test   %edx,%edi
801011cb:	74 43                	je     80101210 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011cd:	83 c0 01             	add    $0x1,%eax
801011d0:	83 c6 01             	add    $0x1,%esi
801011d3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011d8:	74 05                	je     801011df <balloc+0x7f>
801011da:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011dd:	72 d1                	jb     801011b0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011df:	83 ec 0c             	sub    $0xc,%esp
801011e2:	ff 75 e4             	pushl  -0x1c(%ebp)
801011e5:	e8 f6 ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011ea:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011f1:	83 c4 10             	add    $0x10,%esp
801011f4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011f7:	39 05 40 71 11 80    	cmp    %eax,0x80117140
801011fd:	77 82                	ja     80101181 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	68 9f 76 10 80       	push   $0x8010769f
80101207:	e8 64 f1 ff ff       	call   80100370 <panic>
8010120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101210:	09 fa                	or     %edi,%edx
80101212:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101215:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101218:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010121c:	57                   	push   %edi
8010121d:	e8 3e 1c 00 00       	call   80102e60 <log_write>
        brelse(bp);
80101222:	89 3c 24             	mov    %edi,(%esp)
80101225:	e8 b6 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010122a:	58                   	pop    %eax
8010122b:	5a                   	pop    %edx
8010122c:	56                   	push   %esi
8010122d:	ff 75 d8             	pushl  -0x28(%ebp)
80101230:	e8 9b ee ff ff       	call   801000d0 <bread>
80101235:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101237:	8d 40 5c             	lea    0x5c(%eax),%eax
8010123a:	83 c4 0c             	add    $0xc,%esp
8010123d:	68 00 02 00 00       	push   $0x200
80101242:	6a 00                	push   $0x0
80101244:	50                   	push   %eax
80101245:	e8 e6 34 00 00       	call   80104730 <memset>
  log_write(bp);
8010124a:	89 1c 24             	mov    %ebx,(%esp)
8010124d:	e8 0e 1c 00 00       	call   80102e60 <log_write>
  brelse(bp);
80101252:	89 1c 24             	mov    %ebx,(%esp)
80101255:	e8 86 ef ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010125a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010125d:	89 f0                	mov    %esi,%eax
8010125f:	5b                   	pop    %ebx
80101260:	5e                   	pop    %esi
80101261:	5f                   	pop    %edi
80101262:	5d                   	pop    %ebp
80101263:	c3                   	ret    
80101264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010126a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101270 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	57                   	push   %edi
80101274:	56                   	push   %esi
80101275:	53                   	push   %ebx
80101276:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101278:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010127a:	bb 94 71 11 80       	mov    $0x80117194,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010127f:	83 ec 28             	sub    $0x28,%esp
80101282:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101285:	68 60 71 11 80       	push   $0x80117160
8010128a:	e8 a1 33 00 00       	call   80104630 <acquire>
8010128f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101292:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101295:	eb 1b                	jmp    801012b2 <iget+0x42>
80101297:	89 f6                	mov    %esi,%esi
80101299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012a0:	85 f6                	test   %esi,%esi
801012a2:	74 44                	je     801012e8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012a4:	81 c3 50 01 00 00    	add    $0x150,%ebx
801012aa:	81 fb 34 b3 11 80    	cmp    $0x8011b334,%ebx
801012b0:	74 4e                	je     80101300 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012b5:	85 c9                	test   %ecx,%ecx
801012b7:	7e e7                	jle    801012a0 <iget+0x30>
801012b9:	39 3b                	cmp    %edi,(%ebx)
801012bb:	75 e3                	jne    801012a0 <iget+0x30>
801012bd:	39 53 04             	cmp    %edx,0x4(%ebx)
801012c0:	75 de                	jne    801012a0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
801012c2:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012c5:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801012c8:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801012ca:	68 60 71 11 80       	push   $0x80117160

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012cf:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012d2:	e8 09 34 00 00       	call   801046e0 <release>
      return ip;
801012d7:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012dd:	89 f0                	mov    %esi,%eax
801012df:	5b                   	pop    %ebx
801012e0:	5e                   	pop    %esi
801012e1:	5f                   	pop    %edi
801012e2:	5d                   	pop    %ebp
801012e3:	c3                   	ret    
801012e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012e8:	85 c9                	test   %ecx,%ecx
801012ea:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ed:	81 c3 50 01 00 00    	add    $0x150,%ebx
801012f3:	81 fb 34 b3 11 80    	cmp    $0x8011b334,%ebx
801012f9:	75 b7                	jne    801012b2 <iget+0x42>
801012fb:	90                   	nop
801012fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101300:	85 f6                	test   %esi,%esi
80101302:	74 2d                	je     80101331 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101304:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101307:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101309:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010130c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101313:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010131a:	68 60 71 11 80       	push   $0x80117160
8010131f:	e8 bc 33 00 00       	call   801046e0 <release>

  return ip;
80101324:	83 c4 10             	add    $0x10,%esp
}
80101327:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010132a:	89 f0                	mov    %esi,%eax
8010132c:	5b                   	pop    %ebx
8010132d:	5e                   	pop    %esi
8010132e:	5f                   	pop    %edi
8010132f:	5d                   	pop    %ebp
80101330:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101331:	83 ec 0c             	sub    $0xc,%esp
80101334:	68 b5 76 10 80       	push   $0x801076b5
80101339:	e8 32 f0 ff ff       	call   80100370 <panic>
8010133e:	66 90                	xchg   %ax,%ax

80101340 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101340:	55                   	push   %ebp
80101341:	89 e5                	mov    %esp,%ebp
80101343:	57                   	push   %edi
80101344:	56                   	push   %esi
80101345:	53                   	push   %ebx
80101346:	89 c6                	mov    %eax,%esi
80101348:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010134b:	83 fa 0b             	cmp    $0xb,%edx
8010134e:	77 18                	ja     80101368 <bmap+0x28>
80101350:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101353:	8b 83 1c 01 00 00    	mov    0x11c(%ebx),%eax
80101359:	85 c0                	test   %eax,%eax
8010135b:	74 73                	je     801013d0 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010135d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101360:	5b                   	pop    %ebx
80101361:	5e                   	pop    %esi
80101362:	5f                   	pop    %edi
80101363:	5d                   	pop    %ebp
80101364:	c3                   	ret    
80101365:	8d 76 00             	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101368:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010136b:	83 fb 7f             	cmp    $0x7f,%ebx
8010136e:	0f 87 83 00 00 00    	ja     801013f7 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101374:	8b 80 4c 01 00 00    	mov    0x14c(%eax),%eax
8010137a:	85 c0                	test   %eax,%eax
8010137c:	74 6a                	je     801013e8 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010137e:	83 ec 08             	sub    $0x8,%esp
80101381:	50                   	push   %eax
80101382:	ff 36                	pushl  (%esi)
80101384:	e8 47 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101389:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010138d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101390:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101392:	8b 1a                	mov    (%edx),%ebx
80101394:	85 db                	test   %ebx,%ebx
80101396:	75 1d                	jne    801013b5 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101398:	8b 06                	mov    (%esi),%eax
8010139a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010139d:	e8 be fd ff ff       	call   80101160 <balloc>
801013a2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801013a5:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
801013a8:	89 c3                	mov    %eax,%ebx
801013aa:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801013ac:	57                   	push   %edi
801013ad:	e8 ae 1a 00 00       	call   80102e60 <log_write>
801013b2:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
801013b5:	83 ec 0c             	sub    $0xc,%esp
801013b8:	57                   	push   %edi
801013b9:	e8 22 ee ff ff       	call   801001e0 <brelse>
801013be:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801013c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013c4:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801013c6:	5b                   	pop    %ebx
801013c7:	5e                   	pop    %esi
801013c8:	5f                   	pop    %edi
801013c9:	5d                   	pop    %ebp
801013ca:	c3                   	ret    
801013cb:	90                   	nop
801013cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801013d0:	8b 06                	mov    (%esi),%eax
801013d2:	e8 89 fd ff ff       	call   80101160 <balloc>
801013d7:	89 83 1c 01 00 00    	mov    %eax,0x11c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e0:	5b                   	pop    %ebx
801013e1:	5e                   	pop    %esi
801013e2:	5f                   	pop    %edi
801013e3:	5d                   	pop    %ebp
801013e4:	c3                   	ret    
801013e5:	8d 76 00             	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013e8:	8b 06                	mov    (%esi),%eax
801013ea:	e8 71 fd ff ff       	call   80101160 <balloc>
801013ef:	89 86 4c 01 00 00    	mov    %eax,0x14c(%esi)
801013f5:	eb 87                	jmp    8010137e <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013f7:	83 ec 0c             	sub    $0xc,%esp
801013fa:	68 c5 76 10 80       	push   $0x801076c5
801013ff:	e8 6c ef ff ff       	call   80100370 <panic>
80101404:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010140a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101410 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101418:	83 ec 08             	sub    $0x8,%esp
8010141b:	6a 01                	push   $0x1
8010141d:	ff 75 08             	pushl  0x8(%ebp)
80101420:	e8 ab ec ff ff       	call   801000d0 <bread>
80101425:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101427:	8d 40 5c             	lea    0x5c(%eax),%eax
8010142a:	83 c4 0c             	add    $0xc,%esp
8010142d:	6a 1c                	push   $0x1c
8010142f:	50                   	push   %eax
80101430:	56                   	push   %esi
80101431:	e8 aa 33 00 00       	call   801047e0 <memmove>
  brelse(bp);
80101436:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101439:	83 c4 10             	add    $0x10,%esp
}
8010143c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010143f:	5b                   	pop    %ebx
80101440:	5e                   	pop    %esi
80101441:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101442:	e9 99 ed ff ff       	jmp    801001e0 <brelse>
80101447:	89 f6                	mov    %esi,%esi
80101449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101450 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	56                   	push   %esi
80101454:	53                   	push   %ebx
80101455:	89 d3                	mov    %edx,%ebx
80101457:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101459:	83 ec 08             	sub    $0x8,%esp
8010145c:	68 40 71 11 80       	push   $0x80117140
80101461:	50                   	push   %eax
80101462:	e8 a9 ff ff ff       	call   80101410 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101467:	58                   	pop    %eax
80101468:	5a                   	pop    %edx
80101469:	89 da                	mov    %ebx,%edx
8010146b:	c1 ea 0c             	shr    $0xc,%edx
8010146e:	03 15 58 71 11 80    	add    0x80117158,%edx
80101474:	52                   	push   %edx
80101475:	56                   	push   %esi
80101476:	e8 55 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010147b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010147d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101483:	ba 01 00 00 00       	mov    $0x1,%edx
80101488:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010148b:	c1 fb 03             	sar    $0x3,%ebx
8010148e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101491:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101493:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101498:	85 d1                	test   %edx,%ecx
8010149a:	74 27                	je     801014c3 <bfree+0x73>
8010149c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010149e:	f7 d2                	not    %edx
801014a0:	89 c8                	mov    %ecx,%eax
  log_write(bp);
801014a2:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801014a5:	21 d0                	and    %edx,%eax
801014a7:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801014ab:	56                   	push   %esi
801014ac:	e8 af 19 00 00       	call   80102e60 <log_write>
  brelse(bp);
801014b1:	89 34 24             	mov    %esi,(%esp)
801014b4:	e8 27 ed ff ff       	call   801001e0 <brelse>
}
801014b9:	83 c4 10             	add    $0x10,%esp
801014bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014bf:	5b                   	pop    %ebx
801014c0:	5e                   	pop    %esi
801014c1:	5d                   	pop    %ebp
801014c2:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801014c3:	83 ec 0c             	sub    $0xc,%esp
801014c6:	68 d8 76 10 80       	push   $0x801076d8
801014cb:	e8 a0 ee ff ff       	call   80100370 <panic>

801014d0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801014d0:	55                   	push   %ebp
801014d1:	89 e5                	mov    %esp,%ebp
801014d3:	53                   	push   %ebx
801014d4:	bb a0 71 11 80       	mov    $0x801171a0,%ebx
801014d9:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
801014dc:	68 eb 76 10 80       	push   $0x801076eb
801014e1:	68 60 71 11 80       	push   $0x80117160
801014e6:	e8 e5 2f 00 00       	call   801044d0 <initlock>
801014eb:	83 c4 10             	add    $0x10,%esp
801014ee:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801014f0:	83 ec 08             	sub    $0x8,%esp
801014f3:	68 f2 76 10 80       	push   $0x801076f2
801014f8:	53                   	push   %ebx
801014f9:	81 c3 50 01 00 00    	add    $0x150,%ebx
801014ff:	e8 9c 2e 00 00       	call   801043a0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101504:	83 c4 10             	add    $0x10,%esp
80101507:	81 fb 40 b3 11 80    	cmp    $0x8011b340,%ebx
8010150d:	75 e1                	jne    801014f0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010150f:	83 ec 08             	sub    $0x8,%esp
80101512:	68 40 71 11 80       	push   $0x80117140
80101517:	ff 75 08             	pushl  0x8(%ebp)
8010151a:	e8 f1 fe ff ff       	call   80101410 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010151f:	ff 35 58 71 11 80    	pushl  0x80117158
80101525:	ff 35 54 71 11 80    	pushl  0x80117154
8010152b:	ff 35 50 71 11 80    	pushl  0x80117150
80101531:	ff 35 4c 71 11 80    	pushl  0x8011714c
80101537:	ff 35 48 71 11 80    	pushl  0x80117148
8010153d:	ff 35 44 71 11 80    	pushl  0x80117144
80101543:	ff 35 40 71 11 80    	pushl  0x80117140
80101549:	68 58 77 10 80       	push   $0x80107758
8010154e:	e8 0d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101553:	83 c4 30             	add    $0x30,%esp
80101556:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101559:	c9                   	leave  
8010155a:	c3                   	ret    
8010155b:	90                   	nop
8010155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101560 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	57                   	push   %edi
80101564:	56                   	push   %esi
80101565:	53                   	push   %ebx
80101566:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101569:	83 3d 48 71 11 80 01 	cmpl   $0x1,0x80117148
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101570:	8b 45 0c             	mov    0xc(%ebp),%eax
80101573:	8b 75 08             	mov    0x8(%ebp),%esi
80101576:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101579:	0f 86 93 00 00 00    	jbe    80101612 <ialloc+0xb2>
8010157f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101584:	eb 21                	jmp    801015a7 <ialloc+0x47>
80101586:	8d 76 00             	lea    0x0(%esi),%esi
80101589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101590:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101593:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101596:	57                   	push   %edi
80101597:	e8 44 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010159c:	83 c4 10             	add    $0x10,%esp
8010159f:	39 1d 48 71 11 80    	cmp    %ebx,0x80117148
801015a5:	76 6b                	jbe    80101612 <ialloc+0xb2>
    bp = bread(dev, IBLOCK(inum, sb));
801015a7:	89 d8                	mov    %ebx,%eax
801015a9:	83 ec 08             	sub    $0x8,%esp
801015ac:	d1 e8                	shr    %eax
801015ae:	03 05 54 71 11 80    	add    0x80117154,%eax
801015b4:	50                   	push   %eax
801015b5:	56                   	push   %esi
801015b6:	e8 15 eb ff ff       	call   801000d0 <bread>
801015bb:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015bd:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801015bf:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
801015c2:	83 e0 01             	and    $0x1,%eax
801015c5:	c1 e0 08             	shl    $0x8,%eax
801015c8:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015cc:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015d0:	75 be                	jne    80101590 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015d2:	83 ec 04             	sub    $0x4,%esp
801015d5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015d8:	68 00 01 00 00       	push   $0x100
801015dd:	6a 00                	push   $0x0
801015df:	51                   	push   %ecx
801015e0:	e8 4b 31 00 00       	call   80104730 <memset>
      dip->type = type;
801015e5:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015e9:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015ec:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ef:	89 3c 24             	mov    %edi,(%esp)
801015f2:	e8 69 18 00 00       	call   80102e60 <log_write>
      brelse(bp);
801015f7:	89 3c 24             	mov    %edi,(%esp)
801015fa:	e8 e1 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015ff:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101602:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101605:	89 da                	mov    %ebx,%edx
80101607:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101609:	5b                   	pop    %ebx
8010160a:	5e                   	pop    %esi
8010160b:	5f                   	pop    %edi
8010160c:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010160d:	e9 5e fc ff ff       	jmp    80101270 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101612:	83 ec 0c             	sub    $0xc,%esp
80101615:	68 f8 76 10 80       	push   $0x801076f8
8010161a:	e8 51 ed ff ff       	call   80100370 <panic>
8010161f:	90                   	nop

80101620 <iupdate>:
  log_write(bp);
  brelse(bp);
}*/
void
iupdate(struct inode *ip)
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	57                   	push   %edi
80101624:	56                   	push   %esi
80101625:	53                   	push   %ebx
80101626:	83 ec 14             	sub    $0x14,%esp
80101629:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010162c:	8b 43 04             	mov    0x4(%ebx),%eax
8010162f:	d1 e8                	shr    %eax
80101631:	03 05 54 71 11 80    	add    0x80117154,%eax
80101637:	50                   	push   %eax
80101638:	ff 33                	pushl  (%ebx)
8010163a:	e8 91 ea ff ff       	call   801000d0 <bread>
8010163f:	89 c7                	mov    %eax,%edi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101641:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  safestrcpy(dip->owner, ip->uProp.name, sizeof(ip->uProp.name));
80101644:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101647:	83 e0 01             	and    $0x1,%eax
8010164a:	c1 e0 08             	shl    $0x8,%eax
8010164d:	8d 74 07 5c          	lea    0x5c(%edi,%eax,1),%esi
  dip->type = ip->type;
80101651:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80101655:	66 89 06             	mov    %ax,(%esi)
  dip->major = ip->major;
80101658:	0f b7 43 52          	movzwl 0x52(%ebx),%eax
8010165c:	66 89 46 02          	mov    %ax,0x2(%esi)
  dip->minor = ip->minor;
80101660:	0f b7 83 14 01 00 00 	movzwl 0x114(%ebx),%eax
80101667:	66 89 46 04          	mov    %ax,0x4(%esi)
  safestrcpy(dip->owner, ip->uProp.name, sizeof(ip->uProp.name));
8010166b:	8d 43 54             	lea    0x54(%ebx),%eax
8010166e:	6a 60                	push   $0x60
80101670:	50                   	push   %eax
80101671:	8d 46 40             	lea    0x40(%esi),%eax
80101674:	50                   	push   %eax
80101675:	e8 b6 32 00 00       	call   80104930 <safestrcpy>
  safestrcpy(dip->group, ip->uProp.group, sizeof(ip->uProp.group));
8010167a:	8d 83 b4 00 00 00    	lea    0xb4(%ebx),%eax
80101680:	83 c4 0c             	add    $0xc,%esp
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101683:	81 c3 1c 01 00 00    	add    $0x11c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  safestrcpy(dip->owner, ip->uProp.name, sizeof(ip->uProp.name));
  safestrcpy(dip->group, ip->uProp.group, sizeof(ip->uProp.group));
80101689:	6a 60                	push   $0x60
8010168b:	50                   	push   %eax
8010168c:	8d 86 a0 00 00 00    	lea    0xa0(%esi),%eax
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101692:	83 c6 0c             	add    $0xc,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  safestrcpy(dip->owner, ip->uProp.name, sizeof(ip->uProp.name));
  safestrcpy(dip->group, ip->uProp.group, sizeof(ip->uProp.group));
80101695:	50                   	push   %eax
80101696:	e8 95 32 00 00       	call   80104930 <safestrcpy>
  dip->nlink = ip->nlink;
8010169b:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010169f:	83 c4 0c             	add    $0xc,%esp
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  safestrcpy(dip->owner, ip->uProp.name, sizeof(ip->uProp.name));
  safestrcpy(dip->group, ip->uProp.group, sizeof(ip->uProp.group));
  dip->nlink = ip->nlink;
801016a2:	66 89 46 fa          	mov    %ax,-0x6(%esi)
  dip->size = ip->size;
801016a6:	8b 43 fc             	mov    -0x4(%ebx),%eax
801016a9:	89 46 fc             	mov    %eax,-0x4(%esi)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ac:	6a 34                	push   $0x34
801016ae:	53                   	push   %ebx
801016af:	56                   	push   %esi
801016b0:	e8 2b 31 00 00       	call   801047e0 <memmove>
  log_write(bp);
801016b5:	89 3c 24             	mov    %edi,(%esp)
801016b8:	e8 a3 17 00 00       	call   80102e60 <log_write>
  brelse(bp);
801016bd:	89 7d 08             	mov    %edi,0x8(%ebp)
801016c0:	83 c4 10             	add    $0x10,%esp
}
801016c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016c6:	5b                   	pop    %ebx
801016c7:	5e                   	pop    %esi
801016c8:	5f                   	pop    %edi
801016c9:	5d                   	pop    %ebp
  safestrcpy(dip->group, ip->uProp.group, sizeof(ip->uProp.group));
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801016ca:	e9 11 eb ff ff       	jmp    801001e0 <brelse>
801016cf:	90                   	nop

801016d0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	53                   	push   %ebx
801016d4:	83 ec 10             	sub    $0x10,%esp
801016d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //cprintf("dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  acquire(&icache.lock);
801016da:	68 60 71 11 80       	push   $0x80117160
801016df:	e8 4c 2f 00 00       	call   80104630 <acquire>
  //
  ip->ref++;
801016e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016e8:	c7 04 24 60 71 11 80 	movl   $0x80117160,(%esp)
801016ef:	e8 ec 2f 00 00       	call   801046e0 <release>
  return ip;
}
801016f4:	89 d8                	mov    %ebx,%eax
801016f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016f9:	c9                   	leave  
801016fa:	c3                   	ret    
801016fb:	90                   	nop
801016fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101700 <ilock>:
      panic("ilock: no type");
  }
}*/
void
ilock(struct inode *ip)
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	57                   	push   %edi
80101704:	56                   	push   %esi
80101705:	53                   	push   %ebx
80101706:	83 ec 0c             	sub    $0xc,%esp
80101709:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010170c:	85 db                	test   %ebx,%ebx
8010170e:	0f 84 e8 00 00 00    	je     801017fc <ilock+0xfc>
80101714:	8b 53 08             	mov    0x8(%ebx),%edx
80101717:	85 d2                	test   %edx,%edx
80101719:	0f 8e dd 00 00 00    	jle    801017fc <ilock+0xfc>
    panic("ilock");

  acquiresleep(&ip->lock);
8010171f:	8d 43 0c             	lea    0xc(%ebx),%eax
80101722:	83 ec 0c             	sub    $0xc,%esp
80101725:	50                   	push   %eax
80101726:	e8 b5 2c 00 00       	call   801043e0 <acquiresleep>

  if(ip->valid == 0){
8010172b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010172e:	83 c4 10             	add    $0x10,%esp
80101731:	85 c0                	test   %eax,%eax
80101733:	74 0b                	je     80101740 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101735:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101738:	5b                   	pop    %ebx
80101739:	5e                   	pop    %esi
8010173a:	5f                   	pop    %edi
8010173b:	5d                   	pop    %ebp
8010173c:	c3                   	ret    
8010173d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101740:	8b 43 04             	mov    0x4(%ebx),%eax
80101743:	83 ec 08             	sub    $0x8,%esp
80101746:	d1 e8                	shr    %eax
80101748:	03 05 54 71 11 80    	add    0x80117154,%eax
8010174e:	50                   	push   %eax
8010174f:	ff 33                	pushl  (%ebx)
80101751:	e8 7a e9 ff ff       	call   801000d0 <bread>
80101756:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101758:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    safestrcpy(ip->uProp.name, dip->owner, sizeof(dip->owner) + 1);
8010175b:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010175e:	83 e0 01             	and    $0x1,%eax
80101761:	c1 e0 08             	shl    $0x8,%eax
80101764:	8d 74 07 5c          	lea    0x5c(%edi,%eax,1),%esi
    ip->type = dip->type;
80101768:	0f b7 06             	movzwl (%esi),%eax
8010176b:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010176f:	0f b7 46 02          	movzwl 0x2(%esi),%eax
80101773:	66 89 43 52          	mov    %ax,0x52(%ebx)
    safestrcpy(ip->uProp.name, dip->owner, sizeof(dip->owner) + 1);
80101777:	8d 46 40             	lea    0x40(%esi),%eax
8010177a:	6a 61                	push   $0x61
8010177c:	50                   	push   %eax
8010177d:	8d 43 54             	lea    0x54(%ebx),%eax
80101780:	50                   	push   %eax
80101781:	e8 aa 31 00 00       	call   80104930 <safestrcpy>
    safestrcpy(ip->uProp.group, dip->group, sizeof(dip->group) + 1);
80101786:	8d 86 a0 00 00 00    	lea    0xa0(%esi),%eax
8010178c:	83 c4 0c             	add    $0xc,%esp
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010178f:	83 c6 0c             	add    $0xc,%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    safestrcpy(ip->uProp.name, dip->owner, sizeof(dip->owner) + 1);
    safestrcpy(ip->uProp.group, dip->group, sizeof(dip->group) + 1);
80101792:	6a 61                	push   $0x61
80101794:	50                   	push   %eax
80101795:	8d 83 b4 00 00 00    	lea    0xb4(%ebx),%eax
8010179b:	50                   	push   %eax
8010179c:	e8 8f 31 00 00       	call   80104930 <safestrcpy>
    ip->minor = dip->minor;
801017a1:	0f b7 46 f8          	movzwl -0x8(%esi),%eax
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017a5:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    safestrcpy(ip->uProp.name, dip->owner, sizeof(dip->owner) + 1);
    safestrcpy(ip->uProp.group, dip->group, sizeof(dip->group) + 1);
    ip->minor = dip->minor;
801017a8:	66 89 83 14 01 00 00 	mov    %ax,0x114(%ebx)
    ip->nlink = dip->nlink;
801017af:	0f b7 46 fa          	movzwl -0x6(%esi),%eax
801017b3:	66 89 83 16 01 00 00 	mov    %ax,0x116(%ebx)
    ip->size = dip->size;
801017ba:	8b 46 fc             	mov    -0x4(%esi),%eax
801017bd:	89 83 18 01 00 00    	mov    %eax,0x118(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017c3:	8d 83 1c 01 00 00    	lea    0x11c(%ebx),%eax
801017c9:	6a 34                	push   $0x34
801017cb:	56                   	push   %esi
801017cc:	50                   	push   %eax
801017cd:	e8 0e 30 00 00       	call   801047e0 <memmove>
    brelse(bp);
801017d2:	89 3c 24             	mov    %edi,(%esp)
801017d5:	e8 06 ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801017da:	83 c4 10             	add    $0x10,%esp
801017dd:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801017e2:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017e9:	0f 85 46 ff ff ff    	jne    80101735 <ilock+0x35>
      panic("ilock: no type");
801017ef:	83 ec 0c             	sub    $0xc,%esp
801017f2:	68 10 77 10 80       	push   $0x80107710
801017f7:	e8 74 eb ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801017fc:	83 ec 0c             	sub    $0xc,%esp
801017ff:	68 0a 77 10 80       	push   $0x8010770a
80101804:	e8 67 eb ff ff       	call   80100370 <panic>
80101809:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101810 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	56                   	push   %esi
80101814:	53                   	push   %ebx
80101815:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101818:	85 db                	test   %ebx,%ebx
8010181a:	74 28                	je     80101844 <iunlock+0x34>
8010181c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010181f:	83 ec 0c             	sub    $0xc,%esp
80101822:	56                   	push   %esi
80101823:	e8 58 2c 00 00       	call   80104480 <holdingsleep>
80101828:	83 c4 10             	add    $0x10,%esp
8010182b:	85 c0                	test   %eax,%eax
8010182d:	74 15                	je     80101844 <iunlock+0x34>
8010182f:	8b 43 08             	mov    0x8(%ebx),%eax
80101832:	85 c0                	test   %eax,%eax
80101834:	7e 0e                	jle    80101844 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101836:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101839:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010183c:	5b                   	pop    %ebx
8010183d:	5e                   	pop    %esi
8010183e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010183f:	e9 fc 2b 00 00       	jmp    80104440 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101844:	83 ec 0c             	sub    $0xc,%esp
80101847:	68 1f 77 10 80       	push   $0x8010771f
8010184c:	e8 1f eb ff ff       	call   80100370 <panic>
80101851:	eb 0d                	jmp    80101860 <iput>
80101853:	90                   	nop
80101854:	90                   	nop
80101855:	90                   	nop
80101856:	90                   	nop
80101857:	90                   	nop
80101858:	90                   	nop
80101859:	90                   	nop
8010185a:	90                   	nop
8010185b:	90                   	nop
8010185c:	90                   	nop
8010185d:	90                   	nop
8010185e:	90                   	nop
8010185f:	90                   	nop

80101860 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	57                   	push   %edi
80101864:	56                   	push   %esi
80101865:	53                   	push   %ebx
80101866:	83 ec 28             	sub    $0x28,%esp
80101869:	8b 75 08             	mov    0x8(%ebp),%esi
  //cprintf("iput nlink: %d\n",ip->nlink);
  acquiresleep(&ip->lock);
8010186c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010186f:	57                   	push   %edi
80101870:	e8 6b 2b 00 00       	call   801043e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101875:	8b 56 4c             	mov    0x4c(%esi),%edx
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 d2                	test   %edx,%edx
8010187d:	74 0a                	je     80101889 <iput+0x29>
8010187f:	66 83 be 16 01 00 00 	cmpw   $0x0,0x116(%esi)
80101886:	00 
80101887:	74 37                	je     801018c0 <iput+0x60>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80101889:	83 ec 0c             	sub    $0xc,%esp
8010188c:	57                   	push   %edi
8010188d:	e8 ae 2b 00 00       	call   80104440 <releasesleep>

  acquire(&icache.lock);
80101892:	c7 04 24 60 71 11 80 	movl   $0x80117160,(%esp)
80101899:	e8 92 2d 00 00       	call   80104630 <acquire>
  ip->ref--;
8010189e:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	c7 45 08 60 71 11 80 	movl   $0x80117160,0x8(%ebp)
}
801018ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018af:	5b                   	pop    %ebx
801018b0:	5e                   	pop    %esi
801018b1:	5f                   	pop    %edi
801018b2:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801018b3:	e9 28 2e 00 00       	jmp    801046e0 <release>
801018b8:	90                   	nop
801018b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
iput(struct inode *ip)
{
  //cprintf("iput nlink: %d\n",ip->nlink);
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801018c0:	83 ec 0c             	sub    $0xc,%esp
801018c3:	68 60 71 11 80       	push   $0x80117160
801018c8:	e8 63 2d 00 00       	call   80104630 <acquire>
    int r = ip->ref;
801018cd:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801018d0:	c7 04 24 60 71 11 80 	movl   $0x80117160,(%esp)
801018d7:	e8 04 2e 00 00       	call   801046e0 <release>
    if(r == 1){
801018dc:	83 c4 10             	add    $0x10,%esp
801018df:	83 fb 01             	cmp    $0x1,%ebx
801018e2:	75 a5                	jne    80101889 <iput+0x29>
801018e4:	8d 8e 4c 01 00 00    	lea    0x14c(%esi),%ecx
801018ea:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018ed:	8d 9e 1c 01 00 00    	lea    0x11c(%esi),%ebx
801018f3:	89 cf                	mov    %ecx,%edi
801018f5:	eb 10                	jmp    80101907 <iput+0xa7>
801018f7:	89 f6                	mov    %esi,%esi
801018f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101900:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101903:	39 fb                	cmp    %edi,%ebx
80101905:	74 19                	je     80101920 <iput+0xc0>
    if(ip->addrs[i]){
80101907:	8b 13                	mov    (%ebx),%edx
80101909:	85 d2                	test   %edx,%edx
8010190b:	74 f3                	je     80101900 <iput+0xa0>
      bfree(ip->dev, ip->addrs[i]);
8010190d:	8b 06                	mov    (%esi),%eax
8010190f:	e8 3c fb ff ff       	call   80101450 <bfree>
      ip->addrs[i] = 0;
80101914:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010191a:	eb e4                	jmp    80101900 <iput+0xa0>
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101920:	8b 86 4c 01 00 00    	mov    0x14c(%esi),%eax
80101926:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101929:	85 c0                	test   %eax,%eax
8010192b:	75 33                	jne    80101960 <iput+0x100>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010192d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101930:	c7 86 18 01 00 00 00 	movl   $0x0,0x118(%esi)
80101937:	00 00 00 
  iupdate(ip);
8010193a:	56                   	push   %esi
8010193b:	e8 e0 fc ff ff       	call   80101620 <iupdate>
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      //cprintf("iput owner: %s\n",ip->uProp.name);
      itrunc(ip);
      ip->type = 0;
80101940:	31 c0                	xor    %eax,%eax
80101942:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101946:	89 34 24             	mov    %esi,(%esp)
80101949:	e8 d2 fc ff ff       	call   80101620 <iupdate>
      ip->valid = 0;
8010194e:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101955:	83 c4 10             	add    $0x10,%esp
80101958:	e9 2c ff ff ff       	jmp    80101889 <iput+0x29>
8010195d:	8d 76 00             	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101960:	83 ec 08             	sub    $0x8,%esp
80101963:	50                   	push   %eax
80101964:	ff 36                	pushl  (%esi)
80101966:	e8 65 e7 ff ff       	call   801000d0 <bread>
8010196b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101971:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101974:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101977:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010197a:	83 c4 10             	add    $0x10,%esp
8010197d:	89 cf                	mov    %ecx,%edi
8010197f:	eb 0e                	jmp    8010198f <iput+0x12f>
80101981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101988:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
8010198b:	39 fb                	cmp    %edi,%ebx
8010198d:	74 0f                	je     8010199e <iput+0x13e>
      if(a[j])
8010198f:	8b 13                	mov    (%ebx),%edx
80101991:	85 d2                	test   %edx,%edx
80101993:	74 f3                	je     80101988 <iput+0x128>
        bfree(ip->dev, a[j]);
80101995:	8b 06                	mov    (%esi),%eax
80101997:	e8 b4 fa ff ff       	call   80101450 <bfree>
8010199c:	eb ea                	jmp    80101988 <iput+0x128>
    }
    brelse(bp);
8010199e:	83 ec 0c             	sub    $0xc,%esp
801019a1:	ff 75 e4             	pushl  -0x1c(%ebp)
801019a4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019a7:	e8 34 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019ac:	8b 96 4c 01 00 00    	mov    0x14c(%esi),%edx
801019b2:	8b 06                	mov    (%esi),%eax
801019b4:	e8 97 fa ff ff       	call   80101450 <bfree>
    ip->addrs[NDIRECT] = 0;
801019b9:	c7 86 4c 01 00 00 00 	movl   $0x0,0x14c(%esi)
801019c0:	00 00 00 
801019c3:	83 c4 10             	add    $0x10,%esp
801019c6:	e9 62 ff ff ff       	jmp    8010192d <iput+0xcd>
801019cb:	90                   	nop
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019d0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801019d0:	55                   	push   %ebp
801019d1:	89 e5                	mov    %esp,%ebp
801019d3:	53                   	push   %ebx
801019d4:	83 ec 10             	sub    $0x10,%esp
801019d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801019da:	53                   	push   %ebx
801019db:	e8 30 fe ff ff       	call   80101810 <iunlock>
  iput(ip);
801019e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019e3:	83 c4 10             	add    $0x10,%esp
}
801019e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019e9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801019ea:	e9 71 fe ff ff       	jmp    80101860 <iput>
801019ef:	90                   	nop

801019f0 <stati>:
  st->nlink = ip->nlink;
  st->size = ip->size;
}*/
void
stati(struct inode *ip, struct stat *st)
{
801019f0:	55                   	push   %ebp
801019f1:	89 e5                	mov    %esp,%ebp
801019f3:	57                   	push   %edi
801019f4:	56                   	push   %esi
801019f5:	53                   	push   %ebx
801019f6:	83 ec 18             	sub    $0x18,%esp
801019f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801019fc:	8b 75 0c             	mov    0xc(%ebp),%esi
  st->dev = ip->dev;
801019ff:	8b 03                	mov    (%ebx),%eax
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  st->size = ip->size;
  //st->userProp = ip->userProp;
  safestrcpy(st->owner, ip->uProp.name, strlen(ip->uProp.name) + 1);
80101a01:	8d 7b 54             	lea    0x54(%ebx),%edi
  safestrcpy(st->group, ip->uProp.group, strlen(ip->uProp.group) + 1);
80101a04:	81 c3 b4 00 00 00    	add    $0xb4,%ebx
  st->size = ip->size;
}*/
void
stati(struct inode *ip, struct stat *st)
{
  st->dev = ip->dev;
80101a0a:	89 46 04             	mov    %eax,0x4(%esi)
  st->ino = ip->inum;
80101a0d:	8b 83 50 ff ff ff    	mov    -0xb0(%ebx),%eax
80101a13:	89 46 08             	mov    %eax,0x8(%esi)
  st->type = ip->type;
80101a16:	0f b7 43 9c          	movzwl -0x64(%ebx),%eax
80101a1a:	66 89 06             	mov    %ax,(%esi)
  st->nlink = ip->nlink;
80101a1d:	0f b7 43 62          	movzwl 0x62(%ebx),%eax
80101a21:	66 89 46 0c          	mov    %ax,0xc(%esi)
  st->size = ip->size;
80101a25:	8b 43 64             	mov    0x64(%ebx),%eax
80101a28:	89 46 10             	mov    %eax,0x10(%esi)
  //st->userProp = ip->userProp;
  safestrcpy(st->owner, ip->uProp.name, strlen(ip->uProp.name) + 1);
80101a2b:	57                   	push   %edi
80101a2c:	e8 3f 2f 00 00       	call   80104970 <strlen>
80101a31:	83 c4 0c             	add    $0xc,%esp
80101a34:	83 c0 01             	add    $0x1,%eax
80101a37:	50                   	push   %eax
80101a38:	8d 46 14             	lea    0x14(%esi),%eax
80101a3b:	57                   	push   %edi
  safestrcpy(st->group, ip->uProp.group, strlen(ip->uProp.group) + 1);
80101a3c:	83 c6 74             	add    $0x74,%esi
  st->ino = ip->inum;
  st->type = ip->type;
  st->nlink = ip->nlink;
  st->size = ip->size;
  //st->userProp = ip->userProp;
  safestrcpy(st->owner, ip->uProp.name, strlen(ip->uProp.name) + 1);
80101a3f:	50                   	push   %eax
80101a40:	e8 eb 2e 00 00       	call   80104930 <safestrcpy>
  safestrcpy(st->group, ip->uProp.group, strlen(ip->uProp.group) + 1);
80101a45:	89 1c 24             	mov    %ebx,(%esp)
80101a48:	e8 23 2f 00 00       	call   80104970 <strlen>
80101a4d:	83 c4 0c             	add    $0xc,%esp
80101a50:	83 c0 01             	add    $0x1,%eax
80101a53:	50                   	push   %eax
80101a54:	53                   	push   %ebx
80101a55:	56                   	push   %esi
80101a56:	e8 d5 2e 00 00       	call   80104930 <safestrcpy>
}
80101a5b:	83 c4 10             	add    $0x10,%esp
80101a5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a61:	5b                   	pop    %ebx
80101a62:	5e                   	pop    %esi
80101a63:	5f                   	pop    %edi
80101a64:	5d                   	pop    %ebp
80101a65:	c3                   	ret    
80101a66:	8d 76 00             	lea    0x0(%esi),%esi
80101a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101a70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a7f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a87:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a8a:	8b 7d 14             	mov    0x14(%ebp),%edi
80101a8d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a93:	0f 84 a7 00 00 00    	je     80101b40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	8b 80 18 01 00 00    	mov    0x118(%eax),%eax
80101aa2:	39 f0                	cmp    %esi,%eax
80101aa4:	0f 82 be 00 00 00    	jb     80101b68 <readi+0xf8>
80101aaa:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aad:	89 fa                	mov    %edi,%edx
80101aaf:	01 f2                	add    %esi,%edx
80101ab1:	0f 82 b1 00 00 00    	jb     80101b68 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ab7:	89 c1                	mov    %eax,%ecx
80101ab9:	29 f1                	sub    %esi,%ecx
80101abb:	39 d0                	cmp    %edx,%eax
80101abd:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac0:	31 ff                	xor    %edi,%edi
80101ac2:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ac4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ac7:	74 6a                	je     80101b33 <readi+0xc3>
80101ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 d8                	mov    %ebx,%eax
80101ada:	e8 61 f8 ff ff       	call   80101340 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aea:	e8 e1 e5 ff ff       	call   801000d0 <bread>
80101aef:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101af1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101af4:	89 f1                	mov    %esi,%ecx
80101af6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101afc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101aff:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b02:	29 cb                	sub    %ecx,%ebx
80101b04:	29 f8                	sub    %edi,%eax
80101b06:	39 c3                	cmp    %eax,%ebx
80101b08:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b0b:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
80101b0f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b10:	01 df                	add    %ebx,%edi
80101b12:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101b14:	50                   	push   %eax
80101b15:	ff 75 e0             	pushl  -0x20(%ebp)
80101b18:	e8 c3 2c 00 00       	call   801047e0 <memmove>
    brelse(bp);
80101b1d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b20:	89 14 24             	mov    %edx,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b28:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b2b:	83 c4 10             	add    $0x10,%esp
80101b2e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b31:	77 9d                	ja     80101ad0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101b33:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b39:	5b                   	pop    %ebx
80101b3a:	5e                   	pop    %esi
80101b3b:	5f                   	pop    %edi
80101b3c:	5d                   	pop    %ebp
80101b3d:	c3                   	ret    
80101b3e:	66 90                	xchg   %ax,%ax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
	//cprintf("T_DEV\n");
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 1e                	ja     80101b68 <readi+0xf8>
80101b4a:	8b 04 c5 e0 70 11 80 	mov    -0x7fee8f20(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 13                	je     80101b68 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b55:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101b58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp

  if(ip->type == T_DEV){
	//cprintf("T_DEV\n");
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct buf *bp;

  if(ip->type == T_DEV){
	//cprintf("T_DEV\n");
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b6d:	eb c7                	jmp    80101b36 <readi+0xc6>
80101b6f:	90                   	nop

80101b70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;
  //cprintf("src: %s\n", src);
  if(ip->type == T_DEV){
80101b82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101b8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;
  //cprintf("src: %s\n", src);
  if(ip->type == T_DEV){
80101b93:	0f 84 b7 00 00 00    	je     80101c50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9c:	39 b0 18 01 00 00    	cmp    %esi,0x118(%eax)
80101ba2:	0f 82 e8 00 00 00    	jb     80101c90 <writei+0x120>
80101ba8:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bab:	89 f8                	mov    %edi,%eax
80101bad:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101baf:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bb4:	0f 87 d6 00 00 00    	ja     80101c90 <writei+0x120>
80101bba:	39 c6                	cmp    %eax,%esi
80101bbc:	0f 87 ce 00 00 00    	ja     80101c90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bc2:	85 ff                	test   %edi,%edi
80101bc4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101bcb:	74 78                	je     80101c45 <writei+0xd5>
80101bcd:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bd3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bda:	c1 ea 09             	shr    $0x9,%edx
80101bdd:	89 f8                	mov    %edi,%eax
80101bdf:	e8 5c f7 ff ff       	call   80101340 <bmap>
80101be4:	83 ec 08             	sub    $0x8,%esp
80101be7:	50                   	push   %eax
80101be8:	ff 37                	pushl  (%edi)
80101bea:	e8 e1 e4 ff ff       	call   801000d0 <bread>
80101bef:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101bf1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bf4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101bf7:	89 f1                	mov    %esi,%ecx
80101bf9:	83 c4 0c             	add    $0xc,%esp
80101bfc:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101c02:	29 cb                	sub    %ecx,%ebx
80101c04:	39 c3                	cmp    %eax,%ebx
80101c06:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c09:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101c0d:	53                   	push   %ebx
80101c0e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c11:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101c13:	50                   	push   %eax
80101c14:	e8 c7 2b 00 00       	call   801047e0 <memmove>
    log_write(bp);
80101c19:	89 3c 24             	mov    %edi,(%esp)
80101c1c:	e8 3f 12 00 00       	call   80102e60 <log_write>
    brelse(bp);
80101c21:	89 3c 24             	mov    %edi,(%esp)
80101c24:	e8 b7 e5 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c29:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c2c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c2f:	83 c4 10             	add    $0x10,%esp
80101c32:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c35:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101c38:	77 96                	ja     80101bd0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }
  //cprintf("fs.c writei() storing file\n");
  if(n > 0 && off > ip->size){
80101c3a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c3d:	3b b0 18 01 00 00    	cmp    0x118(%eax),%esi
80101c43:	77 33                	ja     80101c78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c45:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4b:	5b                   	pop    %ebx
80101c4c:	5e                   	pop    %esi
80101c4d:	5f                   	pop    %edi
80101c4e:	5d                   	pop    %ebp
80101c4f:	c3                   	ret    
{
  uint tot, m;
  struct buf *bp;
  //cprintf("src: %s\n", src);
  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c54:	66 83 f8 09          	cmp    $0x9,%ax
80101c58:	77 36                	ja     80101c90 <writei+0x120>
80101c5a:	8b 04 c5 e4 70 11 80 	mov    -0x7fee8f1c(,%eax,8),%eax
80101c61:	85 c0                	test   %eax,%eax
80101c63:	74 2b                	je     80101c90 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c65:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
  struct buf *bp;
  //cprintf("src: %s\n", src);
  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101c6f:	ff e0                	jmp    *%eax
80101c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }
  //cprintf("fs.c writei() storing file\n");
  if(n > 0 && off > ip->size){
    ip->size = off;
80101c78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c7b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }
  //cprintf("fs.c writei() storing file\n");
  if(n > 0 && off > ip->size){
    ip->size = off;
80101c7e:	89 b0 18 01 00 00    	mov    %esi,0x118(%eax)
    iupdate(ip);
80101c84:	50                   	push   %eax
80101c85:	e8 96 f9 ff ff       	call   80101620 <iupdate>
80101c8a:	83 c4 10             	add    $0x10,%esp
80101c8d:	eb b6                	jmp    80101c45 <writei+0xd5>
80101c8f:	90                   	nop
  uint tot, m;
  struct buf *bp;
  //cprintf("src: %s\n", src);
  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c95:	eb b1                	jmp    80101c48 <writei+0xd8>
80101c97:	89 f6                	mov    %esi,%esi
80101c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ca0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ca6:	6a 0e                	push   $0xe
80101ca8:	ff 75 0c             	pushl  0xc(%ebp)
80101cab:	ff 75 08             	pushl  0x8(%ebp)
80101cae:	e8 ad 2b 00 00       	call   80104860 <strncmp>
}
80101cb3:	c9                   	leave  
80101cb4:	c3                   	ret    
80101cb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	57                   	push   %edi
80101cc4:	56                   	push   %esi
80101cc5:	53                   	push   %ebx
80101cc6:	83 ec 1c             	sub    $0x1c,%esp
80101cc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR){
80101ccc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cd1:	0f 85 90 00 00 00    	jne    80101d67 <dirlookup+0xa7>
	//cprintf("dp type: %d\n", dp->type);    
	panic("dirlookup not DIR");
    
  }
  //cprintf("dp size: %d\n", dp->size); 
  for(off = 0; off < dp->size; off += sizeof(de)){
80101cd7:	8b 93 18 01 00 00    	mov    0x118(%ebx),%edx
80101cdd:	31 ff                	xor    %edi,%edi
80101cdf:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ce2:	85 d2                	test   %edx,%edx
80101ce4:	75 15                	jne    80101cfb <dirlookup+0x3b>
80101ce6:	eb 68                	jmp    80101d50 <dirlookup+0x90>
80101ce8:	90                   	nop
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cf0:	83 c7 10             	add    $0x10,%edi
80101cf3:	39 bb 18 01 00 00    	cmp    %edi,0x118(%ebx)
80101cf9:	76 55                	jbe    80101d50 <dirlookup+0x90>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de)){
80101cfb:	6a 10                	push   $0x10
80101cfd:	57                   	push   %edi
80101cfe:	56                   	push   %esi
80101cff:	53                   	push   %ebx
80101d00:	e8 6b fd ff ff       	call   80101a70 <readi>
80101d05:	83 c4 10             	add    $0x10,%esp
80101d08:	83 f8 10             	cmp    $0x10,%eax
80101d0b:	75 4d                	jne    80101d5a <dirlookup+0x9a>
		//cprintf("sizeof de: %d\n",sizeof(de));	
		panic("dirlookup read");
	}
    if(de.inum == 0)
80101d0d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d12:	74 dc                	je     80101cf0 <dirlookup+0x30>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101d14:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d17:	83 ec 04             	sub    $0x4,%esp
80101d1a:	6a 0e                	push   $0xe
80101d1c:	50                   	push   %eax
80101d1d:	ff 75 0c             	pushl  0xc(%ebp)
80101d20:	e8 3b 2b 00 00       	call   80104860 <strncmp>
		//cprintf("sizeof de: %d\n",sizeof(de));	
		panic("dirlookup read");
	}
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101d25:	83 c4 10             	add    $0x10,%esp
80101d28:	85 c0                	test   %eax,%eax
80101d2a:	75 c4                	jne    80101cf0 <dirlookup+0x30>
      // entry matches path element
      if(poff)
80101d2c:	8b 45 10             	mov    0x10(%ebp),%eax
80101d2f:	85 c0                	test   %eax,%eax
80101d31:	74 05                	je     80101d38 <dirlookup+0x78>
        *poff = off;
80101d33:	8b 45 10             	mov    0x10(%ebp),%eax
80101d36:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101d38:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101d3c:	8b 03                	mov    (%ebx),%eax
80101d3e:	e8 2d f5 ff ff       	call   80101270 <iget>
    }
  }
  //cprintf("de name: %s\n", de.name);
  return 0;
}
80101d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
80101d4b:	90                   	nop
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d50:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }
  //cprintf("de name: %s\n", de.name);
  return 0;
80101d53:	31 c0                	xor    %eax,%eax
}
80101d55:	5b                   	pop    %ebx
80101d56:	5e                   	pop    %esi
80101d57:	5f                   	pop    %edi
80101d58:	5d                   	pop    %ebp
80101d59:	c3                   	ret    
  }
  //cprintf("dp size: %d\n", dp->size); 
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de)){
		//cprintf("sizeof de: %d\n",sizeof(de));	
		panic("dirlookup read");
80101d5a:	83 ec 0c             	sub    $0xc,%esp
80101d5d:	68 39 77 10 80       	push   $0x80107739
80101d62:	e8 09 e6 ff ff       	call   80100370 <panic>
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR){
	//cprintf("dp type: %d\n", dp->type);    
	panic("dirlookup not DIR");
80101d67:	83 ec 0c             	sub    $0xc,%esp
80101d6a:	68 27 77 10 80       	push   $0x80107727
80101d6f:	e8 fc e5 ff ff       	call   80100370 <panic>
80101d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101d80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	57                   	push   %edi
80101d84:	56                   	push   %esi
80101d85:	53                   	push   %ebx
80101d86:	89 cf                	mov    %ecx,%edi
80101d88:	89 c3                	mov    %eax,%ebx
80101d8a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;
  //cprintf("before dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  if(*path == '/'){
80101d8d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;
  //cprintf("before dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  if(*path == '/'){
80101d93:	0f 84 53 01 00 00    	je     80101eec <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  	//cprintf("get from device1\n");
  }
  else
    ip = idup(myproc()->cwd);
80101d99:	e8 22 1b 00 00       	call   801038c0 <myproc>
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  //cprintf("dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  acquire(&icache.lock);
80101d9e:	83 ec 0c             	sub    $0xc,%esp
  if(*path == '/'){
    ip = iget(ROOTDEV, ROOTINO);
  	//cprintf("get from device1\n");
  }
  else
    ip = idup(myproc()->cwd);
80101da1:	8b 70 68             	mov    0x68(%eax),%esi
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  //cprintf("dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  acquire(&icache.lock);
80101da4:	68 60 71 11 80       	push   $0x80117160
80101da9:	e8 82 28 00 00       	call   80104630 <acquire>
  //
  ip->ref++;
80101dae:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101db2:	c7 04 24 60 71 11 80 	movl   $0x80117160,(%esp)
80101db9:	e8 22 29 00 00       	call   801046e0 <release>
80101dbe:	83 c4 10             	add    $0x10,%esp
80101dc1:	eb 08                	jmp    80101dcb <namex+0x4b>
80101dc3:	90                   	nop
80101dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101dc8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101dcb:	0f b6 03             	movzbl (%ebx),%eax
80101dce:	3c 2f                	cmp    $0x2f,%al
80101dd0:	74 f6                	je     80101dc8 <namex+0x48>
    path++;
  if(*path == 0)
80101dd2:	84 c0                	test   %al,%al
80101dd4:	0f 84 e3 00 00 00    	je     80101ebd <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101dda:	0f b6 03             	movzbl (%ebx),%eax
80101ddd:	89 da                	mov    %ebx,%edx
80101ddf:	84 c0                	test   %al,%al
80101de1:	0f 84 ac 00 00 00    	je     80101e93 <namex+0x113>
80101de7:	3c 2f                	cmp    $0x2f,%al
80101de9:	75 09                	jne    80101df4 <namex+0x74>
80101deb:	e9 a3 00 00 00       	jmp    80101e93 <namex+0x113>
80101df0:	84 c0                	test   %al,%al
80101df2:	74 0a                	je     80101dfe <namex+0x7e>
    path++;
80101df4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101df7:	0f b6 02             	movzbl (%edx),%eax
80101dfa:	3c 2f                	cmp    $0x2f,%al
80101dfc:	75 f2                	jne    80101df0 <namex+0x70>
80101dfe:	89 d1                	mov    %edx,%ecx
80101e00:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101e02:	83 f9 0d             	cmp    $0xd,%ecx
80101e05:	0f 8e 8d 00 00 00    	jle    80101e98 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101e0b:	83 ec 04             	sub    $0x4,%esp
80101e0e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e11:	6a 0e                	push   $0xe
80101e13:	53                   	push   %ebx
80101e14:	57                   	push   %edi
80101e15:	e8 c6 29 00 00       	call   801047e0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101e1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101e1d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101e20:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e22:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e25:	75 11                	jne    80101e38 <namex+0xb8>
80101e27:	89 f6                	mov    %esi,%esi
80101e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e30:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e36:	74 f8                	je     80101e30 <namex+0xb0>
  else
    ip = idup(myproc()->cwd);
  //cprintf("dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  while((path = skipelem(path, name)) != 0){
//cprintf("path: %s\n", path);
    ilock(ip);
80101e38:	83 ec 0c             	sub    $0xc,%esp
80101e3b:	56                   	push   %esi
80101e3c:	e8 bf f8 ff ff       	call   80101700 <ilock>
    if(ip->type != T_DIR){
80101e41:	83 c4 10             	add    $0x10,%esp
80101e44:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e49:	0f 85 7f 00 00 00    	jne    80101ece <namex+0x14e>
	//cprintf("testing\n");
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e52:	85 d2                	test   %edx,%edx
80101e54:	74 09                	je     80101e5f <namex+0xdf>
80101e56:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e59:	0f 84 a3 00 00 00    	je     80101f02 <namex+0x182>
	//cprintf("testing1\n");
      iunlock(ip);
      return ip;
    }
	//cprintf("name:  %s\n", name);
    if((next = dirlookup(ip, name, 0)) == 0){
80101e5f:	83 ec 04             	sub    $0x4,%esp
80101e62:	6a 00                	push   $0x0
80101e64:	57                   	push   %edi
80101e65:	56                   	push   %esi
80101e66:	e8 55 fe ff ff       	call   80101cc0 <dirlookup>
80101e6b:	83 c4 10             	add    $0x10,%esp
80101e6e:	85 c0                	test   %eax,%eax
80101e70:	74 5c                	je     80101ece <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101e72:	83 ec 0c             	sub    $0xc,%esp
80101e75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e78:	56                   	push   %esi
80101e79:	e8 92 f9 ff ff       	call   80101810 <iunlock>
  iput(ip);
80101e7e:	89 34 24             	mov    %esi,(%esp)
80101e81:	e8 da f9 ff ff       	call   80101860 <iput>
80101e86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e89:	83 c4 10             	add    $0x10,%esp
80101e8c:	89 c6                	mov    %eax,%esi
80101e8e:	e9 38 ff ff ff       	jmp    80101dcb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e93:	31 c9                	xor    %ecx,%ecx
80101e95:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101e98:	83 ec 04             	sub    $0x4,%esp
80101e9b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e9e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ea1:	51                   	push   %ecx
80101ea2:	53                   	push   %ebx
80101ea3:	57                   	push   %edi
80101ea4:	e8 37 29 00 00       	call   801047e0 <memmove>
    name[len] = 0;
80101ea9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101eac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101eaf:	83 c4 10             	add    $0x10,%esp
80101eb2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101eb6:	89 d3                	mov    %edx,%ebx
80101eb8:	e9 65 ff ff ff       	jmp    80101e22 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ebd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ec0:	85 c0                	test   %eax,%eax
80101ec2:	75 54                	jne    80101f18 <namex+0x198>
80101ec4:	89 f0                	mov    %esi,%eax
	//cprintf("testing3\n");
    iput(ip);
    return 0;
  }
  return ip;
}
80101ec6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec9:	5b                   	pop    %ebx
80101eca:	5e                   	pop    %esi
80101ecb:	5f                   	pop    %edi
80101ecc:	5d                   	pop    %ebp
80101ecd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101ece:	83 ec 0c             	sub    $0xc,%esp
80101ed1:	56                   	push   %esi
80101ed2:	e8 39 f9 ff ff       	call   80101810 <iunlock>
  iput(ip);
80101ed7:	89 34 24             	mov    %esi,(%esp)
80101eda:	e8 81 f9 ff ff       	call   80101860 <iput>
    }
	//cprintf("name:  %s\n", name);
    if((next = dirlookup(ip, name, 0)) == 0){
	//cprintf("testing2\n");
      iunlockput(ip);
      return 0;
80101edf:	83 c4 10             	add    $0x10,%esp
	//cprintf("testing3\n");
    iput(ip);
    return 0;
  }
  return ip;
}
80101ee2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    }
	//cprintf("name:  %s\n", name);
    if((next = dirlookup(ip, name, 0)) == 0){
	//cprintf("testing2\n");
      iunlockput(ip);
      return 0;
80101ee5:	31 c0                	xor    %eax,%eax
	//cprintf("testing3\n");
    iput(ip);
    return 0;
  }
  return ip;
}
80101ee7:	5b                   	pop    %ebx
80101ee8:	5e                   	pop    %esi
80101ee9:	5f                   	pop    %edi
80101eea:	5d                   	pop    %ebp
80101eeb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;
  //cprintf("before dev: %d\ninum:: %d\n",ip->dev,ip->inum);
  if(*path == '/'){
    ip = iget(ROOTDEV, ROOTINO);
80101eec:	ba 01 00 00 00       	mov    $0x1,%edx
80101ef1:	b8 01 00 00 00       	mov    $0x1,%eax
80101ef6:	e8 75 f3 ff ff       	call   80101270 <iget>
80101efb:	89 c6                	mov    %eax,%esi
80101efd:	e9 c9 fe ff ff       	jmp    80101dcb <namex+0x4b>
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
	//cprintf("testing1\n");
      iunlock(ip);
80101f02:	83 ec 0c             	sub    $0xc,%esp
80101f05:	56                   	push   %esi
80101f06:	e8 05 f9 ff ff       	call   80101810 <iunlock>
      return ip;
80101f0b:	83 c4 10             	add    $0x10,%esp
	//cprintf("testing3\n");
    iput(ip);
    return 0;
  }
  return ip;
}
80101f0e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
	//cprintf("testing1\n");
      iunlock(ip);
      return ip;
80101f11:	89 f0                	mov    %esi,%eax
	//cprintf("testing3\n");
    iput(ip);
    return 0;
  }
  return ip;
}
80101f13:	5b                   	pop    %ebx
80101f14:	5e                   	pop    %esi
80101f15:	5f                   	pop    %edi
80101f16:	5d                   	pop    %ebp
80101f17:	c3                   	ret    
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
	//cprintf("testing3\n");
    iput(ip);
80101f18:	83 ec 0c             	sub    $0xc,%esp
80101f1b:	56                   	push   %esi
80101f1c:	e8 3f f9 ff ff       	call   80101860 <iput>
    return 0;
80101f21:	83 c4 10             	add    $0x10,%esp
80101f24:	31 c0                	xor    %eax,%eax
80101f26:	eb 9e                	jmp    80101ec6 <namex+0x146>
80101f28:	90                   	nop
80101f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101f30 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101f30:	55                   	push   %ebp
80101f31:	89 e5                	mov    %esp,%ebp
80101f33:	57                   	push   %edi
80101f34:	56                   	push   %esi
80101f35:	53                   	push   %ebx
80101f36:	83 ec 20             	sub    $0x20,%esp
80101f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f3c:	6a 00                	push   $0x0
80101f3e:	ff 75 0c             	pushl  0xc(%ebp)
80101f41:	53                   	push   %ebx
80101f42:	e8 79 fd ff ff       	call   80101cc0 <dirlookup>
80101f47:	83 c4 10             	add    $0x10,%esp
80101f4a:	85 c0                	test   %eax,%eax
80101f4c:	75 72                	jne    80101fc0 <dirlink+0x90>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f4e:	8b bb 18 01 00 00    	mov    0x118(%ebx),%edi
80101f54:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f57:	85 ff                	test   %edi,%edi
80101f59:	74 31                	je     80101f8c <dirlink+0x5c>
80101f5b:	31 ff                	xor    %edi,%edi
80101f5d:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f60:	eb 11                	jmp    80101f73 <dirlink+0x43>
80101f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f68:	83 c7 10             	add    $0x10,%edi
80101f6b:	39 bb 18 01 00 00    	cmp    %edi,0x118(%ebx)
80101f71:	76 19                	jbe    80101f8c <dirlink+0x5c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f73:	6a 10                	push   $0x10
80101f75:	57                   	push   %edi
80101f76:	56                   	push   %esi
80101f77:	53                   	push   %ebx
80101f78:	e8 f3 fa ff ff       	call   80101a70 <readi>
80101f7d:	83 c4 10             	add    $0x10,%esp
80101f80:	83 f8 10             	cmp    $0x10,%eax
80101f83:	75 4e                	jne    80101fd3 <dirlink+0xa3>
      panic("dirlink read");
    if(de.inum == 0)
80101f85:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f8a:	75 dc                	jne    80101f68 <dirlink+0x38>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101f8c:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f8f:	83 ec 04             	sub    $0x4,%esp
80101f92:	6a 0e                	push   $0xe
80101f94:	ff 75 0c             	pushl  0xc(%ebp)
80101f97:	50                   	push   %eax
80101f98:	e8 33 29 00 00       	call   801048d0 <strncpy>
  de.inum = inum;
80101f9d:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fa0:	6a 10                	push   $0x10
80101fa2:	57                   	push   %edi
80101fa3:	56                   	push   %esi
80101fa4:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101fa5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fa9:	e8 c2 fb ff ff       	call   80101b70 <writei>
80101fae:	83 c4 20             	add    $0x20,%esp
80101fb1:	83 f8 10             	cmp    $0x10,%eax
80101fb4:	75 2a                	jne    80101fe0 <dirlink+0xb0>
    panic("dirlink");

  return 0;
80101fb6:	31 c0                	xor    %eax,%eax
}
80101fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fbb:	5b                   	pop    %ebx
80101fbc:	5e                   	pop    %esi
80101fbd:	5f                   	pop    %edi
80101fbe:	5d                   	pop    %ebp
80101fbf:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101fc0:	83 ec 0c             	sub    $0xc,%esp
80101fc3:	50                   	push   %eax
80101fc4:	e8 97 f8 ff ff       	call   80101860 <iput>
    return -1;
80101fc9:	83 c4 10             	add    $0x10,%esp
80101fcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101fd1:	eb e5                	jmp    80101fb8 <dirlink+0x88>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101fd3:	83 ec 0c             	sub    $0xc,%esp
80101fd6:	68 48 77 10 80       	push   $0x80107748
80101fdb:	e8 90 e3 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101fe0:	83 ec 0c             	sub    $0xc,%esp
80101fe3:	68 b2 7d 10 80       	push   $0x80107db2
80101fe8:	e8 83 e3 ff ff       	call   80100370 <panic>
80101fed:	8d 76 00             	lea    0x0(%esi),%esi

80101ff0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101ff0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ff1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101ff3:	89 e5                	mov    %esp,%ebp
80101ff5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80101ffb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101ffe:	e8 7d fd ff ff       	call   80101d80 <namex>
}
80102003:	c9                   	leave  
80102004:	c3                   	ret    
80102005:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102010:	55                   	push   %ebp
  return namex(path, 1, name);
80102011:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102016:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102018:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010201b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010201e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010201f:	e9 5c fd ff ff       	jmp    80101d80 <namex>
80102024:	66 90                	xchg   %ax,%ax
80102026:	66 90                	xchg   %ax,%ax
80102028:	66 90                	xchg   %ax,%ax
8010202a:	66 90                	xchg   %ax,%ax
8010202c:	66 90                	xchg   %ax,%ax
8010202e:	66 90                	xchg   %ax,%ax

80102030 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102030:	55                   	push   %ebp
  if(b == 0)
80102031:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102033:	89 e5                	mov    %esp,%ebp
80102035:	56                   	push   %esi
80102036:	53                   	push   %ebx
  if(b == 0)
80102037:	0f 84 ad 00 00 00    	je     801020ea <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
8010203d:	8b 58 08             	mov    0x8(%eax),%ebx
80102040:	89 c1                	mov    %eax,%ecx
80102042:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102048:	0f 87 8f 00 00 00    	ja     801020dd <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102053:	90                   	nop
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102058:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102059:	83 e0 c0             	and    $0xffffffc0,%eax
8010205c:	3c 40                	cmp    $0x40,%al
8010205e:	75 f8                	jne    80102058 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102060:	31 f6                	xor    %esi,%esi
80102062:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102067:	89 f0                	mov    %esi,%eax
80102069:	ee                   	out    %al,(%dx)
8010206a:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010206f:	b8 01 00 00 00       	mov    $0x1,%eax
80102074:	ee                   	out    %al,(%dx)
80102075:	ba f3 01 00 00       	mov    $0x1f3,%edx
8010207a:	89 d8                	mov    %ebx,%eax
8010207c:	ee                   	out    %al,(%dx)
8010207d:	89 d8                	mov    %ebx,%eax
8010207f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102084:	c1 f8 08             	sar    $0x8,%eax
80102087:	ee                   	out    %al,(%dx)
80102088:	ba f5 01 00 00       	mov    $0x1f5,%edx
8010208d:	89 f0                	mov    %esi,%eax
8010208f:	ee                   	out    %al,(%dx)
80102090:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102094:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102099:	83 e0 01             	and    $0x1,%eax
8010209c:	c1 e0 04             	shl    $0x4,%eax
8010209f:	83 c8 e0             	or     $0xffffffe0,%eax
801020a2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
801020a3:	f6 01 04             	testb  $0x4,(%ecx)
801020a6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ab:	75 13                	jne    801020c0 <idestart+0x90>
801020ad:	b8 20 00 00 00       	mov    $0x20,%eax
801020b2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801020b6:	5b                   	pop    %ebx
801020b7:	5e                   	pop    %esi
801020b8:	5d                   	pop    %ebp
801020b9:	c3                   	ret    
801020ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801020c0:	b8 30 00 00 00       	mov    $0x30,%eax
801020c5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
801020c6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
801020cb:	8d 71 5c             	lea    0x5c(%ecx),%esi
801020ce:	b9 80 00 00 00       	mov    $0x80,%ecx
801020d3:	fc                   	cld    
801020d4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801020d9:	5b                   	pop    %ebx
801020da:	5e                   	pop    %esi
801020db:	5d                   	pop    %ebp
801020dc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
801020dd:	83 ec 0c             	sub    $0xc,%esp
801020e0:	68 b4 77 10 80       	push   $0x801077b4
801020e5:	e8 86 e2 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
801020ea:	83 ec 0c             	sub    $0xc,%esp
801020ed:	68 ab 77 10 80       	push   $0x801077ab
801020f2:	e8 79 e2 ff ff       	call   80100370 <panic>
801020f7:	89 f6                	mov    %esi,%esi
801020f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102100 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102106:	68 c6 77 10 80       	push   $0x801077c6
8010210b:	68 80 b5 10 80       	push   $0x8010b580
80102110:	e8 bb 23 00 00       	call   801044d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102115:	58                   	pop    %eax
80102116:	a1 00 ba 11 80       	mov    0x8011ba00,%eax
8010211b:	5a                   	pop    %edx
8010211c:	83 e8 01             	sub    $0x1,%eax
8010211f:	50                   	push   %eax
80102120:	6a 0e                	push   $0xe
80102122:	e8 a9 02 00 00       	call   801023d0 <ioapicenable>
80102127:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010212a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212f:	90                   	nop
80102130:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102131:	83 e0 c0             	and    $0xffffffc0,%eax
80102134:	3c 40                	cmp    $0x40,%al
80102136:	75 f8                	jne    80102130 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102138:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010213d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102142:	ee                   	out    %al,(%dx)
80102143:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102148:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010214d:	eb 06                	jmp    80102155 <ideinit+0x55>
8010214f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102150:	83 e9 01             	sub    $0x1,%ecx
80102153:	74 0f                	je     80102164 <ideinit+0x64>
80102155:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102156:	84 c0                	test   %al,%al
80102158:	74 f6                	je     80102150 <ideinit+0x50>
      havedisk1 = 1;
8010215a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102161:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102164:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102169:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010216e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010216f:	c9                   	leave  
80102170:	c3                   	ret    
80102171:	eb 0d                	jmp    80102180 <ideintr>
80102173:	90                   	nop
80102174:	90                   	nop
80102175:	90                   	nop
80102176:	90                   	nop
80102177:	90                   	nop
80102178:	90                   	nop
80102179:	90                   	nop
8010217a:	90                   	nop
8010217b:	90                   	nop
8010217c:	90                   	nop
8010217d:	90                   	nop
8010217e:	90                   	nop
8010217f:	90                   	nop

80102180 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	57                   	push   %edi
80102184:	56                   	push   %esi
80102185:	53                   	push   %ebx
80102186:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102189:	68 80 b5 10 80       	push   $0x8010b580
8010218e:	e8 9d 24 00 00       	call   80104630 <acquire>

  if((b = idequeue) == 0){
80102193:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
80102199:	83 c4 10             	add    $0x10,%esp
8010219c:	85 db                	test   %ebx,%ebx
8010219e:	74 34                	je     801021d4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801021a0:	8b 43 58             	mov    0x58(%ebx),%eax
801021a3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801021a8:	8b 33                	mov    (%ebx),%esi
801021aa:	f7 c6 04 00 00 00    	test   $0x4,%esi
801021b0:	74 3e                	je     801021f0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021b2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801021b5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801021b8:	83 ce 02             	or     $0x2,%esi
801021bb:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801021bd:	53                   	push   %ebx
801021be:	e8 ad 1e 00 00       	call   80104070 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021c3:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801021c8:	83 c4 10             	add    $0x10,%esp
801021cb:	85 c0                	test   %eax,%eax
801021cd:	74 05                	je     801021d4 <ideintr+0x54>
    idestart(idequeue);
801021cf:	e8 5c fe ff ff       	call   80102030 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
801021d4:	83 ec 0c             	sub    $0xc,%esp
801021d7:	68 80 b5 10 80       	push   $0x8010b580
801021dc:	e8 ff 24 00 00       	call   801046e0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
801021e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021e4:	5b                   	pop    %ebx
801021e5:	5e                   	pop    %esi
801021e6:	5f                   	pop    %edi
801021e7:	5d                   	pop    %ebp
801021e8:	c3                   	ret    
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021f0:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021f5:	8d 76 00             	lea    0x0(%esi),%esi
801021f8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021f9:	89 c1                	mov    %eax,%ecx
801021fb:	83 e1 c0             	and    $0xffffffc0,%ecx
801021fe:	80 f9 40             	cmp    $0x40,%cl
80102201:	75 f5                	jne    801021f8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102203:	a8 21                	test   $0x21,%al
80102205:	75 ab                	jne    801021b2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102207:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010220a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010220f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102214:	fc                   	cld    
80102215:	f3 6d                	rep insl (%dx),%es:(%edi)
80102217:	8b 33                	mov    (%ebx),%esi
80102219:	eb 97                	jmp    801021b2 <ideintr+0x32>
8010221b:	90                   	nop
8010221c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102220 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102220:	55                   	push   %ebp
80102221:	89 e5                	mov    %esp,%ebp
80102223:	53                   	push   %ebx
80102224:	83 ec 10             	sub    $0x10,%esp
80102227:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010222a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010222d:	50                   	push   %eax
8010222e:	e8 4d 22 00 00       	call   80104480 <holdingsleep>
80102233:	83 c4 10             	add    $0x10,%esp
80102236:	85 c0                	test   %eax,%eax
80102238:	0f 84 ad 00 00 00    	je     801022eb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010223e:	8b 03                	mov    (%ebx),%eax
80102240:	83 e0 06             	and    $0x6,%eax
80102243:	83 f8 02             	cmp    $0x2,%eax
80102246:	0f 84 b9 00 00 00    	je     80102305 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010224c:	8b 53 04             	mov    0x4(%ebx),%edx
8010224f:	85 d2                	test   %edx,%edx
80102251:	74 0d                	je     80102260 <iderw+0x40>
80102253:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102258:	85 c0                	test   %eax,%eax
8010225a:	0f 84 98 00 00 00    	je     801022f8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102260:	83 ec 0c             	sub    $0xc,%esp
80102263:	68 80 b5 10 80       	push   $0x8010b580
80102268:	e8 c3 23 00 00       	call   80104630 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010226d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102273:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102276:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010227d:	85 d2                	test   %edx,%edx
8010227f:	75 09                	jne    8010228a <iderw+0x6a>
80102281:	eb 58                	jmp    801022db <iderw+0xbb>
80102283:	90                   	nop
80102284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102288:	89 c2                	mov    %eax,%edx
8010228a:	8b 42 58             	mov    0x58(%edx),%eax
8010228d:	85 c0                	test   %eax,%eax
8010228f:	75 f7                	jne    80102288 <iderw+0x68>
80102291:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102294:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102296:	3b 1d 64 b5 10 80    	cmp    0x8010b564,%ebx
8010229c:	74 44                	je     801022e2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010229e:	8b 03                	mov    (%ebx),%eax
801022a0:	83 e0 06             	and    $0x6,%eax
801022a3:	83 f8 02             	cmp    $0x2,%eax
801022a6:	74 23                	je     801022cb <iderw+0xab>
801022a8:	90                   	nop
801022a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801022b0:	83 ec 08             	sub    $0x8,%esp
801022b3:	68 80 b5 10 80       	push   $0x8010b580
801022b8:	53                   	push   %ebx
801022b9:	e8 f2 1b 00 00       	call   80103eb0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022be:	8b 03                	mov    (%ebx),%eax
801022c0:	83 c4 10             	add    $0x10,%esp
801022c3:	83 e0 06             	and    $0x6,%eax
801022c6:	83 f8 02             	cmp    $0x2,%eax
801022c9:	75 e5                	jne    801022b0 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801022cb:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801022d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022d5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801022d6:	e9 05 24 00 00       	jmp    801046e0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022db:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
801022e0:	eb b2                	jmp    80102294 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801022e2:	89 d8                	mov    %ebx,%eax
801022e4:	e8 47 fd ff ff       	call   80102030 <idestart>
801022e9:	eb b3                	jmp    8010229e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801022eb:	83 ec 0c             	sub    $0xc,%esp
801022ee:	68 ca 77 10 80       	push   $0x801077ca
801022f3:	e8 78 e0 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801022f8:	83 ec 0c             	sub    $0xc,%esp
801022fb:	68 f5 77 10 80       	push   $0x801077f5
80102300:	e8 6b e0 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102305:	83 ec 0c             	sub    $0xc,%esp
80102308:	68 e0 77 10 80       	push   $0x801077e0
8010230d:	e8 5e e0 ff ff       	call   80100370 <panic>
80102312:	66 90                	xchg   %ax,%ax
80102314:	66 90                	xchg   %ax,%ax
80102316:	66 90                	xchg   %ax,%ax
80102318:	66 90                	xchg   %ax,%ax
8010231a:	66 90                	xchg   %ax,%ax
8010231c:	66 90                	xchg   %ax,%ax
8010231e:	66 90                	xchg   %ax,%ax

80102320 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102320:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102321:	c7 05 34 b3 11 80 00 	movl   $0xfec00000,0x8011b334
80102328:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010232b:	89 e5                	mov    %esp,%ebp
8010232d:	56                   	push   %esi
8010232e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010232f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102336:	00 00 00 
  return ioapic->data;
80102339:	8b 15 34 b3 11 80    	mov    0x8011b334,%edx
8010233f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102342:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102348:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010234e:	0f b6 15 60 b4 11 80 	movzbl 0x8011b460,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102355:	89 f0                	mov    %esi,%eax
80102357:	c1 e8 10             	shr    $0x10,%eax
8010235a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010235d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102360:	c1 e8 18             	shr    $0x18,%eax
80102363:	39 d0                	cmp    %edx,%eax
80102365:	74 16                	je     8010237d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102367:	83 ec 0c             	sub    $0xc,%esp
8010236a:	68 14 78 10 80       	push   $0x80107814
8010236f:	e8 ec e2 ff ff       	call   80100660 <cprintf>
80102374:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
8010237a:	83 c4 10             	add    $0x10,%esp
8010237d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102380:	ba 10 00 00 00       	mov    $0x10,%edx
80102385:	b8 20 00 00 00       	mov    $0x20,%eax
8010238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102390:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102392:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102398:	89 c3                	mov    %eax,%ebx
8010239a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801023a0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023a3:	89 59 10             	mov    %ebx,0x10(%ecx)
801023a6:	8d 5a 01             	lea    0x1(%edx),%ebx
801023a9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023ac:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023ae:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801023b0:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
801023b6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023bd:	75 d1                	jne    80102390 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801023bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023c2:	5b                   	pop    %ebx
801023c3:	5e                   	pop    %esi
801023c4:	5d                   	pop    %ebp
801023c5:	c3                   	ret    
801023c6:	8d 76 00             	lea    0x0(%esi),%esi
801023c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023d0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023d1:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801023d7:	89 e5                	mov    %esp,%ebp
801023d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023dc:	8d 50 20             	lea    0x20(%eax),%edx
801023df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023e5:	8b 0d 34 b3 11 80    	mov    0x8011b334,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801023ee:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023f1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801023f6:	a1 34 b3 11 80       	mov    0x8011b334,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023fb:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023fe:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102401:	5d                   	pop    %ebp
80102402:	c3                   	ret    
80102403:	66 90                	xchg   %ax,%ax
80102405:	66 90                	xchg   %ax,%ax
80102407:	66 90                	xchg   %ax,%ax
80102409:	66 90                	xchg   %ax,%ax
8010240b:	66 90                	xchg   %ax,%ax
8010240d:	66 90                	xchg   %ax,%ax
8010240f:	90                   	nop

80102410 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	53                   	push   %ebx
80102414:	83 ec 04             	sub    $0x4,%esp
80102417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010241a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102420:	75 70                	jne    80102492 <kfree+0x82>
80102422:	81 fb a8 f9 11 80    	cmp    $0x8011f9a8,%ebx
80102428:	72 68                	jb     80102492 <kfree+0x82>
8010242a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102430:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102435:	77 5b                	ja     80102492 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102437:	83 ec 04             	sub    $0x4,%esp
8010243a:	68 00 10 00 00       	push   $0x1000
8010243f:	6a 01                	push   $0x1
80102441:	53                   	push   %ebx
80102442:	e8 e9 22 00 00       	call   80104730 <memset>

  if(kmem.use_lock)
80102447:	8b 15 74 b3 11 80    	mov    0x8011b374,%edx
8010244d:	83 c4 10             	add    $0x10,%esp
80102450:	85 d2                	test   %edx,%edx
80102452:	75 2c                	jne    80102480 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102454:	a1 78 b3 11 80       	mov    0x8011b378,%eax
80102459:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010245b:	a1 74 b3 11 80       	mov    0x8011b374,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102460:	89 1d 78 b3 11 80    	mov    %ebx,0x8011b378
  if(kmem.use_lock)
80102466:	85 c0                	test   %eax,%eax
80102468:	75 06                	jne    80102470 <kfree+0x60>
    release(&kmem.lock);
}
8010246a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010246d:	c9                   	leave  
8010246e:	c3                   	ret    
8010246f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102470:	c7 45 08 40 b3 11 80 	movl   $0x8011b340,0x8(%ebp)
}
80102477:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010247a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010247b:	e9 60 22 00 00       	jmp    801046e0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102480:	83 ec 0c             	sub    $0xc,%esp
80102483:	68 40 b3 11 80       	push   $0x8011b340
80102488:	e8 a3 21 00 00       	call   80104630 <acquire>
8010248d:	83 c4 10             	add    $0x10,%esp
80102490:	eb c2                	jmp    80102454 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102492:	83 ec 0c             	sub    $0xc,%esp
80102495:	68 46 78 10 80       	push   $0x80107846
8010249a:	e8 d1 de ff ff       	call   80100370 <panic>
8010249f:	90                   	nop

801024a0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024a5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801024a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024bd:	39 de                	cmp    %ebx,%esi
801024bf:	72 23                	jb     801024e4 <freerange+0x44>
801024c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024c8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ce:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024d7:	50                   	push   %eax
801024d8:	e8 33 ff ff ff       	call   80102410 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024dd:	83 c4 10             	add    $0x10,%esp
801024e0:	39 f3                	cmp    %esi,%ebx
801024e2:	76 e4                	jbe    801024c8 <freerange+0x28>
    kfree(p);
}
801024e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e7:	5b                   	pop    %ebx
801024e8:	5e                   	pop    %esi
801024e9:	5d                   	pop    %ebp
801024ea:	c3                   	ret    
801024eb:	90                   	nop
801024ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801024f0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	56                   	push   %esi
801024f4:	53                   	push   %ebx
801024f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801024f8:	83 ec 08             	sub    $0x8,%esp
801024fb:	68 4c 78 10 80       	push   $0x8010784c
80102500:	68 40 b3 11 80       	push   $0x8011b340
80102505:	e8 c6 1f 00 00       	call   801044d0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010250a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010250d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102510:	c7 05 74 b3 11 80 00 	movl   $0x0,0x8011b374
80102517:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010251a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102520:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102526:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010252c:	39 de                	cmp    %ebx,%esi
8010252e:	72 1c                	jb     8010254c <kinit1+0x5c>
    kfree(p);
80102530:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102536:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102539:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010253f:	50                   	push   %eax
80102540:	e8 cb fe ff ff       	call   80102410 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102545:	83 c4 10             	add    $0x10,%esp
80102548:	39 de                	cmp    %ebx,%esi
8010254a:	73 e4                	jae    80102530 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010254c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010254f:	5b                   	pop    %ebx
80102550:	5e                   	pop    %esi
80102551:	5d                   	pop    %ebp
80102552:	c3                   	ret    
80102553:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102560 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
80102564:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102565:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102568:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <kinit2+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010258e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 73 fe ff ff       	call   80102410 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 de                	cmp    %ebx,%esi
801025a2:	73 e4                	jae    80102588 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801025a4:	c7 05 74 b3 11 80 01 	movl   $0x1,0x8011b374
801025ab:	00 00 00 
}
801025ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025b1:	5b                   	pop    %ebx
801025b2:	5e                   	pop    %esi
801025b3:	5d                   	pop    %ebp
801025b4:	c3                   	ret    
801025b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025c0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801025c0:	55                   	push   %ebp
801025c1:	89 e5                	mov    %esp,%ebp
801025c3:	53                   	push   %ebx
801025c4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801025c7:	a1 74 b3 11 80       	mov    0x8011b374,%eax
801025cc:	85 c0                	test   %eax,%eax
801025ce:	75 30                	jne    80102600 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801025d0:	8b 1d 78 b3 11 80    	mov    0x8011b378,%ebx
  if(r)
801025d6:	85 db                	test   %ebx,%ebx
801025d8:	74 1c                	je     801025f6 <kalloc+0x36>
    kmem.freelist = r->next;
801025da:	8b 13                	mov    (%ebx),%edx
801025dc:	89 15 78 b3 11 80    	mov    %edx,0x8011b378
  if(kmem.use_lock)
801025e2:	85 c0                	test   %eax,%eax
801025e4:	74 10                	je     801025f6 <kalloc+0x36>
    release(&kmem.lock);
801025e6:	83 ec 0c             	sub    $0xc,%esp
801025e9:	68 40 b3 11 80       	push   $0x8011b340
801025ee:	e8 ed 20 00 00       	call   801046e0 <release>
801025f3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801025f6:	89 d8                	mov    %ebx,%eax
801025f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025fb:	c9                   	leave  
801025fc:	c3                   	ret    
801025fd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102600:	83 ec 0c             	sub    $0xc,%esp
80102603:	68 40 b3 11 80       	push   $0x8011b340
80102608:	e8 23 20 00 00       	call   80104630 <acquire>
  r = kmem.freelist;
8010260d:	8b 1d 78 b3 11 80    	mov    0x8011b378,%ebx
  if(r)
80102613:	83 c4 10             	add    $0x10,%esp
80102616:	a1 74 b3 11 80       	mov    0x8011b374,%eax
8010261b:	85 db                	test   %ebx,%ebx
8010261d:	75 bb                	jne    801025da <kalloc+0x1a>
8010261f:	eb c1                	jmp    801025e2 <kalloc+0x22>
80102621:	66 90                	xchg   %ax,%ax
80102623:	66 90                	xchg   %ax,%ax
80102625:	66 90                	xchg   %ax,%ax
80102627:	66 90                	xchg   %ax,%ax
80102629:	66 90                	xchg   %ax,%ax
8010262b:	66 90                	xchg   %ax,%ax
8010262d:	66 90                	xchg   %ax,%ax
8010262f:	90                   	nop

80102630 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102630:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102631:	ba 64 00 00 00       	mov    $0x64,%edx
80102636:	89 e5                	mov    %esp,%ebp
80102638:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102639:	a8 01                	test   $0x1,%al
8010263b:	0f 84 af 00 00 00    	je     801026f0 <kbdgetc+0xc0>
80102641:	ba 60 00 00 00       	mov    $0x60,%edx
80102646:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102647:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010264a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102650:	74 7e                	je     801026d0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102652:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102654:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010265a:	79 24                	jns    80102680 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010265c:	f6 c1 40             	test   $0x40,%cl
8010265f:	75 05                	jne    80102666 <kbdgetc+0x36>
80102661:	89 c2                	mov    %eax,%edx
80102663:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102666:	0f b6 82 80 79 10 80 	movzbl -0x7fef8680(%edx),%eax
8010266d:	83 c8 40             	or     $0x40,%eax
80102670:	0f b6 c0             	movzbl %al,%eax
80102673:	f7 d0                	not    %eax
80102675:	21 c8                	and    %ecx,%eax
80102677:	a3 b4 b5 10 80       	mov    %eax,0x8010b5b4
    return 0;
8010267c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010267e:	5d                   	pop    %ebp
8010267f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102680:	f6 c1 40             	test   $0x40,%cl
80102683:	74 09                	je     8010268e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102685:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102688:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010268b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010268e:	0f b6 82 80 79 10 80 	movzbl -0x7fef8680(%edx),%eax
80102695:	09 c1                	or     %eax,%ecx
80102697:	0f b6 82 80 78 10 80 	movzbl -0x7fef8780(%edx),%eax
8010269e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801026a0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801026a2:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801026a8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801026ab:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801026ae:	8b 04 85 60 78 10 80 	mov    -0x7fef87a0(,%eax,4),%eax
801026b5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801026b9:	74 c3                	je     8010267e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801026bb:	8d 50 9f             	lea    -0x61(%eax),%edx
801026be:	83 fa 19             	cmp    $0x19,%edx
801026c1:	77 1d                	ja     801026e0 <kbdgetc+0xb0>
      c += 'A' - 'a';
801026c3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026c6:	5d                   	pop    %ebp
801026c7:	c3                   	ret    
801026c8:	90                   	nop
801026c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801026d0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801026d2:	83 0d b4 b5 10 80 40 	orl    $0x40,0x8010b5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026d9:	5d                   	pop    %ebp
801026da:	c3                   	ret    
801026db:	90                   	nop
801026dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801026e0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801026e3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801026e6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801026e7:	83 f9 19             	cmp    $0x19,%ecx
801026ea:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801026ed:	c3                   	ret    
801026ee:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801026f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801026f5:	5d                   	pop    %ebp
801026f6:	c3                   	ret    
801026f7:	89 f6                	mov    %esi,%esi
801026f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102700 <kbdintr>:

void
kbdintr(void)
{
80102700:	55                   	push   %ebp
80102701:	89 e5                	mov    %esp,%ebp
80102703:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102706:	68 30 26 10 80       	push   $0x80102630
8010270b:	e8 e0 e0 ff ff       	call   801007f0 <consoleintr>
}
80102710:	83 c4 10             	add    $0x10,%esp
80102713:	c9                   	leave  
80102714:	c3                   	ret    
80102715:	66 90                	xchg   %ax,%ax
80102717:	66 90                	xchg   %ax,%ax
80102719:	66 90                	xchg   %ax,%ax
8010271b:	66 90                	xchg   %ax,%ax
8010271d:	66 90                	xchg   %ax,%ax
8010271f:	90                   	nop

80102720 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102720:	a1 7c b3 11 80       	mov    0x8011b37c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102725:	55                   	push   %ebp
80102726:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102728:	85 c0                	test   %eax,%eax
8010272a:	0f 84 c8 00 00 00    	je     801027f8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102730:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102737:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010273d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102744:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102747:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010274a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102751:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102754:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102757:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010275e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102761:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102764:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010276b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010276e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102771:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102778:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010277b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010277e:	8b 50 30             	mov    0x30(%eax),%edx
80102781:	c1 ea 10             	shr    $0x10,%edx
80102784:	80 fa 03             	cmp    $0x3,%dl
80102787:	77 77                	ja     80102800 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102789:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102790:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102793:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102796:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010279d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027a0:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027a3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801027aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ad:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027b0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027b7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027ba:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027bd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801027c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027ca:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801027d1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
801027d7:	89 f6                	mov    %esi,%esi
801027d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801027e0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801027e6:	80 e6 10             	and    $0x10,%dh
801027e9:	75 f5                	jne    801027e0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027eb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801027f2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801027f8:	5d                   	pop    %ebp
801027f9:	c3                   	ret    
801027fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102800:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102807:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010280a:	8b 50 20             	mov    0x20(%eax),%edx
8010280d:	e9 77 ff ff ff       	jmp    80102789 <lapicinit+0x69>
80102812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80102820:	a1 7c b3 11 80       	mov    0x8011b37c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80102825:	55                   	push   %ebp
80102826:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102828:	85 c0                	test   %eax,%eax
8010282a:	74 0c                	je     80102838 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010282c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010282f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80102830:	c1 e8 18             	shr    $0x18,%eax
}
80102833:	c3                   	ret    
80102834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80102838:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010283a:	5d                   	pop    %ebp
8010283b:	c3                   	ret    
8010283c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102840 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102840:	a1 7c b3 11 80       	mov    0x8011b37c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102845:	55                   	push   %ebp
80102846:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102848:	85 c0                	test   %eax,%eax
8010284a:	74 0d                	je     80102859 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010284c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102853:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102856:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102859:	5d                   	pop    %ebp
8010285a:	c3                   	ret    
8010285b:	90                   	nop
8010285c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102860 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
}
80102863:	5d                   	pop    %ebp
80102864:	c3                   	ret    
80102865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102870 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102870:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102871:	ba 70 00 00 00       	mov    $0x70,%edx
80102876:	b8 0f 00 00 00       	mov    $0xf,%eax
8010287b:	89 e5                	mov    %esp,%ebp
8010287d:	53                   	push   %ebx
8010287e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102881:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102884:	ee                   	out    %al,(%dx)
80102885:	ba 71 00 00 00       	mov    $0x71,%edx
8010288a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010288f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102890:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102892:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102895:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010289b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010289d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801028a0:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a3:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801028a5:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
801028a8:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028ae:	a1 7c b3 11 80       	mov    0x8011b37c,%eax
801028b3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b9:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028bc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801028c3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028d0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028d6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028dc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028df:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028e5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028e8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ee:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028f1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028f7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028fa:	5b                   	pop    %ebx
801028fb:	5d                   	pop    %ebp
801028fc:	c3                   	ret    
801028fd:	8d 76 00             	lea    0x0(%esi),%esi

80102900 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102900:	55                   	push   %ebp
80102901:	ba 70 00 00 00       	mov    $0x70,%edx
80102906:	b8 0b 00 00 00       	mov    $0xb,%eax
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	57                   	push   %edi
8010290e:	56                   	push   %esi
8010290f:	53                   	push   %ebx
80102910:	83 ec 4c             	sub    $0x4c,%esp
80102913:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102914:	ba 71 00 00 00       	mov    $0x71,%edx
80102919:	ec                   	in     (%dx),%al
8010291a:	83 e0 04             	and    $0x4,%eax
8010291d:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102920:	31 db                	xor    %ebx,%ebx
80102922:	88 45 b7             	mov    %al,-0x49(%ebp)
80102925:	bf 70 00 00 00       	mov    $0x70,%edi
8010292a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102930:	89 d8                	mov    %ebx,%eax
80102932:	89 fa                	mov    %edi,%edx
80102934:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102935:	b9 71 00 00 00       	mov    $0x71,%ecx
8010293a:	89 ca                	mov    %ecx,%edx
8010293c:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010293d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102940:	89 fa                	mov    %edi,%edx
80102942:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102945:	b8 02 00 00 00       	mov    $0x2,%eax
8010294a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294b:	89 ca                	mov    %ecx,%edx
8010294d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010294e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102951:	89 fa                	mov    %edi,%edx
80102953:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102956:	b8 04 00 00 00       	mov    $0x4,%eax
8010295b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295c:	89 ca                	mov    %ecx,%edx
8010295e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010295f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102962:	89 fa                	mov    %edi,%edx
80102964:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102967:	b8 07 00 00 00       	mov    $0x7,%eax
8010296c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296d:	89 ca                	mov    %ecx,%edx
8010296f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102970:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102973:	89 fa                	mov    %edi,%edx
80102975:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102978:	b8 08 00 00 00       	mov    $0x8,%eax
8010297d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297e:	89 ca                	mov    %ecx,%edx
80102980:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102981:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102984:	89 fa                	mov    %edi,%edx
80102986:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102989:	b8 09 00 00 00       	mov    $0x9,%eax
8010298e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298f:	89 ca                	mov    %ecx,%edx
80102991:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102992:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102995:	89 fa                	mov    %edi,%edx
80102997:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010299a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010299f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a0:	89 ca                	mov    %ecx,%edx
801029a2:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801029a3:	84 c0                	test   %al,%al
801029a5:	78 89                	js     80102930 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a7:	89 d8                	mov    %ebx,%eax
801029a9:	89 fa                	mov    %edi,%edx
801029ab:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ac:	89 ca                	mov    %ecx,%edx
801029ae:	ec                   	in     (%dx),%al
}

static void
fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801029af:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b2:	89 fa                	mov    %edi,%edx
801029b4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801029b7:	b8 02 00 00 00       	mov    $0x2,%eax
801029bc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	89 ca                	mov    %ecx,%edx
801029bf:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801029c0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c3:	89 fa                	mov    %edi,%edx
801029c5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801029c8:	b8 04 00 00 00       	mov    $0x4,%eax
801029cd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ce:	89 ca                	mov    %ecx,%edx
801029d0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801029d1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d4:	89 fa                	mov    %edi,%edx
801029d6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029d9:	b8 07 00 00 00       	mov    $0x7,%eax
801029de:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029df:	89 ca                	mov    %ecx,%edx
801029e1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801029e2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e5:	89 fa                	mov    %edi,%edx
801029e7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ea:	b8 08 00 00 00       	mov    $0x8,%eax
801029ef:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029f0:	89 ca                	mov    %ecx,%edx
801029f2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801029f3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f6:	89 fa                	mov    %edi,%edx
801029f8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029fb:	b8 09 00 00 00       	mov    $0x9,%eax
80102a00:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a01:	89 ca                	mov    %ecx,%edx
80102a03:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102a04:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a07:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
80102a0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102a0d:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102a10:	6a 18                	push   $0x18
80102a12:	56                   	push   %esi
80102a13:	50                   	push   %eax
80102a14:	e8 67 1d 00 00       	call   80104780 <memcmp>
80102a19:	83 c4 10             	add    $0x10,%esp
80102a1c:	85 c0                	test   %eax,%eax
80102a1e:	0f 85 0c ff ff ff    	jne    80102930 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102a24:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102a28:	75 78                	jne    80102aa2 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102a2a:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a2d:	89 c2                	mov    %eax,%edx
80102a2f:	83 e0 0f             	and    $0xf,%eax
80102a32:	c1 ea 04             	shr    $0x4,%edx
80102a35:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a38:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a3e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a41:	89 c2                	mov    %eax,%edx
80102a43:	83 e0 0f             	and    $0xf,%eax
80102a46:	c1 ea 04             	shr    $0x4,%edx
80102a49:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a52:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a55:	89 c2                	mov    %eax,%edx
80102a57:	83 e0 0f             	and    $0xf,%eax
80102a5a:	c1 ea 04             	shr    $0x4,%edx
80102a5d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a60:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a63:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a66:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a69:	89 c2                	mov    %eax,%edx
80102a6b:	83 e0 0f             	and    $0xf,%eax
80102a6e:	c1 ea 04             	shr    $0x4,%edx
80102a71:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a74:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a77:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a7a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a7d:	89 c2                	mov    %eax,%edx
80102a7f:	83 e0 0f             	and    $0xf,%eax
80102a82:	c1 ea 04             	shr    $0x4,%edx
80102a85:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a88:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a8b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a8e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a91:	89 c2                	mov    %eax,%edx
80102a93:	83 e0 0f             	and    $0xf,%eax
80102a96:	c1 ea 04             	shr    $0x4,%edx
80102a99:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a9c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a9f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102aa2:	8b 75 08             	mov    0x8(%ebp),%esi
80102aa5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102aa8:	89 06                	mov    %eax,(%esi)
80102aaa:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102aad:	89 46 04             	mov    %eax,0x4(%esi)
80102ab0:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ab3:	89 46 08             	mov    %eax,0x8(%esi)
80102ab6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ab9:	89 46 0c             	mov    %eax,0xc(%esi)
80102abc:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102abf:	89 46 10             	mov    %eax,0x10(%esi)
80102ac2:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ac5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ac8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102acf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ad2:	5b                   	pop    %ebx
80102ad3:	5e                   	pop    %esi
80102ad4:	5f                   	pop    %edi
80102ad5:	5d                   	pop    %ebp
80102ad6:	c3                   	ret    
80102ad7:	66 90                	xchg   %ax,%ax
80102ad9:	66 90                	xchg   %ax,%ax
80102adb:	66 90                	xchg   %ax,%ax
80102add:	66 90                	xchg   %ax,%ax
80102adf:	90                   	nop

80102ae0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ae0:	8b 0d c8 b3 11 80    	mov    0x8011b3c8,%ecx
80102ae6:	85 c9                	test   %ecx,%ecx
80102ae8:	0f 8e 85 00 00 00    	jle    80102b73 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102aee:	55                   	push   %ebp
80102aef:	89 e5                	mov    %esp,%ebp
80102af1:	57                   	push   %edi
80102af2:	56                   	push   %esi
80102af3:	53                   	push   %ebx
80102af4:	31 db                	xor    %ebx,%ebx
80102af6:	83 ec 0c             	sub    $0xc,%esp
80102af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102b00:	a1 b4 b3 11 80       	mov    0x8011b3b4,%eax
80102b05:	83 ec 08             	sub    $0x8,%esp
80102b08:	01 d8                	add    %ebx,%eax
80102b0a:	83 c0 01             	add    $0x1,%eax
80102b0d:	50                   	push   %eax
80102b0e:	ff 35 c4 b3 11 80    	pushl  0x8011b3c4
80102b14:	e8 b7 d5 ff ff       	call   801000d0 <bread>
80102b19:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b1b:	58                   	pop    %eax
80102b1c:	5a                   	pop    %edx
80102b1d:	ff 34 9d cc b3 11 80 	pushl  -0x7fee4c34(,%ebx,4)
80102b24:	ff 35 c4 b3 11 80    	pushl  0x8011b3c4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b2a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102b2d:	e8 9e d5 ff ff       	call   801000d0 <bread>
80102b32:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b34:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b37:	83 c4 0c             	add    $0xc,%esp
80102b3a:	68 00 02 00 00       	push   $0x200
80102b3f:	50                   	push   %eax
80102b40:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b43:	50                   	push   %eax
80102b44:	e8 97 1c 00 00       	call   801047e0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b49:	89 34 24             	mov    %esi,(%esp)
80102b4c:	e8 4f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b51:	89 3c 24             	mov    %edi,(%esp)
80102b54:	e8 87 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b59:	89 34 24             	mov    %esi,(%esp)
80102b5c:	e8 7f d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b61:	83 c4 10             	add    $0x10,%esp
80102b64:	39 1d c8 b3 11 80    	cmp    %ebx,0x8011b3c8
80102b6a:	7f 94                	jg     80102b00 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b6f:	5b                   	pop    %ebx
80102b70:	5e                   	pop    %esi
80102b71:	5f                   	pop    %edi
80102b72:	5d                   	pop    %ebp
80102b73:	f3 c3                	repz ret 
80102b75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b80 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	53                   	push   %ebx
80102b84:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b87:	ff 35 b4 b3 11 80    	pushl  0x8011b3b4
80102b8d:	ff 35 c4 b3 11 80    	pushl  0x8011b3c4
80102b93:	e8 38 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b98:	8b 0d c8 b3 11 80    	mov    0x8011b3c8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b9e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102ba1:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ba3:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ba5:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ba8:	7e 1f                	jle    80102bc9 <write_head+0x49>
80102baa:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102bb1:	31 d2                	xor    %edx,%edx
80102bb3:	90                   	nop
80102bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102bb8:	8b 8a cc b3 11 80    	mov    -0x7fee4c34(%edx),%ecx
80102bbe:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102bc2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102bc5:	39 c2                	cmp    %eax,%edx
80102bc7:	75 ef                	jne    80102bb8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102bc9:	83 ec 0c             	sub    $0xc,%esp
80102bcc:	53                   	push   %ebx
80102bcd:	e8 ce d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102bd2:	89 1c 24             	mov    %ebx,(%esp)
80102bd5:	e8 06 d6 ff ff       	call   801001e0 <brelse>
}
80102bda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bdd:	c9                   	leave  
80102bde:	c3                   	ret    
80102bdf:	90                   	nop

80102be0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	53                   	push   %ebx
80102be4:	83 ec 2c             	sub    $0x2c,%esp
80102be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102bea:	68 80 7a 10 80       	push   $0x80107a80
80102bef:	68 80 b3 11 80       	push   $0x8011b380
80102bf4:	e8 d7 18 00 00       	call   801044d0 <initlock>
  readsb(dev, &sb);
80102bf9:	58                   	pop    %eax
80102bfa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bfd:	5a                   	pop    %edx
80102bfe:	50                   	push   %eax
80102bff:	53                   	push   %ebx
80102c00:	e8 0b e8 ff ff       	call   80101410 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c05:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c08:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c0b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102c0c:	89 1d c4 b3 11 80    	mov    %ebx,0x8011b3c4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102c12:	89 15 b8 b3 11 80    	mov    %edx,0x8011b3b8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102c18:	a3 b4 b3 11 80       	mov    %eax,0x8011b3b4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102c1d:	5a                   	pop    %edx
80102c1e:	50                   	push   %eax
80102c1f:	53                   	push   %ebx
80102c20:	e8 ab d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c25:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102c28:	83 c4 10             	add    $0x10,%esp
80102c2b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102c2d:	89 0d c8 b3 11 80    	mov    %ecx,0x8011b3c8
  for (i = 0; i < log.lh.n; i++) {
80102c33:	7e 1c                	jle    80102c51 <initlog+0x71>
80102c35:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102c3c:	31 d2                	xor    %edx,%edx
80102c3e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c40:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c44:	83 c2 04             	add    $0x4,%edx
80102c47:	89 8a c8 b3 11 80    	mov    %ecx,-0x7fee4c38(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c4d:	39 da                	cmp    %ebx,%edx
80102c4f:	75 ef                	jne    80102c40 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	50                   	push   %eax
80102c55:	e8 86 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c5a:	e8 81 fe ff ff       	call   80102ae0 <install_trans>
  log.lh.n = 0;
80102c5f:	c7 05 c8 b3 11 80 00 	movl   $0x0,0x8011b3c8
80102c66:	00 00 00 
  write_head(); // clear the log
80102c69:	e8 12 ff ff ff       	call   80102b80 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c71:	c9                   	leave  
80102c72:	c3                   	ret    
80102c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c86:	68 80 b3 11 80       	push   $0x8011b380
80102c8b:	e8 a0 19 00 00       	call   80104630 <acquire>
80102c90:	83 c4 10             	add    $0x10,%esp
80102c93:	eb 18                	jmp    80102cad <begin_op+0x2d>
80102c95:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c98:	83 ec 08             	sub    $0x8,%esp
80102c9b:	68 80 b3 11 80       	push   $0x8011b380
80102ca0:	68 80 b3 11 80       	push   $0x8011b380
80102ca5:	e8 06 12 00 00       	call   80103eb0 <sleep>
80102caa:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102cad:	a1 c0 b3 11 80       	mov    0x8011b3c0,%eax
80102cb2:	85 c0                	test   %eax,%eax
80102cb4:	75 e2                	jne    80102c98 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102cb6:	a1 bc b3 11 80       	mov    0x8011b3bc,%eax
80102cbb:	8b 15 c8 b3 11 80    	mov    0x8011b3c8,%edx
80102cc1:	83 c0 01             	add    $0x1,%eax
80102cc4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102cc7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102cca:	83 fa 1e             	cmp    $0x1e,%edx
80102ccd:	7f c9                	jg     80102c98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102ccf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102cd2:	a3 bc b3 11 80       	mov    %eax,0x8011b3bc
      release(&log.lock);
80102cd7:	68 80 b3 11 80       	push   $0x8011b380
80102cdc:	e8 ff 19 00 00       	call   801046e0 <release>
      break;
    }
  }
}
80102ce1:	83 c4 10             	add    $0x10,%esp
80102ce4:	c9                   	leave  
80102ce5:	c3                   	ret    
80102ce6:	8d 76 00             	lea    0x0(%esi),%esi
80102ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cf0:	55                   	push   %ebp
80102cf1:	89 e5                	mov    %esp,%ebp
80102cf3:	57                   	push   %edi
80102cf4:	56                   	push   %esi
80102cf5:	53                   	push   %ebx
80102cf6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cf9:	68 80 b3 11 80       	push   $0x8011b380
80102cfe:	e8 2d 19 00 00       	call   80104630 <acquire>
  log.outstanding -= 1;
80102d03:	a1 bc b3 11 80       	mov    0x8011b3bc,%eax
  if(log.committing)
80102d08:	8b 1d c0 b3 11 80    	mov    0x8011b3c0,%ebx
80102d0e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d11:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102d14:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102d16:	a3 bc b3 11 80       	mov    %eax,0x8011b3bc
  if(log.committing)
80102d1b:	0f 85 23 01 00 00    	jne    80102e44 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102d21:	85 c0                	test   %eax,%eax
80102d23:	0f 85 f7 00 00 00    	jne    80102e20 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d29:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102d2c:	c7 05 c0 b3 11 80 01 	movl   $0x1,0x8011b3c0
80102d33:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d36:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102d38:	68 80 b3 11 80       	push   $0x8011b380
80102d3d:	e8 9e 19 00 00       	call   801046e0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d42:	8b 0d c8 b3 11 80    	mov    0x8011b3c8,%ecx
80102d48:	83 c4 10             	add    $0x10,%esp
80102d4b:	85 c9                	test   %ecx,%ecx
80102d4d:	0f 8e 8a 00 00 00    	jle    80102ddd <end_op+0xed>
80102d53:	90                   	nop
80102d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d58:	a1 b4 b3 11 80       	mov    0x8011b3b4,%eax
80102d5d:	83 ec 08             	sub    $0x8,%esp
80102d60:	01 d8                	add    %ebx,%eax
80102d62:	83 c0 01             	add    $0x1,%eax
80102d65:	50                   	push   %eax
80102d66:	ff 35 c4 b3 11 80    	pushl  0x8011b3c4
80102d6c:	e8 5f d3 ff ff       	call   801000d0 <bread>
80102d71:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d73:	58                   	pop    %eax
80102d74:	5a                   	pop    %edx
80102d75:	ff 34 9d cc b3 11 80 	pushl  -0x7fee4c34(,%ebx,4)
80102d7c:	ff 35 c4 b3 11 80    	pushl  0x8011b3c4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d82:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d85:	e8 46 d3 ff ff       	call   801000d0 <bread>
80102d8a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d8c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d8f:	83 c4 0c             	add    $0xc,%esp
80102d92:	68 00 02 00 00       	push   $0x200
80102d97:	50                   	push   %eax
80102d98:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d9b:	50                   	push   %eax
80102d9c:	e8 3f 1a 00 00       	call   801047e0 <memmove>
    bwrite(to);  // write the log
80102da1:	89 34 24             	mov    %esi,(%esp)
80102da4:	e8 f7 d3 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102da9:	89 3c 24             	mov    %edi,(%esp)
80102dac:	e8 2f d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102db1:	89 34 24             	mov    %esi,(%esp)
80102db4:	e8 27 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	3b 1d c8 b3 11 80    	cmp    0x8011b3c8,%ebx
80102dc2:	7c 94                	jl     80102d58 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102dc4:	e8 b7 fd ff ff       	call   80102b80 <write_head>
    install_trans(); // Now install writes to home locations
80102dc9:	e8 12 fd ff ff       	call   80102ae0 <install_trans>
    log.lh.n = 0;
80102dce:	c7 05 c8 b3 11 80 00 	movl   $0x0,0x8011b3c8
80102dd5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102dd8:	e8 a3 fd ff ff       	call   80102b80 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102ddd:	83 ec 0c             	sub    $0xc,%esp
80102de0:	68 80 b3 11 80       	push   $0x8011b380
80102de5:	e8 46 18 00 00       	call   80104630 <acquire>
    log.committing = 0;
    wakeup(&log);
80102dea:	c7 04 24 80 b3 11 80 	movl   $0x8011b380,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102df1:	c7 05 c0 b3 11 80 00 	movl   $0x0,0x8011b3c0
80102df8:	00 00 00 
    wakeup(&log);
80102dfb:	e8 70 12 00 00       	call   80104070 <wakeup>
    release(&log.lock);
80102e00:	c7 04 24 80 b3 11 80 	movl   $0x8011b380,(%esp)
80102e07:	e8 d4 18 00 00       	call   801046e0 <release>
80102e0c:	83 c4 10             	add    $0x10,%esp
  }
}
80102e0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e12:	5b                   	pop    %ebx
80102e13:	5e                   	pop    %esi
80102e14:	5f                   	pop    %edi
80102e15:	5d                   	pop    %ebp
80102e16:	c3                   	ret    
80102e17:	89 f6                	mov    %esi,%esi
80102e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80102e20:	83 ec 0c             	sub    $0xc,%esp
80102e23:	68 80 b3 11 80       	push   $0x8011b380
80102e28:	e8 43 12 00 00       	call   80104070 <wakeup>
  }
  release(&log.lock);
80102e2d:	c7 04 24 80 b3 11 80 	movl   $0x8011b380,(%esp)
80102e34:	e8 a7 18 00 00       	call   801046e0 <release>
80102e39:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102e3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e3f:	5b                   	pop    %ebx
80102e40:	5e                   	pop    %esi
80102e41:	5f                   	pop    %edi
80102e42:	5d                   	pop    %ebp
80102e43:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102e44:	83 ec 0c             	sub    $0xc,%esp
80102e47:	68 84 7a 10 80       	push   $0x80107a84
80102e4c:	e8 1f d5 ff ff       	call   80100370 <panic>
80102e51:	eb 0d                	jmp    80102e60 <log_write>
80102e53:	90                   	nop
80102e54:	90                   	nop
80102e55:	90                   	nop
80102e56:	90                   	nop
80102e57:	90                   	nop
80102e58:	90                   	nop
80102e59:	90                   	nop
80102e5a:	90                   	nop
80102e5b:	90                   	nop
80102e5c:	90                   	nop
80102e5d:	90                   	nop
80102e5e:	90                   	nop
80102e5f:	90                   	nop

80102e60 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e67:	8b 15 c8 b3 11 80    	mov    0x8011b3c8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e6d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e70:	83 fa 1d             	cmp    $0x1d,%edx
80102e73:	0f 8f 97 00 00 00    	jg     80102f10 <log_write+0xb0>
80102e79:	a1 b8 b3 11 80       	mov    0x8011b3b8,%eax
80102e7e:	83 e8 01             	sub    $0x1,%eax
80102e81:	39 c2                	cmp    %eax,%edx
80102e83:	0f 8d 87 00 00 00    	jge    80102f10 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e89:	a1 bc b3 11 80       	mov    0x8011b3bc,%eax
80102e8e:	85 c0                	test   %eax,%eax
80102e90:	0f 8e 87 00 00 00    	jle    80102f1d <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e96:	83 ec 0c             	sub    $0xc,%esp
80102e99:	68 80 b3 11 80       	push   $0x8011b380
80102e9e:	e8 8d 17 00 00       	call   80104630 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102ea3:	8b 15 c8 b3 11 80    	mov    0x8011b3c8,%edx
80102ea9:	83 c4 10             	add    $0x10,%esp
80102eac:	83 fa 00             	cmp    $0x0,%edx
80102eaf:	7e 50                	jle    80102f01 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102eb1:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102eb4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102eb6:	3b 0d cc b3 11 80    	cmp    0x8011b3cc,%ecx
80102ebc:	75 0b                	jne    80102ec9 <log_write+0x69>
80102ebe:	eb 38                	jmp    80102ef8 <log_write+0x98>
80102ec0:	39 0c 85 cc b3 11 80 	cmp    %ecx,-0x7fee4c34(,%eax,4)
80102ec7:	74 2f                	je     80102ef8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102ec9:	83 c0 01             	add    $0x1,%eax
80102ecc:	39 d0                	cmp    %edx,%eax
80102ece:	75 f0                	jne    80102ec0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ed0:	89 0c 95 cc b3 11 80 	mov    %ecx,-0x7fee4c34(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ed7:	83 c2 01             	add    $0x1,%edx
80102eda:	89 15 c8 b3 11 80    	mov    %edx,0x8011b3c8
  b->flags |= B_DIRTY; // prevent eviction
80102ee0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102ee3:	c7 45 08 80 b3 11 80 	movl   $0x8011b380,0x8(%ebp)
}
80102eea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102eed:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102eee:	e9 ed 17 00 00       	jmp    801046e0 <release>
80102ef3:	90                   	nop
80102ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ef8:	89 0c 85 cc b3 11 80 	mov    %ecx,-0x7fee4c34(,%eax,4)
80102eff:	eb df                	jmp    80102ee0 <log_write+0x80>
80102f01:	8b 43 08             	mov    0x8(%ebx),%eax
80102f04:	a3 cc b3 11 80       	mov    %eax,0x8011b3cc
  if (i == log.lh.n)
80102f09:	75 d5                	jne    80102ee0 <log_write+0x80>
80102f0b:	eb ca                	jmp    80102ed7 <log_write+0x77>
80102f0d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102f10:	83 ec 0c             	sub    $0xc,%esp
80102f13:	68 93 7a 10 80       	push   $0x80107a93
80102f18:	e8 53 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102f1d:	83 ec 0c             	sub    $0xc,%esp
80102f20:	68 a9 7a 10 80       	push   $0x80107aa9
80102f25:	e8 46 d4 ff ff       	call   80100370 <panic>
80102f2a:	66 90                	xchg   %ax,%ax
80102f2c:	66 90                	xchg   %ax,%ax
80102f2e:	66 90                	xchg   %ax,%ax

80102f30 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f30:	55                   	push   %ebp
80102f31:	89 e5                	mov    %esp,%ebp
80102f33:	53                   	push   %ebx
80102f34:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102f37:	e8 64 09 00 00       	call   801038a0 <cpuid>
80102f3c:	89 c3                	mov    %eax,%ebx
80102f3e:	e8 5d 09 00 00       	call   801038a0 <cpuid>
80102f43:	83 ec 04             	sub    $0x4,%esp
80102f46:	53                   	push   %ebx
80102f47:	50                   	push   %eax
80102f48:	68 c4 7a 10 80       	push   $0x80107ac4
80102f4d:	e8 0e d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f52:	e8 79 2e 00 00       	call   80105dd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102f57:	e8 c4 08 00 00       	call   80103820 <mycpu>
80102f5c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f5e:	b8 01 00 00 00       	mov    $0x1,%eax
80102f63:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102f6a:	e8 41 0c 00 00       	call   80103bb0 <scheduler>
80102f6f:	90                   	nop

80102f70 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f70:	55                   	push   %ebp
80102f71:	89 e5                	mov    %esp,%ebp
80102f73:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f76:	e8 75 3f 00 00       	call   80106ef0 <switchkvm>
  seginit();
80102f7b:	e8 70 3e 00 00       	call   80106df0 <seginit>
  lapicinit();
80102f80:	e8 9b f7 ff ff       	call   80102720 <lapicinit>
  mpmain();
80102f85:	e8 a6 ff ff ff       	call   80102f30 <mpmain>
80102f8a:	66 90                	xchg   %ax,%ax
80102f8c:	66 90                	xchg   %ax,%ax
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f90:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f94:	83 e4 f0             	and    $0xfffffff0,%esp
80102f97:	ff 71 fc             	pushl  -0x4(%ecx)
80102f9a:	55                   	push   %ebp
80102f9b:	89 e5                	mov    %esp,%ebp
80102f9d:	53                   	push   %ebx
80102f9e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f9f:	bb 80 b4 11 80       	mov    $0x8011b480,%ebx
// doing some setup required for memory allocator to work.
int
main(void)
{
  //initUser();
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102fa4:	83 ec 08             	sub    $0x8,%esp
80102fa7:	68 00 00 40 80       	push   $0x80400000
80102fac:	68 a8 f9 11 80       	push   $0x8011f9a8
80102fb1:	e8 3a f5 ff ff       	call   801024f0 <kinit1>
  kvmalloc();      // kernel page table
80102fb6:	e8 d5 43 00 00       	call   80107390 <kvmalloc>
  mpinit();        // detect other processors
80102fbb:	e8 70 01 00 00       	call   80103130 <mpinit>
  lapicinit();     // interrupt controller
80102fc0:	e8 5b f7 ff ff       	call   80102720 <lapicinit>
  seginit();       // segment descriptors
80102fc5:	e8 26 3e 00 00       	call   80106df0 <seginit>
  picinit();       // disable pic
80102fca:	e8 31 03 00 00       	call   80103300 <picinit>
  ioapicinit();    // another interrupt controller
80102fcf:	e8 4c f3 ff ff       	call   80102320 <ioapicinit>
  consoleinit();   // console hardware
80102fd4:	e8 c7 d9 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102fd9:	e8 e2 30 00 00       	call   801060c0 <uartinit>
  pinit();         // process table
80102fde:	e8 1d 08 00 00       	call   80103800 <pinit>
  tvinit();        // trap vectors
80102fe3:	e8 48 2d 00 00       	call   80105d30 <tvinit>
  binit();         // buffer cache
80102fe8:	e8 53 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fed:	e8 5e dd ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102ff2:	e8 09 f1 ff ff       	call   80102100 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ff7:	83 c4 0c             	add    $0xc,%esp
80102ffa:	68 8a 00 00 00       	push   $0x8a
80102fff:	68 8c b4 10 80       	push   $0x8010b48c
80103004:	68 00 70 00 80       	push   $0x80007000
80103009:	e8 d2 17 00 00       	call   801047e0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010300e:	69 05 00 ba 11 80 b0 	imul   $0xb0,0x8011ba00,%eax
80103015:	00 00 00 
80103018:	83 c4 10             	add    $0x10,%esp
8010301b:	05 80 b4 11 80       	add    $0x8011b480,%eax
80103020:	39 d8                	cmp    %ebx,%eax
80103022:	76 6f                	jbe    80103093 <main+0x103>
80103024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103028:	e8 f3 07 00 00       	call   80103820 <mycpu>
8010302d:	39 d8                	cmp    %ebx,%eax
8010302f:	74 49                	je     8010307a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103031:	e8 8a f5 ff ff       	call   801025c0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103036:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
8010303b:	c7 05 f8 6f 00 80 70 	movl   $0x80102f70,0x80006ff8
80103042:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103045:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010304c:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010304f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103054:	0f b6 03             	movzbl (%ebx),%eax
80103057:	83 ec 08             	sub    $0x8,%esp
8010305a:	68 00 70 00 00       	push   $0x7000
8010305f:	50                   	push   %eax
80103060:	e8 0b f8 ff ff       	call   80102870 <lapicstartap>
80103065:	83 c4 10             	add    $0x10,%esp
80103068:	90                   	nop
80103069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103070:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103076:	85 c0                	test   %eax,%eax
80103078:	74 f6                	je     80103070 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010307a:	69 05 00 ba 11 80 b0 	imul   $0xb0,0x8011ba00,%eax
80103081:	00 00 00 
80103084:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010308a:	05 80 b4 11 80       	add    $0x8011b480,%eax
8010308f:	39 c3                	cmp    %eax,%ebx
80103091:	72 95                	jb     80103028 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103093:	83 ec 08             	sub    $0x8,%esp
80103096:	68 00 00 00 8e       	push   $0x8e000000
8010309b:	68 00 00 40 80       	push   $0x80400000
801030a0:	e8 bb f4 ff ff       	call   80102560 <kinit2>
  userinit();      // first user process
801030a5:	e8 46 08 00 00       	call   801038f0 <userinit>
  mpmain();        // finish this processor's setup
801030aa:	e8 81 fe ff ff       	call   80102f30 <mpmain>
801030af:	90                   	nop

801030b0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030b0:	55                   	push   %ebp
801030b1:	89 e5                	mov    %esp,%ebp
801030b3:	57                   	push   %edi
801030b4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030b5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030bb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801030bc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030bf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030c2:	39 de                	cmp    %ebx,%esi
801030c4:	73 48                	jae    8010310e <mpsearch1+0x5e>
801030c6:	8d 76 00             	lea    0x0(%esi),%esi
801030c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030d0:	83 ec 04             	sub    $0x4,%esp
801030d3:	8d 7e 10             	lea    0x10(%esi),%edi
801030d6:	6a 04                	push   $0x4
801030d8:	68 d8 7a 10 80       	push   $0x80107ad8
801030dd:	56                   	push   %esi
801030de:	e8 9d 16 00 00       	call   80104780 <memcmp>
801030e3:	83 c4 10             	add    $0x10,%esp
801030e6:	85 c0                	test   %eax,%eax
801030e8:	75 1e                	jne    80103108 <mpsearch1+0x58>
801030ea:	8d 7e 10             	lea    0x10(%esi),%edi
801030ed:	89 f2                	mov    %esi,%edx
801030ef:	31 c9                	xor    %ecx,%ecx
801030f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030f8:	0f b6 02             	movzbl (%edx),%eax
801030fb:	83 c2 01             	add    $0x1,%edx
801030fe:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103100:	39 fa                	cmp    %edi,%edx
80103102:	75 f4                	jne    801030f8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103104:	84 c9                	test   %cl,%cl
80103106:	74 10                	je     80103118 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103108:	39 fb                	cmp    %edi,%ebx
8010310a:	89 fe                	mov    %edi,%esi
8010310c:	77 c2                	ja     801030d0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010310e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103111:	31 c0                	xor    %eax,%eax
}
80103113:	5b                   	pop    %ebx
80103114:	5e                   	pop    %esi
80103115:	5f                   	pop    %edi
80103116:	5d                   	pop    %ebp
80103117:	c3                   	ret    
80103118:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010311b:	89 f0                	mov    %esi,%eax
8010311d:	5b                   	pop    %ebx
8010311e:	5e                   	pop    %esi
8010311f:	5f                   	pop    %edi
80103120:	5d                   	pop    %ebp
80103121:	c3                   	ret    
80103122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103130 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	57                   	push   %edi
80103134:	56                   	push   %esi
80103135:	53                   	push   %ebx
80103136:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103139:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103140:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103147:	c1 e0 08             	shl    $0x8,%eax
8010314a:	09 d0                	or     %edx,%eax
8010314c:	c1 e0 04             	shl    $0x4,%eax
8010314f:	85 c0                	test   %eax,%eax
80103151:	75 1b                	jne    8010316e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103153:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010315a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103161:	c1 e0 08             	shl    $0x8,%eax
80103164:	09 d0                	or     %edx,%eax
80103166:	c1 e0 0a             	shl    $0xa,%eax
80103169:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010316e:	ba 00 04 00 00       	mov    $0x400,%edx
80103173:	e8 38 ff ff ff       	call   801030b0 <mpsearch1>
80103178:	85 c0                	test   %eax,%eax
8010317a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010317d:	0f 84 37 01 00 00    	je     801032ba <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103183:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103186:	8b 58 04             	mov    0x4(%eax),%ebx
80103189:	85 db                	test   %ebx,%ebx
8010318b:	0f 84 43 01 00 00    	je     801032d4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103191:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103197:	83 ec 04             	sub    $0x4,%esp
8010319a:	6a 04                	push   $0x4
8010319c:	68 dd 7a 10 80       	push   $0x80107add
801031a1:	56                   	push   %esi
801031a2:	e8 d9 15 00 00       	call   80104780 <memcmp>
801031a7:	83 c4 10             	add    $0x10,%esp
801031aa:	85 c0                	test   %eax,%eax
801031ac:	0f 85 22 01 00 00    	jne    801032d4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031b2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031b9:	3c 01                	cmp    $0x1,%al
801031bb:	74 08                	je     801031c5 <mpinit+0x95>
801031bd:	3c 04                	cmp    $0x4,%al
801031bf:	0f 85 0f 01 00 00    	jne    801032d4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031c5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031cc:	85 ff                	test   %edi,%edi
801031ce:	74 21                	je     801031f1 <mpinit+0xc1>
801031d0:	31 d2                	xor    %edx,%edx
801031d2:	31 c0                	xor    %eax,%eax
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031d8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031df:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031e0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031e3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031e5:	39 c7                	cmp    %eax,%edi
801031e7:	75 ef                	jne    801031d8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031e9:	84 d2                	test   %dl,%dl
801031eb:	0f 85 e3 00 00 00    	jne    801032d4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031f1:	85 f6                	test   %esi,%esi
801031f3:	0f 84 db 00 00 00    	je     801032d4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801031f9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031ff:	a3 7c b3 11 80       	mov    %eax,0x8011b37c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103204:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010320b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103211:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103216:	01 d6                	add    %edx,%esi
80103218:	90                   	nop
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103220:	39 c6                	cmp    %eax,%esi
80103222:	76 23                	jbe    80103247 <mpinit+0x117>
80103224:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103227:	80 fa 04             	cmp    $0x4,%dl
8010322a:	0f 87 c0 00 00 00    	ja     801032f0 <mpinit+0x1c0>
80103230:	ff 24 95 1c 7b 10 80 	jmp    *-0x7fef84e4(,%edx,4)
80103237:	89 f6                	mov    %esi,%esi
80103239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103240:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103243:	39 c6                	cmp    %eax,%esi
80103245:	77 dd                	ja     80103224 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103247:	85 db                	test   %ebx,%ebx
80103249:	0f 84 92 00 00 00    	je     801032e1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010324f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103252:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103256:	74 15                	je     8010326d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103258:	ba 22 00 00 00       	mov    $0x22,%edx
8010325d:	b8 70 00 00 00       	mov    $0x70,%eax
80103262:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103263:	ba 23 00 00 00       	mov    $0x23,%edx
80103268:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103269:	83 c8 01             	or     $0x1,%eax
8010326c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010326d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103270:	5b                   	pop    %ebx
80103271:	5e                   	pop    %esi
80103272:	5f                   	pop    %edi
80103273:	5d                   	pop    %ebp
80103274:	c3                   	ret    
80103275:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103278:	8b 0d 00 ba 11 80    	mov    0x8011ba00,%ecx
8010327e:	83 f9 07             	cmp    $0x7,%ecx
80103281:	7f 19                	jg     8010329c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103283:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103287:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010328d:	83 c1 01             	add    $0x1,%ecx
80103290:	89 0d 00 ba 11 80    	mov    %ecx,0x8011ba00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103296:	88 97 80 b4 11 80    	mov    %dl,-0x7fee4b80(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010329c:	83 c0 14             	add    $0x14,%eax
      continue;
8010329f:	e9 7c ff ff ff       	jmp    80103220 <mpinit+0xf0>
801032a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801032a8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801032ac:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801032af:	88 15 60 b4 11 80    	mov    %dl,0x8011b460
      p += sizeof(struct mpioapic);
      continue;
801032b5:	e9 66 ff ff ff       	jmp    80103220 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032ba:	ba 00 00 01 00       	mov    $0x10000,%edx
801032bf:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032c4:	e8 e7 fd ff ff       	call   801030b0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032c9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032ce:	0f 85 af fe ff ff    	jne    80103183 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801032d4:	83 ec 0c             	sub    $0xc,%esp
801032d7:	68 e2 7a 10 80       	push   $0x80107ae2
801032dc:	e8 8f d0 ff ff       	call   80100370 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032e1:	83 ec 0c             	sub    $0xc,%esp
801032e4:	68 fc 7a 10 80       	push   $0x80107afc
801032e9:	e8 82 d0 ff ff       	call   80100370 <panic>
801032ee:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032f0:	31 db                	xor    %ebx,%ebx
801032f2:	e9 30 ff ff ff       	jmp    80103227 <mpinit+0xf7>
801032f7:	66 90                	xchg   %ax,%ax
801032f9:	66 90                	xchg   %ax,%ax
801032fb:	66 90                	xchg   %ax,%ax
801032fd:	66 90                	xchg   %ax,%ax
801032ff:	90                   	nop

80103300 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103300:	55                   	push   %ebp
80103301:	ba 21 00 00 00       	mov    $0x21,%edx
80103306:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010330b:	89 e5                	mov    %esp,%ebp
8010330d:	ee                   	out    %al,(%dx)
8010330e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103313:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103314:	5d                   	pop    %ebp
80103315:	c3                   	ret    
80103316:	66 90                	xchg   %ax,%ax
80103318:	66 90                	xchg   %ax,%ax
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 0c             	sub    $0xc,%esp
80103329:	8b 75 08             	mov    0x8(%ebp),%esi
8010332c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010332f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103335:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010333b:	e8 30 da ff ff       	call   80100d70 <filealloc>
80103340:	85 c0                	test   %eax,%eax
80103342:	89 06                	mov    %eax,(%esi)
80103344:	0f 84 a8 00 00 00    	je     801033f2 <pipealloc+0xd2>
8010334a:	e8 21 da ff ff       	call   80100d70 <filealloc>
8010334f:	85 c0                	test   %eax,%eax
80103351:	89 03                	mov    %eax,(%ebx)
80103353:	0f 84 87 00 00 00    	je     801033e0 <pipealloc+0xc0>
  //if((*f0 = filealloc(0)) == 0 || (*f1 = filealloc(0)) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103359:	e8 62 f2 ff ff       	call   801025c0 <kalloc>
8010335e:	85 c0                	test   %eax,%eax
80103360:	89 c7                	mov    %eax,%edi
80103362:	0f 84 b0 00 00 00    	je     80103418 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103368:	83 ec 08             	sub    $0x8,%esp
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
  //if((*f0 = filealloc(0)) == 0 || (*f1 = filealloc(0)) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010336b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103372:	00 00 00 
  p->writeopen = 1;
80103375:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010337c:	00 00 00 
  p->nwrite = 0;
8010337f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103386:	00 00 00 
  p->nread = 0;
80103389:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103390:	00 00 00 
  initlock(&p->lock, "pipe");
80103393:	68 30 7b 10 80       	push   $0x80107b30
80103398:	50                   	push   %eax
80103399:	e8 32 11 00 00       	call   801044d0 <initlock>
  (*f0)->type = FD_PIPE;
8010339e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033a0:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
801033a3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801033a9:	8b 06                	mov    (%esi),%eax
801033ab:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801033af:	8b 06                	mov    (%esi),%eax
801033b1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801033b5:	8b 06                	mov    (%esi),%eax
801033b7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801033ba:	8b 03                	mov    (%ebx),%eax
801033bc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801033c2:	8b 03                	mov    (%ebx),%eax
801033c4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801033c8:	8b 03                	mov    (%ebx),%eax
801033ca:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801033ce:	8b 03                	mov    (%ebx),%eax
801033d0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801033d6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801033d8:	5b                   	pop    %ebx
801033d9:	5e                   	pop    %esi
801033da:	5f                   	pop    %edi
801033db:	5d                   	pop    %ebp
801033dc:	c3                   	ret    
801033dd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801033e0:	8b 06                	mov    (%esi),%eax
801033e2:	85 c0                	test   %eax,%eax
801033e4:	74 1e                	je     80103404 <pipealloc+0xe4>
    fileclose(*f0);
801033e6:	83 ec 0c             	sub    $0xc,%esp
801033e9:	50                   	push   %eax
801033ea:	e8 41 da ff ff       	call   80100e30 <fileclose>
801033ef:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801033f2:	8b 03                	mov    (%ebx),%eax
801033f4:	85 c0                	test   %eax,%eax
801033f6:	74 0c                	je     80103404 <pipealloc+0xe4>
    fileclose(*f1);
801033f8:	83 ec 0c             	sub    $0xc,%esp
801033fb:	50                   	push   %eax
801033fc:	e8 2f da ff ff       	call   80100e30 <fileclose>
80103401:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103404:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80103407:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010340c:	5b                   	pop    %ebx
8010340d:	5e                   	pop    %esi
8010340e:	5f                   	pop    %edi
8010340f:	5d                   	pop    %ebp
80103410:	c3                   	ret    
80103411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103418:	8b 06                	mov    (%esi),%eax
8010341a:	85 c0                	test   %eax,%eax
8010341c:	75 c8                	jne    801033e6 <pipealloc+0xc6>
8010341e:	eb d2                	jmp    801033f2 <pipealloc+0xd2>

80103420 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80103420:	55                   	push   %ebp
80103421:	89 e5                	mov    %esp,%ebp
80103423:	56                   	push   %esi
80103424:	53                   	push   %ebx
80103425:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103428:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010342b:	83 ec 0c             	sub    $0xc,%esp
8010342e:	53                   	push   %ebx
8010342f:	e8 fc 11 00 00       	call   80104630 <acquire>
  if(writable){
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 f6                	test   %esi,%esi
80103439:	74 45                	je     80103480 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010343b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103441:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103444:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010344b:	00 00 00 
    wakeup(&p->nread);
8010344e:	50                   	push   %eax
8010344f:	e8 1c 0c 00 00       	call   80104070 <wakeup>
80103454:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103457:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010345d:	85 d2                	test   %edx,%edx
8010345f:	75 0a                	jne    8010346b <pipeclose+0x4b>
80103461:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103467:	85 c0                	test   %eax,%eax
80103469:	74 35                	je     801034a0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010346b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010346e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103471:	5b                   	pop    %ebx
80103472:	5e                   	pop    %esi
80103473:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103474:	e9 67 12 00 00       	jmp    801046e0 <release>
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103480:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103486:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103489:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103490:	00 00 00 
    wakeup(&p->nwrite);
80103493:	50                   	push   %eax
80103494:	e8 d7 0b 00 00       	call   80104070 <wakeup>
80103499:	83 c4 10             	add    $0x10,%esp
8010349c:	eb b9                	jmp    80103457 <pipeclose+0x37>
8010349e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	53                   	push   %ebx
801034a4:	e8 37 12 00 00       	call   801046e0 <release>
    kfree((char*)p);
801034a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801034ac:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
801034af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801034b2:	5b                   	pop    %ebx
801034b3:	5e                   	pop    %esi
801034b4:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
801034b5:	e9 56 ef ff ff       	jmp    80102410 <kfree>
801034ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801034c0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	57                   	push   %edi
801034c4:	56                   	push   %esi
801034c5:	53                   	push   %ebx
801034c6:	83 ec 28             	sub    $0x28,%esp
801034c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801034cc:	53                   	push   %ebx
801034cd:	e8 5e 11 00 00       	call   80104630 <acquire>
  for(i = 0; i < n; i++){
801034d2:	8b 45 10             	mov    0x10(%ebp),%eax
801034d5:	83 c4 10             	add    $0x10,%esp
801034d8:	85 c0                	test   %eax,%eax
801034da:	0f 8e b9 00 00 00    	jle    80103599 <pipewrite+0xd9>
801034e0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034e3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034ef:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801034f5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801034f8:	03 4d 10             	add    0x10(%ebp),%ecx
801034fb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034fe:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103504:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010350a:	39 d0                	cmp    %edx,%eax
8010350c:	74 38                	je     80103546 <pipewrite+0x86>
8010350e:	eb 59                	jmp    80103569 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
80103510:	e8 ab 03 00 00       	call   801038c0 <myproc>
80103515:	8b 48 24             	mov    0x24(%eax),%ecx
80103518:	85 c9                	test   %ecx,%ecx
8010351a:	75 34                	jne    80103550 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010351c:	83 ec 0c             	sub    $0xc,%esp
8010351f:	57                   	push   %edi
80103520:	e8 4b 0b 00 00       	call   80104070 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103525:	58                   	pop    %eax
80103526:	5a                   	pop    %edx
80103527:	53                   	push   %ebx
80103528:	56                   	push   %esi
80103529:	e8 82 09 00 00       	call   80103eb0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010352e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103534:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010353a:	83 c4 10             	add    $0x10,%esp
8010353d:	05 00 02 00 00       	add    $0x200,%eax
80103542:	39 c2                	cmp    %eax,%edx
80103544:	75 2a                	jne    80103570 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80103546:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010354c:	85 c0                	test   %eax,%eax
8010354e:	75 c0                	jne    80103510 <pipewrite+0x50>
        release(&p->lock);
80103550:	83 ec 0c             	sub    $0xc,%esp
80103553:	53                   	push   %ebx
80103554:	e8 87 11 00 00       	call   801046e0 <release>
        return -1;
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103561:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103564:	5b                   	pop    %ebx
80103565:	5e                   	pop    %esi
80103566:	5f                   	pop    %edi
80103567:	5d                   	pop    %ebp
80103568:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103569:	89 c2                	mov    %eax,%edx
8010356b:	90                   	nop
8010356c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103570:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103573:	8d 42 01             	lea    0x1(%edx),%eax
80103576:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010357a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103580:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103586:	0f b6 09             	movzbl (%ecx),%ecx
80103589:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010358d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103590:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80103593:	0f 85 65 ff ff ff    	jne    801034fe <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103599:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010359f:	83 ec 0c             	sub    $0xc,%esp
801035a2:	50                   	push   %eax
801035a3:	e8 c8 0a 00 00       	call   80104070 <wakeup>
  release(&p->lock);
801035a8:	89 1c 24             	mov    %ebx,(%esp)
801035ab:	e8 30 11 00 00       	call   801046e0 <release>
  return n;
801035b0:	83 c4 10             	add    $0x10,%esp
801035b3:	8b 45 10             	mov    0x10(%ebp),%eax
801035b6:	eb a9                	jmp    80103561 <pipewrite+0xa1>
801035b8:	90                   	nop
801035b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801035c0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	57                   	push   %edi
801035c4:	56                   	push   %esi
801035c5:	53                   	push   %ebx
801035c6:	83 ec 18             	sub    $0x18,%esp
801035c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801035cf:	53                   	push   %ebx
801035d0:	e8 5b 10 00 00       	call   80104630 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035d5:	83 c4 10             	add    $0x10,%esp
801035d8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801035de:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801035e4:	75 6a                	jne    80103650 <piperead+0x90>
801035e6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035ec:	85 f6                	test   %esi,%esi
801035ee:	0f 84 cc 00 00 00    	je     801036c0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035f4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801035fa:	eb 2d                	jmp    80103629 <piperead+0x69>
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103600:	83 ec 08             	sub    $0x8,%esp
80103603:	53                   	push   %ebx
80103604:	56                   	push   %esi
80103605:	e8 a6 08 00 00       	call   80103eb0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010360a:	83 c4 10             	add    $0x10,%esp
8010360d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103613:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103619:	75 35                	jne    80103650 <piperead+0x90>
8010361b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103621:	85 d2                	test   %edx,%edx
80103623:	0f 84 97 00 00 00    	je     801036c0 <piperead+0x100>
    if(myproc()->killed){
80103629:	e8 92 02 00 00       	call   801038c0 <myproc>
8010362e:	8b 48 24             	mov    0x24(%eax),%ecx
80103631:	85 c9                	test   %ecx,%ecx
80103633:	74 cb                	je     80103600 <piperead+0x40>
      release(&p->lock);
80103635:	83 ec 0c             	sub    $0xc,%esp
80103638:	53                   	push   %ebx
80103639:	e8 a2 10 00 00       	call   801046e0 <release>
      return -1;
8010363e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103641:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80103644:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103649:	5b                   	pop    %ebx
8010364a:	5e                   	pop    %esi
8010364b:	5f                   	pop    %edi
8010364c:	5d                   	pop    %ebp
8010364d:	c3                   	ret    
8010364e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103650:	8b 45 10             	mov    0x10(%ebp),%eax
80103653:	85 c0                	test   %eax,%eax
80103655:	7e 69                	jle    801036c0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103657:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010365d:	31 c9                	xor    %ecx,%ecx
8010365f:	eb 15                	jmp    80103676 <piperead+0xb6>
80103661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103668:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010366e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80103674:	74 5a                	je     801036d0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103676:	8d 70 01             	lea    0x1(%eax),%esi
80103679:	25 ff 01 00 00       	and    $0x1ff,%eax
8010367e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103684:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80103689:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010368c:	83 c1 01             	add    $0x1,%ecx
8010368f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103692:	75 d4                	jne    80103668 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103694:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010369a:	83 ec 0c             	sub    $0xc,%esp
8010369d:	50                   	push   %eax
8010369e:	e8 cd 09 00 00       	call   80104070 <wakeup>
  release(&p->lock);
801036a3:	89 1c 24             	mov    %ebx,(%esp)
801036a6:	e8 35 10 00 00       	call   801046e0 <release>
  return i;
801036ab:	8b 45 10             	mov    0x10(%ebp),%eax
801036ae:	83 c4 10             	add    $0x10,%esp
}
801036b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036b4:	5b                   	pop    %ebx
801036b5:	5e                   	pop    %esi
801036b6:	5f                   	pop    %edi
801036b7:	5d                   	pop    %ebp
801036b8:	c3                   	ret    
801036b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801036c0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801036c7:	eb cb                	jmp    80103694 <piperead+0xd4>
801036c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036d0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801036d3:	eb bf                	jmp    80103694 <piperead+0xd4>
801036d5:	66 90                	xchg   %ax,%ax
801036d7:	66 90                	xchg   %ax,%ax
801036d9:	66 90                	xchg   %ax,%ax
801036db:	66 90                	xchg   %ax,%ax
801036dd:	66 90                	xchg   %ax,%ax
801036df:	90                   	nop

801036e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801036e4:	bb 54 ba 11 80       	mov    $0x8011ba54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801036e9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801036ec:	68 20 ba 11 80       	push   $0x8011ba20
801036f1:	e8 3a 0f 00 00       	call   80104630 <acquire>
801036f6:	83 c4 10             	add    $0x10,%esp
801036f9:	eb 13                	jmp    8010370e <allocproc+0x2e>
801036fb:	90                   	nop
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103700:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
80103706:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
8010370c:	74 7a                	je     80103788 <allocproc+0xa8>
    if(p->state == UNUSED)
8010370e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103711:	85 c0                	test   %eax,%eax
80103713:	75 eb                	jne    80103700 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103715:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010371a:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010371d:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103724:	68 20 ba 11 80       	push   $0x8011ba20
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103729:	8d 50 01             	lea    0x1(%eax),%edx
8010372c:	89 43 10             	mov    %eax,0x10(%ebx)
8010372f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80103735:	e8 a6 0f 00 00       	call   801046e0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010373a:	e8 81 ee ff ff       	call   801025c0 <kalloc>
8010373f:	83 c4 10             	add    $0x10,%esp
80103742:	85 c0                	test   %eax,%eax
80103744:	89 43 08             	mov    %eax,0x8(%ebx)
80103747:	74 56                	je     8010379f <allocproc+0xbf>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103749:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010374f:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103752:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103757:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010375a:	c7 40 14 21 5d 10 80 	movl   $0x80105d21,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103761:	6a 14                	push   $0x14
80103763:	6a 00                	push   $0x0
80103765:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103766:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103769:	e8 c2 0f 00 00       	call   80104730 <memset>
  p->context->eip = (uint)forkret;
8010376e:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103771:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103774:	c7 40 10 b0 37 10 80 	movl   $0x801037b0,0x10(%eax)

  return p;
8010377b:	89 d8                	mov    %ebx,%eax
}
8010377d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103780:	c9                   	leave  
80103781:	c3                   	ret    
80103782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103788:	83 ec 0c             	sub    $0xc,%esp
8010378b:	68 20 ba 11 80       	push   $0x8011ba20
80103790:	e8 4b 0f 00 00       	call   801046e0 <release>
  return 0;
80103795:	83 c4 10             	add    $0x10,%esp
80103798:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010379a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010379d:	c9                   	leave  
8010379e:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
8010379f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801037a6:	eb d5                	jmp    8010377d <allocproc+0x9d>
801037a8:	90                   	nop
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037b0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037b6:	68 20 ba 11 80       	push   $0x8011ba20
801037bb:	e8 20 0f 00 00       	call   801046e0 <release>

  if (first) {
801037c0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801037c5:	83 c4 10             	add    $0x10,%esp
801037c8:	85 c0                	test   %eax,%eax
801037ca:	75 04                	jne    801037d0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037cc:	c9                   	leave  
801037cd:	c3                   	ret    
801037ce:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801037d0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801037d3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801037da:	00 00 00 
    iinit(ROOTDEV);
801037dd:	6a 01                	push   $0x1
801037df:	e8 ec dc ff ff       	call   801014d0 <iinit>
    initlog(ROOTDEV);
801037e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037eb:	e8 f0 f3 ff ff       	call   80102be0 <initlog>
801037f0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037f3:	c9                   	leave  
801037f4:	c3                   	ret    
801037f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103800 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103806:	68 35 7b 10 80       	push   $0x80107b35
8010380b:	68 20 ba 11 80       	push   $0x8011ba20
80103810:	e8 bb 0c 00 00       	call   801044d0 <initlock>
}
80103815:	83 c4 10             	add    $0x10,%esp
80103818:	c9                   	leave  
80103819:	c3                   	ret    
8010381a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103820 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	56                   	push   %esi
80103824:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103825:	9c                   	pushf  
80103826:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
80103827:	f6 c4 02             	test   $0x2,%ah
8010382a:	75 5b                	jne    80103887 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010382c:	e8 ef ef ff ff       	call   80102820 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103831:	8b 35 00 ba 11 80    	mov    0x8011ba00,%esi
80103837:	85 f6                	test   %esi,%esi
80103839:	7e 3f                	jle    8010387a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010383b:	0f b6 15 80 b4 11 80 	movzbl 0x8011b480,%edx
80103842:	39 d0                	cmp    %edx,%eax
80103844:	74 30                	je     80103876 <mycpu+0x56>
80103846:	b9 30 b5 11 80       	mov    $0x8011b530,%ecx
8010384b:	31 d2                	xor    %edx,%edx
8010384d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103850:	83 c2 01             	add    $0x1,%edx
80103853:	39 f2                	cmp    %esi,%edx
80103855:	74 23                	je     8010387a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103857:	0f b6 19             	movzbl (%ecx),%ebx
8010385a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103860:	39 d8                	cmp    %ebx,%eax
80103862:	75 ec                	jne    80103850 <mycpu+0x30>
      return &cpus[i];
80103864:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010386a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010386d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010386e:	05 80 b4 11 80       	add    $0x8011b480,%eax
  }
  panic("unknown apicid\n");
}
80103873:	5e                   	pop    %esi
80103874:	5d                   	pop    %ebp
80103875:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103876:	31 d2                	xor    %edx,%edx
80103878:	eb ea                	jmp    80103864 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010387a:	83 ec 0c             	sub    $0xc,%esp
8010387d:	68 3c 7b 10 80       	push   $0x80107b3c
80103882:	e8 e9 ca ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80103887:	83 ec 0c             	sub    $0xc,%esp
8010388a:	68 78 7c 10 80       	push   $0x80107c78
8010388f:	e8 dc ca ff ff       	call   80100370 <panic>
80103894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010389a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038a0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801038a6:	e8 75 ff ff ff       	call   80103820 <mycpu>
801038ab:	2d 80 b4 11 80       	sub    $0x8011b480,%eax
}
801038b0:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801038b1:	c1 f8 04             	sar    $0x4,%eax
801038b4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801038ba:	c3                   	ret    
801038bb:	90                   	nop
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038c0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	53                   	push   %ebx
801038c4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801038c7:	e8 84 0c 00 00       	call   80104550 <pushcli>
  c = mycpu();
801038cc:	e8 4f ff ff ff       	call   80103820 <mycpu>
  p = c->proc;
801038d1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038d7:	e8 b4 0c 00 00       	call   80104590 <popcli>
  return p;
}
801038dc:	83 c4 04             	add    $0x4,%esp
801038df:	89 d8                	mov    %ebx,%eax
801038e1:	5b                   	pop    %ebx
801038e2:	5d                   	pop    %ebp
801038e3:	c3                   	ret    
801038e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038f0 <userinit>:
  
  release(&ptable.lock);
}*/
void
userinit(void)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801038f7:	e8 e4 fd ff ff       	call   801036e0 <allocproc>
801038fc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801038fe:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103903:	e8 08 3a 00 00       	call   80107310 <setupkvm>
80103908:	85 c0                	test   %eax,%eax
8010390a:	89 43 04             	mov    %eax,0x4(%ebx)
8010390d:	0f 84 d0 00 00 00    	je     801039e3 <userinit+0xf3>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103913:	83 ec 04             	sub    $0x4,%esp
80103916:	68 2c 00 00 00       	push   $0x2c
8010391b:	68 60 b4 10 80       	push   $0x8010b460
80103920:	50                   	push   %eax
80103921:	e8 fa 36 00 00       	call   80107020 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103926:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103929:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010392f:	6a 4c                	push   $0x4c
80103931:	6a 00                	push   $0x0
80103933:	ff 73 18             	pushl  0x18(%ebx)
80103936:	e8 f5 0d 00 00       	call   80104730 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	8b 43 18             	mov    0x18(%ebx),%eax
8010393e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103943:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103948:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010394b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010394f:	8b 43 18             	mov    0x18(%ebx),%eax
80103952:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010395d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103961:	8b 43 18             	mov    0x18(%ebx),%eax
80103964:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103968:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010396c:	8b 43 18             	mov    0x18(%ebx),%eax
8010396f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103976:	8b 43 18             	mov    0x18(%ebx),%eax
80103979:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103980:	8b 43 18             	mov    0x18(%ebx),%eax
80103983:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010398a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010398d:	6a 10                	push   $0x10
8010398f:	68 65 7b 10 80       	push   $0x80107b65
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;
  safestrcpy(p->currentUser, "Admin", 6);
80103994:	83 c3 7c             	add    $0x7c,%ebx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103997:	50                   	push   %eax
80103998:	e8 93 0f 00 00       	call   80104930 <safestrcpy>
  p->cwd = namei("/");
8010399d:	c7 04 24 6e 7b 10 80 	movl   $0x80107b6e,(%esp)
801039a4:	e8 47 e6 ff ff       	call   80101ff0 <namei>
801039a9:	89 43 ec             	mov    %eax,-0x14(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801039ac:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
801039b3:	e8 78 0c 00 00       	call   80104630 <acquire>

  p->state = RUNNABLE;
  safestrcpy(p->currentUser, "Admin", 6);
801039b8:	83 c4 0c             	add    $0xc,%esp
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;
801039bb:	c7 43 90 03 00 00 00 	movl   $0x3,-0x70(%ebx)
  safestrcpy(p->currentUser, "Admin", 6);
801039c2:	6a 06                	push   $0x6
801039c4:	68 70 7b 10 80       	push   $0x80107b70
801039c9:	53                   	push   %ebx
801039ca:	e8 61 0f 00 00       	call   80104930 <safestrcpy>
  release(&ptable.lock);
801039cf:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
801039d6:	e8 05 0d 00 00       	call   801046e0 <release>
}
801039db:	83 c4 10             	add    $0x10,%esp
801039de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039e1:	c9                   	leave  
801039e2:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801039e3:	83 ec 0c             	sub    $0xc,%esp
801039e6:	68 4c 7b 10 80       	push   $0x80107b4c
801039eb:	e8 80 c9 ff ff       	call   80100370 <panic>

801039f0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	56                   	push   %esi
801039f4:	53                   	push   %ebx
801039f5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801039f8:	e8 53 0b 00 00       	call   80104550 <pushcli>
  c = mycpu();
801039fd:	e8 1e fe ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103a02:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a08:	e8 83 0b 00 00       	call   80104590 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
80103a0d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80103a10:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a12:	7e 34                	jle    80103a48 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a14:	83 ec 04             	sub    $0x4,%esp
80103a17:	01 c6                	add    %eax,%esi
80103a19:	56                   	push   %esi
80103a1a:	50                   	push   %eax
80103a1b:	ff 73 04             	pushl  0x4(%ebx)
80103a1e:	e8 3d 37 00 00       	call   80107160 <allocuvm>
80103a23:	83 c4 10             	add    $0x10,%esp
80103a26:	85 c0                	test   %eax,%eax
80103a28:	74 36                	je     80103a60 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
80103a2a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
80103a2d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a2f:	53                   	push   %ebx
80103a30:	e8 db 34 00 00       	call   80106f10 <switchuvm>
  return 0;
80103a35:	83 c4 10             	add    $0x10,%esp
80103a38:	31 c0                	xor    %eax,%eax
}
80103a3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a3d:	5b                   	pop    %ebx
80103a3e:	5e                   	pop    %esi
80103a3f:	5d                   	pop    %ebp
80103a40:	c3                   	ret    
80103a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a48:	74 e0                	je     80103a2a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103a4a:	83 ec 04             	sub    $0x4,%esp
80103a4d:	01 c6                	add    %eax,%esi
80103a4f:	56                   	push   %esi
80103a50:	50                   	push   %eax
80103a51:	ff 73 04             	pushl  0x4(%ebx)
80103a54:	e8 07 38 00 00       	call   80107260 <deallocuvm>
80103a59:	83 c4 10             	add    $0x10,%esp
80103a5c:	85 c0                	test   %eax,%eax
80103a5e:	75 ca                	jne    80103a2a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a65:	eb d3                	jmp    80103a3a <growproc+0x4a>
80103a67:	89 f6                	mov    %esi,%esi
80103a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a70 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
80103a76:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103a79:	e8 d2 0a 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103a7e:	e8 9d fd ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103a83:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a89:	e8 02 0b 00 00       	call   80104590 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
80103a8e:	e8 4d fc ff ff       	call   801036e0 <allocproc>
80103a93:	85 c0                	test   %eax,%eax
80103a95:	89 c7                	mov    %eax,%edi
80103a97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103a9a:	0f 84 dd 00 00 00    	je     80103b7d <fork+0x10d>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103aa0:	83 ec 08             	sub    $0x8,%esp
80103aa3:	ff 33                	pushl  (%ebx)
80103aa5:	ff 73 04             	pushl  0x4(%ebx)
80103aa8:	e8 33 39 00 00       	call   801073e0 <copyuvm>
80103aad:	83 c4 10             	add    $0x10,%esp
80103ab0:	85 c0                	test   %eax,%eax
80103ab2:	89 47 04             	mov    %eax,0x4(%edi)
80103ab5:	0f 84 c9 00 00 00    	je     80103b84 <fork+0x114>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103abb:	8b 03                	mov    (%ebx),%eax
80103abd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  np->parent = curproc;
  *np->tf = *curproc->tf;
  safestrcpy(np->currentUser, curproc->currentUser, strlen(curproc->currentUser) + 1);
80103ac0:	83 ec 0c             	sub    $0xc,%esp
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
80103ac3:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103ac5:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103ac8:	8b 79 18             	mov    0x18(%ecx),%edi
80103acb:	8b 73 18             	mov    0x18(%ebx),%esi
80103ace:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ad3:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  safestrcpy(np->currentUser, curproc->currentUser, strlen(curproc->currentUser) + 1);
80103ad5:	8d 73 7c             	lea    0x7c(%ebx),%esi
80103ad8:	56                   	push   %esi
80103ad9:	e8 92 0e 00 00       	call   80104970 <strlen>
80103ade:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103ae1:	83 c4 0c             	add    $0xc,%esp
80103ae4:	83 c0 01             	add    $0x1,%eax
80103ae7:	50                   	push   %eax
80103ae8:	56                   	push   %esi

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103ae9:	31 f6                	xor    %esi,%esi
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;
  safestrcpy(np->currentUser, curproc->currentUser, strlen(curproc->currentUser) + 1);
80103aeb:	8d 47 7c             	lea    0x7c(%edi),%eax
80103aee:	50                   	push   %eax
80103aef:	e8 3c 0e 00 00       	call   80104930 <safestrcpy>

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103af4:	8b 47 18             	mov    0x18(%edi),%eax
80103af7:	83 c4 10             	add    $0x10,%esp
80103afa:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103b08:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b0c:	85 c0                	test   %eax,%eax
80103b0e:	74 13                	je     80103b23 <fork+0xb3>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b10:	83 ec 0c             	sub    $0xc,%esp
80103b13:	50                   	push   %eax
80103b14:	e8 c7 d2 ff ff       	call   80100de0 <filedup>
80103b19:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b1c:	83 c4 10             	add    $0x10,%esp
80103b1f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  safestrcpy(np->currentUser, curproc->currentUser, strlen(curproc->currentUser) + 1);

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103b23:	83 c6 01             	add    $0x1,%esi
80103b26:	83 fe 10             	cmp    $0x10,%esi
80103b29:	75 dd                	jne    80103b08 <fork+0x98>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b2b:	83 ec 0c             	sub    $0xc,%esp
80103b2e:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b31:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b34:	e8 97 db ff ff       	call   801016d0 <idup>
80103b39:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b3c:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103b3f:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b42:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b45:	6a 10                	push   $0x10
80103b47:	53                   	push   %ebx
80103b48:	50                   	push   %eax
80103b49:	e8 e2 0d 00 00       	call   80104930 <safestrcpy>

  pid = np->pid;
80103b4e:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80103b51:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80103b58:	e8 d3 0a 00 00       	call   80104630 <acquire>

  np->state = RUNNABLE;
80103b5d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
80103b64:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80103b6b:	e8 70 0b 00 00       	call   801046e0 <release>

  return pid;
80103b70:	83 c4 10             	add    $0x10,%esp
80103b73:	89 d8                	mov    %ebx,%eax
}
80103b75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b78:	5b                   	pop    %ebx
80103b79:	5e                   	pop    %esi
80103b7a:	5f                   	pop    %edi
80103b7b:	5d                   	pop    %ebp
80103b7c:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b82:	eb f1                	jmp    80103b75 <fork+0x105>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103b84:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b87:	83 ec 0c             	sub    $0xc,%esp
80103b8a:	ff 77 08             	pushl  0x8(%edi)
80103b8d:	e8 7e e8 ff ff       	call   80102410 <kfree>
    np->kstack = 0;
80103b92:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103b99:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103ba0:	83 c4 10             	add    $0x10,%esp
80103ba3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ba8:	eb cb                	jmp    80103b75 <fork+0x105>
80103baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103bb0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	57                   	push   %edi
80103bb4:	56                   	push   %esi
80103bb5:	53                   	push   %ebx
80103bb6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103bb9:	e8 62 fc ff ff       	call   80103820 <mycpu>
80103bbe:	8d 78 04             	lea    0x4(%eax),%edi
80103bc1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103bc3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103bca:	00 00 00 
80103bcd:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103bd0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103bd1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bd4:	bb 54 ba 11 80       	mov    $0x8011ba54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103bd9:	68 20 ba 11 80       	push   $0x8011ba20
80103bde:	e8 4d 0a 00 00       	call   80104630 <acquire>
80103be3:	83 c4 10             	add    $0x10,%esp
80103be6:	eb 16                	jmp    80103bfe <scheduler+0x4e>
80103be8:	90                   	nop
80103be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bf0:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
80103bf6:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80103bfc:	74 52                	je     80103c50 <scheduler+0xa0>
      if(p->state != RUNNABLE)
80103bfe:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c02:	75 ec                	jne    80103bf0 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c04:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103c07:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103c0d:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c0e:	81 c3 dc 00 00 00    	add    $0xdc,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80103c14:	e8 f7 32 00 00       	call   80106f10 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103c19:	58                   	pop    %eax
80103c1a:	5a                   	pop    %edx
80103c1b:	ff b3 40 ff ff ff    	pushl  -0xc0(%ebx)
80103c21:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103c22:	c7 83 30 ff ff ff 04 	movl   $0x4,-0xd0(%ebx)
80103c29:	00 00 00 

      swtch(&(c->scheduler), p->context);
80103c2c:	e8 5a 0d 00 00       	call   8010498b <swtch>
      switchkvm();
80103c31:	e8 ba 32 00 00       	call   80106ef0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c36:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c39:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103c3f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c46:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c49:	75 b3                	jne    80103bfe <scheduler+0x4e>
80103c4b:	90                   	nop
80103c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103c50:	83 ec 0c             	sub    $0xc,%esp
80103c53:	68 20 ba 11 80       	push   $0x8011ba20
80103c58:	e8 83 0a 00 00       	call   801046e0 <release>

  }
80103c5d:	83 c4 10             	add    $0x10,%esp
80103c60:	e9 6b ff ff ff       	jmp    80103bd0 <scheduler+0x20>
80103c65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c70 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	56                   	push   %esi
80103c74:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103c75:	e8 d6 08 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103c7a:	e8 a1 fb ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103c7f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c85:	e8 06 09 00 00       	call   80104590 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80103c8a:	83 ec 0c             	sub    $0xc,%esp
80103c8d:	68 20 ba 11 80       	push   $0x8011ba20
80103c92:	e8 69 09 00 00       	call   80104600 <holding>
80103c97:	83 c4 10             	add    $0x10,%esp
80103c9a:	85 c0                	test   %eax,%eax
80103c9c:	74 4f                	je     80103ced <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103c9e:	e8 7d fb ff ff       	call   80103820 <mycpu>
80103ca3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103caa:	75 68                	jne    80103d14 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80103cac:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cb0:	74 55                	je     80103d07 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cb2:	9c                   	pushf  
80103cb3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103cb4:	f6 c4 02             	test   $0x2,%ah
80103cb7:	75 41                	jne    80103cfa <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103cb9:	e8 62 fb ff ff       	call   80103820 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cbe:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103cc1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103cc7:	e8 54 fb ff ff       	call   80103820 <mycpu>
80103ccc:	83 ec 08             	sub    $0x8,%esp
80103ccf:	ff 70 04             	pushl  0x4(%eax)
80103cd2:	53                   	push   %ebx
80103cd3:	e8 b3 0c 00 00       	call   8010498b <swtch>
  mycpu()->intena = intena;
80103cd8:	e8 43 fb ff ff       	call   80103820 <mycpu>
}
80103cdd:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80103ce0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103ce6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ce9:	5b                   	pop    %ebx
80103cea:	5e                   	pop    %esi
80103ceb:	5d                   	pop    %ebp
80103cec:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103ced:	83 ec 0c             	sub    $0xc,%esp
80103cf0:	68 76 7b 10 80       	push   $0x80107b76
80103cf5:	e8 76 c6 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103cfa:	83 ec 0c             	sub    $0xc,%esp
80103cfd:	68 a2 7b 10 80       	push   $0x80107ba2
80103d02:	e8 69 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103d07:	83 ec 0c             	sub    $0xc,%esp
80103d0a:	68 94 7b 10 80       	push   $0x80107b94
80103d0f:	e8 5c c6 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103d14:	83 ec 0c             	sub    $0xc,%esp
80103d17:	68 88 7b 10 80       	push   $0x80107b88
80103d1c:	e8 4f c6 ff ff       	call   80100370 <panic>
80103d21:	eb 0d                	jmp    80103d30 <exit>
80103d23:	90                   	nop
80103d24:	90                   	nop
80103d25:	90                   	nop
80103d26:	90                   	nop
80103d27:	90                   	nop
80103d28:	90                   	nop
80103d29:	90                   	nop
80103d2a:	90                   	nop
80103d2b:	90                   	nop
80103d2c:	90                   	nop
80103d2d:	90                   	nop
80103d2e:	90                   	nop
80103d2f:	90                   	nop

80103d30 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103d30:	55                   	push   %ebp
80103d31:	89 e5                	mov    %esp,%ebp
80103d33:	57                   	push   %edi
80103d34:	56                   	push   %esi
80103d35:	53                   	push   %ebx
80103d36:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103d39:	e8 12 08 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103d3e:	e8 dd fa ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103d43:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103d49:	e8 42 08 00 00       	call   80104590 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103d4e:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80103d54:	8d 5e 28             	lea    0x28(%esi),%ebx
80103d57:	8d 7e 68             	lea    0x68(%esi),%edi
80103d5a:	0f 84 f1 00 00 00    	je     80103e51 <exit+0x121>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103d60:	8b 03                	mov    (%ebx),%eax
80103d62:	85 c0                	test   %eax,%eax
80103d64:	74 12                	je     80103d78 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80103d66:	83 ec 0c             	sub    $0xc,%esp
80103d69:	50                   	push   %eax
80103d6a:	e8 c1 d0 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103d6f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103d75:	83 c4 10             	add    $0x10,%esp
80103d78:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d7b:	39 df                	cmp    %ebx,%edi
80103d7d:	75 e1                	jne    80103d60 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d7f:	e8 fc ee ff ff       	call   80102c80 <begin_op>
  iput(curproc->cwd);
80103d84:	83 ec 0c             	sub    $0xc,%esp
80103d87:	ff 76 68             	pushl  0x68(%esi)
80103d8a:	e8 d1 da ff ff       	call   80101860 <iput>
  end_op();
80103d8f:	e8 5c ef ff ff       	call   80102cf0 <end_op>
  curproc->cwd = 0;
80103d94:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80103d9b:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80103da2:	e8 89 08 00 00       	call   80104630 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103da7:	8b 56 14             	mov    0x14(%esi),%edx
80103daa:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dad:	b8 54 ba 11 80       	mov    $0x8011ba54,%eax
80103db2:	eb 10                	jmp    80103dc4 <exit+0x94>
80103db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103db8:	05 dc 00 00 00       	add    $0xdc,%eax
80103dbd:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
80103dc2:	74 1e                	je     80103de2 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80103dc4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dc8:	75 ee                	jne    80103db8 <exit+0x88>
80103dca:	3b 50 20             	cmp    0x20(%eax),%edx
80103dcd:	75 e9                	jne    80103db8 <exit+0x88>
      p->state = RUNNABLE;
80103dcf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd6:	05 dc 00 00 00       	add    $0xdc,%eax
80103ddb:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
80103de0:	75 e2                	jne    80103dc4 <exit+0x94>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103de2:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
80103de8:	ba 54 ba 11 80       	mov    $0x8011ba54,%edx
80103ded:	eb 0f                	jmp    80103dfe <exit+0xce>
80103def:	90                   	nop

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103df0:	81 c2 dc 00 00 00    	add    $0xdc,%edx
80103df6:	81 fa 54 f1 11 80    	cmp    $0x8011f154,%edx
80103dfc:	74 3a                	je     80103e38 <exit+0x108>
    if(p->parent == curproc){
80103dfe:	39 72 14             	cmp    %esi,0x14(%edx)
80103e01:	75 ed                	jne    80103df0 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103e03:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103e07:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e0a:	75 e4                	jne    80103df0 <exit+0xc0>
80103e0c:	b8 54 ba 11 80       	mov    $0x8011ba54,%eax
80103e11:	eb 11                	jmp    80103e24 <exit+0xf4>
80103e13:	90                   	nop
80103e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e18:	05 dc 00 00 00       	add    $0xdc,%eax
80103e1d:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
80103e22:	74 cc                	je     80103df0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80103e24:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e28:	75 ee                	jne    80103e18 <exit+0xe8>
80103e2a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e2d:	75 e9                	jne    80103e18 <exit+0xe8>
      p->state = RUNNABLE;
80103e2f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e36:	eb e0                	jmp    80103e18 <exit+0xe8>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103e38:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103e3f:	e8 2c fe ff ff       	call   80103c70 <sched>
  panic("zombie exit");
80103e44:	83 ec 0c             	sub    $0xc,%esp
80103e47:	68 c3 7b 10 80       	push   $0x80107bc3
80103e4c:	e8 1f c5 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103e51:	83 ec 0c             	sub    $0xc,%esp
80103e54:	68 b6 7b 10 80       	push   $0x80107bb6
80103e59:	e8 12 c5 ff ff       	call   80100370 <panic>
80103e5e:	66 90                	xchg   %ax,%ax

80103e60 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	53                   	push   %ebx
80103e64:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e67:	68 20 ba 11 80       	push   $0x8011ba20
80103e6c:	e8 bf 07 00 00       	call   80104630 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103e71:	e8 da 06 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103e76:	e8 a5 f9 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103e7b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e81:	e8 0a 07 00 00       	call   80104590 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80103e86:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103e8d:	e8 de fd ff ff       	call   80103c70 <sched>
  release(&ptable.lock);
80103e92:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80103e99:	e8 42 08 00 00       	call   801046e0 <release>
}
80103e9e:	83 c4 10             	add    $0x10,%esp
80103ea1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ea4:	c9                   	leave  
80103ea5:	c3                   	ret    
80103ea6:	8d 76 00             	lea    0x0(%esi),%esi
80103ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103eb0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103eb0:	55                   	push   %ebp
80103eb1:	89 e5                	mov    %esp,%ebp
80103eb3:	57                   	push   %edi
80103eb4:	56                   	push   %esi
80103eb5:	53                   	push   %ebx
80103eb6:	83 ec 0c             	sub    $0xc,%esp
80103eb9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ebc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103ebf:	e8 8c 06 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103ec4:	e8 57 f9 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103ec9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ecf:	e8 bc 06 00 00       	call   80104590 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80103ed4:	85 db                	test   %ebx,%ebx
80103ed6:	0f 84 87 00 00 00    	je     80103f63 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80103edc:	85 f6                	test   %esi,%esi
80103ede:	74 76                	je     80103f56 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ee0:	81 fe 20 ba 11 80    	cmp    $0x8011ba20,%esi
80103ee6:	74 50                	je     80103f38 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ee8:	83 ec 0c             	sub    $0xc,%esp
80103eeb:	68 20 ba 11 80       	push   $0x8011ba20
80103ef0:	e8 3b 07 00 00       	call   80104630 <acquire>
    release(lk);
80103ef5:	89 34 24             	mov    %esi,(%esp)
80103ef8:	e8 e3 07 00 00       	call   801046e0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103efd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f00:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f07:	e8 64 fd ff ff       	call   80103c70 <sched>

  // Tidy up.
  p->chan = 0;
80103f0c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103f13:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80103f1a:	e8 c1 07 00 00       	call   801046e0 <release>
    acquire(lk);
80103f1f:	89 75 08             	mov    %esi,0x8(%ebp)
80103f22:	83 c4 10             	add    $0x10,%esp
  }
}
80103f25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f28:	5b                   	pop    %ebx
80103f29:	5e                   	pop    %esi
80103f2a:	5f                   	pop    %edi
80103f2b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103f2c:	e9 ff 06 00 00       	jmp    80104630 <acquire>
80103f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103f38:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103f3b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80103f42:	e8 29 fd ff ff       	call   80103c70 <sched>

  // Tidy up.
  p->chan = 0;
80103f47:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f51:	5b                   	pop    %ebx
80103f52:	5e                   	pop    %esi
80103f53:	5f                   	pop    %edi
80103f54:	5d                   	pop    %ebp
80103f55:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103f56:	83 ec 0c             	sub    $0xc,%esp
80103f59:	68 d5 7b 10 80       	push   $0x80107bd5
80103f5e:	e8 0d c4 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103f63:	83 ec 0c             	sub    $0xc,%esp
80103f66:	68 cf 7b 10 80       	push   $0x80107bcf
80103f6b:	e8 00 c4 ff ff       	call   80100370 <panic>

80103f70 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	56                   	push   %esi
80103f74:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80103f75:	e8 d6 05 00 00       	call   80104550 <pushcli>
  c = mycpu();
80103f7a:	e8 a1 f8 ff ff       	call   80103820 <mycpu>
  p = c->proc;
80103f7f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f85:	e8 06 06 00 00       	call   80104590 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80103f8a:	83 ec 0c             	sub    $0xc,%esp
80103f8d:	68 20 ba 11 80       	push   $0x8011ba20
80103f92:	e8 99 06 00 00       	call   80104630 <acquire>
80103f97:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f9a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f9c:	bb 54 ba 11 80       	mov    $0x8011ba54,%ebx
80103fa1:	eb 13                	jmp    80103fb6 <wait+0x46>
80103fa3:	90                   	nop
80103fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fa8:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
80103fae:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80103fb4:	74 22                	je     80103fd8 <wait+0x68>
      if(p->parent != curproc)
80103fb6:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fb9:	75 ed                	jne    80103fa8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103fbb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fbf:	74 35                	je     80103ff6 <wait+0x86>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc1:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103fc7:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fcc:	81 fb 54 f1 11 80    	cmp    $0x8011f154,%ebx
80103fd2:	75 e2                	jne    80103fb6 <wait+0x46>
80103fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103fd8:	85 c0                	test   %eax,%eax
80103fda:	74 70                	je     8010404c <wait+0xdc>
80103fdc:	8b 46 24             	mov    0x24(%esi),%eax
80103fdf:	85 c0                	test   %eax,%eax
80103fe1:	75 69                	jne    8010404c <wait+0xdc>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103fe3:	83 ec 08             	sub    $0x8,%esp
80103fe6:	68 20 ba 11 80       	push   $0x8011ba20
80103feb:	56                   	push   %esi
80103fec:	e8 bf fe ff ff       	call   80103eb0 <sleep>
  }
80103ff1:	83 c4 10             	add    $0x10,%esp
80103ff4:	eb a4                	jmp    80103f9a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103ff6:	83 ec 0c             	sub    $0xc,%esp
80103ff9:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103ffc:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fff:	e8 0c e4 ff ff       	call   80102410 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104004:	5a                   	pop    %edx
80104005:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104008:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
8010400f:	e8 7c 32 00 00       	call   80107290 <freevm>
        p->pid = 0;
80104014:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010401b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104022:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104026:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010402d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104034:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
8010403b:	e8 a0 06 00 00       	call   801046e0 <release>
        return pid;
80104040:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104043:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80104046:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104048:	5b                   	pop    %ebx
80104049:	5e                   	pop    %esi
8010404a:	5d                   	pop    %ebp
8010404b:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
8010404c:	83 ec 0c             	sub    $0xc,%esp
8010404f:	68 20 ba 11 80       	push   $0x8011ba20
80104054:	e8 87 06 00 00       	call   801046e0 <release>
      return -1;
80104059:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010405c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
8010405f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104064:	5b                   	pop    %ebx
80104065:	5e                   	pop    %esi
80104066:	5d                   	pop    %ebp
80104067:	c3                   	ret    
80104068:	90                   	nop
80104069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104070 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	53                   	push   %ebx
80104074:	83 ec 10             	sub    $0x10,%esp
80104077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010407a:	68 20 ba 11 80       	push   $0x8011ba20
8010407f:	e8 ac 05 00 00       	call   80104630 <acquire>
80104084:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104087:	b8 54 ba 11 80       	mov    $0x8011ba54,%eax
8010408c:	eb 0e                	jmp    8010409c <wakeup+0x2c>
8010408e:	66 90                	xchg   %ax,%ax
80104090:	05 dc 00 00 00       	add    $0xdc,%eax
80104095:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
8010409a:	74 1e                	je     801040ba <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010409c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040a0:	75 ee                	jne    80104090 <wakeup+0x20>
801040a2:	3b 58 20             	cmp    0x20(%eax),%ebx
801040a5:	75 e9                	jne    80104090 <wakeup+0x20>
      p->state = RUNNABLE;
801040a7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040ae:	05 dc 00 00 00       	add    $0xdc,%eax
801040b3:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
801040b8:	75 e2                	jne    8010409c <wakeup+0x2c>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801040ba:	c7 45 08 20 ba 11 80 	movl   $0x8011ba20,0x8(%ebp)
}
801040c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040c4:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801040c5:	e9 16 06 00 00       	jmp    801046e0 <release>
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	53                   	push   %ebx
801040d4:	83 ec 10             	sub    $0x10,%esp
801040d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801040da:	68 20 ba 11 80       	push   $0x8011ba20
801040df:	e8 4c 05 00 00       	call   80104630 <acquire>
801040e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040e7:	b8 54 ba 11 80       	mov    $0x8011ba54,%eax
801040ec:	eb 0e                	jmp    801040fc <kill+0x2c>
801040ee:	66 90                	xchg   %ax,%ax
801040f0:	05 dc 00 00 00       	add    $0xdc,%eax
801040f5:	3d 54 f1 11 80       	cmp    $0x8011f154,%eax
801040fa:	74 3c                	je     80104138 <kill+0x68>
    if(p->pid == pid){
801040fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801040ff:	75 ef                	jne    801040f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104101:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104105:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010410c:	74 1a                	je     80104128 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010410e:	83 ec 0c             	sub    $0xc,%esp
80104111:	68 20 ba 11 80       	push   $0x8011ba20
80104116:	e8 c5 05 00 00       	call   801046e0 <release>
      return 0;
8010411b:	83 c4 10             	add    $0x10,%esp
8010411e:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104120:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104123:	c9                   	leave  
80104124:	c3                   	ret    
80104125:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104128:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010412f:	eb dd                	jmp    8010410e <kill+0x3e>
80104131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	68 20 ba 11 80       	push   $0x8011ba20
80104140:	e8 9b 05 00 00       	call   801046e0 <release>
  return -1;
80104145:	83 c4 10             	add    $0x10,%esp
80104148:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010414d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104150:	c9                   	leave  
80104151:	c3                   	ret    
80104152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104160 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	57                   	push   %edi
80104164:	56                   	push   %esi
80104165:	53                   	push   %ebx
80104166:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104169:	bb c0 ba 11 80       	mov    $0x8011bac0,%ebx
8010416e:	83 ec 3c             	sub    $0x3c,%esp
80104171:	eb 27                	jmp    8010419a <procdump+0x3a>
80104173:	90                   	nop
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 4c 7c 10 80       	push   $0x80107c4c
80104180:	e8 db c4 ff ff       	call   80100660 <cprintf>
80104185:	83 c4 10             	add    $0x10,%esp
80104188:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010418e:	81 fb c0 f1 11 80    	cmp    $0x8011f1c0,%ebx
80104194:	0f 84 7e 00 00 00    	je     80104218 <procdump+0xb8>
    if(p->state == UNUSED)
8010419a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010419d:	85 c0                	test   %eax,%eax
8010419f:	74 e7                	je     80104188 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a1:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
801041a4:	ba e6 7b 10 80       	mov    $0x80107be6,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a9:	77 11                	ja     801041bc <procdump+0x5c>
801041ab:	8b 14 85 a0 7c 10 80 	mov    -0x7fef8360(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
801041b2:	b8 e6 7b 10 80       	mov    $0x80107be6,%eax
801041b7:	85 d2                	test   %edx,%edx
801041b9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041bc:	53                   	push   %ebx
801041bd:	52                   	push   %edx
801041be:	ff 73 a4             	pushl  -0x5c(%ebx)
801041c1:	68 ea 7b 10 80       	push   $0x80107bea
801041c6:	e8 95 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
801041cb:	83 c4 10             	add    $0x10,%esp
801041ce:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801041d2:	75 a4                	jne    80104178 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041d4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041d7:	83 ec 08             	sub    $0x8,%esp
801041da:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041dd:	50                   	push   %eax
801041de:	8b 43 b0             	mov    -0x50(%ebx),%eax
801041e1:	8b 40 0c             	mov    0xc(%eax),%eax
801041e4:	83 c0 08             	add    $0x8,%eax
801041e7:	50                   	push   %eax
801041e8:	e8 03 03 00 00       	call   801044f0 <getcallerpcs>
801041ed:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041f0:	8b 17                	mov    (%edi),%edx
801041f2:	85 d2                	test   %edx,%edx
801041f4:	74 82                	je     80104178 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041f6:	83 ec 08             	sub    $0x8,%esp
801041f9:	83 c7 04             	add    $0x4,%edi
801041fc:	52                   	push   %edx
801041fd:	68 21 76 10 80       	push   $0x80107621
80104202:	e8 59 c4 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104207:	83 c4 10             	add    $0x10,%esp
8010420a:	39 f7                	cmp    %esi,%edi
8010420c:	75 e2                	jne    801041f0 <procdump+0x90>
8010420e:	e9 65 ff ff ff       	jmp    80104178 <procdump+0x18>
80104213:	90                   	nop
80104214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104218:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010421b:	5b                   	pop    %ebx
8010421c:	5e                   	pop    %esi
8010421d:	5f                   	pop    %edi
8010421e:	5d                   	pop    %ebp
8010421f:	c3                   	ret    

80104220 <cps>:

//process state
int
cps()
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 10             	sub    $0x10,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
80104227:	fb                   	sti    
struct proc *p;

	//Enable interrupt on this processor
	sti();
	acquire(&ptable.lock);
80104228:	68 20 ba 11 80       	push   $0x8011ba20
8010422d:	bb c0 ba 11 80       	mov    $0x8011bac0,%ebx
80104232:	e8 f9 03 00 00       	call   80104630 <acquire>
	cprintf("name \t pid \t state \t \n");
80104237:	c7 04 24 f3 7b 10 80 	movl   $0x80107bf3,(%esp)
8010423e:	e8 1d c4 ff ff       	call   80100660 <cprintf>
80104243:	83 c4 10             	add    $0x10,%esp
80104246:	eb 20                	jmp    80104268 <cps+0x48>
80104248:	90                   	nop
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	{
		if(p->state == SLEEPING)
		{
			cprintf("%s \t %d \t SLEEPING \t \n", p->name, p->pid);
		}
		else if(p->state == RUNNING)
80104250:	83 f8 04             	cmp    $0x4,%eax
80104253:	74 5b                	je     801042b0 <cps+0x90>
		{
			cprintf("%s \t %d \t RUNNING \t \n", p->name, p->pid);
		}
		else if(p->state == RUNNABLE)
80104255:	83 f8 03             	cmp    $0x3,%eax
80104258:	74 76                	je     801042d0 <cps+0xb0>
8010425a:	81 c3 dc 00 00 00    	add    $0xdc,%ebx

	//Enable interrupt on this processor
	sti();
	acquire(&ptable.lock);
	cprintf("name \t pid \t state \t \n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104260:	81 fb c0 f1 11 80    	cmp    $0x8011f1c0,%ebx
80104266:	74 2a                	je     80104292 <cps+0x72>
	{
		if(p->state == SLEEPING)
80104268:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010426b:	83 f8 02             	cmp    $0x2,%eax
8010426e:	75 e0                	jne    80104250 <cps+0x30>
		{
			cprintf("%s \t %d \t SLEEPING \t \n", p->name, p->pid);
80104270:	83 ec 04             	sub    $0x4,%esp
80104273:	ff 73 a4             	pushl  -0x5c(%ebx)
80104276:	53                   	push   %ebx
80104277:	68 0a 7c 10 80       	push   $0x80107c0a
8010427c:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
80104282:	e8 d9 c3 ff ff       	call   80100660 <cprintf>
80104287:	83 c4 10             	add    $0x10,%esp

	//Enable interrupt on this processor
	sti();
	acquire(&ptable.lock);
	cprintf("name \t pid \t state \t \n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010428a:	81 fb c0 f1 11 80    	cmp    $0x8011f1c0,%ebx
80104290:	75 d6                	jne    80104268 <cps+0x48>
		else if(p->state == RUNNABLE)
		{
			cprintf("%s \t %d \t RUNNABLE \t \n", p->name, p->pid);
		}
	}
	release(&ptable.lock);
80104292:	83 ec 0c             	sub    $0xc,%esp
80104295:	68 20 ba 11 80       	push   $0x8011ba20
8010429a:	e8 41 04 00 00       	call   801046e0 <release>
	return 22;
}
8010429f:	b8 16 00 00 00       	mov    $0x16,%eax
801042a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042a7:	c9                   	leave  
801042a8:	c3                   	ret    
801042a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		{
			cprintf("%s \t %d \t SLEEPING \t \n", p->name, p->pid);
		}
		else if(p->state == RUNNING)
		{
			cprintf("%s \t %d \t RUNNING \t \n", p->name, p->pid);
801042b0:	83 ec 04             	sub    $0x4,%esp
801042b3:	ff 73 a4             	pushl  -0x5c(%ebx)
801042b6:	53                   	push   %ebx
801042b7:	68 21 7c 10 80       	push   $0x80107c21
801042bc:	e8 9f c3 ff ff       	call   80100660 <cprintf>
801042c1:	83 c4 10             	add    $0x10,%esp
801042c4:	eb 94                	jmp    8010425a <cps+0x3a>
801042c6:	8d 76 00             	lea    0x0(%esi),%esi
801042c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		}
		else if(p->state == RUNNABLE)
		{
			cprintf("%s \t %d \t RUNNABLE \t \n", p->name, p->pid);
801042d0:	83 ec 04             	sub    $0x4,%esp
801042d3:	ff 73 a4             	pushl  -0x5c(%ebx)
801042d6:	53                   	push   %ebx
801042d7:	68 37 7c 10 80       	push   $0x80107c37
801042dc:	e8 7f c3 ff ff       	call   80100660 <cprintf>
801042e1:	83 c4 10             	add    $0x10,%esp
801042e4:	e9 71 ff ff ff       	jmp    8010425a <cps+0x3a>
801042e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042f0 <changeUser>:
}

//change current user
int
changeUser(char* targetUser)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	56                   	push   %esi
801042f4:	53                   	push   %ebx
801042f5:	8b 75 08             	mov    0x8(%ebp),%esi
801042f8:	bb d0 ba 11 80       	mov    $0x8011bad0,%ebx
	struct proc *p;
	acquire(&ptable.lock);
801042fd:	83 ec 0c             	sub    $0xc,%esp
80104300:	68 20 ba 11 80       	push   $0x8011ba20
80104305:	e8 26 03 00 00       	call   80104630 <acquire>
8010430a:	83 c4 10             	add    $0x10,%esp
8010430d:	8d 76 00             	lea    0x0(%esi),%esi
	//cprintf("name \t pid \t state \t \n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
	{
		safestrcpy(p->currentUser, targetUser, strlen(targetUser) + 1);
80104310:	83 ec 0c             	sub    $0xc,%esp
80104313:	56                   	push   %esi
80104314:	e8 57 06 00 00       	call   80104970 <strlen>
80104319:	83 c4 0c             	add    $0xc,%esp
8010431c:	83 c0 01             	add    $0x1,%eax
8010431f:	50                   	push   %eax
80104320:	56                   	push   %esi
80104321:	53                   	push   %ebx
80104322:	81 c3 dc 00 00 00    	add    $0xdc,%ebx
80104328:	e8 03 06 00 00       	call   80104930 <safestrcpy>
changeUser(char* targetUser)
{
	struct proc *p;
	acquire(&ptable.lock);
	//cprintf("name \t pid \t state \t \n");
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010432d:	83 c4 10             	add    $0x10,%esp
80104330:	81 fb d0 f1 11 80    	cmp    $0x8011f1d0,%ebx
80104336:	75 d8                	jne    80104310 <changeUser+0x20>
	{
		safestrcpy(p->currentUser, targetUser, strlen(targetUser) + 1);
	}
	release(&ptable.lock);
80104338:	83 ec 0c             	sub    $0xc,%esp
8010433b:	68 20 ba 11 80       	push   $0x8011ba20
80104340:	e8 9b 03 00 00       	call   801046e0 <release>
	//char* i = targetUser;
	//while(
	//currentUser = targetUser;	
	//cprintf("currentUser: %s\n", currentUser);
	return 24;
}
80104345:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104348:	b8 18 00 00 00       	mov    $0x18,%eax
8010434d:	5b                   	pop    %ebx
8010434e:	5e                   	pop    %esi
8010434f:	5d                   	pop    %ebp
80104350:	c3                   	ret    
80104351:	eb 0d                	jmp    80104360 <getUser>
80104353:	90                   	nop
80104354:	90                   	nop
80104355:	90                   	nop
80104356:	90                   	nop
80104357:	90                   	nop
80104358:	90                   	nop
80104359:	90                   	nop
8010435a:	90                   	nop
8010435b:	90                   	nop
8010435c:	90                   	nop
8010435d:	90                   	nop
8010435e:	90                   	nop
8010435f:	90                   	nop

80104360 <getUser>:

int
getUser(void)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	83 ec 14             	sub    $0x14,%esp
	struct proc *p;
	acquire(&ptable.lock);
80104366:	68 20 ba 11 80       	push   $0x8011ba20
8010436b:	e8 c0 02 00 00       	call   80104630 <acquire>
	//cprintf("name \t pid \t state \t \n");
	p = ptable.proc;
	cprintf("%s", p->currentUser);
80104370:	58                   	pop    %eax
80104371:	5a                   	pop    %edx
80104372:	68 d0 ba 11 80       	push   $0x8011bad0
80104377:	68 f0 7b 10 80       	push   $0x80107bf0
8010437c:	e8 df c2 ff ff       	call   80100660 <cprintf>
	release(&ptable.lock);
80104381:	c7 04 24 20 ba 11 80 	movl   $0x8011ba20,(%esp)
80104388:	e8 53 03 00 00       	call   801046e0 <release>
	return 25;
}
8010438d:	b8 19 00 00 00       	mov    $0x19,%eax
80104392:	c9                   	leave  
80104393:	c3                   	ret    
80104394:	66 90                	xchg   %ax,%ax
80104396:	66 90                	xchg   %ax,%ax
80104398:	66 90                	xchg   %ax,%ax
8010439a:	66 90                	xchg   %ax,%ax
8010439c:	66 90                	xchg   %ax,%ax
8010439e:	66 90                	xchg   %ax,%ax

801043a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
801043a4:	83 ec 0c             	sub    $0xc,%esp
801043a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801043aa:	68 b8 7c 10 80       	push   $0x80107cb8
801043af:	8d 43 04             	lea    0x4(%ebx),%eax
801043b2:	50                   	push   %eax
801043b3:	e8 18 01 00 00       	call   801044d0 <initlock>
  lk->name = name;
801043b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043c1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801043c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801043cb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801043ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d1:	c9                   	leave  
801043d2:	c3                   	ret    
801043d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
801043e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043e8:	83 ec 0c             	sub    $0xc,%esp
801043eb:	8d 73 04             	lea    0x4(%ebx),%esi
801043ee:	56                   	push   %esi
801043ef:	e8 3c 02 00 00       	call   80104630 <acquire>
  while (lk->locked) {
801043f4:	8b 13                	mov    (%ebx),%edx
801043f6:	83 c4 10             	add    $0x10,%esp
801043f9:	85 d2                	test   %edx,%edx
801043fb:	74 16                	je     80104413 <acquiresleep+0x33>
801043fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104400:	83 ec 08             	sub    $0x8,%esp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
80104405:	e8 a6 fa ff ff       	call   80103eb0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010440a:	8b 03                	mov    (%ebx),%eax
8010440c:	83 c4 10             	add    $0x10,%esp
8010440f:	85 c0                	test   %eax,%eax
80104411:	75 ed                	jne    80104400 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104413:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104419:	e8 a2 f4 ff ff       	call   801038c0 <myproc>
8010441e:	8b 40 10             	mov    0x10(%eax),%eax
80104421:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104424:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104427:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010442a:	5b                   	pop    %ebx
8010442b:	5e                   	pop    %esi
8010442c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010442d:	e9 ae 02 00 00       	jmp    801046e0 <release>
80104432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104440 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	56                   	push   %esi
80104444:	53                   	push   %ebx
80104445:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104448:	83 ec 0c             	sub    $0xc,%esp
8010444b:	8d 73 04             	lea    0x4(%ebx),%esi
8010444e:	56                   	push   %esi
8010444f:	e8 dc 01 00 00       	call   80104630 <acquire>
  lk->locked = 0;
80104454:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010445a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104461:	89 1c 24             	mov    %ebx,(%esp)
80104464:	e8 07 fc ff ff       	call   80104070 <wakeup>
  release(&lk->lk);
80104469:	89 75 08             	mov    %esi,0x8(%ebp)
8010446c:	83 c4 10             	add    $0x10,%esp
}
8010446f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104472:	5b                   	pop    %ebx
80104473:	5e                   	pop    %esi
80104474:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104475:	e9 66 02 00 00       	jmp    801046e0 <release>
8010447a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104480 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	53                   	push   %ebx
80104486:	31 ff                	xor    %edi,%edi
80104488:	83 ec 18             	sub    $0x18,%esp
8010448b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010448e:	8d 73 04             	lea    0x4(%ebx),%esi
80104491:	56                   	push   %esi
80104492:	e8 99 01 00 00       	call   80104630 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104497:	8b 03                	mov    (%ebx),%eax
80104499:	83 c4 10             	add    $0x10,%esp
8010449c:	85 c0                	test   %eax,%eax
8010449e:	74 13                	je     801044b3 <holdingsleep+0x33>
801044a0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801044a3:	e8 18 f4 ff ff       	call   801038c0 <myproc>
801044a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801044ab:	0f 94 c0             	sete   %al
801044ae:	0f b6 c0             	movzbl %al,%eax
801044b1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801044b3:	83 ec 0c             	sub    $0xc,%esp
801044b6:	56                   	push   %esi
801044b7:	e8 24 02 00 00       	call   801046e0 <release>
  return r;
}
801044bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044bf:	89 f8                	mov    %edi,%eax
801044c1:	5b                   	pop    %ebx
801044c2:	5e                   	pop    %esi
801044c3:	5f                   	pop    %edi
801044c4:	5d                   	pop    %ebp
801044c5:	c3                   	ret    
801044c6:	66 90                	xchg   %ax,%ax
801044c8:	66 90                	xchg   %ax,%ax
801044ca:	66 90                	xchg   %ax,%ax
801044cc:	66 90                	xchg   %ax,%ax
801044ce:	66 90                	xchg   %ax,%ax

801044d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801044df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801044e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044e9:	5d                   	pop    %ebp
801044ea:	c3                   	ret    
801044eb:	90                   	nop
801044ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801044f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044f4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801044fd:	31 c0                	xor    %eax,%eax
801044ff:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104500:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104506:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010450c:	77 1a                	ja     80104528 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010450e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104511:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104514:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104517:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104519:	83 f8 0a             	cmp    $0xa,%eax
8010451c:	75 e2                	jne    80104500 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010451e:	5b                   	pop    %ebx
8010451f:	5d                   	pop    %ebp
80104520:	c3                   	ret    
80104521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104528:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010452f:	83 c0 01             	add    $0x1,%eax
80104532:	83 f8 0a             	cmp    $0xa,%eax
80104535:	74 e7                	je     8010451e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104537:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010453e:	83 c0 01             	add    $0x1,%eax
80104541:	83 f8 0a             	cmp    $0xa,%eax
80104544:	75 e2                	jne    80104528 <getcallerpcs+0x38>
80104546:	eb d6                	jmp    8010451e <getcallerpcs+0x2e>
80104548:	90                   	nop
80104549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104550 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 04             	sub    $0x4,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104557:	9c                   	pushf  
80104558:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104559:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010455a:	e8 c1 f2 ff ff       	call   80103820 <mycpu>
8010455f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104565:	85 c0                	test   %eax,%eax
80104567:	75 11                	jne    8010457a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104569:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010456f:	e8 ac f2 ff ff       	call   80103820 <mycpu>
80104574:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010457a:	e8 a1 f2 ff ff       	call   80103820 <mycpu>
8010457f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104586:	83 c4 04             	add    $0x4,%esp
80104589:	5b                   	pop    %ebx
8010458a:	5d                   	pop    %ebp
8010458b:	c3                   	ret    
8010458c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104590 <popcli>:

void
popcli(void)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104596:	9c                   	pushf  
80104597:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104598:	f6 c4 02             	test   $0x2,%ah
8010459b:	75 52                	jne    801045ef <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010459d:	e8 7e f2 ff ff       	call   80103820 <mycpu>
801045a2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801045a8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801045ab:	85 d2                	test   %edx,%edx
801045ad:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801045b3:	78 2d                	js     801045e2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045b5:	e8 66 f2 ff ff       	call   80103820 <mycpu>
801045ba:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801045c0:	85 d2                	test   %edx,%edx
801045c2:	74 0c                	je     801045d0 <popcli+0x40>
    sti();
}
801045c4:	c9                   	leave  
801045c5:	c3                   	ret    
801045c6:	8d 76 00             	lea    0x0(%esi),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045d0:	e8 4b f2 ff ff       	call   80103820 <mycpu>
801045d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045db:	85 c0                	test   %eax,%eax
801045dd:	74 e5                	je     801045c4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801045df:	fb                   	sti    
    sti();
}
801045e0:	c9                   	leave  
801045e1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801045e2:	83 ec 0c             	sub    $0xc,%esp
801045e5:	68 da 7c 10 80       	push   $0x80107cda
801045ea:	e8 81 bd ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801045ef:	83 ec 0c             	sub    $0xc,%esp
801045f2:	68 c3 7c 10 80       	push   $0x80107cc3
801045f7:	e8 74 bd ff ff       	call   80100370 <panic>
801045fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104600 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	56                   	push   %esi
80104604:	53                   	push   %ebx
80104605:	8b 75 08             	mov    0x8(%ebp),%esi
80104608:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
8010460a:	e8 41 ff ff ff       	call   80104550 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010460f:	8b 06                	mov    (%esi),%eax
80104611:	85 c0                	test   %eax,%eax
80104613:	74 10                	je     80104625 <holding+0x25>
80104615:	8b 5e 08             	mov    0x8(%esi),%ebx
80104618:	e8 03 f2 ff ff       	call   80103820 <mycpu>
8010461d:	39 c3                	cmp    %eax,%ebx
8010461f:	0f 94 c3             	sete   %bl
80104622:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104625:	e8 66 ff ff ff       	call   80104590 <popcli>
  return r;
}
8010462a:	89 d8                	mov    %ebx,%eax
8010462c:	5b                   	pop    %ebx
8010462d:	5e                   	pop    %esi
8010462e:	5d                   	pop    %ebp
8010462f:	c3                   	ret    

80104630 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	53                   	push   %ebx
80104634:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104637:	e8 14 ff ff ff       	call   80104550 <pushcli>
  if(holding(lk))
8010463c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010463f:	83 ec 0c             	sub    $0xc,%esp
80104642:	53                   	push   %ebx
80104643:	e8 b8 ff ff ff       	call   80104600 <holding>
80104648:	83 c4 10             	add    $0x10,%esp
8010464b:	85 c0                	test   %eax,%eax
8010464d:	0f 85 7d 00 00 00    	jne    801046d0 <acquire+0xa0>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104653:	ba 01 00 00 00       	mov    $0x1,%edx
80104658:	eb 09                	jmp    80104663 <acquire+0x33>
8010465a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104660:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104663:	89 d0                	mov    %edx,%eax
80104665:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104668:	85 c0                	test   %eax,%eax
8010466a:	75 f4                	jne    80104660 <acquire+0x30>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010466c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104671:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104674:	e8 a7 f1 ff ff       	call   80103820 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104679:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010467b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010467e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104681:	31 c0                	xor    %eax,%eax
80104683:	90                   	nop
80104684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104688:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
8010468e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104694:	77 1a                	ja     801046b0 <acquire+0x80>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104696:	8b 5a 04             	mov    0x4(%edx),%ebx
80104699:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010469c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010469f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801046a1:	83 f8 0a             	cmp    $0xa,%eax
801046a4:	75 e2                	jne    80104688 <acquire+0x58>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801046a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046a9:	c9                   	leave  
801046aa:	c3                   	ret    
801046ab:	90                   	nop
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801046b0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801046b7:	83 c0 01             	add    $0x1,%eax
801046ba:	83 f8 0a             	cmp    $0xa,%eax
801046bd:	74 e7                	je     801046a6 <acquire+0x76>
    pcs[i] = 0;
801046bf:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801046c6:	83 c0 01             	add    $0x1,%eax
801046c9:	83 f8 0a             	cmp    $0xa,%eax
801046cc:	75 e2                	jne    801046b0 <acquire+0x80>
801046ce:	eb d6                	jmp    801046a6 <acquire+0x76>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801046d0:	83 ec 0c             	sub    $0xc,%esp
801046d3:	68 e1 7c 10 80       	push   $0x80107ce1
801046d8:	e8 93 bc ff ff       	call   80100370 <panic>
801046dd:	8d 76 00             	lea    0x0(%esi),%esi

801046e0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	53                   	push   %ebx
801046e4:	83 ec 10             	sub    $0x10,%esp
801046e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801046ea:	53                   	push   %ebx
801046eb:	e8 10 ff ff ff       	call   80104600 <holding>
801046f0:	83 c4 10             	add    $0x10,%esp
801046f3:	85 c0                	test   %eax,%eax
801046f5:	74 22                	je     80104719 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
801046f7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801046fe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80104705:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010470a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80104710:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104713:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80104714:	e9 77 fe ff ff       	jmp    80104590 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104719:	83 ec 0c             	sub    $0xc,%esp
8010471c:	68 e9 7c 10 80       	push   $0x80107ce9
80104721:	e8 4a bc ff ff       	call   80100370 <panic>
80104726:	66 90                	xchg   %ax,%ax
80104728:	66 90                	xchg   %ax,%ax
8010472a:	66 90                	xchg   %ax,%ax
8010472c:	66 90                	xchg   %ax,%ax
8010472e:	66 90                	xchg   %ax,%ax

80104730 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	57                   	push   %edi
80104734:	53                   	push   %ebx
80104735:	8b 55 08             	mov    0x8(%ebp),%edx
80104738:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010473b:	f6 c2 03             	test   $0x3,%dl
8010473e:	75 05                	jne    80104745 <memset+0x15>
80104740:	f6 c1 03             	test   $0x3,%cl
80104743:	74 13                	je     80104758 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104745:	89 d7                	mov    %edx,%edi
80104747:	8b 45 0c             	mov    0xc(%ebp),%eax
8010474a:	fc                   	cld    
8010474b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010474d:	5b                   	pop    %ebx
8010474e:	89 d0                	mov    %edx,%eax
80104750:	5f                   	pop    %edi
80104751:	5d                   	pop    %ebp
80104752:	c3                   	ret    
80104753:	90                   	nop
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104758:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010475c:	c1 e9 02             	shr    $0x2,%ecx
8010475f:	89 fb                	mov    %edi,%ebx
80104761:	89 f8                	mov    %edi,%eax
80104763:	c1 e3 18             	shl    $0x18,%ebx
80104766:	c1 e0 10             	shl    $0x10,%eax
80104769:	09 d8                	or     %ebx,%eax
8010476b:	09 f8                	or     %edi,%eax
8010476d:	c1 e7 08             	shl    $0x8,%edi
80104770:	09 f8                	or     %edi,%eax
80104772:	89 d7                	mov    %edx,%edi
80104774:	fc                   	cld    
80104775:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104777:	5b                   	pop    %ebx
80104778:	89 d0                	mov    %edx,%eax
8010477a:	5f                   	pop    %edi
8010477b:	5d                   	pop    %ebp
8010477c:	c3                   	ret    
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	57                   	push   %edi
80104784:	56                   	push   %esi
80104785:	8b 45 10             	mov    0x10(%ebp),%eax
80104788:	53                   	push   %ebx
80104789:	8b 75 0c             	mov    0xc(%ebp),%esi
8010478c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010478f:	85 c0                	test   %eax,%eax
80104791:	74 29                	je     801047bc <memcmp+0x3c>
    if(*s1 != *s2)
80104793:	0f b6 13             	movzbl (%ebx),%edx
80104796:	0f b6 0e             	movzbl (%esi),%ecx
80104799:	38 d1                	cmp    %dl,%cl
8010479b:	75 2b                	jne    801047c8 <memcmp+0x48>
8010479d:	8d 78 ff             	lea    -0x1(%eax),%edi
801047a0:	31 c0                	xor    %eax,%eax
801047a2:	eb 14                	jmp    801047b8 <memcmp+0x38>
801047a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047a8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
801047ad:	83 c0 01             	add    $0x1,%eax
801047b0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801047b4:	38 ca                	cmp    %cl,%dl
801047b6:	75 10                	jne    801047c8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801047b8:	39 f8                	cmp    %edi,%eax
801047ba:	75 ec                	jne    801047a8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801047bc:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801047bd:	31 c0                	xor    %eax,%eax
}
801047bf:	5e                   	pop    %esi
801047c0:	5f                   	pop    %edi
801047c1:	5d                   	pop    %ebp
801047c2:	c3                   	ret    
801047c3:	90                   	nop
801047c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801047c8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801047cb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801047cc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801047ce:	5e                   	pop    %esi
801047cf:	5f                   	pop    %edi
801047d0:	5d                   	pop    %ebp
801047d1:	c3                   	ret    
801047d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	56                   	push   %esi
801047e4:	53                   	push   %ebx
801047e5:	8b 45 08             	mov    0x8(%ebp),%eax
801047e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801047eb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ee:	39 c6                	cmp    %eax,%esi
801047f0:	73 2e                	jae    80104820 <memmove+0x40>
801047f2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801047f5:	39 c8                	cmp    %ecx,%eax
801047f7:	73 27                	jae    80104820 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801047f9:	85 db                	test   %ebx,%ebx
801047fb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801047fe:	74 17                	je     80104817 <memmove+0x37>
      *--d = *--s;
80104800:	29 d9                	sub    %ebx,%ecx
80104802:	89 cb                	mov    %ecx,%ebx
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104808:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
8010480c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
8010480f:	83 ea 01             	sub    $0x1,%edx
80104812:	83 fa ff             	cmp    $0xffffffff,%edx
80104815:	75 f1                	jne    80104808 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104817:	5b                   	pop    %ebx
80104818:	5e                   	pop    %esi
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    
8010481b:	90                   	nop
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104820:	31 d2                	xor    %edx,%edx
80104822:	85 db                	test   %ebx,%ebx
80104824:	74 f1                	je     80104817 <memmove+0x37>
80104826:	8d 76 00             	lea    0x0(%esi),%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104830:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104834:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104837:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010483a:	39 d3                	cmp    %edx,%ebx
8010483c:	75 f2                	jne    80104830 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010483e:	5b                   	pop    %ebx
8010483f:	5e                   	pop    %esi
80104840:	5d                   	pop    %ebp
80104841:	c3                   	ret    
80104842:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104853:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104854:	eb 8a                	jmp    801047e0 <memmove>
80104856:	8d 76 00             	lea    0x0(%esi),%esi
80104859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104860 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	57                   	push   %edi
80104864:	56                   	push   %esi
80104865:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104868:	53                   	push   %ebx
80104869:	8b 7d 08             	mov    0x8(%ebp),%edi
8010486c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010486f:	85 c9                	test   %ecx,%ecx
80104871:	74 37                	je     801048aa <strncmp+0x4a>
80104873:	0f b6 17             	movzbl (%edi),%edx
80104876:	0f b6 1e             	movzbl (%esi),%ebx
80104879:	84 d2                	test   %dl,%dl
8010487b:	74 3f                	je     801048bc <strncmp+0x5c>
8010487d:	38 d3                	cmp    %dl,%bl
8010487f:	75 3b                	jne    801048bc <strncmp+0x5c>
80104881:	8d 47 01             	lea    0x1(%edi),%eax
80104884:	01 cf                	add    %ecx,%edi
80104886:	eb 1b                	jmp    801048a3 <strncmp+0x43>
80104888:	90                   	nop
80104889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104890:	0f b6 10             	movzbl (%eax),%edx
80104893:	84 d2                	test   %dl,%dl
80104895:	74 21                	je     801048b8 <strncmp+0x58>
80104897:	0f b6 19             	movzbl (%ecx),%ebx
8010489a:	83 c0 01             	add    $0x1,%eax
8010489d:	89 ce                	mov    %ecx,%esi
8010489f:	38 da                	cmp    %bl,%dl
801048a1:	75 19                	jne    801048bc <strncmp+0x5c>
801048a3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
801048a5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
801048a8:	75 e6                	jne    80104890 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801048aa:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
801048ab:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
801048ad:	5e                   	pop    %esi
801048ae:	5f                   	pop    %edi
801048af:	5d                   	pop    %ebp
801048b0:	c3                   	ret    
801048b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801048bc:	0f b6 c2             	movzbl %dl,%eax
801048bf:	29 d8                	sub    %ebx,%eax
}
801048c1:	5b                   	pop    %ebx
801048c2:	5e                   	pop    %esi
801048c3:	5f                   	pop    %edi
801048c4:	5d                   	pop    %ebp
801048c5:	c3                   	ret    
801048c6:	8d 76 00             	lea    0x0(%esi),%esi
801048c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 45 08             	mov    0x8(%ebp),%eax
801048d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801048db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801048de:	89 c2                	mov    %eax,%edx
801048e0:	eb 19                	jmp    801048fb <strncpy+0x2b>
801048e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048e8:	83 c3 01             	add    $0x1,%ebx
801048eb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801048ef:	83 c2 01             	add    $0x1,%edx
801048f2:	84 c9                	test   %cl,%cl
801048f4:	88 4a ff             	mov    %cl,-0x1(%edx)
801048f7:	74 09                	je     80104902 <strncpy+0x32>
801048f9:	89 f1                	mov    %esi,%ecx
801048fb:	85 c9                	test   %ecx,%ecx
801048fd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104900:	7f e6                	jg     801048e8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104902:	31 c9                	xor    %ecx,%ecx
80104904:	85 f6                	test   %esi,%esi
80104906:	7e 17                	jle    8010491f <strncpy+0x4f>
80104908:	90                   	nop
80104909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104910:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104914:	89 f3                	mov    %esi,%ebx
80104916:	83 c1 01             	add    $0x1,%ecx
80104919:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010491b:	85 db                	test   %ebx,%ebx
8010491d:	7f f1                	jg     80104910 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010491f:	5b                   	pop    %ebx
80104920:	5e                   	pop    %esi
80104921:	5d                   	pop    %ebp
80104922:	c3                   	ret    
80104923:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104930 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	56                   	push   %esi
80104934:	53                   	push   %ebx
80104935:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104938:	8b 45 08             	mov    0x8(%ebp),%eax
8010493b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010493e:	85 c9                	test   %ecx,%ecx
80104940:	7e 26                	jle    80104968 <safestrcpy+0x38>
80104942:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104946:	89 c1                	mov    %eax,%ecx
80104948:	eb 17                	jmp    80104961 <safestrcpy+0x31>
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104950:	83 c2 01             	add    $0x1,%edx
80104953:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104957:	83 c1 01             	add    $0x1,%ecx
8010495a:	84 db                	test   %bl,%bl
8010495c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010495f:	74 04                	je     80104965 <safestrcpy+0x35>
80104961:	39 f2                	cmp    %esi,%edx
80104963:	75 eb                	jne    80104950 <safestrcpy+0x20>
    ;
  *s = 0;
80104965:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104968:	5b                   	pop    %ebx
80104969:	5e                   	pop    %esi
8010496a:	5d                   	pop    %ebp
8010496b:	c3                   	ret    
8010496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104970 <strlen>:

int
strlen(const char *s)
{
80104970:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104971:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104973:	89 e5                	mov    %esp,%ebp
80104975:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104978:	80 3a 00             	cmpb   $0x0,(%edx)
8010497b:	74 0c                	je     80104989 <strlen+0x19>
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
80104980:	83 c0 01             	add    $0x1,%eax
80104983:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104987:	75 f7                	jne    80104980 <strlen+0x10>
    ;
  return n;
}
80104989:	5d                   	pop    %ebp
8010498a:	c3                   	ret    

8010498b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010498b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010498f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104993:	55                   	push   %ebp
  pushl %ebx
80104994:	53                   	push   %ebx
  pushl %esi
80104995:	56                   	push   %esi
  pushl %edi
80104996:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104997:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104999:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010499b:	5f                   	pop    %edi
  popl %esi
8010499c:	5e                   	pop    %esi
  popl %ebx
8010499d:	5b                   	pop    %ebx
  popl %ebp
8010499e:	5d                   	pop    %ebp
  ret
8010499f:	c3                   	ret    

801049a0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	53                   	push   %ebx
801049a4:	83 ec 04             	sub    $0x4,%esp
801049a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801049aa:	e8 11 ef ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801049af:	8b 00                	mov    (%eax),%eax
801049b1:	39 d8                	cmp    %ebx,%eax
801049b3:	76 1b                	jbe    801049d0 <fetchint+0x30>
801049b5:	8d 53 04             	lea    0x4(%ebx),%edx
801049b8:	39 d0                	cmp    %edx,%eax
801049ba:	72 14                	jb     801049d0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801049bf:	8b 13                	mov    (%ebx),%edx
801049c1:	89 10                	mov    %edx,(%eax)
  return 0;
801049c3:	31 c0                	xor    %eax,%eax
}
801049c5:	83 c4 04             	add    $0x4,%esp
801049c8:	5b                   	pop    %ebx
801049c9:	5d                   	pop    %ebp
801049ca:	c3                   	ret    
801049cb:	90                   	nop
801049cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801049d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049d5:	eb ee                	jmp    801049c5 <fetchint+0x25>
801049d7:	89 f6                	mov    %esi,%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049e0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801049e0:	55                   	push   %ebp
801049e1:	89 e5                	mov    %esp,%ebp
801049e3:	53                   	push   %ebx
801049e4:	83 ec 04             	sub    $0x4,%esp
801049e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801049ea:	e8 d1 ee ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz)
801049ef:	39 18                	cmp    %ebx,(%eax)
801049f1:	76 29                	jbe    80104a1c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801049f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801049f6:	89 da                	mov    %ebx,%edx
801049f8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801049fa:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801049fc:	39 c3                	cmp    %eax,%ebx
801049fe:	73 1c                	jae    80104a1c <fetchstr+0x3c>
    if(*s == 0)
80104a00:	80 3b 00             	cmpb   $0x0,(%ebx)
80104a03:	75 10                	jne    80104a15 <fetchstr+0x35>
80104a05:	eb 29                	jmp    80104a30 <fetchstr+0x50>
80104a07:	89 f6                	mov    %esi,%esi
80104a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a10:	80 3a 00             	cmpb   $0x0,(%edx)
80104a13:	74 1b                	je     80104a30 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80104a15:	83 c2 01             	add    $0x1,%edx
80104a18:	39 d0                	cmp    %edx,%eax
80104a1a:	77 f4                	ja     80104a10 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104a1c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80104a1f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80104a24:	5b                   	pop    %ebx
80104a25:	5d                   	pop    %ebp
80104a26:	c3                   	ret    
80104a27:	89 f6                	mov    %esi,%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104a30:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80104a33:	89 d0                	mov    %edx,%eax
80104a35:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104a37:	5b                   	pop    %ebx
80104a38:	5d                   	pop    %ebp
80104a39:	c3                   	ret    
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a40 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a45:	e8 76 ee ff ff       	call   801038c0 <myproc>
80104a4a:	8b 40 18             	mov    0x18(%eax),%eax
80104a4d:	8b 55 08             	mov    0x8(%ebp),%edx
80104a50:	8b 40 44             	mov    0x44(%eax),%eax
80104a53:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80104a56:	e8 65 ee ff ff       	call   801038c0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a5b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a5d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a60:	39 c6                	cmp    %eax,%esi
80104a62:	73 1c                	jae    80104a80 <argint+0x40>
80104a64:	8d 53 08             	lea    0x8(%ebx),%edx
80104a67:	39 d0                	cmp    %edx,%eax
80104a69:	72 15                	jb     80104a80 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80104a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a6e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a71:	89 10                	mov    %edx,(%eax)
  return 0;
80104a73:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80104a75:	5b                   	pop    %ebx
80104a76:	5e                   	pop    %esi
80104a77:	5d                   	pop    %ebp
80104a78:	c3                   	ret    
80104a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80104a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a85:	eb ee                	jmp    80104a75 <argint+0x35>
80104a87:	89 f6                	mov    %esi,%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a90 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
80104a95:	83 ec 10             	sub    $0x10,%esp
80104a98:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104a9b:	e8 20 ee ff ff       	call   801038c0 <myproc>
80104aa0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104aa2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104aa5:	83 ec 08             	sub    $0x8,%esp
80104aa8:	50                   	push   %eax
80104aa9:	ff 75 08             	pushl  0x8(%ebp)
80104aac:	e8 8f ff ff ff       	call   80104a40 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ab1:	c1 e8 1f             	shr    $0x1f,%eax
80104ab4:	83 c4 10             	add    $0x10,%esp
80104ab7:	84 c0                	test   %al,%al
80104ab9:	75 2d                	jne    80104ae8 <argptr+0x58>
80104abb:	89 d8                	mov    %ebx,%eax
80104abd:	c1 e8 1f             	shr    $0x1f,%eax
80104ac0:	84 c0                	test   %al,%al
80104ac2:	75 24                	jne    80104ae8 <argptr+0x58>
80104ac4:	8b 16                	mov    (%esi),%edx
80104ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac9:	39 c2                	cmp    %eax,%edx
80104acb:	76 1b                	jbe    80104ae8 <argptr+0x58>
80104acd:	01 c3                	add    %eax,%ebx
80104acf:	39 da                	cmp    %ebx,%edx
80104ad1:	72 15                	jb     80104ae8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80104ad3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ad6:	89 02                	mov    %eax,(%edx)
  return 0;
80104ad8:	31 c0                	xor    %eax,%eax
}
80104ada:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104add:	5b                   	pop    %ebx
80104ade:	5e                   	pop    %esi
80104adf:	5d                   	pop    %ebp
80104ae0:	c3                   	ret    
80104ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104ae8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104aed:	eb eb                	jmp    80104ada <argptr+0x4a>
80104aef:	90                   	nop

80104af0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104af6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104af9:	50                   	push   %eax
80104afa:	ff 75 08             	pushl  0x8(%ebp)
80104afd:	e8 3e ff ff ff       	call   80104a40 <argint>
80104b02:	83 c4 10             	add    $0x10,%esp
80104b05:	85 c0                	test   %eax,%eax
80104b07:	78 17                	js     80104b20 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104b09:	83 ec 08             	sub    $0x8,%esp
80104b0c:	ff 75 0c             	pushl  0xc(%ebp)
80104b0f:	ff 75 f4             	pushl  -0xc(%ebp)
80104b12:	e8 c9 fe ff ff       	call   801049e0 <fetchstr>
80104b17:	83 c4 10             	add    $0x10,%esp
}
80104b1a:	c9                   	leave  
80104b1b:	c3                   	ret    
80104b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80104b25:	c9                   	leave  
80104b26:	c3                   	ret    
80104b27:	89 f6                	mov    %esi,%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <syscall>:
[SYS_changeOwner] sys_changeOwner,
};

void
syscall(void)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80104b35:	e8 86 ed ff ff       	call   801038c0 <myproc>

  num = curproc->tf->eax;
80104b3a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80104b3d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b3f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b42:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b45:	83 fa 19             	cmp    $0x19,%edx
80104b48:	77 1e                	ja     80104b68 <syscall+0x38>
80104b4a:	8b 14 85 20 7d 10 80 	mov    -0x7fef82e0(,%eax,4),%edx
80104b51:	85 d2                	test   %edx,%edx
80104b53:	74 13                	je     80104b68 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104b55:	ff d2                	call   *%edx
80104b57:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b5d:	5b                   	pop    %ebx
80104b5e:	5e                   	pop    %esi
80104b5f:	5d                   	pop    %ebp
80104b60:	c3                   	ret    
80104b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104b68:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b69:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104b6c:	50                   	push   %eax
80104b6d:	ff 73 10             	pushl  0x10(%ebx)
80104b70:	68 f1 7c 10 80       	push   $0x80107cf1
80104b75:	e8 e6 ba ff ff       	call   80100660 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80104b7a:	8b 43 18             	mov    0x18(%ebx),%eax
80104b7d:	83 c4 10             	add    $0x10,%esp
80104b80:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104b87:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b8a:	5b                   	pop    %ebx
80104b8b:	5e                   	pop    %esi
80104b8c:	5d                   	pop    %ebp
80104b8d:	c3                   	ret    
80104b8e:	66 90                	xchg   %ax,%ax

80104b90 <create>:
  return ip;
}*/

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	57                   	push   %edi
80104b94:	56                   	push   %esi
80104b95:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104b96:	8d 75 da             	lea    -0x26(%ebp),%esi
  return ip;
}*/

static struct inode*
create(char *path, short type, short major, short minor)
{
80104b99:	83 ec 44             	sub    $0x44,%esp
80104b9c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104b9f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ba2:	56                   	push   %esi
80104ba3:	50                   	push   %eax
  return ip;
}*/

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ba4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104ba7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104baa:	e8 61 d4 ff ff       	call   80102010 <nameiparent>
80104baf:	83 c4 10             	add    $0x10,%esp
80104bb2:	85 c0                	test   %eax,%eax
80104bb4:	0f 84 f6 00 00 00    	je     80104cb0 <create+0x120>
    return 0;
  ilock(dp);
80104bba:	83 ec 0c             	sub    $0xc,%esp
80104bbd:	89 c7                	mov    %eax,%edi
80104bbf:	50                   	push   %eax
80104bc0:	e8 3b cb ff ff       	call   80101700 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104bc5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104bc8:	83 c4 0c             	add    $0xc,%esp
80104bcb:	50                   	push   %eax
80104bcc:	56                   	push   %esi
80104bcd:	57                   	push   %edi
80104bce:	e8 ed d0 ff ff       	call   80101cc0 <dirlookup>
80104bd3:	83 c4 10             	add    $0x10,%esp
80104bd6:	85 c0                	test   %eax,%eax
80104bd8:	89 c3                	mov    %eax,%ebx
80104bda:	74 54                	je     80104c30 <create+0xa0>
    iunlockput(dp);
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	57                   	push   %edi
80104be0:	e8 eb cd ff ff       	call   801019d0 <iunlockput>
    ilock(ip);
80104be5:	89 1c 24             	mov    %ebx,(%esp)
80104be8:	e8 13 cb ff ff       	call   80101700 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104bed:	83 c4 10             	add    $0x10,%esp
80104bf0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104bf5:	75 19                	jne    80104c10 <create+0x80>
80104bf7:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104bfc:	89 d8                	mov    %ebx,%eax
80104bfe:	75 10                	jne    80104c10 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c00:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c03:	5b                   	pop    %ebx
80104c04:	5e                   	pop    %esi
80104c05:	5f                   	pop    %edi
80104c06:	5d                   	pop    %ebp
80104c07:	c3                   	ret    
80104c08:	90                   	nop
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80104c10:	83 ec 0c             	sub    $0xc,%esp
80104c13:	53                   	push   %ebx
80104c14:	e8 b7 cd ff ff       	call   801019d0 <iunlockput>
    return 0;
80104c19:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80104c1f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c21:	5b                   	pop    %ebx
80104c22:	5e                   	pop    %esi
80104c23:	5f                   	pop    %edi
80104c24:	5d                   	pop    %ebp
80104c25:	c3                   	ret    
80104c26:	8d 76 00             	lea    0x0(%esi),%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104c30:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104c34:	83 ec 08             	sub    $0x8,%esp
80104c37:	50                   	push   %eax
80104c38:	ff 37                	pushl  (%edi)
80104c3a:	e8 21 c9 ff ff       	call   80101560 <ialloc>
80104c3f:	83 c4 10             	add    $0x10,%esp
80104c42:	85 c0                	test   %eax,%eax
80104c44:	89 c3                	mov    %eax,%ebx
80104c46:	0f 84 cf 00 00 00    	je     80104d1b <create+0x18b>
    panic("create: ialloc");

  ilock(ip);
80104c4c:	83 ec 0c             	sub    $0xc,%esp
80104c4f:	50                   	push   %eax
80104c50:	e8 ab ca ff ff       	call   80101700 <ilock>
  ip->major = major;
80104c55:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c59:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104c5d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c61:	66 89 83 14 01 00 00 	mov    %ax,0x114(%ebx)
  ip->nlink = 1;
80104c68:	b8 01 00 00 00       	mov    $0x1,%eax
80104c6d:	66 89 83 16 01 00 00 	mov    %ax,0x116(%ebx)
  iupdate(ip);
80104c74:	89 1c 24             	mov    %ebx,(%esp)
80104c77:	e8 a4 c9 ff ff       	call   80101620 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104c7c:	83 c4 10             	add    $0x10,%esp
80104c7f:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c84:	74 3a                	je     80104cc0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104c86:	83 ec 04             	sub    $0x4,%esp
80104c89:	ff 73 04             	pushl  0x4(%ebx)
80104c8c:	56                   	push   %esi
80104c8d:	57                   	push   %edi
80104c8e:	e8 9d d2 ff ff       	call   80101f30 <dirlink>
80104c93:	83 c4 10             	add    $0x10,%esp
80104c96:	85 c0                	test   %eax,%eax
80104c98:	78 74                	js     80104d0e <create+0x17e>
    panic("create: dirlink");

  iunlockput(dp);
80104c9a:	83 ec 0c             	sub    $0xc,%esp
80104c9d:	57                   	push   %edi
80104c9e:	e8 2d cd ff ff       	call   801019d0 <iunlockput>

  return ip;
80104ca3:	83 c4 10             	add    $0x10,%esp
}
80104ca6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104ca9:	89 d8                	mov    %ebx,%eax
}
80104cab:	5b                   	pop    %ebx
80104cac:	5e                   	pop    %esi
80104cad:	5f                   	pop    %edi
80104cae:	5d                   	pop    %ebp
80104caf:	c3                   	ret    
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104cb0:	31 c0                	xor    %eax,%eax
80104cb2:	e9 49 ff ff ff       	jmp    80104c00 <create+0x70>
80104cb7:	89 f6                	mov    %esi,%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104cc0:	66 83 87 16 01 00 00 	addw   $0x1,0x116(%edi)
80104cc7:	01 
    iupdate(dp);
80104cc8:	83 ec 0c             	sub    $0xc,%esp
80104ccb:	57                   	push   %edi
80104ccc:	e8 4f c9 ff ff       	call   80101620 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104cd1:	83 c4 0c             	add    $0xc,%esp
80104cd4:	ff 73 04             	pushl  0x4(%ebx)
80104cd7:	68 a8 7d 10 80       	push   $0x80107da8
80104cdc:	53                   	push   %ebx
80104cdd:	e8 4e d2 ff ff       	call   80101f30 <dirlink>
80104ce2:	83 c4 10             	add    $0x10,%esp
80104ce5:	85 c0                	test   %eax,%eax
80104ce7:	78 18                	js     80104d01 <create+0x171>
80104ce9:	83 ec 04             	sub    $0x4,%esp
80104cec:	ff 77 04             	pushl  0x4(%edi)
80104cef:	68 a7 7d 10 80       	push   $0x80107da7
80104cf4:	53                   	push   %ebx
80104cf5:	e8 36 d2 ff ff       	call   80101f30 <dirlink>
80104cfa:	83 c4 10             	add    $0x10,%esp
80104cfd:	85 c0                	test   %eax,%eax
80104cff:	79 85                	jns    80104c86 <create+0xf6>
      panic("create dots");
80104d01:	83 ec 0c             	sub    $0xc,%esp
80104d04:	68 9b 7d 10 80       	push   $0x80107d9b
80104d09:	e8 62 b6 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104d0e:	83 ec 0c             	sub    $0xc,%esp
80104d11:	68 aa 7d 10 80       	push   $0x80107daa
80104d16:	e8 55 b6 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104d1b:	83 ec 0c             	sub    $0xc,%esp
80104d1e:	68 8c 7d 10 80       	push   $0x80107d8c
80104d23:	e8 48 b6 ff ff       	call   80100370 <panic>
80104d28:	90                   	nop
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d30 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	56                   	push   %esi
80104d34:	53                   	push   %ebx
80104d35:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104d37:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104d3a:	89 d3                	mov    %edx,%ebx
80104d3c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104d3f:	50                   	push   %eax
80104d40:	6a 00                	push   $0x0
80104d42:	e8 f9 fc ff ff       	call   80104a40 <argint>
80104d47:	83 c4 10             	add    $0x10,%esp
80104d4a:	85 c0                	test   %eax,%eax
80104d4c:	78 32                	js     80104d80 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d4e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d52:	77 2c                	ja     80104d80 <argfd.constprop.0+0x50>
80104d54:	e8 67 eb ff ff       	call   801038c0 <myproc>
80104d59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d5c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104d60:	85 c0                	test   %eax,%eax
80104d62:	74 1c                	je     80104d80 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80104d64:	85 f6                	test   %esi,%esi
80104d66:	74 02                	je     80104d6a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104d68:	89 16                	mov    %edx,(%esi)
  if(pf)
80104d6a:	85 db                	test   %ebx,%ebx
80104d6c:	74 22                	je     80104d90 <argfd.constprop.0+0x60>
    *pf = f;
80104d6e:	89 03                	mov    %eax,(%ebx)
  return 0;
80104d70:	31 c0                	xor    %eax,%eax
}
80104d72:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d75:	5b                   	pop    %ebx
80104d76:	5e                   	pop    %esi
80104d77:	5d                   	pop    %ebp
80104d78:	c3                   	ret    
80104d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d80:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104d83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80104d88:	5b                   	pop    %ebx
80104d89:	5e                   	pop    %esi
80104d8a:	5d                   	pop    %ebp
80104d8b:	c3                   	ret    
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104d90:	31 c0                	xor    %eax,%eax
80104d92:	eb de                	jmp    80104d72 <argfd.constprop.0+0x42>
80104d94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104da0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104da0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104da1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104da3:	89 e5                	mov    %esp,%ebp
80104da5:	56                   	push   %esi
80104da6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104da7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104daa:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104dad:	e8 7e ff ff ff       	call   80104d30 <argfd.constprop.0>
80104db2:	85 c0                	test   %eax,%eax
80104db4:	78 1a                	js     80104dd0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104db6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80104db8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80104dbb:	e8 00 eb ff ff       	call   801038c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80104dc0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104dc4:	85 d2                	test   %edx,%edx
80104dc6:	74 18                	je     80104de0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104dc8:	83 c3 01             	add    $0x1,%ebx
80104dcb:	83 fb 10             	cmp    $0x10,%ebx
80104dce:	75 f0                	jne    80104dc0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104dd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104dd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104dd8:	5b                   	pop    %ebx
80104dd9:	5e                   	pop    %esi
80104dda:	5d                   	pop    %ebp
80104ddb:	c3                   	ret    
80104ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104de0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104de4:	83 ec 0c             	sub    $0xc,%esp
80104de7:	ff 75 f4             	pushl  -0xc(%ebp)
80104dea:	e8 f1 bf ff ff       	call   80100de0 <filedup>
  return fd;
80104def:	83 c4 10             	add    $0x10,%esp
}
80104df2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80104df5:	89 d8                	mov    %ebx,%eax
}
80104df7:	5b                   	pop    %ebx
80104df8:	5e                   	pop    %esi
80104df9:	5d                   	pop    %ebp
80104dfa:	c3                   	ret    
80104dfb:	90                   	nop
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e00 <sys_read>:

int
sys_read(void)
{
80104e00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e01:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104e03:	89 e5                	mov    %esp,%ebp
80104e05:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e0b:	e8 20 ff ff ff       	call   80104d30 <argfd.constprop.0>
80104e10:	85 c0                	test   %eax,%eax
80104e12:	78 4c                	js     80104e60 <sys_read+0x60>
80104e14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e17:	83 ec 08             	sub    $0x8,%esp
80104e1a:	50                   	push   %eax
80104e1b:	6a 02                	push   $0x2
80104e1d:	e8 1e fc ff ff       	call   80104a40 <argint>
80104e22:	83 c4 10             	add    $0x10,%esp
80104e25:	85 c0                	test   %eax,%eax
80104e27:	78 37                	js     80104e60 <sys_read+0x60>
80104e29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e2c:	83 ec 04             	sub    $0x4,%esp
80104e2f:	ff 75 f0             	pushl  -0x10(%ebp)
80104e32:	50                   	push   %eax
80104e33:	6a 01                	push   $0x1
80104e35:	e8 56 fc ff ff       	call   80104a90 <argptr>
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 c0                	test   %eax,%eax
80104e3f:	78 1f                	js     80104e60 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104e41:	83 ec 04             	sub    $0x4,%esp
80104e44:	ff 75 f0             	pushl  -0x10(%ebp)
80104e47:	ff 75 f4             	pushl  -0xc(%ebp)
80104e4a:	ff 75 ec             	pushl  -0x14(%ebp)
80104e4d:	e8 4e c1 ff ff       	call   80100fa0 <fileread>
80104e52:	83 c4 10             	add    $0x10,%esp
  //return fileread(f, p, n, 0);
}
80104e55:	c9                   	leave  
80104e56:	c3                   	ret    
80104e57:	89 f6                	mov    %esi,%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104e60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
  //return fileread(f, p, n, 0);
}
80104e65:	c9                   	leave  
80104e66:	c3                   	ret    
80104e67:	89 f6                	mov    %esi,%esi
80104e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e70 <sys_write>:

int
sys_write(void)
{
80104e70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e71:	31 c0                	xor    %eax,%eax
  //return fileread(f, p, n, 0);
}

int
sys_write(void)
{
80104e73:	89 e5                	mov    %esp,%ebp
80104e75:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104e7b:	e8 b0 fe ff ff       	call   80104d30 <argfd.constprop.0>
80104e80:	85 c0                	test   %eax,%eax
80104e82:	78 4c                	js     80104ed0 <sys_write+0x60>
80104e84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e87:	83 ec 08             	sub    $0x8,%esp
80104e8a:	50                   	push   %eax
80104e8b:	6a 02                	push   $0x2
80104e8d:	e8 ae fb ff ff       	call   80104a40 <argint>
80104e92:	83 c4 10             	add    $0x10,%esp
80104e95:	85 c0                	test   %eax,%eax
80104e97:	78 37                	js     80104ed0 <sys_write+0x60>
80104e99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104e9c:	83 ec 04             	sub    $0x4,%esp
80104e9f:	ff 75 f0             	pushl  -0x10(%ebp)
80104ea2:	50                   	push   %eax
80104ea3:	6a 01                	push   $0x1
80104ea5:	e8 e6 fb ff ff       	call   80104a90 <argptr>
80104eaa:	83 c4 10             	add    $0x10,%esp
80104ead:	85 c0                	test   %eax,%eax
80104eaf:	78 1f                	js     80104ed0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104eb1:	83 ec 04             	sub    $0x4,%esp
80104eb4:	ff 75 f0             	pushl  -0x10(%ebp)
80104eb7:	ff 75 f4             	pushl  -0xc(%ebp)
80104eba:	ff 75 ec             	pushl  -0x14(%ebp)
80104ebd:	e8 7e c1 ff ff       	call   80101040 <filewrite>
80104ec2:	83 c4 10             	add    $0x10,%esp
  //return filewrite(f, p, n, 0);
}
80104ec5:	c9                   	leave  
80104ec6:	c3                   	ret    
80104ec7:	89 f6                	mov    %esi,%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
  //return filewrite(f, p, n, 0);
}
80104ed5:	c9                   	leave  
80104ed6:	c3                   	ret    
80104ed7:	89 f6                	mov    %esi,%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <sys_close>:

int
sys_close(void)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104ee6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ee9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104eec:	e8 3f fe ff ff       	call   80104d30 <argfd.constprop.0>
80104ef1:	85 c0                	test   %eax,%eax
80104ef3:	78 2b                	js     80104f20 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80104ef5:	e8 c6 e9 ff ff       	call   801038c0 <myproc>
80104efa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80104efd:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80104f00:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104f07:	00 
  fileclose(f);
80104f08:	ff 75 f4             	pushl  -0xc(%ebp)
80104f0b:	e8 20 bf ff ff       	call   80100e30 <fileclose>
  return 0;
80104f10:	83 c4 10             	add    $0x10,%esp
80104f13:	31 c0                	xor    %eax,%eax
}
80104f15:	c9                   	leave  
80104f16:	c3                   	ret    
80104f17:	89 f6                	mov    %esi,%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104f25:	c9                   	leave  
80104f26:	c3                   	ret    
80104f27:	89 f6                	mov    %esi,%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <sys_fstat>:

int
sys_fstat(void)
{
80104f30:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f31:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104f33:	89 e5                	mov    %esp,%ebp
80104f35:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f38:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104f3b:	e8 f0 fd ff ff       	call   80104d30 <argfd.constprop.0>
80104f40:	85 c0                	test   %eax,%eax
80104f42:	78 34                	js     80104f78 <sys_fstat+0x48>
80104f44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f47:	83 ec 04             	sub    $0x4,%esp
80104f4a:	68 d4 00 00 00       	push   $0xd4
80104f4f:	50                   	push   %eax
80104f50:	6a 01                	push   $0x1
80104f52:	e8 39 fb ff ff       	call   80104a90 <argptr>
80104f57:	83 c4 10             	add    $0x10,%esp
80104f5a:	85 c0                	test   %eax,%eax
80104f5c:	78 1a                	js     80104f78 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
80104f5e:	83 ec 08             	sub    $0x8,%esp
80104f61:	ff 75 f4             	pushl  -0xc(%ebp)
80104f64:	ff 75 f0             	pushl  -0x10(%ebp)
80104f67:	e8 e4 bf ff ff       	call   80100f50 <filestat>
80104f6c:	83 c4 10             	add    $0x10,%esp
}
80104f6f:	c9                   	leave  
80104f70:	c3                   	ret    
80104f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104f7d:	c9                   	leave  
80104f7e:	c3                   	ret    
80104f7f:	90                   	nop

80104f80 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f86:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104f89:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f8c:	50                   	push   %eax
80104f8d:	6a 00                	push   $0x0
80104f8f:	e8 5c fb ff ff       	call   80104af0 <argstr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	0f 88 fe 00 00 00    	js     8010509d <sys_link+0x11d>
80104f9f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104fa2:	83 ec 08             	sub    $0x8,%esp
80104fa5:	50                   	push   %eax
80104fa6:	6a 01                	push   $0x1
80104fa8:	e8 43 fb ff ff       	call   80104af0 <argstr>
80104fad:	83 c4 10             	add    $0x10,%esp
80104fb0:	85 c0                	test   %eax,%eax
80104fb2:	0f 88 e5 00 00 00    	js     8010509d <sys_link+0x11d>
    return -1;

  begin_op();
80104fb8:	e8 c3 dc ff ff       	call   80102c80 <begin_op>
  if((ip = namei(old)) == 0){
80104fbd:	83 ec 0c             	sub    $0xc,%esp
80104fc0:	ff 75 d4             	pushl  -0x2c(%ebp)
80104fc3:	e8 28 d0 ff ff       	call   80101ff0 <namei>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	85 c0                	test   %eax,%eax
80104fcd:	89 c3                	mov    %eax,%ebx
80104fcf:	0f 84 f3 00 00 00    	je     801050c8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104fd5:	83 ec 0c             	sub    $0xc,%esp
80104fd8:	50                   	push   %eax
80104fd9:	e8 22 c7 ff ff       	call   80101700 <ilock>
  if(ip->type == T_DIR){
80104fde:	83 c4 10             	add    $0x10,%esp
80104fe1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fe6:	0f 84 c4 00 00 00    	je     801050b0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104fec:	66 83 83 16 01 00 00 	addw   $0x1,0x116(%ebx)
80104ff3:	01 
  iupdate(ip);
80104ff4:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104ff7:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104ffa:	53                   	push   %ebx
80104ffb:	e8 20 c6 ff ff       	call   80101620 <iupdate>
  iunlock(ip);
80105000:	89 1c 24             	mov    %ebx,(%esp)
80105003:	e8 08 c8 ff ff       	call   80101810 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105008:	58                   	pop    %eax
80105009:	5a                   	pop    %edx
8010500a:	57                   	push   %edi
8010500b:	ff 75 d0             	pushl  -0x30(%ebp)
8010500e:	e8 fd cf ff ff       	call   80102010 <nameiparent>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	85 c0                	test   %eax,%eax
80105018:	89 c6                	mov    %eax,%esi
8010501a:	74 58                	je     80105074 <sys_link+0xf4>
    goto bad;
  ilock(dp);
8010501c:	83 ec 0c             	sub    $0xc,%esp
8010501f:	50                   	push   %eax
80105020:	e8 db c6 ff ff       	call   80101700 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105025:	83 c4 10             	add    $0x10,%esp
80105028:	8b 03                	mov    (%ebx),%eax
8010502a:	39 06                	cmp    %eax,(%esi)
8010502c:	75 3a                	jne    80105068 <sys_link+0xe8>
8010502e:	83 ec 04             	sub    $0x4,%esp
80105031:	ff 73 04             	pushl  0x4(%ebx)
80105034:	57                   	push   %edi
80105035:	56                   	push   %esi
80105036:	e8 f5 ce ff ff       	call   80101f30 <dirlink>
8010503b:	83 c4 10             	add    $0x10,%esp
8010503e:	85 c0                	test   %eax,%eax
80105040:	78 26                	js     80105068 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80105042:	83 ec 0c             	sub    $0xc,%esp
80105045:	56                   	push   %esi
80105046:	e8 85 c9 ff ff       	call   801019d0 <iunlockput>
  iput(ip);
8010504b:	89 1c 24             	mov    %ebx,(%esp)
8010504e:	e8 0d c8 ff ff       	call   80101860 <iput>

  end_op();
80105053:	e8 98 dc ff ff       	call   80102cf0 <end_op>

  return 0;
80105058:	83 c4 10             	add    $0x10,%esp
8010505b:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010505d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105060:	5b                   	pop    %ebx
80105061:	5e                   	pop    %esi
80105062:	5f                   	pop    %edi
80105063:	5d                   	pop    %ebp
80105064:	c3                   	ret    
80105065:	8d 76 00             	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105068:	83 ec 0c             	sub    $0xc,%esp
8010506b:	56                   	push   %esi
8010506c:	e8 5f c9 ff ff       	call   801019d0 <iunlockput>
    goto bad;
80105071:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105074:	83 ec 0c             	sub    $0xc,%esp
80105077:	53                   	push   %ebx
80105078:	e8 83 c6 ff ff       	call   80101700 <ilock>
  ip->nlink--;
8010507d:	66 83 ab 16 01 00 00 	subw   $0x1,0x116(%ebx)
80105084:	01 
  iupdate(ip);
80105085:	89 1c 24             	mov    %ebx,(%esp)
80105088:	e8 93 c5 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
8010508d:	89 1c 24             	mov    %ebx,(%esp)
80105090:	e8 3b c9 ff ff       	call   801019d0 <iunlockput>
  end_op();
80105095:	e8 56 dc ff ff       	call   80102cf0 <end_op>
  return -1;
8010509a:	83 c4 10             	add    $0x10,%esp
}
8010509d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050a5:	5b                   	pop    %ebx
801050a6:	5e                   	pop    %esi
801050a7:	5f                   	pop    %edi
801050a8:	5d                   	pop    %ebp
801050a9:	c3                   	ret    
801050aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
801050b0:	83 ec 0c             	sub    $0xc,%esp
801050b3:	53                   	push   %ebx
801050b4:	e8 17 c9 ff ff       	call   801019d0 <iunlockput>
    end_op();
801050b9:	e8 32 dc ff ff       	call   80102cf0 <end_op>
    return -1;
801050be:	83 c4 10             	add    $0x10,%esp
801050c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050c6:	eb 95                	jmp    8010505d <sys_link+0xdd>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
801050c8:	e8 23 dc ff ff       	call   80102cf0 <end_op>
    return -1;
801050cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050d2:	eb 89                	jmp    8010505d <sys_link+0xdd>
801050d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801050e0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	57                   	push   %edi
801050e4:	56                   	push   %esi
801050e5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801050e6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
801050e9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801050ec:	50                   	push   %eax
801050ed:	6a 00                	push   $0x0
801050ef:	e8 fc f9 ff ff       	call   80104af0 <argstr>
801050f4:	83 c4 10             	add    $0x10,%esp
801050f7:	85 c0                	test   %eax,%eax
801050f9:	0f 88 95 01 00 00    	js     80105294 <sys_unlink+0x1b4>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801050ff:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105102:	e8 79 db ff ff       	call   80102c80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105107:	83 ec 08             	sub    $0x8,%esp
8010510a:	53                   	push   %ebx
8010510b:	ff 75 c0             	pushl  -0x40(%ebp)
8010510e:	e8 fd ce ff ff       	call   80102010 <nameiparent>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	85 c0                	test   %eax,%eax
80105118:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010511b:	0f 84 7d 01 00 00    	je     8010529e <sys_unlink+0x1be>
    end_op();
    return -1;
  }

  ilock(dp);
80105121:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	56                   	push   %esi
80105128:	e8 d3 c5 ff ff       	call   80101700 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010512d:	58                   	pop    %eax
8010512e:	5a                   	pop    %edx
8010512f:	68 a8 7d 10 80       	push   $0x80107da8
80105134:	53                   	push   %ebx
80105135:	e8 66 cb ff ff       	call   80101ca0 <namecmp>
8010513a:	83 c4 10             	add    $0x10,%esp
8010513d:	85 c0                	test   %eax,%eax
8010513f:	0f 84 0f 01 00 00    	je     80105254 <sys_unlink+0x174>
80105145:	83 ec 08             	sub    $0x8,%esp
80105148:	68 a7 7d 10 80       	push   $0x80107da7
8010514d:	53                   	push   %ebx
8010514e:	e8 4d cb ff ff       	call   80101ca0 <namecmp>
80105153:	83 c4 10             	add    $0x10,%esp
80105156:	85 c0                	test   %eax,%eax
80105158:	0f 84 f6 00 00 00    	je     80105254 <sys_unlink+0x174>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010515e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105161:	83 ec 04             	sub    $0x4,%esp
80105164:	50                   	push   %eax
80105165:	53                   	push   %ebx
80105166:	56                   	push   %esi
80105167:	e8 54 cb ff ff       	call   80101cc0 <dirlookup>
8010516c:	83 c4 10             	add    $0x10,%esp
8010516f:	85 c0                	test   %eax,%eax
80105171:	89 c3                	mov    %eax,%ebx
80105173:	0f 84 db 00 00 00    	je     80105254 <sys_unlink+0x174>
    goto bad;
  ilock(ip);
80105179:	83 ec 0c             	sub    $0xc,%esp
8010517c:	50                   	push   %eax
8010517d:	e8 7e c5 ff ff       	call   80101700 <ilock>

  if(ip->nlink < 1)
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	66 83 bb 16 01 00 00 	cmpw   $0x0,0x116(%ebx)
8010518c:	00 
8010518d:	0f 8e 34 01 00 00    	jle    801052c7 <sys_unlink+0x1e7>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105193:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105198:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010519b:	74 6b                	je     80105208 <sys_unlink+0x128>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010519d:	83 ec 04             	sub    $0x4,%esp
801051a0:	6a 10                	push   $0x10
801051a2:	6a 00                	push   $0x0
801051a4:	56                   	push   %esi
801051a5:	e8 86 f5 ff ff       	call   80104730 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051aa:	6a 10                	push   $0x10
801051ac:	ff 75 c4             	pushl  -0x3c(%ebp)
801051af:	56                   	push   %esi
801051b0:	ff 75 b4             	pushl  -0x4c(%ebp)
801051b3:	e8 b8 c9 ff ff       	call   80101b70 <writei>
801051b8:	83 c4 20             	add    $0x20,%esp
801051bb:	83 f8 10             	cmp    $0x10,%eax
801051be:	0f 85 f6 00 00 00    	jne    801052ba <sys_unlink+0x1da>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801051c4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051c9:	0f 84 a9 00 00 00    	je     80105278 <sys_unlink+0x198>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801051cf:	83 ec 0c             	sub    $0xc,%esp
801051d2:	ff 75 b4             	pushl  -0x4c(%ebp)
801051d5:	e8 f6 c7 ff ff       	call   801019d0 <iunlockput>

  ip->nlink--;
801051da:	66 83 ab 16 01 00 00 	subw   $0x1,0x116(%ebx)
801051e1:	01 
  iupdate(ip);
801051e2:	89 1c 24             	mov    %ebx,(%esp)
801051e5:	e8 36 c4 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
801051ea:	89 1c 24             	mov    %ebx,(%esp)
801051ed:	e8 de c7 ff ff       	call   801019d0 <iunlockput>

  end_op();
801051f2:	e8 f9 da ff ff       	call   80102cf0 <end_op>

  return 0;
801051f7:	83 c4 10             	add    $0x10,%esp
801051fa:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801051fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ff:	5b                   	pop    %ebx
80105200:	5e                   	pop    %esi
80105201:	5f                   	pop    %edi
80105202:	5d                   	pop    %ebp
80105203:	c3                   	ret    
80105204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105208:	83 bb 18 01 00 00 20 	cmpl   $0x20,0x118(%ebx)
8010520f:	76 8c                	jbe    8010519d <sys_unlink+0xbd>
80105211:	bf 20 00 00 00       	mov    $0x20,%edi
80105216:	eb 17                	jmp    8010522f <sys_unlink+0x14f>
80105218:	90                   	nop
80105219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105220:	83 c7 10             	add    $0x10,%edi
80105223:	3b bb 18 01 00 00    	cmp    0x118(%ebx),%edi
80105229:	0f 83 6e ff ff ff    	jae    8010519d <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010522f:	6a 10                	push   $0x10
80105231:	57                   	push   %edi
80105232:	56                   	push   %esi
80105233:	53                   	push   %ebx
80105234:	e8 37 c8 ff ff       	call   80101a70 <readi>
80105239:	83 c4 10             	add    $0x10,%esp
8010523c:	83 f8 10             	cmp    $0x10,%eax
8010523f:	75 6c                	jne    801052ad <sys_unlink+0x1cd>
      panic("isdirempty: readi");
    if(de.inum != 0)
80105241:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105246:	74 d8                	je     80105220 <sys_unlink+0x140>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105248:	83 ec 0c             	sub    $0xc,%esp
8010524b:	53                   	push   %ebx
8010524c:	e8 7f c7 ff ff       	call   801019d0 <iunlockput>
    goto bad;
80105251:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105254:	83 ec 0c             	sub    $0xc,%esp
80105257:	ff 75 b4             	pushl  -0x4c(%ebp)
8010525a:	e8 71 c7 ff ff       	call   801019d0 <iunlockput>
  end_op();
8010525f:	e8 8c da ff ff       	call   80102cf0 <end_op>
  return -1;
80105264:	83 c4 10             	add    $0x10,%esp
}
80105267:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
8010526a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010526f:	5b                   	pop    %ebx
80105270:	5e                   	pop    %esi
80105271:	5f                   	pop    %edi
80105272:	5d                   	pop    %ebp
80105273:	c3                   	ret    
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105278:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010527b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010527e:	66 83 a8 16 01 00 00 	subw   $0x1,0x116(%eax)
80105285:	01 
    iupdate(dp);
80105286:	50                   	push   %eax
80105287:	e8 94 c3 ff ff       	call   80101620 <iupdate>
8010528c:	83 c4 10             	add    $0x10,%esp
8010528f:	e9 3b ff ff ff       	jmp    801051cf <sys_unlink+0xef>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105294:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105299:	e9 5e ff ff ff       	jmp    801051fc <sys_unlink+0x11c>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010529e:	e8 4d da ff ff       	call   80102cf0 <end_op>
    return -1;
801052a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052a8:	e9 4f ff ff ff       	jmp    801051fc <sys_unlink+0x11c>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801052ad:	83 ec 0c             	sub    $0xc,%esp
801052b0:	68 cc 7d 10 80       	push   $0x80107dcc
801052b5:	e8 b6 b0 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801052ba:	83 ec 0c             	sub    $0xc,%esp
801052bd:	68 de 7d 10 80       	push   $0x80107dde
801052c2:	e8 a9 b0 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801052c7:	83 ec 0c             	sub    $0xc,%esp
801052ca:	68 ba 7d 10 80       	push   $0x80107dba
801052cf:	e8 9c b0 ff ff       	call   80100370 <panic>
801052d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801052e0 <sys_open>:
  return fd;
}*/

int
sys_open(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	57                   	push   %edi
801052e4:	56                   	push   %esi
801052e5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052e6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return fd;
}*/

int
sys_open(void)
{
801052e9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052ec:	50                   	push   %eax
801052ed:	6a 00                	push   $0x0
801052ef:	e8 fc f7 ff ff       	call   80104af0 <argstr>
801052f4:	83 c4 10             	add    $0x10,%esp
801052f7:	85 c0                	test   %eax,%eax
801052f9:	0f 88 42 02 00 00    	js     80105541 <sys_open+0x261>
801052ff:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105302:	83 ec 08             	sub    $0x8,%esp
80105305:	50                   	push   %eax
80105306:	6a 01                	push   $0x1
80105308:	e8 33 f7 ff ff       	call   80104a40 <argint>
8010530d:	83 c4 10             	add    $0x10,%esp
80105310:	85 c0                	test   %eax,%eax
80105312:	0f 88 29 02 00 00    	js     80105541 <sys_open+0x261>
    {
	//cprintf("path: %s\n", path);
	//cprintf("mode: %s\n", omode);
	return -1;
    }
  begin_op();
80105318:	e8 63 d9 ff ff       	call   80102c80 <begin_op>
  //cprintf("open with user: %s\n", myproc()->currentUser);
  char *temp;
  argstr(0, &temp);
8010531d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105320:	83 ec 08             	sub    $0x8,%esp
80105323:	50                   	push   %eax
80105324:	6a 00                	push   $0x0
80105326:	e8 c5 f7 ff ff       	call   80104af0 <argstr>
  if(omode & O_CREATE){
8010532b:	83 c4 10             	add    $0x10,%esp
8010532e:	f6 45 e1 02          	testb  $0x2,-0x1f(%ebp)
80105332:	0f 85 e8 00 00 00    	jne    80105420 <sys_open+0x140>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105338:	83 ec 0c             	sub    $0xc,%esp
8010533b:	ff 75 dc             	pushl  -0x24(%ebp)
8010533e:	e8 ad cc ff ff       	call   80101ff0 <namei>
80105343:	83 c4 10             	add    $0x10,%esp
80105346:	85 c0                	test   %eax,%eax
80105348:	89 c6                	mov    %eax,%esi
8010534a:	0f 84 1c 01 00 00    	je     8010546c <sys_open+0x18c>
	//cprintf("wrong path: %s\n", path);
      end_op();
      return -1;
    }
    ilock(ip);
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	50                   	push   %eax
80105354:	e8 a7 c3 ff ff       	call   80101700 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105359:	83 c4 10             	add    $0x10,%esp
8010535c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105361:	0f 84 e9 01 00 00    	je     80105550 <sys_open+0x270>
80105367:	8d 5e 54             	lea    0x54(%esi),%ebx
      iunlockput(ip);
      end_op();
      return -1;
    }
  }
  if(strncmp(ip->uProp.name, "", strlen(ip->uProp.name) + 1) != 0)
8010536a:	83 ec 0c             	sub    $0xc,%esp
8010536d:	53                   	push   %ebx
8010536e:	e8 fd f5 ff ff       	call   80104970 <strlen>
80105373:	83 c4 0c             	add    $0xc,%esp
80105376:	83 c0 01             	add    $0x1,%eax
80105379:	50                   	push   %eax
8010537a:	68 4d 7c 10 80       	push   $0x80107c4d
8010537f:	53                   	push   %ebx
80105380:	e8 db f4 ff ff       	call   80104860 <strncmp>
80105385:	83 c4 10             	add    $0x10,%esp
80105388:	85 c0                	test   %eax,%eax
8010538a:	74 38                	je     801053c4 <sys_open+0xe4>
  {
	if(strncmp(myproc()->currentUser, "Admin", strlen(myproc()->currentUser) + 1) != 0)
8010538c:	e8 2f e5 ff ff       	call   801038c0 <myproc>
80105391:	83 ec 0c             	sub    $0xc,%esp
80105394:	83 c0 7c             	add    $0x7c,%eax
80105397:	50                   	push   %eax
80105398:	e8 d3 f5 ff ff       	call   80104970 <strlen>
8010539d:	89 c7                	mov    %eax,%edi
8010539f:	83 c7 01             	add    $0x1,%edi
801053a2:	e8 19 e5 ff ff       	call   801038c0 <myproc>
801053a7:	83 c4 0c             	add    $0xc,%esp
801053aa:	83 c0 7c             	add    $0x7c,%eax
801053ad:	57                   	push   %edi
801053ae:	68 70 7b 10 80       	push   $0x80107b70
801053b3:	50                   	push   %eax
801053b4:	e8 a7 f4 ff ff       	call   80104860 <strncmp>
801053b9:	83 c4 10             	add    $0x10,%esp
801053bc:	85 c0                	test   %eax,%eax
801053be:	0f 85 2c 01 00 00    	jne    801054f0 <sys_open+0x210>
      			end_op();
			return -1;
		}
	}
  }
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801053c4:	e8 a7 b9 ff ff       	call   80100d70 <filealloc>
801053c9:	85 c0                	test   %eax,%eax
801053cb:	89 c7                	mov    %eax,%edi
801053cd:	74 31                	je     80105400 <sys_open+0x120>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801053cf:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801053d1:	e8 ea e4 ff ff       	call   801038c0 <myproc>
801053d6:	8d 76 00             	lea    0x0(%esi),%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801053e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801053e4:	85 d2                	test   %edx,%edx
801053e6:	0f 84 94 00 00 00    	je     80105480 <sys_open+0x1a0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801053ec:	83 c3 01             	add    $0x1,%ebx
801053ef:	83 fb 10             	cmp    $0x10,%ebx
801053f2:	75 ec                	jne    801053e0 <sys_open+0x100>
	}
  }
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
  //if((f = filealloc(myproc()->currentUser)) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
801053f4:	83 ec 0c             	sub    $0xc,%esp
801053f7:	57                   	push   %edi
801053f8:	e8 33 ba ff ff       	call   80100e30 <fileclose>
801053fd:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	56                   	push   %esi
80105404:	e8 c7 c5 ff ff       	call   801019d0 <iunlockput>
    end_op();
80105409:	e8 e2 d8 ff ff       	call   80102cf0 <end_op>
    return -1;
8010540e:	83 c4 10             	add    $0x10,%esp
80105411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105416:	e9 c3 00 00 00       	jmp    801054de <sys_open+0x1fe>
8010541b:	90                   	nop
8010541c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  //cprintf("open with user: %s\n", myproc()->currentUser);
  char *temp;
  argstr(0, &temp);
  if(omode & O_CREATE){
	//cprintf("\n\ncreateFile\n\n");
    ip = create(path, T_FILE, 0, 0);
80105420:	83 ec 0c             	sub    $0xc,%esp
80105423:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105426:	31 c9                	xor    %ecx,%ecx
80105428:	6a 00                	push   $0x0
8010542a:	ba 02 00 00 00       	mov    $0x2,%edx
8010542f:	e8 5c f7 ff ff       	call   80104b90 <create>
80105434:	89 c6                	mov    %eax,%esi
    safestrcpy(ip->uProp.name, myproc()->currentUser, strlen(myproc()->currentUser) + 1);
80105436:	e8 85 e4 ff ff       	call   801038c0 <myproc>
8010543b:	83 c0 7c             	add    $0x7c,%eax
8010543e:	8d 5e 54             	lea    0x54(%esi),%ebx
80105441:	89 04 24             	mov    %eax,(%esp)
80105444:	e8 27 f5 ff ff       	call   80104970 <strlen>
80105449:	89 c7                	mov    %eax,%edi
8010544b:	83 c7 01             	add    $0x1,%edi
8010544e:	e8 6d e4 ff ff       	call   801038c0 <myproc>
80105453:	83 c4 0c             	add    $0xc,%esp
80105456:	83 c0 7c             	add    $0x7c,%eax
80105459:	57                   	push   %edi
8010545a:	50                   	push   %eax
8010545b:	53                   	push   %ebx
8010545c:	e8 cf f4 ff ff       	call   80104930 <safestrcpy>
    if(ip == 0){
80105461:	83 c4 10             	add    $0x10,%esp
80105464:	85 f6                	test   %esi,%esi
80105466:	0f 85 fe fe ff ff    	jne    8010536a <sys_open+0x8a>
      end_op();
8010546c:	e8 7f d8 ff ff       	call   80102cf0 <end_op>
      return -1;
80105471:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105476:	eb 66                	jmp    801054de <sys_open+0x1fe>
80105478:	90                   	nop
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105480:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105483:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105487:	56                   	push   %esi
80105488:	e8 83 c3 ff ff       	call   80101810 <iunlock>
  end_op();  
8010548d:	e8 5e d8 ff ff       	call   80102cf0 <end_op>
  
  
  safestrcpy(f->name, temp, strlen(temp) + 1);
80105492:	58                   	pop    %eax
80105493:	ff 75 e4             	pushl  -0x1c(%ebp)
80105496:	e8 d5 f4 ff ff       	call   80104970 <strlen>
8010549b:	83 c4 0c             	add    $0xc,%esp
8010549e:	83 c0 01             	add    $0x1,%eax
801054a1:	50                   	push   %eax
801054a2:	8d 87 d8 00 00 00    	lea    0xd8(%edi),%eax
801054a8:	ff 75 e4             	pushl  -0x1c(%ebp)
801054ab:	50                   	push   %eax
801054ac:	e8 7f f4 ff ff       	call   80104930 <safestrcpy>
  f->type = FD_INODE;
801054b1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054b7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054ba:	83 c4 10             	add    $0x10,%esp
  end_op();  
  
  
  safestrcpy(f->name, temp, strlen(temp) + 1);
  f->type = FD_INODE;
  f->ip = ip;
801054bd:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801054c0:	c7 87 d4 00 00 00 00 	movl   $0x0,0xd4(%edi)
801054c7:	00 00 00 
  f->readable = !(omode & O_WRONLY);
801054ca:	89 d0                	mov    %edx,%eax
801054cc:	83 e0 01             	and    $0x1,%eax
801054cf:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054d2:	83 e2 03             	and    $0x3,%edx
  
  safestrcpy(f->name, temp, strlen(temp) + 1);
  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054d5:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054d8:	0f 95 47 09          	setne  0x9(%edi)
  //safestrcpy(f->uProp.name, myproc()->currentUser, strlen(myproc()->currentUser) + 1);
  //cprintf("IP owner: %s\n", ip->uProp.name);
  return fd;
801054dc:	89 d8                	mov    %ebx,%eax
}
801054de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054e1:	5b                   	pop    %ebx
801054e2:	5e                   	pop    %esi
801054e3:	5f                   	pop    %edi
801054e4:	5d                   	pop    %ebp
801054e5:	c3                   	ret    
801054e6:	8d 76 00             	lea    0x0(%esi),%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
  if(strncmp(ip->uProp.name, "", strlen(ip->uProp.name) + 1) != 0)
  {
	if(strncmp(myproc()->currentUser, "Admin", strlen(myproc()->currentUser) + 1) != 0)
	{
		if(strncmp(myproc()->currentUser, ip->uProp.name, strlen(myproc()->currentUser) + 1) != 0)
801054f0:	e8 cb e3 ff ff       	call   801038c0 <myproc>
801054f5:	83 ec 0c             	sub    $0xc,%esp
801054f8:	83 c0 7c             	add    $0x7c,%eax
801054fb:	50                   	push   %eax
801054fc:	e8 6f f4 ff ff       	call   80104970 <strlen>
80105501:	89 c7                	mov    %eax,%edi
80105503:	83 c7 01             	add    $0x1,%edi
80105506:	e8 b5 e3 ff ff       	call   801038c0 <myproc>
8010550b:	83 c4 0c             	add    $0xc,%esp
8010550e:	83 c0 7c             	add    $0x7c,%eax
80105511:	57                   	push   %edi
80105512:	53                   	push   %ebx
80105513:	50                   	push   %eax
80105514:	e8 47 f3 ff ff       	call   80104860 <strncmp>
80105519:	83 c4 10             	add    $0x10,%esp
8010551c:	85 c0                	test   %eax,%eax
8010551e:	0f 84 a0 fe ff ff    	je     801053c4 <sys_open+0xe4>
		{
			cprintf("File access denied\n");
80105524:	83 ec 0c             	sub    $0xc,%esp
80105527:	68 ed 7d 10 80       	push   $0x80107ded
8010552c:	e8 2f b1 ff ff       	call   80100660 <cprintf>

			iunlockput(ip);
80105531:	89 34 24             	mov    %esi,(%esp)
80105534:	e8 97 c4 ff ff       	call   801019d0 <iunlockput>
      			end_op();
80105539:	e8 b2 d7 ff ff       	call   80102cf0 <end_op>
			return -1;
8010553e:	83 c4 10             	add    $0x10,%esp
80105541:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105546:	eb 96                	jmp    801054de <sys_open+0x1fe>
80105548:	90                   	nop
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	//cprintf("wrong path: %s\n", path);
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105550:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80105553:	85 c9                	test   %ecx,%ecx
80105555:	0f 84 0c fe ff ff    	je     80105367 <sys_open+0x87>
8010555b:	e9 a0 fe ff ff       	jmp    80105400 <sys_open+0x120>

80105560 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105566:	e8 15 d7 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010556b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010556e:	83 ec 08             	sub    $0x8,%esp
80105571:	50                   	push   %eax
80105572:	6a 00                	push   $0x0
80105574:	e8 77 f5 ff ff       	call   80104af0 <argstr>
80105579:	83 c4 10             	add    $0x10,%esp
8010557c:	85 c0                	test   %eax,%eax
8010557e:	78 30                	js     801055b0 <sys_mkdir+0x50>
80105580:	83 ec 0c             	sub    $0xc,%esp
80105583:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105586:	31 c9                	xor    %ecx,%ecx
80105588:	6a 00                	push   $0x0
8010558a:	ba 01 00 00 00       	mov    $0x1,%edx
8010558f:	e8 fc f5 ff ff       	call   80104b90 <create>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	85 c0                	test   %eax,%eax
80105599:	74 15                	je     801055b0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010559b:	83 ec 0c             	sub    $0xc,%esp
8010559e:	50                   	push   %eax
8010559f:	e8 2c c4 ff ff       	call   801019d0 <iunlockput>
  end_op();
801055a4:	e8 47 d7 ff ff       	call   80102cf0 <end_op>
  return 0;
801055a9:	83 c4 10             	add    $0x10,%esp
801055ac:	31 c0                	xor    %eax,%eax
}
801055ae:	c9                   	leave  
801055af:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801055b0:	e8 3b d7 ff ff       	call   80102cf0 <end_op>
    return -1;
801055b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055c0 <sys_mknod>:

int
sys_mknod(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801055c6:	e8 b5 d6 ff ff       	call   80102c80 <begin_op>
  if((argstr(0, &path)) < 0 ||
801055cb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801055ce:	83 ec 08             	sub    $0x8,%esp
801055d1:	50                   	push   %eax
801055d2:	6a 00                	push   $0x0
801055d4:	e8 17 f5 ff ff       	call   80104af0 <argstr>
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	85 c0                	test   %eax,%eax
801055de:	78 60                	js     80105640 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801055e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055e3:	83 ec 08             	sub    $0x8,%esp
801055e6:	50                   	push   %eax
801055e7:	6a 01                	push   $0x1
801055e9:	e8 52 f4 ff ff       	call   80104a40 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	85 c0                	test   %eax,%eax
801055f3:	78 4b                	js     80105640 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801055f5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055f8:	83 ec 08             	sub    $0x8,%esp
801055fb:	50                   	push   %eax
801055fc:	6a 02                	push   $0x2
801055fe:	e8 3d f4 ff ff       	call   80104a40 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	78 36                	js     80105640 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010560a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010560e:	83 ec 0c             	sub    $0xc,%esp
80105611:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105615:	ba 03 00 00 00       	mov    $0x3,%edx
8010561a:	50                   	push   %eax
8010561b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010561e:	e8 6d f5 ff ff       	call   80104b90 <create>
80105623:	83 c4 10             	add    $0x10,%esp
80105626:	85 c0                	test   %eax,%eax
80105628:	74 16                	je     80105640 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010562a:	83 ec 0c             	sub    $0xc,%esp
8010562d:	50                   	push   %eax
8010562e:	e8 9d c3 ff ff       	call   801019d0 <iunlockput>
  end_op();
80105633:	e8 b8 d6 ff ff       	call   80102cf0 <end_op>
  return 0;
80105638:	83 c4 10             	add    $0x10,%esp
8010563b:	31 c0                	xor    %eax,%eax
}
8010563d:	c9                   	leave  
8010563e:	c3                   	ret    
8010563f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105640:	e8 ab d6 ff ff       	call   80102cf0 <end_op>
    return -1;
80105645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010564a:	c9                   	leave  
8010564b:	c3                   	ret    
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_chdir>:

int
sys_chdir(void)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	56                   	push   %esi
80105654:	53                   	push   %ebx
80105655:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105658:	e8 63 e2 ff ff       	call   801038c0 <myproc>
8010565d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010565f:	e8 1c d6 ff ff       	call   80102c80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105664:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105667:	83 ec 08             	sub    $0x8,%esp
8010566a:	50                   	push   %eax
8010566b:	6a 00                	push   $0x0
8010566d:	e8 7e f4 ff ff       	call   80104af0 <argstr>
80105672:	83 c4 10             	add    $0x10,%esp
80105675:	85 c0                	test   %eax,%eax
80105677:	78 77                	js     801056f0 <sys_chdir+0xa0>
80105679:	83 ec 0c             	sub    $0xc,%esp
8010567c:	ff 75 f4             	pushl  -0xc(%ebp)
8010567f:	e8 6c c9 ff ff       	call   80101ff0 <namei>
80105684:	83 c4 10             	add    $0x10,%esp
80105687:	85 c0                	test   %eax,%eax
80105689:	89 c3                	mov    %eax,%ebx
8010568b:	74 63                	je     801056f0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010568d:	83 ec 0c             	sub    $0xc,%esp
80105690:	50                   	push   %eax
80105691:	e8 6a c0 ff ff       	call   80101700 <ilock>
  if(ip->type != T_DIR){
80105696:	83 c4 10             	add    $0x10,%esp
80105699:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010569e:	75 30                	jne    801056d0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056a0:	83 ec 0c             	sub    $0xc,%esp
801056a3:	53                   	push   %ebx
801056a4:	e8 67 c1 ff ff       	call   80101810 <iunlock>
  iput(curproc->cwd);
801056a9:	58                   	pop    %eax
801056aa:	ff 76 68             	pushl  0x68(%esi)
801056ad:	e8 ae c1 ff ff       	call   80101860 <iput>
  end_op();
801056b2:	e8 39 d6 ff ff       	call   80102cf0 <end_op>
  curproc->cwd = ip;
801056b7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801056ba:	83 c4 10             	add    $0x10,%esp
801056bd:	31 c0                	xor    %eax,%eax
}
801056bf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056c2:	5b                   	pop    %ebx
801056c3:	5e                   	pop    %esi
801056c4:	5d                   	pop    %ebp
801056c5:	c3                   	ret    
801056c6:	8d 76 00             	lea    0x0(%esi),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801056d0:	83 ec 0c             	sub    $0xc,%esp
801056d3:	53                   	push   %ebx
801056d4:	e8 f7 c2 ff ff       	call   801019d0 <iunlockput>
    end_op();
801056d9:	e8 12 d6 ff ff       	call   80102cf0 <end_op>
    return -1;
801056de:	83 c4 10             	add    $0x10,%esp
801056e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e6:	eb d7                	jmp    801056bf <sys_chdir+0x6f>
801056e8:	90                   	nop
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801056f0:	e8 fb d5 ff ff       	call   80102cf0 <end_op>
    return -1;
801056f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056fa:	eb c3                	jmp    801056bf <sys_chdir+0x6f>
801056fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105700 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	57                   	push   %edi
80105704:	56                   	push   %esi
80105705:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105706:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010570c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105712:	50                   	push   %eax
80105713:	6a 00                	push   $0x0
80105715:	e8 d6 f3 ff ff       	call   80104af0 <argstr>
8010571a:	83 c4 10             	add    $0x10,%esp
8010571d:	85 c0                	test   %eax,%eax
8010571f:	78 7f                	js     801057a0 <sys_exec+0xa0>
80105721:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105727:	83 ec 08             	sub    $0x8,%esp
8010572a:	50                   	push   %eax
8010572b:	6a 01                	push   $0x1
8010572d:	e8 0e f3 ff ff       	call   80104a40 <argint>
80105732:	83 c4 10             	add    $0x10,%esp
80105735:	85 c0                	test   %eax,%eax
80105737:	78 67                	js     801057a0 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105739:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010573f:	83 ec 04             	sub    $0x4,%esp
80105742:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105748:	68 80 00 00 00       	push   $0x80
8010574d:	6a 00                	push   $0x0
8010574f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105755:	50                   	push   %eax
80105756:	31 db                	xor    %ebx,%ebx
80105758:	e8 d3 ef ff ff       	call   80104730 <memset>
8010575d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105760:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105766:	83 ec 08             	sub    $0x8,%esp
80105769:	57                   	push   %edi
8010576a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010576d:	50                   	push   %eax
8010576e:	e8 2d f2 ff ff       	call   801049a0 <fetchint>
80105773:	83 c4 10             	add    $0x10,%esp
80105776:	85 c0                	test   %eax,%eax
80105778:	78 26                	js     801057a0 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010577a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105780:	85 c0                	test   %eax,%eax
80105782:	74 2c                	je     801057b0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105784:	83 ec 08             	sub    $0x8,%esp
80105787:	56                   	push   %esi
80105788:	50                   	push   %eax
80105789:	e8 52 f2 ff ff       	call   801049e0 <fetchstr>
8010578e:	83 c4 10             	add    $0x10,%esp
80105791:	85 c0                	test   %eax,%eax
80105793:	78 0b                	js     801057a0 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105795:	83 c3 01             	add    $0x1,%ebx
80105798:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010579b:	83 fb 20             	cmp    $0x20,%ebx
8010579e:	75 c0                	jne    80105760 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801057a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801057a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
801057a8:	5b                   	pop    %ebx
801057a9:	5e                   	pop    %esi
801057aa:	5f                   	pop    %edi
801057ab:	5d                   	pop    %ebp
801057ac:	c3                   	ret    
801057ad:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801057b0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801057b6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801057b9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801057c0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801057c4:	50                   	push   %eax
801057c5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801057cb:	e8 20 b2 ff ff       	call   801009f0 <exec>
801057d0:	83 c4 10             	add    $0x10,%esp
}
801057d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057d6:	5b                   	pop    %ebx
801057d7:	5e                   	pop    %esi
801057d8:	5f                   	pop    %edi
801057d9:	5d                   	pop    %ebp
801057da:	c3                   	ret    
801057db:	90                   	nop
801057dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057e0 <sys_pipe>:

int
sys_pipe(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	57                   	push   %edi
801057e4:	56                   	push   %esi
801057e5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057e6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801057e9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801057ec:	6a 08                	push   $0x8
801057ee:	50                   	push   %eax
801057ef:	6a 00                	push   $0x0
801057f1:	e8 9a f2 ff ff       	call   80104a90 <argptr>
801057f6:	83 c4 10             	add    $0x10,%esp
801057f9:	85 c0                	test   %eax,%eax
801057fb:	78 4a                	js     80105847 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057fd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105800:	83 ec 08             	sub    $0x8,%esp
80105803:	50                   	push   %eax
80105804:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105807:	50                   	push   %eax
80105808:	e8 13 db ff ff       	call   80103320 <pipealloc>
8010580d:	83 c4 10             	add    $0x10,%esp
80105810:	85 c0                	test   %eax,%eax
80105812:	78 33                	js     80105847 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105814:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105816:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105819:	e8 a2 e0 ff ff       	call   801038c0 <myproc>
8010581e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105820:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105824:	85 f6                	test   %esi,%esi
80105826:	74 30                	je     80105858 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105828:	83 c3 01             	add    $0x1,%ebx
8010582b:	83 fb 10             	cmp    $0x10,%ebx
8010582e:	75 f0                	jne    80105820 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105830:	83 ec 0c             	sub    $0xc,%esp
80105833:	ff 75 e0             	pushl  -0x20(%ebp)
80105836:	e8 f5 b5 ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
8010583b:	58                   	pop    %eax
8010583c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010583f:	e8 ec b5 ff ff       	call   80100e30 <fileclose>
    return -1;
80105844:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105847:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010584a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010584f:	5b                   	pop    %ebx
80105850:	5e                   	pop    %esi
80105851:	5f                   	pop    %edi
80105852:	5d                   	pop    %ebp
80105853:	c3                   	ret    
80105854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105858:	8d 73 08             	lea    0x8(%ebx),%esi
8010585b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010585f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105862:	e8 59 e0 ff ff       	call   801038c0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80105867:	31 d2                	xor    %edx,%edx
80105869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105870:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105874:	85 c9                	test   %ecx,%ecx
80105876:	74 18                	je     80105890 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105878:	83 c2 01             	add    $0x1,%edx
8010587b:	83 fa 10             	cmp    $0x10,%edx
8010587e:	75 f0                	jne    80105870 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105880:	e8 3b e0 ff ff       	call   801038c0 <myproc>
80105885:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010588c:	00 
8010588d:	eb a1                	jmp    80105830 <sys_pipe+0x50>
8010588f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105890:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105894:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105897:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105899:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010589c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010589f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
801058a2:	31 c0                	xor    %eax,%eax
}
801058a4:	5b                   	pop    %ebx
801058a5:	5e                   	pop    %esi
801058a6:	5f                   	pop    %edi
801058a7:	5d                   	pop    %ebp
801058a8:	c3                   	ret    
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058b0 <sys_changeOwner>:
int
sys_changeOwner(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	57                   	push   %edi
801058b4:	56                   	push   %esi
801058b5:	53                   	push   %ebx
	char *fname;
	char *owner;
	struct inode *ip;
	argstr(0, &fname);
801058b6:	8d 5d e0             	lea    -0x20(%ebp),%ebx
  fd[1] = fd1;
  return 0;
}
int
sys_changeOwner(void)
{
801058b9:	83 ec 24             	sub    $0x24,%esp
	char *fname;
	char *owner;
	struct inode *ip;
	argstr(0, &fname);
801058bc:	53                   	push   %ebx
801058bd:	6a 00                	push   $0x0
801058bf:	e8 2c f2 ff ff       	call   80104af0 <argstr>
	argstr(1, &owner);
801058c4:	58                   	pop    %eax
801058c5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058c8:	5a                   	pop    %edx
801058c9:	50                   	push   %eax
801058ca:	6a 01                	push   $0x1
801058cc:	e8 1f f2 ff ff       	call   80104af0 <argstr>
	//cprintf("%s %s\n",fname,owner);
	if(argstr(0, &fname) < 0)
801058d1:	59                   	pop    %ecx
801058d2:	5e                   	pop    %esi
801058d3:	53                   	push   %ebx
801058d4:	6a 00                	push   $0x0
801058d6:	e8 15 f2 ff ff       	call   80104af0 <argstr>
801058db:	83 c4 10             	add    $0x10,%esp
801058de:	85 c0                	test   %eax,%eax
801058e0:	0f 88 2a 01 00 00    	js     80105a10 <sys_changeOwner+0x160>
        {
		return -1;
        }
	begin_op();
801058e6:	e8 95 d3 ff ff       	call   80102c80 <begin_op>
	if((ip = namei(fname)) == 0){
801058eb:	83 ec 0c             	sub    $0xc,%esp
801058ee:	ff 75 e0             	pushl  -0x20(%ebp)
801058f1:	e8 fa c6 ff ff       	call   80101ff0 <namei>
801058f6:	83 c4 10             	add    $0x10,%esp
801058f9:	85 c0                	test   %eax,%eax
801058fb:	89 c3                	mov    %eax,%ebx
801058fd:	0f 84 38 01 00 00    	je     80105a3b <sys_changeOwner+0x18b>
		//cprintf("wrong path: %s\n", path);
      		end_op();
      		return -1;
    	}
    	ilock(ip);
80105903:	83 ec 0c             	sub    $0xc,%esp
80105906:	50                   	push   %eax
80105907:	e8 f4 bd ff ff       	call   80101700 <ilock>
    	if(ip->type == T_DIR){
8010590c:	83 c4 10             	add    $0x10,%esp
8010590f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105914:	0f 84 06 01 00 00    	je     80105a20 <sys_changeOwner+0x170>
      		iunlockput(ip);
      		end_op();
      		return -1;
    	}
  	if(strncmp(ip->uProp.name, "", strlen(ip->uProp.name) + 1) != 0)
8010591a:	8d 73 54             	lea    0x54(%ebx),%esi
8010591d:	83 ec 0c             	sub    $0xc,%esp
80105920:	56                   	push   %esi
80105921:	e8 4a f0 ff ff       	call   80104970 <strlen>
80105926:	83 c4 0c             	add    $0xc,%esp
80105929:	83 c0 01             	add    $0x1,%eax
8010592c:	50                   	push   %eax
8010592d:	68 4d 7c 10 80       	push   $0x80107c4d
80105932:	56                   	push   %esi
80105933:	e8 28 ef ff ff       	call   80104860 <strncmp>
80105938:	83 c4 10             	add    $0x10,%esp
8010593b:	85 c0                	test   %eax,%eax
8010593d:	75 41                	jne    80105980 <sys_changeOwner+0xd0>
      				end_op();
				return -1;
			}
		}
  	}
	safestrcpy(ip->uProp.name, owner, strlen(owner) + 1);
8010593f:	83 ec 0c             	sub    $0xc,%esp
80105942:	ff 75 e4             	pushl  -0x1c(%ebp)
80105945:	e8 26 f0 ff ff       	call   80104970 <strlen>
8010594a:	83 c4 0c             	add    $0xc,%esp
8010594d:	83 c0 01             	add    $0x1,%eax
80105950:	50                   	push   %eax
80105951:	ff 75 e4             	pushl  -0x1c(%ebp)
80105954:	56                   	push   %esi
80105955:	e8 d6 ef ff ff       	call   80104930 <safestrcpy>
	iupdate(ip);
8010595a:	89 1c 24             	mov    %ebx,(%esp)
8010595d:	e8 be bc ff ff       	call   80101620 <iupdate>
	iunlockput(ip);
80105962:	89 1c 24             	mov    %ebx,(%esp)
80105965:	e8 66 c0 ff ff       	call   801019d0 <iunlockput>
      	end_op();
8010596a:	e8 81 d3 ff ff       	call   80102cf0 <end_op>
	return 0;
8010596f:	83 c4 10             	add    $0x10,%esp
80105972:	31 c0                	xor    %eax,%eax
}
80105974:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105977:	5b                   	pop    %ebx
80105978:	5e                   	pop    %esi
80105979:	5f                   	pop    %edi
8010597a:	5d                   	pop    %ebp
8010597b:	c3                   	ret    
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      		end_op();
      		return -1;
    	}
  	if(strncmp(ip->uProp.name, "", strlen(ip->uProp.name) + 1) != 0)
  	{
		if(strncmp(myproc()->currentUser, "Admin", strlen(myproc()->currentUser) + 1) != 0)
80105980:	e8 3b df ff ff       	call   801038c0 <myproc>
80105985:	83 ec 0c             	sub    $0xc,%esp
80105988:	83 c0 7c             	add    $0x7c,%eax
8010598b:	50                   	push   %eax
8010598c:	e8 df ef ff ff       	call   80104970 <strlen>
80105991:	89 c7                	mov    %eax,%edi
80105993:	83 c7 01             	add    $0x1,%edi
80105996:	e8 25 df ff ff       	call   801038c0 <myproc>
8010599b:	83 c4 0c             	add    $0xc,%esp
8010599e:	83 c0 7c             	add    $0x7c,%eax
801059a1:	57                   	push   %edi
801059a2:	68 70 7b 10 80       	push   $0x80107b70
801059a7:	50                   	push   %eax
801059a8:	e8 b3 ee ff ff       	call   80104860 <strncmp>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	85 c0                	test   %eax,%eax
801059b2:	74 8b                	je     8010593f <sys_changeOwner+0x8f>
		{
			if(strncmp(myproc()->currentUser, ip->uProp.name, strlen(myproc()->currentUser) + 1) != 0)
801059b4:	e8 07 df ff ff       	call   801038c0 <myproc>
801059b9:	83 ec 0c             	sub    $0xc,%esp
801059bc:	83 c0 7c             	add    $0x7c,%eax
801059bf:	50                   	push   %eax
801059c0:	e8 ab ef ff ff       	call   80104970 <strlen>
801059c5:	89 c7                	mov    %eax,%edi
801059c7:	83 c7 01             	add    $0x1,%edi
801059ca:	e8 f1 de ff ff       	call   801038c0 <myproc>
801059cf:	83 c4 0c             	add    $0xc,%esp
801059d2:	83 c0 7c             	add    $0x7c,%eax
801059d5:	57                   	push   %edi
801059d6:	56                   	push   %esi
801059d7:	50                   	push   %eax
801059d8:	e8 83 ee ff ff       	call   80104860 <strncmp>
801059dd:	83 c4 10             	add    $0x10,%esp
801059e0:	85 c0                	test   %eax,%eax
801059e2:	0f 84 57 ff ff ff    	je     8010593f <sys_changeOwner+0x8f>
			{
				cprintf("Owner: %s\nOwner change denied\n", ip->uProp.name);
801059e8:	83 ec 08             	sub    $0x8,%esp
801059eb:	56                   	push   %esi
801059ec:	68 18 7e 10 80       	push   $0x80107e18
801059f1:	e8 6a ac ff ff       	call   80100660 <cprintf>

				iunlockput(ip);
801059f6:	89 1c 24             	mov    %ebx,(%esp)
801059f9:	e8 d2 bf ff ff       	call   801019d0 <iunlockput>
      				end_op();
801059fe:	e8 ed d2 ff ff       	call   80102cf0 <end_op>
				return -1;
80105a03:	83 c4 10             	add    $0x10,%esp
80105a06:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a0b:	e9 64 ff ff ff       	jmp    80105974 <sys_changeOwner+0xc4>
	argstr(0, &fname);
	argstr(1, &owner);
	//cprintf("%s %s\n",fname,owner);
	if(argstr(0, &fname) < 0)
        {
		return -1;
80105a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a15:	e9 5a ff ff ff       	jmp    80105974 <sys_changeOwner+0xc4>
80105a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      		end_op();
      		return -1;
    	}
    	ilock(ip);
    	if(ip->type == T_DIR){
      		iunlockput(ip);
80105a20:	83 ec 0c             	sub    $0xc,%esp
80105a23:	53                   	push   %ebx
80105a24:	e8 a7 bf ff ff       	call   801019d0 <iunlockput>
      		end_op();
80105a29:	e8 c2 d2 ff ff       	call   80102cf0 <end_op>
      		return -1;
80105a2e:	83 c4 10             	add    $0x10,%esp
80105a31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a36:	e9 39 ff ff ff       	jmp    80105974 <sys_changeOwner+0xc4>
		return -1;
        }
	begin_op();
	if((ip = namei(fname)) == 0){
		//cprintf("wrong path: %s\n", path);
      		end_op();
80105a3b:	e8 b0 d2 ff ff       	call   80102cf0 <end_op>
      		return -1;
80105a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a45:	e9 2a ff ff ff       	jmp    80105974 <sys_changeOwner+0xc4>
80105a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a50 <sys_userTag>:
      	end_op();
	return 0;
}
int
sys_userTag(void)
{
80105a50:	55                   	push   %ebp
80105a51:	89 e5                	mov    %esp,%ebp
80105a53:	53                   	push   %ebx
	char *fname;
	struct inode *ip;
	argstr(0, &fname);
80105a54:	8d 5d f4             	lea    -0xc(%ebp),%ebx
      	end_op();
	return 0;
}
int
sys_userTag(void)
{
80105a57:	83 ec 1c             	sub    $0x1c,%esp
	char *fname;
	struct inode *ip;
	argstr(0, &fname);
80105a5a:	53                   	push   %ebx
80105a5b:	6a 00                	push   $0x0
80105a5d:	e8 8e f0 ff ff       	call   80104af0 <argstr>
	cprintf("file name: %s\n",fname);
80105a62:	58                   	pop    %eax
80105a63:	5a                   	pop    %edx
80105a64:	ff 75 f4             	pushl  -0xc(%ebp)
80105a67:	68 01 7e 10 80       	push   $0x80107e01
80105a6c:	e8 ef ab ff ff       	call   80100660 <cprintf>
	if(argstr(0, &fname) < 0)
80105a71:	59                   	pop    %ecx
80105a72:	58                   	pop    %eax
80105a73:	53                   	push   %ebx
80105a74:	6a 00                	push   $0x0
80105a76:	e8 75 f0 ff ff       	call   80104af0 <argstr>
80105a7b:	83 c4 10             	add    $0x10,%esp
80105a7e:	85 c0                	test   %eax,%eax
80105a80:	78 5e                	js     80105ae0 <sys_userTag+0x90>
        {
		return -1;
        }
	begin_op();
80105a82:	e8 f9 d1 ff ff       	call   80102c80 <begin_op>
	if((ip = namei(fname)) == 0){
80105a87:	83 ec 0c             	sub    $0xc,%esp
80105a8a:	ff 75 f4             	pushl  -0xc(%ebp)
80105a8d:	e8 5e c5 ff ff       	call   80101ff0 <namei>
80105a92:	83 c4 10             	add    $0x10,%esp
80105a95:	85 c0                	test   %eax,%eax
80105a97:	89 c3                	mov    %eax,%ebx
80105a99:	74 6d                	je     80105b08 <sys_userTag+0xb8>
		//cprintf("wrong path: %s\n", path);
      		end_op();
      		return -1;
    	}
    	ilock(ip);
80105a9b:	83 ec 0c             	sub    $0xc,%esp
80105a9e:	50                   	push   %eax
80105a9f:	e8 5c bc ff ff       	call   80101700 <ilock>
    	if(ip->type == T_DIR){
80105aa4:	83 c4 10             	add    $0x10,%esp
80105aa7:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105aac:	74 42                	je     80105af0 <sys_userTag+0xa0>
      		iunlockput(ip);
      		end_op();
      		return -1;
    	}
  	
	cprintf("%s: %s\n", fname, ip->uProp.name);
80105aae:	8d 43 54             	lea    0x54(%ebx),%eax
80105ab1:	83 ec 04             	sub    $0x4,%esp
80105ab4:	50                   	push   %eax
80105ab5:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab8:	68 10 7e 10 80       	push   $0x80107e10
80105abd:	e8 9e ab ff ff       	call   80100660 <cprintf>
	iunlock(ip);
80105ac2:	89 1c 24             	mov    %ebx,(%esp)
80105ac5:	e8 46 bd ff ff       	call   80101810 <iunlock>
      	end_op();
80105aca:	e8 21 d2 ff ff       	call   80102cf0 <end_op>
	return 0;
80105acf:	83 c4 10             	add    $0x10,%esp
80105ad2:	31 c0                	xor    %eax,%eax
}
80105ad4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ad7:	c9                   	leave  
80105ad8:	c3                   	ret    
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	struct inode *ip;
	argstr(0, &fname);
	cprintf("file name: %s\n",fname);
	if(argstr(0, &fname) < 0)
        {
		return -1;
80105ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ae5:	eb ed                	jmp    80105ad4 <sys_userTag+0x84>
80105ae7:	89 f6                	mov    %esi,%esi
80105ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      		end_op();
      		return -1;
    	}
    	ilock(ip);
    	if(ip->type == T_DIR){
      		iunlockput(ip);
80105af0:	83 ec 0c             	sub    $0xc,%esp
80105af3:	53                   	push   %ebx
80105af4:	e8 d7 be ff ff       	call   801019d0 <iunlockput>
      		end_op();
80105af9:	e8 f2 d1 ff ff       	call   80102cf0 <end_op>
      		return -1;
80105afe:	83 c4 10             	add    $0x10,%esp
80105b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b06:	eb cc                	jmp    80105ad4 <sys_userTag+0x84>
		return -1;
        }
	begin_op();
	if((ip = namei(fname)) == 0){
		//cprintf("wrong path: %s\n", path);
      		end_op();
80105b08:	e8 e3 d1 ff ff       	call   80102cf0 <end_op>
      		return -1;
80105b0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b12:	eb c0                	jmp    80105ad4 <sys_userTag+0x84>
80105b14:	66 90                	xchg   %ax,%ax
80105b16:	66 90                	xchg   %ax,%ax
80105b18:	66 90                	xchg   %ax,%ax
80105b1a:	66 90                	xchg   %ax,%ax
80105b1c:	66 90                	xchg   %ax,%ax
80105b1e:	66 90                	xchg   %ax,%ax

80105b20 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105b23:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105b24:	e9 47 df ff ff       	jmp    80103a70 <fork>
80105b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b30 <sys_exit>:
}

int
sys_exit(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	83 ec 08             	sub    $0x8,%esp
  exit();
80105b36:	e8 f5 e1 ff ff       	call   80103d30 <exit>
  return 0;  // not reached
}
80105b3b:	31 c0                	xor    %eax,%eax
80105b3d:	c9                   	leave  
80105b3e:	c3                   	ret    
80105b3f:	90                   	nop

80105b40 <sys_wait>:

int
sys_wait(void)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105b43:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105b44:	e9 27 e4 ff ff       	jmp    80103f70 <wait>
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b50 <sys_kill>:
}

int
sys_kill(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105b56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b59:	50                   	push   %eax
80105b5a:	6a 00                	push   $0x0
80105b5c:	e8 df ee ff ff       	call   80104a40 <argint>
80105b61:	83 c4 10             	add    $0x10,%esp
80105b64:	85 c0                	test   %eax,%eax
80105b66:	78 18                	js     80105b80 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105b68:	83 ec 0c             	sub    $0xc,%esp
80105b6b:	ff 75 f4             	pushl  -0xc(%ebp)
80105b6e:	e8 5d e5 ff ff       	call   801040d0 <kill>
80105b73:	83 c4 10             	add    $0x10,%esp
}
80105b76:	c9                   	leave  
80105b77:	c3                   	ret    
80105b78:	90                   	nop
80105b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105b85:	c9                   	leave  
80105b86:	c3                   	ret    
80105b87:	89 f6                	mov    %esi,%esi
80105b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b90 <sys_getpid>:

int
sys_getpid(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105b96:	e8 25 dd ff ff       	call   801038c0 <myproc>
80105b9b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105b9e:	c9                   	leave  
80105b9f:	c3                   	ret    

80105ba0 <sys_sbrk>:

int
sys_sbrk(void)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105ba4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105ba7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105baa:	50                   	push   %eax
80105bab:	6a 00                	push   $0x0
80105bad:	e8 8e ee ff ff       	call   80104a40 <argint>
80105bb2:	83 c4 10             	add    $0x10,%esp
80105bb5:	85 c0                	test   %eax,%eax
80105bb7:	78 27                	js     80105be0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105bb9:	e8 02 dd ff ff       	call   801038c0 <myproc>
  if(growproc(n) < 0)
80105bbe:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80105bc1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105bc3:	ff 75 f4             	pushl  -0xc(%ebp)
80105bc6:	e8 25 de ff ff       	call   801039f0 <growproc>
80105bcb:	83 c4 10             	add    $0x10,%esp
80105bce:	85 c0                	test   %eax,%eax
80105bd0:	78 0e                	js     80105be0 <sys_sbrk+0x40>
    return -1;
  return addr;
80105bd2:	89 d8                	mov    %ebx,%eax
}
80105bd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bd7:	c9                   	leave  
80105bd8:	c3                   	ret    
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105be5:	eb ed                	jmp    80105bd4 <sys_sbrk+0x34>
80105be7:	89 f6                	mov    %esi,%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bf0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105bf0:	55                   	push   %ebp
80105bf1:	89 e5                	mov    %esp,%ebp
80105bf3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105bf4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105bf7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105bfa:	50                   	push   %eax
80105bfb:	6a 00                	push   $0x0
80105bfd:	e8 3e ee ff ff       	call   80104a40 <argint>
80105c02:	83 c4 10             	add    $0x10,%esp
80105c05:	85 c0                	test   %eax,%eax
80105c07:	0f 88 8a 00 00 00    	js     80105c97 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105c0d:	83 ec 0c             	sub    $0xc,%esp
80105c10:	68 60 f1 11 80       	push   $0x8011f160
80105c15:	e8 16 ea ff ff       	call   80104630 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c1d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105c20:	8b 1d a0 f9 11 80    	mov    0x8011f9a0,%ebx
  while(ticks - ticks0 < n){
80105c26:	85 d2                	test   %edx,%edx
80105c28:	75 27                	jne    80105c51 <sys_sleep+0x61>
80105c2a:	eb 54                	jmp    80105c80 <sys_sleep+0x90>
80105c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105c30:	83 ec 08             	sub    $0x8,%esp
80105c33:	68 60 f1 11 80       	push   $0x8011f160
80105c38:	68 a0 f9 11 80       	push   $0x8011f9a0
80105c3d:	e8 6e e2 ff ff       	call   80103eb0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105c42:	a1 a0 f9 11 80       	mov    0x8011f9a0,%eax
80105c47:	83 c4 10             	add    $0x10,%esp
80105c4a:	29 d8                	sub    %ebx,%eax
80105c4c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105c4f:	73 2f                	jae    80105c80 <sys_sleep+0x90>
    if(myproc()->killed){
80105c51:	e8 6a dc ff ff       	call   801038c0 <myproc>
80105c56:	8b 40 24             	mov    0x24(%eax),%eax
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	74 d3                	je     80105c30 <sys_sleep+0x40>
      release(&tickslock);
80105c5d:	83 ec 0c             	sub    $0xc,%esp
80105c60:	68 60 f1 11 80       	push   $0x8011f160
80105c65:	e8 76 ea ff ff       	call   801046e0 <release>
      return -1;
80105c6a:	83 c4 10             	add    $0x10,%esp
80105c6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105c72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c75:	c9                   	leave  
80105c76:	c3                   	ret    
80105c77:	89 f6                	mov    %esi,%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	68 60 f1 11 80       	push   $0x8011f160
80105c88:	e8 53 ea ff ff       	call   801046e0 <release>
  return 0;
80105c8d:	83 c4 10             	add    $0x10,%esp
80105c90:	31 c0                	xor    %eax,%eax
}
80105c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c95:	c9                   	leave  
80105c96:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105c97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9c:	eb d4                	jmp    80105c72 <sys_sleep+0x82>
80105c9e:	66 90                	xchg   %ax,%ax

80105ca0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	53                   	push   %ebx
80105ca4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105ca7:	68 60 f1 11 80       	push   $0x8011f160
80105cac:	e8 7f e9 ff ff       	call   80104630 <acquire>
  xticks = ticks;
80105cb1:	8b 1d a0 f9 11 80    	mov    0x8011f9a0,%ebx
  release(&tickslock);
80105cb7:	c7 04 24 60 f1 11 80 	movl   $0x8011f160,(%esp)
80105cbe:	e8 1d ea ff ff       	call   801046e0 <release>
  return xticks;
}
80105cc3:	89 d8                	mov    %ebx,%eax
80105cc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105cc8:	c9                   	leave  
80105cc9:	c3                   	ret    
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105cd0 <sys_cps>:

int
sys_cps(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
	return cps();
}
80105cd3:	5d                   	pop    %ebp
}

int
sys_cps(void)
{
	return cps();
80105cd4:	e9 47 e5 ff ff       	jmp    80104220 <cps>
80105cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ce0 <sys_changeUser>:
}

int 
sys_changeUser(void)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	83 ec 20             	sub    $0x20,%esp
	char* userName;
	argstr(0, &userName);
80105ce6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ce9:	50                   	push   %eax
80105cea:	6a 00                	push   $0x0
80105cec:	e8 ff ed ff ff       	call   80104af0 <argstr>
	return changeUser(userName);
80105cf1:	58                   	pop    %eax
80105cf2:	ff 75 f4             	pushl  -0xc(%ebp)
80105cf5:	e8 f6 e5 ff ff       	call   801042f0 <changeUser>
}
80105cfa:	c9                   	leave  
80105cfb:	c3                   	ret    
80105cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d00 <sys_getUser>:
int
sys_getUser(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
	//cprint("%s\n",getUser());
	return getUser();
}
80105d03:	5d                   	pop    %ebp
}
int
sys_getUser(void)
{
	//cprint("%s\n",getUser());
	return getUser();
80105d04:	e9 57 e6 ff ff       	jmp    80104360 <getUser>

80105d09 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105d09:	1e                   	push   %ds
  pushl %es
80105d0a:	06                   	push   %es
  pushl %fs
80105d0b:	0f a0                	push   %fs
  pushl %gs
80105d0d:	0f a8                	push   %gs
  pushal
80105d0f:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105d10:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105d14:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105d16:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105d18:	54                   	push   %esp
  call trap
80105d19:	e8 e2 00 00 00       	call   80105e00 <trap>
  addl $4, %esp
80105d1e:	83 c4 04             	add    $0x4,%esp

80105d21 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105d21:	61                   	popa   
  popl %gs
80105d22:	0f a9                	pop    %gs
  popl %fs
80105d24:	0f a1                	pop    %fs
  popl %es
80105d26:	07                   	pop    %es
  popl %ds
80105d27:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105d28:	83 c4 08             	add    $0x8,%esp
  iret
80105d2b:	cf                   	iret   
80105d2c:	66 90                	xchg   %ax,%ax
80105d2e:	66 90                	xchg   %ax,%ax

80105d30 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105d30:	31 c0                	xor    %eax,%eax
80105d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105d38:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105d3f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105d44:	c6 04 c5 a4 f1 11 80 	movb   $0x0,-0x7fee0e5c(,%eax,8)
80105d4b:	00 
80105d4c:	66 89 0c c5 a2 f1 11 	mov    %cx,-0x7fee0e5e(,%eax,8)
80105d53:	80 
80105d54:	c6 04 c5 a5 f1 11 80 	movb   $0x8e,-0x7fee0e5b(,%eax,8)
80105d5b:	8e 
80105d5c:	66 89 14 c5 a0 f1 11 	mov    %dx,-0x7fee0e60(,%eax,8)
80105d63:	80 
80105d64:	c1 ea 10             	shr    $0x10,%edx
80105d67:	66 89 14 c5 a6 f1 11 	mov    %dx,-0x7fee0e5a(,%eax,8)
80105d6e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105d6f:	83 c0 01             	add    $0x1,%eax
80105d72:	3d 00 01 00 00       	cmp    $0x100,%eax
80105d77:	75 bf                	jne    80105d38 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d79:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d7a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105d7f:	89 e5                	mov    %esp,%ebp
80105d81:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d84:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80105d89:	68 37 7e 10 80       	push   $0x80107e37
80105d8e:	68 60 f1 11 80       	push   $0x8011f160
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105d93:	66 89 15 a2 f3 11 80 	mov    %dx,0x8011f3a2
80105d9a:	c6 05 a4 f3 11 80 00 	movb   $0x0,0x8011f3a4
80105da1:	66 a3 a0 f3 11 80    	mov    %ax,0x8011f3a0
80105da7:	c1 e8 10             	shr    $0x10,%eax
80105daa:	c6 05 a5 f3 11 80 ef 	movb   $0xef,0x8011f3a5
80105db1:	66 a3 a6 f3 11 80    	mov    %ax,0x8011f3a6

  initlock(&tickslock, "time");
80105db7:	e8 14 e7 ff ff       	call   801044d0 <initlock>
}
80105dbc:	83 c4 10             	add    $0x10,%esp
80105dbf:	c9                   	leave  
80105dc0:	c3                   	ret    
80105dc1:	eb 0d                	jmp    80105dd0 <idtinit>
80105dc3:	90                   	nop
80105dc4:	90                   	nop
80105dc5:	90                   	nop
80105dc6:	90                   	nop
80105dc7:	90                   	nop
80105dc8:	90                   	nop
80105dc9:	90                   	nop
80105dca:	90                   	nop
80105dcb:	90                   	nop
80105dcc:	90                   	nop
80105dcd:	90                   	nop
80105dce:	90                   	nop
80105dcf:	90                   	nop

80105dd0 <idtinit>:

void
idtinit(void)
{
80105dd0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105dd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105dd6:	89 e5                	mov    %esp,%ebp
80105dd8:	83 ec 10             	sub    $0x10,%esp
80105ddb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105ddf:	b8 a0 f1 11 80       	mov    $0x8011f1a0,%eax
80105de4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105de8:	c1 e8 10             	shr    $0x10,%eax
80105deb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105def:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105df2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105df5:	c9                   	leave  
80105df6:	c3                   	ret    
80105df7:	89 f6                	mov    %esi,%esi
80105df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	56                   	push   %esi
80105e05:	53                   	push   %ebx
80105e06:	83 ec 1c             	sub    $0x1c,%esp
80105e09:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
80105e0c:	8b 47 30             	mov    0x30(%edi),%eax
80105e0f:	83 f8 40             	cmp    $0x40,%eax
80105e12:	0f 84 88 01 00 00    	je     80105fa0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105e18:	83 e8 20             	sub    $0x20,%eax
80105e1b:	83 f8 1f             	cmp    $0x1f,%eax
80105e1e:	77 10                	ja     80105e30 <trap+0x30>
80105e20:	ff 24 85 e0 7e 10 80 	jmp    *-0x7fef8120(,%eax,4)
80105e27:	89 f6                	mov    %esi,%esi
80105e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105e30:	e8 8b da ff ff       	call   801038c0 <myproc>
80105e35:	85 c0                	test   %eax,%eax
80105e37:	0f 84 d7 01 00 00    	je     80106014 <trap+0x214>
80105e3d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105e41:	0f 84 cd 01 00 00    	je     80106014 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105e47:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e4a:	8b 57 38             	mov    0x38(%edi),%edx
80105e4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105e50:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105e53:	e8 48 da ff ff       	call   801038a0 <cpuid>
80105e58:	8b 77 34             	mov    0x34(%edi),%esi
80105e5b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105e5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105e61:	e8 5a da ff ff       	call   801038c0 <myproc>
80105e66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105e69:	e8 52 da ff ff       	call   801038c0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e6e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105e71:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105e74:	51                   	push   %ecx
80105e75:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105e76:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e79:	ff 75 e4             	pushl  -0x1c(%ebp)
80105e7c:	56                   	push   %esi
80105e7d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105e7e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105e81:	52                   	push   %edx
80105e82:	ff 70 10             	pushl  0x10(%eax)
80105e85:	68 9c 7e 10 80       	push   $0x80107e9c
80105e8a:	e8 d1 a7 ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105e8f:	83 c4 20             	add    $0x20,%esp
80105e92:	e8 29 da ff ff       	call   801038c0 <myproc>
80105e97:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105e9e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ea0:	e8 1b da ff ff       	call   801038c0 <myproc>
80105ea5:	85 c0                	test   %eax,%eax
80105ea7:	74 0c                	je     80105eb5 <trap+0xb5>
80105ea9:	e8 12 da ff ff       	call   801038c0 <myproc>
80105eae:	8b 50 24             	mov    0x24(%eax),%edx
80105eb1:	85 d2                	test   %edx,%edx
80105eb3:	75 4b                	jne    80105f00 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105eb5:	e8 06 da ff ff       	call   801038c0 <myproc>
80105eba:	85 c0                	test   %eax,%eax
80105ebc:	74 0b                	je     80105ec9 <trap+0xc9>
80105ebe:	e8 fd d9 ff ff       	call   801038c0 <myproc>
80105ec3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ec7:	74 4f                	je     80105f18 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ec9:	e8 f2 d9 ff ff       	call   801038c0 <myproc>
80105ece:	85 c0                	test   %eax,%eax
80105ed0:	74 1d                	je     80105eef <trap+0xef>
80105ed2:	e8 e9 d9 ff ff       	call   801038c0 <myproc>
80105ed7:	8b 40 24             	mov    0x24(%eax),%eax
80105eda:	85 c0                	test   %eax,%eax
80105edc:	74 11                	je     80105eef <trap+0xef>
80105ede:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105ee2:	83 e0 03             	and    $0x3,%eax
80105ee5:	66 83 f8 03          	cmp    $0x3,%ax
80105ee9:	0f 84 da 00 00 00    	je     80105fc9 <trap+0x1c9>
    exit();
}
80105eef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ef2:	5b                   	pop    %ebx
80105ef3:	5e                   	pop    %esi
80105ef4:	5f                   	pop    %edi
80105ef5:	5d                   	pop    %ebp
80105ef6:	c3                   	ret    
80105ef7:	89 f6                	mov    %esi,%esi
80105ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105f00:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105f04:	83 e0 03             	and    $0x3,%eax
80105f07:	66 83 f8 03          	cmp    $0x3,%ax
80105f0b:	75 a8                	jne    80105eb5 <trap+0xb5>
    exit();
80105f0d:	e8 1e de ff ff       	call   80103d30 <exit>
80105f12:	eb a1                	jmp    80105eb5 <trap+0xb5>
80105f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105f18:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105f1c:	75 ab                	jne    80105ec9 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105f1e:	e8 3d df ff ff       	call   80103e60 <yield>
80105f23:	eb a4                	jmp    80105ec9 <trap+0xc9>
80105f25:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80105f28:	e8 73 d9 ff ff       	call   801038a0 <cpuid>
80105f2d:	85 c0                	test   %eax,%eax
80105f2f:	0f 84 ab 00 00 00    	je     80105fe0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80105f35:	e8 06 c9 ff ff       	call   80102840 <lapiceoi>
    break;
80105f3a:	e9 61 ff ff ff       	jmp    80105ea0 <trap+0xa0>
80105f3f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105f40:	e8 bb c7 ff ff       	call   80102700 <kbdintr>
    lapiceoi();
80105f45:	e8 f6 c8 ff ff       	call   80102840 <lapiceoi>
    break;
80105f4a:	e9 51 ff ff ff       	jmp    80105ea0 <trap+0xa0>
80105f4f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105f50:	e8 5b 02 00 00       	call   801061b0 <uartintr>
    lapiceoi();
80105f55:	e8 e6 c8 ff ff       	call   80102840 <lapiceoi>
    break;
80105f5a:	e9 41 ff ff ff       	jmp    80105ea0 <trap+0xa0>
80105f5f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105f60:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105f64:	8b 77 38             	mov    0x38(%edi),%esi
80105f67:	e8 34 d9 ff ff       	call   801038a0 <cpuid>
80105f6c:	56                   	push   %esi
80105f6d:	53                   	push   %ebx
80105f6e:	50                   	push   %eax
80105f6f:	68 44 7e 10 80       	push   $0x80107e44
80105f74:	e8 e7 a6 ff ff       	call   80100660 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80105f79:	e8 c2 c8 ff ff       	call   80102840 <lapiceoi>
    break;
80105f7e:	83 c4 10             	add    $0x10,%esp
80105f81:	e9 1a ff ff ff       	jmp    80105ea0 <trap+0xa0>
80105f86:	8d 76 00             	lea    0x0(%esi),%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105f90:	e8 eb c1 ff ff       	call   80102180 <ideintr>
80105f95:	eb 9e                	jmp    80105f35 <trap+0x135>
80105f97:	89 f6                	mov    %esi,%esi
80105f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105fa0:	e8 1b d9 ff ff       	call   801038c0 <myproc>
80105fa5:	8b 58 24             	mov    0x24(%eax),%ebx
80105fa8:	85 db                	test   %ebx,%ebx
80105faa:	75 2c                	jne    80105fd8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
80105fac:	e8 0f d9 ff ff       	call   801038c0 <myproc>
80105fb1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105fb4:	e8 77 eb ff ff       	call   80104b30 <syscall>
    if(myproc()->killed)
80105fb9:	e8 02 d9 ff ff       	call   801038c0 <myproc>
80105fbe:	8b 48 24             	mov    0x24(%eax),%ecx
80105fc1:	85 c9                	test   %ecx,%ecx
80105fc3:	0f 84 26 ff ff ff    	je     80105eef <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105fc9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fcc:	5b                   	pop    %ebx
80105fcd:	5e                   	pop    %esi
80105fce:	5f                   	pop    %edi
80105fcf:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80105fd0:	e9 5b dd ff ff       	jmp    80103d30 <exit>
80105fd5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105fd8:	e8 53 dd ff ff       	call   80103d30 <exit>
80105fdd:	eb cd                	jmp    80105fac <trap+0x1ac>
80105fdf:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80105fe0:	83 ec 0c             	sub    $0xc,%esp
80105fe3:	68 60 f1 11 80       	push   $0x8011f160
80105fe8:	e8 43 e6 ff ff       	call   80104630 <acquire>
      ticks++;
      wakeup(&ticks);
80105fed:	c7 04 24 a0 f9 11 80 	movl   $0x8011f9a0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80105ff4:	83 05 a0 f9 11 80 01 	addl   $0x1,0x8011f9a0
      wakeup(&ticks);
80105ffb:	e8 70 e0 ff ff       	call   80104070 <wakeup>
      release(&tickslock);
80106000:	c7 04 24 60 f1 11 80 	movl   $0x8011f160,(%esp)
80106007:	e8 d4 e6 ff ff       	call   801046e0 <release>
8010600c:	83 c4 10             	add    $0x10,%esp
8010600f:	e9 21 ff ff ff       	jmp    80105f35 <trap+0x135>
80106014:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106017:	8b 5f 38             	mov    0x38(%edi),%ebx
8010601a:	e8 81 d8 ff ff       	call   801038a0 <cpuid>
8010601f:	83 ec 0c             	sub    $0xc,%esp
80106022:	56                   	push   %esi
80106023:	53                   	push   %ebx
80106024:	50                   	push   %eax
80106025:	ff 77 30             	pushl  0x30(%edi)
80106028:	68 68 7e 10 80       	push   $0x80107e68
8010602d:	e8 2e a6 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80106032:	83 c4 14             	add    $0x14,%esp
80106035:	68 3c 7e 10 80       	push   $0x80107e3c
8010603a:	e8 31 a3 ff ff       	call   80100370 <panic>
8010603f:	90                   	nop

80106040 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106040:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106045:	55                   	push   %ebp
80106046:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106048:	85 c0                	test   %eax,%eax
8010604a:	74 1c                	je     80106068 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010604c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106051:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106052:	a8 01                	test   $0x1,%al
80106054:	74 12                	je     80106068 <uartgetc+0x28>
80106056:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010605b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010605c:	0f b6 c0             	movzbl %al,%eax
}
8010605f:	5d                   	pop    %ebp
80106060:	c3                   	ret    
80106061:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010606d:	5d                   	pop    %ebp
8010606e:	c3                   	ret    
8010606f:	90                   	nop

80106070 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	57                   	push   %edi
80106074:	56                   	push   %esi
80106075:	53                   	push   %ebx
80106076:	89 c7                	mov    %eax,%edi
80106078:	bb 80 00 00 00       	mov    $0x80,%ebx
8010607d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106082:	83 ec 0c             	sub    $0xc,%esp
80106085:	eb 1b                	jmp    801060a2 <uartputc.part.0+0x32>
80106087:	89 f6                	mov    %esi,%esi
80106089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106090:	83 ec 0c             	sub    $0xc,%esp
80106093:	6a 0a                	push   $0xa
80106095:	e8 c6 c7 ff ff       	call   80102860 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010609a:	83 c4 10             	add    $0x10,%esp
8010609d:	83 eb 01             	sub    $0x1,%ebx
801060a0:	74 07                	je     801060a9 <uartputc.part.0+0x39>
801060a2:	89 f2                	mov    %esi,%edx
801060a4:	ec                   	in     (%dx),%al
801060a5:	a8 20                	test   $0x20,%al
801060a7:	74 e7                	je     80106090 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801060a9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ae:	89 f8                	mov    %edi,%eax
801060b0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
801060b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060b4:	5b                   	pop    %ebx
801060b5:	5e                   	pop    %esi
801060b6:	5f                   	pop    %edi
801060b7:	5d                   	pop    %ebp
801060b8:	c3                   	ret    
801060b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060c0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801060c0:	55                   	push   %ebp
801060c1:	31 c9                	xor    %ecx,%ecx
801060c3:	89 c8                	mov    %ecx,%eax
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	57                   	push   %edi
801060c8:	56                   	push   %esi
801060c9:	53                   	push   %ebx
801060ca:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801060cf:	89 da                	mov    %ebx,%edx
801060d1:	83 ec 0c             	sub    $0xc,%esp
801060d4:	ee                   	out    %al,(%dx)
801060d5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801060da:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801060df:	89 fa                	mov    %edi,%edx
801060e1:	ee                   	out    %al,(%dx)
801060e2:	b8 0c 00 00 00       	mov    $0xc,%eax
801060e7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ec:	ee                   	out    %al,(%dx)
801060ed:	be f9 03 00 00       	mov    $0x3f9,%esi
801060f2:	89 c8                	mov    %ecx,%eax
801060f4:	89 f2                	mov    %esi,%edx
801060f6:	ee                   	out    %al,(%dx)
801060f7:	b8 03 00 00 00       	mov    $0x3,%eax
801060fc:	89 fa                	mov    %edi,%edx
801060fe:	ee                   	out    %al,(%dx)
801060ff:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106104:	89 c8                	mov    %ecx,%eax
80106106:	ee                   	out    %al,(%dx)
80106107:	b8 01 00 00 00       	mov    $0x1,%eax
8010610c:	89 f2                	mov    %esi,%edx
8010610e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010610f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106114:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106115:	3c ff                	cmp    $0xff,%al
80106117:	74 5a                	je     80106173 <uartinit+0xb3>
    return;
  uart = 1;
80106119:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106120:	00 00 00 
80106123:	89 da                	mov    %ebx,%edx
80106125:	ec                   	in     (%dx),%al
80106126:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010612b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
8010612c:	83 ec 08             	sub    $0x8,%esp
8010612f:	bb 60 7f 10 80       	mov    $0x80107f60,%ebx
80106134:	6a 00                	push   $0x0
80106136:	6a 04                	push   $0x4
80106138:	e8 93 c2 ff ff       	call   801023d0 <ioapicenable>
8010613d:	83 c4 10             	add    $0x10,%esp
80106140:	b8 78 00 00 00       	mov    $0x78,%eax
80106145:	eb 13                	jmp    8010615a <uartinit+0x9a>
80106147:	89 f6                	mov    %esi,%esi
80106149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106150:	83 c3 01             	add    $0x1,%ebx
80106153:	0f be 03             	movsbl (%ebx),%eax
80106156:	84 c0                	test   %al,%al
80106158:	74 19                	je     80106173 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010615a:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80106160:	85 d2                	test   %edx,%edx
80106162:	74 ec                	je     80106150 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106164:	83 c3 01             	add    $0x1,%ebx
80106167:	e8 04 ff ff ff       	call   80106070 <uartputc.part.0>
8010616c:	0f be 03             	movsbl (%ebx),%eax
8010616f:	84 c0                	test   %al,%al
80106171:	75 e7                	jne    8010615a <uartinit+0x9a>
    uartputc(*p);
}
80106173:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106176:	5b                   	pop    %ebx
80106177:	5e                   	pop    %esi
80106178:	5f                   	pop    %edi
80106179:	5d                   	pop    %ebp
8010617a:	c3                   	ret    
8010617b:	90                   	nop
8010617c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106180 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106180:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106186:	55                   	push   %ebp
80106187:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106189:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010618b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010618e:	74 10                	je     801061a0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106190:	5d                   	pop    %ebp
80106191:	e9 da fe ff ff       	jmp    80106070 <uartputc.part.0>
80106196:	8d 76 00             	lea    0x0(%esi),%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801061a0:	5d                   	pop    %ebp
801061a1:	c3                   	ret    
801061a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801061b0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
801061b0:	55                   	push   %ebp
801061b1:	89 e5                	mov    %esp,%ebp
801061b3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801061b6:	68 40 60 10 80       	push   $0x80106040
801061bb:	e8 30 a6 ff ff       	call   801007f0 <consoleintr>
}
801061c0:	83 c4 10             	add    $0x10,%esp
801061c3:	c9                   	leave  
801061c4:	c3                   	ret    

801061c5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $0
801061c7:	6a 00                	push   $0x0
  jmp alltraps
801061c9:	e9 3b fb ff ff       	jmp    80105d09 <alltraps>

801061ce <vector1>:
.globl vector1
vector1:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $1
801061d0:	6a 01                	push   $0x1
  jmp alltraps
801061d2:	e9 32 fb ff ff       	jmp    80105d09 <alltraps>

801061d7 <vector2>:
.globl vector2
vector2:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $2
801061d9:	6a 02                	push   $0x2
  jmp alltraps
801061db:	e9 29 fb ff ff       	jmp    80105d09 <alltraps>

801061e0 <vector3>:
.globl vector3
vector3:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $3
801061e2:	6a 03                	push   $0x3
  jmp alltraps
801061e4:	e9 20 fb ff ff       	jmp    80105d09 <alltraps>

801061e9 <vector4>:
.globl vector4
vector4:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $4
801061eb:	6a 04                	push   $0x4
  jmp alltraps
801061ed:	e9 17 fb ff ff       	jmp    80105d09 <alltraps>

801061f2 <vector5>:
.globl vector5
vector5:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $5
801061f4:	6a 05                	push   $0x5
  jmp alltraps
801061f6:	e9 0e fb ff ff       	jmp    80105d09 <alltraps>

801061fb <vector6>:
.globl vector6
vector6:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $6
801061fd:	6a 06                	push   $0x6
  jmp alltraps
801061ff:	e9 05 fb ff ff       	jmp    80105d09 <alltraps>

80106204 <vector7>:
.globl vector7
vector7:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $7
80106206:	6a 07                	push   $0x7
  jmp alltraps
80106208:	e9 fc fa ff ff       	jmp    80105d09 <alltraps>

8010620d <vector8>:
.globl vector8
vector8:
  pushl $8
8010620d:	6a 08                	push   $0x8
  jmp alltraps
8010620f:	e9 f5 fa ff ff       	jmp    80105d09 <alltraps>

80106214 <vector9>:
.globl vector9
vector9:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $9
80106216:	6a 09                	push   $0x9
  jmp alltraps
80106218:	e9 ec fa ff ff       	jmp    80105d09 <alltraps>

8010621d <vector10>:
.globl vector10
vector10:
  pushl $10
8010621d:	6a 0a                	push   $0xa
  jmp alltraps
8010621f:	e9 e5 fa ff ff       	jmp    80105d09 <alltraps>

80106224 <vector11>:
.globl vector11
vector11:
  pushl $11
80106224:	6a 0b                	push   $0xb
  jmp alltraps
80106226:	e9 de fa ff ff       	jmp    80105d09 <alltraps>

8010622b <vector12>:
.globl vector12
vector12:
  pushl $12
8010622b:	6a 0c                	push   $0xc
  jmp alltraps
8010622d:	e9 d7 fa ff ff       	jmp    80105d09 <alltraps>

80106232 <vector13>:
.globl vector13
vector13:
  pushl $13
80106232:	6a 0d                	push   $0xd
  jmp alltraps
80106234:	e9 d0 fa ff ff       	jmp    80105d09 <alltraps>

80106239 <vector14>:
.globl vector14
vector14:
  pushl $14
80106239:	6a 0e                	push   $0xe
  jmp alltraps
8010623b:	e9 c9 fa ff ff       	jmp    80105d09 <alltraps>

80106240 <vector15>:
.globl vector15
vector15:
  pushl $0
80106240:	6a 00                	push   $0x0
  pushl $15
80106242:	6a 0f                	push   $0xf
  jmp alltraps
80106244:	e9 c0 fa ff ff       	jmp    80105d09 <alltraps>

80106249 <vector16>:
.globl vector16
vector16:
  pushl $0
80106249:	6a 00                	push   $0x0
  pushl $16
8010624b:	6a 10                	push   $0x10
  jmp alltraps
8010624d:	e9 b7 fa ff ff       	jmp    80105d09 <alltraps>

80106252 <vector17>:
.globl vector17
vector17:
  pushl $17
80106252:	6a 11                	push   $0x11
  jmp alltraps
80106254:	e9 b0 fa ff ff       	jmp    80105d09 <alltraps>

80106259 <vector18>:
.globl vector18
vector18:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $18
8010625b:	6a 12                	push   $0x12
  jmp alltraps
8010625d:	e9 a7 fa ff ff       	jmp    80105d09 <alltraps>

80106262 <vector19>:
.globl vector19
vector19:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $19
80106264:	6a 13                	push   $0x13
  jmp alltraps
80106266:	e9 9e fa ff ff       	jmp    80105d09 <alltraps>

8010626b <vector20>:
.globl vector20
vector20:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $20
8010626d:	6a 14                	push   $0x14
  jmp alltraps
8010626f:	e9 95 fa ff ff       	jmp    80105d09 <alltraps>

80106274 <vector21>:
.globl vector21
vector21:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $21
80106276:	6a 15                	push   $0x15
  jmp alltraps
80106278:	e9 8c fa ff ff       	jmp    80105d09 <alltraps>

8010627d <vector22>:
.globl vector22
vector22:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $22
8010627f:	6a 16                	push   $0x16
  jmp alltraps
80106281:	e9 83 fa ff ff       	jmp    80105d09 <alltraps>

80106286 <vector23>:
.globl vector23
vector23:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $23
80106288:	6a 17                	push   $0x17
  jmp alltraps
8010628a:	e9 7a fa ff ff       	jmp    80105d09 <alltraps>

8010628f <vector24>:
.globl vector24
vector24:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $24
80106291:	6a 18                	push   $0x18
  jmp alltraps
80106293:	e9 71 fa ff ff       	jmp    80105d09 <alltraps>

80106298 <vector25>:
.globl vector25
vector25:
  pushl $0
80106298:	6a 00                	push   $0x0
  pushl $25
8010629a:	6a 19                	push   $0x19
  jmp alltraps
8010629c:	e9 68 fa ff ff       	jmp    80105d09 <alltraps>

801062a1 <vector26>:
.globl vector26
vector26:
  pushl $0
801062a1:	6a 00                	push   $0x0
  pushl $26
801062a3:	6a 1a                	push   $0x1a
  jmp alltraps
801062a5:	e9 5f fa ff ff       	jmp    80105d09 <alltraps>

801062aa <vector27>:
.globl vector27
vector27:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $27
801062ac:	6a 1b                	push   $0x1b
  jmp alltraps
801062ae:	e9 56 fa ff ff       	jmp    80105d09 <alltraps>

801062b3 <vector28>:
.globl vector28
vector28:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $28
801062b5:	6a 1c                	push   $0x1c
  jmp alltraps
801062b7:	e9 4d fa ff ff       	jmp    80105d09 <alltraps>

801062bc <vector29>:
.globl vector29
vector29:
  pushl $0
801062bc:	6a 00                	push   $0x0
  pushl $29
801062be:	6a 1d                	push   $0x1d
  jmp alltraps
801062c0:	e9 44 fa ff ff       	jmp    80105d09 <alltraps>

801062c5 <vector30>:
.globl vector30
vector30:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $30
801062c7:	6a 1e                	push   $0x1e
  jmp alltraps
801062c9:	e9 3b fa ff ff       	jmp    80105d09 <alltraps>

801062ce <vector31>:
.globl vector31
vector31:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $31
801062d0:	6a 1f                	push   $0x1f
  jmp alltraps
801062d2:	e9 32 fa ff ff       	jmp    80105d09 <alltraps>

801062d7 <vector32>:
.globl vector32
vector32:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $32
801062d9:	6a 20                	push   $0x20
  jmp alltraps
801062db:	e9 29 fa ff ff       	jmp    80105d09 <alltraps>

801062e0 <vector33>:
.globl vector33
vector33:
  pushl $0
801062e0:	6a 00                	push   $0x0
  pushl $33
801062e2:	6a 21                	push   $0x21
  jmp alltraps
801062e4:	e9 20 fa ff ff       	jmp    80105d09 <alltraps>

801062e9 <vector34>:
.globl vector34
vector34:
  pushl $0
801062e9:	6a 00                	push   $0x0
  pushl $34
801062eb:	6a 22                	push   $0x22
  jmp alltraps
801062ed:	e9 17 fa ff ff       	jmp    80105d09 <alltraps>

801062f2 <vector35>:
.globl vector35
vector35:
  pushl $0
801062f2:	6a 00                	push   $0x0
  pushl $35
801062f4:	6a 23                	push   $0x23
  jmp alltraps
801062f6:	e9 0e fa ff ff       	jmp    80105d09 <alltraps>

801062fb <vector36>:
.globl vector36
vector36:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $36
801062fd:	6a 24                	push   $0x24
  jmp alltraps
801062ff:	e9 05 fa ff ff       	jmp    80105d09 <alltraps>

80106304 <vector37>:
.globl vector37
vector37:
  pushl $0
80106304:	6a 00                	push   $0x0
  pushl $37
80106306:	6a 25                	push   $0x25
  jmp alltraps
80106308:	e9 fc f9 ff ff       	jmp    80105d09 <alltraps>

8010630d <vector38>:
.globl vector38
vector38:
  pushl $0
8010630d:	6a 00                	push   $0x0
  pushl $38
8010630f:	6a 26                	push   $0x26
  jmp alltraps
80106311:	e9 f3 f9 ff ff       	jmp    80105d09 <alltraps>

80106316 <vector39>:
.globl vector39
vector39:
  pushl $0
80106316:	6a 00                	push   $0x0
  pushl $39
80106318:	6a 27                	push   $0x27
  jmp alltraps
8010631a:	e9 ea f9 ff ff       	jmp    80105d09 <alltraps>

8010631f <vector40>:
.globl vector40
vector40:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $40
80106321:	6a 28                	push   $0x28
  jmp alltraps
80106323:	e9 e1 f9 ff ff       	jmp    80105d09 <alltraps>

80106328 <vector41>:
.globl vector41
vector41:
  pushl $0
80106328:	6a 00                	push   $0x0
  pushl $41
8010632a:	6a 29                	push   $0x29
  jmp alltraps
8010632c:	e9 d8 f9 ff ff       	jmp    80105d09 <alltraps>

80106331 <vector42>:
.globl vector42
vector42:
  pushl $0
80106331:	6a 00                	push   $0x0
  pushl $42
80106333:	6a 2a                	push   $0x2a
  jmp alltraps
80106335:	e9 cf f9 ff ff       	jmp    80105d09 <alltraps>

8010633a <vector43>:
.globl vector43
vector43:
  pushl $0
8010633a:	6a 00                	push   $0x0
  pushl $43
8010633c:	6a 2b                	push   $0x2b
  jmp alltraps
8010633e:	e9 c6 f9 ff ff       	jmp    80105d09 <alltraps>

80106343 <vector44>:
.globl vector44
vector44:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $44
80106345:	6a 2c                	push   $0x2c
  jmp alltraps
80106347:	e9 bd f9 ff ff       	jmp    80105d09 <alltraps>

8010634c <vector45>:
.globl vector45
vector45:
  pushl $0
8010634c:	6a 00                	push   $0x0
  pushl $45
8010634e:	6a 2d                	push   $0x2d
  jmp alltraps
80106350:	e9 b4 f9 ff ff       	jmp    80105d09 <alltraps>

80106355 <vector46>:
.globl vector46
vector46:
  pushl $0
80106355:	6a 00                	push   $0x0
  pushl $46
80106357:	6a 2e                	push   $0x2e
  jmp alltraps
80106359:	e9 ab f9 ff ff       	jmp    80105d09 <alltraps>

8010635e <vector47>:
.globl vector47
vector47:
  pushl $0
8010635e:	6a 00                	push   $0x0
  pushl $47
80106360:	6a 2f                	push   $0x2f
  jmp alltraps
80106362:	e9 a2 f9 ff ff       	jmp    80105d09 <alltraps>

80106367 <vector48>:
.globl vector48
vector48:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $48
80106369:	6a 30                	push   $0x30
  jmp alltraps
8010636b:	e9 99 f9 ff ff       	jmp    80105d09 <alltraps>

80106370 <vector49>:
.globl vector49
vector49:
  pushl $0
80106370:	6a 00                	push   $0x0
  pushl $49
80106372:	6a 31                	push   $0x31
  jmp alltraps
80106374:	e9 90 f9 ff ff       	jmp    80105d09 <alltraps>

80106379 <vector50>:
.globl vector50
vector50:
  pushl $0
80106379:	6a 00                	push   $0x0
  pushl $50
8010637b:	6a 32                	push   $0x32
  jmp alltraps
8010637d:	e9 87 f9 ff ff       	jmp    80105d09 <alltraps>

80106382 <vector51>:
.globl vector51
vector51:
  pushl $0
80106382:	6a 00                	push   $0x0
  pushl $51
80106384:	6a 33                	push   $0x33
  jmp alltraps
80106386:	e9 7e f9 ff ff       	jmp    80105d09 <alltraps>

8010638b <vector52>:
.globl vector52
vector52:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $52
8010638d:	6a 34                	push   $0x34
  jmp alltraps
8010638f:	e9 75 f9 ff ff       	jmp    80105d09 <alltraps>

80106394 <vector53>:
.globl vector53
vector53:
  pushl $0
80106394:	6a 00                	push   $0x0
  pushl $53
80106396:	6a 35                	push   $0x35
  jmp alltraps
80106398:	e9 6c f9 ff ff       	jmp    80105d09 <alltraps>

8010639d <vector54>:
.globl vector54
vector54:
  pushl $0
8010639d:	6a 00                	push   $0x0
  pushl $54
8010639f:	6a 36                	push   $0x36
  jmp alltraps
801063a1:	e9 63 f9 ff ff       	jmp    80105d09 <alltraps>

801063a6 <vector55>:
.globl vector55
vector55:
  pushl $0
801063a6:	6a 00                	push   $0x0
  pushl $55
801063a8:	6a 37                	push   $0x37
  jmp alltraps
801063aa:	e9 5a f9 ff ff       	jmp    80105d09 <alltraps>

801063af <vector56>:
.globl vector56
vector56:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $56
801063b1:	6a 38                	push   $0x38
  jmp alltraps
801063b3:	e9 51 f9 ff ff       	jmp    80105d09 <alltraps>

801063b8 <vector57>:
.globl vector57
vector57:
  pushl $0
801063b8:	6a 00                	push   $0x0
  pushl $57
801063ba:	6a 39                	push   $0x39
  jmp alltraps
801063bc:	e9 48 f9 ff ff       	jmp    80105d09 <alltraps>

801063c1 <vector58>:
.globl vector58
vector58:
  pushl $0
801063c1:	6a 00                	push   $0x0
  pushl $58
801063c3:	6a 3a                	push   $0x3a
  jmp alltraps
801063c5:	e9 3f f9 ff ff       	jmp    80105d09 <alltraps>

801063ca <vector59>:
.globl vector59
vector59:
  pushl $0
801063ca:	6a 00                	push   $0x0
  pushl $59
801063cc:	6a 3b                	push   $0x3b
  jmp alltraps
801063ce:	e9 36 f9 ff ff       	jmp    80105d09 <alltraps>

801063d3 <vector60>:
.globl vector60
vector60:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $60
801063d5:	6a 3c                	push   $0x3c
  jmp alltraps
801063d7:	e9 2d f9 ff ff       	jmp    80105d09 <alltraps>

801063dc <vector61>:
.globl vector61
vector61:
  pushl $0
801063dc:	6a 00                	push   $0x0
  pushl $61
801063de:	6a 3d                	push   $0x3d
  jmp alltraps
801063e0:	e9 24 f9 ff ff       	jmp    80105d09 <alltraps>

801063e5 <vector62>:
.globl vector62
vector62:
  pushl $0
801063e5:	6a 00                	push   $0x0
  pushl $62
801063e7:	6a 3e                	push   $0x3e
  jmp alltraps
801063e9:	e9 1b f9 ff ff       	jmp    80105d09 <alltraps>

801063ee <vector63>:
.globl vector63
vector63:
  pushl $0
801063ee:	6a 00                	push   $0x0
  pushl $63
801063f0:	6a 3f                	push   $0x3f
  jmp alltraps
801063f2:	e9 12 f9 ff ff       	jmp    80105d09 <alltraps>

801063f7 <vector64>:
.globl vector64
vector64:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $64
801063f9:	6a 40                	push   $0x40
  jmp alltraps
801063fb:	e9 09 f9 ff ff       	jmp    80105d09 <alltraps>

80106400 <vector65>:
.globl vector65
vector65:
  pushl $0
80106400:	6a 00                	push   $0x0
  pushl $65
80106402:	6a 41                	push   $0x41
  jmp alltraps
80106404:	e9 00 f9 ff ff       	jmp    80105d09 <alltraps>

80106409 <vector66>:
.globl vector66
vector66:
  pushl $0
80106409:	6a 00                	push   $0x0
  pushl $66
8010640b:	6a 42                	push   $0x42
  jmp alltraps
8010640d:	e9 f7 f8 ff ff       	jmp    80105d09 <alltraps>

80106412 <vector67>:
.globl vector67
vector67:
  pushl $0
80106412:	6a 00                	push   $0x0
  pushl $67
80106414:	6a 43                	push   $0x43
  jmp alltraps
80106416:	e9 ee f8 ff ff       	jmp    80105d09 <alltraps>

8010641b <vector68>:
.globl vector68
vector68:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $68
8010641d:	6a 44                	push   $0x44
  jmp alltraps
8010641f:	e9 e5 f8 ff ff       	jmp    80105d09 <alltraps>

80106424 <vector69>:
.globl vector69
vector69:
  pushl $0
80106424:	6a 00                	push   $0x0
  pushl $69
80106426:	6a 45                	push   $0x45
  jmp alltraps
80106428:	e9 dc f8 ff ff       	jmp    80105d09 <alltraps>

8010642d <vector70>:
.globl vector70
vector70:
  pushl $0
8010642d:	6a 00                	push   $0x0
  pushl $70
8010642f:	6a 46                	push   $0x46
  jmp alltraps
80106431:	e9 d3 f8 ff ff       	jmp    80105d09 <alltraps>

80106436 <vector71>:
.globl vector71
vector71:
  pushl $0
80106436:	6a 00                	push   $0x0
  pushl $71
80106438:	6a 47                	push   $0x47
  jmp alltraps
8010643a:	e9 ca f8 ff ff       	jmp    80105d09 <alltraps>

8010643f <vector72>:
.globl vector72
vector72:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $72
80106441:	6a 48                	push   $0x48
  jmp alltraps
80106443:	e9 c1 f8 ff ff       	jmp    80105d09 <alltraps>

80106448 <vector73>:
.globl vector73
vector73:
  pushl $0
80106448:	6a 00                	push   $0x0
  pushl $73
8010644a:	6a 49                	push   $0x49
  jmp alltraps
8010644c:	e9 b8 f8 ff ff       	jmp    80105d09 <alltraps>

80106451 <vector74>:
.globl vector74
vector74:
  pushl $0
80106451:	6a 00                	push   $0x0
  pushl $74
80106453:	6a 4a                	push   $0x4a
  jmp alltraps
80106455:	e9 af f8 ff ff       	jmp    80105d09 <alltraps>

8010645a <vector75>:
.globl vector75
vector75:
  pushl $0
8010645a:	6a 00                	push   $0x0
  pushl $75
8010645c:	6a 4b                	push   $0x4b
  jmp alltraps
8010645e:	e9 a6 f8 ff ff       	jmp    80105d09 <alltraps>

80106463 <vector76>:
.globl vector76
vector76:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $76
80106465:	6a 4c                	push   $0x4c
  jmp alltraps
80106467:	e9 9d f8 ff ff       	jmp    80105d09 <alltraps>

8010646c <vector77>:
.globl vector77
vector77:
  pushl $0
8010646c:	6a 00                	push   $0x0
  pushl $77
8010646e:	6a 4d                	push   $0x4d
  jmp alltraps
80106470:	e9 94 f8 ff ff       	jmp    80105d09 <alltraps>

80106475 <vector78>:
.globl vector78
vector78:
  pushl $0
80106475:	6a 00                	push   $0x0
  pushl $78
80106477:	6a 4e                	push   $0x4e
  jmp alltraps
80106479:	e9 8b f8 ff ff       	jmp    80105d09 <alltraps>

8010647e <vector79>:
.globl vector79
vector79:
  pushl $0
8010647e:	6a 00                	push   $0x0
  pushl $79
80106480:	6a 4f                	push   $0x4f
  jmp alltraps
80106482:	e9 82 f8 ff ff       	jmp    80105d09 <alltraps>

80106487 <vector80>:
.globl vector80
vector80:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $80
80106489:	6a 50                	push   $0x50
  jmp alltraps
8010648b:	e9 79 f8 ff ff       	jmp    80105d09 <alltraps>

80106490 <vector81>:
.globl vector81
vector81:
  pushl $0
80106490:	6a 00                	push   $0x0
  pushl $81
80106492:	6a 51                	push   $0x51
  jmp alltraps
80106494:	e9 70 f8 ff ff       	jmp    80105d09 <alltraps>

80106499 <vector82>:
.globl vector82
vector82:
  pushl $0
80106499:	6a 00                	push   $0x0
  pushl $82
8010649b:	6a 52                	push   $0x52
  jmp alltraps
8010649d:	e9 67 f8 ff ff       	jmp    80105d09 <alltraps>

801064a2 <vector83>:
.globl vector83
vector83:
  pushl $0
801064a2:	6a 00                	push   $0x0
  pushl $83
801064a4:	6a 53                	push   $0x53
  jmp alltraps
801064a6:	e9 5e f8 ff ff       	jmp    80105d09 <alltraps>

801064ab <vector84>:
.globl vector84
vector84:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $84
801064ad:	6a 54                	push   $0x54
  jmp alltraps
801064af:	e9 55 f8 ff ff       	jmp    80105d09 <alltraps>

801064b4 <vector85>:
.globl vector85
vector85:
  pushl $0
801064b4:	6a 00                	push   $0x0
  pushl $85
801064b6:	6a 55                	push   $0x55
  jmp alltraps
801064b8:	e9 4c f8 ff ff       	jmp    80105d09 <alltraps>

801064bd <vector86>:
.globl vector86
vector86:
  pushl $0
801064bd:	6a 00                	push   $0x0
  pushl $86
801064bf:	6a 56                	push   $0x56
  jmp alltraps
801064c1:	e9 43 f8 ff ff       	jmp    80105d09 <alltraps>

801064c6 <vector87>:
.globl vector87
vector87:
  pushl $0
801064c6:	6a 00                	push   $0x0
  pushl $87
801064c8:	6a 57                	push   $0x57
  jmp alltraps
801064ca:	e9 3a f8 ff ff       	jmp    80105d09 <alltraps>

801064cf <vector88>:
.globl vector88
vector88:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $88
801064d1:	6a 58                	push   $0x58
  jmp alltraps
801064d3:	e9 31 f8 ff ff       	jmp    80105d09 <alltraps>

801064d8 <vector89>:
.globl vector89
vector89:
  pushl $0
801064d8:	6a 00                	push   $0x0
  pushl $89
801064da:	6a 59                	push   $0x59
  jmp alltraps
801064dc:	e9 28 f8 ff ff       	jmp    80105d09 <alltraps>

801064e1 <vector90>:
.globl vector90
vector90:
  pushl $0
801064e1:	6a 00                	push   $0x0
  pushl $90
801064e3:	6a 5a                	push   $0x5a
  jmp alltraps
801064e5:	e9 1f f8 ff ff       	jmp    80105d09 <alltraps>

801064ea <vector91>:
.globl vector91
vector91:
  pushl $0
801064ea:	6a 00                	push   $0x0
  pushl $91
801064ec:	6a 5b                	push   $0x5b
  jmp alltraps
801064ee:	e9 16 f8 ff ff       	jmp    80105d09 <alltraps>

801064f3 <vector92>:
.globl vector92
vector92:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $92
801064f5:	6a 5c                	push   $0x5c
  jmp alltraps
801064f7:	e9 0d f8 ff ff       	jmp    80105d09 <alltraps>

801064fc <vector93>:
.globl vector93
vector93:
  pushl $0
801064fc:	6a 00                	push   $0x0
  pushl $93
801064fe:	6a 5d                	push   $0x5d
  jmp alltraps
80106500:	e9 04 f8 ff ff       	jmp    80105d09 <alltraps>

80106505 <vector94>:
.globl vector94
vector94:
  pushl $0
80106505:	6a 00                	push   $0x0
  pushl $94
80106507:	6a 5e                	push   $0x5e
  jmp alltraps
80106509:	e9 fb f7 ff ff       	jmp    80105d09 <alltraps>

8010650e <vector95>:
.globl vector95
vector95:
  pushl $0
8010650e:	6a 00                	push   $0x0
  pushl $95
80106510:	6a 5f                	push   $0x5f
  jmp alltraps
80106512:	e9 f2 f7 ff ff       	jmp    80105d09 <alltraps>

80106517 <vector96>:
.globl vector96
vector96:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $96
80106519:	6a 60                	push   $0x60
  jmp alltraps
8010651b:	e9 e9 f7 ff ff       	jmp    80105d09 <alltraps>

80106520 <vector97>:
.globl vector97
vector97:
  pushl $0
80106520:	6a 00                	push   $0x0
  pushl $97
80106522:	6a 61                	push   $0x61
  jmp alltraps
80106524:	e9 e0 f7 ff ff       	jmp    80105d09 <alltraps>

80106529 <vector98>:
.globl vector98
vector98:
  pushl $0
80106529:	6a 00                	push   $0x0
  pushl $98
8010652b:	6a 62                	push   $0x62
  jmp alltraps
8010652d:	e9 d7 f7 ff ff       	jmp    80105d09 <alltraps>

80106532 <vector99>:
.globl vector99
vector99:
  pushl $0
80106532:	6a 00                	push   $0x0
  pushl $99
80106534:	6a 63                	push   $0x63
  jmp alltraps
80106536:	e9 ce f7 ff ff       	jmp    80105d09 <alltraps>

8010653b <vector100>:
.globl vector100
vector100:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $100
8010653d:	6a 64                	push   $0x64
  jmp alltraps
8010653f:	e9 c5 f7 ff ff       	jmp    80105d09 <alltraps>

80106544 <vector101>:
.globl vector101
vector101:
  pushl $0
80106544:	6a 00                	push   $0x0
  pushl $101
80106546:	6a 65                	push   $0x65
  jmp alltraps
80106548:	e9 bc f7 ff ff       	jmp    80105d09 <alltraps>

8010654d <vector102>:
.globl vector102
vector102:
  pushl $0
8010654d:	6a 00                	push   $0x0
  pushl $102
8010654f:	6a 66                	push   $0x66
  jmp alltraps
80106551:	e9 b3 f7 ff ff       	jmp    80105d09 <alltraps>

80106556 <vector103>:
.globl vector103
vector103:
  pushl $0
80106556:	6a 00                	push   $0x0
  pushl $103
80106558:	6a 67                	push   $0x67
  jmp alltraps
8010655a:	e9 aa f7 ff ff       	jmp    80105d09 <alltraps>

8010655f <vector104>:
.globl vector104
vector104:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $104
80106561:	6a 68                	push   $0x68
  jmp alltraps
80106563:	e9 a1 f7 ff ff       	jmp    80105d09 <alltraps>

80106568 <vector105>:
.globl vector105
vector105:
  pushl $0
80106568:	6a 00                	push   $0x0
  pushl $105
8010656a:	6a 69                	push   $0x69
  jmp alltraps
8010656c:	e9 98 f7 ff ff       	jmp    80105d09 <alltraps>

80106571 <vector106>:
.globl vector106
vector106:
  pushl $0
80106571:	6a 00                	push   $0x0
  pushl $106
80106573:	6a 6a                	push   $0x6a
  jmp alltraps
80106575:	e9 8f f7 ff ff       	jmp    80105d09 <alltraps>

8010657a <vector107>:
.globl vector107
vector107:
  pushl $0
8010657a:	6a 00                	push   $0x0
  pushl $107
8010657c:	6a 6b                	push   $0x6b
  jmp alltraps
8010657e:	e9 86 f7 ff ff       	jmp    80105d09 <alltraps>

80106583 <vector108>:
.globl vector108
vector108:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $108
80106585:	6a 6c                	push   $0x6c
  jmp alltraps
80106587:	e9 7d f7 ff ff       	jmp    80105d09 <alltraps>

8010658c <vector109>:
.globl vector109
vector109:
  pushl $0
8010658c:	6a 00                	push   $0x0
  pushl $109
8010658e:	6a 6d                	push   $0x6d
  jmp alltraps
80106590:	e9 74 f7 ff ff       	jmp    80105d09 <alltraps>

80106595 <vector110>:
.globl vector110
vector110:
  pushl $0
80106595:	6a 00                	push   $0x0
  pushl $110
80106597:	6a 6e                	push   $0x6e
  jmp alltraps
80106599:	e9 6b f7 ff ff       	jmp    80105d09 <alltraps>

8010659e <vector111>:
.globl vector111
vector111:
  pushl $0
8010659e:	6a 00                	push   $0x0
  pushl $111
801065a0:	6a 6f                	push   $0x6f
  jmp alltraps
801065a2:	e9 62 f7 ff ff       	jmp    80105d09 <alltraps>

801065a7 <vector112>:
.globl vector112
vector112:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $112
801065a9:	6a 70                	push   $0x70
  jmp alltraps
801065ab:	e9 59 f7 ff ff       	jmp    80105d09 <alltraps>

801065b0 <vector113>:
.globl vector113
vector113:
  pushl $0
801065b0:	6a 00                	push   $0x0
  pushl $113
801065b2:	6a 71                	push   $0x71
  jmp alltraps
801065b4:	e9 50 f7 ff ff       	jmp    80105d09 <alltraps>

801065b9 <vector114>:
.globl vector114
vector114:
  pushl $0
801065b9:	6a 00                	push   $0x0
  pushl $114
801065bb:	6a 72                	push   $0x72
  jmp alltraps
801065bd:	e9 47 f7 ff ff       	jmp    80105d09 <alltraps>

801065c2 <vector115>:
.globl vector115
vector115:
  pushl $0
801065c2:	6a 00                	push   $0x0
  pushl $115
801065c4:	6a 73                	push   $0x73
  jmp alltraps
801065c6:	e9 3e f7 ff ff       	jmp    80105d09 <alltraps>

801065cb <vector116>:
.globl vector116
vector116:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $116
801065cd:	6a 74                	push   $0x74
  jmp alltraps
801065cf:	e9 35 f7 ff ff       	jmp    80105d09 <alltraps>

801065d4 <vector117>:
.globl vector117
vector117:
  pushl $0
801065d4:	6a 00                	push   $0x0
  pushl $117
801065d6:	6a 75                	push   $0x75
  jmp alltraps
801065d8:	e9 2c f7 ff ff       	jmp    80105d09 <alltraps>

801065dd <vector118>:
.globl vector118
vector118:
  pushl $0
801065dd:	6a 00                	push   $0x0
  pushl $118
801065df:	6a 76                	push   $0x76
  jmp alltraps
801065e1:	e9 23 f7 ff ff       	jmp    80105d09 <alltraps>

801065e6 <vector119>:
.globl vector119
vector119:
  pushl $0
801065e6:	6a 00                	push   $0x0
  pushl $119
801065e8:	6a 77                	push   $0x77
  jmp alltraps
801065ea:	e9 1a f7 ff ff       	jmp    80105d09 <alltraps>

801065ef <vector120>:
.globl vector120
vector120:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $120
801065f1:	6a 78                	push   $0x78
  jmp alltraps
801065f3:	e9 11 f7 ff ff       	jmp    80105d09 <alltraps>

801065f8 <vector121>:
.globl vector121
vector121:
  pushl $0
801065f8:	6a 00                	push   $0x0
  pushl $121
801065fa:	6a 79                	push   $0x79
  jmp alltraps
801065fc:	e9 08 f7 ff ff       	jmp    80105d09 <alltraps>

80106601 <vector122>:
.globl vector122
vector122:
  pushl $0
80106601:	6a 00                	push   $0x0
  pushl $122
80106603:	6a 7a                	push   $0x7a
  jmp alltraps
80106605:	e9 ff f6 ff ff       	jmp    80105d09 <alltraps>

8010660a <vector123>:
.globl vector123
vector123:
  pushl $0
8010660a:	6a 00                	push   $0x0
  pushl $123
8010660c:	6a 7b                	push   $0x7b
  jmp alltraps
8010660e:	e9 f6 f6 ff ff       	jmp    80105d09 <alltraps>

80106613 <vector124>:
.globl vector124
vector124:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $124
80106615:	6a 7c                	push   $0x7c
  jmp alltraps
80106617:	e9 ed f6 ff ff       	jmp    80105d09 <alltraps>

8010661c <vector125>:
.globl vector125
vector125:
  pushl $0
8010661c:	6a 00                	push   $0x0
  pushl $125
8010661e:	6a 7d                	push   $0x7d
  jmp alltraps
80106620:	e9 e4 f6 ff ff       	jmp    80105d09 <alltraps>

80106625 <vector126>:
.globl vector126
vector126:
  pushl $0
80106625:	6a 00                	push   $0x0
  pushl $126
80106627:	6a 7e                	push   $0x7e
  jmp alltraps
80106629:	e9 db f6 ff ff       	jmp    80105d09 <alltraps>

8010662e <vector127>:
.globl vector127
vector127:
  pushl $0
8010662e:	6a 00                	push   $0x0
  pushl $127
80106630:	6a 7f                	push   $0x7f
  jmp alltraps
80106632:	e9 d2 f6 ff ff       	jmp    80105d09 <alltraps>

80106637 <vector128>:
.globl vector128
vector128:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $128
80106639:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010663e:	e9 c6 f6 ff ff       	jmp    80105d09 <alltraps>

80106643 <vector129>:
.globl vector129
vector129:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $129
80106645:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010664a:	e9 ba f6 ff ff       	jmp    80105d09 <alltraps>

8010664f <vector130>:
.globl vector130
vector130:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $130
80106651:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106656:	e9 ae f6 ff ff       	jmp    80105d09 <alltraps>

8010665b <vector131>:
.globl vector131
vector131:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $131
8010665d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106662:	e9 a2 f6 ff ff       	jmp    80105d09 <alltraps>

80106667 <vector132>:
.globl vector132
vector132:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $132
80106669:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010666e:	e9 96 f6 ff ff       	jmp    80105d09 <alltraps>

80106673 <vector133>:
.globl vector133
vector133:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $133
80106675:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010667a:	e9 8a f6 ff ff       	jmp    80105d09 <alltraps>

8010667f <vector134>:
.globl vector134
vector134:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $134
80106681:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106686:	e9 7e f6 ff ff       	jmp    80105d09 <alltraps>

8010668b <vector135>:
.globl vector135
vector135:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $135
8010668d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106692:	e9 72 f6 ff ff       	jmp    80105d09 <alltraps>

80106697 <vector136>:
.globl vector136
vector136:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $136
80106699:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010669e:	e9 66 f6 ff ff       	jmp    80105d09 <alltraps>

801066a3 <vector137>:
.globl vector137
vector137:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $137
801066a5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801066aa:	e9 5a f6 ff ff       	jmp    80105d09 <alltraps>

801066af <vector138>:
.globl vector138
vector138:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $138
801066b1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801066b6:	e9 4e f6 ff ff       	jmp    80105d09 <alltraps>

801066bb <vector139>:
.globl vector139
vector139:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $139
801066bd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801066c2:	e9 42 f6 ff ff       	jmp    80105d09 <alltraps>

801066c7 <vector140>:
.globl vector140
vector140:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $140
801066c9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801066ce:	e9 36 f6 ff ff       	jmp    80105d09 <alltraps>

801066d3 <vector141>:
.globl vector141
vector141:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $141
801066d5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801066da:	e9 2a f6 ff ff       	jmp    80105d09 <alltraps>

801066df <vector142>:
.globl vector142
vector142:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $142
801066e1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801066e6:	e9 1e f6 ff ff       	jmp    80105d09 <alltraps>

801066eb <vector143>:
.globl vector143
vector143:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $143
801066ed:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801066f2:	e9 12 f6 ff ff       	jmp    80105d09 <alltraps>

801066f7 <vector144>:
.globl vector144
vector144:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $144
801066f9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801066fe:	e9 06 f6 ff ff       	jmp    80105d09 <alltraps>

80106703 <vector145>:
.globl vector145
vector145:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $145
80106705:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010670a:	e9 fa f5 ff ff       	jmp    80105d09 <alltraps>

8010670f <vector146>:
.globl vector146
vector146:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $146
80106711:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106716:	e9 ee f5 ff ff       	jmp    80105d09 <alltraps>

8010671b <vector147>:
.globl vector147
vector147:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $147
8010671d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106722:	e9 e2 f5 ff ff       	jmp    80105d09 <alltraps>

80106727 <vector148>:
.globl vector148
vector148:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $148
80106729:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010672e:	e9 d6 f5 ff ff       	jmp    80105d09 <alltraps>

80106733 <vector149>:
.globl vector149
vector149:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $149
80106735:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010673a:	e9 ca f5 ff ff       	jmp    80105d09 <alltraps>

8010673f <vector150>:
.globl vector150
vector150:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $150
80106741:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106746:	e9 be f5 ff ff       	jmp    80105d09 <alltraps>

8010674b <vector151>:
.globl vector151
vector151:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $151
8010674d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106752:	e9 b2 f5 ff ff       	jmp    80105d09 <alltraps>

80106757 <vector152>:
.globl vector152
vector152:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $152
80106759:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010675e:	e9 a6 f5 ff ff       	jmp    80105d09 <alltraps>

80106763 <vector153>:
.globl vector153
vector153:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $153
80106765:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010676a:	e9 9a f5 ff ff       	jmp    80105d09 <alltraps>

8010676f <vector154>:
.globl vector154
vector154:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $154
80106771:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106776:	e9 8e f5 ff ff       	jmp    80105d09 <alltraps>

8010677b <vector155>:
.globl vector155
vector155:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $155
8010677d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106782:	e9 82 f5 ff ff       	jmp    80105d09 <alltraps>

80106787 <vector156>:
.globl vector156
vector156:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $156
80106789:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010678e:	e9 76 f5 ff ff       	jmp    80105d09 <alltraps>

80106793 <vector157>:
.globl vector157
vector157:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $157
80106795:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010679a:	e9 6a f5 ff ff       	jmp    80105d09 <alltraps>

8010679f <vector158>:
.globl vector158
vector158:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $158
801067a1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801067a6:	e9 5e f5 ff ff       	jmp    80105d09 <alltraps>

801067ab <vector159>:
.globl vector159
vector159:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $159
801067ad:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801067b2:	e9 52 f5 ff ff       	jmp    80105d09 <alltraps>

801067b7 <vector160>:
.globl vector160
vector160:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $160
801067b9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801067be:	e9 46 f5 ff ff       	jmp    80105d09 <alltraps>

801067c3 <vector161>:
.globl vector161
vector161:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $161
801067c5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801067ca:	e9 3a f5 ff ff       	jmp    80105d09 <alltraps>

801067cf <vector162>:
.globl vector162
vector162:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $162
801067d1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801067d6:	e9 2e f5 ff ff       	jmp    80105d09 <alltraps>

801067db <vector163>:
.globl vector163
vector163:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $163
801067dd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801067e2:	e9 22 f5 ff ff       	jmp    80105d09 <alltraps>

801067e7 <vector164>:
.globl vector164
vector164:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $164
801067e9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801067ee:	e9 16 f5 ff ff       	jmp    80105d09 <alltraps>

801067f3 <vector165>:
.globl vector165
vector165:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $165
801067f5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801067fa:	e9 0a f5 ff ff       	jmp    80105d09 <alltraps>

801067ff <vector166>:
.globl vector166
vector166:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $166
80106801:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106806:	e9 fe f4 ff ff       	jmp    80105d09 <alltraps>

8010680b <vector167>:
.globl vector167
vector167:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $167
8010680d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106812:	e9 f2 f4 ff ff       	jmp    80105d09 <alltraps>

80106817 <vector168>:
.globl vector168
vector168:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $168
80106819:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010681e:	e9 e6 f4 ff ff       	jmp    80105d09 <alltraps>

80106823 <vector169>:
.globl vector169
vector169:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $169
80106825:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010682a:	e9 da f4 ff ff       	jmp    80105d09 <alltraps>

8010682f <vector170>:
.globl vector170
vector170:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $170
80106831:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106836:	e9 ce f4 ff ff       	jmp    80105d09 <alltraps>

8010683b <vector171>:
.globl vector171
vector171:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $171
8010683d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106842:	e9 c2 f4 ff ff       	jmp    80105d09 <alltraps>

80106847 <vector172>:
.globl vector172
vector172:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $172
80106849:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010684e:	e9 b6 f4 ff ff       	jmp    80105d09 <alltraps>

80106853 <vector173>:
.globl vector173
vector173:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $173
80106855:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010685a:	e9 aa f4 ff ff       	jmp    80105d09 <alltraps>

8010685f <vector174>:
.globl vector174
vector174:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $174
80106861:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106866:	e9 9e f4 ff ff       	jmp    80105d09 <alltraps>

8010686b <vector175>:
.globl vector175
vector175:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $175
8010686d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106872:	e9 92 f4 ff ff       	jmp    80105d09 <alltraps>

80106877 <vector176>:
.globl vector176
vector176:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $176
80106879:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010687e:	e9 86 f4 ff ff       	jmp    80105d09 <alltraps>

80106883 <vector177>:
.globl vector177
vector177:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $177
80106885:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010688a:	e9 7a f4 ff ff       	jmp    80105d09 <alltraps>

8010688f <vector178>:
.globl vector178
vector178:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $178
80106891:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106896:	e9 6e f4 ff ff       	jmp    80105d09 <alltraps>

8010689b <vector179>:
.globl vector179
vector179:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $179
8010689d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801068a2:	e9 62 f4 ff ff       	jmp    80105d09 <alltraps>

801068a7 <vector180>:
.globl vector180
vector180:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $180
801068a9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801068ae:	e9 56 f4 ff ff       	jmp    80105d09 <alltraps>

801068b3 <vector181>:
.globl vector181
vector181:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $181
801068b5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801068ba:	e9 4a f4 ff ff       	jmp    80105d09 <alltraps>

801068bf <vector182>:
.globl vector182
vector182:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $182
801068c1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801068c6:	e9 3e f4 ff ff       	jmp    80105d09 <alltraps>

801068cb <vector183>:
.globl vector183
vector183:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $183
801068cd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801068d2:	e9 32 f4 ff ff       	jmp    80105d09 <alltraps>

801068d7 <vector184>:
.globl vector184
vector184:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $184
801068d9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801068de:	e9 26 f4 ff ff       	jmp    80105d09 <alltraps>

801068e3 <vector185>:
.globl vector185
vector185:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $185
801068e5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801068ea:	e9 1a f4 ff ff       	jmp    80105d09 <alltraps>

801068ef <vector186>:
.globl vector186
vector186:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $186
801068f1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801068f6:	e9 0e f4 ff ff       	jmp    80105d09 <alltraps>

801068fb <vector187>:
.globl vector187
vector187:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $187
801068fd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106902:	e9 02 f4 ff ff       	jmp    80105d09 <alltraps>

80106907 <vector188>:
.globl vector188
vector188:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $188
80106909:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010690e:	e9 f6 f3 ff ff       	jmp    80105d09 <alltraps>

80106913 <vector189>:
.globl vector189
vector189:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $189
80106915:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010691a:	e9 ea f3 ff ff       	jmp    80105d09 <alltraps>

8010691f <vector190>:
.globl vector190
vector190:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $190
80106921:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106926:	e9 de f3 ff ff       	jmp    80105d09 <alltraps>

8010692b <vector191>:
.globl vector191
vector191:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $191
8010692d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106932:	e9 d2 f3 ff ff       	jmp    80105d09 <alltraps>

80106937 <vector192>:
.globl vector192
vector192:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $192
80106939:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010693e:	e9 c6 f3 ff ff       	jmp    80105d09 <alltraps>

80106943 <vector193>:
.globl vector193
vector193:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $193
80106945:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010694a:	e9 ba f3 ff ff       	jmp    80105d09 <alltraps>

8010694f <vector194>:
.globl vector194
vector194:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $194
80106951:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106956:	e9 ae f3 ff ff       	jmp    80105d09 <alltraps>

8010695b <vector195>:
.globl vector195
vector195:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $195
8010695d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106962:	e9 a2 f3 ff ff       	jmp    80105d09 <alltraps>

80106967 <vector196>:
.globl vector196
vector196:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $196
80106969:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010696e:	e9 96 f3 ff ff       	jmp    80105d09 <alltraps>

80106973 <vector197>:
.globl vector197
vector197:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $197
80106975:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010697a:	e9 8a f3 ff ff       	jmp    80105d09 <alltraps>

8010697f <vector198>:
.globl vector198
vector198:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $198
80106981:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106986:	e9 7e f3 ff ff       	jmp    80105d09 <alltraps>

8010698b <vector199>:
.globl vector199
vector199:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $199
8010698d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106992:	e9 72 f3 ff ff       	jmp    80105d09 <alltraps>

80106997 <vector200>:
.globl vector200
vector200:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $200
80106999:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010699e:	e9 66 f3 ff ff       	jmp    80105d09 <alltraps>

801069a3 <vector201>:
.globl vector201
vector201:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $201
801069a5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801069aa:	e9 5a f3 ff ff       	jmp    80105d09 <alltraps>

801069af <vector202>:
.globl vector202
vector202:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $202
801069b1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801069b6:	e9 4e f3 ff ff       	jmp    80105d09 <alltraps>

801069bb <vector203>:
.globl vector203
vector203:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $203
801069bd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801069c2:	e9 42 f3 ff ff       	jmp    80105d09 <alltraps>

801069c7 <vector204>:
.globl vector204
vector204:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $204
801069c9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801069ce:	e9 36 f3 ff ff       	jmp    80105d09 <alltraps>

801069d3 <vector205>:
.globl vector205
vector205:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $205
801069d5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801069da:	e9 2a f3 ff ff       	jmp    80105d09 <alltraps>

801069df <vector206>:
.globl vector206
vector206:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $206
801069e1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801069e6:	e9 1e f3 ff ff       	jmp    80105d09 <alltraps>

801069eb <vector207>:
.globl vector207
vector207:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $207
801069ed:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801069f2:	e9 12 f3 ff ff       	jmp    80105d09 <alltraps>

801069f7 <vector208>:
.globl vector208
vector208:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $208
801069f9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801069fe:	e9 06 f3 ff ff       	jmp    80105d09 <alltraps>

80106a03 <vector209>:
.globl vector209
vector209:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $209
80106a05:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106a0a:	e9 fa f2 ff ff       	jmp    80105d09 <alltraps>

80106a0f <vector210>:
.globl vector210
vector210:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $210
80106a11:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106a16:	e9 ee f2 ff ff       	jmp    80105d09 <alltraps>

80106a1b <vector211>:
.globl vector211
vector211:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $211
80106a1d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106a22:	e9 e2 f2 ff ff       	jmp    80105d09 <alltraps>

80106a27 <vector212>:
.globl vector212
vector212:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $212
80106a29:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106a2e:	e9 d6 f2 ff ff       	jmp    80105d09 <alltraps>

80106a33 <vector213>:
.globl vector213
vector213:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $213
80106a35:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106a3a:	e9 ca f2 ff ff       	jmp    80105d09 <alltraps>

80106a3f <vector214>:
.globl vector214
vector214:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $214
80106a41:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106a46:	e9 be f2 ff ff       	jmp    80105d09 <alltraps>

80106a4b <vector215>:
.globl vector215
vector215:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $215
80106a4d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106a52:	e9 b2 f2 ff ff       	jmp    80105d09 <alltraps>

80106a57 <vector216>:
.globl vector216
vector216:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $216
80106a59:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106a5e:	e9 a6 f2 ff ff       	jmp    80105d09 <alltraps>

80106a63 <vector217>:
.globl vector217
vector217:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $217
80106a65:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106a6a:	e9 9a f2 ff ff       	jmp    80105d09 <alltraps>

80106a6f <vector218>:
.globl vector218
vector218:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $218
80106a71:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106a76:	e9 8e f2 ff ff       	jmp    80105d09 <alltraps>

80106a7b <vector219>:
.globl vector219
vector219:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $219
80106a7d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106a82:	e9 82 f2 ff ff       	jmp    80105d09 <alltraps>

80106a87 <vector220>:
.globl vector220
vector220:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $220
80106a89:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106a8e:	e9 76 f2 ff ff       	jmp    80105d09 <alltraps>

80106a93 <vector221>:
.globl vector221
vector221:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $221
80106a95:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106a9a:	e9 6a f2 ff ff       	jmp    80105d09 <alltraps>

80106a9f <vector222>:
.globl vector222
vector222:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $222
80106aa1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106aa6:	e9 5e f2 ff ff       	jmp    80105d09 <alltraps>

80106aab <vector223>:
.globl vector223
vector223:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $223
80106aad:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106ab2:	e9 52 f2 ff ff       	jmp    80105d09 <alltraps>

80106ab7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $224
80106ab9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106abe:	e9 46 f2 ff ff       	jmp    80105d09 <alltraps>

80106ac3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $225
80106ac5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106aca:	e9 3a f2 ff ff       	jmp    80105d09 <alltraps>

80106acf <vector226>:
.globl vector226
vector226:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $226
80106ad1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ad6:	e9 2e f2 ff ff       	jmp    80105d09 <alltraps>

80106adb <vector227>:
.globl vector227
vector227:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $227
80106add:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ae2:	e9 22 f2 ff ff       	jmp    80105d09 <alltraps>

80106ae7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $228
80106ae9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106aee:	e9 16 f2 ff ff       	jmp    80105d09 <alltraps>

80106af3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $229
80106af5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106afa:	e9 0a f2 ff ff       	jmp    80105d09 <alltraps>

80106aff <vector230>:
.globl vector230
vector230:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $230
80106b01:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106b06:	e9 fe f1 ff ff       	jmp    80105d09 <alltraps>

80106b0b <vector231>:
.globl vector231
vector231:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $231
80106b0d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106b12:	e9 f2 f1 ff ff       	jmp    80105d09 <alltraps>

80106b17 <vector232>:
.globl vector232
vector232:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $232
80106b19:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106b1e:	e9 e6 f1 ff ff       	jmp    80105d09 <alltraps>

80106b23 <vector233>:
.globl vector233
vector233:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $233
80106b25:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106b2a:	e9 da f1 ff ff       	jmp    80105d09 <alltraps>

80106b2f <vector234>:
.globl vector234
vector234:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $234
80106b31:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106b36:	e9 ce f1 ff ff       	jmp    80105d09 <alltraps>

80106b3b <vector235>:
.globl vector235
vector235:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $235
80106b3d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106b42:	e9 c2 f1 ff ff       	jmp    80105d09 <alltraps>

80106b47 <vector236>:
.globl vector236
vector236:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $236
80106b49:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106b4e:	e9 b6 f1 ff ff       	jmp    80105d09 <alltraps>

80106b53 <vector237>:
.globl vector237
vector237:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $237
80106b55:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106b5a:	e9 aa f1 ff ff       	jmp    80105d09 <alltraps>

80106b5f <vector238>:
.globl vector238
vector238:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $238
80106b61:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106b66:	e9 9e f1 ff ff       	jmp    80105d09 <alltraps>

80106b6b <vector239>:
.globl vector239
vector239:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $239
80106b6d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106b72:	e9 92 f1 ff ff       	jmp    80105d09 <alltraps>

80106b77 <vector240>:
.globl vector240
vector240:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $240
80106b79:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106b7e:	e9 86 f1 ff ff       	jmp    80105d09 <alltraps>

80106b83 <vector241>:
.globl vector241
vector241:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $241
80106b85:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106b8a:	e9 7a f1 ff ff       	jmp    80105d09 <alltraps>

80106b8f <vector242>:
.globl vector242
vector242:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $242
80106b91:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106b96:	e9 6e f1 ff ff       	jmp    80105d09 <alltraps>

80106b9b <vector243>:
.globl vector243
vector243:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $243
80106b9d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106ba2:	e9 62 f1 ff ff       	jmp    80105d09 <alltraps>

80106ba7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $244
80106ba9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106bae:	e9 56 f1 ff ff       	jmp    80105d09 <alltraps>

80106bb3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $245
80106bb5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106bba:	e9 4a f1 ff ff       	jmp    80105d09 <alltraps>

80106bbf <vector246>:
.globl vector246
vector246:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $246
80106bc1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106bc6:	e9 3e f1 ff ff       	jmp    80105d09 <alltraps>

80106bcb <vector247>:
.globl vector247
vector247:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $247
80106bcd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106bd2:	e9 32 f1 ff ff       	jmp    80105d09 <alltraps>

80106bd7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $248
80106bd9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106bde:	e9 26 f1 ff ff       	jmp    80105d09 <alltraps>

80106be3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $249
80106be5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106bea:	e9 1a f1 ff ff       	jmp    80105d09 <alltraps>

80106bef <vector250>:
.globl vector250
vector250:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $250
80106bf1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106bf6:	e9 0e f1 ff ff       	jmp    80105d09 <alltraps>

80106bfb <vector251>:
.globl vector251
vector251:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $251
80106bfd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106c02:	e9 02 f1 ff ff       	jmp    80105d09 <alltraps>

80106c07 <vector252>:
.globl vector252
vector252:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $252
80106c09:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106c0e:	e9 f6 f0 ff ff       	jmp    80105d09 <alltraps>

80106c13 <vector253>:
.globl vector253
vector253:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $253
80106c15:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106c1a:	e9 ea f0 ff ff       	jmp    80105d09 <alltraps>

80106c1f <vector254>:
.globl vector254
vector254:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $254
80106c21:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106c26:	e9 de f0 ff ff       	jmp    80105d09 <alltraps>

80106c2b <vector255>:
.globl vector255
vector255:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $255
80106c2d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106c32:	e9 d2 f0 ff ff       	jmp    80105d09 <alltraps>
80106c37:	66 90                	xchg   %ax,%ax
80106c39:	66 90                	xchg   %ax,%ax
80106c3b:	66 90                	xchg   %ax,%ax
80106c3d:	66 90                	xchg   %ax,%ax
80106c3f:	90                   	nop

80106c40 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
80106c46:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106c48:	c1 ea 16             	shr    $0x16,%edx
80106c4b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106c4e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106c51:	8b 07                	mov    (%edi),%eax
80106c53:	a8 01                	test   $0x1,%al
80106c55:	74 29                	je     80106c80 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c57:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c5c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106c62:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106c65:	c1 eb 0a             	shr    $0xa,%ebx
80106c68:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80106c6e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106c71:	5b                   	pop    %ebx
80106c72:	5e                   	pop    %esi
80106c73:	5f                   	pop    %edi
80106c74:	5d                   	pop    %ebp
80106c75:	c3                   	ret    
80106c76:	8d 76 00             	lea    0x0(%esi),%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c80:	85 c9                	test   %ecx,%ecx
80106c82:	74 2c                	je     80106cb0 <walkpgdir+0x70>
80106c84:	e8 37 b9 ff ff       	call   801025c0 <kalloc>
80106c89:	85 c0                	test   %eax,%eax
80106c8b:	89 c6                	mov    %eax,%esi
80106c8d:	74 21                	je     80106cb0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80106c8f:	83 ec 04             	sub    $0x4,%esp
80106c92:	68 00 10 00 00       	push   $0x1000
80106c97:	6a 00                	push   $0x0
80106c99:	50                   	push   %eax
80106c9a:	e8 91 da ff ff       	call   80104730 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c9f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106ca5:	83 c4 10             	add    $0x10,%esp
80106ca8:	83 c8 07             	or     $0x7,%eax
80106cab:	89 07                	mov    %eax,(%edi)
80106cad:	eb b3                	jmp    80106c62 <walkpgdir+0x22>
80106caf:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80106cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106cb3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106cb5:	5b                   	pop    %ebx
80106cb6:	5e                   	pop    %esi
80106cb7:	5f                   	pop    %edi
80106cb8:	5d                   	pop    %ebp
80106cb9:	c3                   	ret    
80106cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106cc0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	57                   	push   %edi
80106cc4:	56                   	push   %esi
80106cc5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106cc6:	89 d3                	mov    %edx,%ebx
80106cc8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106cce:	83 ec 1c             	sub    $0x1c,%esp
80106cd1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106cd4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106cd8:	8b 7d 08             	mov    0x8(%ebp),%edi
80106cdb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106ce0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ce6:	29 df                	sub    %ebx,%edi
80106ce8:	83 c8 01             	or     $0x1,%eax
80106ceb:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106cee:	eb 15                	jmp    80106d05 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106cf0:	f6 00 01             	testb  $0x1,(%eax)
80106cf3:	75 45                	jne    80106d3a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106cf5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106cf8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106cfb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106cfd:	74 31                	je     80106d30 <mappages+0x70>
      break;
    a += PGSIZE;
80106cff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106d05:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d08:	b9 01 00 00 00       	mov    $0x1,%ecx
80106d0d:	89 da                	mov    %ebx,%edx
80106d0f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106d12:	e8 29 ff ff ff       	call   80106c40 <walkpgdir>
80106d17:	85 c0                	test   %eax,%eax
80106d19:	75 d5                	jne    80106cf0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106d1b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106d1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106d23:	5b                   	pop    %ebx
80106d24:	5e                   	pop    %esi
80106d25:	5f                   	pop    %edi
80106d26:	5d                   	pop    %ebp
80106d27:	c3                   	ret    
80106d28:	90                   	nop
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d30:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106d33:	31 c0                	xor    %eax,%eax
}
80106d35:	5b                   	pop    %ebx
80106d36:	5e                   	pop    %esi
80106d37:	5f                   	pop    %edi
80106d38:	5d                   	pop    %ebp
80106d39:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106d3a:	83 ec 0c             	sub    $0xc,%esp
80106d3d:	68 68 7f 10 80       	push   $0x80107f68
80106d42:	e8 29 96 ff ff       	call   80100370 <panic>
80106d47:	89 f6                	mov    %esi,%esi
80106d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d50 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d50:	55                   	push   %ebp
80106d51:	89 e5                	mov    %esp,%ebp
80106d53:	57                   	push   %edi
80106d54:	56                   	push   %esi
80106d55:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d56:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d5c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106d5e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106d64:	83 ec 1c             	sub    $0x1c,%esp
80106d67:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106d6a:	39 d3                	cmp    %edx,%ebx
80106d6c:	73 66                	jae    80106dd4 <deallocuvm.part.0+0x84>
80106d6e:	89 d6                	mov    %edx,%esi
80106d70:	eb 3d                	jmp    80106daf <deallocuvm.part.0+0x5f>
80106d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106d78:	8b 10                	mov    (%eax),%edx
80106d7a:	f6 c2 01             	test   $0x1,%dl
80106d7d:	74 26                	je     80106da5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106d7f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d85:	74 58                	je     80106ddf <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106d87:	83 ec 0c             	sub    $0xc,%esp
80106d8a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d93:	52                   	push   %edx
80106d94:	e8 77 b6 ff ff       	call   80102410 <kfree>
      *pte = 0;
80106d99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d9c:	83 c4 10             	add    $0x10,%esp
80106d9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106da5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dab:	39 f3                	cmp    %esi,%ebx
80106dad:	73 25                	jae    80106dd4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106daf:	31 c9                	xor    %ecx,%ecx
80106db1:	89 da                	mov    %ebx,%edx
80106db3:	89 f8                	mov    %edi,%eax
80106db5:	e8 86 fe ff ff       	call   80106c40 <walkpgdir>
    if(!pte)
80106dba:	85 c0                	test   %eax,%eax
80106dbc:	75 ba                	jne    80106d78 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106dbe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106dc4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106dca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106dd0:	39 f3                	cmp    %esi,%ebx
80106dd2:	72 db                	jb     80106daf <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106dd4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106dd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dda:	5b                   	pop    %ebx
80106ddb:	5e                   	pop    %esi
80106ddc:	5f                   	pop    %edi
80106ddd:	5d                   	pop    %ebp
80106dde:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106ddf:	83 ec 0c             	sub    $0xc,%esp
80106de2:	68 46 78 10 80       	push   $0x80107846
80106de7:	e8 84 95 ff ff       	call   80100370 <panic>
80106dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106df0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106df0:	55                   	push   %ebp
80106df1:	89 e5                	mov    %esp,%ebp
80106df3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106df6:	e8 a5 ca ff ff       	call   801038a0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106dfb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106e01:	31 c9                	xor    %ecx,%ecx
80106e03:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106e08:	66 89 90 f8 b4 11 80 	mov    %dx,-0x7fee4b08(%eax)
80106e0f:	66 89 88 fa b4 11 80 	mov    %cx,-0x7fee4b06(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e16:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106e1b:	31 c9                	xor    %ecx,%ecx
80106e1d:	66 89 90 00 b5 11 80 	mov    %dx,-0x7fee4b00(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e24:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e29:	66 89 88 02 b5 11 80 	mov    %cx,-0x7fee4afe(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e30:	31 c9                	xor    %ecx,%ecx
80106e32:	66 89 90 08 b5 11 80 	mov    %dx,-0x7fee4af8(%eax)
80106e39:	66 89 88 0a b5 11 80 	mov    %cx,-0x7fee4af6(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106e40:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80106e45:	31 c9                	xor    %ecx,%ecx
80106e47:	66 89 90 10 b5 11 80 	mov    %dx,-0x7fee4af0(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106e4e:	c6 80 fc b4 11 80 00 	movb   $0x0,-0x7fee4b04(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106e55:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106e5a:	c6 80 fd b4 11 80 9a 	movb   $0x9a,-0x7fee4b03(%eax)
80106e61:	c6 80 fe b4 11 80 cf 	movb   $0xcf,-0x7fee4b02(%eax)
80106e68:	c6 80 ff b4 11 80 00 	movb   $0x0,-0x7fee4b01(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106e6f:	c6 80 04 b5 11 80 00 	movb   $0x0,-0x7fee4afc(%eax)
80106e76:	c6 80 05 b5 11 80 92 	movb   $0x92,-0x7fee4afb(%eax)
80106e7d:	c6 80 06 b5 11 80 cf 	movb   $0xcf,-0x7fee4afa(%eax)
80106e84:	c6 80 07 b5 11 80 00 	movb   $0x0,-0x7fee4af9(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106e8b:	c6 80 0c b5 11 80 00 	movb   $0x0,-0x7fee4af4(%eax)
80106e92:	c6 80 0d b5 11 80 fa 	movb   $0xfa,-0x7fee4af3(%eax)
80106e99:	c6 80 0e b5 11 80 cf 	movb   $0xcf,-0x7fee4af2(%eax)
80106ea0:	c6 80 0f b5 11 80 00 	movb   $0x0,-0x7fee4af1(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ea7:	66 89 88 12 b5 11 80 	mov    %cx,-0x7fee4aee(%eax)
80106eae:	c6 80 14 b5 11 80 00 	movb   $0x0,-0x7fee4aec(%eax)
80106eb5:	c6 80 15 b5 11 80 f2 	movb   $0xf2,-0x7fee4aeb(%eax)
80106ebc:	c6 80 16 b5 11 80 cf 	movb   $0xcf,-0x7fee4aea(%eax)
80106ec3:	c6 80 17 b5 11 80 00 	movb   $0x0,-0x7fee4ae9(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80106eca:	05 f0 b4 11 80       	add    $0x8011b4f0,%eax
80106ecf:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106ed3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ed7:	c1 e8 10             	shr    $0x10,%eax
80106eda:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106ede:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ee1:	0f 01 10             	lgdtl  (%eax)
}
80106ee4:	c9                   	leave  
80106ee5:	c3                   	ret    
80106ee6:	8d 76 00             	lea    0x0(%esi),%esi
80106ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ef0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ef0:	a1 a4 f9 11 80       	mov    0x8011f9a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106ef5:	55                   	push   %ebp
80106ef6:	89 e5                	mov    %esp,%ebp
80106ef8:	05 00 00 00 80       	add    $0x80000000,%eax
80106efd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106f00:	5d                   	pop    %ebp
80106f01:	c3                   	ret    
80106f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f10 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	57                   	push   %edi
80106f14:	56                   	push   %esi
80106f15:	53                   	push   %ebx
80106f16:	83 ec 1c             	sub    $0x1c,%esp
80106f19:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106f1c:	85 f6                	test   %esi,%esi
80106f1e:	0f 84 cd 00 00 00    	je     80106ff1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106f24:	8b 46 08             	mov    0x8(%esi),%eax
80106f27:	85 c0                	test   %eax,%eax
80106f29:	0f 84 dc 00 00 00    	je     8010700b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106f2f:	8b 7e 04             	mov    0x4(%esi),%edi
80106f32:	85 ff                	test   %edi,%edi
80106f34:	0f 84 c4 00 00 00    	je     80106ffe <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
80106f3a:	e8 11 d6 ff ff       	call   80104550 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106f3f:	e8 dc c8 ff ff       	call   80103820 <mycpu>
80106f44:	89 c3                	mov    %eax,%ebx
80106f46:	e8 d5 c8 ff ff       	call   80103820 <mycpu>
80106f4b:	89 c7                	mov    %eax,%edi
80106f4d:	e8 ce c8 ff ff       	call   80103820 <mycpu>
80106f52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f55:	83 c7 08             	add    $0x8,%edi
80106f58:	e8 c3 c8 ff ff       	call   80103820 <mycpu>
80106f5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f60:	83 c0 08             	add    $0x8,%eax
80106f63:	ba 67 00 00 00       	mov    $0x67,%edx
80106f68:	c1 e8 18             	shr    $0x18,%eax
80106f6b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106f72:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106f79:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106f80:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106f87:	83 c1 08             	add    $0x8,%ecx
80106f8a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106f90:	c1 e9 10             	shr    $0x10,%ecx
80106f93:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106f99:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106f9e:	e8 7d c8 ff ff       	call   80103820 <mycpu>
80106fa3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106faa:	e8 71 c8 ff ff       	call   80103820 <mycpu>
80106faf:	b9 10 00 00 00       	mov    $0x10,%ecx
80106fb4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106fb8:	e8 63 c8 ff ff       	call   80103820 <mycpu>
80106fbd:	8b 56 08             	mov    0x8(%esi),%edx
80106fc0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106fc6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106fc9:	e8 52 c8 ff ff       	call   80103820 <mycpu>
80106fce:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106fd2:	b8 28 00 00 00       	mov    $0x28,%eax
80106fd7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106fda:	8b 46 04             	mov    0x4(%esi),%eax
80106fdd:	05 00 00 00 80       	add    $0x80000000,%eax
80106fe2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106fe5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fe8:	5b                   	pop    %ebx
80106fe9:	5e                   	pop    %esi
80106fea:	5f                   	pop    %edi
80106feb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106fec:	e9 9f d5 ff ff       	jmp    80104590 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106ff1:	83 ec 0c             	sub    $0xc,%esp
80106ff4:	68 6e 7f 10 80       	push   $0x80107f6e
80106ff9:	e8 72 93 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106ffe:	83 ec 0c             	sub    $0xc,%esp
80107001:	68 99 7f 10 80       	push   $0x80107f99
80107006:	e8 65 93 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
8010700b:	83 ec 0c             	sub    $0xc,%esp
8010700e:	68 84 7f 10 80       	push   $0x80107f84
80107013:	e8 58 93 ff ff       	call   80100370 <panic>
80107018:	90                   	nop
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107020 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	83 ec 1c             	sub    $0x1c,%esp
80107029:	8b 75 10             	mov    0x10(%ebp),%esi
8010702c:	8b 45 08             	mov    0x8(%ebp),%eax
8010702f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107032:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107038:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010703b:	77 49                	ja     80107086 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010703d:	e8 7e b5 ff ff       	call   801025c0 <kalloc>
  memset(mem, 0, PGSIZE);
80107042:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107045:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107047:	68 00 10 00 00       	push   $0x1000
8010704c:	6a 00                	push   $0x0
8010704e:	50                   	push   %eax
8010704f:	e8 dc d6 ff ff       	call   80104730 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107054:	58                   	pop    %eax
80107055:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010705b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107060:	5a                   	pop    %edx
80107061:	6a 06                	push   $0x6
80107063:	50                   	push   %eax
80107064:	31 d2                	xor    %edx,%edx
80107066:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107069:	e8 52 fc ff ff       	call   80106cc0 <mappages>
  memmove(mem, init, sz);
8010706e:	89 75 10             	mov    %esi,0x10(%ebp)
80107071:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107074:	83 c4 10             	add    $0x10,%esp
80107077:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010707a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010707d:	5b                   	pop    %ebx
8010707e:	5e                   	pop    %esi
8010707f:	5f                   	pop    %edi
80107080:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107081:	e9 5a d7 ff ff       	jmp    801047e0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107086:	83 ec 0c             	sub    $0xc,%esp
80107089:	68 ad 7f 10 80       	push   $0x80107fad
8010708e:	e8 dd 92 ff ff       	call   80100370 <panic>
80107093:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070a0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	57                   	push   %edi
801070a4:	56                   	push   %esi
801070a5:	53                   	push   %ebx
801070a6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801070a9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801070b0:	0f 85 91 00 00 00    	jne    80107147 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801070b6:	8b 75 18             	mov    0x18(%ebp),%esi
801070b9:	31 db                	xor    %ebx,%ebx
801070bb:	85 f6                	test   %esi,%esi
801070bd:	75 1a                	jne    801070d9 <loaduvm+0x39>
801070bf:	eb 6f                	jmp    80107130 <loaduvm+0x90>
801070c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070ce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801070d4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801070d7:	76 57                	jbe    80107130 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801070d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801070dc:	8b 45 08             	mov    0x8(%ebp),%eax
801070df:	31 c9                	xor    %ecx,%ecx
801070e1:	01 da                	add    %ebx,%edx
801070e3:	e8 58 fb ff ff       	call   80106c40 <walkpgdir>
801070e8:	85 c0                	test   %eax,%eax
801070ea:	74 4e                	je     8010713a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801070ec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801070ee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801070f1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801070f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801070fb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107101:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107104:	01 d9                	add    %ebx,%ecx
80107106:	05 00 00 00 80       	add    $0x80000000,%eax
8010710b:	57                   	push   %edi
8010710c:	51                   	push   %ecx
8010710d:	50                   	push   %eax
8010710e:	ff 75 10             	pushl  0x10(%ebp)
80107111:	e8 5a a9 ff ff       	call   80101a70 <readi>
80107116:	83 c4 10             	add    $0x10,%esp
80107119:	39 c7                	cmp    %eax,%edi
8010711b:	74 ab                	je     801070c8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
8010711d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80107120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80107125:	5b                   	pop    %ebx
80107126:	5e                   	pop    %esi
80107127:	5f                   	pop    %edi
80107128:	5d                   	pop    %ebp
80107129:	c3                   	ret    
8010712a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107130:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107133:	31 c0                	xor    %eax,%eax
}
80107135:	5b                   	pop    %ebx
80107136:	5e                   	pop    %esi
80107137:	5f                   	pop    %edi
80107138:	5d                   	pop    %ebp
80107139:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
8010713a:	83 ec 0c             	sub    $0xc,%esp
8010713d:	68 c7 7f 10 80       	push   $0x80107fc7
80107142:	e8 29 92 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107147:	83 ec 0c             	sub    $0xc,%esp
8010714a:	68 68 80 10 80       	push   $0x80108068
8010714f:	e8 1c 92 ff ff       	call   80100370 <panic>
80107154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010715a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107160 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 0c             	sub    $0xc,%esp
80107169:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010716c:	85 ff                	test   %edi,%edi
8010716e:	0f 88 ca 00 00 00    	js     8010723e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107174:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107177:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010717a:	0f 82 82 00 00 00    	jb     80107202 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107180:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107186:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010718c:	39 df                	cmp    %ebx,%edi
8010718e:	77 43                	ja     801071d3 <allocuvm+0x73>
80107190:	e9 bb 00 00 00       	jmp    80107250 <allocuvm+0xf0>
80107195:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107198:	83 ec 04             	sub    $0x4,%esp
8010719b:	68 00 10 00 00       	push   $0x1000
801071a0:	6a 00                	push   $0x0
801071a2:	50                   	push   %eax
801071a3:	e8 88 d5 ff ff       	call   80104730 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801071a8:	58                   	pop    %eax
801071a9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801071af:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071b4:	5a                   	pop    %edx
801071b5:	6a 06                	push   $0x6
801071b7:	50                   	push   %eax
801071b8:	89 da                	mov    %ebx,%edx
801071ba:	8b 45 08             	mov    0x8(%ebp),%eax
801071bd:	e8 fe fa ff ff       	call   80106cc0 <mappages>
801071c2:	83 c4 10             	add    $0x10,%esp
801071c5:	85 c0                	test   %eax,%eax
801071c7:	78 47                	js     80107210 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801071c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071cf:	39 df                	cmp    %ebx,%edi
801071d1:	76 7d                	jbe    80107250 <allocuvm+0xf0>
    mem = kalloc();
801071d3:	e8 e8 b3 ff ff       	call   801025c0 <kalloc>
    if(mem == 0){
801071d8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801071da:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801071dc:	75 ba                	jne    80107198 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
801071de:	83 ec 0c             	sub    $0xc,%esp
801071e1:	68 e5 7f 10 80       	push   $0x80107fe5
801071e6:	e8 75 94 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801071eb:	83 c4 10             	add    $0x10,%esp
801071ee:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801071f1:	76 4b                	jbe    8010723e <allocuvm+0xde>
801071f3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801071f6:	8b 45 08             	mov    0x8(%ebp),%eax
801071f9:	89 fa                	mov    %edi,%edx
801071fb:	e8 50 fb ff ff       	call   80106d50 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80107200:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107202:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107205:	5b                   	pop    %ebx
80107206:	5e                   	pop    %esi
80107207:	5f                   	pop    %edi
80107208:	5d                   	pop    %ebp
80107209:	c3                   	ret    
8010720a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80107210:	83 ec 0c             	sub    $0xc,%esp
80107213:	68 fd 7f 10 80       	push   $0x80107ffd
80107218:	e8 43 94 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010721d:	83 c4 10             	add    $0x10,%esp
80107220:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107223:	76 0d                	jbe    80107232 <allocuvm+0xd2>
80107225:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107228:	8b 45 08             	mov    0x8(%ebp),%eax
8010722b:	89 fa                	mov    %edi,%edx
8010722d:	e8 1e fb ff ff       	call   80106d50 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107232:	83 ec 0c             	sub    $0xc,%esp
80107235:	56                   	push   %esi
80107236:	e8 d5 b1 ff ff       	call   80102410 <kfree>
      return 0;
8010723b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
8010723e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107241:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107243:	5b                   	pop    %ebx
80107244:	5e                   	pop    %esi
80107245:	5f                   	pop    %edi
80107246:	5d                   	pop    %ebp
80107247:	c3                   	ret    
80107248:	90                   	nop
80107249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107250:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107253:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107255:	5b                   	pop    %ebx
80107256:	5e                   	pop    %esi
80107257:	5f                   	pop    %edi
80107258:	5d                   	pop    %ebp
80107259:	c3                   	ret    
8010725a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107260 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107260:	55                   	push   %ebp
80107261:	89 e5                	mov    %esp,%ebp
80107263:	8b 55 0c             	mov    0xc(%ebp),%edx
80107266:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107269:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010726c:	39 d1                	cmp    %edx,%ecx
8010726e:	73 10                	jae    80107280 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107270:	5d                   	pop    %ebp
80107271:	e9 da fa ff ff       	jmp    80106d50 <deallocuvm.part.0>
80107276:	8d 76 00             	lea    0x0(%esi),%esi
80107279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107280:	89 d0                	mov    %edx,%eax
80107282:	5d                   	pop    %ebp
80107283:	c3                   	ret    
80107284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010728a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107290 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107290:	55                   	push   %ebp
80107291:	89 e5                	mov    %esp,%ebp
80107293:	57                   	push   %edi
80107294:	56                   	push   %esi
80107295:	53                   	push   %ebx
80107296:	83 ec 0c             	sub    $0xc,%esp
80107299:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010729c:	85 f6                	test   %esi,%esi
8010729e:	74 59                	je     801072f9 <freevm+0x69>
801072a0:	31 c9                	xor    %ecx,%ecx
801072a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801072a7:	89 f0                	mov    %esi,%eax
801072a9:	e8 a2 fa ff ff       	call   80106d50 <deallocuvm.part.0>
801072ae:	89 f3                	mov    %esi,%ebx
801072b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801072b6:	eb 0f                	jmp    801072c7 <freevm+0x37>
801072b8:	90                   	nop
801072b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072c0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801072c3:	39 fb                	cmp    %edi,%ebx
801072c5:	74 23                	je     801072ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801072c7:	8b 03                	mov    (%ebx),%eax
801072c9:	a8 01                	test   $0x1,%al
801072cb:	74 f3                	je     801072c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801072cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072d2:	83 ec 0c             	sub    $0xc,%esp
801072d5:	83 c3 04             	add    $0x4,%ebx
801072d8:	05 00 00 00 80       	add    $0x80000000,%eax
801072dd:	50                   	push   %eax
801072de:	e8 2d b1 ff ff       	call   80102410 <kfree>
801072e3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801072e6:	39 fb                	cmp    %edi,%ebx
801072e8:	75 dd                	jne    801072c7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801072ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801072ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072f0:	5b                   	pop    %ebx
801072f1:	5e                   	pop    %esi
801072f2:	5f                   	pop    %edi
801072f3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801072f4:	e9 17 b1 ff ff       	jmp    80102410 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801072f9:	83 ec 0c             	sub    $0xc,%esp
801072fc:	68 19 80 10 80       	push   $0x80108019
80107301:	e8 6a 90 ff ff       	call   80100370 <panic>
80107306:	8d 76 00             	lea    0x0(%esi),%esi
80107309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107310 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	56                   	push   %esi
80107314:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107315:	e8 a6 b2 ff ff       	call   801025c0 <kalloc>
8010731a:	85 c0                	test   %eax,%eax
8010731c:	74 6a                	je     80107388 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
8010731e:	83 ec 04             	sub    $0x4,%esp
80107321:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107323:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80107328:	68 00 10 00 00       	push   $0x1000
8010732d:	6a 00                	push   $0x0
8010732f:	50                   	push   %eax
80107330:	e8 fb d3 ff ff       	call   80104730 <memset>
80107335:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107338:	8b 43 04             	mov    0x4(%ebx),%eax
8010733b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010733e:	83 ec 08             	sub    $0x8,%esp
80107341:	8b 13                	mov    (%ebx),%edx
80107343:	ff 73 0c             	pushl  0xc(%ebx)
80107346:	50                   	push   %eax
80107347:	29 c1                	sub    %eax,%ecx
80107349:	89 f0                	mov    %esi,%eax
8010734b:	e8 70 f9 ff ff       	call   80106cc0 <mappages>
80107350:	83 c4 10             	add    $0x10,%esp
80107353:	85 c0                	test   %eax,%eax
80107355:	78 19                	js     80107370 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107357:	83 c3 10             	add    $0x10,%ebx
8010735a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107360:	75 d6                	jne    80107338 <setupkvm+0x28>
80107362:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107364:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107367:	5b                   	pop    %ebx
80107368:	5e                   	pop    %esi
80107369:	5d                   	pop    %ebp
8010736a:	c3                   	ret    
8010736b:	90                   	nop
8010736c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107370:	83 ec 0c             	sub    $0xc,%esp
80107373:	56                   	push   %esi
80107374:	e8 17 ff ff ff       	call   80107290 <freevm>
      return 0;
80107379:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
8010737c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
8010737f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107381:	5b                   	pop    %ebx
80107382:	5e                   	pop    %esi
80107383:	5d                   	pop    %ebp
80107384:	c3                   	ret    
80107385:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107388:	31 c0                	xor    %eax,%eax
8010738a:	eb d8                	jmp    80107364 <setupkvm+0x54>
8010738c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107390 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107396:	e8 75 ff ff ff       	call   80107310 <setupkvm>
8010739b:	a3 a4 f9 11 80       	mov    %eax,0x8011f9a4
801073a0:	05 00 00 00 80       	add    $0x80000000,%eax
801073a5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
801073a8:	c9                   	leave  
801073a9:	c3                   	ret    
801073aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801073b0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801073b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801073b1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801073b3:	89 e5                	mov    %esp,%ebp
801073b5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801073b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801073bb:	8b 45 08             	mov    0x8(%ebp),%eax
801073be:	e8 7d f8 ff ff       	call   80106c40 <walkpgdir>
  if(pte == 0)
801073c3:	85 c0                	test   %eax,%eax
801073c5:	74 05                	je     801073cc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801073c7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801073ca:	c9                   	leave  
801073cb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801073cc:	83 ec 0c             	sub    $0xc,%esp
801073cf:	68 2a 80 10 80       	push   $0x8010802a
801073d4:	e8 97 8f ff ff       	call   80100370 <panic>
801073d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073e0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801073e0:	55                   	push   %ebp
801073e1:	89 e5                	mov    %esp,%ebp
801073e3:	57                   	push   %edi
801073e4:	56                   	push   %esi
801073e5:	53                   	push   %ebx
801073e6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801073e9:	e8 22 ff ff ff       	call   80107310 <setupkvm>
801073ee:	85 c0                	test   %eax,%eax
801073f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801073f3:	0f 84 c5 00 00 00    	je     801074be <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801073f9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801073fc:	85 c9                	test   %ecx,%ecx
801073fe:	0f 84 9c 00 00 00    	je     801074a0 <copyuvm+0xc0>
80107404:	31 ff                	xor    %edi,%edi
80107406:	eb 4a                	jmp    80107452 <copyuvm+0x72>
80107408:	90                   	nop
80107409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107410:	83 ec 04             	sub    $0x4,%esp
80107413:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107419:	68 00 10 00 00       	push   $0x1000
8010741e:	53                   	push   %ebx
8010741f:	50                   	push   %eax
80107420:	e8 bb d3 ff ff       	call   801047e0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107425:	58                   	pop    %eax
80107426:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010742c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107431:	5a                   	pop    %edx
80107432:	ff 75 e4             	pushl  -0x1c(%ebp)
80107435:	50                   	push   %eax
80107436:	89 fa                	mov    %edi,%edx
80107438:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010743b:	e8 80 f8 ff ff       	call   80106cc0 <mappages>
80107440:	83 c4 10             	add    $0x10,%esp
80107443:	85 c0                	test   %eax,%eax
80107445:	78 69                	js     801074b0 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107447:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010744d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107450:	76 4e                	jbe    801074a0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107452:	8b 45 08             	mov    0x8(%ebp),%eax
80107455:	31 c9                	xor    %ecx,%ecx
80107457:	89 fa                	mov    %edi,%edx
80107459:	e8 e2 f7 ff ff       	call   80106c40 <walkpgdir>
8010745e:	85 c0                	test   %eax,%eax
80107460:	74 6d                	je     801074cf <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107462:	8b 00                	mov    (%eax),%eax
80107464:	a8 01                	test   $0x1,%al
80107466:	74 5a                	je     801074c2 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107468:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010746a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010746f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
80107475:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107478:	e8 43 b1 ff ff       	call   801025c0 <kalloc>
8010747d:	85 c0                	test   %eax,%eax
8010747f:	89 c6                	mov    %eax,%esi
80107481:	75 8d                	jne    80107410 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107483:	83 ec 0c             	sub    $0xc,%esp
80107486:	ff 75 e0             	pushl  -0x20(%ebp)
80107489:	e8 02 fe ff ff       	call   80107290 <freevm>
  return 0;
8010748e:	83 c4 10             	add    $0x10,%esp
80107491:	31 c0                	xor    %eax,%eax
}
80107493:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107496:	5b                   	pop    %ebx
80107497:	5e                   	pop    %esi
80107498:	5f                   	pop    %edi
80107499:	5d                   	pop    %ebp
8010749a:	c3                   	ret    
8010749b:	90                   	nop
8010749c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801074a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801074a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074a6:	5b                   	pop    %ebx
801074a7:	5e                   	pop    %esi
801074a8:	5f                   	pop    %edi
801074a9:	5d                   	pop    %ebp
801074aa:	c3                   	ret    
801074ab:	90                   	nop
801074ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
801074b0:	83 ec 0c             	sub    $0xc,%esp
801074b3:	56                   	push   %esi
801074b4:	e8 57 af ff ff       	call   80102410 <kfree>
      goto bad;
801074b9:	83 c4 10             	add    $0x10,%esp
801074bc:	eb c5                	jmp    80107483 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801074be:	31 c0                	xor    %eax,%eax
801074c0:	eb d1                	jmp    80107493 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801074c2:	83 ec 0c             	sub    $0xc,%esp
801074c5:	68 4e 80 10 80       	push   $0x8010804e
801074ca:	e8 a1 8e ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801074cf:	83 ec 0c             	sub    $0xc,%esp
801074d2:	68 34 80 10 80       	push   $0x80108034
801074d7:	e8 94 8e ff ff       	call   80100370 <panic>
801074dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801074e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801074e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801074e1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801074e3:	89 e5                	mov    %esp,%ebp
801074e5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801074e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801074eb:	8b 45 08             	mov    0x8(%ebp),%eax
801074ee:	e8 4d f7 ff ff       	call   80106c40 <walkpgdir>
  if((*pte & PTE_P) == 0)
801074f3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
801074f5:	89 c2                	mov    %eax,%edx
801074f7:	83 e2 05             	and    $0x5,%edx
801074fa:	83 fa 05             	cmp    $0x5,%edx
801074fd:	75 11                	jne    80107510 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801074ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107504:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107505:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010750a:	c3                   	ret    
8010750b:	90                   	nop
8010750c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107510:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107512:	c9                   	leave  
80107513:	c3                   	ret    
80107514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010751a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107520 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107520:	55                   	push   %ebp
80107521:	89 e5                	mov    %esp,%ebp
80107523:	57                   	push   %edi
80107524:	56                   	push   %esi
80107525:	53                   	push   %ebx
80107526:	83 ec 1c             	sub    $0x1c,%esp
80107529:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010752c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010752f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107532:	85 db                	test   %ebx,%ebx
80107534:	75 40                	jne    80107576 <copyout+0x56>
80107536:	eb 70                	jmp    801075a8 <copyout+0x88>
80107538:	90                   	nop
80107539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107540:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107543:	89 f1                	mov    %esi,%ecx
80107545:	29 d1                	sub    %edx,%ecx
80107547:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010754d:	39 d9                	cmp    %ebx,%ecx
8010754f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107552:	29 f2                	sub    %esi,%edx
80107554:	83 ec 04             	sub    $0x4,%esp
80107557:	01 d0                	add    %edx,%eax
80107559:	51                   	push   %ecx
8010755a:	57                   	push   %edi
8010755b:	50                   	push   %eax
8010755c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010755f:	e8 7c d2 ff ff       	call   801047e0 <memmove>
    len -= n;
    buf += n;
80107564:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107567:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010756a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107570:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107572:	29 cb                	sub    %ecx,%ebx
80107574:	74 32                	je     801075a8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107576:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107578:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010757b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010757e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107584:	56                   	push   %esi
80107585:	ff 75 08             	pushl  0x8(%ebp)
80107588:	e8 53 ff ff ff       	call   801074e0 <uva2ka>
    if(pa0 == 0)
8010758d:	83 c4 10             	add    $0x10,%esp
80107590:	85 c0                	test   %eax,%eax
80107592:	75 ac                	jne    80107540 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107594:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107597:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010759c:	5b                   	pop    %ebx
8010759d:	5e                   	pop    %esi
8010759e:	5f                   	pop    %edi
8010759f:	5d                   	pop    %ebp
801075a0:	c3                   	ret    
801075a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801075ab:	31 c0                	xor    %eax,%eax
}
801075ad:	5b                   	pop    %ebx
801075ae:	5e                   	pop    %esi
801075af:	5f                   	pop    %edi
801075b0:	5d                   	pop    %ebp
801075b1:	c3                   	ret    
801075b2:	66 90                	xchg   %ax,%ax
801075b4:	66 90                	xchg   %ax,%ax
801075b6:	66 90                	xchg   %ax,%ax
801075b8:	66 90                	xchg   %ax,%ax
801075ba:	66 90                	xchg   %ax,%ax
801075bc:	66 90                	xchg   %ax,%ax
801075be:	66 90                	xchg   %ax,%ax

801075c0 <initUser>:
//add user concept
//static char currentUser[128];

void
initUser()
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
	
	/*char buf[1024];
	int fd = open("Filechanged",O_RDONLY);
	read(fd, buf, sizeof(buf));
	printf(1,"Filechanged: %s\n", buf);*/
}
801075c3:	5d                   	pop    %ebp
801075c4:	c3                   	ret    
