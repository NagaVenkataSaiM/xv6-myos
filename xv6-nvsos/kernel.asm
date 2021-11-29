
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 f0 2d 10 80       	mov    $0x80102df0,%eax
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
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
{
80100049:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 c0 6c 10 	movl   $0x80106cc0,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 d0 40 00 00       	call   80104130 <initlock>
  bcache.head.next = &bcache.head;
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
  bcache.head.prev = &bcache.head;
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 c7 6c 10 	movl   $0x80106cc7,0x4(%esp)
8010009b:	80 
8010009c:	e8 5f 3f 00 00       	call   80104000 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
    bcache.head.next = b;
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
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
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&bcache.lock);
801000dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
{
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 b5 41 00 00       	call   801042a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
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
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
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
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 aa 41 00 00       	call   80104310 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 cf 3e 00 00       	call   80104040 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 a2 1f 00 00       	call   80102120 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 ce 6c 10 80 	movl   $0x80106cce,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 2b 3f 00 00       	call   801040e0 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 df 6c 10 80 	movl   $0x80106cdf,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
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
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 ea 3e 00 00       	call   801040e0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 9e 3e 00 00       	call   801040a0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 92 40 00 00       	call   801042a0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100226:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100250:	e9 bb 40 00 00       	jmp    80104310 <release>
    panic("brelse");
80100255:	c7 04 24 e6 6c 10 80 	movl   $0x80106ce6,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

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
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 09 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 0d 40 00 00       	call   801042a0 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 f3 33 00 00       	call   801036a0 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 38 39 00 00       	call   80103c00 <sleep>
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 fa 3f 00 00       	call   80104310 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 92 13 00 00       	call   801016b0 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&cons.lock);
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 dc 3f 00 00       	call   80104310 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 74 13 00 00       	call   801016b0 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        input.r--;
8010034e:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  cons.locking = 0;
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100370:	00 00 00 
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 e5 23 00 00       	call   80102760 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 ed 6c 10 80 	movl   $0x80106ced,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 c2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 b7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 e2 72 10 80 	movl   $0x801072e2,(%esp)
801003a0:	e8 ab 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 9c 3d 00 00       	call   80104150 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 01 6d 10 80 	movl   $0x80106d01,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 83 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
801003f6:	89 c3                	mov    %eax,%ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 ac 00 00 00    	je     801004b2 <consputc+0xd2>
    uartputc(c);
80100406:	89 04 24             	mov    %eax,(%esp)
80100409:	e8 12 54 00 00       	call   80105820 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010040e:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	be d5 03 00 00       	mov    $0x3d5,%esi
80100420:	89 f2                	mov    %esi,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	c1 e1 08             	shl    $0x8,%ecx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c1                	or     %eax,%ecx
  if(c == '\n')
80100439:	83 fb 0a             	cmp    $0xa,%ebx
8010043c:	0f 84 0d 01 00 00    	je     8010054f <consputc+0x16f>
  else if(c == BACKSPACE){
80100442:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100448:	0f 84 e8 00 00 00    	je     80100536 <consputc+0x156>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010044e:	0f b6 db             	movzbl %bl,%ebx
80100451:	80 cf 07             	or     $0x7,%bh
80100454:	8d 79 01             	lea    0x1(%ecx),%edi
80100457:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
8010045e:	80 
  if(pos < 0 || pos > 25*80)
8010045f:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100465:	0f 87 bf 00 00 00    	ja     8010052a <consputc+0x14a>
  if((pos/80) >= 24){  // Scroll up.
8010046b:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100471:	7f 68                	jg     801004db <consputc+0xfb>
80100473:	89 f8                	mov    %edi,%eax
80100475:	89 fb                	mov    %edi,%ebx
80100477:	c1 e8 08             	shr    $0x8,%eax
8010047a:	89 c6                	mov    %eax,%esi
8010047c:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 fa                	mov    %edi,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	89 f0                	mov    %esi,%eax
80100492:	b2 d5                	mov    $0xd5,%dl
80100494:	ee                   	out    %al,(%dx)
80100495:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049a:	89 fa                	mov    %edi,%edx
8010049c:	ee                   	out    %al,(%dx)
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	b2 d5                	mov    $0xd5,%dl
801004a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a2:	b8 20 07 00 00       	mov    $0x720,%eax
801004a7:	66 89 01             	mov    %ax,(%ecx)
}
801004aa:	83 c4 1c             	add    $0x1c,%esp
801004ad:	5b                   	pop    %ebx
801004ae:	5e                   	pop    %esi
801004af:	5f                   	pop    %edi
801004b0:	5d                   	pop    %ebp
801004b1:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b9:	e8 62 53 00 00       	call   80105820 <uartputc>
801004be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c5:	e8 56 53 00 00       	call   80105820 <uartputc>
801004ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d1:	e8 4a 53 00 00       	call   80105820 <uartputc>
801004d6:	e9 33 ff ff ff       	jmp    8010040e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004db:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004e2:	00 
    pos -= 80;
801004e3:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004ed:	80 
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ee:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f5:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004fc:	e8 ff 3e 00 00       	call   80104400 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100501:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100506:	29 f8                	sub    %edi,%eax
80100508:	01 c0                	add    %eax,%eax
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100511:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100518:	00 
80100519:	e8 42 3e 00 00       	call   80104360 <memset>
8010051e:	89 f1                	mov    %esi,%ecx
80100520:	be 07 00 00 00       	mov    $0x7,%esi
80100525:	e9 59 ff ff ff       	jmp    80100483 <consputc+0xa3>
    panic("pos under/overflow");
8010052a:	c7 04 24 05 6d 10 80 	movl   $0x80106d05,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>
    if(pos > 0) --pos;
80100536:	85 c9                	test   %ecx,%ecx
80100538:	8d 79 ff             	lea    -0x1(%ecx),%edi
8010053b:	0f 85 1e ff ff ff    	jne    8010045f <consputc+0x7f>
80100541:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100546:	31 db                	xor    %ebx,%ebx
80100548:	31 f6                	xor    %esi,%esi
8010054a:	e9 34 ff ff ff       	jmp    80100483 <consputc+0xa3>
    pos += 80 - pos%80;
8010054f:	89 c8                	mov    %ecx,%eax
80100551:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100556:	f7 ea                	imul   %edx
80100558:	c1 ea 05             	shr    $0x5,%edx
8010055b:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055e:	c1 e0 04             	shl    $0x4,%eax
80100561:	8d 78 50             	lea    0x50(%eax),%edi
80100564:	e9 f6 fe ff ff       	jmp    8010045f <consputc+0x7f>
80100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	89 d6                	mov    %edx,%esi
80100577:	53                   	push   %ebx
80100578:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
8010057d:	74 61                	je     801005e0 <printint+0x70>
8010057f:	85 c0                	test   %eax,%eax
80100581:	79 5d                	jns    801005e0 <printint+0x70>
    x = -xx;
80100583:	f7 d8                	neg    %eax
80100585:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010058a:	31 c9                	xor    %ecx,%ecx
8010058c:	eb 04                	jmp    80100592 <printint+0x22>
8010058e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100590:	89 d9                	mov    %ebx,%ecx
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 f6                	div    %esi
80100596:	8d 59 01             	lea    0x1(%ecx),%ebx
80100599:	0f b6 92 30 6d 10 80 	movzbl -0x7fef92d0(%edx),%edx
  }while((x /= base) != 0);
801005a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005a2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005a6:	75 e8                	jne    80100590 <printint+0x20>
  if(sign)
801005a8:	85 ff                	test   %edi,%edi
    buf[i++] = digits[x % base];
801005aa:	89 d8                	mov    %ebx,%eax
  if(sign)
801005ac:	74 08                	je     801005b6 <printint+0x46>
    buf[i++] = '-';
801005ae:	8d 59 02             	lea    0x2(%ecx),%ebx
801005b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
  while(--i >= 0)
801005b6:	83 eb 01             	sub    $0x1,%ebx
801005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801005c0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005c5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005c8:	e8 13 fe ff ff       	call   801003e0 <consputc>
  while(--i >= 0)
801005cd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005d0:	75 ee                	jne    801005c0 <printint+0x50>
}
801005d2:	83 c4 1c             	add    $0x1c,%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    x = xx;
801005e0:	31 ff                	xor    %edi,%edi
801005e2:	eb a6                	jmp    8010058a <printint+0x1a>
801005e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 89 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010060e:	e8 8d 3c 00 00       	call   801042a0 <acquire>
80100613:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100616:	85 f6                	test   %esi,%esi
80100618:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061b:	7e 12                	jle    8010062f <consolewrite+0x3f>
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	83 c7 01             	add    $0x1,%edi
80100626:	e8 b5 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; i < n; i++)
8010062b:	39 df                	cmp    %ebx,%edi
8010062d:	75 f1                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100636:	e8 d5 3c 00 00       	call   80104310 <release>
  ilock(ip);
8010063b:	8b 45 08             	mov    0x8(%ebp),%eax
8010063e:	89 04 24             	mov    %eax,(%esp)
80100641:	e8 6a 10 00 00       	call   801016b0 <ilock>

  return n;
}
80100646:	83 c4 1c             	add    $0x1c,%esp
80100649:	89 f0                	mov    %esi,%eax
8010064b:	5b                   	pop    %ebx
8010064c:	5e                   	pop    %esi
8010064d:	5f                   	pop    %edi
8010064e:	5d                   	pop    %ebp
8010064f:	c3                   	ret    

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100659:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100663:	0f 85 27 01 00 00    	jne    80100790 <cprintf+0x140>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 c1                	mov    %eax,%ecx
80100670:	0f 84 2b 01 00 00    	je     801007a1 <cprintf+0x151>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100676:	0f b6 00             	movzbl (%eax),%eax
80100679:	31 db                	xor    %ebx,%ebx
8010067b:	89 cf                	mov    %ecx,%edi
8010067d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100680:	85 c0                	test   %eax,%eax
80100682:	75 4c                	jne    801006d0 <cprintf+0x80>
80100684:	eb 5f                	jmp    801006e5 <cprintf+0x95>
80100686:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
80100688:	83 c3 01             	add    $0x1,%ebx
8010068b:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
8010068f:	85 d2                	test   %edx,%edx
80100691:	74 52                	je     801006e5 <cprintf+0x95>
    switch(c){
80100693:	83 fa 70             	cmp    $0x70,%edx
80100696:	74 72                	je     8010070a <cprintf+0xba>
80100698:	7f 66                	jg     80100700 <cprintf+0xb0>
8010069a:	83 fa 25             	cmp    $0x25,%edx
8010069d:	8d 76 00             	lea    0x0(%esi),%esi
801006a0:	0f 84 a2 00 00 00    	je     80100748 <cprintf+0xf8>
801006a6:	83 fa 64             	cmp    $0x64,%edx
801006a9:	75 7d                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 10, 1);
801006ab:	8d 46 04             	lea    0x4(%esi),%eax
801006ae:	b9 01 00 00 00       	mov    $0x1,%ecx
801006b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b6:	8b 06                	mov    (%esi),%eax
801006b8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006bd:	e8 ae fe ff ff       	call   80100570 <printint>
801006c2:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c5:	83 c3 01             	add    $0x1,%ebx
801006c8:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 15                	je     801006e5 <cprintf+0x95>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	74 b3                	je     80100688 <cprintf+0x38>
      consputc(c);
801006d5:	e8 06 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006da:	83 c3 01             	add    $0x1,%ebx
801006dd:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	75 eb                	jne    801006d0 <cprintf+0x80>
  if(locking)
801006e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006e8:	85 c0                	test   %eax,%eax
801006ea:	74 0c                	je     801006f8 <cprintf+0xa8>
    release(&cons.lock);
801006ec:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006f3:	e8 18 3c 00 00       	call   80104310 <release>
}
801006f8:	83 c4 1c             	add    $0x1c,%esp
801006fb:	5b                   	pop    %ebx
801006fc:	5e                   	pop    %esi
801006fd:	5f                   	pop    %edi
801006fe:	5d                   	pop    %ebp
801006ff:	c3                   	ret    
    switch(c){
80100700:	83 fa 73             	cmp    $0x73,%edx
80100703:	74 53                	je     80100758 <cprintf+0x108>
80100705:	83 fa 78             	cmp    $0x78,%edx
80100708:	75 1e                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 16, 0);
8010070a:	8d 46 04             	lea    0x4(%esi),%eax
8010070d:	31 c9                	xor    %ecx,%ecx
8010070f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100712:	8b 06                	mov    (%esi),%eax
80100714:	ba 10 00 00 00       	mov    $0x10,%edx
80100719:	e8 52 fe ff ff       	call   80100570 <printint>
8010071e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100721:	eb a2                	jmp    801006c5 <cprintf+0x75>
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100728:	b8 25 00 00 00       	mov    $0x25,%eax
8010072d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100730:	e8 ab fc ff ff       	call   801003e0 <consputc>
      consputc(c);
80100735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100738:	89 d0                	mov    %edx,%eax
8010073a:	e8 a1 fc ff ff       	call   801003e0 <consputc>
8010073f:	eb 99                	jmp    801006da <cprintf+0x8a>
80100741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	e8 8e fc ff ff       	call   801003e0 <consputc>
      break;
80100752:	e9 6e ff ff ff       	jmp    801006c5 <cprintf+0x75>
80100757:	90                   	nop
      if((s = (char*)*argp++) == 0)
80100758:	8d 46 04             	lea    0x4(%esi),%eax
8010075b:	8b 36                	mov    (%esi),%esi
8010075d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100760:	b8 18 6d 10 80       	mov    $0x80106d18,%eax
80100765:	85 f6                	test   %esi,%esi
80100767:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
8010076a:	0f be 06             	movsbl (%esi),%eax
8010076d:	84 c0                	test   %al,%al
8010076f:	74 16                	je     80100787 <cprintf+0x137>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100778:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
8010077b:	e8 60 fc ff ff       	call   801003e0 <consputc>
      for(; *s; s++)
80100780:	0f be 06             	movsbl (%esi),%eax
80100783:	84 c0                	test   %al,%al
80100785:	75 f1                	jne    80100778 <cprintf+0x128>
      if((s = (char*)*argp++) == 0)
80100787:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010078a:	e9 36 ff ff ff       	jmp    801006c5 <cprintf+0x75>
8010078f:	90                   	nop
    acquire(&cons.lock);
80100790:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100797:	e8 04 3b 00 00       	call   801042a0 <acquire>
8010079c:	e9 c8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007a1:	c7 04 24 1f 6d 10 80 	movl   $0x80106d1f,(%esp)
801007a8:	e8 b3 fb ff ff       	call   80100360 <panic>
801007ad:	8d 76 00             	lea    0x0(%esi),%esi

801007b0 <consoleintr>:
{
801007b0:	55                   	push   %ebp
801007b1:	89 e5                	mov    %esp,%ebp
801007b3:	57                   	push   %edi
801007b4:	56                   	push   %esi
  int c, doprocdump = 0;
801007b5:	31 f6                	xor    %esi,%esi
{
801007b7:	53                   	push   %ebx
801007b8:	83 ec 1c             	sub    $0x1c,%esp
801007bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007be:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007c5:	e8 d6 3a 00 00       	call   801042a0 <acquire>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007d0:	ff d3                	call   *%ebx
801007d2:	85 c0                	test   %eax,%eax
801007d4:	89 c7                	mov    %eax,%edi
801007d6:	78 48                	js     80100820 <consoleintr+0x70>
    switch(c){
801007d8:	83 ff 10             	cmp    $0x10,%edi
801007db:	0f 84 2f 01 00 00    	je     80100910 <consoleintr+0x160>
801007e1:	7e 5d                	jle    80100840 <consoleintr+0x90>
801007e3:	83 ff 15             	cmp    $0x15,%edi
801007e6:	0f 84 d4 00 00 00    	je     801008c0 <consoleintr+0x110>
801007ec:	83 ff 7f             	cmp    $0x7f,%edi
801007ef:	90                   	nop
801007f0:	75 53                	jne    80100845 <consoleintr+0x95>
      if(input.e != input.w){
801007f2:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801007f7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801007fd:	74 d1                	je     801007d0 <consoleintr+0x20>
        input.e--;
801007ff:	83 e8 01             	sub    $0x1,%eax
80100802:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100807:	b8 00 01 00 00       	mov    $0x100,%eax
8010080c:	e8 cf fb ff ff       	call   801003e0 <consputc>
  while((c = getc()) >= 0){
80100811:	ff d3                	call   *%ebx
80100813:	85 c0                	test   %eax,%eax
80100815:	89 c7                	mov    %eax,%edi
80100817:	79 bf                	jns    801007d8 <consoleintr+0x28>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100820:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100827:	e8 e4 3a 00 00       	call   80104310 <release>
  if(doprocdump) {
8010082c:	85 f6                	test   %esi,%esi
8010082e:	0f 85 ec 00 00 00    	jne    80100920 <consoleintr+0x170>
}
80100834:	83 c4 1c             	add    $0x1c,%esp
80100837:	5b                   	pop    %ebx
80100838:	5e                   	pop    %esi
80100839:	5f                   	pop    %edi
8010083a:	5d                   	pop    %ebp
8010083b:	c3                   	ret    
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100840:	83 ff 08             	cmp    $0x8,%edi
80100843:	74 ad                	je     801007f2 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100845:	85 ff                	test   %edi,%edi
80100847:	74 87                	je     801007d0 <consoleintr+0x20>
80100849:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010084e:	89 c2                	mov    %eax,%edx
80100850:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100856:	83 fa 7f             	cmp    $0x7f,%edx
80100859:	0f 87 71 ff ff ff    	ja     801007d0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010085f:	8d 50 01             	lea    0x1(%eax),%edx
80100862:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100865:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100868:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010086e:	0f 84 b8 00 00 00    	je     8010092c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100874:	89 f9                	mov    %edi,%ecx
80100876:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010087c:	89 f8                	mov    %edi,%eax
8010087e:	e8 5d fb ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100883:	83 ff 04             	cmp    $0x4,%edi
80100886:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088b:	74 19                	je     801008a6 <consoleintr+0xf6>
8010088d:	83 ff 0a             	cmp    $0xa,%edi
80100890:	74 14                	je     801008a6 <consoleintr+0xf6>
80100892:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
80100898:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
8010089e:	39 d0                	cmp    %edx,%eax
801008a0:	0f 85 2a ff ff ff    	jne    801007d0 <consoleintr+0x20>
          wakeup(&input.r);
801008a6:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
          input.w = input.e;
801008ad:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008b2:	e8 d9 34 00 00       	call   80103d90 <wakeup>
801008b7:	e9 14 ff ff ff       	jmp    801007d0 <consoleintr+0x20>
801008bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008c0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008c5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008cb:	75 2b                	jne    801008f8 <consoleintr+0x148>
801008cd:	e9 fe fe ff ff       	jmp    801007d0 <consoleintr+0x20>
801008d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
801008d8:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008dd:	b8 00 01 00 00       	mov    $0x100,%eax
801008e2:	e8 f9 fa ff ff       	call   801003e0 <consputc>
      while(input.e != input.w &&
801008e7:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ec:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008f2:	0f 84 d8 fe ff ff    	je     801007d0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f8:	83 e8 01             	sub    $0x1,%eax
801008fb:	89 c2                	mov    %eax,%edx
801008fd:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100900:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100907:	75 cf                	jne    801008d8 <consoleintr+0x128>
80100909:	e9 c2 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010090e:	66 90                	xchg   %ax,%ax
      doprocdump = 1;
80100910:	be 01 00 00 00       	mov    $0x1,%esi
80100915:	e9 b6 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100920:	83 c4 1c             	add    $0x1c,%esp
80100923:	5b                   	pop    %ebx
80100924:	5e                   	pop    %esi
80100925:	5f                   	pop    %edi
80100926:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100927:	e9 44 35 00 00       	jmp    80103e70 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010092c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100933:	b8 0a 00 00 00       	mov    $0xa,%eax
80100938:	e8 a3 fa ff ff       	call   801003e0 <consputc>
8010093d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100942:	e9 5f ff ff ff       	jmp    801008a6 <consoleintr+0xf6>
80100947:	89 f6                	mov    %esi,%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100950 <consoleinit>:

void
consoleinit(void)
{
80100950:	55                   	push   %ebp
80100951:	89 e5                	mov    %esp,%ebp
80100953:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100956:	c7 44 24 04 28 6d 10 	movl   $0x80106d28,0x4(%esp)
8010095d:	80 
8010095e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100965:	e8 c6 37 00 00       	call   80104130 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010096a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100971:	00 
80100972:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100979:	c7 05 6c 09 11 80 f0 	movl   $0x801005f0,0x8011096c
80100980:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100983:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
8010098a:	02 10 80 
  cons.locking = 1;
8010098d:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100994:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100997:	e8 14 19 00 00       	call   801022b0 <ioapicenable>
}
8010099c:	c9                   	leave  
8010099d:	c3                   	ret    
8010099e:	66 90                	xchg   %ax,%ax

801009a0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	57                   	push   %edi
801009a4:	56                   	push   %esi
801009a5:	53                   	push   %ebx
801009a6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009ac:	e8 ef 2c 00 00       	call   801036a0 <myproc>
801009b1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009b7:	e8 54 21 00 00       	call   80102b10 <begin_op>

  if((ip = namei(path)) == 0){
801009bc:	8b 45 08             	mov    0x8(%ebp),%eax
801009bf:	89 04 24             	mov    %eax,(%esp)
801009c2:	e8 39 15 00 00       	call   80101f00 <namei>
801009c7:	85 c0                	test   %eax,%eax
801009c9:	89 c3                	mov    %eax,%ebx
801009cb:	0f 84 c2 01 00 00    	je     80100b93 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009d1:	89 04 24             	mov    %eax,(%esp)
801009d4:	e8 d7 0c 00 00       	call   801016b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009d9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009df:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
801009e6:	00 
801009e7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801009ee:	00 
801009ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801009f3:	89 1c 24             	mov    %ebx,(%esp)
801009f6:	e8 65 0f 00 00       	call   80101960 <readi>
801009fb:	83 f8 34             	cmp    $0x34,%eax
801009fe:	74 20                	je     80100a20 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a00:	89 1c 24             	mov    %ebx,(%esp)
80100a03:	e8 08 0f 00 00       	call   80101910 <iunlockput>
    end_op();
80100a08:	e8 73 21 00 00       	call   80102b80 <end_op>
  }
  return -1;
80100a0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a12:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a18:	5b                   	pop    %ebx
80100a19:	5e                   	pop    %esi
80100a1a:	5f                   	pop    %edi
80100a1b:	5d                   	pop    %ebp
80100a1c:	c3                   	ret    
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100a20:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a27:	45 4c 46 
80100a2a:	75 d4                	jne    80100a00 <exec+0x60>
  if((pgdir = setupkvm()) == 0)
80100a2c:	e8 df 5f 00 00       	call   80106a10 <setupkvm>
80100a31:	85 c0                	test   %eax,%eax
80100a33:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a39:	74 c5                	je     80100a00 <exec+0x60>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a3b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a42:	00 
80100a43:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = 0;
80100a49:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a50:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a53:	0f 84 da 00 00 00    	je     80100b33 <exec+0x193>
80100a59:	31 ff                	xor    %edi,%edi
80100a5b:	eb 18                	jmp    80100a75 <exec+0xd5>
80100a5d:	8d 76 00             	lea    0x0(%esi),%esi
80100a60:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a67:	83 c7 01             	add    $0x1,%edi
80100a6a:	83 c6 20             	add    $0x20,%esi
80100a6d:	39 f8                	cmp    %edi,%eax
80100a6f:	0f 8e be 00 00 00    	jle    80100b33 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a75:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a7b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a82:	00 
80100a83:	89 74 24 08          	mov    %esi,0x8(%esp)
80100a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a8b:	89 1c 24             	mov    %ebx,(%esp)
80100a8e:	e8 cd 0e 00 00       	call   80101960 <readi>
80100a93:	83 f8 20             	cmp    $0x20,%eax
80100a96:	0f 85 84 00 00 00    	jne    80100b20 <exec+0x180>
    if(ph.type != ELF_PROG_LOAD)
80100a9c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aa3:	75 bb                	jne    80100a60 <exec+0xc0>
    if(ph.memsz < ph.filesz)
80100aa5:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aab:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ab1:	72 6d                	jb     80100b20 <exec+0x180>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab9:	72 65                	jb     80100b20 <exec+0x180>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100abb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abf:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ac9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100acf:	89 04 24             	mov    %eax,(%esp)
80100ad2:	e8 a9 5d 00 00       	call   80106880 <allocuvm>
80100ad7:	85 c0                	test   %eax,%eax
80100ad9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100adf:	74 3f                	je     80100b20 <exec+0x180>
    if(ph.vaddr % PGSIZE != 0)
80100ae1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ae7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aec:	75 32                	jne    80100b20 <exec+0x180>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aee:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100afe:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b02:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b06:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b0c:	89 04 24             	mov    %eax,(%esp)
80100b0f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b13:	e8 a8 5c 00 00       	call   801067c0 <loaduvm>
80100b18:	85 c0                	test   %eax,%eax
80100b1a:	0f 89 40 ff ff ff    	jns    80100a60 <exec+0xc0>
    freevm(pgdir);
80100b20:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 62 5e 00 00       	call   80106990 <freevm>
80100b2e:	e9 cd fe ff ff       	jmp    80100a00 <exec+0x60>
  iunlockput(ip);
80100b33:	89 1c 24             	mov    %ebx,(%esp)
80100b36:	e8 d5 0d 00 00       	call   80101910 <iunlockput>
80100b3b:	90                   	nop
80100b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b40:	e8 3b 20 00 00       	call   80102b80 <end_op>
  sz = PGROUNDUP(sz);
80100b45:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b4b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b55:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b5f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b65:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b69:	89 04 24             	mov    %eax,(%esp)
80100b6c:	e8 0f 5d 00 00       	call   80106880 <allocuvm>
80100b71:	85 c0                	test   %eax,%eax
80100b73:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100b79:	75 33                	jne    80100bae <exec+0x20e>
    freevm(pgdir);
80100b7b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b81:	89 04 24             	mov    %eax,(%esp)
80100b84:	e8 07 5e 00 00       	call   80106990 <freevm>
  return -1;
80100b89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b8e:	e9 7f fe ff ff       	jmp    80100a12 <exec+0x72>
    end_op();
80100b93:	e8 e8 1f 00 00       	call   80102b80 <end_op>
    cprintf("exec: fail\n");
80100b98:	c7 04 24 41 6d 10 80 	movl   $0x80106d41,(%esp)
80100b9f:	e8 ac fa ff ff       	call   80100650 <cprintf>
    return -1;
80100ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba9:	e9 64 fe ff ff       	jmp    80100a12 <exec+0x72>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bae:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100bb4:	89 d8                	mov    %ebx,%eax
80100bb6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bbf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bc5:	89 04 24             	mov    %eax,(%esp)
80100bc8:	e8 f3 5e 00 00       	call   80106ac0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bd0:	8b 00                	mov    (%eax),%eax
80100bd2:	85 c0                	test   %eax,%eax
80100bd4:	0f 84 59 01 00 00    	je     80100d33 <exec+0x393>
80100bda:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100bdd:	31 d2                	xor    %edx,%edx
80100bdf:	8d 71 04             	lea    0x4(%ecx),%esi
80100be2:	89 cf                	mov    %ecx,%edi
80100be4:	89 d1                	mov    %edx,%ecx
80100be6:	89 f2                	mov    %esi,%edx
80100be8:	89 fe                	mov    %edi,%esi
80100bea:	89 cf                	mov    %ecx,%edi
80100bec:	eb 0a                	jmp    80100bf8 <exec+0x258>
80100bee:	66 90                	xchg   %ax,%ax
80100bf0:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100bf3:	83 ff 20             	cmp    $0x20,%edi
80100bf6:	74 83                	je     80100b7b <exec+0x1db>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf8:	89 04 24             	mov    %eax,(%esp)
80100bfb:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c01:	e8 7a 39 00 00       	call   80104580 <strlen>
80100c06:	f7 d0                	not    %eax
80100c08:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0a:	8b 06                	mov    (%esi),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0f:	89 04 24             	mov    %eax,(%esp)
80100c12:	e8 69 39 00 00       	call   80104580 <strlen>
80100c17:	83 c0 01             	add    $0x1,%eax
80100c1a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c1e:	8b 06                	mov    (%esi),%eax
80100c20:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c24:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c28:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2e:	89 04 24             	mov    %eax,(%esp)
80100c31:	e8 ea 5f 00 00       	call   80106c20 <copyout>
80100c36:	85 c0                	test   %eax,%eax
80100c38:	0f 88 3d ff ff ff    	js     80100b7b <exec+0x1db>
  for(argc = 0; argv[argc]; argc++) {
80100c3e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    ustack[3+argc] = sp;
80100c44:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c4a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c51:	83 c7 01             	add    $0x1,%edi
80100c54:	8b 02                	mov    (%edx),%eax
80100c56:	89 d6                	mov    %edx,%esi
80100c58:	85 c0                	test   %eax,%eax
80100c5a:	75 94                	jne    80100bf0 <exec+0x250>
80100c5c:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100c5e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100c65:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c69:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[1] = argc;
80100c70:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c76:	89 da                	mov    %ebx,%edx
80100c78:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100c7a:	83 c0 0c             	add    $0xc,%eax
80100c7d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c83:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c89:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100c91:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c98:	ff ff ff 
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9b:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c9e:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ca4:	e8 77 5f 00 00       	call   80106c20 <copyout>
80100ca9:	85 c0                	test   %eax,%eax
80100cab:	0f 88 ca fe ff ff    	js     80100b7b <exec+0x1db>
  for(last=s=path; *s; s++)
80100cb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cb4:	0f b6 10             	movzbl (%eax),%edx
80100cb7:	84 d2                	test   %dl,%dl
80100cb9:	74 19                	je     80100cd4 <exec+0x334>
80100cbb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cbe:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100cc1:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100cc4:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100cc7:	0f 44 c8             	cmove  %eax,%ecx
80100cca:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100ccd:	84 d2                	test   %dl,%dl
80100ccf:	75 f0                	jne    80100cc1 <exec+0x321>
80100cd1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cd4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cda:	8b 45 08             	mov    0x8(%ebp),%eax
80100cdd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100ce4:	00 
80100ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce9:	89 f8                	mov    %edi,%eax
80100ceb:	83 c0 6c             	add    $0x6c,%eax
80100cee:	89 04 24             	mov    %eax,(%esp)
80100cf1:	e8 4a 38 00 00       	call   80104540 <safestrcpy>
  curproc->pgdir = pgdir;
80100cf6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100cfc:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100cff:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d02:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d05:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100d0b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d0d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d13:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d16:	8b 47 18             	mov    0x18(%edi),%eax
80100d19:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d1c:	89 3c 24             	mov    %edi,(%esp)
80100d1f:	e8 0c 59 00 00       	call   80106630 <switchuvm>
  freevm(oldpgdir);
80100d24:	89 34 24             	mov    %esi,(%esp)
80100d27:	e8 64 5c 00 00       	call   80106990 <freevm>
  return 0;
80100d2c:	31 c0                	xor    %eax,%eax
80100d2e:	e9 df fc ff ff       	jmp    80100a12 <exec+0x72>
  for(argc = 0; argv[argc]; argc++) {
80100d33:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d39:	31 d2                	xor    %edx,%edx
80100d3b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d41:	e9 18 ff ff ff       	jmp    80100c5e <exec+0x2be>
80100d46:	66 90                	xchg   %ax,%ax
80100d48:	66 90                	xchg   %ax,%ax
80100d4a:	66 90                	xchg   %ax,%ax
80100d4c:	66 90                	xchg   %ax,%ax
80100d4e:	66 90                	xchg   %ax,%ax

80100d50 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d56:	c7 44 24 04 4d 6d 10 	movl   $0x80106d4d,0x4(%esp)
80100d5d:	80 
80100d5e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d65:	e8 c6 33 00 00       	call   80104130 <initlock>
}
80100d6a:	c9                   	leave  
80100d6b:	c3                   	ret    
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

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
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
{
80100d79:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d7c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d83:	e8 18 35 00 00       	call   801042a0 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
    if(f->ref == 0){
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100da2:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
      f->ref = 1;
80100da9:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100db0:	e8 5b 35 00 00       	call   80104310 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100db5:	83 c4 14             	add    $0x14,%esp
      return f;
80100db8:	89 d8                	mov    %ebx,%eax
}
80100dba:	5b                   	pop    %ebx
80100dbb:	5d                   	pop    %ebp
80100dbc:	c3                   	ret    
80100dbd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100dc0:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100dc7:	e8 44 35 00 00       	call   80104310 <release>
}
80100dcc:	83 c4 14             	add    $0x14,%esp
  return 0;
80100dcf:	31 c0                	xor    %eax,%eax
}
80100dd1:	5b                   	pop    %ebx
80100dd2:	5d                   	pop    %ebp
80100dd3:	c3                   	ret    
80100dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100de0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 14             	sub    $0x14,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dea:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100df1:	e8 aa 34 00 00       	call   801042a0 <acquire>
  if(f->ref < 1)
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 1a                	jle    80100e17 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100dfd:	83 c0 01             	add    $0x1,%eax
80100e00:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e03:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e0a:	e8 01 35 00 00       	call   80104310 <release>
  return f;
}
80100e0f:	83 c4 14             	add    $0x14,%esp
80100e12:	89 d8                	mov    %ebx,%eax
80100e14:	5b                   	pop    %ebx
80100e15:	5d                   	pop    %ebp
80100e16:	c3                   	ret    
    panic("filedup");
80100e17:	c7 04 24 54 6d 10 80 	movl   $0x80106d54,(%esp)
80100e1e:	e8 3d f5 ff ff       	call   80100360 <panic>
80100e23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 1c             	sub    $0x1c,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e3c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e43:	e8 58 34 00 00       	call   801042a0 <acquire>
  if(f->ref < 1)
80100e48:	8b 57 04             	mov    0x4(%edi),%edx
80100e4b:	85 d2                	test   %edx,%edx
80100e4d:	0f 8e 89 00 00 00    	jle    80100edc <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100e53:	83 ea 01             	sub    $0x1,%edx
80100e56:	85 d2                	test   %edx,%edx
80100e58:	89 57 04             	mov    %edx,0x4(%edi)
80100e5b:	74 13                	je     80100e70 <fileclose+0x40>
    release(&ftable.lock);
80100e5d:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e64:	83 c4 1c             	add    $0x1c,%esp
80100e67:	5b                   	pop    %ebx
80100e68:	5e                   	pop    %esi
80100e69:	5f                   	pop    %edi
80100e6a:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e6b:	e9 a0 34 00 00       	jmp    80104310 <release>
  ff = *f;
80100e70:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e74:	8b 37                	mov    (%edi),%esi
80100e76:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->type = FD_NONE;
80100e79:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100e7f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e82:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100e85:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  ff = *f;
80100e8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100e8f:	e8 7c 34 00 00       	call   80104310 <release>
  if(ff.type == FD_PIPE)
80100e94:	83 fe 01             	cmp    $0x1,%esi
80100e97:	74 0f                	je     80100ea8 <fileclose+0x78>
  else if(ff.type == FD_INODE){
80100e99:	83 fe 02             	cmp    $0x2,%esi
80100e9c:	74 22                	je     80100ec0 <fileclose+0x90>
}
80100e9e:	83 c4 1c             	add    $0x1c,%esp
80100ea1:	5b                   	pop    %ebx
80100ea2:	5e                   	pop    %esi
80100ea3:	5f                   	pop    %edi
80100ea4:	5d                   	pop    %ebp
80100ea5:	c3                   	ret    
80100ea6:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ea8:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100eac:	89 1c 24             	mov    %ebx,(%esp)
80100eaf:	89 74 24 04          	mov    %esi,0x4(%esp)
80100eb3:	e8 a8 23 00 00       	call   80103260 <pipeclose>
80100eb8:	eb e4                	jmp    80100e9e <fileclose+0x6e>
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ec0:	e8 4b 1c 00 00       	call   80102b10 <begin_op>
    iput(ff.ip);
80100ec5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ec8:	89 04 24             	mov    %eax,(%esp)
80100ecb:	e8 00 09 00 00       	call   801017d0 <iput>
}
80100ed0:	83 c4 1c             	add    $0x1c,%esp
80100ed3:	5b                   	pop    %ebx
80100ed4:	5e                   	pop    %esi
80100ed5:	5f                   	pop    %edi
80100ed6:	5d                   	pop    %ebp
    end_op();
80100ed7:	e9 a4 1c 00 00       	jmp    80102b80 <end_op>
    panic("fileclose");
80100edc:	c7 04 24 5c 6d 10 80 	movl   $0x80106d5c,(%esp)
80100ee3:	e8 78 f4 ff ff       	call   80100360 <panic>
80100ee8:	90                   	nop
80100ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 14             	sub    $0x14,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
    ilock(f->ip);
80100eff:	8b 43 10             	mov    0x10(%ebx),%eax
80100f02:	89 04 24             	mov    %eax,(%esp)
80100f05:	e8 a6 07 00 00       	call   801016b0 <ilock>
    stati(f->ip, st);
80100f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
80100f14:	89 04 24             	mov    %eax,(%esp)
80100f17:	e8 14 0a 00 00       	call   80101930 <stati>
    iunlock(f->ip);
80100f1c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f1f:	89 04 24             	mov    %eax,(%esp)
80100f22:	e8 69 08 00 00       	call   80101790 <iunlock>
    return 0;
  }
  return -1;
}
80100f27:	83 c4 14             	add    $0x14,%esp
    return 0;
80100f2a:	31 c0                	xor    %eax,%eax
}
80100f2c:	5b                   	pop    %ebx
80100f2d:	5d                   	pop    %ebp
80100f2e:	c3                   	ret    
80100f2f:	90                   	nop
80100f30:	83 c4 14             	add    $0x14,%esp
  return -1;
80100f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f38:	5b                   	pop    %ebx
80100f39:	5d                   	pop    %ebp
80100f3a:	c3                   	ret    
80100f3b:	90                   	nop
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 1c             	sub    $0x1c,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 68                	je     80100fc0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 49                	je     80100fa8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 63                	jne    80100fc7 <fileread+0x87>
    ilock(f->ip);
80100f64:	8b 43 10             	mov    0x10(%ebx),%eax
80100f67:	89 04 24             	mov    %eax,(%esp)
80100f6a:	e8 41 07 00 00       	call   801016b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f6f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f73:	8b 43 14             	mov    0x14(%ebx),%eax
80100f76:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f7a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f7e:	8b 43 10             	mov    0x10(%ebx),%eax
80100f81:	89 04 24             	mov    %eax,(%esp)
80100f84:	e8 d7 09 00 00       	call   80101960 <readi>
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	89 c6                	mov    %eax,%esi
80100f8d:	7e 03                	jle    80100f92 <fileread+0x52>
      f->off += r;
80100f8f:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f92:	8b 43 10             	mov    0x10(%ebx),%eax
80100f95:	89 04 24             	mov    %eax,(%esp)
80100f98:	e8 f3 07 00 00       	call   80101790 <iunlock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f9d:	89 f0                	mov    %esi,%eax
    return r;
  }
  panic("fileread");
}
80100f9f:	83 c4 1c             	add    $0x1c,%esp
80100fa2:	5b                   	pop    %ebx
80100fa3:	5e                   	pop    %esi
80100fa4:	5f                   	pop    %edi
80100fa5:	5d                   	pop    %ebp
80100fa6:	c3                   	ret    
80100fa7:	90                   	nop
    return piperead(f->pipe, addr, n);
80100fa8:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fab:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fae:	83 c4 1c             	add    $0x1c,%esp
80100fb1:	5b                   	pop    %ebx
80100fb2:	5e                   	pop    %esi
80100fb3:	5f                   	pop    %edi
80100fb4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fb5:	e9 26 24 00 00       	jmp    801033e0 <piperead>
80100fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fc5:	eb d8                	jmp    80100f9f <fileread+0x5f>
  panic("fileread");
80100fc7:	c7 04 24 66 6d 10 80 	movl   $0x80106d66,(%esp)
80100fce:	e8 8d f3 ff ff       	call   80100360 <panic>
80100fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 2c             	sub    $0x2c,%esp
80100fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fec:	8b 7d 08             	mov    0x8(%ebp),%edi
80100fef:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80100ff5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80100ffc:	0f 84 ae 00 00 00    	je     801010b0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101002:	8b 07                	mov    (%edi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d7 00 00 00    	jne    801010ed <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 db                	xor    %ebx,%ebx
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 31                	jg     80101050 <filewrite+0x70>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101028:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010102b:	01 47 14             	add    %eax,0x14(%edi)
8010102e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101031:	89 0c 24             	mov    %ecx,(%esp)
80101034:	e8 57 07 00 00       	call   80101790 <iunlock>
      end_op();
80101039:	e8 42 1b 00 00       	call   80102b80 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101041:	39 f0                	cmp    %esi,%eax
80101043:	0f 85 98 00 00 00    	jne    801010e1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101049:	01 c3                	add    %eax,%ebx
    while(i < n){
8010104b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010104e:	7e 70                	jle    801010c0 <filewrite+0xe0>
      int n1 = n - i;
80101050:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101053:	b8 00 06 00 00       	mov    $0x600,%eax
80101058:	29 de                	sub    %ebx,%esi
8010105a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101060:	0f 4f f0             	cmovg  %eax,%esi
      begin_op();
80101063:	e8 a8 1a 00 00       	call   80102b10 <begin_op>
      ilock(f->ip);
80101068:	8b 47 10             	mov    0x10(%edi),%eax
8010106b:	89 04 24             	mov    %eax,(%esp)
8010106e:	e8 3d 06 00 00       	call   801016b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101073:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101077:	8b 47 14             	mov    0x14(%edi),%eax
8010107a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010107e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101081:	01 d8                	add    %ebx,%eax
80101083:	89 44 24 04          	mov    %eax,0x4(%esp)
80101087:	8b 47 10             	mov    0x10(%edi),%eax
8010108a:	89 04 24             	mov    %eax,(%esp)
8010108d:	e8 ce 09 00 00       	call   80101a60 <writei>
80101092:	85 c0                	test   %eax,%eax
80101094:	7f 92                	jg     80101028 <filewrite+0x48>
      iunlock(f->ip);
80101096:	8b 4f 10             	mov    0x10(%edi),%ecx
80101099:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010109c:	89 0c 24             	mov    %ecx,(%esp)
8010109f:	e8 ec 06 00 00       	call   80101790 <iunlock>
      end_op();
801010a4:	e8 d7 1a 00 00       	call   80102b80 <end_op>
      if(r < 0)
801010a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ac:	85 c0                	test   %eax,%eax
801010ae:	74 91                	je     80101041 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010b0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010b8:	5b                   	pop    %ebx
801010b9:	5e                   	pop    %esi
801010ba:	5f                   	pop    %edi
801010bb:	5d                   	pop    %ebp
801010bc:	c3                   	ret    
801010bd:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
801010c0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801010c3:	89 d8                	mov    %ebx,%eax
801010c5:	75 e9                	jne    801010b0 <filewrite+0xd0>
}
801010c7:	83 c4 2c             	add    $0x2c,%esp
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801010cf:	8b 47 0c             	mov    0xc(%edi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010d5:	83 c4 2c             	add    $0x2c,%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010dc:	e9 0f 22 00 00       	jmp    801032f0 <pipewrite>
        panic("short filewrite");
801010e1:	c7 04 24 6f 6d 10 80 	movl   $0x80106d6f,(%esp)
801010e8:	e8 73 f2 ff ff       	call   80100360 <panic>
  panic("filewrite");
801010ed:	c7 04 24 75 6d 10 80 	movl   $0x80106d75,(%esp)
801010f4:	e8 67 f2 ff ff       	call   80100360 <panic>
801010f9:	66 90                	xchg   %ax,%ax
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	89 d7                	mov    %edx,%edi
80101106:	56                   	push   %esi
80101107:	53                   	push   %ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101108:	bb 01 00 00 00       	mov    $0x1,%ebx
{
8010110d:	83 ec 1c             	sub    $0x1c,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101110:	c1 ea 0c             	shr    $0xc,%edx
80101113:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101119:	89 04 24             	mov    %eax,(%esp)
8010111c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101120:	e8 ab ef ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101125:	89 f9                	mov    %edi,%ecx
  bi = b % BPB;
80101127:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
8010112d:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
8010112f:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101132:	c1 fa 03             	sar    $0x3,%edx
  m = 1 << (bi % 8);
80101135:	d3 e3                	shl    %cl,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101137:	89 c6                	mov    %eax,%esi
  if((bp->data[bi/8] & m) == 0)
80101139:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
8010113e:	0f b6 c8             	movzbl %al,%ecx
80101141:	85 d9                	test   %ebx,%ecx
80101143:	74 20                	je     80101165 <bfree+0x65>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101145:	f7 d3                	not    %ebx
80101147:	21 c3                	and    %eax,%ebx
80101149:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
8010114d:	89 34 24             	mov    %esi,(%esp)
80101150:	e8 5b 1b 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101155:	89 34 24             	mov    %esi,(%esp)
80101158:	e8 83 f0 ff ff       	call   801001e0 <brelse>
}
8010115d:	83 c4 1c             	add    $0x1c,%esp
80101160:	5b                   	pop    %ebx
80101161:	5e                   	pop    %esi
80101162:	5f                   	pop    %edi
80101163:	5d                   	pop    %ebp
80101164:	c3                   	ret    
    panic("freeing free block");
80101165:	c7 04 24 7f 6d 10 80 	movl   $0x80106d7f,(%esp)
8010116c:	e8 ef f1 ff ff       	call   80100360 <panic>
80101171:	eb 0d                	jmp    80101180 <balloc>
80101173:	90                   	nop
80101174:	90                   	nop
80101175:	90                   	nop
80101176:	90                   	nop
80101177:	90                   	nop
80101178:	90                   	nop
80101179:	90                   	nop
8010117a:	90                   	nop
8010117b:	90                   	nop
8010117c:	90                   	nop
8010117d:	90                   	nop
8010117e:	90                   	nop
8010117f:	90                   	nop

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 2c             	sub    $0x2c,%esp
80101189:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010118c:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101191:	85 c0                	test   %eax,%eax
80101193:	0f 84 8c 00 00 00    	je     80101225 <balloc+0xa5>
80101199:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a3:	89 f0                	mov    %esi,%eax
801011a5:	c1 f8 0c             	sar    $0xc,%eax
801011a8:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801011b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011b5:	89 04 24             	mov    %eax,(%esp)
801011b8:	e8 13 ef ff ff       	call   801000d0 <bread>
801011bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801011c0:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011c8:	31 c0                	xor    %eax,%eax
801011ca:	eb 33                	jmp    801011ff <balloc+0x7f>
801011cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011d3:	89 c2                	mov    %eax,%edx
      m = 1 << (bi % 8);
801011d5:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d7:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	bf 01 00 00 00       	mov    $0x1,%edi
801011e2:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e4:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx
      m = 1 << (bi % 8);
801011e9:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011eb:	0f b6 fb             	movzbl %bl,%edi
801011ee:	85 cf                	test   %ecx,%edi
801011f0:	74 46                	je     80101238 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011f2:	83 c0 01             	add    $0x1,%eax
801011f5:	83 c6 01             	add    $0x1,%esi
801011f8:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fd:	74 05                	je     80101204 <balloc+0x84>
801011ff:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101202:	72 cc                	jb     801011d0 <balloc+0x50>
    brelse(bp);
80101204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101207:	89 04 24             	mov    %eax,(%esp)
8010120a:	e8 d1 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
8010121f:	0f 82 7b ff ff ff    	jb     801011a0 <balloc+0x20>
  panic("balloc: out of blocks");
80101225:	c7 04 24 92 6d 10 80 	movl   $0x80106d92,(%esp)
8010122c:	e8 2f f1 ff ff       	call   80100360 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101238:	09 d9                	or     %ebx,%ecx
8010123a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010123d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
80101241:	89 1c 24             	mov    %ebx,(%esp)
80101244:	e8 67 1a 00 00       	call   80102cb0 <log_write>
        brelse(bp);
80101249:	89 1c 24             	mov    %ebx,(%esp)
8010124c:	e8 8f ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
80101251:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101254:	89 74 24 04          	mov    %esi,0x4(%esp)
80101258:	89 04 24             	mov    %eax,(%esp)
8010125b:	e8 70 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101260:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101267:	00 
80101268:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010126f:	00 
  bp = bread(dev, bno);
80101270:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101272:	8d 40 5c             	lea    0x5c(%eax),%eax
80101275:	89 04 24             	mov    %eax,(%esp)
80101278:	e8 e3 30 00 00       	call   80104360 <memset>
  log_write(bp);
8010127d:	89 1c 24             	mov    %ebx,(%esp)
80101280:	e8 2b 1a 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101285:	89 1c 24             	mov    %ebx,(%esp)
80101288:	e8 53 ef ff ff       	call   801001e0 <brelse>
}
8010128d:	83 c4 2c             	add    $0x2c,%esp
80101290:	89 f0                	mov    %esi,%eax
80101292:	5b                   	pop    %ebx
80101293:	5e                   	pop    %esi
80101294:	5f                   	pop    %edi
80101295:	5d                   	pop    %ebp
80101296:	c3                   	ret    
80101297:	89 f6                	mov    %esi,%esi
80101299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012af:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&icache.lock);
801012b2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
{
801012b9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012bc:	e8 df 2f 00 00       	call   801042a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012c4:	eb 14                	jmp    801012da <iget+0x3a>
801012c6:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012c8:	85 f6                	test   %esi,%esi
801012ca:	74 3c                	je     80101308 <iget+0x68>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012cc:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012d2:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012d8:	74 46                	je     80101320 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012da:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	7e e7                	jle    801012c8 <iget+0x28>
801012e1:	39 3b                	cmp    %edi,(%ebx)
801012e3:	75 e3                	jne    801012c8 <iget+0x28>
801012e5:	39 53 04             	cmp    %edx,0x4(%ebx)
801012e8:	75 de                	jne    801012c8 <iget+0x28>
      ip->ref++;
801012ea:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012ed:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012ef:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
      ip->ref++;
801012f6:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012f9:	e8 12 30 00 00       	call   80104310 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012fe:	83 c4 1c             	add    $0x1c,%esp
80101301:	89 f0                	mov    %esi,%eax
80101303:	5b                   	pop    %ebx
80101304:	5e                   	pop    %esi
80101305:	5f                   	pop    %edi
80101306:	5d                   	pop    %ebp
80101307:	c3                   	ret    
80101308:	85 c9                	test   %ecx,%ecx
8010130a:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101313:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101319:	75 bf                	jne    801012da <iget+0x3a>
8010131b:	90                   	nop
8010131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
80101320:	85 f6                	test   %esi,%esi
80101322:	74 29                	je     8010134d <iget+0xad>
  ip->dev = dev;
80101324:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101326:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101329:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101330:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101337:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010133e:	e8 cd 2f 00 00       	call   80104310 <release>
}
80101343:	83 c4 1c             	add    $0x1c,%esp
80101346:	89 f0                	mov    %esi,%eax
80101348:	5b                   	pop    %ebx
80101349:	5e                   	pop    %esi
8010134a:	5f                   	pop    %edi
8010134b:	5d                   	pop    %ebp
8010134c:	c3                   	ret    
    panic("iget: no inodes");
8010134d:	c7 04 24 a8 6d 10 80 	movl   $0x80106da8,(%esp)
80101354:	e8 07 f0 ff ff       	call   80100360 <panic>
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c3                	mov    %eax,%ebx
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 46 5c             	mov    0x5c(%esi),%eax
80101376:	85 c0                	test   %eax,%eax
80101378:	74 66                	je     801013e0 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	83 c4 1c             	add    $0x1c,%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
80101388:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
8010138b:	83 fe 7f             	cmp    $0x7f,%esi
8010138e:	77 77                	ja     80101407 <bmap+0xa7>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101390:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101396:	85 c0                	test   %eax,%eax
80101398:	74 5e                	je     801013f8 <bmap+0x98>
    bp = bread(ip->dev, addr);
8010139a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010139e:	8b 03                	mov    (%ebx),%eax
801013a0:	89 04 24             	mov    %eax,(%esp)
801013a3:	e8 28 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013a8:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
    bp = bread(ip->dev, addr);
801013ac:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013ae:	8b 32                	mov    (%edx),%esi
801013b0:	85 f6                	test   %esi,%esi
801013b2:	75 19                	jne    801013cd <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
801013b4:	8b 03                	mov    (%ebx),%eax
801013b6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013b9:	e8 c2 fd ff ff       	call   80101180 <balloc>
801013be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013c1:	89 02                	mov    %eax,(%edx)
801013c3:	89 c6                	mov    %eax,%esi
      log_write(bp);
801013c5:	89 3c 24             	mov    %edi,(%esp)
801013c8:	e8 e3 18 00 00       	call   80102cb0 <log_write>
    brelse(bp);
801013cd:	89 3c 24             	mov    %edi,(%esp)
801013d0:	e8 0b ee ff ff       	call   801001e0 <brelse>
}
801013d5:	83 c4 1c             	add    $0x1c,%esp
    brelse(bp);
801013d8:	89 f0                	mov    %esi,%eax
}
801013da:	5b                   	pop    %ebx
801013db:	5e                   	pop    %esi
801013dc:	5f                   	pop    %edi
801013dd:	5d                   	pop    %ebp
801013de:	c3                   	ret    
801013df:	90                   	nop
      ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 03                	mov    (%ebx),%eax
801013e2:	e8 99 fd ff ff       	call   80101180 <balloc>
801013e7:	89 46 5c             	mov    %eax,0x5c(%esi)
}
801013ea:	83 c4 1c             	add    $0x1c,%esp
801013ed:	5b                   	pop    %ebx
801013ee:	5e                   	pop    %esi
801013ef:	5f                   	pop    %edi
801013f0:	5d                   	pop    %ebp
801013f1:	c3                   	ret    
801013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013f8:	8b 03                	mov    (%ebx),%eax
801013fa:	e8 81 fd ff ff       	call   80101180 <balloc>
801013ff:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101405:	eb 93                	jmp    8010139a <bmap+0x3a>
  panic("bmap: out of range");
80101407:	c7 04 24 b8 6d 10 80 	movl   $0x80106db8,(%esp)
8010140e:	e8 4d ef ff ff       	call   80100360 <panic>
80101413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101420 <readsb>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, 1);
80101428:	8b 45 08             	mov    0x8(%ebp),%eax
8010142b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101432:	00 
{
80101433:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101436:	89 04 24             	mov    %eax,(%esp)
80101439:	e8 92 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010143e:	89 34 24             	mov    %esi,(%esp)
80101441:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101448:	00 
  bp = bread(dev, 1);
80101449:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010144b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010144e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101452:	e8 a9 2f 00 00       	call   80104400 <memmove>
  brelse(bp);
80101457:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010145a:	83 c4 10             	add    $0x10,%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5d                   	pop    %ebp
  brelse(bp);
80101460:	e9 7b ed ff ff       	jmp    801001e0 <brelse>
80101465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101470 <iinit>:
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
8010147c:	c7 44 24 04 cb 6d 10 	movl   $0x80106dcb,0x4(%esp)
80101483:	80 
80101484:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010148b:	e8 a0 2c 00 00       	call   80104130 <initlock>
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	89 1c 24             	mov    %ebx,(%esp)
80101493:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101499:	c7 44 24 04 d2 6d 10 	movl   $0x80106dd2,0x4(%esp)
801014a0:	80 
801014a1:	e8 5a 2b 00 00       	call   80104000 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014a6:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ac:	75 e2                	jne    80101490 <iinit+0x20>
  readsb(dev, &sb);
801014ae:	8b 45 08             	mov    0x8(%ebp),%eax
801014b1:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014b8:	80 
801014b9:	89 04 24             	mov    %eax,(%esp)
801014bc:	e8 5f ff ff ff       	call   80101420 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014c1:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801014c6:	c7 04 24 38 6e 10 80 	movl   $0x80106e38,(%esp)
801014cd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801014d1:	a1 d4 09 11 80       	mov    0x801109d4,%eax
801014d6:	89 44 24 18          	mov    %eax,0x18(%esp)
801014da:	a1 d0 09 11 80       	mov    0x801109d0,%eax
801014df:	89 44 24 14          	mov    %eax,0x14(%esp)
801014e3:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801014e8:	89 44 24 10          	mov    %eax,0x10(%esp)
801014ec:	a1 c8 09 11 80       	mov    0x801109c8,%eax
801014f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014f5:	a1 c4 09 11 80       	mov    0x801109c4,%eax
801014fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801014fe:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101503:	89 44 24 04          	mov    %eax,0x4(%esp)
80101507:	e8 44 f1 ff ff       	call   80100650 <cprintf>
}
8010150c:	83 c4 24             	add    $0x24,%esp
8010150f:	5b                   	pop    %ebx
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
80101512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 2c             	sub    $0x2c,%esp
80101529:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101533:	8b 7d 08             	mov    0x8(%ebp),%edi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 a2 00 00 00    	jbe    801015e1 <ialloc+0xc1>
8010153f:	be 01 00 00 00       	mov    $0x1,%esi
80101544:	bb 01 00 00 00       	mov    $0x1,%ebx
80101549:	eb 1a                	jmp    80101565 <ialloc+0x45>
8010154b:	90                   	nop
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
80101550:	89 14 24             	mov    %edx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	e8 85 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155b:	89 de                	mov    %ebx,%esi
8010155d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101563:	73 7c                	jae    801015e1 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101565:	89 f0                	mov    %esi,%eax
80101567:	c1 e8 03             	shr    $0x3,%eax
8010156a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101570:	89 3c 24             	mov    %edi,(%esp)
80101573:	89 44 24 04          	mov    %eax,0x4(%esp)
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 f0                	mov    %esi,%eax
80101580:	83 e0 07             	and    $0x7,%eax
80101583:	c1 e0 06             	shl    $0x6,%eax
80101586:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010158e:	75 c0                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101590:	89 0c 24             	mov    %ecx,(%esp)
80101593:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010159a:	00 
8010159b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015a2:	00 
801015a3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015a9:	e8 b2 2d 00 00       	call   80104360 <memset>
      dip->type = type;
801015ae:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801015b2:	8b 55 dc             	mov    -0x24(%ebp),%edx
      dip->type = type;
801015b5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801015b8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      dip->type = type;
801015bb:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015be:	89 14 24             	mov    %edx,(%esp)
801015c1:	e8 ea 16 00 00       	call   80102cb0 <log_write>
      brelse(bp);
801015c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015c9:	89 14 24             	mov    %edx,(%esp)
801015cc:	e8 0f ec ff ff       	call   801001e0 <brelse>
}
801015d1:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
801015d4:	89 f2                	mov    %esi,%edx
}
801015d6:	5b                   	pop    %ebx
      return iget(dev, inum);
801015d7:	89 f8                	mov    %edi,%eax
}
801015d9:	5e                   	pop    %esi
801015da:	5f                   	pop    %edi
801015db:	5d                   	pop    %ebp
      return iget(dev, inum);
801015dc:	e9 bf fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
801015e1:	c7 04 24 d8 6d 10 80 	movl   $0x80106dd8,(%esp)
801015e8:	e8 73 ed ff ff       	call   80100360 <panic>
801015ed:	8d 76 00             	lea    0x0(%esi),%esi

801015f0 <iupdate>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	83 ec 10             	sub    $0x10,%esp
801015f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fe:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101601:	c1 e8 03             	shr    $0x3,%eax
80101604:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010160a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010160e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101611:	89 04 24             	mov    %eax,(%esp)
80101614:	e8 b7 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101619:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010161c:	83 e2 07             	and    $0x7,%edx
8010161f:	c1 e2 06             	shl    $0x6,%edx
80101622:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101626:	89 c6                	mov    %eax,%esi
  dip->type = ip->type;
80101628:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162c:	83 c2 0c             	add    $0xc,%edx
  dip->type = ip->type;
8010162f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101633:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101637:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010163b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010163f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101643:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101647:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010164b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010164e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101651:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101655:	89 14 24             	mov    %edx,(%esp)
80101658:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010165f:	00 
80101660:	e8 9b 2d 00 00       	call   80104400 <memmove>
  log_write(bp);
80101665:	89 34 24             	mov    %esi,(%esp)
80101668:	e8 43 16 00 00       	call   80102cb0 <log_write>
  brelse(bp);
8010166d:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101670:	83 c4 10             	add    $0x10,%esp
80101673:	5b                   	pop    %ebx
80101674:	5e                   	pop    %esi
80101675:	5d                   	pop    %ebp
  brelse(bp);
80101676:	e9 65 eb ff ff       	jmp    801001e0 <brelse>
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <idup>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	83 ec 14             	sub    $0x14,%esp
80101687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010168a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101691:	e8 0a 2c 00 00       	call   801042a0 <acquire>
  ip->ref++;
80101696:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010169a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016a1:	e8 6a 2c 00 00       	call   80104310 <release>
}
801016a6:	83 c4 14             	add    $0x14,%esp
801016a9:	89 d8                	mov    %ebx,%eax
801016ab:	5b                   	pop    %ebx
801016ac:	5d                   	pop    %ebp
801016ad:	c3                   	ret    
801016ae:	66 90                	xchg   %ax,%ax

801016b0 <ilock>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	83 ec 10             	sub    $0x10,%esp
801016b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016bb:	85 db                	test   %ebx,%ebx
801016bd:	0f 84 b3 00 00 00    	je     80101776 <ilock+0xc6>
801016c3:	8b 53 08             	mov    0x8(%ebx),%edx
801016c6:	85 d2                	test   %edx,%edx
801016c8:	0f 8e a8 00 00 00    	jle    80101776 <ilock+0xc6>
  acquiresleep(&ip->lock);
801016ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801016d1:	89 04 24             	mov    %eax,(%esp)
801016d4:	e8 67 29 00 00       	call   80104040 <acquiresleep>
  if(ip->valid == 0){
801016d9:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016dc:	85 c0                	test   %eax,%eax
801016de:	74 08                	je     801016e8 <ilock+0x38>
}
801016e0:	83 c4 10             	add    $0x10,%esp
801016e3:	5b                   	pop    %ebx
801016e4:	5e                   	pop    %esi
801016e5:	5d                   	pop    %ebp
801016e6:	c3                   	ret    
801016e7:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	8b 43 04             	mov    0x4(%ebx),%eax
801016eb:	c1 e8 03             	shr    $0x3,%eax
801016ee:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801016f8:	8b 03                	mov    (%ebx),%eax
801016fa:	89 04 24             	mov    %eax,(%esp)
801016fd:	e8 ce e9 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101702:	8b 53 04             	mov    0x4(%ebx),%edx
80101705:	83 e2 07             	and    $0x7,%edx
80101708:	c1 e2 06             	shl    $0x6,%edx
8010170b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170f:	89 c6                	mov    %eax,%esi
    ip->type = dip->type;
80101711:	0f b7 02             	movzwl (%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101714:	83 c2 0c             	add    $0xc,%edx
    ip->type = dip->type;
80101717:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010171b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010171f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101723:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101727:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010172b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010172f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101733:	8b 42 fc             	mov    -0x4(%edx),%eax
80101736:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101739:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010173c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101740:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101747:	00 
80101748:	89 04 24             	mov    %eax,(%esp)
8010174b:	e8 b0 2c 00 00       	call   80104400 <memmove>
    brelse(bp);
80101750:	89 34 24             	mov    %esi,(%esp)
80101753:	e8 88 ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101758:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010175d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101764:	0f 85 76 ff ff ff    	jne    801016e0 <ilock+0x30>
      panic("ilock: no type");
8010176a:	c7 04 24 f0 6d 10 80 	movl   $0x80106df0,(%esp)
80101771:	e8 ea eb ff ff       	call   80100360 <panic>
    panic("ilock");
80101776:	c7 04 24 ea 6d 10 80 	movl   $0x80106dea,(%esp)
8010177d:	e8 de eb ff ff       	call   80100360 <panic>
80101782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101790 <iunlock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	83 ec 10             	sub    $0x10,%esp
80101798:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010179b:	85 db                	test   %ebx,%ebx
8010179d:	74 24                	je     801017c3 <iunlock+0x33>
8010179f:	8d 73 0c             	lea    0xc(%ebx),%esi
801017a2:	89 34 24             	mov    %esi,(%esp)
801017a5:	e8 36 29 00 00       	call   801040e0 <holdingsleep>
801017aa:	85 c0                	test   %eax,%eax
801017ac:	74 15                	je     801017c3 <iunlock+0x33>
801017ae:	8b 43 08             	mov    0x8(%ebx),%eax
801017b1:	85 c0                	test   %eax,%eax
801017b3:	7e 0e                	jle    801017c3 <iunlock+0x33>
  releasesleep(&ip->lock);
801017b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	5b                   	pop    %ebx
801017bc:	5e                   	pop    %esi
801017bd:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017be:	e9 dd 28 00 00       	jmp    801040a0 <releasesleep>
    panic("iunlock");
801017c3:	c7 04 24 ff 6d 10 80 	movl   $0x80106dff,(%esp)
801017ca:	e8 91 eb ff ff       	call   80100360 <panic>
801017cf:	90                   	nop

801017d0 <iput>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	83 ec 1c             	sub    $0x1c,%esp
801017d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017dc:	8d 7e 0c             	lea    0xc(%esi),%edi
801017df:	89 3c 24             	mov    %edi,(%esp)
801017e2:	e8 59 28 00 00       	call   80104040 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017e7:	8b 56 4c             	mov    0x4c(%esi),%edx
801017ea:	85 d2                	test   %edx,%edx
801017ec:	74 07                	je     801017f5 <iput+0x25>
801017ee:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017f3:	74 2b                	je     80101820 <iput+0x50>
  releasesleep(&ip->lock);
801017f5:	89 3c 24             	mov    %edi,(%esp)
801017f8:	e8 a3 28 00 00       	call   801040a0 <releasesleep>
  acquire(&icache.lock);
801017fd:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101804:	e8 97 2a 00 00       	call   801042a0 <acquire>
  ip->ref--;
80101809:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010180d:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101814:	83 c4 1c             	add    $0x1c,%esp
80101817:	5b                   	pop    %ebx
80101818:	5e                   	pop    %esi
80101819:	5f                   	pop    %edi
8010181a:	5d                   	pop    %ebp
  release(&icache.lock);
8010181b:	e9 f0 2a 00 00       	jmp    80104310 <release>
    acquire(&icache.lock);
80101820:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101827:	e8 74 2a 00 00       	call   801042a0 <acquire>
    int r = ip->ref;
8010182c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010182f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101836:	e8 d5 2a 00 00       	call   80104310 <release>
    if(r == 1){
8010183b:	83 fb 01             	cmp    $0x1,%ebx
8010183e:	75 b5                	jne    801017f5 <iput+0x25>
80101840:	8d 4e 30             	lea    0x30(%esi),%ecx
80101843:	89 f3                	mov    %esi,%ebx
80101845:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x87>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fb                	cmp    %edi,%ebx
80101855:	74 19                	je     80101870 <iput+0xa0>
    if(ip->addrs[i]){
80101857:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010185a:	85 d2                	test   %edx,%edx
8010185c:	74 f2                	je     80101850 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010185e:	8b 06                	mov    (%esi),%eax
80101860:	e8 9b f8 ff ff       	call   80101100 <bfree>
      ip->addrs[i] = 0;
80101865:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010186c:	eb e2                	jmp    80101850 <iput+0x80>
8010186e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 2b                	jne    801018a8 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010187d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101884:	89 34 24             	mov    %esi,(%esp)
80101887:	e8 64 fd ff ff       	call   801015f0 <iupdate>
      ip->type = 0;
8010188c:	31 c0                	xor    %eax,%eax
8010188e:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101892:	89 34 24             	mov    %esi,(%esp)
80101895:	e8 56 fd ff ff       	call   801015f0 <iupdate>
      ip->valid = 0;
8010189a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018a1:	e9 4f ff ff ff       	jmp    801017f5 <iput+0x25>
801018a6:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018ac:	8b 06                	mov    (%esi),%eax
    for(j = 0; j < NINDIRECT; j++){
801018ae:	31 db                	xor    %ebx,%ebx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	89 04 24             	mov    %eax,(%esp)
801018b3:	e8 18 e8 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801018b8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    a = (uint*)bp->data;
801018bb:	8d 48 5c             	lea    0x5c(%eax),%ecx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801018c1:	89 cf                	mov    %ecx,%edi
801018c3:	31 c0                	xor    %eax,%eax
801018c5:	eb 0e                	jmp    801018d5 <iput+0x105>
801018c7:	90                   	nop
801018c8:	83 c3 01             	add    $0x1,%ebx
801018cb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801018d1:	89 d8                	mov    %ebx,%eax
801018d3:	74 10                	je     801018e5 <iput+0x115>
      if(a[j])
801018d5:	8b 14 87             	mov    (%edi,%eax,4),%edx
801018d8:	85 d2                	test   %edx,%edx
801018da:	74 ec                	je     801018c8 <iput+0xf8>
        bfree(ip->dev, a[j]);
801018dc:	8b 06                	mov    (%esi),%eax
801018de:	e8 1d f8 ff ff       	call   80101100 <bfree>
801018e3:	eb e3                	jmp    801018c8 <iput+0xf8>
    brelse(bp);
801018e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018eb:	89 04 24             	mov    %eax,(%esp)
801018ee:	e8 ed e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018f3:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018f9:	8b 06                	mov    (%esi),%eax
801018fb:	e8 00 f8 ff ff       	call   80101100 <bfree>
    ip->addrs[NDIRECT] = 0;
80101900:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101907:	00 00 00 
8010190a:	e9 6e ff ff ff       	jmp    8010187d <iput+0xad>
8010190f:	90                   	nop

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 14             	sub    $0x14,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	89 1c 24             	mov    %ebx,(%esp)
8010191d:	e8 6e fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101922:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101925:	83 c4 14             	add    $0x14,%esp
80101928:	5b                   	pop    %ebx
80101929:	5d                   	pop    %ebp
  iput(ip);
8010192a:	e9 a1 fe ff ff       	jmp    801017d0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 2c             	sub    $0x2c,%esp
80101969:	8b 45 0c             	mov    0xc(%ebp),%eax
8010196c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010196f:	8b 75 10             	mov    0x10(%ebp),%esi
80101972:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101975:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101978:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
8010197d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101980:	0f 84 aa 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101986:	8b 47 58             	mov    0x58(%edi),%eax
80101989:	39 f0                	cmp    %esi,%eax
8010198b:	0f 82 c7 00 00 00    	jb     80101a58 <readi+0xf8>
80101991:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101994:	89 da                	mov    %ebx,%edx
80101996:	01 f2                	add    %esi,%edx
80101998:	0f 82 ba 00 00 00    	jb     80101a58 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010199e:	89 c1                	mov    %eax,%ecx
801019a0:	29 f1                	sub    %esi,%ecx
801019a2:	39 d0                	cmp    %edx,%eax
801019a4:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019a7:	31 c0                	xor    %eax,%eax
801019a9:	85 c9                	test   %ecx,%ecx
    n = ip->size - off;
801019ab:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ae:	74 70                	je     80101a20 <readi+0xc0>
801019b0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801019b3:	89 c7                	mov    %eax,%edi
801019b5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019b8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019bb:	89 f2                	mov    %esi,%edx
801019bd:	c1 ea 09             	shr    $0x9,%edx
801019c0:	89 d8                	mov    %ebx,%eax
801019c2:	e8 99 f9 ff ff       	call   80101360 <bmap>
801019c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801019cb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019cd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d2:	89 04 24             	mov    %eax,(%esp)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801019dd:	29 f9                	sub    %edi,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019df:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019e1:	89 f0                	mov    %esi,%eax
801019e3:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e8:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019ea:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019ee:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801019f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fa:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019fe:	01 df                	add    %ebx,%edi
80101a00:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101a05:	89 04 24             	mov    %eax,(%esp)
80101a08:	e8 f3 29 00 00       	call   80104400 <memmove>
    brelse(bp);
80101a0d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a10:	89 14 24             	mov    %edx,(%esp)
80101a13:	e8 c8 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a18:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a1e:	77 98                	ja     801019b8 <readi+0x58>
  }
  return n;
80101a20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a23:	83 c4 2c             	add    $0x2c,%esp
80101a26:	5b                   	pop    %ebx
80101a27:	5e                   	pop    %esi
80101a28:	5f                   	pop    %edi
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 1e                	ja     80101a58 <readi+0xf8>
80101a3a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 13                	je     80101a58 <readi+0xf8>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101a48:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a4b:	83 c4 2c             	add    $0x2c,%esp
80101a4e:	5b                   	pop    %ebx
80101a4f:	5e                   	pop    %esi
80101a50:	5f                   	pop    %edi
80101a51:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a52:	ff e0                	jmp    *%eax
80101a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a5d:	eb c4                	jmp    80101a23 <readi+0xc3>
80101a5f:	90                   	nop

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 2c             	sub    $0x2c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	8b 75 10             	mov    0x10(%ebp),%esi
80101a7d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a80:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 e3 00 00 00    	jb     80101b78 <writei+0x118>
80101a95:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a98:	89 c8                	mov    %ecx,%eax
80101a9a:	01 f0                	add    %esi,%eax
80101a9c:	0f 82 d6 00 00 00    	jb     80101b78 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa2:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa7:	0f 87 cb 00 00 00    	ja     80101b78 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aad:	85 c9                	test   %ecx,%ecx
80101aaf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ab6:	74 77                	je     80101b2f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101abb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101abd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac2:	c1 ea 09             	shr    $0x9,%edx
80101ac5:	89 f8                	mov    %edi,%eax
80101ac7:	e8 94 f8 ff ff       	call   80101360 <bmap>
80101acc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ad0:	8b 07                	mov    (%edi),%eax
80101ad2:	89 04 24             	mov    %eax,(%esp)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101add:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ae0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae3:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae5:	89 f0                	mov    %esi,%eax
80101ae7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101aec:	29 c3                	sub    %eax,%ebx
80101aee:	39 cb                	cmp    %ecx,%ebx
80101af0:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af7:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101af9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101afd:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b01:	89 04 24             	mov    %eax,(%esp)
80101b04:	e8 f7 28 00 00       	call   80104400 <memmove>
    log_write(bp);
80101b09:	89 3c 24             	mov    %edi,(%esp)
80101b0c:	e8 9f 11 00 00       	call   80102cb0 <log_write>
    brelse(bp);
80101b11:	89 3c 24             	mov    %edi,(%esp)
80101b14:	e8 c7 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b19:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b1f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b22:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b25:	77 91                	ja     80101ab8 <writei+0x58>
  }

  if(n > 0 && off > ip->size){
80101b27:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2a:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2d:	72 39                	jb     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b32:	83 c4 2c             	add    $0x2c,%esp
80101b35:	5b                   	pop    %ebx
80101b36:	5e                   	pop    %esi
80101b37:	5f                   	pop    %edi
80101b38:	5d                   	pop    %ebp
80101b39:	c3                   	ret    
80101b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 2e                	ja     80101b78 <writei+0x118>
80101b4a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 23                	je     80101b78 <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b58:	83 c4 2c             	add    $0x2c,%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b6e:	89 04 24             	mov    %eax,(%esp)
80101b71:	e8 7a fa ff ff       	call   801015f0 <iupdate>
80101b76:	eb b7                	jmp    80101b2f <writei+0xcf>
}
80101b78:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80101b7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101b80:	5b                   	pop    %ebx
80101b81:	5e                   	pop    %esi
80101b82:	5f                   	pop    %edi
80101b83:	5d                   	pop    %ebp
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b99:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ba0:	00 
80101ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba8:	89 04 24             	mov    %eax,(%esp)
80101bab:	e8 d0 28 00 00       	call   80104480 <strncmp>
}
80101bb0:	c9                   	leave  
80101bb1:	c3                   	ret    
80101bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 2c             	sub    $0x2c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 97 00 00 00    	jne    80101c6e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	75 0d                	jne    80101bf0 <dirlookup+0x30>
80101be3:	eb 73                	jmp    80101c58 <dirlookup+0x98>
80101be5:	8d 76 00             	lea    0x0(%esi),%esi
80101be8:	83 c7 10             	add    $0x10,%edi
80101beb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bee:	76 68                	jbe    80101c58 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101bf7:	00 
80101bf8:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101bfc:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c00:	89 1c 24             	mov    %ebx,(%esp)
80101c03:	e8 58 fd ff ff       	call   80101960 <readi>
80101c08:	83 f8 10             	cmp    $0x10,%eax
80101c0b:	75 55                	jne    80101c62 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c12:	74 d4                	je     80101be8 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101c14:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c17:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c1e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c25:	00 
80101c26:	89 04 24             	mov    %eax,(%esp)
80101c29:	e8 52 28 00 00       	call   80104480 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c2e:	85 c0                	test   %eax,%eax
80101c30:	75 b6                	jne    80101be8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c32:	8b 45 10             	mov    0x10(%ebp),%eax
80101c35:	85 c0                	test   %eax,%eax
80101c37:	74 05                	je     80101c3e <dirlookup+0x7e>
        *poff = off;
80101c39:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c42:	8b 03                	mov    (%ebx),%eax
80101c44:	e8 57 f6 ff ff       	call   801012a0 <iget>
    }
  }

  return 0;
}
80101c49:	83 c4 2c             	add    $0x2c,%esp
80101c4c:	5b                   	pop    %ebx
80101c4d:	5e                   	pop    %esi
80101c4e:	5f                   	pop    %edi
80101c4f:	5d                   	pop    %ebp
80101c50:	c3                   	ret    
80101c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c58:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101c5b:	31 c0                	xor    %eax,%eax
}
80101c5d:	5b                   	pop    %ebx
80101c5e:	5e                   	pop    %esi
80101c5f:	5f                   	pop    %edi
80101c60:	5d                   	pop    %ebp
80101c61:	c3                   	ret    
      panic("dirlookup read");
80101c62:	c7 04 24 19 6e 10 80 	movl   $0x80106e19,(%esp)
80101c69:	e8 f2 e6 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101c6e:	c7 04 24 07 6e 10 80 	movl   $0x80106e07,(%esp)
80101c75:	e8 e6 e6 ff ff       	call   80100360 <panic>
80101c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	89 cf                	mov    %ecx,%edi
80101c86:	56                   	push   %esi
80101c87:	53                   	push   %ebx
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 51 01 00 00    	je     80101dea <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 02 1a 00 00       	call   801036a0 <myproc>
80101c9e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ca1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ca8:	e8 f3 25 00 00       	call   801042a0 <acquire>
  ip->ref++;
80101cad:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cb8:	e8 53 26 00 00       	call   80104310 <release>
80101cbd:	eb 04                	jmp    80101cc3 <namex+0x43>
80101cbf:	90                   	nop
    path++;
80101cc0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cc3:	0f b6 03             	movzbl (%ebx),%eax
80101cc6:	3c 2f                	cmp    $0x2f,%al
80101cc8:	74 f6                	je     80101cc0 <namex+0x40>
  if(*path == 0)
80101cca:	84 c0                	test   %al,%al
80101ccc:	0f 84 ed 00 00 00    	je     80101dbf <namex+0x13f>
  while(*path != '/' && *path != 0)
80101cd2:	0f b6 03             	movzbl (%ebx),%eax
80101cd5:	89 da                	mov    %ebx,%edx
80101cd7:	84 c0                	test   %al,%al
80101cd9:	0f 84 b1 00 00 00    	je     80101d90 <namex+0x110>
80101cdf:	3c 2f                	cmp    $0x2f,%al
80101ce1:	75 0f                	jne    80101cf2 <namex+0x72>
80101ce3:	e9 a8 00 00 00       	jmp    80101d90 <namex+0x110>
80101ce8:	3c 2f                	cmp    $0x2f,%al
80101cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101cf0:	74 0a                	je     80101cfc <namex+0x7c>
    path++;
80101cf2:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf5:	0f b6 02             	movzbl (%edx),%eax
80101cf8:	84 c0                	test   %al,%al
80101cfa:	75 ec                	jne    80101ce8 <namex+0x68>
80101cfc:	89 d1                	mov    %edx,%ecx
80101cfe:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d00:	83 f9 0d             	cmp    $0xd,%ecx
80101d03:	0f 8e 8f 00 00 00    	jle    80101d98 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d0d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d14:	00 
80101d15:	89 3c 24             	mov    %edi,(%esp)
80101d18:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d1b:	e8 e0 26 00 00       	call   80104400 <memmove>
    path++;
80101d20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d23:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d25:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d28:	75 0e                	jne    80101d38 <namex+0xb8>
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	89 34 24             	mov    %esi,(%esp)
80101d3b:	e8 70 f9 ff ff       	call   801016b0 <ilock>
    if(ip->type != T_DIR){
80101d40:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d45:	0f 85 85 00 00 00    	jne    80101dd0 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d4e:	85 d2                	test   %edx,%edx
80101d50:	74 09                	je     80101d5b <namex+0xdb>
80101d52:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d55:	0f 84 a5 00 00 00    	je     80101e00 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d62:	00 
80101d63:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d67:	89 34 24             	mov    %esi,(%esp)
80101d6a:	e8 51 fe ff ff       	call   80101bc0 <dirlookup>
80101d6f:	85 c0                	test   %eax,%eax
80101d71:	74 5d                	je     80101dd0 <namex+0x150>
  iunlock(ip);
80101d73:	89 34 24             	mov    %esi,(%esp)
80101d76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d79:	e8 12 fa ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 4a fa ff ff       	call   801017d0 <iput>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	89 c6                	mov    %eax,%esi
80101d8b:	e9 33 ff ff ff       	jmp    80101cc3 <namex+0x43>
  while(*path != '/' && *path != 0)
80101d90:	31 c9                	xor    %ecx,%ecx
80101d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101d98:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101d9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101da0:	89 3c 24             	mov    %edi,(%esp)
80101da3:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da9:	e8 52 26 00 00       	call   80104400 <memmove>
    name[len] = 0;
80101dae:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101db8:	89 d3                	mov    %edx,%ebx
80101dba:	e9 66 ff ff ff       	jmp    80101d25 <namex+0xa5>
  }
  if(nameiparent){
80101dbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dc2:	85 c0                	test   %eax,%eax
80101dc4:	75 4c                	jne    80101e12 <namex+0x192>
80101dc6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101dc8:	83 c4 2c             	add    $0x2c,%esp
80101dcb:	5b                   	pop    %ebx
80101dcc:	5e                   	pop    %esi
80101dcd:	5f                   	pop    %edi
80101dce:	5d                   	pop    %ebp
80101dcf:	c3                   	ret    
  iunlock(ip);
80101dd0:	89 34 24             	mov    %esi,(%esp)
80101dd3:	e8 b8 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101dd8:	89 34 24             	mov    %esi,(%esp)
80101ddb:	e8 f0 f9 ff ff       	call   801017d0 <iput>
}
80101de0:	83 c4 2c             	add    $0x2c,%esp
      return 0;
80101de3:	31 c0                	xor    %eax,%eax
}
80101de5:	5b                   	pop    %ebx
80101de6:	5e                   	pop    %esi
80101de7:	5f                   	pop    %edi
80101de8:	5d                   	pop    %ebp
80101de9:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101dea:	ba 01 00 00 00       	mov    $0x1,%edx
80101def:	b8 01 00 00 00       	mov    $0x1,%eax
80101df4:	e8 a7 f4 ff ff       	call   801012a0 <iget>
80101df9:	89 c6                	mov    %eax,%esi
80101dfb:	e9 c3 fe ff ff       	jmp    80101cc3 <namex+0x43>
      iunlock(ip);
80101e00:	89 34 24             	mov    %esi,(%esp)
80101e03:	e8 88 f9 ff ff       	call   80101790 <iunlock>
}
80101e08:	83 c4 2c             	add    $0x2c,%esp
      return ip;
80101e0b:	89 f0                	mov    %esi,%eax
}
80101e0d:	5b                   	pop    %ebx
80101e0e:	5e                   	pop    %esi
80101e0f:	5f                   	pop    %edi
80101e10:	5d                   	pop    %ebp
80101e11:	c3                   	ret    
    iput(ip);
80101e12:	89 34 24             	mov    %esi,(%esp)
80101e15:	e8 b6 f9 ff ff       	call   801017d0 <iput>
    return 0;
80101e1a:	31 c0                	xor    %eax,%eax
80101e1c:	eb aa                	jmp    80101dc8 <namex+0x148>
80101e1e:	66 90                	xchg   %ax,%ax

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 2c             	sub    $0x2c,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e2f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e36:	00 
80101e37:	89 1c 24             	mov    %ebx,(%esp)
80101e3a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e3e:	e8 7d fd ff ff       	call   80101bc0 <dirlookup>
80101e43:	85 c0                	test   %eax,%eax
80101e45:	0f 85 8b 00 00 00    	jne    80101ed6 <dirlink+0xb6>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e4e:	31 ff                	xor    %edi,%edi
80101e50:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e53:	85 c0                	test   %eax,%eax
80101e55:	75 13                	jne    80101e6a <dirlink+0x4a>
80101e57:	eb 35                	jmp    80101e8e <dirlink+0x6e>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e60:	8d 57 10             	lea    0x10(%edi),%edx
80101e63:	39 53 58             	cmp    %edx,0x58(%ebx)
80101e66:	89 d7                	mov    %edx,%edi
80101e68:	76 24                	jbe    80101e8e <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101e71:	00 
80101e72:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101e76:	89 74 24 04          	mov    %esi,0x4(%esp)
80101e7a:	89 1c 24             	mov    %ebx,(%esp)
80101e7d:	e8 de fa ff ff       	call   80101960 <readi>
80101e82:	83 f8 10             	cmp    $0x10,%eax
80101e85:	75 5e                	jne    80101ee5 <dirlink+0xc5>
    if(de.inum == 0)
80101e87:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8c:	75 d2                	jne    80101e60 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e91:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e98:	00 
80101e99:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e9d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea0:	89 04 24             	mov    %eax,(%esp)
80101ea3:	e8 48 26 00 00       	call   801044f0 <strncpy>
  de.inum = inum;
80101ea8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eab:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101eb2:	00 
80101eb3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101eb7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ebb:	89 1c 24             	mov    %ebx,(%esp)
  de.inum = inum;
80101ebe:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec2:	e8 99 fb ff ff       	call   80101a60 <writei>
80101ec7:	83 f8 10             	cmp    $0x10,%eax
80101eca:	75 25                	jne    80101ef1 <dirlink+0xd1>
  return 0;
80101ecc:	31 c0                	xor    %eax,%eax
}
80101ece:	83 c4 2c             	add    $0x2c,%esp
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
    iput(ip);
80101ed6:	89 04 24             	mov    %eax,(%esp)
80101ed9:	e8 f2 f8 ff ff       	call   801017d0 <iput>
    return -1;
80101ede:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee3:	eb e9                	jmp    80101ece <dirlink+0xae>
      panic("dirlink read");
80101ee5:	c7 04 24 28 6e 10 80 	movl   $0x80106e28,(%esp)
80101eec:	e8 6f e4 ff ff       	call   80100360 <panic>
    panic("dirlink");
80101ef1:	c7 04 24 82 74 10 80 	movl   $0x80107482,(%esp)
80101ef8:	e8 63 e4 ff ff       	call   80100360 <panic>
80101efd:	8d 76 00             	lea    0x0(%esi),%esi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 6d fd ff ff       	call   80101c80 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 4c fd ff ff       	jmp    80101c80 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	56                   	push   %esi
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	53                   	push   %ebx
80101f47:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f4a:	85 c0                	test   %eax,%eax
80101f4c:	0f 84 99 00 00 00    	je     80101feb <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f52:	8b 48 08             	mov    0x8(%eax),%ecx
80101f55:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101f5b:	0f 87 7e 00 00 00    	ja     80101fdf <idestart+0x9f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f61:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f69:	83 e0 c0             	and    $0xffffffc0,%eax
80101f6c:	3c 40                	cmp    $0x40,%al
80101f6e:	75 f8                	jne    80101f68 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f70:	31 db                	xor    %ebx,%ebx
80101f72:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ee                   	out    %al,(%dx)
80101f7a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f84:	ee                   	out    %al,(%dx)
80101f85:	0f b6 c1             	movzbl %cl,%eax
80101f88:	b2 f3                	mov    $0xf3,%dl
80101f8a:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f8b:	89 c8                	mov    %ecx,%eax
80101f8d:	b2 f4                	mov    $0xf4,%dl
80101f8f:	c1 f8 08             	sar    $0x8,%eax
80101f92:	ee                   	out    %al,(%dx)
80101f93:	b2 f5                	mov    $0xf5,%dl
80101f95:	89 d8                	mov    %ebx,%eax
80101f97:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f98:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9c:	b2 f6                	mov    $0xf6,%dl
80101f9e:	83 e0 01             	and    $0x1,%eax
80101fa1:	c1 e0 04             	shl    $0x4,%eax
80101fa4:	83 c8 e0             	or     $0xffffffe0,%eax
80101fa7:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fa8:	f6 06 04             	testb  $0x4,(%esi)
80101fab:	75 13                	jne    80101fc0 <idestart+0x80>
80101fad:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fb8:	83 c4 10             	add    $0x10,%esp
80101fbb:	5b                   	pop    %ebx
80101fbc:	5e                   	pop    %esi
80101fbd:	5d                   	pop    %ebp
80101fbe:	c3                   	ret    
80101fbf:	90                   	nop
80101fc0:	b2 f7                	mov    $0xf7,%dl
80101fc2:	b8 30 00 00 00       	mov    $0x30,%eax
80101fc7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fcd:	83 c6 5c             	add    $0x5c,%esi
80101fd0:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fd5:	fc                   	cld    
80101fd6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd8:	83 c4 10             	add    $0x10,%esp
80101fdb:	5b                   	pop    %ebx
80101fdc:	5e                   	pop    %esi
80101fdd:	5d                   	pop    %ebp
80101fde:	c3                   	ret    
    panic("incorrect blockno");
80101fdf:	c7 04 24 94 6e 10 80 	movl   $0x80106e94,(%esp)
80101fe6:	e8 75 e3 ff ff       	call   80100360 <panic>
    panic("idestart");
80101feb:	c7 04 24 8b 6e 10 80 	movl   $0x80106e8b,(%esp)
80101ff2:	e8 69 e3 ff ff       	call   80100360 <panic>
80101ff7:	89 f6                	mov    %esi,%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80102006:	c7 44 24 04 a6 6e 10 	movl   $0x80106ea6,0x4(%esp)
8010200d:	80 
8010200e:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102015:	e8 16 21 00 00       	call   80104130 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010201a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010201f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102026:	83 e8 01             	sub    $0x1,%eax
80102029:	89 44 24 04          	mov    %eax,0x4(%esp)
8010202d:	e8 7e 02 00 00       	call   801022b0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102032:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102037:	90                   	nop
80102038:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102039:	83 e0 c0             	and    $0xffffffc0,%eax
8010203c:	3c 40                	cmp    $0x40,%al
8010203e:	75 f8                	jne    80102038 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102040:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102045:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204a:	ee                   	out    %al,(%dx)
8010204b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102050:	b2 f7                	mov    $0xf7,%dl
80102052:	eb 09                	jmp    8010205d <ideinit+0x5d>
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102058:	83 e9 01             	sub    $0x1,%ecx
8010205b:	74 0f                	je     8010206c <ideinit+0x6c>
8010205d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010205e:	84 c0                	test   %al,%al
80102060:	74 f6                	je     80102058 <ideinit+0x58>
      havedisk1 = 1;
80102062:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102069:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010206c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102071:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102076:	ee                   	out    %al,(%dx)
}
80102077:	c9                   	leave  
80102078:	c3                   	ret    
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102090:	e8 0b 22 00 00       	call   801042a0 <acquire>

  if((b = idequeue) == 0){
80102095:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
8010209b:	85 db                	test   %ebx,%ebx
8010209d:	74 30                	je     801020cf <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010209f:	8b 43 58             	mov    0x58(%ebx),%eax
801020a2:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a7:	8b 33                	mov    (%ebx),%esi
801020a9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020af:	74 37                	je     801020e8 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020b1:	83 e6 fb             	and    $0xfffffffb,%esi
801020b4:	83 ce 02             	or     $0x2,%esi
801020b7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020b9:	89 1c 24             	mov    %ebx,(%esp)
801020bc:	e8 cf 1c 00 00       	call   80103d90 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020c1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020c6:	85 c0                	test   %eax,%eax
801020c8:	74 05                	je     801020cf <ideintr+0x4f>
    idestart(idequeue);
801020ca:	e8 71 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
801020cf:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020d6:	e8 35 22 00 00       	call   80104310 <release>

  release(&idelock);
}
801020db:	83 c4 1c             	add    $0x1c,%esp
801020de:	5b                   	pop    %ebx
801020df:	5e                   	pop    %esi
801020e0:	5f                   	pop    %edi
801020e1:	5d                   	pop    %ebp
801020e2:	c3                   	ret    
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ed:	8d 76 00             	lea    0x0(%esi),%esi
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	89 c1                	mov    %eax,%ecx
801020f3:	83 e1 c0             	and    $0xffffffc0,%ecx
801020f6:	80 f9 40             	cmp    $0x40,%cl
801020f9:	75 f5                	jne    801020f0 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020fb:	a8 21                	test   $0x21,%al
801020fd:	75 b2                	jne    801020b1 <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
801020ff:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102102:	b9 80 00 00 00       	mov    $0x80,%ecx
80102107:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210c:	fc                   	cld    
8010210d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010210f:	8b 33                	mov    (%ebx),%esi
80102111:	eb 9e                	jmp    801020b1 <ideintr+0x31>
80102113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 14             	sub    $0x14,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	89 04 24             	mov    %eax,(%esp)
80102130:	e8 ab 1f 00 00       	call   801040e0 <holdingsleep>
80102135:	85 c0                	test   %eax,%eax
80102137:	0f 84 9e 00 00 00    	je     801021db <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213d:	8b 03                	mov    (%ebx),%eax
8010213f:	83 e0 06             	and    $0x6,%eax
80102142:	83 f8 02             	cmp    $0x2,%eax
80102145:	0f 84 a8 00 00 00    	je     801021f3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214b:	8b 53 04             	mov    0x4(%ebx),%edx
8010214e:	85 d2                	test   %edx,%edx
80102150:	74 0d                	je     8010215f <iderw+0x3f>
80102152:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102157:	85 c0                	test   %eax,%eax
80102159:	0f 84 88 00 00 00    	je     801021e7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010215f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102166:	e8 35 21 00 00       	call   801042a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
80102170:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102177:	85 c0                	test   %eax,%eax
80102179:	75 07                	jne    80102182 <iderw+0x62>
8010217b:	eb 4e                	jmp    801021cb <iderw+0xab>
8010217d:	8d 76 00             	lea    0x0(%esi),%esi
80102180:	89 d0                	mov    %edx,%eax
80102182:	8b 50 58             	mov    0x58(%eax),%edx
80102185:	85 d2                	test   %edx,%edx
80102187:	75 f7                	jne    80102180 <iderw+0x60>
80102189:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
8010218c:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
8010218e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102194:	74 3c                	je     801021d2 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102196:	8b 03                	mov    (%ebx),%eax
80102198:	83 e0 06             	and    $0x6,%eax
8010219b:	83 f8 02             	cmp    $0x2,%eax
8010219e:	74 1a                	je     801021ba <iderw+0x9a>
    sleep(b, &idelock);
801021a0:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801021a7:	80 
801021a8:	89 1c 24             	mov    %ebx,(%esp)
801021ab:	e8 50 1a 00 00       	call   80103c00 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021b0:	8b 13                	mov    (%ebx),%edx
801021b2:	83 e2 06             	and    $0x6,%edx
801021b5:	83 fa 02             	cmp    $0x2,%edx
801021b8:	75 e6                	jne    801021a0 <iderw+0x80>
  }


  release(&idelock);
801021ba:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021c1:	83 c4 14             	add    $0x14,%esp
801021c4:	5b                   	pop    %ebx
801021c5:	5d                   	pop    %ebp
  release(&idelock);
801021c6:	e9 45 21 00 00       	jmp    80104310 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021cb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
801021d0:	eb ba                	jmp    8010218c <iderw+0x6c>
    idestart(b);
801021d2:	89 d8                	mov    %ebx,%eax
801021d4:	e8 67 fd ff ff       	call   80101f40 <idestart>
801021d9:	eb bb                	jmp    80102196 <iderw+0x76>
    panic("iderw: buf not locked");
801021db:	c7 04 24 aa 6e 10 80 	movl   $0x80106eaa,(%esp)
801021e2:	e8 79 e1 ff ff       	call   80100360 <panic>
    panic("iderw: ide disk 1 not present");
801021e7:	c7 04 24 d5 6e 10 80 	movl   $0x80106ed5,(%esp)
801021ee:	e8 6d e1 ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
801021f3:	c7 04 24 c0 6e 10 80 	movl   $0x80106ec0,(%esp)
801021fa:	e8 61 e1 ff ff       	call   80100360 <panic>
801021ff:	90                   	nop

80102200 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	56                   	push   %esi
80102204:	53                   	push   %ebx
80102205:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102208:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010220f:	00 c0 fe 
  ioapic->reg = reg;
80102212:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102219:	00 00 00 
  return ioapic->data;
8010221c:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102222:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
80102225:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010222b:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102231:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102238:	c1 e8 10             	shr    $0x10,%eax
8010223b:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010223e:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102241:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102244:	39 c2                	cmp    %eax,%edx
80102246:	74 12                	je     8010225a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102248:	c7 04 24 f4 6e 10 80 	movl   $0x80106ef4,(%esp)
8010224f:	e8 fc e3 ff ff       	call   80100650 <cprintf>
80102254:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010225a:	ba 10 00 00 00       	mov    $0x10,%edx
8010225f:	31 c0                	xor    %eax,%eax
80102261:	eb 07                	jmp    8010226a <ioapicinit+0x6a>
80102263:	90                   	nop
80102264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102268:	89 cb                	mov    %ecx,%ebx
  ioapic->reg = reg;
8010226a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010226c:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102272:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102275:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  for(i = 0; i <= maxintr; i++){
8010227b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010227e:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102281:	8d 4a 01             	lea    0x1(%edx),%ecx
80102284:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102287:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102289:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010228f:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
80102291:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
80102298:	7d ce                	jge    80102268 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010229a:	83 c4 10             	add    $0x10,%esp
8010229d:	5b                   	pop    %ebx
8010229e:	5e                   	pop    %esi
8010229f:	5d                   	pop    %ebp
801022a0:	c3                   	ret    
801022a1:	eb 0d                	jmp    801022b0 <ioapicenable>
801022a3:	90                   	nop
801022a4:	90                   	nop
801022a5:	90                   	nop
801022a6:	90                   	nop
801022a7:	90                   	nop
801022a8:	90                   	nop
801022a9:	90                   	nop
801022aa:	90                   	nop
801022ab:	90                   	nop
801022ac:	90                   	nop
801022ad:	90                   	nop
801022ae:	90                   	nop
801022af:	90                   	nop

801022b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	8b 55 08             	mov    0x8(%ebp),%edx
801022b6:	53                   	push   %ebx
801022b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ba:	8d 5a 20             	lea    0x20(%edx),%ebx
801022bd:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
  ioapic->reg = reg;
801022c1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022c7:	c1 e0 18             	shl    $0x18,%eax
  ioapic->reg = reg;
801022ca:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022cc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022d2:	83 c1 01             	add    $0x1,%ecx
  ioapic->data = data;
801022d5:	89 5a 10             	mov    %ebx,0x10(%edx)
  ioapic->reg = reg;
801022d8:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022da:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022e0:	89 42 10             	mov    %eax,0x10(%edx)
}
801022e3:	5b                   	pop    %ebx
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	66 90                	xchg   %ax,%ax
801022e8:	66 90                	xchg   %ax,%ax
801022ea:	66 90                	xchg   %ax,%ax
801022ec:	66 90                	xchg   %ax,%ax
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	53                   	push   %ebx
801022f4:	83 ec 14             	sub    $0x14,%esp
801022f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801022fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102300:	75 7c                	jne    8010237e <kfree+0x8e>
80102302:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
80102308:	72 74                	jb     8010237e <kfree+0x8e>
8010230a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102310:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102315:	77 67                	ja     8010237e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102317:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010231e:	00 
8010231f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102326:	00 
80102327:	89 1c 24             	mov    %ebx,(%esp)
8010232a:	e8 31 20 00 00       	call   80104360 <memset>

  if(kmem.use_lock)
8010232f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102335:	85 d2                	test   %edx,%edx
80102337:	75 37                	jne    80102370 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102339:	a1 78 26 11 80       	mov    0x80112678,%eax
8010233e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102340:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102345:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
8010234b:	85 c0                	test   %eax,%eax
8010234d:	75 09                	jne    80102358 <kfree+0x68>
    release(&kmem.lock);
}
8010234f:	83 c4 14             	add    $0x14,%esp
80102352:	5b                   	pop    %ebx
80102353:	5d                   	pop    %ebp
80102354:	c3                   	ret    
80102355:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102358:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010235f:	83 c4 14             	add    $0x14,%esp
80102362:	5b                   	pop    %ebx
80102363:	5d                   	pop    %ebp
    release(&kmem.lock);
80102364:	e9 a7 1f 00 00       	jmp    80104310 <release>
80102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102370:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102377:	e8 24 1f 00 00       	call   801042a0 <acquire>
8010237c:	eb bb                	jmp    80102339 <kfree+0x49>
    panic("kfree");
8010237e:	c7 04 24 26 6f 10 80 	movl   $0x80106f26,(%esp)
80102385:	e8 d6 df ff ff       	call   80100360 <panic>
8010238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102390 <freerange>:
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	56                   	push   %esi
80102394:	53                   	push   %ebx
80102395:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102398:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010239b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010239e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801023a4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023aa:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801023b0:	39 de                	cmp    %ebx,%esi
801023b2:	73 08                	jae    801023bc <freerange+0x2c>
801023b4:	eb 18                	jmp    801023ce <freerange+0x3e>
801023b6:	66 90                	xchg   %ax,%ax
801023b8:	89 da                	mov    %ebx,%edx
801023ba:	89 c3                	mov    %eax,%ebx
    kfree(p);
801023bc:	89 14 24             	mov    %edx,(%esp)
801023bf:	e8 2c ff ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023c4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801023ca:	39 f0                	cmp    %esi,%eax
801023cc:	76 ea                	jbe    801023b8 <freerange+0x28>
}
801023ce:	83 c4 10             	add    $0x10,%esp
801023d1:	5b                   	pop    %ebx
801023d2:	5e                   	pop    %esi
801023d3:	5d                   	pop    %ebp
801023d4:	c3                   	ret    
801023d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023e0 <kinit1>:
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	56                   	push   %esi
801023e4:	53                   	push   %ebx
801023e5:	83 ec 10             	sub    $0x10,%esp
801023e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801023eb:	c7 44 24 04 2c 6f 10 	movl   $0x80106f2c,0x4(%esp)
801023f2:	80 
801023f3:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801023fa:	e8 31 1d 00 00       	call   80104130 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801023ff:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102402:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102409:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010240c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102412:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102418:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010241e:	39 de                	cmp    %ebx,%esi
80102420:	73 0a                	jae    8010242c <kinit1+0x4c>
80102422:	eb 1a                	jmp    8010243e <kinit1+0x5e>
80102424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102428:	89 da                	mov    %ebx,%edx
8010242a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010242c:	89 14 24             	mov    %edx,(%esp)
8010242f:	e8 bc fe ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102434:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010243a:	39 c6                	cmp    %eax,%esi
8010243c:	73 ea                	jae    80102428 <kinit1+0x48>
}
8010243e:	83 c4 10             	add    $0x10,%esp
80102441:	5b                   	pop    %ebx
80102442:	5e                   	pop    %esi
80102443:	5d                   	pop    %ebp
80102444:	c3                   	ret    
80102445:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102450 <kinit2>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102458:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010245b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010245e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102464:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010246a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 08                	jae    8010247c <kinit2+0x2c>
80102474:	eb 18                	jmp    8010248e <kinit2+0x3e>
80102476:	66 90                	xchg   %ax,%ax
80102478:	89 da                	mov    %ebx,%edx
8010247a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010247c:	89 14 24             	mov    %edx,(%esp)
8010247f:	e8 6c fe ff ff       	call   801022f0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102484:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010248a:	39 c6                	cmp    %eax,%esi
8010248c:	73 ea                	jae    80102478 <kinit2+0x28>
  kmem.use_lock = 1;
8010248e:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102495:	00 00 00 
}
80102498:	83 c4 10             	add    $0x10,%esp
8010249b:	5b                   	pop    %ebx
8010249c:	5e                   	pop    %esi
8010249d:	5d                   	pop    %ebp
8010249e:	c3                   	ret    
8010249f:	90                   	nop

801024a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
801024a7:	a1 74 26 11 80       	mov    0x80112674,%eax
801024ac:	85 c0                	test   %eax,%eax
801024ae:	75 30                	jne    801024e0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024b0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
801024b6:	85 db                	test   %ebx,%ebx
801024b8:	74 08                	je     801024c2 <kalloc+0x22>
    kmem.freelist = r->next;
801024ba:	8b 13                	mov    (%ebx),%edx
801024bc:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
801024c2:	85 c0                	test   %eax,%eax
801024c4:	74 0c                	je     801024d2 <kalloc+0x32>
    release(&kmem.lock);
801024c6:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024cd:	e8 3e 1e 00 00       	call   80104310 <release>
  return (char*)r;
}
801024d2:	83 c4 14             	add    $0x14,%esp
801024d5:	89 d8                	mov    %ebx,%eax
801024d7:	5b                   	pop    %ebx
801024d8:	5d                   	pop    %ebp
801024d9:	c3                   	ret    
801024da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
801024e0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024e7:	e8 b4 1d 00 00       	call   801042a0 <acquire>
801024ec:	a1 74 26 11 80       	mov    0x80112674,%eax
801024f1:	eb bd                	jmp    801024b0 <kalloc+0x10>
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 ba 00 00 00    	je     801025c8 <kbdgetc+0xc8>
8010250e:	b2 60                	mov    $0x60,%dl
80102510:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102511:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102514:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010251a:	0f 84 88 00 00 00    	je     801025a8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102520:	84 c0                	test   %al,%al
80102522:	79 2c                	jns    80102550 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102524:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010252a:	f6 c2 40             	test   $0x40,%dl
8010252d:	75 05                	jne    80102534 <kbdgetc+0x34>
8010252f:	89 c1                	mov    %eax,%ecx
80102531:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102534:	0f b6 81 60 70 10 80 	movzbl -0x7fef8fa0(%ecx),%eax
8010253b:	83 c8 40             	or     $0x40,%eax
8010253e:	0f b6 c0             	movzbl %al,%eax
80102541:	f7 d0                	not    %eax
80102543:	21 d0                	and    %edx,%eax
80102545:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010254a:	31 c0                	xor    %eax,%eax
8010254c:	c3                   	ret    
8010254d:	8d 76 00             	lea    0x0(%esi),%esi
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	53                   	push   %ebx
80102554:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  } else if(shift & E0ESC){
8010255a:	f6 c3 40             	test   $0x40,%bl
8010255d:	74 09                	je     80102568 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010255f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102562:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102565:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102568:	0f b6 91 60 70 10 80 	movzbl -0x7fef8fa0(%ecx),%edx
  shift ^= togglecode[data];
8010256f:	0f b6 81 60 6f 10 80 	movzbl -0x7fef90a0(%ecx),%eax
  shift |= shiftcode[data];
80102576:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102578:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010257a:	89 d0                	mov    %edx,%eax
8010257c:	83 e0 03             	and    $0x3,%eax
8010257f:	8b 04 85 40 6f 10 80 	mov    -0x7fef90c0(,%eax,4),%eax
  shift ^= togglecode[data];
80102586:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  if(shift & CAPSLOCK){
8010258c:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010258f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102593:	74 0b                	je     801025a0 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102595:	8d 50 9f             	lea    -0x61(%eax),%edx
80102598:	83 fa 19             	cmp    $0x19,%edx
8010259b:	77 1b                	ja     801025b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010259d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025a0:	5b                   	pop    %ebx
801025a1:	5d                   	pop    %ebp
801025a2:	c3                   	ret    
801025a3:	90                   	nop
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025a8:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025af:	31 c0                	xor    %eax,%eax
801025b1:	c3                   	ret    
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801025b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025bb:	8d 50 20             	lea    0x20(%eax),%edx
801025be:	83 f9 19             	cmp    $0x19,%ecx
801025c1:	0f 46 c2             	cmovbe %edx,%eax
  return c;
801025c4:	eb da                	jmp    801025a0 <kbdgetc+0xa0>
801025c6:	66 90                	xchg   %ax,%ax
    return -1;
801025c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax

801025d0 <kbdintr>:

void
kbdintr(void)
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801025d6:	c7 04 24 00 25 10 80 	movl   $0x80102500,(%esp)
801025dd:	e8 ce e1 ff ff       	call   801007b0 <consoleintr>
}
801025e2:	c9                   	leave  
801025e3:	c3                   	ret    
801025e4:	66 90                	xchg   %ax,%ax
801025e6:	66 90                	xchg   %ax,%ax
801025e8:	66 90                	xchg   %ax,%ax
801025ea:	66 90                	xchg   %ax,%ax
801025ec:	66 90                	xchg   %ax,%ax
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
801025f0:	55                   	push   %ebp
801025f1:	89 c1                	mov    %eax,%ecx
801025f3:	89 e5                	mov    %esp,%ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025f5:	ba 70 00 00 00       	mov    $0x70,%edx
801025fa:	53                   	push   %ebx
801025fb:	31 c0                	xor    %eax,%eax
801025fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025fe:	bb 71 00 00 00       	mov    $0x71,%ebx
80102603:	89 da                	mov    %ebx,%edx
80102605:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102606:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102609:	b2 70                	mov    $0x70,%dl
8010260b:	89 01                	mov    %eax,(%ecx)
8010260d:	b8 02 00 00 00       	mov    $0x2,%eax
80102612:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102613:	89 da                	mov    %ebx,%edx
80102615:	ec                   	in     (%dx),%al
80102616:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102619:	b2 70                	mov    $0x70,%dl
8010261b:	89 41 04             	mov    %eax,0x4(%ecx)
8010261e:	b8 04 00 00 00       	mov    $0x4,%eax
80102623:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102624:	89 da                	mov    %ebx,%edx
80102626:	ec                   	in     (%dx),%al
80102627:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010262a:	b2 70                	mov    $0x70,%dl
8010262c:	89 41 08             	mov    %eax,0x8(%ecx)
8010262f:	b8 07 00 00 00       	mov    $0x7,%eax
80102634:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102635:	89 da                	mov    %ebx,%edx
80102637:	ec                   	in     (%dx),%al
80102638:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010263b:	b2 70                	mov    $0x70,%dl
8010263d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102640:	b8 08 00 00 00       	mov    $0x8,%eax
80102645:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102646:	89 da                	mov    %ebx,%edx
80102648:	ec                   	in     (%dx),%al
80102649:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010264c:	b2 70                	mov    $0x70,%dl
8010264e:	89 41 10             	mov    %eax,0x10(%ecx)
80102651:	b8 09 00 00 00       	mov    $0x9,%eax
80102656:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102657:	89 da                	mov    %ebx,%edx
80102659:	ec                   	in     (%dx),%al
8010265a:	0f b6 d8             	movzbl %al,%ebx
8010265d:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102660:	5b                   	pop    %ebx
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret    
80102663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <lapicinit>:
  if(!lapic)
80102670:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102675:	55                   	push   %ebp
80102676:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102678:	85 c0                	test   %eax,%eax
8010267a:	0f 84 c0 00 00 00    	je     80102740 <lapicinit+0xd0>
  lapic[index] = value;
80102680:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102687:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010268d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102697:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010269a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026a1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ae:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026b1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026b4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026bb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026c8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026cb:	8b 50 20             	mov    0x20(%eax),%edx
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ce:	8b 50 30             	mov    0x30(%eax),%edx
801026d1:	c1 ea 10             	shr    $0x10,%edx
801026d4:	80 fa 03             	cmp    $0x3,%dl
801026d7:	77 6f                	ja     80102748 <lapicinit+0xd8>
  lapic[index] = value;
801026d9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ed:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102700:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102707:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010270d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010271a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102721:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
80102727:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
80102728:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010272e:	80 e6 10             	and    $0x10,%dh
80102731:	75 f5                	jne    80102728 <lapicinit+0xb8>
  lapic[index] = value;
80102733:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010273a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273d:	8b 40 20             	mov    0x20(%eax),%eax
}
80102740:	5d                   	pop    %ebp
80102741:	c3                   	ret    
80102742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102748:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010274f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102752:	8b 50 20             	mov    0x20(%eax),%edx
80102755:	eb 82                	jmp    801026d9 <lapicinit+0x69>
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicid>:
  if (!lapic)
80102760:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0c                	je     80102778 <lapicid+0x18>
  return lapic[ID] >> 24;
8010276c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010276f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
80102770:	c1 e8 18             	shr    $0x18,%eax
}
80102773:	c3                   	ret    
80102774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102778:	31 c0                	xor    %eax,%eax
}
8010277a:	5d                   	pop    %ebp
8010277b:	c3                   	ret    
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <lapiceoi>:
  if(lapic)
80102780:	a1 7c 26 11 80       	mov    0x8011267c,%eax
{
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
  lapic[index] = value;
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102796:	8b 40 20             	mov    0x20(%eax),%eax
}
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:
{
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
}
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:
{
801027b0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027b1:	ba 70 00 00 00       	mov    $0x70,%edx
801027b6:	89 e5                	mov    %esp,%ebp
801027b8:	b8 0f 00 00 00       	mov    $0xf,%eax
801027bd:	53                   	push   %ebx
801027be:	8b 4d 08             	mov    0x8(%ebp),%ecx
801027c1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ca:	b2 71                	mov    $0x71,%dl
801027cc:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801027cd:	31 c0                	xor    %eax,%eax
801027cf:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027d5:	89 d8                	mov    %ebx,%eax
801027d7:	c1 e8 04             	shr    $0x4,%eax
801027da:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapicw(ICRHI, apicid<<24);
801027e5:	c1 e1 18             	shl    $0x18,%ecx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027e8:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
801027eb:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027f1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f4:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027fb:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102801:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102808:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102817:	89 da                	mov    %ebx,%edx
80102819:	80 ce 06             	or     $0x6,%dh
  lapic[index] = value;
8010281c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102822:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102825:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010282b:	8b 48 20             	mov    0x20(%eax),%ecx
  lapic[index] = value;
8010282e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102834:	8b 40 20             	mov    0x20(%eax),%eax
}
80102837:	5b                   	pop    %ebx
80102838:	5d                   	pop    %ebp
80102839:	c3                   	ret    
8010283a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102840 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102840:	55                   	push   %ebp
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	89 e5                	mov    %esp,%ebp
80102848:	b8 0b 00 00 00       	mov    $0xb,%eax
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102854:	b2 71                	mov    $0x71,%dl
80102856:	ec                   	in     (%dx),%al
80102857:	88 45 b7             	mov    %al,-0x49(%ebp)
8010285a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010285d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102861:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010286d:	89 d8                	mov    %ebx,%eax
8010286f:	e8 7c fd ff ff       	call   801025f0 <fill_rtcdate>
80102874:	b8 0a 00 00 00       	mov    $0xa,%eax
80102879:	89 f2                	mov    %esi,%edx
8010287b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287c:	ba 71 00 00 00       	mov    $0x71,%edx
80102881:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102882:	84 c0                	test   %al,%al
80102884:	78 e7                	js     8010286d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
80102886:	89 f8                	mov    %edi,%eax
80102888:	e8 63 fd ff ff       	call   801025f0 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010288d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102894:	00 
80102895:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102899:	89 1c 24             	mov    %ebx,(%esp)
8010289c:	e8 0f 1b 00 00       	call   801043b0 <memcmp>
801028a1:	85 c0                	test   %eax,%eax
801028a3:	75 c3                	jne    80102868 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801028a5:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028a9:	75 78                	jne    80102923 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028ab:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028ae:	89 c2                	mov    %eax,%edx
801028b0:	83 e0 0f             	and    $0xf,%eax
801028b3:	c1 ea 04             	shr    $0x4,%edx
801028b6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028b9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028bc:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028bf:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028c2:	89 c2                	mov    %eax,%edx
801028c4:	83 e0 0f             	and    $0xf,%eax
801028c7:	c1 ea 04             	shr    $0x4,%edx
801028ca:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028cd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028d0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801028d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801028d6:	89 c2                	mov    %eax,%edx
801028d8:	83 e0 0f             	and    $0xf,%eax
801028db:	c1 ea 04             	shr    $0x4,%edx
801028de:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028e1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801028e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801028ea:	89 c2                	mov    %eax,%edx
801028ec:	83 e0 0f             	and    $0xf,%eax
801028ef:	c1 ea 04             	shr    $0x4,%edx
801028f2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028f8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801028fb:	8b 45 c8             	mov    -0x38(%ebp),%eax
801028fe:	89 c2                	mov    %eax,%edx
80102900:	83 e0 0f             	and    $0xf,%eax
80102903:	c1 ea 04             	shr    $0x4,%edx
80102906:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102909:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010290f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102912:	89 c2                	mov    %eax,%edx
80102914:	83 e0 0f             	and    $0xf,%eax
80102917:	c1 ea 04             	shr    $0x4,%edx
8010291a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010291d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102920:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102923:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102926:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102929:	89 01                	mov    %eax,(%ecx)
8010292b:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010292e:	89 41 04             	mov    %eax,0x4(%ecx)
80102931:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102934:	89 41 08             	mov    %eax,0x8(%ecx)
80102937:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010293a:	89 41 0c             	mov    %eax,0xc(%ecx)
8010293d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102940:	89 41 10             	mov    %eax,0x10(%ecx)
80102943:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102946:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102949:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102950:	83 c4 4c             	add    $0x4c,%esp
80102953:	5b                   	pop    %ebx
80102954:	5e                   	pop    %esi
80102955:	5f                   	pop    %edi
80102956:	5d                   	pop    %ebp
80102957:	c3                   	ret    
80102958:	66 90                	xchg   %ax,%ax
8010295a:	66 90                	xchg   %ax,%ax
8010295c:	66 90                	xchg   %ax,%ax
8010295e:	66 90                	xchg   %ax,%ax

80102960 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	57                   	push   %edi
80102964:	56                   	push   %esi
80102965:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102966:	31 db                	xor    %ebx,%ebx
{
80102968:	83 ec 1c             	sub    $0x1c,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010296b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102970:	85 c0                	test   %eax,%eax
80102972:	7e 78                	jle    801029ec <install_trans+0x8c>
80102974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102978:	a1 b4 26 11 80       	mov    0x801126b4,%eax
8010297d:	01 d8                	add    %ebx,%eax
8010297f:	83 c0 01             	add    $0x1,%eax
80102982:	89 44 24 04          	mov    %eax,0x4(%esp)
80102986:	a1 c4 26 11 80       	mov    0x801126c4,%eax
8010298b:	89 04 24             	mov    %eax,(%esp)
8010298e:	e8 3d d7 ff ff       	call   801000d0 <bread>
80102993:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102995:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
8010299c:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010299f:	89 44 24 04          	mov    %eax,0x4(%esp)
801029a3:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801029a8:	89 04 24             	mov    %eax,(%esp)
801029ab:	e8 20 d7 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801029b7:	00 
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029b8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029ba:	8d 47 5c             	lea    0x5c(%edi),%eax
801029bd:	89 44 24 04          	mov    %eax,0x4(%esp)
801029c1:	8d 46 5c             	lea    0x5c(%esi),%eax
801029c4:	89 04 24             	mov    %eax,(%esp)
801029c7:	e8 34 1a 00 00       	call   80104400 <memmove>
    bwrite(dbuf);  // write dst to disk
801029cc:	89 34 24             	mov    %esi,(%esp)
801029cf:	e8 cc d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
801029d4:	89 3c 24             	mov    %edi,(%esp)
801029d7:	e8 04 d8 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
801029dc:	89 34 24             	mov    %esi,(%esp)
801029df:	e8 fc d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801029e4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
801029ea:	7f 8c                	jg     80102978 <install_trans+0x18>
  }
}
801029ec:	83 c4 1c             	add    $0x1c,%esp
801029ef:	5b                   	pop    %ebx
801029f0:	5e                   	pop    %esi
801029f1:	5f                   	pop    %edi
801029f2:	5d                   	pop    %ebp
801029f3:	c3                   	ret    
801029f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a00 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a00:	55                   	push   %ebp
80102a01:	89 e5                	mov    %esp,%ebp
80102a03:	57                   	push   %edi
80102a04:	56                   	push   %esi
80102a05:	53                   	push   %ebx
80102a06:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a09:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a12:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a17:	89 04 24             	mov    %eax,(%esp)
80102a1a:	e8 b1 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a1f:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102a25:	31 d2                	xor    %edx,%edx
80102a27:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102a29:	89 c7                	mov    %eax,%edi
  hb->n = log.lh.n;
80102a2b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102a2e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102a31:	7e 17                	jle    80102a4a <write_head+0x4a>
80102a33:	90                   	nop
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a38:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102a3f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102a43:	83 c2 01             	add    $0x1,%edx
80102a46:	39 da                	cmp    %ebx,%edx
80102a48:	75 ee                	jne    80102a38 <write_head+0x38>
  }
  bwrite(buf);
80102a4a:	89 3c 24             	mov    %edi,(%esp)
80102a4d:	e8 4e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a52:	89 3c 24             	mov    %edi,(%esp)
80102a55:	e8 86 d7 ff ff       	call   801001e0 <brelse>
}
80102a5a:	83 c4 1c             	add    $0x1c,%esp
80102a5d:	5b                   	pop    %ebx
80102a5e:	5e                   	pop    %esi
80102a5f:	5f                   	pop    %edi
80102a60:	5d                   	pop    %ebp
80102a61:	c3                   	ret    
80102a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <initlog>:
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	56                   	push   %esi
80102a74:	53                   	push   %ebx
80102a75:	83 ec 30             	sub    $0x30,%esp
80102a78:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102a7b:	c7 44 24 04 60 71 10 	movl   $0x80107160,0x4(%esp)
80102a82:	80 
80102a83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102a8a:	e8 a1 16 00 00       	call   80104130 <initlock>
  readsb(dev, &sb);
80102a8f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102a92:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a96:	89 1c 24             	mov    %ebx,(%esp)
80102a99:	e8 82 e9 ff ff       	call   80101420 <readsb>
  log.start = sb.logstart;
80102a9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102aa1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102aa4:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102aa7:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
  struct buf *buf = bread(log.dev, log.start);
80102aad:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.size = sb.nlog;
80102ab1:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
  log.start = sb.logstart;
80102ab7:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  struct buf *buf = bread(log.dev, log.start);
80102abc:	e8 0f d6 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ac1:	31 d2                	xor    %edx,%edx
  log.lh.n = lh->n;
80102ac3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ac6:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102ac9:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102acb:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102ad1:	7e 17                	jle    80102aea <initlog+0x7a>
80102ad3:	90                   	nop
80102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102ad8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102adc:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ae3:	83 c2 01             	add    $0x1,%edx
80102ae6:	39 da                	cmp    %ebx,%edx
80102ae8:	75 ee                	jne    80102ad8 <initlog+0x68>
  brelse(buf);
80102aea:	89 04 24             	mov    %eax,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102af2:	e8 69 fe ff ff       	call   80102960 <install_trans>
  log.lh.n = 0;
80102af7:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102afe:	00 00 00 
  write_head(); // clear the log
80102b01:	e8 fa fe ff ff       	call   80102a00 <write_head>
}
80102b06:	83 c4 30             	add    $0x30,%esp
80102b09:	5b                   	pop    %ebx
80102b0a:	5e                   	pop    %esi
80102b0b:	5d                   	pop    %ebp
80102b0c:	c3                   	ret    
80102b0d:	8d 76 00             	lea    0x0(%esi),%esi

80102b10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102b16:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b1d:	e8 7e 17 00 00       	call   801042a0 <acquire>
80102b22:	eb 18                	jmp    80102b3c <begin_op+0x2c>
80102b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b28:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102b2f:	80 
80102b30:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b37:	e8 c4 10 00 00       	call   80103c00 <sleep>
    if(log.committing){
80102b3c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b41:	85 c0                	test   %eax,%eax
80102b43:	75 e3                	jne    80102b28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b45:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b4a:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b50:	83 c0 01             	add    $0x1,%eax
80102b53:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b56:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b59:	83 fa 1e             	cmp    $0x1e,%edx
80102b5c:	7f ca                	jg     80102b28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b5e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      log.outstanding += 1;
80102b65:	a3 bc 26 11 80       	mov    %eax,0x801126bc
      release(&log.lock);
80102b6a:	e8 a1 17 00 00       	call   80104310 <release>
      break;
    }
  }
}
80102b6f:	c9                   	leave  
80102b70:	c3                   	ret    
80102b71:	eb 0d                	jmp    80102b80 <end_op>
80102b73:	90                   	nop
80102b74:	90                   	nop
80102b75:	90                   	nop
80102b76:	90                   	nop
80102b77:	90                   	nop
80102b78:	90                   	nop
80102b79:	90                   	nop
80102b7a:	90                   	nop
80102b7b:	90                   	nop
80102b7c:	90                   	nop
80102b7d:	90                   	nop
80102b7e:	90                   	nop
80102b7f:	90                   	nop

80102b80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	57                   	push   %edi
80102b84:	56                   	push   %esi
80102b85:	53                   	push   %ebx
80102b86:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102b89:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b90:	e8 0b 17 00 00       	call   801042a0 <acquire>
  log.outstanding -= 1;
80102b95:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102b9a:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
  log.outstanding -= 1;
80102ba0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102ba3:	85 d2                	test   %edx,%edx
  log.outstanding -= 1;
80102ba5:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102baa:	0f 85 f3 00 00 00    	jne    80102ca3 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102bb0:	85 c0                	test   %eax,%eax
80102bb2:	0f 85 cb 00 00 00    	jne    80102c83 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102bb8:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bbf:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
80102bc1:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102bc8:	00 00 00 
  release(&log.lock);
80102bcb:	e8 40 17 00 00       	call   80104310 <release>
  if (log.lh.n > 0) {
80102bd0:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102bd5:	85 c0                	test   %eax,%eax
80102bd7:	0f 8e 90 00 00 00    	jle    80102c6d <end_op+0xed>
80102bdd:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102be0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102be5:	01 d8                	add    %ebx,%eax
80102be7:	83 c0 01             	add    $0x1,%eax
80102bea:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bee:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102bf3:	89 04 24             	mov    %eax,(%esp)
80102bf6:	e8 d5 d4 ff ff       	call   801000d0 <bread>
80102bfb:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102bfd:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102c04:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c07:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c0b:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102c10:	89 04 24             	mov    %eax,(%esp)
80102c13:	e8 b8 d4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102c18:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c1f:	00 
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c20:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c22:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c25:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c29:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c2c:	89 04 24             	mov    %eax,(%esp)
80102c2f:	e8 cc 17 00 00       	call   80104400 <memmove>
    bwrite(to);  // write the log
80102c34:	89 34 24             	mov    %esi,(%esp)
80102c37:	e8 64 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c3c:	89 3c 24             	mov    %edi,(%esp)
80102c3f:	e8 9c d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c44:	89 34 24             	mov    %esi,(%esp)
80102c47:	e8 94 d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c4c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c52:	7c 8c                	jl     80102be0 <end_op+0x60>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c54:	e8 a7 fd ff ff       	call   80102a00 <write_head>
    install_trans(); // Now install writes to home locations
80102c59:	e8 02 fd ff ff       	call   80102960 <install_trans>
    log.lh.n = 0;
80102c5e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c65:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c68:	e8 93 fd ff ff       	call   80102a00 <write_head>
    acquire(&log.lock);
80102c6d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c74:	e8 27 16 00 00       	call   801042a0 <acquire>
    log.committing = 0;
80102c79:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102c80:	00 00 00 
    wakeup(&log);
80102c83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c8a:	e8 01 11 00 00       	call   80103d90 <wakeup>
    release(&log.lock);
80102c8f:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c96:	e8 75 16 00 00       	call   80104310 <release>
}
80102c9b:	83 c4 1c             	add    $0x1c,%esp
80102c9e:	5b                   	pop    %ebx
80102c9f:	5e                   	pop    %esi
80102ca0:	5f                   	pop    %edi
80102ca1:	5d                   	pop    %ebp
80102ca2:	c3                   	ret    
    panic("log.committing");
80102ca3:	c7 04 24 64 71 10 80 	movl   $0x80107164,(%esp)
80102caa:	e8 b1 d6 ff ff       	call   80100360 <panic>
80102caf:	90                   	nop

80102cb0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cb7:	a1 c8 26 11 80       	mov    0x801126c8,%eax
{
80102cbc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cbf:	83 f8 1d             	cmp    $0x1d,%eax
80102cc2:	0f 8f 98 00 00 00    	jg     80102d60 <log_write+0xb0>
80102cc8:	8b 0d b8 26 11 80    	mov    0x801126b8,%ecx
80102cce:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102cd1:	39 d0                	cmp    %edx,%eax
80102cd3:	0f 8d 87 00 00 00    	jge    80102d60 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102cd9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cde:	85 c0                	test   %eax,%eax
80102ce0:	0f 8e 86 00 00 00    	jle    80102d6c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102ce6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102ced:	e8 ae 15 00 00       	call   801042a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102cf2:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cf8:	83 fa 00             	cmp    $0x0,%edx
80102cfb:	7e 54                	jle    80102d51 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102cfd:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d00:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d02:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102d08:	75 0f                	jne    80102d19 <log_write+0x69>
80102d0a:	eb 3c                	jmp    80102d48 <log_write+0x98>
80102d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d10:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d17:	74 2f                	je     80102d48 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102d19:	83 c0 01             	add    $0x1,%eax
80102d1c:	39 d0                	cmp    %edx,%eax
80102d1e:	75 f0                	jne    80102d10 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102d20:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d27:	83 c2 01             	add    $0x1,%edx
80102d2a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102d30:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102d33:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102d3a:	83 c4 14             	add    $0x14,%esp
80102d3d:	5b                   	pop    %ebx
80102d3e:	5d                   	pop    %ebp
  release(&log.lock);
80102d3f:	e9 cc 15 00 00       	jmp    80104310 <release>
80102d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80102d48:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102d4f:	eb df                	jmp    80102d30 <log_write+0x80>
80102d51:	8b 43 08             	mov    0x8(%ebx),%eax
80102d54:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102d59:	75 d5                	jne    80102d30 <log_write+0x80>
80102d5b:	eb ca                	jmp    80102d27 <log_write+0x77>
80102d5d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("too big a transaction");
80102d60:	c7 04 24 73 71 10 80 	movl   $0x80107173,(%esp)
80102d67:	e8 f4 d5 ff ff       	call   80100360 <panic>
    panic("log_write outside of trans");
80102d6c:	c7 04 24 89 71 10 80 	movl   $0x80107189,(%esp)
80102d73:	e8 e8 d5 ff ff       	call   80100360 <panic>
80102d78:	66 90                	xchg   %ax,%ax
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102d87:	e8 f4 08 00 00       	call   80103680 <cpuid>
80102d8c:	89 c3                	mov    %eax,%ebx
80102d8e:	e8 ed 08 00 00       	call   80103680 <cpuid>
80102d93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102d97:	c7 04 24 a4 71 10 80 	movl   $0x801071a4,(%esp)
80102d9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da2:	e8 a9 d8 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102da7:	e8 a4 27 00 00       	call   80105550 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102dac:	e8 4f 08 00 00       	call   80103600 <mycpu>
80102db1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102db3:	b8 01 00 00 00       	mov    $0x1,%eax
80102db8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102dbf:	e8 9c 0b 00 00       	call   80103960 <scheduler>
80102dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102dd0 <mpenter>:
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102dd6:	e8 35 38 00 00       	call   80106610 <switchkvm>
  seginit();
80102ddb:	e8 70 37 00 00       	call   80106550 <seginit>
  lapicinit();
80102de0:	e8 8b f8 ff ff       	call   80102670 <lapicinit>
  mpmain();
80102de5:	e8 96 ff ff ff       	call   80102d80 <mpmain>
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <main>:
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102df4:	bb 80 27 11 80       	mov    $0x80112780,%ebx
{
80102df9:	83 e4 f0             	and    $0xfffffff0,%esp
80102dfc:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102dff:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e06:	80 
80102e07:	c7 04 24 a8 54 11 80 	movl   $0x801154a8,(%esp)
80102e0e:	e8 cd f5 ff ff       	call   801023e0 <kinit1>
  kvmalloc();      // kernel page table
80102e13:	e8 88 3c 00 00       	call   80106aa0 <kvmalloc>
  mpinit();        // detect other processors
80102e18:	e8 73 01 00 00       	call   80102f90 <mpinit>
80102e1d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102e20:	e8 4b f8 ff ff       	call   80102670 <lapicinit>
  seginit();       // segment descriptors
80102e25:	e8 26 37 00 00       	call   80106550 <seginit>
  picinit();       // disable pic
80102e2a:	e8 21 03 00 00       	call   80103150 <picinit>
80102e2f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102e30:	e8 cb f3 ff ff       	call   80102200 <ioapicinit>
  consoleinit();   // console hardware
80102e35:	e8 16 db ff ff       	call   80100950 <consoleinit>
  uartinit();      // serial port
80102e3a:	e8 31 2a 00 00       	call   80105870 <uartinit>
80102e3f:	90                   	nop
  pinit();         // process table
80102e40:	e8 9b 07 00 00       	call   801035e0 <pinit>
  tvinit();        // trap vectors
80102e45:	e8 66 26 00 00       	call   801054b0 <tvinit>
  binit();         // buffer cache
80102e4a:	e8 f1 d1 ff ff       	call   80100040 <binit>
80102e4f:	90                   	nop
  fileinit();      // file table
80102e50:	e8 fb de ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102e55:	e8 a6 f1 ff ff       	call   80102000 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e5a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102e61:	00 
80102e62:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102e69:	80 
80102e6a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102e71:	e8 8a 15 00 00       	call   80104400 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102e76:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102e7d:	00 00 00 
80102e80:	05 80 27 11 80       	add    $0x80112780,%eax
80102e85:	39 d8                	cmp    %ebx,%eax
80102e87:	76 6a                	jbe    80102ef3 <main+0x103>
80102e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102e90:	e8 6b 07 00 00       	call   80103600 <mycpu>
80102e95:	39 d8                	cmp    %ebx,%eax
80102e97:	74 41                	je     80102eda <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102e99:	e8 02 f6 ff ff       	call   801024a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102e9e:	c7 05 f8 6f 00 80 d0 	movl   $0x80102dd0,0x80006ff8
80102ea5:	2d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ea8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102eaf:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102eb2:	05 00 10 00 00       	add    $0x1000,%eax
80102eb7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102ebc:	0f b6 03             	movzbl (%ebx),%eax
80102ebf:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102ec6:	00 
80102ec7:	89 04 24             	mov    %eax,(%esp)
80102eca:	e8 e1 f8 ff ff       	call   801027b0 <lapicstartap>
80102ecf:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ed0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102ed6:	85 c0                	test   %eax,%eax
80102ed8:	74 f6                	je     80102ed0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102eda:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ee1:	00 00 00 
80102ee4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102eea:	05 80 27 11 80       	add    $0x80112780,%eax
80102eef:	39 c3                	cmp    %eax,%ebx
80102ef1:	72 9d                	jb     80102e90 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102ef3:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102efa:	8e 
80102efb:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f02:	e8 49 f5 ff ff       	call   80102450 <kinit2>
  userinit();      // first user process
80102f07:	e8 c4 07 00 00       	call   801036d0 <userinit>
  mpmain();        // finish this processor's setup
80102f0c:	e8 6f fe ff ff       	call   80102d80 <mpmain>
80102f11:	66 90                	xchg   %ax,%ax
80102f13:	66 90                	xchg   %ax,%ax
80102f15:	66 90                	xchg   %ax,%ax
80102f17:	66 90                	xchg   %ax,%ax
80102f19:	66 90                	xchg   %ax,%ax
80102f1b:	66 90                	xchg   %ax,%ax
80102f1d:	66 90                	xchg   %ax,%ax
80102f1f:	90                   	nop

80102f20 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f24:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102f2a:	53                   	push   %ebx
  e = addr+len;
80102f2b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102f2e:	83 ec 10             	sub    $0x10,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102f31:	39 de                	cmp    %ebx,%esi
80102f33:	73 3c                	jae    80102f71 <mpsearch1+0x51>
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f38:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102f3f:	00 
80102f40:	c7 44 24 04 b8 71 10 	movl   $0x801071b8,0x4(%esp)
80102f47:	80 
80102f48:	89 34 24             	mov    %esi,(%esp)
80102f4b:	e8 60 14 00 00       	call   801043b0 <memcmp>
80102f50:	85 c0                	test   %eax,%eax
80102f52:	75 16                	jne    80102f6a <mpsearch1+0x4a>
80102f54:	31 c9                	xor    %ecx,%ecx
80102f56:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80102f58:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
  for(i=0; i<len; i++)
80102f5c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80102f5f:	01 c1                	add    %eax,%ecx
  for(i=0; i<len; i++)
80102f61:	83 fa 10             	cmp    $0x10,%edx
80102f64:	75 f2                	jne    80102f58 <mpsearch1+0x38>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f66:	84 c9                	test   %cl,%cl
80102f68:	74 10                	je     80102f7a <mpsearch1+0x5a>
  for(p = addr; p < e; p += sizeof(struct mp))
80102f6a:	83 c6 10             	add    $0x10,%esi
80102f6d:	39 f3                	cmp    %esi,%ebx
80102f6f:	77 c7                	ja     80102f38 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
80102f71:	83 c4 10             	add    $0x10,%esp
  return 0;
80102f74:	31 c0                	xor    %eax,%eax
}
80102f76:	5b                   	pop    %ebx
80102f77:	5e                   	pop    %esi
80102f78:	5d                   	pop    %ebp
80102f79:	c3                   	ret    
80102f7a:	83 c4 10             	add    $0x10,%esp
80102f7d:	89 f0                	mov    %esi,%eax
80102f7f:	5b                   	pop    %ebx
80102f80:	5e                   	pop    %esi
80102f81:	5d                   	pop    %ebp
80102f82:	c3                   	ret    
80102f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f90 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	57                   	push   %edi
80102f94:	56                   	push   %esi
80102f95:	53                   	push   %ebx
80102f96:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102f99:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fa0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fa7:	c1 e0 08             	shl    $0x8,%eax
80102faa:	09 d0                	or     %edx,%eax
80102fac:	c1 e0 04             	shl    $0x4,%eax
80102faf:	85 c0                	test   %eax,%eax
80102fb1:	75 1b                	jne    80102fce <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102fb3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fba:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102fc1:	c1 e0 08             	shl    $0x8,%eax
80102fc4:	09 d0                	or     %edx,%eax
80102fc6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102fc9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102fce:	ba 00 04 00 00       	mov    $0x400,%edx
80102fd3:	e8 48 ff ff ff       	call   80102f20 <mpsearch1>
80102fd8:	85 c0                	test   %eax,%eax
80102fda:	89 c7                	mov    %eax,%edi
80102fdc:	0f 84 22 01 00 00    	je     80103104 <mpinit+0x174>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80102fe2:	8b 77 04             	mov    0x4(%edi),%esi
80102fe5:	85 f6                	test   %esi,%esi
80102fe7:	0f 84 30 01 00 00    	je     8010311d <mpinit+0x18d>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80102fed:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80102ff3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102ffa:	00 
80102ffb:	c7 44 24 04 bd 71 10 	movl   $0x801071bd,0x4(%esp)
80103002:	80 
80103003:	89 04 24             	mov    %eax,(%esp)
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103006:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103009:	e8 a2 13 00 00       	call   801043b0 <memcmp>
8010300e:	85 c0                	test   %eax,%eax
80103010:	0f 85 07 01 00 00    	jne    8010311d <mpinit+0x18d>
  if(conf->version != 1 && conf->version != 4)
80103016:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010301d:	3c 04                	cmp    $0x4,%al
8010301f:	0f 85 0b 01 00 00    	jne    80103130 <mpinit+0x1a0>
  if(sum((uchar*)conf, conf->length) != 0)
80103025:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
  for(i=0; i<len; i++)
8010302c:	85 c0                	test   %eax,%eax
8010302e:	74 21                	je     80103051 <mpinit+0xc1>
  sum = 0;
80103030:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103032:	31 d2                	xor    %edx,%edx
80103034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103038:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010303f:	80 
  for(i=0; i<len; i++)
80103040:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103043:	01 d9                	add    %ebx,%ecx
  for(i=0; i<len; i++)
80103045:	39 d0                	cmp    %edx,%eax
80103047:	7f ef                	jg     80103038 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103049:	84 c9                	test   %cl,%cl
8010304b:	0f 85 cc 00 00 00    	jne    8010311d <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103051:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103054:	85 c0                	test   %eax,%eax
80103056:	0f 84 c1 00 00 00    	je     8010311d <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010305c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  ismp = 1;
80103062:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103067:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010306c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103073:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103079:	03 55 e4             	add    -0x1c(%ebp),%edx
8010307c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103080:	39 c2                	cmp    %eax,%edx
80103082:	76 1b                	jbe    8010309f <mpinit+0x10f>
80103084:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
80103087:	80 f9 04             	cmp    $0x4,%cl
8010308a:	77 74                	ja     80103100 <mpinit+0x170>
8010308c:	ff 24 8d fc 71 10 80 	jmp    *-0x7fef8e04(,%ecx,4)
80103093:	90                   	nop
80103094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103098:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010309b:	39 c2                	cmp    %eax,%edx
8010309d:	77 e5                	ja     80103084 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010309f:	85 db                	test   %ebx,%ebx
801030a1:	0f 84 93 00 00 00    	je     8010313a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801030a7:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801030ab:	74 12                	je     801030bf <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ad:	ba 22 00 00 00       	mov    $0x22,%edx
801030b2:	b8 70 00 00 00       	mov    $0x70,%eax
801030b7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030b8:	b2 23                	mov    $0x23,%dl
801030ba:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801030bb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030be:	ee                   	out    %al,(%dx)
  }
}
801030bf:	83 c4 1c             	add    $0x1c,%esp
801030c2:	5b                   	pop    %ebx
801030c3:	5e                   	pop    %esi
801030c4:	5f                   	pop    %edi
801030c5:	5d                   	pop    %ebp
801030c6:	c3                   	ret    
801030c7:	90                   	nop
      if(ncpu < NCPU) {
801030c8:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801030ce:	83 fe 07             	cmp    $0x7,%esi
801030d1:	7f 17                	jg     801030ea <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801030d3:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801030d7:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
801030dd:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801030e4:	88 8e 80 27 11 80    	mov    %cl,-0x7feed880(%esi)
      p += sizeof(struct mpproc);
801030ea:	83 c0 14             	add    $0x14,%eax
      continue;
801030ed:	eb 91                	jmp    80103080 <mpinit+0xf0>
801030ef:	90                   	nop
      ioapicid = ioapic->apicno;
801030f0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801030f4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801030f7:	88 0d 60 27 11 80    	mov    %cl,0x80112760
      continue;
801030fd:	eb 81                	jmp    80103080 <mpinit+0xf0>
801030ff:	90                   	nop
      ismp = 0;
80103100:	31 db                	xor    %ebx,%ebx
80103102:	eb 83                	jmp    80103087 <mpinit+0xf7>
  return mpsearch1(0xF0000, 0x10000);
80103104:	ba 00 00 01 00       	mov    $0x10000,%edx
80103109:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010310e:	e8 0d fe ff ff       	call   80102f20 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103113:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103115:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103117:	0f 85 c5 fe ff ff    	jne    80102fe2 <mpinit+0x52>
    panic("Expect to run on an SMP");
8010311d:	c7 04 24 c2 71 10 80 	movl   $0x801071c2,(%esp)
80103124:	e8 37 d2 ff ff       	call   80100360 <panic>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(conf->version != 1 && conf->version != 4)
80103130:	3c 01                	cmp    $0x1,%al
80103132:	0f 84 ed fe ff ff    	je     80103025 <mpinit+0x95>
80103138:	eb e3                	jmp    8010311d <mpinit+0x18d>
    panic("Didn't find a suitable machine");
8010313a:	c7 04 24 dc 71 10 80 	movl   $0x801071dc,(%esp)
80103141:	e8 1a d2 ff ff       	call   80100360 <panic>
80103146:	66 90                	xchg   %ax,%ax
80103148:	66 90                	xchg   %ax,%ax
8010314a:	66 90                	xchg   %ax,%ax
8010314c:	66 90                	xchg   %ax,%ax
8010314e:	66 90                	xchg   %ax,%ax

80103150 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103150:	55                   	push   %ebp
80103151:	ba 21 00 00 00       	mov    $0x21,%edx
80103156:	89 e5                	mov    %esp,%ebp
80103158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010315d:	ee                   	out    %al,(%dx)
8010315e:	b2 a1                	mov    $0xa1,%dl
80103160:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103161:	5d                   	pop    %ebp
80103162:	c3                   	ret    
80103163:	66 90                	xchg   %ax,%ax
80103165:	66 90                	xchg   %ax,%ax
80103167:	66 90                	xchg   %ax,%ax
80103169:	66 90                	xchg   %ax,%ax
8010316b:	66 90                	xchg   %ax,%ax
8010316d:	66 90                	xchg   %ax,%ax
8010316f:	90                   	nop

80103170 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
80103175:	53                   	push   %ebx
80103176:	83 ec 1c             	sub    $0x1c,%esp
80103179:	8b 75 08             	mov    0x8(%ebp),%esi
8010317c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010317f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103185:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010318b:	e8 e0 db ff ff       	call   80100d70 <filealloc>
80103190:	85 c0                	test   %eax,%eax
80103192:	89 06                	mov    %eax,(%esi)
80103194:	0f 84 a4 00 00 00    	je     8010323e <pipealloc+0xce>
8010319a:	e8 d1 db ff ff       	call   80100d70 <filealloc>
8010319f:	85 c0                	test   %eax,%eax
801031a1:	89 03                	mov    %eax,(%ebx)
801031a3:	0f 84 87 00 00 00    	je     80103230 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801031a9:	e8 f2 f2 ff ff       	call   801024a0 <kalloc>
801031ae:	85 c0                	test   %eax,%eax
801031b0:	89 c7                	mov    %eax,%edi
801031b2:	74 7c                	je     80103230 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
801031b4:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801031bb:	00 00 00 
  p->writeopen = 1;
801031be:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801031c5:	00 00 00 
  p->nwrite = 0;
801031c8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801031cf:	00 00 00 
  p->nread = 0;
801031d2:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801031d9:	00 00 00 
  initlock(&p->lock, "pipe");
801031dc:	89 04 24             	mov    %eax,(%esp)
801031df:	c7 44 24 04 10 72 10 	movl   $0x80107210,0x4(%esp)
801031e6:	80 
801031e7:	e8 44 0f 00 00       	call   80104130 <initlock>
  (*f0)->type = FD_PIPE;
801031ec:	8b 06                	mov    (%esi),%eax
801031ee:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801031f4:	8b 06                	mov    (%esi),%eax
801031f6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801031fa:	8b 06                	mov    (%esi),%eax
801031fc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103200:	8b 06                	mov    (%esi),%eax
80103202:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103205:	8b 03                	mov    (%ebx),%eax
80103207:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010320d:	8b 03                	mov    (%ebx),%eax
8010320f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103213:	8b 03                	mov    (%ebx),%eax
80103215:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103219:	8b 03                	mov    (%ebx),%eax
  return 0;
8010321b:	31 db                	xor    %ebx,%ebx
  (*f1)->pipe = p;
8010321d:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103220:	83 c4 1c             	add    $0x1c,%esp
80103223:	89 d8                	mov    %ebx,%eax
80103225:	5b                   	pop    %ebx
80103226:	5e                   	pop    %esi
80103227:	5f                   	pop    %edi
80103228:	5d                   	pop    %ebp
80103229:	c3                   	ret    
8010322a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103230:	8b 06                	mov    (%esi),%eax
80103232:	85 c0                	test   %eax,%eax
80103234:	74 08                	je     8010323e <pipealloc+0xce>
    fileclose(*f0);
80103236:	89 04 24             	mov    %eax,(%esp)
80103239:	e8 f2 db ff ff       	call   80100e30 <fileclose>
  if(*f1)
8010323e:	8b 03                	mov    (%ebx),%eax
  return -1;
80103240:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(*f1)
80103245:	85 c0                	test   %eax,%eax
80103247:	74 d7                	je     80103220 <pipealloc+0xb0>
    fileclose(*f1);
80103249:	89 04 24             	mov    %eax,(%esp)
8010324c:	e8 df db ff ff       	call   80100e30 <fileclose>
}
80103251:	83 c4 1c             	add    $0x1c,%esp
80103254:	89 d8                	mov    %ebx,%eax
80103256:	5b                   	pop    %ebx
80103257:	5e                   	pop    %esi
80103258:	5f                   	pop    %edi
80103259:	5d                   	pop    %ebp
8010325a:	c3                   	ret    
8010325b:	90                   	nop
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103260 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	56                   	push   %esi
80103264:	53                   	push   %ebx
80103265:	83 ec 10             	sub    $0x10,%esp
80103268:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010326e:	89 1c 24             	mov    %ebx,(%esp)
80103271:	e8 2a 10 00 00       	call   801042a0 <acquire>
  if(writable){
80103276:	85 f6                	test   %esi,%esi
80103278:	74 3e                	je     801032b8 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
8010327a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103280:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103287:	00 00 00 
    wakeup(&p->nread);
8010328a:	89 04 24             	mov    %eax,(%esp)
8010328d:	e8 fe 0a 00 00       	call   80103d90 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103292:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103298:	85 d2                	test   %edx,%edx
8010329a:	75 0a                	jne    801032a6 <pipeclose+0x46>
8010329c:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 32                	je     801032d8 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801032a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032a9:	83 c4 10             	add    $0x10,%esp
801032ac:	5b                   	pop    %ebx
801032ad:	5e                   	pop    %esi
801032ae:	5d                   	pop    %ebp
    release(&p->lock);
801032af:	e9 5c 10 00 00       	jmp    80104310 <release>
801032b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801032b8:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801032be:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801032c5:	00 00 00 
    wakeup(&p->nwrite);
801032c8:	89 04 24             	mov    %eax,(%esp)
801032cb:	e8 c0 0a 00 00       	call   80103d90 <wakeup>
801032d0:	eb c0                	jmp    80103292 <pipeclose+0x32>
801032d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&p->lock);
801032d8:	89 1c 24             	mov    %ebx,(%esp)
801032db:	e8 30 10 00 00       	call   80104310 <release>
    kfree((char*)p);
801032e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032e3:	83 c4 10             	add    $0x10,%esp
801032e6:	5b                   	pop    %ebx
801032e7:	5e                   	pop    %esi
801032e8:	5d                   	pop    %ebp
    kfree((char*)p);
801032e9:	e9 02 f0 ff ff       	jmp    801022f0 <kfree>
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	57                   	push   %edi
801032f4:	56                   	push   %esi
801032f5:	53                   	push   %ebx
801032f6:	83 ec 1c             	sub    $0x1c,%esp
801032f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801032fc:	89 1c 24             	mov    %ebx,(%esp)
801032ff:	e8 9c 0f 00 00       	call   801042a0 <acquire>
  for(i = 0; i < n; i++){
80103304:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103307:	85 c9                	test   %ecx,%ecx
80103309:	0f 8e b2 00 00 00    	jle    801033c1 <pipewrite+0xd1>
8010330f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103312:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103318:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010331e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103324:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103327:	03 4d 10             	add    0x10(%ebp),%ecx
8010332a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010332d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103333:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103339:	39 c8                	cmp    %ecx,%eax
8010333b:	74 38                	je     80103375 <pipewrite+0x85>
8010333d:	eb 55                	jmp    80103394 <pipewrite+0xa4>
8010333f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103340:	e8 5b 03 00 00       	call   801036a0 <myproc>
80103345:	8b 40 24             	mov    0x24(%eax),%eax
80103348:	85 c0                	test   %eax,%eax
8010334a:	75 33                	jne    8010337f <pipewrite+0x8f>
      wakeup(&p->nread);
8010334c:	89 3c 24             	mov    %edi,(%esp)
8010334f:	e8 3c 0a 00 00       	call   80103d90 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103354:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103358:	89 34 24             	mov    %esi,(%esp)
8010335b:	e8 a0 08 00 00       	call   80103c00 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103360:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103366:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010336c:	05 00 02 00 00       	add    $0x200,%eax
80103371:	39 c2                	cmp    %eax,%edx
80103373:	75 23                	jne    80103398 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
80103375:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010337b:	85 d2                	test   %edx,%edx
8010337d:	75 c1                	jne    80103340 <pipewrite+0x50>
        release(&p->lock);
8010337f:	89 1c 24             	mov    %ebx,(%esp)
80103382:	e8 89 0f 00 00       	call   80104310 <release>
        return -1;
80103387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010338c:	83 c4 1c             	add    $0x1c,%esp
8010338f:	5b                   	pop    %ebx
80103390:	5e                   	pop    %esi
80103391:	5f                   	pop    %edi
80103392:	5d                   	pop    %ebp
80103393:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103394:	89 c2                	mov    %eax,%edx
80103396:	66 90                	xchg   %ax,%ax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103398:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010339b:	8d 42 01             	lea    0x1(%edx),%eax
8010339e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801033a4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801033aa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801033ae:	0f b6 09             	movzbl (%ecx),%ecx
801033b1:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801033b5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033b8:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801033bb:	0f 85 6c ff ff ff    	jne    8010332d <pipewrite+0x3d>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801033c1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033c7:	89 04 24             	mov    %eax,(%esp)
801033ca:	e8 c1 09 00 00       	call   80103d90 <wakeup>
  release(&p->lock);
801033cf:	89 1c 24             	mov    %ebx,(%esp)
801033d2:	e8 39 0f 00 00       	call   80104310 <release>
  return n;
801033d7:	8b 45 10             	mov    0x10(%ebp),%eax
801033da:	eb b0                	jmp    8010338c <pipewrite+0x9c>
801033dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
801033e9:	8b 75 08             	mov    0x8(%ebp),%esi
801033ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801033ef:	89 34 24             	mov    %esi,(%esp)
801033f2:	e8 a9 0e 00 00       	call   801042a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801033f7:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801033fd:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103403:	75 5b                	jne    80103460 <piperead+0x80>
80103405:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010340b:	85 db                	test   %ebx,%ebx
8010340d:	74 51                	je     80103460 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010340f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103415:	eb 25                	jmp    8010343c <piperead+0x5c>
80103417:	90                   	nop
80103418:	89 74 24 04          	mov    %esi,0x4(%esp)
8010341c:	89 1c 24             	mov    %ebx,(%esp)
8010341f:	e8 dc 07 00 00       	call   80103c00 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103424:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010342a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103430:	75 2e                	jne    80103460 <piperead+0x80>
80103432:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103438:	85 d2                	test   %edx,%edx
8010343a:	74 24                	je     80103460 <piperead+0x80>
    if(myproc()->killed){
8010343c:	e8 5f 02 00 00       	call   801036a0 <myproc>
80103441:	8b 48 24             	mov    0x24(%eax),%ecx
80103444:	85 c9                	test   %ecx,%ecx
80103446:	74 d0                	je     80103418 <piperead+0x38>
      release(&p->lock);
80103448:	89 34 24             	mov    %esi,(%esp)
8010344b:	e8 c0 0e 00 00       	call   80104310 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103450:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80103453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103458:	5b                   	pop    %ebx
80103459:	5e                   	pop    %esi
8010345a:	5f                   	pop    %edi
8010345b:	5d                   	pop    %ebp
8010345c:	c3                   	ret    
8010345d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103460:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103463:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103465:	85 d2                	test   %edx,%edx
80103467:	7f 2b                	jg     80103494 <piperead+0xb4>
80103469:	eb 31                	jmp    8010349c <piperead+0xbc>
8010346b:	90                   	nop
8010346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103470:	8d 48 01             	lea    0x1(%eax),%ecx
80103473:	25 ff 01 00 00       	and    $0x1ff,%eax
80103478:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010347e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103483:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103486:	83 c3 01             	add    $0x1,%ebx
80103489:	3b 5d 10             	cmp    0x10(%ebp),%ebx
8010348c:	74 0e                	je     8010349c <piperead+0xbc>
    if(p->nread == p->nwrite)
8010348e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103494:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010349a:	75 d4                	jne    80103470 <piperead+0x90>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010349c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801034a2:	89 04 24             	mov    %eax,(%esp)
801034a5:	e8 e6 08 00 00       	call   80103d90 <wakeup>
  release(&p->lock);
801034aa:	89 34 24             	mov    %esi,(%esp)
801034ad:	e8 5e 0e 00 00       	call   80104310 <release>
}
801034b2:	83 c4 1c             	add    $0x1c,%esp
  return i;
801034b5:	89 d8                	mov    %ebx,%eax
}
801034b7:	5b                   	pop    %ebx
801034b8:	5e                   	pop    %esi
801034b9:	5f                   	pop    %edi
801034ba:	5d                   	pop    %ebp
801034bb:	c3                   	ret    
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801034c9:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801034cc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801034d3:	e8 c8 0d 00 00       	call   801042a0 <acquire>
801034d8:	eb 11                	jmp    801034eb <allocproc+0x2b>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034e0:	83 c3 7c             	add    $0x7c,%ebx
801034e3:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801034e9:	74 7d                	je     80103568 <allocproc+0xa8>
    if(p->state == UNUSED)
801034eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801034ee:	85 c0                	test   %eax,%eax
801034f0:	75 ee                	jne    801034e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801034f2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801034f7:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  p->state = EMBRYO;
801034fe:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103505:	8d 50 01             	lea    0x1(%eax),%edx
80103508:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
8010350e:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103511:	e8 fa 0d 00 00       	call   80104310 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103516:	e8 85 ef ff ff       	call   801024a0 <kalloc>
8010351b:	85 c0                	test   %eax,%eax
8010351d:	89 43 08             	mov    %eax,0x8(%ebx)
80103520:	74 5a                	je     8010357c <allocproc+0xbc>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103522:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103528:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010352d:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103530:	c7 40 14 a1 54 10 80 	movl   $0x801054a1,0x14(%eax)
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103537:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010353e:	00 
8010353f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103546:	00 
80103547:	89 04 24             	mov    %eax,(%esp)
  p->context = (struct context*)sp;
8010354a:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010354d:	e8 0e 0e 00 00       	call   80104360 <memset>
  p->context->eip = (uint)forkret;
80103552:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103555:	c7 40 10 90 35 10 80 	movl   $0x80103590,0x10(%eax)

  return p;
8010355c:	89 d8                	mov    %ebx,%eax
}
8010355e:	83 c4 14             	add    $0x14,%esp
80103561:	5b                   	pop    %ebx
80103562:	5d                   	pop    %ebp
80103563:	c3                   	ret    
80103564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103568:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010356f:	e8 9c 0d 00 00       	call   80104310 <release>
}
80103574:	83 c4 14             	add    $0x14,%esp
  return 0;
80103577:	31 c0                	xor    %eax,%eax
}
80103579:	5b                   	pop    %ebx
8010357a:	5d                   	pop    %ebp
8010357b:	c3                   	ret    
    p->state = UNUSED;
8010357c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103583:	eb d9                	jmp    8010355e <allocproc+0x9e>
80103585:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103590 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103596:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010359d:	e8 6e 0d 00 00       	call   80104310 <release>

  if (first) {
801035a2:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801035a7:	85 c0                	test   %eax,%eax
801035a9:	75 05                	jne    801035b0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801035ab:	c9                   	leave  
801035ac:	c3                   	ret    
801035ad:	8d 76 00             	lea    0x0(%esi),%esi
    iinit(ROOTDEV);
801035b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
801035b7:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
801035be:	00 00 00 
    iinit(ROOTDEV);
801035c1:	e8 aa de ff ff       	call   80101470 <iinit>
    initlog(ROOTDEV);
801035c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801035cd:	e8 9e f4 ff ff       	call   80102a70 <initlog>
}
801035d2:	c9                   	leave  
801035d3:	c3                   	ret    
801035d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801035e0 <pinit>:
{
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
801035e6:	c7 44 24 04 15 72 10 	movl   $0x80107215,0x4(%esp)
801035ed:	80 
801035ee:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035f5:	e8 36 0b 00 00       	call   80104130 <initlock>
}
801035fa:	c9                   	leave  
801035fb:	c3                   	ret    
801035fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103600 <mycpu>:
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	56                   	push   %esi
80103604:	53                   	push   %ebx
80103605:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103608:	9c                   	pushf  
80103609:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010360a:	f6 c4 02             	test   $0x2,%ah
8010360d:	75 57                	jne    80103666 <mycpu+0x66>
  apicid = lapicid();
8010360f:	e8 4c f1 ff ff       	call   80102760 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103614:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
8010361a:	85 f6                	test   %esi,%esi
8010361c:	7e 3c                	jle    8010365a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010361e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103625:	39 c2                	cmp    %eax,%edx
80103627:	74 2d                	je     80103656 <mycpu+0x56>
80103629:	b9 30 28 11 80       	mov    $0x80112830,%ecx
  for (i = 0; i < ncpu; ++i) {
8010362e:	31 d2                	xor    %edx,%edx
80103630:	83 c2 01             	add    $0x1,%edx
80103633:	39 f2                	cmp    %esi,%edx
80103635:	74 23                	je     8010365a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103637:	0f b6 19             	movzbl (%ecx),%ebx
8010363a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103640:	39 c3                	cmp    %eax,%ebx
80103642:	75 ec                	jne    80103630 <mycpu+0x30>
      return &cpus[i];
80103644:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
}
8010364a:	83 c4 10             	add    $0x10,%esp
8010364d:	5b                   	pop    %ebx
8010364e:	5e                   	pop    %esi
8010364f:	5d                   	pop    %ebp
      return &cpus[i];
80103650:	05 80 27 11 80       	add    $0x80112780,%eax
}
80103655:	c3                   	ret    
  for (i = 0; i < ncpu; ++i) {
80103656:	31 d2                	xor    %edx,%edx
80103658:	eb ea                	jmp    80103644 <mycpu+0x44>
  panic("unknown apicid\n");
8010365a:	c7 04 24 1c 72 10 80 	movl   $0x8010721c,(%esp)
80103661:	e8 fa cc ff ff       	call   80100360 <panic>
    panic("mycpu called with interrupts enabled\n");
80103666:	c7 04 24 58 73 10 80 	movl   $0x80107358,(%esp)
8010366d:	e8 ee cc ff ff       	call   80100360 <panic>
80103672:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103680 <cpuid>:
cpuid() {
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103686:	e8 75 ff ff ff       	call   80103600 <mycpu>
}
8010368b:	c9                   	leave  
  return mycpu()-cpus;
8010368c:	2d 80 27 11 80       	sub    $0x80112780,%eax
80103691:	c1 f8 04             	sar    $0x4,%eax
80103694:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010369a:	c3                   	ret    
8010369b:	90                   	nop
8010369c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036a0 <myproc>:
myproc(void) {
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	53                   	push   %ebx
801036a4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
801036a7:	e8 04 0b 00 00       	call   801041b0 <pushcli>
  c = mycpu();
801036ac:	e8 4f ff ff ff       	call   80103600 <mycpu>
  p = c->proc;
801036b1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801036b7:	e8 34 0b 00 00       	call   801041f0 <popcli>
}
801036bc:	83 c4 04             	add    $0x4,%esp
801036bf:	89 d8                	mov    %ebx,%eax
801036c1:	5b                   	pop    %ebx
801036c2:	5d                   	pop    %ebp
801036c3:	c3                   	ret    
801036c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801036d0 <userinit>:
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
801036d4:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
801036d7:	e8 e4 fd ff ff       	call   801034c0 <allocproc>
801036dc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801036de:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
  if((p->pgdir = setupkvm()) == 0)
801036e3:	e8 28 33 00 00       	call   80106a10 <setupkvm>
801036e8:	85 c0                	test   %eax,%eax
801036ea:	89 43 04             	mov    %eax,0x4(%ebx)
801036ed:	0f 84 d4 00 00 00    	je     801037c7 <userinit+0xf7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801036f3:	89 04 24             	mov    %eax,(%esp)
801036f6:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
801036fd:	00 
801036fe:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103705:	80 
80103706:	e8 35 30 00 00       	call   80106740 <inituvm>
  p->sz = PGSIZE;
8010370b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103711:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103718:	00 
80103719:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103720:	00 
80103721:	8b 43 18             	mov    0x18(%ebx),%eax
80103724:	89 04 24             	mov    %eax,(%esp)
80103727:	e8 34 0c 00 00       	call   80104360 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010372c:	8b 43 18             	mov    0x18(%ebx),%eax
8010372f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103734:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103739:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010373d:	8b 43 18             	mov    0x18(%ebx),%eax
80103740:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103744:	8b 43 18             	mov    0x18(%ebx),%eax
80103747:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010374b:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010374f:	8b 43 18             	mov    0x18(%ebx),%eax
80103752:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103756:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010375a:	8b 43 18             	mov    0x18(%ebx),%eax
8010375d:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103764:	8b 43 18             	mov    0x18(%ebx),%eax
80103767:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010376e:	8b 43 18             	mov    0x18(%ebx),%eax
80103771:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103778:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010377b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103782:	00 
80103783:	c7 44 24 04 45 72 10 	movl   $0x80107245,0x4(%esp)
8010378a:	80 
8010378b:	89 04 24             	mov    %eax,(%esp)
8010378e:	e8 ad 0d 00 00       	call   80104540 <safestrcpy>
  p->cwd = namei("/");
80103793:	c7 04 24 4e 72 10 80 	movl   $0x8010724e,(%esp)
8010379a:	e8 61 e7 ff ff       	call   80101f00 <namei>
8010379f:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
801037a2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037a9:	e8 f2 0a 00 00       	call   801042a0 <acquire>
  p->state = RUNNABLE;
801037ae:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801037b5:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037bc:	e8 4f 0b 00 00       	call   80104310 <release>
}
801037c1:	83 c4 14             	add    $0x14,%esp
801037c4:	5b                   	pop    %ebx
801037c5:	5d                   	pop    %ebp
801037c6:	c3                   	ret    
    panic("userinit: out of memory?");
801037c7:	c7 04 24 2c 72 10 80 	movl   $0x8010722c,(%esp)
801037ce:	e8 8d cb ff ff       	call   80100360 <panic>
801037d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037e0 <growproc>:
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	56                   	push   %esi
801037e4:	53                   	push   %ebx
801037e5:	83 ec 10             	sub    $0x10,%esp
801037e8:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
801037eb:	e8 b0 fe ff ff       	call   801036a0 <myproc>
  if(n > 0){
801037f0:	83 fe 00             	cmp    $0x0,%esi
  struct proc *curproc = myproc();
801037f3:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
801037f5:	8b 00                	mov    (%eax),%eax
  if(n > 0){
801037f7:	7e 2f                	jle    80103828 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801037f9:	01 c6                	add    %eax,%esi
801037fb:	89 74 24 08          	mov    %esi,0x8(%esp)
801037ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80103803:	8b 43 04             	mov    0x4(%ebx),%eax
80103806:	89 04 24             	mov    %eax,(%esp)
80103809:	e8 72 30 00 00       	call   80106880 <allocuvm>
8010380e:	85 c0                	test   %eax,%eax
80103810:	74 36                	je     80103848 <growproc+0x68>
  curproc->sz = sz;
80103812:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103814:	89 1c 24             	mov    %ebx,(%esp)
80103817:	e8 14 2e 00 00       	call   80106630 <switchuvm>
  return 0;
8010381c:	31 c0                	xor    %eax,%eax
}
8010381e:	83 c4 10             	add    $0x10,%esp
80103821:	5b                   	pop    %ebx
80103822:	5e                   	pop    %esi
80103823:	5d                   	pop    %ebp
80103824:	c3                   	ret    
80103825:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(n < 0){
80103828:	74 e8                	je     80103812 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010382a:	01 c6                	add    %eax,%esi
8010382c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103830:	89 44 24 04          	mov    %eax,0x4(%esp)
80103834:	8b 43 04             	mov    0x4(%ebx),%eax
80103837:	89 04 24             	mov    %eax,(%esp)
8010383a:	e8 31 31 00 00       	call   80106970 <deallocuvm>
8010383f:	85 c0                	test   %eax,%eax
80103841:	75 cf                	jne    80103812 <growproc+0x32>
80103843:	90                   	nop
80103844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80103848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010384d:	eb cf                	jmp    8010381e <growproc+0x3e>
8010384f:	90                   	nop

80103850 <fork>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	57                   	push   %edi
80103854:	56                   	push   %esi
80103855:	53                   	push   %ebx
80103856:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *curproc = myproc();
80103859:	e8 42 fe ff ff       	call   801036a0 <myproc>
8010385e:	89 c3                	mov    %eax,%ebx
  if((np = allocproc()) == 0){
80103860:	e8 5b fc ff ff       	call   801034c0 <allocproc>
80103865:	85 c0                	test   %eax,%eax
80103867:	89 c7                	mov    %eax,%edi
80103869:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010386c:	0f 84 bc 00 00 00    	je     8010392e <fork+0xde>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103872:	8b 03                	mov    (%ebx),%eax
80103874:	89 44 24 04          	mov    %eax,0x4(%esp)
80103878:	8b 43 04             	mov    0x4(%ebx),%eax
8010387b:	89 04 24             	mov    %eax,(%esp)
8010387e:	e8 6d 32 00 00       	call   80106af0 <copyuvm>
80103883:	85 c0                	test   %eax,%eax
80103885:	89 47 04             	mov    %eax,0x4(%edi)
80103888:	0f 84 a7 00 00 00    	je     80103935 <fork+0xe5>
  np->sz = curproc->sz;
8010388e:	8b 03                	mov    (%ebx),%eax
80103890:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103893:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103895:	8b 79 18             	mov    0x18(%ecx),%edi
80103898:	89 c8                	mov    %ecx,%eax
  np->parent = curproc;
8010389a:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010389d:	8b 73 18             	mov    0x18(%ebx),%esi
801038a0:	b9 13 00 00 00       	mov    $0x13,%ecx
801038a5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801038a7:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801038a9:	8b 40 18             	mov    0x18(%eax),%eax
801038ac:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801038b3:	90                   	nop
801038b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
801038b8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801038bc:	85 c0                	test   %eax,%eax
801038be:	74 0f                	je     801038cf <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
801038c0:	89 04 24             	mov    %eax,(%esp)
801038c3:	e8 18 d5 ff ff       	call   80100de0 <filedup>
801038c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801038cb:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801038cf:	83 c6 01             	add    $0x1,%esi
801038d2:	83 fe 10             	cmp    $0x10,%esi
801038d5:	75 e1                	jne    801038b8 <fork+0x68>
  np->cwd = idup(curproc->cwd);
801038d7:	8b 43 68             	mov    0x68(%ebx),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801038da:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801038dd:	89 04 24             	mov    %eax,(%esp)
801038e0:	e8 9b dd ff ff       	call   80101680 <idup>
801038e5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801038e8:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801038eb:	8d 47 6c             	lea    0x6c(%edi),%eax
801038ee:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801038f2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801038f9:	00 
801038fa:	89 04 24             	mov    %eax,(%esp)
801038fd:	e8 3e 0c 00 00       	call   80104540 <safestrcpy>
  pid = np->pid;
80103902:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103905:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010390c:	e8 8f 09 00 00       	call   801042a0 <acquire>
  np->state = RUNNABLE;
80103911:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103918:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010391f:	e8 ec 09 00 00       	call   80104310 <release>
  return pid;
80103924:	89 d8                	mov    %ebx,%eax
}
80103926:	83 c4 1c             	add    $0x1c,%esp
80103929:	5b                   	pop    %ebx
8010392a:	5e                   	pop    %esi
8010392b:	5f                   	pop    %edi
8010392c:	5d                   	pop    %ebp
8010392d:	c3                   	ret    
    return -1;
8010392e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103933:	eb f1                	jmp    80103926 <fork+0xd6>
    kfree(np->kstack);
80103935:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103938:	8b 47 08             	mov    0x8(%edi),%eax
8010393b:	89 04 24             	mov    %eax,(%esp)
8010393e:	e8 ad e9 ff ff       	call   801022f0 <kfree>
    return -1;
80103943:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    np->kstack = 0;
80103948:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
8010394f:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103956:	eb ce                	jmp    80103926 <fork+0xd6>
80103958:	90                   	nop
80103959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103960 <scheduler>:
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	57                   	push   %edi
80103964:	56                   	push   %esi
80103965:	53                   	push   %ebx
80103966:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103969:	e8 92 fc ff ff       	call   80103600 <mycpu>
8010396e:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103970:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103977:	00 00 00 
8010397a:	8d 78 04             	lea    0x4(%eax),%edi
8010397d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103980:	fb                   	sti    
    acquire(&ptable.lock);
80103981:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103988:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
8010398d:	e8 0e 09 00 00       	call   801042a0 <acquire>
80103992:	eb 0f                	jmp    801039a3 <scheduler+0x43>
80103994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103998:	83 c3 7c             	add    $0x7c,%ebx
8010399b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
801039a1:	74 45                	je     801039e8 <scheduler+0x88>
      if(p->state != RUNNABLE)
801039a3:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801039a7:	75 ef                	jne    80103998 <scheduler+0x38>
      c->proc = p;
801039a9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801039af:	89 1c 24             	mov    %ebx,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039b2:	83 c3 7c             	add    $0x7c,%ebx
      switchuvm(p);
801039b5:	e8 76 2c 00 00       	call   80106630 <switchuvm>
      swtch(&(c->scheduler), p->context);
801039ba:	8b 43 a0             	mov    -0x60(%ebx),%eax
      p->state = RUNNING;
801039bd:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&(c->scheduler), p->context);
801039c4:	89 3c 24             	mov    %edi,(%esp)
801039c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801039cb:	e8 cb 0b 00 00       	call   8010459b <swtch>
      switchkvm();
801039d0:	e8 3b 2c 00 00       	call   80106610 <switchkvm>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039d5:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      c->proc = 0;
801039db:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801039e2:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801039e5:	75 bc                	jne    801039a3 <scheduler+0x43>
801039e7:	90                   	nop
    release(&ptable.lock);
801039e8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039ef:	e8 1c 09 00 00       	call   80104310 <release>
  }
801039f4:	eb 8a                	jmp    80103980 <scheduler+0x20>
801039f6:	8d 76 00             	lea    0x0(%esi),%esi
801039f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a00 <sched>:
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	56                   	push   %esi
80103a04:	53                   	push   %ebx
80103a05:	83 ec 10             	sub    $0x10,%esp
  struct proc *p = myproc();
80103a08:	e8 93 fc ff ff       	call   801036a0 <myproc>
  if(!holding(&ptable.lock))
80103a0d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *p = myproc();
80103a14:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103a16:	e8 45 08 00 00       	call   80104260 <holding>
80103a1b:	85 c0                	test   %eax,%eax
80103a1d:	74 4f                	je     80103a6e <sched+0x6e>
  if(mycpu()->ncli != 1)
80103a1f:	e8 dc fb ff ff       	call   80103600 <mycpu>
80103a24:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103a2b:	75 65                	jne    80103a92 <sched+0x92>
  if(p->state == RUNNING)
80103a2d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103a31:	74 53                	je     80103a86 <sched+0x86>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103a33:	9c                   	pushf  
80103a34:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103a35:	f6 c4 02             	test   $0x2,%ah
80103a38:	75 40                	jne    80103a7a <sched+0x7a>
  intena = mycpu()->intena;
80103a3a:	e8 c1 fb ff ff       	call   80103600 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103a3f:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103a42:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103a48:	e8 b3 fb ff ff       	call   80103600 <mycpu>
80103a4d:	8b 40 04             	mov    0x4(%eax),%eax
80103a50:	89 1c 24             	mov    %ebx,(%esp)
80103a53:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a57:	e8 3f 0b 00 00       	call   8010459b <swtch>
  mycpu()->intena = intena;
80103a5c:	e8 9f fb ff ff       	call   80103600 <mycpu>
80103a61:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103a67:	83 c4 10             	add    $0x10,%esp
80103a6a:	5b                   	pop    %ebx
80103a6b:	5e                   	pop    %esi
80103a6c:	5d                   	pop    %ebp
80103a6d:	c3                   	ret    
    panic("sched ptable.lock");
80103a6e:	c7 04 24 50 72 10 80 	movl   $0x80107250,(%esp)
80103a75:	e8 e6 c8 ff ff       	call   80100360 <panic>
    panic("sched interruptible");
80103a7a:	c7 04 24 7c 72 10 80 	movl   $0x8010727c,(%esp)
80103a81:	e8 da c8 ff ff       	call   80100360 <panic>
    panic("sched running");
80103a86:	c7 04 24 6e 72 10 80 	movl   $0x8010726e,(%esp)
80103a8d:	e8 ce c8 ff ff       	call   80100360 <panic>
    panic("sched locks");
80103a92:	c7 04 24 62 72 10 80 	movl   $0x80107262,(%esp)
80103a99:	e8 c2 c8 ff ff       	call   80100360 <panic>
80103a9e:	66 90                	xchg   %ax,%ax

80103aa0 <exit>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	56                   	push   %esi
  if(curproc == initproc)
80103aa4:	31 f6                	xor    %esi,%esi
{
80103aa6:	53                   	push   %ebx
80103aa7:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103aaa:	e8 f1 fb ff ff       	call   801036a0 <myproc>
  if(curproc == initproc)
80103aaf:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
  struct proc *curproc = myproc();
80103ab5:	89 c3                	mov    %eax,%ebx
  if(curproc == initproc)
80103ab7:	0f 84 ea 00 00 00    	je     80103ba7 <exit+0x107>
80103abd:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103ac0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ac4:	85 c0                	test   %eax,%eax
80103ac6:	74 10                	je     80103ad8 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103ac8:	89 04 24             	mov    %eax,(%esp)
80103acb:	e8 60 d3 ff ff       	call   80100e30 <fileclose>
      curproc->ofile[fd] = 0;
80103ad0:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103ad7:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103ad8:	83 c6 01             	add    $0x1,%esi
80103adb:	83 fe 10             	cmp    $0x10,%esi
80103ade:	75 e0                	jne    80103ac0 <exit+0x20>
  begin_op();
80103ae0:	e8 2b f0 ff ff       	call   80102b10 <begin_op>
  iput(curproc->cwd);
80103ae5:	8b 43 68             	mov    0x68(%ebx),%eax
80103ae8:	89 04 24             	mov    %eax,(%esp)
80103aeb:	e8 e0 dc ff ff       	call   801017d0 <iput>
  end_op();
80103af0:	e8 8b f0 ff ff       	call   80102b80 <end_op>
  curproc->cwd = 0;
80103af5:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103afc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b03:	e8 98 07 00 00       	call   801042a0 <acquire>
  wakeup1(curproc->parent);
80103b08:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b0b:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103b10:	eb 11                	jmp    80103b23 <exit+0x83>
80103b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b18:	83 c2 7c             	add    $0x7c,%edx
80103b1b:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103b21:	74 1d                	je     80103b40 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103b23:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103b27:	75 ef                	jne    80103b18 <exit+0x78>
80103b29:	3b 42 20             	cmp    0x20(%edx),%eax
80103b2c:	75 ea                	jne    80103b18 <exit+0x78>
      p->state = RUNNABLE;
80103b2e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b35:	83 c2 7c             	add    $0x7c,%edx
80103b38:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103b3e:	75 e3                	jne    80103b23 <exit+0x83>
      p->parent = initproc;
80103b40:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103b45:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103b4a:	eb 0f                	jmp    80103b5b <exit+0xbb>
80103b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b50:	83 c1 7c             	add    $0x7c,%ecx
80103b53:	81 f9 54 4c 11 80    	cmp    $0x80114c54,%ecx
80103b59:	74 34                	je     80103b8f <exit+0xef>
    if(p->parent == curproc){
80103b5b:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103b5e:	75 f0                	jne    80103b50 <exit+0xb0>
      if(p->state == ZOMBIE)
80103b60:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
      p->parent = initproc;
80103b64:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103b67:	75 e7                	jne    80103b50 <exit+0xb0>
80103b69:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103b6e:	eb 0b                	jmp    80103b7b <exit+0xdb>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b70:	83 c2 7c             	add    $0x7c,%edx
80103b73:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103b79:	74 d5                	je     80103b50 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103b7b:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103b7f:	75 ef                	jne    80103b70 <exit+0xd0>
80103b81:	3b 42 20             	cmp    0x20(%edx),%eax
80103b84:	75 ea                	jne    80103b70 <exit+0xd0>
      p->state = RUNNABLE;
80103b86:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103b8d:	eb e1                	jmp    80103b70 <exit+0xd0>
  curproc->state = ZOMBIE;
80103b8f:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103b96:	e8 65 fe ff ff       	call   80103a00 <sched>
  panic("zombie exit");
80103b9b:	c7 04 24 9d 72 10 80 	movl   $0x8010729d,(%esp)
80103ba2:	e8 b9 c7 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103ba7:	c7 04 24 90 72 10 80 	movl   $0x80107290,(%esp)
80103bae:	e8 ad c7 ff ff       	call   80100360 <panic>
80103bb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103bc0 <yield>:
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103bc6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103bcd:	e8 ce 06 00 00       	call   801042a0 <acquire>
  myproc()->state = RUNNABLE;
80103bd2:	e8 c9 fa ff ff       	call   801036a0 <myproc>
80103bd7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103bde:	e8 1d fe ff ff       	call   80103a00 <sched>
  release(&ptable.lock);
80103be3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103bea:	e8 21 07 00 00       	call   80104310 <release>
}
80103bef:	c9                   	leave  
80103bf0:	c3                   	ret    
80103bf1:	eb 0d                	jmp    80103c00 <sleep>
80103bf3:	90                   	nop
80103bf4:	90                   	nop
80103bf5:	90                   	nop
80103bf6:	90                   	nop
80103bf7:	90                   	nop
80103bf8:	90                   	nop
80103bf9:	90                   	nop
80103bfa:	90                   	nop
80103bfb:	90                   	nop
80103bfc:	90                   	nop
80103bfd:	90                   	nop
80103bfe:	90                   	nop
80103bff:	90                   	nop

80103c00 <sleep>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 1c             	sub    $0x1c,%esp
80103c09:	8b 7d 08             	mov    0x8(%ebp),%edi
80103c0c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
80103c0f:	e8 8c fa ff ff       	call   801036a0 <myproc>
  if(p == 0)
80103c14:	85 c0                	test   %eax,%eax
  struct proc *p = myproc();
80103c16:	89 c3                	mov    %eax,%ebx
  if(p == 0)
80103c18:	0f 84 7c 00 00 00    	je     80103c9a <sleep+0x9a>
  if(lk == 0)
80103c1e:	85 f6                	test   %esi,%esi
80103c20:	74 6c                	je     80103c8e <sleep+0x8e>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103c22:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103c28:	74 46                	je     80103c70 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103c2a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c31:	e8 6a 06 00 00       	call   801042a0 <acquire>
    release(lk);
80103c36:	89 34 24             	mov    %esi,(%esp)
80103c39:	e8 d2 06 00 00       	call   80104310 <release>
  p->chan = chan;
80103c3e:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80103c41:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103c48:	e8 b3 fd ff ff       	call   80103a00 <sched>
  p->chan = 0;
80103c4d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80103c54:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c5b:	e8 b0 06 00 00       	call   80104310 <release>
    acquire(lk);
80103c60:	89 75 08             	mov    %esi,0x8(%ebp)
}
80103c63:	83 c4 1c             	add    $0x1c,%esp
80103c66:	5b                   	pop    %ebx
80103c67:	5e                   	pop    %esi
80103c68:	5f                   	pop    %edi
80103c69:	5d                   	pop    %ebp
    acquire(lk);
80103c6a:	e9 31 06 00 00       	jmp    801042a0 <acquire>
80103c6f:	90                   	nop
  p->chan = chan;
80103c70:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80103c73:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103c7a:	e8 81 fd ff ff       	call   80103a00 <sched>
  p->chan = 0;
80103c7f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103c86:	83 c4 1c             	add    $0x1c,%esp
80103c89:	5b                   	pop    %ebx
80103c8a:	5e                   	pop    %esi
80103c8b:	5f                   	pop    %edi
80103c8c:	5d                   	pop    %ebp
80103c8d:	c3                   	ret    
    panic("sleep without lk");
80103c8e:	c7 04 24 af 72 10 80 	movl   $0x801072af,(%esp)
80103c95:	e8 c6 c6 ff ff       	call   80100360 <panic>
    panic("sleep");
80103c9a:	c7 04 24 a9 72 10 80 	movl   $0x801072a9,(%esp)
80103ca1:	e8 ba c6 ff ff       	call   80100360 <panic>
80103ca6:	8d 76 00             	lea    0x0(%esi),%esi
80103ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cb0 <wait>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
80103cb5:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103cb8:	e8 e3 f9 ff ff       	call   801036a0 <myproc>
  acquire(&ptable.lock);
80103cbd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  struct proc *curproc = myproc();
80103cc4:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80103cc6:	e8 d5 05 00 00       	call   801042a0 <acquire>
    havekids = 0;
80103ccb:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ccd:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103cd2:	eb 0f                	jmp    80103ce3 <wait+0x33>
80103cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cd8:	83 c3 7c             	add    $0x7c,%ebx
80103cdb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103ce1:	74 1d                	je     80103d00 <wait+0x50>
      if(p->parent != curproc)
80103ce3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ce6:	75 f0                	jne    80103cd8 <wait+0x28>
      if(p->state == ZOMBIE){
80103ce8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103cec:	74 2f                	je     80103d1d <wait+0x6d>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cee:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103cf1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf6:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103cfc:	75 e5                	jne    80103ce3 <wait+0x33>
80103cfe:	66 90                	xchg   %ax,%ax
    if(!havekids || curproc->killed){
80103d00:	85 c0                	test   %eax,%eax
80103d02:	74 6e                	je     80103d72 <wait+0xc2>
80103d04:	8b 46 24             	mov    0x24(%esi),%eax
80103d07:	85 c0                	test   %eax,%eax
80103d09:	75 67                	jne    80103d72 <wait+0xc2>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103d0b:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103d12:	80 
80103d13:	89 34 24             	mov    %esi,(%esp)
80103d16:	e8 e5 fe ff ff       	call   80103c00 <sleep>
  }
80103d1b:	eb ae                	jmp    80103ccb <wait+0x1b>
        kfree(p->kstack);
80103d1d:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
80103d20:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103d23:	89 04 24             	mov    %eax,(%esp)
80103d26:	e8 c5 e5 ff ff       	call   801022f0 <kfree>
        freevm(p->pgdir);
80103d2b:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
80103d2e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103d35:	89 04 24             	mov    %eax,(%esp)
80103d38:	e8 53 2c 00 00       	call   80106990 <freevm>
        release(&ptable.lock);
80103d3d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
        p->pid = 0;
80103d44:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103d4b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103d52:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103d56:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103d5d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103d64:	e8 a7 05 00 00       	call   80104310 <release>
}
80103d69:	83 c4 10             	add    $0x10,%esp
        return pid;
80103d6c:	89 f0                	mov    %esi,%eax
}
80103d6e:	5b                   	pop    %ebx
80103d6f:	5e                   	pop    %esi
80103d70:	5d                   	pop    %ebp
80103d71:	c3                   	ret    
      release(&ptable.lock);
80103d72:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d79:	e8 92 05 00 00       	call   80104310 <release>
}
80103d7e:	83 c4 10             	add    $0x10,%esp
      return -1;
80103d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d86:	5b                   	pop    %ebx
80103d87:	5e                   	pop    %esi
80103d88:	5d                   	pop    %ebp
80103d89:	c3                   	ret    
80103d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103d90 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	53                   	push   %ebx
80103d94:	83 ec 14             	sub    $0x14,%esp
80103d97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103d9a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103da1:	e8 fa 04 00 00       	call   801042a0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103dab:	eb 0d                	jmp    80103dba <wakeup+0x2a>
80103dad:	8d 76 00             	lea    0x0(%esi),%esi
80103db0:	83 c0 7c             	add    $0x7c,%eax
80103db3:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103db8:	74 1e                	je     80103dd8 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103dba:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dbe:	75 f0                	jne    80103db0 <wakeup+0x20>
80103dc0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103dc3:	75 eb                	jne    80103db0 <wakeup+0x20>
      p->state = RUNNABLE;
80103dc5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dcc:	83 c0 7c             	add    $0x7c,%eax
80103dcf:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103dd4:	75 e4                	jne    80103dba <wakeup+0x2a>
80103dd6:	66 90                	xchg   %ax,%ax
  wakeup1(chan);
  release(&ptable.lock);
80103dd8:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103ddf:	83 c4 14             	add    $0x14,%esp
80103de2:	5b                   	pop    %ebx
80103de3:	5d                   	pop    %ebp
  release(&ptable.lock);
80103de4:	e9 27 05 00 00       	jmp    80104310 <release>
80103de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103df0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	53                   	push   %ebx
80103df4:	83 ec 14             	sub    $0x14,%esp
80103df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103dfa:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e01:	e8 9a 04 00 00       	call   801042a0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e06:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103e0b:	eb 0d                	jmp    80103e1a <kill+0x2a>
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
80103e10:	83 c0 7c             	add    $0x7c,%eax
80103e13:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103e18:	74 36                	je     80103e50 <kill+0x60>
    if(p->pid == pid){
80103e1a:	39 58 10             	cmp    %ebx,0x10(%eax)
80103e1d:	75 f1                	jne    80103e10 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103e1f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80103e23:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80103e2a:	74 14                	je     80103e40 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103e2c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e33:	e8 d8 04 00 00       	call   80104310 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103e38:	83 c4 14             	add    $0x14,%esp
      return 0;
80103e3b:	31 c0                	xor    %eax,%eax
}
80103e3d:	5b                   	pop    %ebx
80103e3e:	5d                   	pop    %ebp
80103e3f:	c3                   	ret    
        p->state = RUNNABLE;
80103e40:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e47:	eb e3                	jmp    80103e2c <kill+0x3c>
80103e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103e50:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e57:	e8 b4 04 00 00       	call   80104310 <release>
}
80103e5c:	83 c4 14             	add    $0x14,%esp
  return -1;
80103e5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103e64:	5b                   	pop    %ebx
80103e65:	5d                   	pop    %ebp
80103e66:	c3                   	ret    
80103e67:	89 f6                	mov    %esi,%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	57                   	push   %edi
80103e74:	56                   	push   %esi
80103e75:	53                   	push   %ebx
80103e76:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103e7b:	83 ec 4c             	sub    $0x4c,%esp
80103e7e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80103e81:	eb 20                	jmp    80103ea3 <procdump+0x33>
80103e83:	90                   	nop
80103e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103e88:	c7 04 24 e2 72 10 80 	movl   $0x801072e2,(%esp)
80103e8f:	e8 bc c7 ff ff       	call   80100650 <cprintf>
80103e94:	83 c3 7c             	add    $0x7c,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e97:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80103e9d:	0f 84 8d 00 00 00    	je     80103f30 <procdump+0xc0>
    if(p->state == UNUSED)
80103ea3:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103ea6:	85 c0                	test   %eax,%eax
80103ea8:	74 ea                	je     80103e94 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103eaa:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80103ead:	ba c0 72 10 80       	mov    $0x801072c0,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80103eb2:	77 11                	ja     80103ec5 <procdump+0x55>
80103eb4:	8b 14 85 80 73 10 80 	mov    -0x7fef8c80(,%eax,4),%edx
      state = "???";
80103ebb:	b8 c0 72 10 80       	mov    $0x801072c0,%eax
80103ec0:	85 d2                	test   %edx,%edx
80103ec2:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80103ec5:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103ec8:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103ecc:	89 54 24 08          	mov    %edx,0x8(%esp)
80103ed0:	c7 04 24 c4 72 10 80 	movl   $0x801072c4,(%esp)
80103ed7:	89 44 24 04          	mov    %eax,0x4(%esp)
80103edb:	e8 70 c7 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80103ee0:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80103ee4:	75 a2                	jne    80103e88 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80103ee6:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103ee9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103eed:	8b 43 b0             	mov    -0x50(%ebx),%eax
80103ef0:	8d 7d c0             	lea    -0x40(%ebp),%edi
80103ef3:	8b 40 0c             	mov    0xc(%eax),%eax
80103ef6:	83 c0 08             	add    $0x8,%eax
80103ef9:	89 04 24             	mov    %eax,(%esp)
80103efc:	e8 4f 02 00 00       	call   80104150 <getcallerpcs>
80103f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80103f08:	8b 17                	mov    (%edi),%edx
80103f0a:	85 d2                	test   %edx,%edx
80103f0c:	0f 84 76 ff ff ff    	je     80103e88 <procdump+0x18>
        cprintf(" %p", pc[i]);
80103f12:	89 54 24 04          	mov    %edx,0x4(%esp)
80103f16:	83 c7 04             	add    $0x4,%edi
80103f19:	c7 04 24 01 6d 10 80 	movl   $0x80106d01,(%esp)
80103f20:	e8 2b c7 ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80103f25:	39 f7                	cmp    %esi,%edi
80103f27:	75 df                	jne    80103f08 <procdump+0x98>
80103f29:	e9 5a ff ff ff       	jmp    80103e88 <procdump+0x18>
80103f2e:	66 90                	xchg   %ax,%ax
  }
}
80103f30:	83 c4 4c             	add    $0x4c,%esp
80103f33:	5b                   	pop    %ebx
80103f34:	5e                   	pop    %esi
80103f35:	5f                   	pop    %edi
80103f36:	5d                   	pop    %ebp
80103f37:	c3                   	ret    
80103f38:	90                   	nop
80103f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f40 <getpinfo>:
int getpinfo()
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 14             	sub    $0x14,%esp
  asm volatile("sti");
80103f47:	fb                   	sti    
struct proc *p;
sti();
acquire(&ptable.lock);
80103f48:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f4f:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
80103f54:	e8 47 03 00 00       	call   801042a0 <acquire>
cprintf("name \t pid \t state \t \n");
80103f59:	c7 04 24 cd 72 10 80 	movl   $0x801072cd,(%esp)
80103f60:	e8 eb c6 ff ff       	call   80100650 <cprintf>
80103f65:	eb 16                	jmp    80103f7d <getpinfo+0x3d>
80103f67:	90                   	nop
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
  if(p->state == SLEEPING)
	  cprintf("%s \t %d \t SLEEPING \t  \n ", p->name,p->pid);
	else if(p->state == RUNNING)
80103f68:	83 f8 04             	cmp    $0x4,%eax
80103f6b:	74 53                	je     80103fc0 <getpinfo+0x80>
 	  cprintf("%s \t %d \t RUNNING \t \n ", p->name,p->pid);
	else if(p->state == RUNNABLE)
80103f6d:	83 f8 03             	cmp    $0x3,%eax
80103f70:	74 6e                	je     80103fe0 <getpinfo+0xa0>
80103f72:	83 c3 7c             	add    $0x7c,%ebx
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f75:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80103f7b:	74 2b                	je     80103fa8 <getpinfo+0x68>
  if(p->state == SLEEPING)
80103f7d:	8b 43 a0             	mov    -0x60(%ebx),%eax
80103f80:	83 f8 02             	cmp    $0x2,%eax
80103f83:	75 e3                	jne    80103f68 <getpinfo+0x28>
	  cprintf("%s \t %d \t SLEEPING \t  \n ", p->name,p->pid);
80103f85:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103f88:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103f8c:	83 c3 7c             	add    $0x7c,%ebx
80103f8f:	c7 04 24 e4 72 10 80 	movl   $0x801072e4,(%esp)
80103f96:	89 44 24 08          	mov    %eax,0x8(%esp)
80103f9a:	e8 b1 c6 ff ff       	call   80100650 <cprintf>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f9f:	81 fb c0 4c 11 80    	cmp    $0x80114cc0,%ebx
80103fa5:	75 d6                	jne    80103f7d <getpinfo+0x3d>
80103fa7:	90                   	nop
 	  cprintf("%s \t %d \t RUNNABLE \t  \n ", p->name,p->pid);
}
release(&ptable.lock);
80103fa8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103faf:	e8 5c 03 00 00       	call   80104310 <release>
return 22;
}
80103fb4:	83 c4 14             	add    $0x14,%esp
80103fb7:	b8 16 00 00 00       	mov    $0x16,%eax
80103fbc:	5b                   	pop    %ebx
80103fbd:	5d                   	pop    %ebp
80103fbe:	c3                   	ret    
80103fbf:	90                   	nop
 	  cprintf("%s \t %d \t RUNNING \t \n ", p->name,p->pid);
80103fc0:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103fc3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103fc7:	c7 04 24 fd 72 10 80 	movl   $0x801072fd,(%esp)
80103fce:	89 44 24 08          	mov    %eax,0x8(%esp)
80103fd2:	e8 79 c6 ff ff       	call   80100650 <cprintf>
80103fd7:	eb 99                	jmp    80103f72 <getpinfo+0x32>
80103fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 	  cprintf("%s \t %d \t RUNNABLE \t  \n ", p->name,p->pid);
80103fe0:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80103fe3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103fe7:	c7 04 24 14 73 10 80 	movl   $0x80107314,(%esp)
80103fee:	89 44 24 08          	mov    %eax,0x8(%esp)
80103ff2:	e8 59 c6 ff ff       	call   80100650 <cprintf>
80103ff7:	e9 76 ff ff ff       	jmp    80103f72 <getpinfo+0x32>
80103ffc:	66 90                	xchg   %ax,%ax
80103ffe:	66 90                	xchg   %ax,%ax

80104000 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	53                   	push   %ebx
80104004:	83 ec 14             	sub    $0x14,%esp
80104007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010400a:	c7 44 24 04 98 73 10 	movl   $0x80107398,0x4(%esp)
80104011:	80 
80104012:	8d 43 04             	lea    0x4(%ebx),%eax
80104015:	89 04 24             	mov    %eax,(%esp)
80104018:	e8 13 01 00 00       	call   80104130 <initlock>
  lk->name = name;
8010401d:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104020:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104026:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010402d:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104030:	83 c4 14             	add    $0x14,%esp
80104033:	5b                   	pop    %ebx
80104034:	5d                   	pop    %ebp
80104035:	c3                   	ret    
80104036:	8d 76 00             	lea    0x0(%esi),%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	56                   	push   %esi
80104044:	53                   	push   %ebx
80104045:	83 ec 10             	sub    $0x10,%esp
80104048:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010404b:	8d 73 04             	lea    0x4(%ebx),%esi
8010404e:	89 34 24             	mov    %esi,(%esp)
80104051:	e8 4a 02 00 00       	call   801042a0 <acquire>
  while (lk->locked) {
80104056:	8b 13                	mov    (%ebx),%edx
80104058:	85 d2                	test   %edx,%edx
8010405a:	74 16                	je     80104072 <acquiresleep+0x32>
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104060:	89 74 24 04          	mov    %esi,0x4(%esp)
80104064:	89 1c 24             	mov    %ebx,(%esp)
80104067:	e8 94 fb ff ff       	call   80103c00 <sleep>
  while (lk->locked) {
8010406c:	8b 03                	mov    (%ebx),%eax
8010406e:	85 c0                	test   %eax,%eax
80104070:	75 ee                	jne    80104060 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104072:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104078:	e8 23 f6 ff ff       	call   801036a0 <myproc>
8010407d:	8b 40 10             	mov    0x10(%eax),%eax
80104080:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104083:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104086:	83 c4 10             	add    $0x10,%esp
80104089:	5b                   	pop    %ebx
8010408a:	5e                   	pop    %esi
8010408b:	5d                   	pop    %ebp
  release(&lk->lk);
8010408c:	e9 7f 02 00 00       	jmp    80104310 <release>
80104091:	eb 0d                	jmp    801040a0 <releasesleep>
80104093:	90                   	nop
80104094:	90                   	nop
80104095:	90                   	nop
80104096:	90                   	nop
80104097:	90                   	nop
80104098:	90                   	nop
80104099:	90                   	nop
8010409a:	90                   	nop
8010409b:	90                   	nop
8010409c:	90                   	nop
8010409d:	90                   	nop
8010409e:	90                   	nop
8010409f:	90                   	nop

801040a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	56                   	push   %esi
801040a4:	53                   	push   %ebx
801040a5:	83 ec 10             	sub    $0x10,%esp
801040a8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040ab:	8d 73 04             	lea    0x4(%ebx),%esi
801040ae:	89 34 24             	mov    %esi,(%esp)
801040b1:	e8 ea 01 00 00       	call   801042a0 <acquire>
  lk->locked = 0;
801040b6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801040bc:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801040c3:	89 1c 24             	mov    %ebx,(%esp)
801040c6:	e8 c5 fc ff ff       	call   80103d90 <wakeup>
  release(&lk->lk);
801040cb:	89 75 08             	mov    %esi,0x8(%ebp)
}
801040ce:	83 c4 10             	add    $0x10,%esp
801040d1:	5b                   	pop    %ebx
801040d2:	5e                   	pop    %esi
801040d3:	5d                   	pop    %ebp
  release(&lk->lk);
801040d4:	e9 37 02 00 00       	jmp    80104310 <release>
801040d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
801040e4:	31 ff                	xor    %edi,%edi
{
801040e6:	56                   	push   %esi
801040e7:	53                   	push   %ebx
801040e8:	83 ec 1c             	sub    $0x1c,%esp
801040eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040ee:	8d 73 04             	lea    0x4(%ebx),%esi
801040f1:	89 34 24             	mov    %esi,(%esp)
801040f4:	e8 a7 01 00 00       	call   801042a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801040f9:	8b 03                	mov    (%ebx),%eax
801040fb:	85 c0                	test   %eax,%eax
801040fd:	74 13                	je     80104112 <holdingsleep+0x32>
801040ff:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104102:	e8 99 f5 ff ff       	call   801036a0 <myproc>
80104107:	3b 58 10             	cmp    0x10(%eax),%ebx
8010410a:	0f 94 c0             	sete   %al
8010410d:	0f b6 c0             	movzbl %al,%eax
80104110:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104112:	89 34 24             	mov    %esi,(%esp)
80104115:	e8 f6 01 00 00       	call   80104310 <release>
  return r;
}
8010411a:	83 c4 1c             	add    $0x1c,%esp
8010411d:	89 f8                	mov    %edi,%eax
8010411f:	5b                   	pop    %ebx
80104120:	5e                   	pop    %esi
80104121:	5f                   	pop    %edi
80104122:	5d                   	pop    %ebp
80104123:	c3                   	ret    
80104124:	66 90                	xchg   %ax,%ax
80104126:	66 90                	xchg   %ax,%ax
80104128:	66 90                	xchg   %ax,%ax
8010412a:	66 90                	xchg   %ax,%ax
8010412c:	66 90                	xchg   %ax,%ax
8010412e:	66 90                	xchg   %ax,%ax

80104130 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104136:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104139:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010413f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104142:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104149:	5d                   	pop    %ebp
8010414a:	c3                   	ret    
8010414b:	90                   	nop
8010414c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104150 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104153:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104156:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104159:	53                   	push   %ebx
  ebp = (uint*)v - 2;
8010415a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
8010415d:	31 c0                	xor    %eax,%eax
8010415f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104160:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104166:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010416c:	77 1a                	ja     80104188 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010416e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104171:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104174:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104177:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104179:	83 f8 0a             	cmp    $0xa,%eax
8010417c:	75 e2                	jne    80104160 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010417e:	5b                   	pop    %ebx
8010417f:	5d                   	pop    %ebp
80104180:	c3                   	ret    
80104181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104188:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010418f:	83 c0 01             	add    $0x1,%eax
80104192:	83 f8 0a             	cmp    $0xa,%eax
80104195:	74 e7                	je     8010417e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104197:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
8010419e:	83 c0 01             	add    $0x1,%eax
801041a1:	83 f8 0a             	cmp    $0xa,%eax
801041a4:	75 e2                	jne    80104188 <getcallerpcs+0x38>
801041a6:	eb d6                	jmp    8010417e <getcallerpcs+0x2e>
801041a8:	90                   	nop
801041a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041b0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041b7:	9c                   	pushf  
801041b8:	5b                   	pop    %ebx
  asm volatile("cli");
801041b9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801041ba:	e8 41 f4 ff ff       	call   80103600 <mycpu>
801041bf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801041c5:	85 c0                	test   %eax,%eax
801041c7:	75 11                	jne    801041da <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801041c9:	e8 32 f4 ff ff       	call   80103600 <mycpu>
801041ce:	81 e3 00 02 00 00    	and    $0x200,%ebx
801041d4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801041da:	e8 21 f4 ff ff       	call   80103600 <mycpu>
801041df:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801041e6:	83 c4 04             	add    $0x4,%esp
801041e9:	5b                   	pop    %ebx
801041ea:	5d                   	pop    %ebp
801041eb:	c3                   	ret    
801041ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041f0 <popcli>:

void
popcli(void)
{
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041f6:	9c                   	pushf  
801041f7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801041f8:	f6 c4 02             	test   $0x2,%ah
801041fb:	75 49                	jne    80104246 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801041fd:	e8 fe f3 ff ff       	call   80103600 <mycpu>
80104202:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104208:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010420b:	85 d2                	test   %edx,%edx
8010420d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104213:	78 25                	js     8010423a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104215:	e8 e6 f3 ff ff       	call   80103600 <mycpu>
8010421a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104220:	85 d2                	test   %edx,%edx
80104222:	74 04                	je     80104228 <popcli+0x38>
    sti();
}
80104224:	c9                   	leave  
80104225:	c3                   	ret    
80104226:	66 90                	xchg   %ax,%ax
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104228:	e8 d3 f3 ff ff       	call   80103600 <mycpu>
8010422d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104233:	85 c0                	test   %eax,%eax
80104235:	74 ed                	je     80104224 <popcli+0x34>
  asm volatile("sti");
80104237:	fb                   	sti    
}
80104238:	c9                   	leave  
80104239:	c3                   	ret    
    panic("popcli");
8010423a:	c7 04 24 ba 73 10 80 	movl   $0x801073ba,(%esp)
80104241:	e8 1a c1 ff ff       	call   80100360 <panic>
    panic("popcli - interruptible");
80104246:	c7 04 24 a3 73 10 80 	movl   $0x801073a3,(%esp)
8010424d:	e8 0e c1 ff ff       	call   80100360 <panic>
80104252:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <holding>:
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
  r = lock->locked && lock->cpu == mycpu();
80104264:	31 f6                	xor    %esi,%esi
{
80104266:	53                   	push   %ebx
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010426a:	e8 41 ff ff ff       	call   801041b0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010426f:	8b 03                	mov    (%ebx),%eax
80104271:	85 c0                	test   %eax,%eax
80104273:	74 12                	je     80104287 <holding+0x27>
80104275:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104278:	e8 83 f3 ff ff       	call   80103600 <mycpu>
8010427d:	39 c3                	cmp    %eax,%ebx
8010427f:	0f 94 c0             	sete   %al
80104282:	0f b6 c0             	movzbl %al,%eax
80104285:	89 c6                	mov    %eax,%esi
  popcli();
80104287:	e8 64 ff ff ff       	call   801041f0 <popcli>
}
8010428c:	89 f0                	mov    %esi,%eax
8010428e:	5b                   	pop    %ebx
8010428f:	5e                   	pop    %esi
80104290:	5d                   	pop    %ebp
80104291:	c3                   	ret    
80104292:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042a0 <acquire>:
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	53                   	push   %ebx
801042a4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801042a7:	e8 04 ff ff ff       	call   801041b0 <pushcli>
  if(holding(lk))
801042ac:	8b 45 08             	mov    0x8(%ebp),%eax
801042af:	89 04 24             	mov    %eax,(%esp)
801042b2:	e8 a9 ff ff ff       	call   80104260 <holding>
801042b7:	85 c0                	test   %eax,%eax
801042b9:	75 3a                	jne    801042f5 <acquire+0x55>
  asm volatile("lock; xchgl %0, %1" :
801042bb:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
801042c0:	8b 55 08             	mov    0x8(%ebp),%edx
801042c3:	89 c8                	mov    %ecx,%eax
801042c5:	f0 87 02             	lock xchg %eax,(%edx)
801042c8:	85 c0                	test   %eax,%eax
801042ca:	75 f4                	jne    801042c0 <acquire+0x20>
  __sync_synchronize();
801042cc:	0f ae f0             	mfence 
  lk->cpu = mycpu();
801042cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042d2:	e8 29 f3 ff ff       	call   80103600 <mycpu>
801042d7:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
801042da:	8b 45 08             	mov    0x8(%ebp),%eax
801042dd:	83 c0 0c             	add    $0xc,%eax
801042e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801042e4:	8d 45 08             	lea    0x8(%ebp),%eax
801042e7:	89 04 24             	mov    %eax,(%esp)
801042ea:	e8 61 fe ff ff       	call   80104150 <getcallerpcs>
}
801042ef:	83 c4 14             	add    $0x14,%esp
801042f2:	5b                   	pop    %ebx
801042f3:	5d                   	pop    %ebp
801042f4:	c3                   	ret    
    panic("acquire");
801042f5:	c7 04 24 c1 73 10 80 	movl   $0x801073c1,(%esp)
801042fc:	e8 5f c0 ff ff       	call   80100360 <panic>
80104301:	eb 0d                	jmp    80104310 <release>
80104303:	90                   	nop
80104304:	90                   	nop
80104305:	90                   	nop
80104306:	90                   	nop
80104307:	90                   	nop
80104308:	90                   	nop
80104309:	90                   	nop
8010430a:	90                   	nop
8010430b:	90                   	nop
8010430c:	90                   	nop
8010430d:	90                   	nop
8010430e:	90                   	nop
8010430f:	90                   	nop

80104310 <release>:
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	53                   	push   %ebx
80104314:	83 ec 14             	sub    $0x14,%esp
80104317:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010431a:	89 1c 24             	mov    %ebx,(%esp)
8010431d:	e8 3e ff ff ff       	call   80104260 <holding>
80104322:	85 c0                	test   %eax,%eax
80104324:	74 21                	je     80104347 <release+0x37>
  lk->pcs[0] = 0;
80104326:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010432d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104334:	0f ae f0             	mfence 
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104337:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010433d:	83 c4 14             	add    $0x14,%esp
80104340:	5b                   	pop    %ebx
80104341:	5d                   	pop    %ebp
  popcli();
80104342:	e9 a9 fe ff ff       	jmp    801041f0 <popcli>
    panic("release");
80104347:	c7 04 24 c9 73 10 80 	movl   $0x801073c9,(%esp)
8010434e:	e8 0d c0 ff ff       	call   80100360 <panic>
80104353:	66 90                	xchg   %ax,%ax
80104355:	66 90                	xchg   %ax,%ax
80104357:	66 90                	xchg   %ax,%ax
80104359:	66 90                	xchg   %ax,%ax
8010435b:	66 90                	xchg   %ax,%ax
8010435d:	66 90                	xchg   %ax,%ax
8010435f:	90                   	nop

80104360 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	8b 55 08             	mov    0x8(%ebp),%edx
80104366:	57                   	push   %edi
80104367:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010436a:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
8010436b:	f6 c2 03             	test   $0x3,%dl
8010436e:	75 05                	jne    80104375 <memset+0x15>
80104370:	f6 c1 03             	test   $0x3,%cl
80104373:	74 13                	je     80104388 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104375:	89 d7                	mov    %edx,%edi
80104377:	8b 45 0c             	mov    0xc(%ebp),%eax
8010437a:	fc                   	cld    
8010437b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010437d:	5b                   	pop    %ebx
8010437e:	89 d0                	mov    %edx,%eax
80104380:	5f                   	pop    %edi
80104381:	5d                   	pop    %ebp
80104382:	c3                   	ret    
80104383:	90                   	nop
80104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104388:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
8010438c:	c1 e9 02             	shr    $0x2,%ecx
8010438f:	89 f8                	mov    %edi,%eax
80104391:	89 fb                	mov    %edi,%ebx
80104393:	c1 e0 18             	shl    $0x18,%eax
80104396:	c1 e3 10             	shl    $0x10,%ebx
80104399:	09 d8                	or     %ebx,%eax
8010439b:	09 f8                	or     %edi,%eax
8010439d:	c1 e7 08             	shl    $0x8,%edi
801043a0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801043a2:	89 d7                	mov    %edx,%edi
801043a4:	fc                   	cld    
801043a5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801043a7:	5b                   	pop    %ebx
801043a8:	89 d0                	mov    %edx,%eax
801043aa:	5f                   	pop    %edi
801043ab:	5d                   	pop    %ebp
801043ac:	c3                   	ret    
801043ad:	8d 76 00             	lea    0x0(%esi),%esi

801043b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	8b 45 10             	mov    0x10(%ebp),%eax
801043b6:	57                   	push   %edi
801043b7:	56                   	push   %esi
801043b8:	8b 75 0c             	mov    0xc(%ebp),%esi
801043bb:	53                   	push   %ebx
801043bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801043bf:	85 c0                	test   %eax,%eax
801043c1:	8d 78 ff             	lea    -0x1(%eax),%edi
801043c4:	74 26                	je     801043ec <memcmp+0x3c>
    if(*s1 != *s2)
801043c6:	0f b6 03             	movzbl (%ebx),%eax
801043c9:	31 d2                	xor    %edx,%edx
801043cb:	0f b6 0e             	movzbl (%esi),%ecx
801043ce:	38 c8                	cmp    %cl,%al
801043d0:	74 16                	je     801043e8 <memcmp+0x38>
801043d2:	eb 24                	jmp    801043f8 <memcmp+0x48>
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043d8:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
801043dd:	83 c2 01             	add    $0x1,%edx
801043e0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801043e4:	38 c8                	cmp    %cl,%al
801043e6:	75 10                	jne    801043f8 <memcmp+0x48>
  while(n-- > 0){
801043e8:	39 fa                	cmp    %edi,%edx
801043ea:	75 ec                	jne    801043d8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801043ec:	5b                   	pop    %ebx
  return 0;
801043ed:	31 c0                	xor    %eax,%eax
}
801043ef:	5e                   	pop    %esi
801043f0:	5f                   	pop    %edi
801043f1:	5d                   	pop    %ebp
801043f2:	c3                   	ret    
801043f3:	90                   	nop
801043f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043f8:	5b                   	pop    %ebx
      return *s1 - *s2;
801043f9:	29 c8                	sub    %ecx,%eax
}
801043fb:	5e                   	pop    %esi
801043fc:	5f                   	pop    %edi
801043fd:	5d                   	pop    %ebp
801043fe:	c3                   	ret    
801043ff:	90                   	nop

80104400 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	8b 45 08             	mov    0x8(%ebp),%eax
80104407:	56                   	push   %esi
80104408:	8b 75 0c             	mov    0xc(%ebp),%esi
8010440b:	53                   	push   %ebx
8010440c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010440f:	39 c6                	cmp    %eax,%esi
80104411:	73 35                	jae    80104448 <memmove+0x48>
80104413:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104416:	39 c8                	cmp    %ecx,%eax
80104418:	73 2e                	jae    80104448 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
8010441a:	85 db                	test   %ebx,%ebx
    d += n;
8010441c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
8010441f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104422:	74 1b                	je     8010443f <memmove+0x3f>
80104424:	f7 db                	neg    %ebx
80104426:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104429:	01 fb                	add    %edi,%ebx
8010442b:	90                   	nop
8010442c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104430:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104434:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
    while(n-- > 0)
80104437:	83 ea 01             	sub    $0x1,%edx
8010443a:	83 fa ff             	cmp    $0xffffffff,%edx
8010443d:	75 f1                	jne    80104430 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010443f:	5b                   	pop    %ebx
80104440:	5e                   	pop    %esi
80104441:	5f                   	pop    %edi
80104442:	5d                   	pop    %ebp
80104443:	c3                   	ret    
80104444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104448:	31 d2                	xor    %edx,%edx
8010444a:	85 db                	test   %ebx,%ebx
8010444c:	74 f1                	je     8010443f <memmove+0x3f>
8010444e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104450:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104454:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104457:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010445a:	39 da                	cmp    %ebx,%edx
8010445c:	75 f2                	jne    80104450 <memmove+0x50>
}
8010445e:	5b                   	pop    %ebx
8010445f:	5e                   	pop    %esi
80104460:	5f                   	pop    %edi
80104461:	5d                   	pop    %ebp
80104462:	c3                   	ret    
80104463:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104470 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104473:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104474:	eb 8a                	jmp    80104400 <memmove>
80104476:	8d 76 00             	lea    0x0(%esi),%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	56                   	push   %esi
80104484:	8b 75 10             	mov    0x10(%ebp),%esi
80104487:	53                   	push   %ebx
80104488:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010448b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010448e:	85 f6                	test   %esi,%esi
80104490:	74 30                	je     801044c2 <strncmp+0x42>
80104492:	0f b6 01             	movzbl (%ecx),%eax
80104495:	84 c0                	test   %al,%al
80104497:	74 2f                	je     801044c8 <strncmp+0x48>
80104499:	0f b6 13             	movzbl (%ebx),%edx
8010449c:	38 d0                	cmp    %dl,%al
8010449e:	75 46                	jne    801044e6 <strncmp+0x66>
801044a0:	8d 51 01             	lea    0x1(%ecx),%edx
801044a3:	01 ce                	add    %ecx,%esi
801044a5:	eb 14                	jmp    801044bb <strncmp+0x3b>
801044a7:	90                   	nop
801044a8:	0f b6 02             	movzbl (%edx),%eax
801044ab:	84 c0                	test   %al,%al
801044ad:	74 31                	je     801044e0 <strncmp+0x60>
801044af:	0f b6 19             	movzbl (%ecx),%ebx
801044b2:	83 c2 01             	add    $0x1,%edx
801044b5:	38 d8                	cmp    %bl,%al
801044b7:	75 17                	jne    801044d0 <strncmp+0x50>
    n--, p++, q++;
801044b9:	89 cb                	mov    %ecx,%ebx
  while(n > 0 && *p && *p == *q)
801044bb:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
801044bd:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(n > 0 && *p && *p == *q)
801044c0:	75 e6                	jne    801044a8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801044c2:	5b                   	pop    %ebx
    return 0;
801044c3:	31 c0                	xor    %eax,%eax
}
801044c5:	5e                   	pop    %esi
801044c6:	5d                   	pop    %ebp
801044c7:	c3                   	ret    
801044c8:	0f b6 1b             	movzbl (%ebx),%ebx
  while(n > 0 && *p && *p == *q)
801044cb:	31 c0                	xor    %eax,%eax
801044cd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
801044d0:	0f b6 d3             	movzbl %bl,%edx
801044d3:	29 d0                	sub    %edx,%eax
}
801044d5:	5b                   	pop    %ebx
801044d6:	5e                   	pop    %esi
801044d7:	5d                   	pop    %ebp
801044d8:	c3                   	ret    
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044e0:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
801044e4:	eb ea                	jmp    801044d0 <strncmp+0x50>
  while(n > 0 && *p && *p == *q)
801044e6:	89 d3                	mov    %edx,%ebx
801044e8:	eb e6                	jmp    801044d0 <strncmp+0x50>
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801044f0:	55                   	push   %ebp
801044f1:	89 e5                	mov    %esp,%ebp
801044f3:	8b 45 08             	mov    0x8(%ebp),%eax
801044f6:	56                   	push   %esi
801044f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801044fa:	53                   	push   %ebx
801044fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801044fe:	89 c2                	mov    %eax,%edx
80104500:	eb 19                	jmp    8010451b <strncpy+0x2b>
80104502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104508:	83 c3 01             	add    $0x1,%ebx
8010450b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010450f:	83 c2 01             	add    $0x1,%edx
80104512:	84 c9                	test   %cl,%cl
80104514:	88 4a ff             	mov    %cl,-0x1(%edx)
80104517:	74 09                	je     80104522 <strncpy+0x32>
80104519:	89 f1                	mov    %esi,%ecx
8010451b:	85 c9                	test   %ecx,%ecx
8010451d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104520:	7f e6                	jg     80104508 <strncpy+0x18>
    ;
  while(n-- > 0)
80104522:	31 c9                	xor    %ecx,%ecx
80104524:	85 f6                	test   %esi,%esi
80104526:	7e 0f                	jle    80104537 <strncpy+0x47>
    *s++ = 0;
80104528:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010452c:	89 f3                	mov    %esi,%ebx
8010452e:	83 c1 01             	add    $0x1,%ecx
80104531:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104533:	85 db                	test   %ebx,%ebx
80104535:	7f f1                	jg     80104528 <strncpy+0x38>
  return os;
}
80104537:	5b                   	pop    %ebx
80104538:	5e                   	pop    %esi
80104539:	5d                   	pop    %ebp
8010453a:	c3                   	ret    
8010453b:	90                   	nop
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104546:	56                   	push   %esi
80104547:	8b 45 08             	mov    0x8(%ebp),%eax
8010454a:	53                   	push   %ebx
8010454b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010454e:	85 c9                	test   %ecx,%ecx
80104550:	7e 26                	jle    80104578 <safestrcpy+0x38>
80104552:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104556:	89 c1                	mov    %eax,%ecx
80104558:	eb 17                	jmp    80104571 <safestrcpy+0x31>
8010455a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104560:	83 c2 01             	add    $0x1,%edx
80104563:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104567:	83 c1 01             	add    $0x1,%ecx
8010456a:	84 db                	test   %bl,%bl
8010456c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010456f:	74 04                	je     80104575 <safestrcpy+0x35>
80104571:	39 f2                	cmp    %esi,%edx
80104573:	75 eb                	jne    80104560 <safestrcpy+0x20>
    ;
  *s = 0;
80104575:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104578:	5b                   	pop    %ebx
80104579:	5e                   	pop    %esi
8010457a:	5d                   	pop    %ebp
8010457b:	c3                   	ret    
8010457c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104580 <strlen>:

int
strlen(const char *s)
{
80104580:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104581:	31 c0                	xor    %eax,%eax
{
80104583:	89 e5                	mov    %esp,%ebp
80104585:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104588:	80 3a 00             	cmpb   $0x0,(%edx)
8010458b:	74 0c                	je     80104599 <strlen+0x19>
8010458d:	8d 76 00             	lea    0x0(%esi),%esi
80104590:	83 c0 01             	add    $0x1,%eax
80104593:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104597:	75 f7                	jne    80104590 <strlen+0x10>
    ;
  return n;
}
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret    

8010459b <swtch>:
8010459b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010459f:	8b 54 24 08          	mov    0x8(%esp),%edx
801045a3:	55                   	push   %ebp
801045a4:	53                   	push   %ebx
801045a5:	56                   	push   %esi
801045a6:	57                   	push   %edi
801045a7:	89 20                	mov    %esp,(%eax)
801045a9:	89 d4                	mov    %edx,%esp
801045ab:	5f                   	pop    %edi
801045ac:	5e                   	pop    %esi
801045ad:	5b                   	pop    %ebx
801045ae:	5d                   	pop    %ebp
801045af:	c3                   	ret    

801045b0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 04             	sub    $0x4,%esp
801045b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801045ba:	e8 e1 f0 ff ff       	call   801036a0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801045bf:	8b 00                	mov    (%eax),%eax
801045c1:	39 d8                	cmp    %ebx,%eax
801045c3:	76 1b                	jbe    801045e0 <fetchint+0x30>
801045c5:	8d 53 04             	lea    0x4(%ebx),%edx
801045c8:	39 d0                	cmp    %edx,%eax
801045ca:	72 14                	jb     801045e0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801045cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801045cf:	8b 13                	mov    (%ebx),%edx
801045d1:	89 10                	mov    %edx,(%eax)
  return 0;
801045d3:	31 c0                	xor    %eax,%eax
}
801045d5:	83 c4 04             	add    $0x4,%esp
801045d8:	5b                   	pop    %ebx
801045d9:	5d                   	pop    %ebp
801045da:	c3                   	ret    
801045db:	90                   	nop
801045dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801045e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801045e5:	eb ee                	jmp    801045d5 <fetchint+0x25>
801045e7:	89 f6                	mov    %esi,%esi
801045e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045f0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	53                   	push   %ebx
801045f4:	83 ec 04             	sub    $0x4,%esp
801045f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801045fa:	e8 a1 f0 ff ff       	call   801036a0 <myproc>

  if(addr >= curproc->sz)
801045ff:	39 18                	cmp    %ebx,(%eax)
80104601:	76 26                	jbe    80104629 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104603:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104606:	89 da                	mov    %ebx,%edx
80104608:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010460a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010460c:	39 c3                	cmp    %eax,%ebx
8010460e:	73 19                	jae    80104629 <fetchstr+0x39>
    if(*s == 0)
80104610:	80 3b 00             	cmpb   $0x0,(%ebx)
80104613:	75 0d                	jne    80104622 <fetchstr+0x32>
80104615:	eb 21                	jmp    80104638 <fetchstr+0x48>
80104617:	90                   	nop
80104618:	80 3a 00             	cmpb   $0x0,(%edx)
8010461b:	90                   	nop
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104620:	74 16                	je     80104638 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80104622:	83 c2 01             	add    $0x1,%edx
80104625:	39 d0                	cmp    %edx,%eax
80104627:	77 ef                	ja     80104618 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104629:	83 c4 04             	add    $0x4,%esp
    return -1;
8010462c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104631:	5b                   	pop    %ebx
80104632:	5d                   	pop    %ebp
80104633:	c3                   	ret    
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104638:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010463b:	89 d0                	mov    %edx,%eax
8010463d:	29 d8                	sub    %ebx,%eax
}
8010463f:	5b                   	pop    %ebx
80104640:	5d                   	pop    %ebp
80104641:	c3                   	ret    
80104642:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	56                   	push   %esi
80104654:	8b 75 0c             	mov    0xc(%ebp),%esi
80104657:	53                   	push   %ebx
80104658:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010465b:	e8 40 f0 ff ff       	call   801036a0 <myproc>
80104660:	89 75 0c             	mov    %esi,0xc(%ebp)
80104663:	8b 40 18             	mov    0x18(%eax),%eax
80104666:	8b 40 44             	mov    0x44(%eax),%eax
80104669:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010466d:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104670:	5b                   	pop    %ebx
80104671:	5e                   	pop    %esi
80104672:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104673:	e9 38 ff ff ff       	jmp    801045b0 <fetchint>
80104678:	90                   	nop
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104680 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	56                   	push   %esi
80104684:	53                   	push   %ebx
80104685:	83 ec 20             	sub    $0x20,%esp
80104688:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010468b:	e8 10 f0 ff ff       	call   801036a0 <myproc>
80104690:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104692:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104695:	89 44 24 04          	mov    %eax,0x4(%esp)
80104699:	8b 45 08             	mov    0x8(%ebp),%eax
8010469c:	89 04 24             	mov    %eax,(%esp)
8010469f:	e8 ac ff ff ff       	call   80104650 <argint>
801046a4:	85 c0                	test   %eax,%eax
801046a6:	78 28                	js     801046d0 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801046a8:	85 db                	test   %ebx,%ebx
801046aa:	78 24                	js     801046d0 <argptr+0x50>
801046ac:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046af:	8b 06                	mov    (%esi),%eax
801046b1:	39 c2                	cmp    %eax,%edx
801046b3:	73 1b                	jae    801046d0 <argptr+0x50>
801046b5:	01 d3                	add    %edx,%ebx
801046b7:	39 d8                	cmp    %ebx,%eax
801046b9:	72 15                	jb     801046d0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801046bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801046be:	89 10                	mov    %edx,(%eax)
  return 0;
}
801046c0:	83 c4 20             	add    $0x20,%esp
  return 0;
801046c3:	31 c0                	xor    %eax,%eax
}
801046c5:	5b                   	pop    %ebx
801046c6:	5e                   	pop    %esi
801046c7:	5d                   	pop    %ebp
801046c8:	c3                   	ret    
801046c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046d0:	83 c4 20             	add    $0x20,%esp
    return -1;
801046d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801046d8:	5b                   	pop    %ebx
801046d9:	5e                   	pop    %esi
801046da:	5d                   	pop    %ebp
801046db:	c3                   	ret    
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801046e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801046e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801046ed:	8b 45 08             	mov    0x8(%ebp),%eax
801046f0:	89 04 24             	mov    %eax,(%esp)
801046f3:	e8 58 ff ff ff       	call   80104650 <argint>
801046f8:	85 c0                	test   %eax,%eax
801046fa:	78 14                	js     80104710 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801046fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801046ff:	89 44 24 04          	mov    %eax,0x4(%esp)
80104703:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104706:	89 04 24             	mov    %eax,(%esp)
80104709:	e8 e2 fe ff ff       	call   801045f0 <fetchstr>
}
8010470e:	c9                   	leave  
8010470f:	c3                   	ret    
    return -1;
80104710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104715:	c9                   	leave  
80104716:	c3                   	ret    
80104717:	89 f6                	mov    %esi,%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <syscall>:
[SYS_getpinfo] sys_getpinfo,
};

void
syscall(void)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104728:	e8 73 ef ff ff       	call   801036a0 <myproc>

  num = curproc->tf->eax;
8010472d:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
80104730:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104732:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104735:	8d 50 ff             	lea    -0x1(%eax),%edx
80104738:	83 fa 15             	cmp    $0x15,%edx
8010473b:	77 1b                	ja     80104758 <syscall+0x38>
8010473d:	8b 14 85 00 74 10 80 	mov    -0x7fef8c00(,%eax,4),%edx
80104744:	85 d2                	test   %edx,%edx
80104746:	74 10                	je     80104758 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104748:	ff d2                	call   *%edx
8010474a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010474d:	83 c4 10             	add    $0x10,%esp
80104750:	5b                   	pop    %ebx
80104751:	5e                   	pop    %esi
80104752:	5d                   	pop    %ebp
80104753:	c3                   	ret    
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104758:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010475c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010475f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104763:	8b 43 10             	mov    0x10(%ebx),%eax
80104766:	c7 04 24 d1 73 10 80 	movl   $0x801073d1,(%esp)
8010476d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104771:	e8 da be ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80104776:	8b 43 18             	mov    0x18(%ebx),%eax
80104779:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104780:	83 c4 10             	add    $0x10,%esp
80104783:	5b                   	pop    %ebx
80104784:	5e                   	pop    %esi
80104785:	5d                   	pop    %ebp
80104786:	c3                   	ret    
80104787:	66 90                	xchg   %ax,%ax
80104789:	66 90                	xchg   %ax,%ax
8010478b:	66 90                	xchg   %ax,%ax
8010478d:	66 90                	xchg   %ax,%ax
8010478f:	90                   	nop

80104790 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	89 c3                	mov    %eax,%ebx
80104796:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104799:	e8 02 ef ff ff       	call   801036a0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010479e:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
801047a0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801047a4:	85 c9                	test   %ecx,%ecx
801047a6:	74 18                	je     801047c0 <fdalloc+0x30>
  for(fd = 0; fd < NOFILE; fd++){
801047a8:	83 c2 01             	add    $0x1,%edx
801047ab:	83 fa 10             	cmp    $0x10,%edx
801047ae:	75 f0                	jne    801047a0 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
801047b0:	83 c4 04             	add    $0x4,%esp
  return -1;
801047b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801047b8:	5b                   	pop    %ebx
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801047c0:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
}
801047c4:	83 c4 04             	add    $0x4,%esp
      return fd;
801047c7:	89 d0                	mov    %edx,%eax
}
801047c9:	5b                   	pop    %ebx
801047ca:	5d                   	pop    %ebp
801047cb:	c3                   	ret    
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801047d0:	55                   	push   %ebp
801047d1:	89 e5                	mov    %esp,%ebp
801047d3:	57                   	push   %edi
801047d4:	56                   	push   %esi
801047d5:	53                   	push   %ebx
801047d6:	83 ec 3c             	sub    $0x3c,%esp
801047d9:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801047dc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801047df:	8d 5d da             	lea    -0x26(%ebp),%ebx
801047e2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801047e6:	89 04 24             	mov    %eax,(%esp)
{
801047e9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801047ec:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801047ef:	e8 2c d7 ff ff       	call   80101f20 <nameiparent>
801047f4:	85 c0                	test   %eax,%eax
801047f6:	89 c7                	mov    %eax,%edi
801047f8:	0f 84 da 00 00 00    	je     801048d8 <create+0x108>
    return 0;
  ilock(dp);
801047fe:	89 04 24             	mov    %eax,(%esp)
80104801:	e8 aa ce ff ff       	call   801016b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104806:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010480d:	00 
8010480e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104812:	89 3c 24             	mov    %edi,(%esp)
80104815:	e8 a6 d3 ff ff       	call   80101bc0 <dirlookup>
8010481a:	85 c0                	test   %eax,%eax
8010481c:	89 c6                	mov    %eax,%esi
8010481e:	74 40                	je     80104860 <create+0x90>
    iunlockput(dp);
80104820:	89 3c 24             	mov    %edi,(%esp)
80104823:	e8 e8 d0 ff ff       	call   80101910 <iunlockput>
    ilock(ip);
80104828:	89 34 24             	mov    %esi,(%esp)
8010482b:	e8 80 ce ff ff       	call   801016b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104830:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104835:	75 11                	jne    80104848 <create+0x78>
80104837:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010483c:	89 f0                	mov    %esi,%eax
8010483e:	75 08                	jne    80104848 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104840:	83 c4 3c             	add    $0x3c,%esp
80104843:	5b                   	pop    %ebx
80104844:	5e                   	pop    %esi
80104845:	5f                   	pop    %edi
80104846:	5d                   	pop    %ebp
80104847:	c3                   	ret    
    iunlockput(ip);
80104848:	89 34 24             	mov    %esi,(%esp)
8010484b:	e8 c0 d0 ff ff       	call   80101910 <iunlockput>
}
80104850:	83 c4 3c             	add    $0x3c,%esp
    return 0;
80104853:	31 c0                	xor    %eax,%eax
}
80104855:	5b                   	pop    %ebx
80104856:	5e                   	pop    %esi
80104857:	5f                   	pop    %edi
80104858:	5d                   	pop    %ebp
80104859:	c3                   	ret    
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104860:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104864:	89 44 24 04          	mov    %eax,0x4(%esp)
80104868:	8b 07                	mov    (%edi),%eax
8010486a:	89 04 24             	mov    %eax,(%esp)
8010486d:	e8 ae cc ff ff       	call   80101520 <ialloc>
80104872:	85 c0                	test   %eax,%eax
80104874:	89 c6                	mov    %eax,%esi
80104876:	0f 84 bf 00 00 00    	je     8010493b <create+0x16b>
  ilock(ip);
8010487c:	89 04 24             	mov    %eax,(%esp)
8010487f:	e8 2c ce ff ff       	call   801016b0 <ilock>
  ip->major = major;
80104884:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104888:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010488c:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104890:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104894:	b8 01 00 00 00       	mov    $0x1,%eax
80104899:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010489d:	89 34 24             	mov    %esi,(%esp)
801048a0:	e8 4b cd ff ff       	call   801015f0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801048a5:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801048aa:	74 34                	je     801048e0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
801048ac:	8b 46 04             	mov    0x4(%esi),%eax
801048af:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801048b3:	89 3c 24             	mov    %edi,(%esp)
801048b6:	89 44 24 08          	mov    %eax,0x8(%esp)
801048ba:	e8 61 d5 ff ff       	call   80101e20 <dirlink>
801048bf:	85 c0                	test   %eax,%eax
801048c1:	78 6c                	js     8010492f <create+0x15f>
  iunlockput(dp);
801048c3:	89 3c 24             	mov    %edi,(%esp)
801048c6:	e8 45 d0 ff ff       	call   80101910 <iunlockput>
}
801048cb:	83 c4 3c             	add    $0x3c,%esp
  return ip;
801048ce:	89 f0                	mov    %esi,%eax
}
801048d0:	5b                   	pop    %ebx
801048d1:	5e                   	pop    %esi
801048d2:	5f                   	pop    %edi
801048d3:	5d                   	pop    %ebp
801048d4:	c3                   	ret    
801048d5:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
801048d8:	31 c0                	xor    %eax,%eax
801048da:	e9 61 ff ff ff       	jmp    80104840 <create+0x70>
801048df:	90                   	nop
    dp->nlink++;  // for ".."
801048e0:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
801048e5:	89 3c 24             	mov    %edi,(%esp)
801048e8:	e8 03 cd ff ff       	call   801015f0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801048ed:	8b 46 04             	mov    0x4(%esi),%eax
801048f0:	c7 44 24 04 78 74 10 	movl   $0x80107478,0x4(%esp)
801048f7:	80 
801048f8:	89 34 24             	mov    %esi,(%esp)
801048fb:	89 44 24 08          	mov    %eax,0x8(%esp)
801048ff:	e8 1c d5 ff ff       	call   80101e20 <dirlink>
80104904:	85 c0                	test   %eax,%eax
80104906:	78 1b                	js     80104923 <create+0x153>
80104908:	8b 47 04             	mov    0x4(%edi),%eax
8010490b:	c7 44 24 04 77 74 10 	movl   $0x80107477,0x4(%esp)
80104912:	80 
80104913:	89 34 24             	mov    %esi,(%esp)
80104916:	89 44 24 08          	mov    %eax,0x8(%esp)
8010491a:	e8 01 d5 ff ff       	call   80101e20 <dirlink>
8010491f:	85 c0                	test   %eax,%eax
80104921:	79 89                	jns    801048ac <create+0xdc>
      panic("create dots");
80104923:	c7 04 24 6b 74 10 80 	movl   $0x8010746b,(%esp)
8010492a:	e8 31 ba ff ff       	call   80100360 <panic>
    panic("create: dirlink");
8010492f:	c7 04 24 7a 74 10 80 	movl   $0x8010747a,(%esp)
80104936:	e8 25 ba ff ff       	call   80100360 <panic>
    panic("create: ialloc");
8010493b:	c7 04 24 5c 74 10 80 	movl   $0x8010745c,(%esp)
80104942:	e8 19 ba ff ff       	call   80100360 <panic>
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	89 c6                	mov    %eax,%esi
80104956:	53                   	push   %ebx
80104957:	89 d3                	mov    %edx,%ebx
80104959:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
8010495c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010495f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104963:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010496a:	e8 e1 fc ff ff       	call   80104650 <argint>
8010496f:	85 c0                	test   %eax,%eax
80104971:	78 2d                	js     801049a0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104973:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104977:	77 27                	ja     801049a0 <argfd.constprop.0+0x50>
80104979:	e8 22 ed ff ff       	call   801036a0 <myproc>
8010497e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104981:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104985:	85 c0                	test   %eax,%eax
80104987:	74 17                	je     801049a0 <argfd.constprop.0+0x50>
  if(pfd)
80104989:	85 f6                	test   %esi,%esi
8010498b:	74 02                	je     8010498f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010498d:	89 16                	mov    %edx,(%esi)
  if(pf)
8010498f:	85 db                	test   %ebx,%ebx
80104991:	74 1d                	je     801049b0 <argfd.constprop.0+0x60>
    *pf = f;
80104993:	89 03                	mov    %eax,(%ebx)
  return 0;
80104995:	31 c0                	xor    %eax,%eax
}
80104997:	83 c4 20             	add    $0x20,%esp
8010499a:	5b                   	pop    %ebx
8010499b:	5e                   	pop    %esi
8010499c:	5d                   	pop    %ebp
8010499d:	c3                   	ret    
8010499e:	66 90                	xchg   %ax,%ax
801049a0:	83 c4 20             	add    $0x20,%esp
    return -1;
801049a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049a8:	5b                   	pop    %ebx
801049a9:	5e                   	pop    %esi
801049aa:	5d                   	pop    %ebp
801049ab:	c3                   	ret    
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
801049b0:	31 c0                	xor    %eax,%eax
801049b2:	eb e3                	jmp    80104997 <argfd.constprop.0+0x47>
801049b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049c0 <sys_dup>:
{
801049c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801049c1:	31 c0                	xor    %eax,%eax
{
801049c3:	89 e5                	mov    %esp,%ebp
801049c5:	53                   	push   %ebx
801049c6:	83 ec 24             	sub    $0x24,%esp
  if(argfd(0, 0, &f) < 0)
801049c9:	8d 55 f4             	lea    -0xc(%ebp),%edx
801049cc:	e8 7f ff ff ff       	call   80104950 <argfd.constprop.0>
801049d1:	85 c0                	test   %eax,%eax
801049d3:	78 23                	js     801049f8 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801049d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049d8:	e8 b3 fd ff ff       	call   80104790 <fdalloc>
801049dd:	85 c0                	test   %eax,%eax
801049df:	89 c3                	mov    %eax,%ebx
801049e1:	78 15                	js     801049f8 <sys_dup+0x38>
  filedup(f);
801049e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e6:	89 04 24             	mov    %eax,(%esp)
801049e9:	e8 f2 c3 ff ff       	call   80100de0 <filedup>
  return fd;
801049ee:	89 d8                	mov    %ebx,%eax
}
801049f0:	83 c4 24             	add    $0x24,%esp
801049f3:	5b                   	pop    %ebx
801049f4:	5d                   	pop    %ebp
801049f5:	c3                   	ret    
801049f6:	66 90                	xchg   %ax,%ax
    return -1;
801049f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049fd:	eb f1                	jmp    801049f0 <sys_dup+0x30>
801049ff:	90                   	nop

80104a00 <sys_read>:
{
80104a00:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a01:	31 c0                	xor    %eax,%eax
{
80104a03:	89 e5                	mov    %esp,%ebp
80104a05:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a0b:	e8 40 ff ff ff       	call   80104950 <argfd.constprop.0>
80104a10:	85 c0                	test   %eax,%eax
80104a12:	78 54                	js     80104a68 <sys_read+0x68>
80104a14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a17:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a22:	e8 29 fc ff ff       	call   80104650 <argint>
80104a27:	85 c0                	test   %eax,%eax
80104a29:	78 3d                	js     80104a68 <sys_read+0x68>
80104a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a2e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104a35:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a40:	e8 3b fc ff ff       	call   80104680 <argptr>
80104a45:	85 c0                	test   %eax,%eax
80104a47:	78 1f                	js     80104a68 <sys_read+0x68>
  return fileread(f, p, n);
80104a49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a4c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a53:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a57:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a5a:	89 04 24             	mov    %eax,(%esp)
80104a5d:	e8 de c4 ff ff       	call   80100f40 <fileread>
}
80104a62:	c9                   	leave  
80104a63:	c3                   	ret    
80104a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a6d:	c9                   	leave  
80104a6e:	c3                   	ret    
80104a6f:	90                   	nop

80104a70 <sys_write>:
{
80104a70:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a71:	31 c0                	xor    %eax,%eax
{
80104a73:	89 e5                	mov    %esp,%ebp
80104a75:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a7b:	e8 d0 fe ff ff       	call   80104950 <argfd.constprop.0>
80104a80:	85 c0                	test   %eax,%eax
80104a82:	78 54                	js     80104ad8 <sys_write+0x68>
80104a84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a8b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a92:	e8 b9 fb ff ff       	call   80104650 <argint>
80104a97:	85 c0                	test   %eax,%eax
80104a99:	78 3d                	js     80104ad8 <sys_write+0x68>
80104a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104aa5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104aa9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104aac:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ab0:	e8 cb fb ff ff       	call   80104680 <argptr>
80104ab5:	85 c0                	test   %eax,%eax
80104ab7:	78 1f                	js     80104ad8 <sys_write+0x68>
  return filewrite(f, p, n);
80104ab9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104abc:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ac3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ac7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104aca:	89 04 24             	mov    %eax,(%esp)
80104acd:	e8 0e c5 ff ff       	call   80100fe0 <filewrite>
}
80104ad2:	c9                   	leave  
80104ad3:	c3                   	ret    
80104ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104add:	c9                   	leave  
80104ade:	c3                   	ret    
80104adf:	90                   	nop

80104ae0 <sys_close>:
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80104ae6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ae9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104aec:	e8 5f fe ff ff       	call   80104950 <argfd.constprop.0>
80104af1:	85 c0                	test   %eax,%eax
80104af3:	78 23                	js     80104b18 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80104af5:	e8 a6 eb ff ff       	call   801036a0 <myproc>
80104afa:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104afd:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104b04:	00 
  fileclose(f);
80104b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b08:	89 04 24             	mov    %eax,(%esp)
80104b0b:	e8 20 c3 ff ff       	call   80100e30 <fileclose>
  return 0;
80104b10:	31 c0                	xor    %eax,%eax
}
80104b12:	c9                   	leave  
80104b13:	c3                   	ret    
80104b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b1d:	c9                   	leave  
80104b1e:	c3                   	ret    
80104b1f:	90                   	nop

80104b20 <sys_fstat>:
{
80104b20:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b21:	31 c0                	xor    %eax,%eax
{
80104b23:	89 e5                	mov    %esp,%ebp
80104b25:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104b28:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104b2b:	e8 20 fe ff ff       	call   80104950 <argfd.constprop.0>
80104b30:	85 c0                	test   %eax,%eax
80104b32:	78 34                	js     80104b68 <sys_fstat+0x48>
80104b34:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b37:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104b3e:	00 
80104b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b4a:	e8 31 fb ff ff       	call   80104680 <argptr>
80104b4f:	85 c0                	test   %eax,%eax
80104b51:	78 15                	js     80104b68 <sys_fstat+0x48>
  return filestat(f, st);
80104b53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b56:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b5d:	89 04 24             	mov    %eax,(%esp)
80104b60:	e8 8b c3 ff ff       	call   80100ef0 <filestat>
}
80104b65:	c9                   	leave  
80104b66:	c3                   	ret    
80104b67:	90                   	nop
    return -1;
80104b68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b6d:	c9                   	leave  
80104b6e:	c3                   	ret    
80104b6f:	90                   	nop

80104b70 <sys_link>:
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	57                   	push   %edi
80104b74:	56                   	push   %esi
80104b75:	53                   	push   %ebx
80104b76:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104b79:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b7c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b80:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b87:	e8 54 fb ff ff       	call   801046e0 <argstr>
80104b8c:	85 c0                	test   %eax,%eax
80104b8e:	0f 88 e6 00 00 00    	js     80104c7a <sys_link+0x10a>
80104b94:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104b97:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104ba2:	e8 39 fb ff ff       	call   801046e0 <argstr>
80104ba7:	85 c0                	test   %eax,%eax
80104ba9:	0f 88 cb 00 00 00    	js     80104c7a <sys_link+0x10a>
  begin_op();
80104baf:	e8 5c df ff ff       	call   80102b10 <begin_op>
  if((ip = namei(old)) == 0){
80104bb4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104bb7:	89 04 24             	mov    %eax,(%esp)
80104bba:	e8 41 d3 ff ff       	call   80101f00 <namei>
80104bbf:	85 c0                	test   %eax,%eax
80104bc1:	89 c3                	mov    %eax,%ebx
80104bc3:	0f 84 ac 00 00 00    	je     80104c75 <sys_link+0x105>
  ilock(ip);
80104bc9:	89 04 24             	mov    %eax,(%esp)
80104bcc:	e8 df ca ff ff       	call   801016b0 <ilock>
  if(ip->type == T_DIR){
80104bd1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104bd6:	0f 84 91 00 00 00    	je     80104c6d <sys_link+0xfd>
  ip->nlink++;
80104bdc:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104be1:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104be4:	89 1c 24             	mov    %ebx,(%esp)
80104be7:	e8 04 ca ff ff       	call   801015f0 <iupdate>
  iunlock(ip);
80104bec:	89 1c 24             	mov    %ebx,(%esp)
80104bef:	e8 9c cb ff ff       	call   80101790 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80104bf4:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104bf7:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104bfb:	89 04 24             	mov    %eax,(%esp)
80104bfe:	e8 1d d3 ff ff       	call   80101f20 <nameiparent>
80104c03:	85 c0                	test   %eax,%eax
80104c05:	89 c6                	mov    %eax,%esi
80104c07:	74 4f                	je     80104c58 <sys_link+0xe8>
  ilock(dp);
80104c09:	89 04 24             	mov    %eax,(%esp)
80104c0c:	e8 9f ca ff ff       	call   801016b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104c11:	8b 03                	mov    (%ebx),%eax
80104c13:	39 06                	cmp    %eax,(%esi)
80104c15:	75 39                	jne    80104c50 <sys_link+0xe0>
80104c17:	8b 43 04             	mov    0x4(%ebx),%eax
80104c1a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104c1e:	89 34 24             	mov    %esi,(%esp)
80104c21:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c25:	e8 f6 d1 ff ff       	call   80101e20 <dirlink>
80104c2a:	85 c0                	test   %eax,%eax
80104c2c:	78 22                	js     80104c50 <sys_link+0xe0>
  iunlockput(dp);
80104c2e:	89 34 24             	mov    %esi,(%esp)
80104c31:	e8 da cc ff ff       	call   80101910 <iunlockput>
  iput(ip);
80104c36:	89 1c 24             	mov    %ebx,(%esp)
80104c39:	e8 92 cb ff ff       	call   801017d0 <iput>
  end_op();
80104c3e:	e8 3d df ff ff       	call   80102b80 <end_op>
}
80104c43:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80104c46:	31 c0                	xor    %eax,%eax
}
80104c48:	5b                   	pop    %ebx
80104c49:	5e                   	pop    %esi
80104c4a:	5f                   	pop    %edi
80104c4b:	5d                   	pop    %ebp
80104c4c:	c3                   	ret    
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80104c50:	89 34 24             	mov    %esi,(%esp)
80104c53:	e8 b8 cc ff ff       	call   80101910 <iunlockput>
  ilock(ip);
80104c58:	89 1c 24             	mov    %ebx,(%esp)
80104c5b:	e8 50 ca ff ff       	call   801016b0 <ilock>
  ip->nlink--;
80104c60:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104c65:	89 1c 24             	mov    %ebx,(%esp)
80104c68:	e8 83 c9 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104c6d:	89 1c 24             	mov    %ebx,(%esp)
80104c70:	e8 9b cc ff ff       	call   80101910 <iunlockput>
  end_op();
80104c75:	e8 06 df ff ff       	call   80102b80 <end_op>
}
80104c7a:	83 c4 3c             	add    $0x3c,%esp
  return -1;
80104c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5f                   	pop    %edi
80104c85:	5d                   	pop    %ebp
80104c86:	c3                   	ret    
80104c87:	89 f6                	mov    %esi,%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <sys_unlink>:
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	57                   	push   %edi
80104c94:	56                   	push   %esi
80104c95:	53                   	push   %ebx
80104c96:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
80104c99:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ca0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ca7:	e8 34 fa ff ff       	call   801046e0 <argstr>
80104cac:	85 c0                	test   %eax,%eax
80104cae:	0f 88 76 01 00 00    	js     80104e2a <sys_unlink+0x19a>
  begin_op();
80104cb4:	e8 57 de ff ff       	call   80102b10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104cb9:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104cbc:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104cbf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104cc3:	89 04 24             	mov    %eax,(%esp)
80104cc6:	e8 55 d2 ff ff       	call   80101f20 <nameiparent>
80104ccb:	85 c0                	test   %eax,%eax
80104ccd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104cd0:	0f 84 4f 01 00 00    	je     80104e25 <sys_unlink+0x195>
  ilock(dp);
80104cd6:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104cd9:	89 34 24             	mov    %esi,(%esp)
80104cdc:	e8 cf c9 ff ff       	call   801016b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104ce1:	c7 44 24 04 78 74 10 	movl   $0x80107478,0x4(%esp)
80104ce8:	80 
80104ce9:	89 1c 24             	mov    %ebx,(%esp)
80104cec:	e8 9f ce ff ff       	call   80101b90 <namecmp>
80104cf1:	85 c0                	test   %eax,%eax
80104cf3:	0f 84 21 01 00 00    	je     80104e1a <sys_unlink+0x18a>
80104cf9:	c7 44 24 04 77 74 10 	movl   $0x80107477,0x4(%esp)
80104d00:	80 
80104d01:	89 1c 24             	mov    %ebx,(%esp)
80104d04:	e8 87 ce ff ff       	call   80101b90 <namecmp>
80104d09:	85 c0                	test   %eax,%eax
80104d0b:	0f 84 09 01 00 00    	je     80104e1a <sys_unlink+0x18a>
  if((ip = dirlookup(dp, name, &off)) == 0)
80104d11:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104d14:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d18:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d1c:	89 34 24             	mov    %esi,(%esp)
80104d1f:	e8 9c ce ff ff       	call   80101bc0 <dirlookup>
80104d24:	85 c0                	test   %eax,%eax
80104d26:	89 c3                	mov    %eax,%ebx
80104d28:	0f 84 ec 00 00 00    	je     80104e1a <sys_unlink+0x18a>
  ilock(ip);
80104d2e:	89 04 24             	mov    %eax,(%esp)
80104d31:	e8 7a c9 ff ff       	call   801016b0 <ilock>
  if(ip->nlink < 1)
80104d36:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104d3b:	0f 8e 24 01 00 00    	jle    80104e65 <sys_unlink+0x1d5>
  if(ip->type == T_DIR && !isdirempty(ip)){
80104d41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d46:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104d49:	74 7d                	je     80104dc8 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
80104d4b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104d52:	00 
80104d53:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104d5a:	00 
80104d5b:	89 34 24             	mov    %esi,(%esp)
80104d5e:	e8 fd f5 ff ff       	call   80104360 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104d63:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104d66:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104d6d:	00 
80104d6e:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d72:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d76:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d79:	89 04 24             	mov    %eax,(%esp)
80104d7c:	e8 df cc ff ff       	call   80101a60 <writei>
80104d81:	83 f8 10             	cmp    $0x10,%eax
80104d84:	0f 85 cf 00 00 00    	jne    80104e59 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
80104d8a:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d8f:	0f 84 a3 00 00 00    	je     80104e38 <sys_unlink+0x1a8>
  iunlockput(dp);
80104d95:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d98:	89 04 24             	mov    %eax,(%esp)
80104d9b:	e8 70 cb ff ff       	call   80101910 <iunlockput>
  ip->nlink--;
80104da0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104da5:	89 1c 24             	mov    %ebx,(%esp)
80104da8:	e8 43 c8 ff ff       	call   801015f0 <iupdate>
  iunlockput(ip);
80104dad:	89 1c 24             	mov    %ebx,(%esp)
80104db0:	e8 5b cb ff ff       	call   80101910 <iunlockput>
  end_op();
80104db5:	e8 c6 dd ff ff       	call   80102b80 <end_op>
}
80104dba:	83 c4 5c             	add    $0x5c,%esp
  return 0;
80104dbd:	31 c0                	xor    %eax,%eax
}
80104dbf:	5b                   	pop    %ebx
80104dc0:	5e                   	pop    %esi
80104dc1:	5f                   	pop    %edi
80104dc2:	5d                   	pop    %ebp
80104dc3:	c3                   	ret    
80104dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104dc8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104dcc:	0f 86 79 ff ff ff    	jbe    80104d4b <sys_unlink+0xbb>
80104dd2:	bf 20 00 00 00       	mov    $0x20,%edi
80104dd7:	eb 15                	jmp    80104dee <sys_unlink+0x15e>
80104dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104de0:	8d 57 10             	lea    0x10(%edi),%edx
80104de3:	3b 53 58             	cmp    0x58(%ebx),%edx
80104de6:	0f 83 5f ff ff ff    	jae    80104d4b <sys_unlink+0xbb>
80104dec:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104dee:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104df5:	00 
80104df6:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104dfa:	89 74 24 04          	mov    %esi,0x4(%esp)
80104dfe:	89 1c 24             	mov    %ebx,(%esp)
80104e01:	e8 5a cb ff ff       	call   80101960 <readi>
80104e06:	83 f8 10             	cmp    $0x10,%eax
80104e09:	75 42                	jne    80104e4d <sys_unlink+0x1bd>
    if(de.inum != 0)
80104e0b:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104e10:	74 ce                	je     80104de0 <sys_unlink+0x150>
    iunlockput(ip);
80104e12:	89 1c 24             	mov    %ebx,(%esp)
80104e15:	e8 f6 ca ff ff       	call   80101910 <iunlockput>
  iunlockput(dp);
80104e1a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e1d:	89 04 24             	mov    %eax,(%esp)
80104e20:	e8 eb ca ff ff       	call   80101910 <iunlockput>
  end_op();
80104e25:	e8 56 dd ff ff       	call   80102b80 <end_op>
}
80104e2a:	83 c4 5c             	add    $0x5c,%esp
  return -1;
80104e2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104e32:	5b                   	pop    %ebx
80104e33:	5e                   	pop    %esi
80104e34:	5f                   	pop    %edi
80104e35:	5d                   	pop    %ebp
80104e36:	c3                   	ret    
80104e37:	90                   	nop
    dp->nlink--;
80104e38:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104e3b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104e40:	89 04 24             	mov    %eax,(%esp)
80104e43:	e8 a8 c7 ff ff       	call   801015f0 <iupdate>
80104e48:	e9 48 ff ff ff       	jmp    80104d95 <sys_unlink+0x105>
      panic("isdirempty: readi");
80104e4d:	c7 04 24 9c 74 10 80 	movl   $0x8010749c,(%esp)
80104e54:	e8 07 b5 ff ff       	call   80100360 <panic>
    panic("unlink: writei");
80104e59:	c7 04 24 ae 74 10 80 	movl   $0x801074ae,(%esp)
80104e60:	e8 fb b4 ff ff       	call   80100360 <panic>
    panic("unlink: nlink < 1");
80104e65:	c7 04 24 8a 74 10 80 	movl   $0x8010748a,(%esp)
80104e6c:	e8 ef b4 ff ff       	call   80100360 <panic>
80104e71:	eb 0d                	jmp    80104e80 <sys_open>
80104e73:	90                   	nop
80104e74:	90                   	nop
80104e75:	90                   	nop
80104e76:	90                   	nop
80104e77:	90                   	nop
80104e78:	90                   	nop
80104e79:	90                   	nop
80104e7a:	90                   	nop
80104e7b:	90                   	nop
80104e7c:	90                   	nop
80104e7d:	90                   	nop
80104e7e:	90                   	nop
80104e7f:	90                   	nop

80104e80 <sys_open>:

int
sys_open(void)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	57                   	push   %edi
80104e84:	56                   	push   %esi
80104e85:	53                   	push   %ebx
80104e86:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104e89:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104e8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e90:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e97:	e8 44 f8 ff ff       	call   801046e0 <argstr>
80104e9c:	85 c0                	test   %eax,%eax
80104e9e:	0f 88 d1 00 00 00    	js     80104f75 <sys_open+0xf5>
80104ea4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104ea7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104eab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104eb2:	e8 99 f7 ff ff       	call   80104650 <argint>
80104eb7:	85 c0                	test   %eax,%eax
80104eb9:	0f 88 b6 00 00 00    	js     80104f75 <sys_open+0xf5>
    return -1;

  begin_op();
80104ebf:	e8 4c dc ff ff       	call   80102b10 <begin_op>

  if(omode & O_CREATE){
80104ec4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104ec8:	0f 85 82 00 00 00    	jne    80104f50 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104ece:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ed1:	89 04 24             	mov    %eax,(%esp)
80104ed4:	e8 27 d0 ff ff       	call   80101f00 <namei>
80104ed9:	85 c0                	test   %eax,%eax
80104edb:	89 c6                	mov    %eax,%esi
80104edd:	0f 84 8d 00 00 00    	je     80104f70 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
80104ee3:	89 04 24             	mov    %eax,(%esp)
80104ee6:	e8 c5 c7 ff ff       	call   801016b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104eeb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104ef0:	0f 84 92 00 00 00    	je     80104f88 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104ef6:	e8 75 be ff ff       	call   80100d70 <filealloc>
80104efb:	85 c0                	test   %eax,%eax
80104efd:	89 c3                	mov    %eax,%ebx
80104eff:	0f 84 93 00 00 00    	je     80104f98 <sys_open+0x118>
80104f05:	e8 86 f8 ff ff       	call   80104790 <fdalloc>
80104f0a:	85 c0                	test   %eax,%eax
80104f0c:	89 c7                	mov    %eax,%edi
80104f0e:	0f 88 94 00 00 00    	js     80104fa8 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104f14:	89 34 24             	mov    %esi,(%esp)
80104f17:	e8 74 c8 ff ff       	call   80101790 <iunlock>
  end_op();
80104f1c:	e8 5f dc ff ff       	call   80102b80 <end_op>

  f->type = FD_INODE;
80104f21:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104f27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->ip = ip;
80104f2a:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
80104f2d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80104f34:	89 c2                	mov    %eax,%edx
80104f36:	83 e2 01             	and    $0x1,%edx
80104f39:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f3c:	a8 03                	test   $0x3,%al
  f->readable = !(omode & O_WRONLY);
80104f3e:	88 53 08             	mov    %dl,0x8(%ebx)
  return fd;
80104f41:	89 f8                	mov    %edi,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f43:	0f 95 43 09          	setne  0x9(%ebx)
}
80104f47:	83 c4 2c             	add    $0x2c,%esp
80104f4a:	5b                   	pop    %ebx
80104f4b:	5e                   	pop    %esi
80104f4c:	5f                   	pop    %edi
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop
    ip = create(path, T_FILE, 0, 0);
80104f50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f53:	31 c9                	xor    %ecx,%ecx
80104f55:	ba 02 00 00 00       	mov    $0x2,%edx
80104f5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f61:	e8 6a f8 ff ff       	call   801047d0 <create>
    if(ip == 0){
80104f66:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80104f68:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80104f6a:	75 8a                	jne    80104ef6 <sys_open+0x76>
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80104f70:	e8 0b dc ff ff       	call   80102b80 <end_op>
}
80104f75:	83 c4 2c             	add    $0x2c,%esp
    return -1;
80104f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f7d:	5b                   	pop    %ebx
80104f7e:	5e                   	pop    %esi
80104f7f:	5f                   	pop    %edi
80104f80:	5d                   	pop    %ebp
80104f81:	c3                   	ret    
80104f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	0f 84 63 ff ff ff    	je     80104ef6 <sys_open+0x76>
80104f93:	90                   	nop
80104f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104f98:	89 34 24             	mov    %esi,(%esp)
80104f9b:	e8 70 c9 ff ff       	call   80101910 <iunlockput>
80104fa0:	eb ce                	jmp    80104f70 <sys_open+0xf0>
80104fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      fileclose(f);
80104fa8:	89 1c 24             	mov    %ebx,(%esp)
80104fab:	e8 80 be ff ff       	call   80100e30 <fileclose>
80104fb0:	eb e6                	jmp    80104f98 <sys_open+0x118>
80104fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fc0 <sys_mkdir>:

int
sys_mkdir(void)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104fc6:	e8 45 db ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104fcb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fce:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fd2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fd9:	e8 02 f7 ff ff       	call   801046e0 <argstr>
80104fde:	85 c0                	test   %eax,%eax
80104fe0:	78 2e                	js     80105010 <sys_mkdir+0x50>
80104fe2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fe5:	31 c9                	xor    %ecx,%ecx
80104fe7:	ba 01 00 00 00       	mov    $0x1,%edx
80104fec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ff3:	e8 d8 f7 ff ff       	call   801047d0 <create>
80104ff8:	85 c0                	test   %eax,%eax
80104ffa:	74 14                	je     80105010 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104ffc:	89 04 24             	mov    %eax,(%esp)
80104fff:	e8 0c c9 ff ff       	call   80101910 <iunlockput>
  end_op();
80105004:	e8 77 db ff ff       	call   80102b80 <end_op>
  return 0;
80105009:	31 c0                	xor    %eax,%eax
}
8010500b:	c9                   	leave  
8010500c:	c3                   	ret    
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105010:	e8 6b db ff ff       	call   80102b80 <end_op>
    return -1;
80105015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010501a:	c9                   	leave  
8010501b:	c3                   	ret    
8010501c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105020 <sys_mknod>:

int
sys_mknod(void)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105026:	e8 e5 da ff ff       	call   80102b10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010502b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010502e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105032:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105039:	e8 a2 f6 ff ff       	call   801046e0 <argstr>
8010503e:	85 c0                	test   %eax,%eax
80105040:	78 5e                	js     801050a0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105042:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105045:	89 44 24 04          	mov    %eax,0x4(%esp)
80105049:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105050:	e8 fb f5 ff ff       	call   80104650 <argint>
  if((argstr(0, &path)) < 0 ||
80105055:	85 c0                	test   %eax,%eax
80105057:	78 47                	js     801050a0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105059:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010505c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105060:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105067:	e8 e4 f5 ff ff       	call   80104650 <argint>
     argint(1, &major) < 0 ||
8010506c:	85 c0                	test   %eax,%eax
8010506e:	78 30                	js     801050a0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105070:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105074:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80105079:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
8010507d:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
80105080:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105083:	e8 48 f7 ff ff       	call   801047d0 <create>
80105088:	85 c0                	test   %eax,%eax
8010508a:	74 14                	je     801050a0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010508c:	89 04 24             	mov    %eax,(%esp)
8010508f:	e8 7c c8 ff ff       	call   80101910 <iunlockput>
  end_op();
80105094:	e8 e7 da ff ff       	call   80102b80 <end_op>
  return 0;
80105099:	31 c0                	xor    %eax,%eax
}
8010509b:	c9                   	leave  
8010509c:	c3                   	ret    
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801050a0:	e8 db da ff ff       	call   80102b80 <end_op>
    return -1;
801050a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050aa:	c9                   	leave  
801050ab:	c3                   	ret    
801050ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050b0 <sys_chdir>:

int
sys_chdir(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	56                   	push   %esi
801050b4:	53                   	push   %ebx
801050b5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801050b8:	e8 e3 e5 ff ff       	call   801036a0 <myproc>
801050bd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801050bf:	e8 4c da ff ff       	call   80102b10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801050c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801050cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050d2:	e8 09 f6 ff ff       	call   801046e0 <argstr>
801050d7:	85 c0                	test   %eax,%eax
801050d9:	78 4a                	js     80105125 <sys_chdir+0x75>
801050db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050de:	89 04 24             	mov    %eax,(%esp)
801050e1:	e8 1a ce ff ff       	call   80101f00 <namei>
801050e6:	85 c0                	test   %eax,%eax
801050e8:	89 c3                	mov    %eax,%ebx
801050ea:	74 39                	je     80105125 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
801050ec:	89 04 24             	mov    %eax,(%esp)
801050ef:	e8 bc c5 ff ff       	call   801016b0 <ilock>
  if(ip->type != T_DIR){
801050f4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
801050f9:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
801050fc:	75 22                	jne    80105120 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
801050fe:	e8 8d c6 ff ff       	call   80101790 <iunlock>
  iput(curproc->cwd);
80105103:	8b 46 68             	mov    0x68(%esi),%eax
80105106:	89 04 24             	mov    %eax,(%esp)
80105109:	e8 c2 c6 ff ff       	call   801017d0 <iput>
  end_op();
8010510e:	e8 6d da ff ff       	call   80102b80 <end_op>
  curproc->cwd = ip;
  return 0;
80105113:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80105115:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80105118:	83 c4 20             	add    $0x20,%esp
8010511b:	5b                   	pop    %ebx
8010511c:	5e                   	pop    %esi
8010511d:	5d                   	pop    %ebp
8010511e:	c3                   	ret    
8010511f:	90                   	nop
    iunlockput(ip);
80105120:	e8 eb c7 ff ff       	call   80101910 <iunlockput>
    end_op();
80105125:	e8 56 da ff ff       	call   80102b80 <end_op>
}
8010512a:	83 c4 20             	add    $0x20,%esp
    return -1;
8010512d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105132:	5b                   	pop    %ebx
80105133:	5e                   	pop    %esi
80105134:	5d                   	pop    %ebp
80105135:	c3                   	ret    
80105136:	8d 76 00             	lea    0x0(%esi),%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_exec>:

int
sys_exec(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	57                   	push   %edi
80105144:	56                   	push   %esi
80105145:	53                   	push   %ebx
80105146:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010514c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105152:	89 44 24 04          	mov    %eax,0x4(%esp)
80105156:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010515d:	e8 7e f5 ff ff       	call   801046e0 <argstr>
80105162:	85 c0                	test   %eax,%eax
80105164:	0f 88 84 00 00 00    	js     801051ee <sys_exec+0xae>
8010516a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105170:	89 44 24 04          	mov    %eax,0x4(%esp)
80105174:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010517b:	e8 d0 f4 ff ff       	call   80104650 <argint>
80105180:	85 c0                	test   %eax,%eax
80105182:	78 6a                	js     801051ee <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105184:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010518a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010518c:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105193:	00 
80105194:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
8010519a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801051a1:	00 
801051a2:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801051a8:	89 04 24             	mov    %eax,(%esp)
801051ab:	e8 b0 f1 ff ff       	call   80104360 <memset>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801051b0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801051b6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801051ba:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801051bd:	89 04 24             	mov    %eax,(%esp)
801051c0:	e8 eb f3 ff ff       	call   801045b0 <fetchint>
801051c5:	85 c0                	test   %eax,%eax
801051c7:	78 25                	js     801051ee <sys_exec+0xae>
      return -1;
    if(uarg == 0){
801051c9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801051cf:	85 c0                	test   %eax,%eax
801051d1:	74 2d                	je     80105200 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801051d3:	89 74 24 04          	mov    %esi,0x4(%esp)
801051d7:	89 04 24             	mov    %eax,(%esp)
801051da:	e8 11 f4 ff ff       	call   801045f0 <fetchstr>
801051df:	85 c0                	test   %eax,%eax
801051e1:	78 0b                	js     801051ee <sys_exec+0xae>
  for(i=0;; i++){
801051e3:	83 c3 01             	add    $0x1,%ebx
801051e6:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
801051e9:	83 fb 20             	cmp    $0x20,%ebx
801051ec:	75 c2                	jne    801051b0 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
801051ee:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
801051f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051f9:	5b                   	pop    %ebx
801051fa:	5e                   	pop    %esi
801051fb:	5f                   	pop    %edi
801051fc:	5d                   	pop    %ebp
801051fd:	c3                   	ret    
801051fe:	66 90                	xchg   %ax,%ax
  return exec(path, argv);
80105200:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105206:	89 44 24 04          	mov    %eax,0x4(%esp)
8010520a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
      argv[i] = 0;
80105210:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105217:	00 00 00 00 
  return exec(path, argv);
8010521b:	89 04 24             	mov    %eax,(%esp)
8010521e:	e8 7d b7 ff ff       	call   801009a0 <exec>
}
80105223:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105229:	5b                   	pop    %ebx
8010522a:	5e                   	pop    %esi
8010522b:	5f                   	pop    %edi
8010522c:	5d                   	pop    %ebp
8010522d:	c3                   	ret    
8010522e:	66 90                	xchg   %ax,%ax

80105230 <sys_pipe>:

int
sys_pipe(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	53                   	push   %ebx
80105234:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105237:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010523a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105241:	00 
80105242:	89 44 24 04          	mov    %eax,0x4(%esp)
80105246:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010524d:	e8 2e f4 ff ff       	call   80104680 <argptr>
80105252:	85 c0                	test   %eax,%eax
80105254:	78 6d                	js     801052c3 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105256:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105259:	89 44 24 04          	mov    %eax,0x4(%esp)
8010525d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105260:	89 04 24             	mov    %eax,(%esp)
80105263:	e8 08 df ff ff       	call   80103170 <pipealloc>
80105268:	85 c0                	test   %eax,%eax
8010526a:	78 57                	js     801052c3 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010526c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010526f:	e8 1c f5 ff ff       	call   80104790 <fdalloc>
80105274:	85 c0                	test   %eax,%eax
80105276:	89 c3                	mov    %eax,%ebx
80105278:	78 33                	js     801052ad <sys_pipe+0x7d>
8010527a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010527d:	e8 0e f5 ff ff       	call   80104790 <fdalloc>
80105282:	85 c0                	test   %eax,%eax
80105284:	78 1a                	js     801052a0 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105286:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105289:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
8010528b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010528e:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
80105291:	83 c4 24             	add    $0x24,%esp
  return 0;
80105294:	31 c0                	xor    %eax,%eax
}
80105296:	5b                   	pop    %ebx
80105297:	5d                   	pop    %ebp
80105298:	c3                   	ret    
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801052a0:	e8 fb e3 ff ff       	call   801036a0 <myproc>
801052a5:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
801052ac:	00 
    fileclose(rf);
801052ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052b0:	89 04 24             	mov    %eax,(%esp)
801052b3:	e8 78 bb ff ff       	call   80100e30 <fileclose>
    fileclose(wf);
801052b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052bb:	89 04 24             	mov    %eax,(%esp)
801052be:	e8 6d bb ff ff       	call   80100e30 <fileclose>
}
801052c3:	83 c4 24             	add    $0x24,%esp
    return -1;
801052c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052cb:	5b                   	pop    %ebx
801052cc:	5d                   	pop    %ebp
801052cd:	c3                   	ret    
801052ce:	66 90                	xchg   %ax,%ax

801052d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801052d3:	5d                   	pop    %ebp
  return fork();
801052d4:	e9 77 e5 ff ff       	jmp    80103850 <fork>
801052d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801052e0 <sys_exit>:

int
sys_exit(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	83 ec 08             	sub    $0x8,%esp
  exit();
801052e6:	e8 b5 e7 ff ff       	call   80103aa0 <exit>
  return 0;  // not reached
}
801052eb:	31 c0                	xor    %eax,%eax
801052ed:	c9                   	leave  
801052ee:	c3                   	ret    
801052ef:	90                   	nop

801052f0 <sys_wait>:

int
sys_wait(void)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801052f3:	5d                   	pop    %ebp
  return wait();
801052f4:	e9 b7 e9 ff ff       	jmp    80103cb0 <wait>
801052f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105300 <sys_kill>:

int
sys_kill(void)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105306:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105309:	89 44 24 04          	mov    %eax,0x4(%esp)
8010530d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105314:	e8 37 f3 ff ff       	call   80104650 <argint>
80105319:	85 c0                	test   %eax,%eax
8010531b:	78 13                	js     80105330 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010531d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105320:	89 04 24             	mov    %eax,(%esp)
80105323:	e8 c8 ea ff ff       	call   80103df0 <kill>
}
80105328:	c9                   	leave  
80105329:	c3                   	ret    
8010532a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105335:	c9                   	leave  
80105336:	c3                   	ret    
80105337:	89 f6                	mov    %esi,%esi
80105339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105340 <sys_getpid>:

int
sys_getpid(void)
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105346:	e8 55 e3 ff ff       	call   801036a0 <myproc>
8010534b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010534e:	c9                   	leave  
8010534f:	c3                   	ret    

80105350 <sys_sbrk>:

int
sys_sbrk(void)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	53                   	push   %ebx
80105354:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105357:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010535a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010535e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105365:	e8 e6 f2 ff ff       	call   80104650 <argint>
8010536a:	85 c0                	test   %eax,%eax
8010536c:	78 22                	js     80105390 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010536e:	e8 2d e3 ff ff       	call   801036a0 <myproc>
  if(growproc(n) < 0)
80105373:	8b 55 f4             	mov    -0xc(%ebp),%edx
  addr = myproc()->sz;
80105376:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105378:	89 14 24             	mov    %edx,(%esp)
8010537b:	e8 60 e4 ff ff       	call   801037e0 <growproc>
80105380:	85 c0                	test   %eax,%eax
80105382:	78 0c                	js     80105390 <sys_sbrk+0x40>
    return -1;
  return addr;
80105384:	89 d8                	mov    %ebx,%eax
}
80105386:	83 c4 24             	add    $0x24,%esp
80105389:	5b                   	pop    %ebx
8010538a:	5d                   	pop    %ebp
8010538b:	c3                   	ret    
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105390:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105395:	eb ef                	jmp    80105386 <sys_sbrk+0x36>
80105397:	89 f6                	mov    %esi,%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053a0 <sys_sleep>:

int
sys_sleep(void)
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	53                   	push   %ebx
801053a4:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801053a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053b5:	e8 96 f2 ff ff       	call   80104650 <argint>
801053ba:	85 c0                	test   %eax,%eax
801053bc:	78 7e                	js     8010543c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
801053be:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801053c5:	e8 d6 ee ff ff       	call   801042a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801053ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801053cd:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
801053d3:	85 d2                	test   %edx,%edx
801053d5:	75 29                	jne    80105400 <sys_sleep+0x60>
801053d7:	eb 4f                	jmp    80105428 <sys_sleep+0x88>
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801053e0:	c7 44 24 04 60 4c 11 	movl   $0x80114c60,0x4(%esp)
801053e7:	80 
801053e8:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
801053ef:	e8 0c e8 ff ff       	call   80103c00 <sleep>
  while(ticks - ticks0 < n){
801053f4:	a1 a0 54 11 80       	mov    0x801154a0,%eax
801053f9:	29 d8                	sub    %ebx,%eax
801053fb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801053fe:	73 28                	jae    80105428 <sys_sleep+0x88>
    if(myproc()->killed){
80105400:	e8 9b e2 ff ff       	call   801036a0 <myproc>
80105405:	8b 40 24             	mov    0x24(%eax),%eax
80105408:	85 c0                	test   %eax,%eax
8010540a:	74 d4                	je     801053e0 <sys_sleep+0x40>
      release(&tickslock);
8010540c:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105413:	e8 f8 ee ff ff       	call   80104310 <release>
      return -1;
80105418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010541d:	83 c4 24             	add    $0x24,%esp
80105420:	5b                   	pop    %ebx
80105421:	5d                   	pop    %ebp
80105422:	c3                   	ret    
80105423:	90                   	nop
80105424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
80105428:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010542f:	e8 dc ee ff ff       	call   80104310 <release>
}
80105434:	83 c4 24             	add    $0x24,%esp
  return 0;
80105437:	31 c0                	xor    %eax,%eax
}
80105439:	5b                   	pop    %ebx
8010543a:	5d                   	pop    %ebp
8010543b:	c3                   	ret    
    return -1;
8010543c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105441:	eb da                	jmp    8010541d <sys_sleep+0x7d>
80105443:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	53                   	push   %ebx
80105454:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105457:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010545e:	e8 3d ee ff ff       	call   801042a0 <acquire>
  xticks = ticks;
80105463:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
80105469:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105470:	e8 9b ee ff ff       	call   80104310 <release>
  return xticks;
}
80105475:	83 c4 14             	add    $0x14,%esp
80105478:	89 d8                	mov    %ebx,%eax
8010547a:	5b                   	pop    %ebx
8010547b:	5d                   	pop    %ebp
8010547c:	c3                   	ret    
8010547d:	8d 76 00             	lea    0x0(%esi),%esi

80105480 <sys_getpinfo>:
int 
sys_getpinfo(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
return getpinfo();
}
80105483:	5d                   	pop    %ebp
return getpinfo();
80105484:	e9 b7 ea ff ff       	jmp    80103f40 <getpinfo>

80105489 <alltraps>:
80105489:	1e                   	push   %ds
8010548a:	06                   	push   %es
8010548b:	0f a0                	push   %fs
8010548d:	0f a8                	push   %gs
8010548f:	60                   	pusha  
80105490:	66 b8 10 00          	mov    $0x10,%ax
80105494:	8e d8                	mov    %eax,%ds
80105496:	8e c0                	mov    %eax,%es
80105498:	54                   	push   %esp
80105499:	e8 e2 00 00 00       	call   80105580 <trap>
8010549e:	83 c4 04             	add    $0x4,%esp

801054a1 <trapret>:
801054a1:	61                   	popa   
801054a2:	0f a9                	pop    %gs
801054a4:	0f a1                	pop    %fs
801054a6:	07                   	pop    %es
801054a7:	1f                   	pop    %ds
801054a8:	83 c4 08             	add    $0x8,%esp
801054ab:	cf                   	iret   
801054ac:	66 90                	xchg   %ax,%ax
801054ae:	66 90                	xchg   %ax,%ax

801054b0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801054b0:	31 c0                	xor    %eax,%eax
801054b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801054b8:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
801054bf:	b9 08 00 00 00       	mov    $0x8,%ecx
801054c4:	66 89 0c c5 a2 4c 11 	mov    %cx,-0x7feeb35e(,%eax,8)
801054cb:	80 
801054cc:	c6 04 c5 a4 4c 11 80 	movb   $0x0,-0x7feeb35c(,%eax,8)
801054d3:	00 
801054d4:	c6 04 c5 a5 4c 11 80 	movb   $0x8e,-0x7feeb35b(,%eax,8)
801054db:	8e 
801054dc:	66 89 14 c5 a0 4c 11 	mov    %dx,-0x7feeb360(,%eax,8)
801054e3:	80 
801054e4:	c1 ea 10             	shr    $0x10,%edx
801054e7:	66 89 14 c5 a6 4c 11 	mov    %dx,-0x7feeb35a(,%eax,8)
801054ee:	80 
  for(i = 0; i < 256; i++)
801054ef:	83 c0 01             	add    $0x1,%eax
801054f2:	3d 00 01 00 00       	cmp    $0x100,%eax
801054f7:	75 bf                	jne    801054b8 <tvinit+0x8>
{
801054f9:	55                   	push   %ebp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801054fa:	ba 08 00 00 00       	mov    $0x8,%edx
{
801054ff:	89 e5                	mov    %esp,%ebp
80105501:	83 ec 18             	sub    $0x18,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105504:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105509:	c7 44 24 04 bd 74 10 	movl   $0x801074bd,0x4(%esp)
80105510:	80 
80105511:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105518:	66 89 15 a2 4e 11 80 	mov    %dx,0x80114ea2
8010551f:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
80105525:	c1 e8 10             	shr    $0x10,%eax
80105528:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
8010552f:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
80105536:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6
  initlock(&tickslock, "time");
8010553c:	e8 ef eb ff ff       	call   80104130 <initlock>
}
80105541:	c9                   	leave  
80105542:	c3                   	ret    
80105543:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <idtinit>:

void
idtinit(void)
{
80105550:	55                   	push   %ebp
  pd[0] = size-1;
80105551:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105556:	89 e5                	mov    %esp,%ebp
80105558:	83 ec 10             	sub    $0x10,%esp
8010555b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010555f:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105564:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105568:	c1 e8 10             	shr    $0x10,%eax
8010556b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010556f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105572:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105575:	c9                   	leave  
80105576:	c3                   	ret    
80105577:	89 f6                	mov    %esi,%esi
80105579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105580 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
80105585:	53                   	push   %ebx
80105586:	83 ec 3c             	sub    $0x3c,%esp
80105589:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010558c:	8b 43 30             	mov    0x30(%ebx),%eax
8010558f:	83 f8 40             	cmp    $0x40,%eax
80105592:	0f 84 a0 01 00 00    	je     80105738 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105598:	83 e8 20             	sub    $0x20,%eax
8010559b:	83 f8 1f             	cmp    $0x1f,%eax
8010559e:	77 08                	ja     801055a8 <trap+0x28>
801055a0:	ff 24 85 64 75 10 80 	jmp    *-0x7fef8a9c(,%eax,4)
801055a7:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801055a8:	e8 f3 e0 ff ff       	call   801036a0 <myproc>
801055ad:	85 c0                	test   %eax,%eax
801055af:	90                   	nop
801055b0:	0f 84 fa 01 00 00    	je     801057b0 <trap+0x230>
801055b6:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801055ba:	0f 84 f0 01 00 00    	je     801057b0 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801055c0:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055c3:	8b 53 38             	mov    0x38(%ebx),%edx
801055c6:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801055c9:	89 55 dc             	mov    %edx,-0x24(%ebp)
801055cc:	e8 af e0 ff ff       	call   80103680 <cpuid>
801055d1:	8b 73 30             	mov    0x30(%ebx),%esi
801055d4:	89 c7                	mov    %eax,%edi
801055d6:	8b 43 34             	mov    0x34(%ebx),%eax
801055d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801055dc:	e8 bf e0 ff ff       	call   801036a0 <myproc>
801055e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
801055e4:	e8 b7 e0 ff ff       	call   801036a0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055e9:	8b 55 dc             	mov    -0x24(%ebp),%edx
801055ec:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
801055f0:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801055f3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801055f6:	89 7c 24 14          	mov    %edi,0x14(%esp)
801055fa:	89 54 24 18          	mov    %edx,0x18(%esp)
801055fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80105601:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105604:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105608:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010560c:	89 54 24 10          	mov    %edx,0x10(%esp)
80105610:	8b 40 10             	mov    0x10(%eax),%eax
80105613:	c7 04 24 20 75 10 80 	movl   $0x80107520,(%esp)
8010561a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010561e:	e8 2d b0 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105623:	e8 78 e0 ff ff       	call   801036a0 <myproc>
80105628:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010562f:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105630:	e8 6b e0 ff ff       	call   801036a0 <myproc>
80105635:	85 c0                	test   %eax,%eax
80105637:	74 0c                	je     80105645 <trap+0xc5>
80105639:	e8 62 e0 ff ff       	call   801036a0 <myproc>
8010563e:	8b 50 24             	mov    0x24(%eax),%edx
80105641:	85 d2                	test   %edx,%edx
80105643:	75 4b                	jne    80105690 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105645:	e8 56 e0 ff ff       	call   801036a0 <myproc>
8010564a:	85 c0                	test   %eax,%eax
8010564c:	74 0d                	je     8010565b <trap+0xdb>
8010564e:	66 90                	xchg   %ax,%ax
80105650:	e8 4b e0 ff ff       	call   801036a0 <myproc>
80105655:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105659:	74 4d                	je     801056a8 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010565b:	e8 40 e0 ff ff       	call   801036a0 <myproc>
80105660:	85 c0                	test   %eax,%eax
80105662:	74 1d                	je     80105681 <trap+0x101>
80105664:	e8 37 e0 ff ff       	call   801036a0 <myproc>
80105669:	8b 40 24             	mov    0x24(%eax),%eax
8010566c:	85 c0                	test   %eax,%eax
8010566e:	74 11                	je     80105681 <trap+0x101>
80105670:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105674:	83 e0 03             	and    $0x3,%eax
80105677:	66 83 f8 03          	cmp    $0x3,%ax
8010567b:	0f 84 e8 00 00 00    	je     80105769 <trap+0x1e9>
    exit();
}
80105681:	83 c4 3c             	add    $0x3c,%esp
80105684:	5b                   	pop    %ebx
80105685:	5e                   	pop    %esi
80105686:	5f                   	pop    %edi
80105687:	5d                   	pop    %ebp
80105688:	c3                   	ret    
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105690:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105694:	83 e0 03             	and    $0x3,%eax
80105697:	66 83 f8 03          	cmp    $0x3,%ax
8010569b:	75 a8                	jne    80105645 <trap+0xc5>
    exit();
8010569d:	e8 fe e3 ff ff       	call   80103aa0 <exit>
801056a2:	eb a1                	jmp    80105645 <trap+0xc5>
801056a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
801056a8:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801056ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056b0:	75 a9                	jne    8010565b <trap+0xdb>
    yield();
801056b2:	e8 09 e5 ff ff       	call   80103bc0 <yield>
801056b7:	eb a2                	jmp    8010565b <trap+0xdb>
801056b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
801056c0:	e8 bb df ff ff       	call   80103680 <cpuid>
801056c5:	85 c0                	test   %eax,%eax
801056c7:	0f 84 b3 00 00 00    	je     80105780 <trap+0x200>
801056cd:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
801056d0:	e8 ab d0 ff ff       	call   80102780 <lapiceoi>
    break;
801056d5:	e9 56 ff ff ff       	jmp    80105630 <trap+0xb0>
801056da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
801056e0:	e8 eb ce ff ff       	call   801025d0 <kbdintr>
    lapiceoi();
801056e5:	e8 96 d0 ff ff       	call   80102780 <lapiceoi>
    break;
801056ea:	e9 41 ff ff ff       	jmp    80105630 <trap+0xb0>
801056ef:	90                   	nop
    uartintr();
801056f0:	e8 1b 02 00 00       	call   80105910 <uartintr>
    lapiceoi();
801056f5:	e8 86 d0 ff ff       	call   80102780 <lapiceoi>
    break;
801056fa:	e9 31 ff ff ff       	jmp    80105630 <trap+0xb0>
801056ff:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105700:	8b 7b 38             	mov    0x38(%ebx),%edi
80105703:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105707:	e8 74 df ff ff       	call   80103680 <cpuid>
8010570c:	c7 04 24 c8 74 10 80 	movl   $0x801074c8,(%esp)
80105713:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105717:	89 74 24 08          	mov    %esi,0x8(%esp)
8010571b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010571f:	e8 2c af ff ff       	call   80100650 <cprintf>
    lapiceoi();
80105724:	e8 57 d0 ff ff       	call   80102780 <lapiceoi>
    break;
80105729:	e9 02 ff ff ff       	jmp    80105630 <trap+0xb0>
8010572e:	66 90                	xchg   %ax,%ax
    ideintr();
80105730:	e8 4b c9 ff ff       	call   80102080 <ideintr>
80105735:	eb 96                	jmp    801056cd <trap+0x14d>
80105737:	90                   	nop
80105738:	90                   	nop
80105739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105740:	e8 5b df ff ff       	call   801036a0 <myproc>
80105745:	8b 70 24             	mov    0x24(%eax),%esi
80105748:	85 f6                	test   %esi,%esi
8010574a:	75 2c                	jne    80105778 <trap+0x1f8>
    myproc()->tf = tf;
8010574c:	e8 4f df ff ff       	call   801036a0 <myproc>
80105751:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105754:	e8 c7 ef ff ff       	call   80104720 <syscall>
    if(myproc()->killed)
80105759:	e8 42 df ff ff       	call   801036a0 <myproc>
8010575e:	8b 48 24             	mov    0x24(%eax),%ecx
80105761:	85 c9                	test   %ecx,%ecx
80105763:	0f 84 18 ff ff ff    	je     80105681 <trap+0x101>
}
80105769:	83 c4 3c             	add    $0x3c,%esp
8010576c:	5b                   	pop    %ebx
8010576d:	5e                   	pop    %esi
8010576e:	5f                   	pop    %edi
8010576f:	5d                   	pop    %ebp
      exit();
80105770:	e9 2b e3 ff ff       	jmp    80103aa0 <exit>
80105775:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
80105778:	e8 23 e3 ff ff       	call   80103aa0 <exit>
8010577d:	eb cd                	jmp    8010574c <trap+0x1cc>
8010577f:	90                   	nop
      acquire(&tickslock);
80105780:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105787:	e8 14 eb ff ff       	call   801042a0 <acquire>
      wakeup(&ticks);
8010578c:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
      ticks++;
80105793:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
8010579a:	e8 f1 e5 ff ff       	call   80103d90 <wakeup>
      release(&tickslock);
8010579f:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801057a6:	e8 65 eb ff ff       	call   80104310 <release>
801057ab:	e9 1d ff ff ff       	jmp    801056cd <trap+0x14d>
801057b0:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801057b3:	8b 73 38             	mov    0x38(%ebx),%esi
801057b6:	e8 c5 de ff ff       	call   80103680 <cpuid>
801057bb:	89 7c 24 10          	mov    %edi,0x10(%esp)
801057bf:	89 74 24 0c          	mov    %esi,0xc(%esp)
801057c3:	89 44 24 08          	mov    %eax,0x8(%esp)
801057c7:	8b 43 30             	mov    0x30(%ebx),%eax
801057ca:	c7 04 24 ec 74 10 80 	movl   $0x801074ec,(%esp)
801057d1:	89 44 24 04          	mov    %eax,0x4(%esp)
801057d5:	e8 76 ae ff ff       	call   80100650 <cprintf>
      panic("trap");
801057da:	c7 04 24 c2 74 10 80 	movl   $0x801074c2,(%esp)
801057e1:	e8 7a ab ff ff       	call   80100360 <panic>
801057e6:	66 90                	xchg   %ax,%ax
801057e8:	66 90                	xchg   %ax,%ax
801057ea:	66 90                	xchg   %ax,%ax
801057ec:	66 90                	xchg   %ax,%ax
801057ee:	66 90                	xchg   %ax,%ax

801057f0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801057f0:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
{
801057f5:	55                   	push   %ebp
801057f6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801057f8:	85 c0                	test   %eax,%eax
801057fa:	74 14                	je     80105810 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801057fc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105801:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105802:	a8 01                	test   $0x1,%al
80105804:	74 0a                	je     80105810 <uartgetc+0x20>
80105806:	b2 f8                	mov    $0xf8,%dl
80105808:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105809:	0f b6 c0             	movzbl %al,%eax
}
8010580c:	5d                   	pop    %ebp
8010580d:	c3                   	ret    
8010580e:	66 90                	xchg   %ax,%ax
    return -1;
80105810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105815:	5d                   	pop    %ebp
80105816:	c3                   	ret    
80105817:	89 f6                	mov    %esi,%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105820 <uartputc>:
  if(!uart)
80105820:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105825:	85 c0                	test   %eax,%eax
80105827:	74 3f                	je     80105868 <uartputc+0x48>
{
80105829:	55                   	push   %ebp
8010582a:	89 e5                	mov    %esp,%ebp
8010582c:	56                   	push   %esi
8010582d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105832:	53                   	push   %ebx
  if(!uart)
80105833:	bb 80 00 00 00       	mov    $0x80,%ebx
{
80105838:	83 ec 10             	sub    $0x10,%esp
8010583b:	eb 14                	jmp    80105851 <uartputc+0x31>
8010583d:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105840:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105847:	e8 54 cf ff ff       	call   801027a0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010584c:	83 eb 01             	sub    $0x1,%ebx
8010584f:	74 07                	je     80105858 <uartputc+0x38>
80105851:	89 f2                	mov    %esi,%edx
80105853:	ec                   	in     (%dx),%al
80105854:	a8 20                	test   $0x20,%al
80105856:	74 e8                	je     80105840 <uartputc+0x20>
  outb(COM1+0, c);
80105858:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010585c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105861:	ee                   	out    %al,(%dx)
}
80105862:	83 c4 10             	add    $0x10,%esp
80105865:	5b                   	pop    %ebx
80105866:	5e                   	pop    %esi
80105867:	5d                   	pop    %ebp
80105868:	f3 c3                	repz ret 
8010586a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105870 <uartinit>:
{
80105870:	55                   	push   %ebp
80105871:	31 c9                	xor    %ecx,%ecx
80105873:	89 e5                	mov    %esp,%ebp
80105875:	89 c8                	mov    %ecx,%eax
80105877:	57                   	push   %edi
80105878:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010587d:	56                   	push   %esi
8010587e:	89 fa                	mov    %edi,%edx
80105880:	53                   	push   %ebx
80105881:	83 ec 1c             	sub    $0x1c,%esp
80105884:	ee                   	out    %al,(%dx)
80105885:	be fb 03 00 00       	mov    $0x3fb,%esi
8010588a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010588f:	89 f2                	mov    %esi,%edx
80105891:	ee                   	out    %al,(%dx)
80105892:	b8 0c 00 00 00       	mov    $0xc,%eax
80105897:	b2 f8                	mov    $0xf8,%dl
80105899:	ee                   	out    %al,(%dx)
8010589a:	bb f9 03 00 00       	mov    $0x3f9,%ebx
8010589f:	89 c8                	mov    %ecx,%eax
801058a1:	89 da                	mov    %ebx,%edx
801058a3:	ee                   	out    %al,(%dx)
801058a4:	b8 03 00 00 00       	mov    $0x3,%eax
801058a9:	89 f2                	mov    %esi,%edx
801058ab:	ee                   	out    %al,(%dx)
801058ac:	b2 fc                	mov    $0xfc,%dl
801058ae:	89 c8                	mov    %ecx,%eax
801058b0:	ee                   	out    %al,(%dx)
801058b1:	b8 01 00 00 00       	mov    $0x1,%eax
801058b6:	89 da                	mov    %ebx,%edx
801058b8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801058b9:	b2 fd                	mov    $0xfd,%dl
801058bb:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801058bc:	3c ff                	cmp    $0xff,%al
801058be:	74 42                	je     80105902 <uartinit+0x92>
  uart = 1;
801058c0:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
801058c7:	00 00 00 
801058ca:	89 fa                	mov    %edi,%edx
801058cc:	ec                   	in     (%dx),%al
801058cd:	b2 f8                	mov    $0xf8,%dl
801058cf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801058d0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801058d7:	00 
  for(p="xv6...\n"; *p; p++)
801058d8:	bb e4 75 10 80       	mov    $0x801075e4,%ebx
  ioapicenable(IRQ_COM1, 0);
801058dd:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801058e4:	e8 c7 c9 ff ff       	call   801022b0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801058e9:	b8 78 00 00 00       	mov    $0x78,%eax
801058ee:	66 90                	xchg   %ax,%ax
    uartputc(*p);
801058f0:	89 04 24             	mov    %eax,(%esp)
  for(p="xv6...\n"; *p; p++)
801058f3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
801058f6:	e8 25 ff ff ff       	call   80105820 <uartputc>
  for(p="xv6...\n"; *p; p++)
801058fb:	0f be 03             	movsbl (%ebx),%eax
801058fe:	84 c0                	test   %al,%al
80105900:	75 ee                	jne    801058f0 <uartinit+0x80>
}
80105902:	83 c4 1c             	add    $0x1c,%esp
80105905:	5b                   	pop    %ebx
80105906:	5e                   	pop    %esi
80105907:	5f                   	pop    %edi
80105908:	5d                   	pop    %ebp
80105909:	c3                   	ret    
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105910 <uartintr>:

void
uartintr(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105916:	c7 04 24 f0 57 10 80 	movl   $0x801057f0,(%esp)
8010591d:	e8 8e ae ff ff       	call   801007b0 <consoleintr>
}
80105922:	c9                   	leave  
80105923:	c3                   	ret    

80105924 <vector0>:
80105924:	6a 00                	push   $0x0
80105926:	6a 00                	push   $0x0
80105928:	e9 5c fb ff ff       	jmp    80105489 <alltraps>

8010592d <vector1>:
8010592d:	6a 00                	push   $0x0
8010592f:	6a 01                	push   $0x1
80105931:	e9 53 fb ff ff       	jmp    80105489 <alltraps>

80105936 <vector2>:
80105936:	6a 00                	push   $0x0
80105938:	6a 02                	push   $0x2
8010593a:	e9 4a fb ff ff       	jmp    80105489 <alltraps>

8010593f <vector3>:
8010593f:	6a 00                	push   $0x0
80105941:	6a 03                	push   $0x3
80105943:	e9 41 fb ff ff       	jmp    80105489 <alltraps>

80105948 <vector4>:
80105948:	6a 00                	push   $0x0
8010594a:	6a 04                	push   $0x4
8010594c:	e9 38 fb ff ff       	jmp    80105489 <alltraps>

80105951 <vector5>:
80105951:	6a 00                	push   $0x0
80105953:	6a 05                	push   $0x5
80105955:	e9 2f fb ff ff       	jmp    80105489 <alltraps>

8010595a <vector6>:
8010595a:	6a 00                	push   $0x0
8010595c:	6a 06                	push   $0x6
8010595e:	e9 26 fb ff ff       	jmp    80105489 <alltraps>

80105963 <vector7>:
80105963:	6a 00                	push   $0x0
80105965:	6a 07                	push   $0x7
80105967:	e9 1d fb ff ff       	jmp    80105489 <alltraps>

8010596c <vector8>:
8010596c:	6a 08                	push   $0x8
8010596e:	e9 16 fb ff ff       	jmp    80105489 <alltraps>

80105973 <vector9>:
80105973:	6a 00                	push   $0x0
80105975:	6a 09                	push   $0x9
80105977:	e9 0d fb ff ff       	jmp    80105489 <alltraps>

8010597c <vector10>:
8010597c:	6a 0a                	push   $0xa
8010597e:	e9 06 fb ff ff       	jmp    80105489 <alltraps>

80105983 <vector11>:
80105983:	6a 0b                	push   $0xb
80105985:	e9 ff fa ff ff       	jmp    80105489 <alltraps>

8010598a <vector12>:
8010598a:	6a 0c                	push   $0xc
8010598c:	e9 f8 fa ff ff       	jmp    80105489 <alltraps>

80105991 <vector13>:
80105991:	6a 0d                	push   $0xd
80105993:	e9 f1 fa ff ff       	jmp    80105489 <alltraps>

80105998 <vector14>:
80105998:	6a 0e                	push   $0xe
8010599a:	e9 ea fa ff ff       	jmp    80105489 <alltraps>

8010599f <vector15>:
8010599f:	6a 00                	push   $0x0
801059a1:	6a 0f                	push   $0xf
801059a3:	e9 e1 fa ff ff       	jmp    80105489 <alltraps>

801059a8 <vector16>:
801059a8:	6a 00                	push   $0x0
801059aa:	6a 10                	push   $0x10
801059ac:	e9 d8 fa ff ff       	jmp    80105489 <alltraps>

801059b1 <vector17>:
801059b1:	6a 11                	push   $0x11
801059b3:	e9 d1 fa ff ff       	jmp    80105489 <alltraps>

801059b8 <vector18>:
801059b8:	6a 00                	push   $0x0
801059ba:	6a 12                	push   $0x12
801059bc:	e9 c8 fa ff ff       	jmp    80105489 <alltraps>

801059c1 <vector19>:
801059c1:	6a 00                	push   $0x0
801059c3:	6a 13                	push   $0x13
801059c5:	e9 bf fa ff ff       	jmp    80105489 <alltraps>

801059ca <vector20>:
801059ca:	6a 00                	push   $0x0
801059cc:	6a 14                	push   $0x14
801059ce:	e9 b6 fa ff ff       	jmp    80105489 <alltraps>

801059d3 <vector21>:
801059d3:	6a 00                	push   $0x0
801059d5:	6a 15                	push   $0x15
801059d7:	e9 ad fa ff ff       	jmp    80105489 <alltraps>

801059dc <vector22>:
801059dc:	6a 00                	push   $0x0
801059de:	6a 16                	push   $0x16
801059e0:	e9 a4 fa ff ff       	jmp    80105489 <alltraps>

801059e5 <vector23>:
801059e5:	6a 00                	push   $0x0
801059e7:	6a 17                	push   $0x17
801059e9:	e9 9b fa ff ff       	jmp    80105489 <alltraps>

801059ee <vector24>:
801059ee:	6a 00                	push   $0x0
801059f0:	6a 18                	push   $0x18
801059f2:	e9 92 fa ff ff       	jmp    80105489 <alltraps>

801059f7 <vector25>:
801059f7:	6a 00                	push   $0x0
801059f9:	6a 19                	push   $0x19
801059fb:	e9 89 fa ff ff       	jmp    80105489 <alltraps>

80105a00 <vector26>:
80105a00:	6a 00                	push   $0x0
80105a02:	6a 1a                	push   $0x1a
80105a04:	e9 80 fa ff ff       	jmp    80105489 <alltraps>

80105a09 <vector27>:
80105a09:	6a 00                	push   $0x0
80105a0b:	6a 1b                	push   $0x1b
80105a0d:	e9 77 fa ff ff       	jmp    80105489 <alltraps>

80105a12 <vector28>:
80105a12:	6a 00                	push   $0x0
80105a14:	6a 1c                	push   $0x1c
80105a16:	e9 6e fa ff ff       	jmp    80105489 <alltraps>

80105a1b <vector29>:
80105a1b:	6a 00                	push   $0x0
80105a1d:	6a 1d                	push   $0x1d
80105a1f:	e9 65 fa ff ff       	jmp    80105489 <alltraps>

80105a24 <vector30>:
80105a24:	6a 00                	push   $0x0
80105a26:	6a 1e                	push   $0x1e
80105a28:	e9 5c fa ff ff       	jmp    80105489 <alltraps>

80105a2d <vector31>:
80105a2d:	6a 00                	push   $0x0
80105a2f:	6a 1f                	push   $0x1f
80105a31:	e9 53 fa ff ff       	jmp    80105489 <alltraps>

80105a36 <vector32>:
80105a36:	6a 00                	push   $0x0
80105a38:	6a 20                	push   $0x20
80105a3a:	e9 4a fa ff ff       	jmp    80105489 <alltraps>

80105a3f <vector33>:
80105a3f:	6a 00                	push   $0x0
80105a41:	6a 21                	push   $0x21
80105a43:	e9 41 fa ff ff       	jmp    80105489 <alltraps>

80105a48 <vector34>:
80105a48:	6a 00                	push   $0x0
80105a4a:	6a 22                	push   $0x22
80105a4c:	e9 38 fa ff ff       	jmp    80105489 <alltraps>

80105a51 <vector35>:
80105a51:	6a 00                	push   $0x0
80105a53:	6a 23                	push   $0x23
80105a55:	e9 2f fa ff ff       	jmp    80105489 <alltraps>

80105a5a <vector36>:
80105a5a:	6a 00                	push   $0x0
80105a5c:	6a 24                	push   $0x24
80105a5e:	e9 26 fa ff ff       	jmp    80105489 <alltraps>

80105a63 <vector37>:
80105a63:	6a 00                	push   $0x0
80105a65:	6a 25                	push   $0x25
80105a67:	e9 1d fa ff ff       	jmp    80105489 <alltraps>

80105a6c <vector38>:
80105a6c:	6a 00                	push   $0x0
80105a6e:	6a 26                	push   $0x26
80105a70:	e9 14 fa ff ff       	jmp    80105489 <alltraps>

80105a75 <vector39>:
80105a75:	6a 00                	push   $0x0
80105a77:	6a 27                	push   $0x27
80105a79:	e9 0b fa ff ff       	jmp    80105489 <alltraps>

80105a7e <vector40>:
80105a7e:	6a 00                	push   $0x0
80105a80:	6a 28                	push   $0x28
80105a82:	e9 02 fa ff ff       	jmp    80105489 <alltraps>

80105a87 <vector41>:
80105a87:	6a 00                	push   $0x0
80105a89:	6a 29                	push   $0x29
80105a8b:	e9 f9 f9 ff ff       	jmp    80105489 <alltraps>

80105a90 <vector42>:
80105a90:	6a 00                	push   $0x0
80105a92:	6a 2a                	push   $0x2a
80105a94:	e9 f0 f9 ff ff       	jmp    80105489 <alltraps>

80105a99 <vector43>:
80105a99:	6a 00                	push   $0x0
80105a9b:	6a 2b                	push   $0x2b
80105a9d:	e9 e7 f9 ff ff       	jmp    80105489 <alltraps>

80105aa2 <vector44>:
80105aa2:	6a 00                	push   $0x0
80105aa4:	6a 2c                	push   $0x2c
80105aa6:	e9 de f9 ff ff       	jmp    80105489 <alltraps>

80105aab <vector45>:
80105aab:	6a 00                	push   $0x0
80105aad:	6a 2d                	push   $0x2d
80105aaf:	e9 d5 f9 ff ff       	jmp    80105489 <alltraps>

80105ab4 <vector46>:
80105ab4:	6a 00                	push   $0x0
80105ab6:	6a 2e                	push   $0x2e
80105ab8:	e9 cc f9 ff ff       	jmp    80105489 <alltraps>

80105abd <vector47>:
80105abd:	6a 00                	push   $0x0
80105abf:	6a 2f                	push   $0x2f
80105ac1:	e9 c3 f9 ff ff       	jmp    80105489 <alltraps>

80105ac6 <vector48>:
80105ac6:	6a 00                	push   $0x0
80105ac8:	6a 30                	push   $0x30
80105aca:	e9 ba f9 ff ff       	jmp    80105489 <alltraps>

80105acf <vector49>:
80105acf:	6a 00                	push   $0x0
80105ad1:	6a 31                	push   $0x31
80105ad3:	e9 b1 f9 ff ff       	jmp    80105489 <alltraps>

80105ad8 <vector50>:
80105ad8:	6a 00                	push   $0x0
80105ada:	6a 32                	push   $0x32
80105adc:	e9 a8 f9 ff ff       	jmp    80105489 <alltraps>

80105ae1 <vector51>:
80105ae1:	6a 00                	push   $0x0
80105ae3:	6a 33                	push   $0x33
80105ae5:	e9 9f f9 ff ff       	jmp    80105489 <alltraps>

80105aea <vector52>:
80105aea:	6a 00                	push   $0x0
80105aec:	6a 34                	push   $0x34
80105aee:	e9 96 f9 ff ff       	jmp    80105489 <alltraps>

80105af3 <vector53>:
80105af3:	6a 00                	push   $0x0
80105af5:	6a 35                	push   $0x35
80105af7:	e9 8d f9 ff ff       	jmp    80105489 <alltraps>

80105afc <vector54>:
80105afc:	6a 00                	push   $0x0
80105afe:	6a 36                	push   $0x36
80105b00:	e9 84 f9 ff ff       	jmp    80105489 <alltraps>

80105b05 <vector55>:
80105b05:	6a 00                	push   $0x0
80105b07:	6a 37                	push   $0x37
80105b09:	e9 7b f9 ff ff       	jmp    80105489 <alltraps>

80105b0e <vector56>:
80105b0e:	6a 00                	push   $0x0
80105b10:	6a 38                	push   $0x38
80105b12:	e9 72 f9 ff ff       	jmp    80105489 <alltraps>

80105b17 <vector57>:
80105b17:	6a 00                	push   $0x0
80105b19:	6a 39                	push   $0x39
80105b1b:	e9 69 f9 ff ff       	jmp    80105489 <alltraps>

80105b20 <vector58>:
80105b20:	6a 00                	push   $0x0
80105b22:	6a 3a                	push   $0x3a
80105b24:	e9 60 f9 ff ff       	jmp    80105489 <alltraps>

80105b29 <vector59>:
80105b29:	6a 00                	push   $0x0
80105b2b:	6a 3b                	push   $0x3b
80105b2d:	e9 57 f9 ff ff       	jmp    80105489 <alltraps>

80105b32 <vector60>:
80105b32:	6a 00                	push   $0x0
80105b34:	6a 3c                	push   $0x3c
80105b36:	e9 4e f9 ff ff       	jmp    80105489 <alltraps>

80105b3b <vector61>:
80105b3b:	6a 00                	push   $0x0
80105b3d:	6a 3d                	push   $0x3d
80105b3f:	e9 45 f9 ff ff       	jmp    80105489 <alltraps>

80105b44 <vector62>:
80105b44:	6a 00                	push   $0x0
80105b46:	6a 3e                	push   $0x3e
80105b48:	e9 3c f9 ff ff       	jmp    80105489 <alltraps>

80105b4d <vector63>:
80105b4d:	6a 00                	push   $0x0
80105b4f:	6a 3f                	push   $0x3f
80105b51:	e9 33 f9 ff ff       	jmp    80105489 <alltraps>

80105b56 <vector64>:
80105b56:	6a 00                	push   $0x0
80105b58:	6a 40                	push   $0x40
80105b5a:	e9 2a f9 ff ff       	jmp    80105489 <alltraps>

80105b5f <vector65>:
80105b5f:	6a 00                	push   $0x0
80105b61:	6a 41                	push   $0x41
80105b63:	e9 21 f9 ff ff       	jmp    80105489 <alltraps>

80105b68 <vector66>:
80105b68:	6a 00                	push   $0x0
80105b6a:	6a 42                	push   $0x42
80105b6c:	e9 18 f9 ff ff       	jmp    80105489 <alltraps>

80105b71 <vector67>:
80105b71:	6a 00                	push   $0x0
80105b73:	6a 43                	push   $0x43
80105b75:	e9 0f f9 ff ff       	jmp    80105489 <alltraps>

80105b7a <vector68>:
80105b7a:	6a 00                	push   $0x0
80105b7c:	6a 44                	push   $0x44
80105b7e:	e9 06 f9 ff ff       	jmp    80105489 <alltraps>

80105b83 <vector69>:
80105b83:	6a 00                	push   $0x0
80105b85:	6a 45                	push   $0x45
80105b87:	e9 fd f8 ff ff       	jmp    80105489 <alltraps>

80105b8c <vector70>:
80105b8c:	6a 00                	push   $0x0
80105b8e:	6a 46                	push   $0x46
80105b90:	e9 f4 f8 ff ff       	jmp    80105489 <alltraps>

80105b95 <vector71>:
80105b95:	6a 00                	push   $0x0
80105b97:	6a 47                	push   $0x47
80105b99:	e9 eb f8 ff ff       	jmp    80105489 <alltraps>

80105b9e <vector72>:
80105b9e:	6a 00                	push   $0x0
80105ba0:	6a 48                	push   $0x48
80105ba2:	e9 e2 f8 ff ff       	jmp    80105489 <alltraps>

80105ba7 <vector73>:
80105ba7:	6a 00                	push   $0x0
80105ba9:	6a 49                	push   $0x49
80105bab:	e9 d9 f8 ff ff       	jmp    80105489 <alltraps>

80105bb0 <vector74>:
80105bb0:	6a 00                	push   $0x0
80105bb2:	6a 4a                	push   $0x4a
80105bb4:	e9 d0 f8 ff ff       	jmp    80105489 <alltraps>

80105bb9 <vector75>:
80105bb9:	6a 00                	push   $0x0
80105bbb:	6a 4b                	push   $0x4b
80105bbd:	e9 c7 f8 ff ff       	jmp    80105489 <alltraps>

80105bc2 <vector76>:
80105bc2:	6a 00                	push   $0x0
80105bc4:	6a 4c                	push   $0x4c
80105bc6:	e9 be f8 ff ff       	jmp    80105489 <alltraps>

80105bcb <vector77>:
80105bcb:	6a 00                	push   $0x0
80105bcd:	6a 4d                	push   $0x4d
80105bcf:	e9 b5 f8 ff ff       	jmp    80105489 <alltraps>

80105bd4 <vector78>:
80105bd4:	6a 00                	push   $0x0
80105bd6:	6a 4e                	push   $0x4e
80105bd8:	e9 ac f8 ff ff       	jmp    80105489 <alltraps>

80105bdd <vector79>:
80105bdd:	6a 00                	push   $0x0
80105bdf:	6a 4f                	push   $0x4f
80105be1:	e9 a3 f8 ff ff       	jmp    80105489 <alltraps>

80105be6 <vector80>:
80105be6:	6a 00                	push   $0x0
80105be8:	6a 50                	push   $0x50
80105bea:	e9 9a f8 ff ff       	jmp    80105489 <alltraps>

80105bef <vector81>:
80105bef:	6a 00                	push   $0x0
80105bf1:	6a 51                	push   $0x51
80105bf3:	e9 91 f8 ff ff       	jmp    80105489 <alltraps>

80105bf8 <vector82>:
80105bf8:	6a 00                	push   $0x0
80105bfa:	6a 52                	push   $0x52
80105bfc:	e9 88 f8 ff ff       	jmp    80105489 <alltraps>

80105c01 <vector83>:
80105c01:	6a 00                	push   $0x0
80105c03:	6a 53                	push   $0x53
80105c05:	e9 7f f8 ff ff       	jmp    80105489 <alltraps>

80105c0a <vector84>:
80105c0a:	6a 00                	push   $0x0
80105c0c:	6a 54                	push   $0x54
80105c0e:	e9 76 f8 ff ff       	jmp    80105489 <alltraps>

80105c13 <vector85>:
80105c13:	6a 00                	push   $0x0
80105c15:	6a 55                	push   $0x55
80105c17:	e9 6d f8 ff ff       	jmp    80105489 <alltraps>

80105c1c <vector86>:
80105c1c:	6a 00                	push   $0x0
80105c1e:	6a 56                	push   $0x56
80105c20:	e9 64 f8 ff ff       	jmp    80105489 <alltraps>

80105c25 <vector87>:
80105c25:	6a 00                	push   $0x0
80105c27:	6a 57                	push   $0x57
80105c29:	e9 5b f8 ff ff       	jmp    80105489 <alltraps>

80105c2e <vector88>:
80105c2e:	6a 00                	push   $0x0
80105c30:	6a 58                	push   $0x58
80105c32:	e9 52 f8 ff ff       	jmp    80105489 <alltraps>

80105c37 <vector89>:
80105c37:	6a 00                	push   $0x0
80105c39:	6a 59                	push   $0x59
80105c3b:	e9 49 f8 ff ff       	jmp    80105489 <alltraps>

80105c40 <vector90>:
80105c40:	6a 00                	push   $0x0
80105c42:	6a 5a                	push   $0x5a
80105c44:	e9 40 f8 ff ff       	jmp    80105489 <alltraps>

80105c49 <vector91>:
80105c49:	6a 00                	push   $0x0
80105c4b:	6a 5b                	push   $0x5b
80105c4d:	e9 37 f8 ff ff       	jmp    80105489 <alltraps>

80105c52 <vector92>:
80105c52:	6a 00                	push   $0x0
80105c54:	6a 5c                	push   $0x5c
80105c56:	e9 2e f8 ff ff       	jmp    80105489 <alltraps>

80105c5b <vector93>:
80105c5b:	6a 00                	push   $0x0
80105c5d:	6a 5d                	push   $0x5d
80105c5f:	e9 25 f8 ff ff       	jmp    80105489 <alltraps>

80105c64 <vector94>:
80105c64:	6a 00                	push   $0x0
80105c66:	6a 5e                	push   $0x5e
80105c68:	e9 1c f8 ff ff       	jmp    80105489 <alltraps>

80105c6d <vector95>:
80105c6d:	6a 00                	push   $0x0
80105c6f:	6a 5f                	push   $0x5f
80105c71:	e9 13 f8 ff ff       	jmp    80105489 <alltraps>

80105c76 <vector96>:
80105c76:	6a 00                	push   $0x0
80105c78:	6a 60                	push   $0x60
80105c7a:	e9 0a f8 ff ff       	jmp    80105489 <alltraps>

80105c7f <vector97>:
80105c7f:	6a 00                	push   $0x0
80105c81:	6a 61                	push   $0x61
80105c83:	e9 01 f8 ff ff       	jmp    80105489 <alltraps>

80105c88 <vector98>:
80105c88:	6a 00                	push   $0x0
80105c8a:	6a 62                	push   $0x62
80105c8c:	e9 f8 f7 ff ff       	jmp    80105489 <alltraps>

80105c91 <vector99>:
80105c91:	6a 00                	push   $0x0
80105c93:	6a 63                	push   $0x63
80105c95:	e9 ef f7 ff ff       	jmp    80105489 <alltraps>

80105c9a <vector100>:
80105c9a:	6a 00                	push   $0x0
80105c9c:	6a 64                	push   $0x64
80105c9e:	e9 e6 f7 ff ff       	jmp    80105489 <alltraps>

80105ca3 <vector101>:
80105ca3:	6a 00                	push   $0x0
80105ca5:	6a 65                	push   $0x65
80105ca7:	e9 dd f7 ff ff       	jmp    80105489 <alltraps>

80105cac <vector102>:
80105cac:	6a 00                	push   $0x0
80105cae:	6a 66                	push   $0x66
80105cb0:	e9 d4 f7 ff ff       	jmp    80105489 <alltraps>

80105cb5 <vector103>:
80105cb5:	6a 00                	push   $0x0
80105cb7:	6a 67                	push   $0x67
80105cb9:	e9 cb f7 ff ff       	jmp    80105489 <alltraps>

80105cbe <vector104>:
80105cbe:	6a 00                	push   $0x0
80105cc0:	6a 68                	push   $0x68
80105cc2:	e9 c2 f7 ff ff       	jmp    80105489 <alltraps>

80105cc7 <vector105>:
80105cc7:	6a 00                	push   $0x0
80105cc9:	6a 69                	push   $0x69
80105ccb:	e9 b9 f7 ff ff       	jmp    80105489 <alltraps>

80105cd0 <vector106>:
80105cd0:	6a 00                	push   $0x0
80105cd2:	6a 6a                	push   $0x6a
80105cd4:	e9 b0 f7 ff ff       	jmp    80105489 <alltraps>

80105cd9 <vector107>:
80105cd9:	6a 00                	push   $0x0
80105cdb:	6a 6b                	push   $0x6b
80105cdd:	e9 a7 f7 ff ff       	jmp    80105489 <alltraps>

80105ce2 <vector108>:
80105ce2:	6a 00                	push   $0x0
80105ce4:	6a 6c                	push   $0x6c
80105ce6:	e9 9e f7 ff ff       	jmp    80105489 <alltraps>

80105ceb <vector109>:
80105ceb:	6a 00                	push   $0x0
80105ced:	6a 6d                	push   $0x6d
80105cef:	e9 95 f7 ff ff       	jmp    80105489 <alltraps>

80105cf4 <vector110>:
80105cf4:	6a 00                	push   $0x0
80105cf6:	6a 6e                	push   $0x6e
80105cf8:	e9 8c f7 ff ff       	jmp    80105489 <alltraps>

80105cfd <vector111>:
80105cfd:	6a 00                	push   $0x0
80105cff:	6a 6f                	push   $0x6f
80105d01:	e9 83 f7 ff ff       	jmp    80105489 <alltraps>

80105d06 <vector112>:
80105d06:	6a 00                	push   $0x0
80105d08:	6a 70                	push   $0x70
80105d0a:	e9 7a f7 ff ff       	jmp    80105489 <alltraps>

80105d0f <vector113>:
80105d0f:	6a 00                	push   $0x0
80105d11:	6a 71                	push   $0x71
80105d13:	e9 71 f7 ff ff       	jmp    80105489 <alltraps>

80105d18 <vector114>:
80105d18:	6a 00                	push   $0x0
80105d1a:	6a 72                	push   $0x72
80105d1c:	e9 68 f7 ff ff       	jmp    80105489 <alltraps>

80105d21 <vector115>:
80105d21:	6a 00                	push   $0x0
80105d23:	6a 73                	push   $0x73
80105d25:	e9 5f f7 ff ff       	jmp    80105489 <alltraps>

80105d2a <vector116>:
80105d2a:	6a 00                	push   $0x0
80105d2c:	6a 74                	push   $0x74
80105d2e:	e9 56 f7 ff ff       	jmp    80105489 <alltraps>

80105d33 <vector117>:
80105d33:	6a 00                	push   $0x0
80105d35:	6a 75                	push   $0x75
80105d37:	e9 4d f7 ff ff       	jmp    80105489 <alltraps>

80105d3c <vector118>:
80105d3c:	6a 00                	push   $0x0
80105d3e:	6a 76                	push   $0x76
80105d40:	e9 44 f7 ff ff       	jmp    80105489 <alltraps>

80105d45 <vector119>:
80105d45:	6a 00                	push   $0x0
80105d47:	6a 77                	push   $0x77
80105d49:	e9 3b f7 ff ff       	jmp    80105489 <alltraps>

80105d4e <vector120>:
80105d4e:	6a 00                	push   $0x0
80105d50:	6a 78                	push   $0x78
80105d52:	e9 32 f7 ff ff       	jmp    80105489 <alltraps>

80105d57 <vector121>:
80105d57:	6a 00                	push   $0x0
80105d59:	6a 79                	push   $0x79
80105d5b:	e9 29 f7 ff ff       	jmp    80105489 <alltraps>

80105d60 <vector122>:
80105d60:	6a 00                	push   $0x0
80105d62:	6a 7a                	push   $0x7a
80105d64:	e9 20 f7 ff ff       	jmp    80105489 <alltraps>

80105d69 <vector123>:
80105d69:	6a 00                	push   $0x0
80105d6b:	6a 7b                	push   $0x7b
80105d6d:	e9 17 f7 ff ff       	jmp    80105489 <alltraps>

80105d72 <vector124>:
80105d72:	6a 00                	push   $0x0
80105d74:	6a 7c                	push   $0x7c
80105d76:	e9 0e f7 ff ff       	jmp    80105489 <alltraps>

80105d7b <vector125>:
80105d7b:	6a 00                	push   $0x0
80105d7d:	6a 7d                	push   $0x7d
80105d7f:	e9 05 f7 ff ff       	jmp    80105489 <alltraps>

80105d84 <vector126>:
80105d84:	6a 00                	push   $0x0
80105d86:	6a 7e                	push   $0x7e
80105d88:	e9 fc f6 ff ff       	jmp    80105489 <alltraps>

80105d8d <vector127>:
80105d8d:	6a 00                	push   $0x0
80105d8f:	6a 7f                	push   $0x7f
80105d91:	e9 f3 f6 ff ff       	jmp    80105489 <alltraps>

80105d96 <vector128>:
80105d96:	6a 00                	push   $0x0
80105d98:	68 80 00 00 00       	push   $0x80
80105d9d:	e9 e7 f6 ff ff       	jmp    80105489 <alltraps>

80105da2 <vector129>:
80105da2:	6a 00                	push   $0x0
80105da4:	68 81 00 00 00       	push   $0x81
80105da9:	e9 db f6 ff ff       	jmp    80105489 <alltraps>

80105dae <vector130>:
80105dae:	6a 00                	push   $0x0
80105db0:	68 82 00 00 00       	push   $0x82
80105db5:	e9 cf f6 ff ff       	jmp    80105489 <alltraps>

80105dba <vector131>:
80105dba:	6a 00                	push   $0x0
80105dbc:	68 83 00 00 00       	push   $0x83
80105dc1:	e9 c3 f6 ff ff       	jmp    80105489 <alltraps>

80105dc6 <vector132>:
80105dc6:	6a 00                	push   $0x0
80105dc8:	68 84 00 00 00       	push   $0x84
80105dcd:	e9 b7 f6 ff ff       	jmp    80105489 <alltraps>

80105dd2 <vector133>:
80105dd2:	6a 00                	push   $0x0
80105dd4:	68 85 00 00 00       	push   $0x85
80105dd9:	e9 ab f6 ff ff       	jmp    80105489 <alltraps>

80105dde <vector134>:
80105dde:	6a 00                	push   $0x0
80105de0:	68 86 00 00 00       	push   $0x86
80105de5:	e9 9f f6 ff ff       	jmp    80105489 <alltraps>

80105dea <vector135>:
80105dea:	6a 00                	push   $0x0
80105dec:	68 87 00 00 00       	push   $0x87
80105df1:	e9 93 f6 ff ff       	jmp    80105489 <alltraps>

80105df6 <vector136>:
80105df6:	6a 00                	push   $0x0
80105df8:	68 88 00 00 00       	push   $0x88
80105dfd:	e9 87 f6 ff ff       	jmp    80105489 <alltraps>

80105e02 <vector137>:
80105e02:	6a 00                	push   $0x0
80105e04:	68 89 00 00 00       	push   $0x89
80105e09:	e9 7b f6 ff ff       	jmp    80105489 <alltraps>

80105e0e <vector138>:
80105e0e:	6a 00                	push   $0x0
80105e10:	68 8a 00 00 00       	push   $0x8a
80105e15:	e9 6f f6 ff ff       	jmp    80105489 <alltraps>

80105e1a <vector139>:
80105e1a:	6a 00                	push   $0x0
80105e1c:	68 8b 00 00 00       	push   $0x8b
80105e21:	e9 63 f6 ff ff       	jmp    80105489 <alltraps>

80105e26 <vector140>:
80105e26:	6a 00                	push   $0x0
80105e28:	68 8c 00 00 00       	push   $0x8c
80105e2d:	e9 57 f6 ff ff       	jmp    80105489 <alltraps>

80105e32 <vector141>:
80105e32:	6a 00                	push   $0x0
80105e34:	68 8d 00 00 00       	push   $0x8d
80105e39:	e9 4b f6 ff ff       	jmp    80105489 <alltraps>

80105e3e <vector142>:
80105e3e:	6a 00                	push   $0x0
80105e40:	68 8e 00 00 00       	push   $0x8e
80105e45:	e9 3f f6 ff ff       	jmp    80105489 <alltraps>

80105e4a <vector143>:
80105e4a:	6a 00                	push   $0x0
80105e4c:	68 8f 00 00 00       	push   $0x8f
80105e51:	e9 33 f6 ff ff       	jmp    80105489 <alltraps>

80105e56 <vector144>:
80105e56:	6a 00                	push   $0x0
80105e58:	68 90 00 00 00       	push   $0x90
80105e5d:	e9 27 f6 ff ff       	jmp    80105489 <alltraps>

80105e62 <vector145>:
80105e62:	6a 00                	push   $0x0
80105e64:	68 91 00 00 00       	push   $0x91
80105e69:	e9 1b f6 ff ff       	jmp    80105489 <alltraps>

80105e6e <vector146>:
80105e6e:	6a 00                	push   $0x0
80105e70:	68 92 00 00 00       	push   $0x92
80105e75:	e9 0f f6 ff ff       	jmp    80105489 <alltraps>

80105e7a <vector147>:
80105e7a:	6a 00                	push   $0x0
80105e7c:	68 93 00 00 00       	push   $0x93
80105e81:	e9 03 f6 ff ff       	jmp    80105489 <alltraps>

80105e86 <vector148>:
80105e86:	6a 00                	push   $0x0
80105e88:	68 94 00 00 00       	push   $0x94
80105e8d:	e9 f7 f5 ff ff       	jmp    80105489 <alltraps>

80105e92 <vector149>:
80105e92:	6a 00                	push   $0x0
80105e94:	68 95 00 00 00       	push   $0x95
80105e99:	e9 eb f5 ff ff       	jmp    80105489 <alltraps>

80105e9e <vector150>:
80105e9e:	6a 00                	push   $0x0
80105ea0:	68 96 00 00 00       	push   $0x96
80105ea5:	e9 df f5 ff ff       	jmp    80105489 <alltraps>

80105eaa <vector151>:
80105eaa:	6a 00                	push   $0x0
80105eac:	68 97 00 00 00       	push   $0x97
80105eb1:	e9 d3 f5 ff ff       	jmp    80105489 <alltraps>

80105eb6 <vector152>:
80105eb6:	6a 00                	push   $0x0
80105eb8:	68 98 00 00 00       	push   $0x98
80105ebd:	e9 c7 f5 ff ff       	jmp    80105489 <alltraps>

80105ec2 <vector153>:
80105ec2:	6a 00                	push   $0x0
80105ec4:	68 99 00 00 00       	push   $0x99
80105ec9:	e9 bb f5 ff ff       	jmp    80105489 <alltraps>

80105ece <vector154>:
80105ece:	6a 00                	push   $0x0
80105ed0:	68 9a 00 00 00       	push   $0x9a
80105ed5:	e9 af f5 ff ff       	jmp    80105489 <alltraps>

80105eda <vector155>:
80105eda:	6a 00                	push   $0x0
80105edc:	68 9b 00 00 00       	push   $0x9b
80105ee1:	e9 a3 f5 ff ff       	jmp    80105489 <alltraps>

80105ee6 <vector156>:
80105ee6:	6a 00                	push   $0x0
80105ee8:	68 9c 00 00 00       	push   $0x9c
80105eed:	e9 97 f5 ff ff       	jmp    80105489 <alltraps>

80105ef2 <vector157>:
80105ef2:	6a 00                	push   $0x0
80105ef4:	68 9d 00 00 00       	push   $0x9d
80105ef9:	e9 8b f5 ff ff       	jmp    80105489 <alltraps>

80105efe <vector158>:
80105efe:	6a 00                	push   $0x0
80105f00:	68 9e 00 00 00       	push   $0x9e
80105f05:	e9 7f f5 ff ff       	jmp    80105489 <alltraps>

80105f0a <vector159>:
80105f0a:	6a 00                	push   $0x0
80105f0c:	68 9f 00 00 00       	push   $0x9f
80105f11:	e9 73 f5 ff ff       	jmp    80105489 <alltraps>

80105f16 <vector160>:
80105f16:	6a 00                	push   $0x0
80105f18:	68 a0 00 00 00       	push   $0xa0
80105f1d:	e9 67 f5 ff ff       	jmp    80105489 <alltraps>

80105f22 <vector161>:
80105f22:	6a 00                	push   $0x0
80105f24:	68 a1 00 00 00       	push   $0xa1
80105f29:	e9 5b f5 ff ff       	jmp    80105489 <alltraps>

80105f2e <vector162>:
80105f2e:	6a 00                	push   $0x0
80105f30:	68 a2 00 00 00       	push   $0xa2
80105f35:	e9 4f f5 ff ff       	jmp    80105489 <alltraps>

80105f3a <vector163>:
80105f3a:	6a 00                	push   $0x0
80105f3c:	68 a3 00 00 00       	push   $0xa3
80105f41:	e9 43 f5 ff ff       	jmp    80105489 <alltraps>

80105f46 <vector164>:
80105f46:	6a 00                	push   $0x0
80105f48:	68 a4 00 00 00       	push   $0xa4
80105f4d:	e9 37 f5 ff ff       	jmp    80105489 <alltraps>

80105f52 <vector165>:
80105f52:	6a 00                	push   $0x0
80105f54:	68 a5 00 00 00       	push   $0xa5
80105f59:	e9 2b f5 ff ff       	jmp    80105489 <alltraps>

80105f5e <vector166>:
80105f5e:	6a 00                	push   $0x0
80105f60:	68 a6 00 00 00       	push   $0xa6
80105f65:	e9 1f f5 ff ff       	jmp    80105489 <alltraps>

80105f6a <vector167>:
80105f6a:	6a 00                	push   $0x0
80105f6c:	68 a7 00 00 00       	push   $0xa7
80105f71:	e9 13 f5 ff ff       	jmp    80105489 <alltraps>

80105f76 <vector168>:
80105f76:	6a 00                	push   $0x0
80105f78:	68 a8 00 00 00       	push   $0xa8
80105f7d:	e9 07 f5 ff ff       	jmp    80105489 <alltraps>

80105f82 <vector169>:
80105f82:	6a 00                	push   $0x0
80105f84:	68 a9 00 00 00       	push   $0xa9
80105f89:	e9 fb f4 ff ff       	jmp    80105489 <alltraps>

80105f8e <vector170>:
80105f8e:	6a 00                	push   $0x0
80105f90:	68 aa 00 00 00       	push   $0xaa
80105f95:	e9 ef f4 ff ff       	jmp    80105489 <alltraps>

80105f9a <vector171>:
80105f9a:	6a 00                	push   $0x0
80105f9c:	68 ab 00 00 00       	push   $0xab
80105fa1:	e9 e3 f4 ff ff       	jmp    80105489 <alltraps>

80105fa6 <vector172>:
80105fa6:	6a 00                	push   $0x0
80105fa8:	68 ac 00 00 00       	push   $0xac
80105fad:	e9 d7 f4 ff ff       	jmp    80105489 <alltraps>

80105fb2 <vector173>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	68 ad 00 00 00       	push   $0xad
80105fb9:	e9 cb f4 ff ff       	jmp    80105489 <alltraps>

80105fbe <vector174>:
80105fbe:	6a 00                	push   $0x0
80105fc0:	68 ae 00 00 00       	push   $0xae
80105fc5:	e9 bf f4 ff ff       	jmp    80105489 <alltraps>

80105fca <vector175>:
80105fca:	6a 00                	push   $0x0
80105fcc:	68 af 00 00 00       	push   $0xaf
80105fd1:	e9 b3 f4 ff ff       	jmp    80105489 <alltraps>

80105fd6 <vector176>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	68 b0 00 00 00       	push   $0xb0
80105fdd:	e9 a7 f4 ff ff       	jmp    80105489 <alltraps>

80105fe2 <vector177>:
80105fe2:	6a 00                	push   $0x0
80105fe4:	68 b1 00 00 00       	push   $0xb1
80105fe9:	e9 9b f4 ff ff       	jmp    80105489 <alltraps>

80105fee <vector178>:
80105fee:	6a 00                	push   $0x0
80105ff0:	68 b2 00 00 00       	push   $0xb2
80105ff5:	e9 8f f4 ff ff       	jmp    80105489 <alltraps>

80105ffa <vector179>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	68 b3 00 00 00       	push   $0xb3
80106001:	e9 83 f4 ff ff       	jmp    80105489 <alltraps>

80106006 <vector180>:
80106006:	6a 00                	push   $0x0
80106008:	68 b4 00 00 00       	push   $0xb4
8010600d:	e9 77 f4 ff ff       	jmp    80105489 <alltraps>

80106012 <vector181>:
80106012:	6a 00                	push   $0x0
80106014:	68 b5 00 00 00       	push   $0xb5
80106019:	e9 6b f4 ff ff       	jmp    80105489 <alltraps>

8010601e <vector182>:
8010601e:	6a 00                	push   $0x0
80106020:	68 b6 00 00 00       	push   $0xb6
80106025:	e9 5f f4 ff ff       	jmp    80105489 <alltraps>

8010602a <vector183>:
8010602a:	6a 00                	push   $0x0
8010602c:	68 b7 00 00 00       	push   $0xb7
80106031:	e9 53 f4 ff ff       	jmp    80105489 <alltraps>

80106036 <vector184>:
80106036:	6a 00                	push   $0x0
80106038:	68 b8 00 00 00       	push   $0xb8
8010603d:	e9 47 f4 ff ff       	jmp    80105489 <alltraps>

80106042 <vector185>:
80106042:	6a 00                	push   $0x0
80106044:	68 b9 00 00 00       	push   $0xb9
80106049:	e9 3b f4 ff ff       	jmp    80105489 <alltraps>

8010604e <vector186>:
8010604e:	6a 00                	push   $0x0
80106050:	68 ba 00 00 00       	push   $0xba
80106055:	e9 2f f4 ff ff       	jmp    80105489 <alltraps>

8010605a <vector187>:
8010605a:	6a 00                	push   $0x0
8010605c:	68 bb 00 00 00       	push   $0xbb
80106061:	e9 23 f4 ff ff       	jmp    80105489 <alltraps>

80106066 <vector188>:
80106066:	6a 00                	push   $0x0
80106068:	68 bc 00 00 00       	push   $0xbc
8010606d:	e9 17 f4 ff ff       	jmp    80105489 <alltraps>

80106072 <vector189>:
80106072:	6a 00                	push   $0x0
80106074:	68 bd 00 00 00       	push   $0xbd
80106079:	e9 0b f4 ff ff       	jmp    80105489 <alltraps>

8010607e <vector190>:
8010607e:	6a 00                	push   $0x0
80106080:	68 be 00 00 00       	push   $0xbe
80106085:	e9 ff f3 ff ff       	jmp    80105489 <alltraps>

8010608a <vector191>:
8010608a:	6a 00                	push   $0x0
8010608c:	68 bf 00 00 00       	push   $0xbf
80106091:	e9 f3 f3 ff ff       	jmp    80105489 <alltraps>

80106096 <vector192>:
80106096:	6a 00                	push   $0x0
80106098:	68 c0 00 00 00       	push   $0xc0
8010609d:	e9 e7 f3 ff ff       	jmp    80105489 <alltraps>

801060a2 <vector193>:
801060a2:	6a 00                	push   $0x0
801060a4:	68 c1 00 00 00       	push   $0xc1
801060a9:	e9 db f3 ff ff       	jmp    80105489 <alltraps>

801060ae <vector194>:
801060ae:	6a 00                	push   $0x0
801060b0:	68 c2 00 00 00       	push   $0xc2
801060b5:	e9 cf f3 ff ff       	jmp    80105489 <alltraps>

801060ba <vector195>:
801060ba:	6a 00                	push   $0x0
801060bc:	68 c3 00 00 00       	push   $0xc3
801060c1:	e9 c3 f3 ff ff       	jmp    80105489 <alltraps>

801060c6 <vector196>:
801060c6:	6a 00                	push   $0x0
801060c8:	68 c4 00 00 00       	push   $0xc4
801060cd:	e9 b7 f3 ff ff       	jmp    80105489 <alltraps>

801060d2 <vector197>:
801060d2:	6a 00                	push   $0x0
801060d4:	68 c5 00 00 00       	push   $0xc5
801060d9:	e9 ab f3 ff ff       	jmp    80105489 <alltraps>

801060de <vector198>:
801060de:	6a 00                	push   $0x0
801060e0:	68 c6 00 00 00       	push   $0xc6
801060e5:	e9 9f f3 ff ff       	jmp    80105489 <alltraps>

801060ea <vector199>:
801060ea:	6a 00                	push   $0x0
801060ec:	68 c7 00 00 00       	push   $0xc7
801060f1:	e9 93 f3 ff ff       	jmp    80105489 <alltraps>

801060f6 <vector200>:
801060f6:	6a 00                	push   $0x0
801060f8:	68 c8 00 00 00       	push   $0xc8
801060fd:	e9 87 f3 ff ff       	jmp    80105489 <alltraps>

80106102 <vector201>:
80106102:	6a 00                	push   $0x0
80106104:	68 c9 00 00 00       	push   $0xc9
80106109:	e9 7b f3 ff ff       	jmp    80105489 <alltraps>

8010610e <vector202>:
8010610e:	6a 00                	push   $0x0
80106110:	68 ca 00 00 00       	push   $0xca
80106115:	e9 6f f3 ff ff       	jmp    80105489 <alltraps>

8010611a <vector203>:
8010611a:	6a 00                	push   $0x0
8010611c:	68 cb 00 00 00       	push   $0xcb
80106121:	e9 63 f3 ff ff       	jmp    80105489 <alltraps>

80106126 <vector204>:
80106126:	6a 00                	push   $0x0
80106128:	68 cc 00 00 00       	push   $0xcc
8010612d:	e9 57 f3 ff ff       	jmp    80105489 <alltraps>

80106132 <vector205>:
80106132:	6a 00                	push   $0x0
80106134:	68 cd 00 00 00       	push   $0xcd
80106139:	e9 4b f3 ff ff       	jmp    80105489 <alltraps>

8010613e <vector206>:
8010613e:	6a 00                	push   $0x0
80106140:	68 ce 00 00 00       	push   $0xce
80106145:	e9 3f f3 ff ff       	jmp    80105489 <alltraps>

8010614a <vector207>:
8010614a:	6a 00                	push   $0x0
8010614c:	68 cf 00 00 00       	push   $0xcf
80106151:	e9 33 f3 ff ff       	jmp    80105489 <alltraps>

80106156 <vector208>:
80106156:	6a 00                	push   $0x0
80106158:	68 d0 00 00 00       	push   $0xd0
8010615d:	e9 27 f3 ff ff       	jmp    80105489 <alltraps>

80106162 <vector209>:
80106162:	6a 00                	push   $0x0
80106164:	68 d1 00 00 00       	push   $0xd1
80106169:	e9 1b f3 ff ff       	jmp    80105489 <alltraps>

8010616e <vector210>:
8010616e:	6a 00                	push   $0x0
80106170:	68 d2 00 00 00       	push   $0xd2
80106175:	e9 0f f3 ff ff       	jmp    80105489 <alltraps>

8010617a <vector211>:
8010617a:	6a 00                	push   $0x0
8010617c:	68 d3 00 00 00       	push   $0xd3
80106181:	e9 03 f3 ff ff       	jmp    80105489 <alltraps>

80106186 <vector212>:
80106186:	6a 00                	push   $0x0
80106188:	68 d4 00 00 00       	push   $0xd4
8010618d:	e9 f7 f2 ff ff       	jmp    80105489 <alltraps>

80106192 <vector213>:
80106192:	6a 00                	push   $0x0
80106194:	68 d5 00 00 00       	push   $0xd5
80106199:	e9 eb f2 ff ff       	jmp    80105489 <alltraps>

8010619e <vector214>:
8010619e:	6a 00                	push   $0x0
801061a0:	68 d6 00 00 00       	push   $0xd6
801061a5:	e9 df f2 ff ff       	jmp    80105489 <alltraps>

801061aa <vector215>:
801061aa:	6a 00                	push   $0x0
801061ac:	68 d7 00 00 00       	push   $0xd7
801061b1:	e9 d3 f2 ff ff       	jmp    80105489 <alltraps>

801061b6 <vector216>:
801061b6:	6a 00                	push   $0x0
801061b8:	68 d8 00 00 00       	push   $0xd8
801061bd:	e9 c7 f2 ff ff       	jmp    80105489 <alltraps>

801061c2 <vector217>:
801061c2:	6a 00                	push   $0x0
801061c4:	68 d9 00 00 00       	push   $0xd9
801061c9:	e9 bb f2 ff ff       	jmp    80105489 <alltraps>

801061ce <vector218>:
801061ce:	6a 00                	push   $0x0
801061d0:	68 da 00 00 00       	push   $0xda
801061d5:	e9 af f2 ff ff       	jmp    80105489 <alltraps>

801061da <vector219>:
801061da:	6a 00                	push   $0x0
801061dc:	68 db 00 00 00       	push   $0xdb
801061e1:	e9 a3 f2 ff ff       	jmp    80105489 <alltraps>

801061e6 <vector220>:
801061e6:	6a 00                	push   $0x0
801061e8:	68 dc 00 00 00       	push   $0xdc
801061ed:	e9 97 f2 ff ff       	jmp    80105489 <alltraps>

801061f2 <vector221>:
801061f2:	6a 00                	push   $0x0
801061f4:	68 dd 00 00 00       	push   $0xdd
801061f9:	e9 8b f2 ff ff       	jmp    80105489 <alltraps>

801061fe <vector222>:
801061fe:	6a 00                	push   $0x0
80106200:	68 de 00 00 00       	push   $0xde
80106205:	e9 7f f2 ff ff       	jmp    80105489 <alltraps>

8010620a <vector223>:
8010620a:	6a 00                	push   $0x0
8010620c:	68 df 00 00 00       	push   $0xdf
80106211:	e9 73 f2 ff ff       	jmp    80105489 <alltraps>

80106216 <vector224>:
80106216:	6a 00                	push   $0x0
80106218:	68 e0 00 00 00       	push   $0xe0
8010621d:	e9 67 f2 ff ff       	jmp    80105489 <alltraps>

80106222 <vector225>:
80106222:	6a 00                	push   $0x0
80106224:	68 e1 00 00 00       	push   $0xe1
80106229:	e9 5b f2 ff ff       	jmp    80105489 <alltraps>

8010622e <vector226>:
8010622e:	6a 00                	push   $0x0
80106230:	68 e2 00 00 00       	push   $0xe2
80106235:	e9 4f f2 ff ff       	jmp    80105489 <alltraps>

8010623a <vector227>:
8010623a:	6a 00                	push   $0x0
8010623c:	68 e3 00 00 00       	push   $0xe3
80106241:	e9 43 f2 ff ff       	jmp    80105489 <alltraps>

80106246 <vector228>:
80106246:	6a 00                	push   $0x0
80106248:	68 e4 00 00 00       	push   $0xe4
8010624d:	e9 37 f2 ff ff       	jmp    80105489 <alltraps>

80106252 <vector229>:
80106252:	6a 00                	push   $0x0
80106254:	68 e5 00 00 00       	push   $0xe5
80106259:	e9 2b f2 ff ff       	jmp    80105489 <alltraps>

8010625e <vector230>:
8010625e:	6a 00                	push   $0x0
80106260:	68 e6 00 00 00       	push   $0xe6
80106265:	e9 1f f2 ff ff       	jmp    80105489 <alltraps>

8010626a <vector231>:
8010626a:	6a 00                	push   $0x0
8010626c:	68 e7 00 00 00       	push   $0xe7
80106271:	e9 13 f2 ff ff       	jmp    80105489 <alltraps>

80106276 <vector232>:
80106276:	6a 00                	push   $0x0
80106278:	68 e8 00 00 00       	push   $0xe8
8010627d:	e9 07 f2 ff ff       	jmp    80105489 <alltraps>

80106282 <vector233>:
80106282:	6a 00                	push   $0x0
80106284:	68 e9 00 00 00       	push   $0xe9
80106289:	e9 fb f1 ff ff       	jmp    80105489 <alltraps>

8010628e <vector234>:
8010628e:	6a 00                	push   $0x0
80106290:	68 ea 00 00 00       	push   $0xea
80106295:	e9 ef f1 ff ff       	jmp    80105489 <alltraps>

8010629a <vector235>:
8010629a:	6a 00                	push   $0x0
8010629c:	68 eb 00 00 00       	push   $0xeb
801062a1:	e9 e3 f1 ff ff       	jmp    80105489 <alltraps>

801062a6 <vector236>:
801062a6:	6a 00                	push   $0x0
801062a8:	68 ec 00 00 00       	push   $0xec
801062ad:	e9 d7 f1 ff ff       	jmp    80105489 <alltraps>

801062b2 <vector237>:
801062b2:	6a 00                	push   $0x0
801062b4:	68 ed 00 00 00       	push   $0xed
801062b9:	e9 cb f1 ff ff       	jmp    80105489 <alltraps>

801062be <vector238>:
801062be:	6a 00                	push   $0x0
801062c0:	68 ee 00 00 00       	push   $0xee
801062c5:	e9 bf f1 ff ff       	jmp    80105489 <alltraps>

801062ca <vector239>:
801062ca:	6a 00                	push   $0x0
801062cc:	68 ef 00 00 00       	push   $0xef
801062d1:	e9 b3 f1 ff ff       	jmp    80105489 <alltraps>

801062d6 <vector240>:
801062d6:	6a 00                	push   $0x0
801062d8:	68 f0 00 00 00       	push   $0xf0
801062dd:	e9 a7 f1 ff ff       	jmp    80105489 <alltraps>

801062e2 <vector241>:
801062e2:	6a 00                	push   $0x0
801062e4:	68 f1 00 00 00       	push   $0xf1
801062e9:	e9 9b f1 ff ff       	jmp    80105489 <alltraps>

801062ee <vector242>:
801062ee:	6a 00                	push   $0x0
801062f0:	68 f2 00 00 00       	push   $0xf2
801062f5:	e9 8f f1 ff ff       	jmp    80105489 <alltraps>

801062fa <vector243>:
801062fa:	6a 00                	push   $0x0
801062fc:	68 f3 00 00 00       	push   $0xf3
80106301:	e9 83 f1 ff ff       	jmp    80105489 <alltraps>

80106306 <vector244>:
80106306:	6a 00                	push   $0x0
80106308:	68 f4 00 00 00       	push   $0xf4
8010630d:	e9 77 f1 ff ff       	jmp    80105489 <alltraps>

80106312 <vector245>:
80106312:	6a 00                	push   $0x0
80106314:	68 f5 00 00 00       	push   $0xf5
80106319:	e9 6b f1 ff ff       	jmp    80105489 <alltraps>

8010631e <vector246>:
8010631e:	6a 00                	push   $0x0
80106320:	68 f6 00 00 00       	push   $0xf6
80106325:	e9 5f f1 ff ff       	jmp    80105489 <alltraps>

8010632a <vector247>:
8010632a:	6a 00                	push   $0x0
8010632c:	68 f7 00 00 00       	push   $0xf7
80106331:	e9 53 f1 ff ff       	jmp    80105489 <alltraps>

80106336 <vector248>:
80106336:	6a 00                	push   $0x0
80106338:	68 f8 00 00 00       	push   $0xf8
8010633d:	e9 47 f1 ff ff       	jmp    80105489 <alltraps>

80106342 <vector249>:
80106342:	6a 00                	push   $0x0
80106344:	68 f9 00 00 00       	push   $0xf9
80106349:	e9 3b f1 ff ff       	jmp    80105489 <alltraps>

8010634e <vector250>:
8010634e:	6a 00                	push   $0x0
80106350:	68 fa 00 00 00       	push   $0xfa
80106355:	e9 2f f1 ff ff       	jmp    80105489 <alltraps>

8010635a <vector251>:
8010635a:	6a 00                	push   $0x0
8010635c:	68 fb 00 00 00       	push   $0xfb
80106361:	e9 23 f1 ff ff       	jmp    80105489 <alltraps>

80106366 <vector252>:
80106366:	6a 00                	push   $0x0
80106368:	68 fc 00 00 00       	push   $0xfc
8010636d:	e9 17 f1 ff ff       	jmp    80105489 <alltraps>

80106372 <vector253>:
80106372:	6a 00                	push   $0x0
80106374:	68 fd 00 00 00       	push   $0xfd
80106379:	e9 0b f1 ff ff       	jmp    80105489 <alltraps>

8010637e <vector254>:
8010637e:	6a 00                	push   $0x0
80106380:	68 fe 00 00 00       	push   $0xfe
80106385:	e9 ff f0 ff ff       	jmp    80105489 <alltraps>

8010638a <vector255>:
8010638a:	6a 00                	push   $0x0
8010638c:	68 ff 00 00 00       	push   $0xff
80106391:	e9 f3 f0 ff ff       	jmp    80105489 <alltraps>
80106396:	66 90                	xchg   %ax,%ax
80106398:	66 90                	xchg   %ax,%ax
8010639a:	66 90                	xchg   %ax,%ax
8010639c:	66 90                	xchg   %ax,%ax
8010639e:	66 90                	xchg   %ax,%ax

801063a0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	57                   	push   %edi
801063a4:	56                   	push   %esi
801063a5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801063a7:	c1 ea 16             	shr    $0x16,%edx
{
801063aa:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801063ab:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801063ae:	83 ec 1c             	sub    $0x1c,%esp
  if(*pde & PTE_P){
801063b1:	8b 1f                	mov    (%edi),%ebx
801063b3:	f6 c3 01             	test   $0x1,%bl
801063b6:	74 28                	je     801063e0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801063b8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801063be:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801063c4:	c1 ee 0a             	shr    $0xa,%esi
}
801063c7:	83 c4 1c             	add    $0x1c,%esp
  return &pgtab[PTX(va)];
801063ca:	89 f2                	mov    %esi,%edx
801063cc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801063d2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801063d5:	5b                   	pop    %ebx
801063d6:	5e                   	pop    %esi
801063d7:	5f                   	pop    %edi
801063d8:	5d                   	pop    %ebp
801063d9:	c3                   	ret    
801063da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801063e0:	85 c9                	test   %ecx,%ecx
801063e2:	74 34                	je     80106418 <walkpgdir+0x78>
801063e4:	e8 b7 c0 ff ff       	call   801024a0 <kalloc>
801063e9:	85 c0                	test   %eax,%eax
801063eb:	89 c3                	mov    %eax,%ebx
801063ed:	74 29                	je     80106418 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
801063ef:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801063f6:	00 
801063f7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801063fe:	00 
801063ff:	89 04 24             	mov    %eax,(%esp)
80106402:	e8 59 df ff ff       	call   80104360 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106407:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010640d:	83 c8 07             	or     $0x7,%eax
80106410:	89 07                	mov    %eax,(%edi)
80106412:	eb b0                	jmp    801063c4 <walkpgdir+0x24>
80106414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80106418:	83 c4 1c             	add    $0x1c,%esp
      return 0;
8010641b:	31 c0                	xor    %eax,%eax
}
8010641d:	5b                   	pop    %ebx
8010641e:	5e                   	pop    %esi
8010641f:	5f                   	pop    %edi
80106420:	5d                   	pop    %ebp
80106421:	c3                   	ret    
80106422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106430 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106430:	55                   	push   %ebp
80106431:	89 e5                	mov    %esp,%ebp
80106433:	57                   	push   %edi
80106434:	56                   	push   %esi
80106435:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106436:	89 d3                	mov    %edx,%ebx
{
80106438:	83 ec 1c             	sub    $0x1c,%esp
8010643b:	8b 7d 08             	mov    0x8(%ebp),%edi
  a = (char*)PGROUNDDOWN((uint)va);
8010643e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106444:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106447:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
8010644b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010644e:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106452:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80106459:	29 df                	sub    %ebx,%edi
8010645b:	eb 18                	jmp    80106475 <mappages+0x45>
8010645d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
80106460:	f6 00 01             	testb  $0x1,(%eax)
80106463:	75 3d                	jne    801064a2 <mappages+0x72>
    *pte = pa | perm | PTE_P;
80106465:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106468:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010646b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010646d:	74 29                	je     80106498 <mappages+0x68>
      break;
    a += PGSIZE;
8010646f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106475:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106478:	b9 01 00 00 00       	mov    $0x1,%ecx
8010647d:	89 da                	mov    %ebx,%edx
8010647f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106482:	e8 19 ff ff ff       	call   801063a0 <walkpgdir>
80106487:	85 c0                	test   %eax,%eax
80106489:	75 d5                	jne    80106460 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010648b:	83 c4 1c             	add    $0x1c,%esp
      return -1;
8010648e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106493:	5b                   	pop    %ebx
80106494:	5e                   	pop    %esi
80106495:	5f                   	pop    %edi
80106496:	5d                   	pop    %ebp
80106497:	c3                   	ret    
80106498:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010649b:	31 c0                	xor    %eax,%eax
}
8010649d:	5b                   	pop    %ebx
8010649e:	5e                   	pop    %esi
8010649f:	5f                   	pop    %edi
801064a0:	5d                   	pop    %ebp
801064a1:	c3                   	ret    
      panic("remap");
801064a2:	c7 04 24 ec 75 10 80 	movl   $0x801075ec,(%esp)
801064a9:	e8 b2 9e ff ff       	call   80100360 <panic>
801064ae:	66 90                	xchg   %ax,%ax

801064b0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	57                   	push   %edi
801064b4:	89 c7                	mov    %eax,%edi
801064b6:	56                   	push   %esi
801064b7:	89 d6                	mov    %edx,%esi
801064b9:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801064ba:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801064c0:	83 ec 1c             	sub    $0x1c,%esp
  a = PGROUNDUP(newsz);
801064c3:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801064c9:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801064cb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801064ce:	72 3b                	jb     8010650b <deallocuvm.part.0+0x5b>
801064d0:	eb 5e                	jmp    80106530 <deallocuvm.part.0+0x80>
801064d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801064d8:	8b 10                	mov    (%eax),%edx
801064da:	f6 c2 01             	test   $0x1,%dl
801064dd:	74 22                	je     80106501 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801064df:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801064e5:	74 54                	je     8010653b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
801064e7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801064ed:	89 14 24             	mov    %edx,(%esp)
801064f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801064f3:	e8 f8 bd ff ff       	call   801022f0 <kfree>
      *pte = 0;
801064f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801064fb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106501:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106507:	39 f3                	cmp    %esi,%ebx
80106509:	73 25                	jae    80106530 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010650b:	31 c9                	xor    %ecx,%ecx
8010650d:	89 da                	mov    %ebx,%edx
8010650f:	89 f8                	mov    %edi,%eax
80106511:	e8 8a fe ff ff       	call   801063a0 <walkpgdir>
    if(!pte)
80106516:	85 c0                	test   %eax,%eax
80106518:	75 be                	jne    801064d8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010651a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106520:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106526:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010652c:	39 f3                	cmp    %esi,%ebx
8010652e:	72 db                	jb     8010650b <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80106530:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106533:	83 c4 1c             	add    $0x1c,%esp
80106536:	5b                   	pop    %ebx
80106537:	5e                   	pop    %esi
80106538:	5f                   	pop    %edi
80106539:	5d                   	pop    %ebp
8010653a:	c3                   	ret    
        panic("kfree");
8010653b:	c7 04 24 26 6f 10 80 	movl   $0x80106f26,(%esp)
80106542:	e8 19 9e ff ff       	call   80100360 <panic>
80106547:	89 f6                	mov    %esi,%esi
80106549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106550 <seginit>:
{
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
80106553:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106556:	e8 25 d1 ff ff       	call   80103680 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010655b:	31 c9                	xor    %ecx,%ecx
8010655d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c = &cpus[cpuid()];
80106562:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106568:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010656d:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106571:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  lgdt(c->gdt, sizeof(c->gdt));
80106576:	83 c0 70             	add    $0x70,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106579:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010657d:	31 c9                	xor    %ecx,%ecx
8010657f:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106583:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106588:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010658c:	31 c9                	xor    %ecx,%ecx
8010658e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106592:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106597:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010659b:	31 c9                	xor    %ecx,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010659d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
801065a1:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065a5:	c6 40 15 92          	movb   $0x92,0x15(%eax)
801065a9:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065ad:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
801065b1:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801065b5:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
801065b9:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
801065bd:	66 89 50 20          	mov    %dx,0x20(%eax)
  pd[0] = size-1;
801065c1:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065c6:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
801065ca:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065ce:	c6 40 14 00          	movb   $0x0,0x14(%eax)
801065d2:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801065d6:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
801065da:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801065de:	66 89 48 22          	mov    %cx,0x22(%eax)
801065e2:	c6 40 24 00          	movb   $0x0,0x24(%eax)
801065e6:	c6 40 27 00          	movb   $0x0,0x27(%eax)
801065ea:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801065ee:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801065f2:	c1 e8 10             	shr    $0x10,%eax
801065f5:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801065f9:	8d 45 f2             	lea    -0xe(%ebp),%eax
801065fc:	0f 01 10             	lgdtl  (%eax)
}
801065ff:	c9                   	leave  
80106600:	c3                   	ret    
80106601:	eb 0d                	jmp    80106610 <switchkvm>
80106603:	90                   	nop
80106604:	90                   	nop
80106605:	90                   	nop
80106606:	90                   	nop
80106607:	90                   	nop
80106608:	90                   	nop
80106609:	90                   	nop
8010660a:	90                   	nop
8010660b:	90                   	nop
8010660c:	90                   	nop
8010660d:	90                   	nop
8010660e:	90                   	nop
8010660f:	90                   	nop

80106610 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106610:	a1 a4 54 11 80       	mov    0x801154a4,%eax
{
80106615:	55                   	push   %ebp
80106616:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106618:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010661d:	0f 22 d8             	mov    %eax,%cr3
}
80106620:	5d                   	pop    %ebp
80106621:	c3                   	ret    
80106622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106630 <switchuvm>:
{
80106630:	55                   	push   %ebp
80106631:	89 e5                	mov    %esp,%ebp
80106633:	57                   	push   %edi
80106634:	56                   	push   %esi
80106635:	53                   	push   %ebx
80106636:	83 ec 1c             	sub    $0x1c,%esp
80106639:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010663c:	85 f6                	test   %esi,%esi
8010663e:	0f 84 cd 00 00 00    	je     80106711 <switchuvm+0xe1>
  if(p->kstack == 0)
80106644:	8b 46 08             	mov    0x8(%esi),%eax
80106647:	85 c0                	test   %eax,%eax
80106649:	0f 84 da 00 00 00    	je     80106729 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010664f:	8b 7e 04             	mov    0x4(%esi),%edi
80106652:	85 ff                	test   %edi,%edi
80106654:	0f 84 c3 00 00 00    	je     8010671d <switchuvm+0xed>
  pushcli();
8010665a:	e8 51 db ff ff       	call   801041b0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010665f:	e8 9c cf ff ff       	call   80103600 <mycpu>
80106664:	89 c3                	mov    %eax,%ebx
80106666:	e8 95 cf ff ff       	call   80103600 <mycpu>
8010666b:	89 c7                	mov    %eax,%edi
8010666d:	e8 8e cf ff ff       	call   80103600 <mycpu>
80106672:	83 c7 08             	add    $0x8,%edi
80106675:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106678:	e8 83 cf ff ff       	call   80103600 <mycpu>
8010667d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106680:	ba 67 00 00 00       	mov    $0x67,%edx
80106685:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010668c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106693:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
8010669a:	83 c1 08             	add    $0x8,%ecx
8010669d:	c1 e9 10             	shr    $0x10,%ecx
801066a0:	83 c0 08             	add    $0x8,%eax
801066a3:	c1 e8 18             	shr    $0x18,%eax
801066a6:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801066ac:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
801066b3:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801066b9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801066be:	e8 3d cf ff ff       	call   80103600 <mycpu>
801066c3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801066ca:	e8 31 cf ff ff       	call   80103600 <mycpu>
801066cf:	b9 10 00 00 00       	mov    $0x10,%ecx
801066d4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801066d8:	e8 23 cf ff ff       	call   80103600 <mycpu>
801066dd:	8b 56 08             	mov    0x8(%esi),%edx
801066e0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801066e6:	89 48 0c             	mov    %ecx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801066e9:	e8 12 cf ff ff       	call   80103600 <mycpu>
801066ee:	66 89 58 6e          	mov    %bx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801066f2:	b8 28 00 00 00       	mov    $0x28,%eax
801066f7:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801066fa:	8b 46 04             	mov    0x4(%esi),%eax
801066fd:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106702:	0f 22 d8             	mov    %eax,%cr3
}
80106705:	83 c4 1c             	add    $0x1c,%esp
80106708:	5b                   	pop    %ebx
80106709:	5e                   	pop    %esi
8010670a:	5f                   	pop    %edi
8010670b:	5d                   	pop    %ebp
  popcli();
8010670c:	e9 df da ff ff       	jmp    801041f0 <popcli>
    panic("switchuvm: no process");
80106711:	c7 04 24 f2 75 10 80 	movl   $0x801075f2,(%esp)
80106718:	e8 43 9c ff ff       	call   80100360 <panic>
    panic("switchuvm: no pgdir");
8010671d:	c7 04 24 1d 76 10 80 	movl   $0x8010761d,(%esp)
80106724:	e8 37 9c ff ff       	call   80100360 <panic>
    panic("switchuvm: no kstack");
80106729:	c7 04 24 08 76 10 80 	movl   $0x80107608,(%esp)
80106730:	e8 2b 9c ff ff       	call   80100360 <panic>
80106735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106740 <inituvm>:
{
80106740:	55                   	push   %ebp
80106741:	89 e5                	mov    %esp,%ebp
80106743:	57                   	push   %edi
80106744:	56                   	push   %esi
80106745:	53                   	push   %ebx
80106746:	83 ec 1c             	sub    $0x1c,%esp
80106749:	8b 75 10             	mov    0x10(%ebp),%esi
8010674c:	8b 45 08             	mov    0x8(%ebp),%eax
8010674f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106752:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106758:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010675b:	77 54                	ja     801067b1 <inituvm+0x71>
  mem = kalloc();
8010675d:	e8 3e bd ff ff       	call   801024a0 <kalloc>
  memset(mem, 0, PGSIZE);
80106762:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106769:	00 
8010676a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106771:	00 
  mem = kalloc();
80106772:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106774:	89 04 24             	mov    %eax,(%esp)
80106777:	e8 e4 db ff ff       	call   80104360 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
8010677c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106782:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106787:	89 04 24             	mov    %eax,(%esp)
8010678a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010678d:	31 d2                	xor    %edx,%edx
8010678f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106796:	00 
80106797:	e8 94 fc ff ff       	call   80106430 <mappages>
  memmove(mem, init, sz);
8010679c:	89 75 10             	mov    %esi,0x10(%ebp)
8010679f:	89 7d 0c             	mov    %edi,0xc(%ebp)
801067a2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801067a5:	83 c4 1c             	add    $0x1c,%esp
801067a8:	5b                   	pop    %ebx
801067a9:	5e                   	pop    %esi
801067aa:	5f                   	pop    %edi
801067ab:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801067ac:	e9 4f dc ff ff       	jmp    80104400 <memmove>
    panic("inituvm: more than a page");
801067b1:	c7 04 24 31 76 10 80 	movl   $0x80107631,(%esp)
801067b8:	e8 a3 9b ff ff       	call   80100360 <panic>
801067bd:	8d 76 00             	lea    0x0(%esi),%esi

801067c0 <loaduvm>:
{
801067c0:	55                   	push   %ebp
801067c1:	89 e5                	mov    %esp,%ebp
801067c3:	57                   	push   %edi
801067c4:	56                   	push   %esi
801067c5:	53                   	push   %ebx
801067c6:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
801067c9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801067d0:	0f 85 98 00 00 00    	jne    8010686e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
801067d6:	8b 75 18             	mov    0x18(%ebp),%esi
801067d9:	31 db                	xor    %ebx,%ebx
801067db:	85 f6                	test   %esi,%esi
801067dd:	75 1a                	jne    801067f9 <loaduvm+0x39>
801067df:	eb 77                	jmp    80106858 <loaduvm+0x98>
801067e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067e8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067ee:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801067f4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801067f7:	76 5f                	jbe    80106858 <loaduvm+0x98>
801067f9:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801067fc:	31 c9                	xor    %ecx,%ecx
801067fe:	8b 45 08             	mov    0x8(%ebp),%eax
80106801:	01 da                	add    %ebx,%edx
80106803:	e8 98 fb ff ff       	call   801063a0 <walkpgdir>
80106808:	85 c0                	test   %eax,%eax
8010680a:	74 56                	je     80106862 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
8010680c:	8b 00                	mov    (%eax),%eax
      n = PGSIZE;
8010680e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106813:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80106816:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      n = PGSIZE;
8010681b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106821:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106824:	05 00 00 00 80       	add    $0x80000000,%eax
80106829:	89 44 24 04          	mov    %eax,0x4(%esp)
8010682d:	8b 45 10             	mov    0x10(%ebp),%eax
80106830:	01 d9                	add    %ebx,%ecx
80106832:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106836:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010683a:	89 04 24             	mov    %eax,(%esp)
8010683d:	e8 1e b1 ff ff       	call   80101960 <readi>
80106842:	39 f8                	cmp    %edi,%eax
80106844:	74 a2                	je     801067e8 <loaduvm+0x28>
}
80106846:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106849:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010684e:	5b                   	pop    %ebx
8010684f:	5e                   	pop    %esi
80106850:	5f                   	pop    %edi
80106851:	5d                   	pop    %ebp
80106852:	c3                   	ret    
80106853:	90                   	nop
80106854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106858:	83 c4 1c             	add    $0x1c,%esp
  return 0;
8010685b:	31 c0                	xor    %eax,%eax
}
8010685d:	5b                   	pop    %ebx
8010685e:	5e                   	pop    %esi
8010685f:	5f                   	pop    %edi
80106860:	5d                   	pop    %ebp
80106861:	c3                   	ret    
      panic("loaduvm: address should exist");
80106862:	c7 04 24 4b 76 10 80 	movl   $0x8010764b,(%esp)
80106869:	e8 f2 9a ff ff       	call   80100360 <panic>
    panic("loaduvm: addr must be page aligned");
8010686e:	c7 04 24 ec 76 10 80 	movl   $0x801076ec,(%esp)
80106875:	e8 e6 9a ff ff       	call   80100360 <panic>
8010687a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106880 <allocuvm>:
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
80106886:	83 ec 1c             	sub    $0x1c,%esp
80106889:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
8010688c:	85 ff                	test   %edi,%edi
8010688e:	0f 88 7e 00 00 00    	js     80106912 <allocuvm+0x92>
  if(newsz < oldsz)
80106894:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106897:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
8010689a:	72 78                	jb     80106914 <allocuvm+0x94>
  a = PGROUNDUP(oldsz);
8010689c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801068a2:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801068a8:	39 df                	cmp    %ebx,%edi
801068aa:	77 4a                	ja     801068f6 <allocuvm+0x76>
801068ac:	eb 72                	jmp    80106920 <allocuvm+0xa0>
801068ae:	66 90                	xchg   %ax,%ax
    memset(mem, 0, PGSIZE);
801068b0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801068b7:	00 
801068b8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801068bf:	00 
801068c0:	89 04 24             	mov    %eax,(%esp)
801068c3:	e8 98 da ff ff       	call   80104360 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801068c8:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801068ce:	b9 00 10 00 00       	mov    $0x1000,%ecx
801068d3:	89 04 24             	mov    %eax,(%esp)
801068d6:	8b 45 08             	mov    0x8(%ebp),%eax
801068d9:	89 da                	mov    %ebx,%edx
801068db:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801068e2:	00 
801068e3:	e8 48 fb ff ff       	call   80106430 <mappages>
801068e8:	85 c0                	test   %eax,%eax
801068ea:	78 44                	js     80106930 <allocuvm+0xb0>
  for(; a < newsz; a += PGSIZE){
801068ec:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068f2:	39 df                	cmp    %ebx,%edi
801068f4:	76 2a                	jbe    80106920 <allocuvm+0xa0>
    mem = kalloc();
801068f6:	e8 a5 bb ff ff       	call   801024a0 <kalloc>
    if(mem == 0){
801068fb:	85 c0                	test   %eax,%eax
    mem = kalloc();
801068fd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801068ff:	75 af                	jne    801068b0 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106901:	c7 04 24 69 76 10 80 	movl   $0x80107669,(%esp)
80106908:	e8 43 9d ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010690d:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106910:	77 48                	ja     8010695a <allocuvm+0xda>
      return 0;
80106912:	31 c0                	xor    %eax,%eax
}
80106914:	83 c4 1c             	add    $0x1c,%esp
80106917:	5b                   	pop    %ebx
80106918:	5e                   	pop    %esi
80106919:	5f                   	pop    %edi
8010691a:	5d                   	pop    %ebp
8010691b:	c3                   	ret    
8010691c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106920:	83 c4 1c             	add    $0x1c,%esp
80106923:	89 f8                	mov    %edi,%eax
80106925:	5b                   	pop    %ebx
80106926:	5e                   	pop    %esi
80106927:	5f                   	pop    %edi
80106928:	5d                   	pop    %ebp
80106929:	c3                   	ret    
8010692a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106930:	c7 04 24 81 76 10 80 	movl   $0x80107681,(%esp)
80106937:	e8 14 9d ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010693c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010693f:	76 0d                	jbe    8010694e <allocuvm+0xce>
80106941:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106944:	89 fa                	mov    %edi,%edx
80106946:	8b 45 08             	mov    0x8(%ebp),%eax
80106949:	e8 62 fb ff ff       	call   801064b0 <deallocuvm.part.0>
      kfree(mem);
8010694e:	89 34 24             	mov    %esi,(%esp)
80106951:	e8 9a b9 ff ff       	call   801022f0 <kfree>
      return 0;
80106956:	31 c0                	xor    %eax,%eax
80106958:	eb ba                	jmp    80106914 <allocuvm+0x94>
8010695a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010695d:	89 fa                	mov    %edi,%edx
8010695f:	8b 45 08             	mov    0x8(%ebp),%eax
80106962:	e8 49 fb ff ff       	call   801064b0 <deallocuvm.part.0>
      return 0;
80106967:	31 c0                	xor    %eax,%eax
80106969:	eb a9                	jmp    80106914 <allocuvm+0x94>
8010696b:	90                   	nop
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106970 <deallocuvm>:
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	8b 55 0c             	mov    0xc(%ebp),%edx
80106976:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106979:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010697c:	39 d1                	cmp    %edx,%ecx
8010697e:	73 08                	jae    80106988 <deallocuvm+0x18>
}
80106980:	5d                   	pop    %ebp
80106981:	e9 2a fb ff ff       	jmp    801064b0 <deallocuvm.part.0>
80106986:	66 90                	xchg   %ax,%ax
80106988:	89 d0                	mov    %edx,%eax
8010698a:	5d                   	pop    %ebp
8010698b:	c3                   	ret    
8010698c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106990 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	56                   	push   %esi
80106994:	53                   	push   %ebx
80106995:	83 ec 10             	sub    $0x10,%esp
80106998:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010699b:	85 f6                	test   %esi,%esi
8010699d:	74 59                	je     801069f8 <freevm+0x68>
8010699f:	31 c9                	xor    %ecx,%ecx
801069a1:	ba 00 00 00 80       	mov    $0x80000000,%edx
801069a6:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801069a8:	31 db                	xor    %ebx,%ebx
801069aa:	e8 01 fb ff ff       	call   801064b0 <deallocuvm.part.0>
801069af:	eb 12                	jmp    801069c3 <freevm+0x33>
801069b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069b8:	83 c3 01             	add    $0x1,%ebx
801069bb:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801069c1:	74 27                	je     801069ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801069c3:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
801069c6:	f6 c2 01             	test   $0x1,%dl
801069c9:	74 ed                	je     801069b8 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801069cb:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(i = 0; i < NPDENTRIES; i++){
801069d1:	83 c3 01             	add    $0x1,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801069d4:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801069da:	89 14 24             	mov    %edx,(%esp)
801069dd:	e8 0e b9 ff ff       	call   801022f0 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
801069e2:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801069e8:	75 d9                	jne    801069c3 <freevm+0x33>
    }
  }
  kfree((char*)pgdir);
801069ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801069ed:	83 c4 10             	add    $0x10,%esp
801069f0:	5b                   	pop    %ebx
801069f1:	5e                   	pop    %esi
801069f2:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801069f3:	e9 f8 b8 ff ff       	jmp    801022f0 <kfree>
    panic("freevm: no pgdir");
801069f8:	c7 04 24 9d 76 10 80 	movl   $0x8010769d,(%esp)
801069ff:	e8 5c 99 ff ff       	call   80100360 <panic>
80106a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106a10 <setupkvm>:
{
80106a10:	55                   	push   %ebp
80106a11:	89 e5                	mov    %esp,%ebp
80106a13:	56                   	push   %esi
80106a14:	53                   	push   %ebx
80106a15:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
80106a18:	e8 83 ba ff ff       	call   801024a0 <kalloc>
80106a1d:	85 c0                	test   %eax,%eax
80106a1f:	89 c6                	mov    %eax,%esi
80106a21:	74 6d                	je     80106a90 <setupkvm+0x80>
  memset(pgdir, 0, PGSIZE);
80106a23:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a2a:	00 
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a2b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106a30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a37:	00 
80106a38:	89 04 24             	mov    %eax,(%esp)
80106a3b:	e8 20 d9 ff ff       	call   80104360 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106a40:	8b 53 0c             	mov    0xc(%ebx),%edx
80106a43:	8b 43 04             	mov    0x4(%ebx),%eax
80106a46:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106a49:	89 54 24 04          	mov    %edx,0x4(%esp)
80106a4d:	8b 13                	mov    (%ebx),%edx
80106a4f:	89 04 24             	mov    %eax,(%esp)
80106a52:	29 c1                	sub    %eax,%ecx
80106a54:	89 f0                	mov    %esi,%eax
80106a56:	e8 d5 f9 ff ff       	call   80106430 <mappages>
80106a5b:	85 c0                	test   %eax,%eax
80106a5d:	78 19                	js     80106a78 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106a5f:	83 c3 10             	add    $0x10,%ebx
80106a62:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106a68:	72 d6                	jb     80106a40 <setupkvm+0x30>
80106a6a:	89 f0                	mov    %esi,%eax
}
80106a6c:	83 c4 10             	add    $0x10,%esp
80106a6f:	5b                   	pop    %ebx
80106a70:	5e                   	pop    %esi
80106a71:	5d                   	pop    %ebp
80106a72:	c3                   	ret    
80106a73:	90                   	nop
80106a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106a78:	89 34 24             	mov    %esi,(%esp)
80106a7b:	e8 10 ff ff ff       	call   80106990 <freevm>
}
80106a80:	83 c4 10             	add    $0x10,%esp
      return 0;
80106a83:	31 c0                	xor    %eax,%eax
}
80106a85:	5b                   	pop    %ebx
80106a86:	5e                   	pop    %esi
80106a87:	5d                   	pop    %ebp
80106a88:	c3                   	ret    
80106a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106a90:	31 c0                	xor    %eax,%eax
80106a92:	eb d8                	jmp    80106a6c <setupkvm+0x5c>
80106a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106aa0 <kvmalloc>:
{
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106aa6:	e8 65 ff ff ff       	call   80106a10 <setupkvm>
80106aab:	a3 a4 54 11 80       	mov    %eax,0x801154a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ab0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ab5:	0f 22 d8             	mov    %eax,%cr3
}
80106ab8:	c9                   	leave  
80106ab9:	c3                   	ret    
80106aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ac0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106ac0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106ac1:	31 c9                	xor    %ecx,%ecx
{
80106ac3:	89 e5                	mov    %esp,%ebp
80106ac5:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106ac8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106acb:	8b 45 08             	mov    0x8(%ebp),%eax
80106ace:	e8 cd f8 ff ff       	call   801063a0 <walkpgdir>
  if(pte == 0)
80106ad3:	85 c0                	test   %eax,%eax
80106ad5:	74 05                	je     80106adc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106ad7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106ada:	c9                   	leave  
80106adb:	c3                   	ret    
    panic("clearpteu");
80106adc:	c7 04 24 ae 76 10 80 	movl   $0x801076ae,(%esp)
80106ae3:	e8 78 98 ff ff       	call   80100360 <panic>
80106ae8:	90                   	nop
80106ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106af0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106af0:	55                   	push   %ebp
80106af1:	89 e5                	mov    %esp,%ebp
80106af3:	57                   	push   %edi
80106af4:	56                   	push   %esi
80106af5:	53                   	push   %ebx
80106af6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106af9:	e8 12 ff ff ff       	call   80106a10 <setupkvm>
80106afe:	85 c0                	test   %eax,%eax
80106b00:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106b03:	0f 84 b9 00 00 00    	je     80106bc2 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106b09:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b0c:	85 c0                	test   %eax,%eax
80106b0e:	0f 84 94 00 00 00    	je     80106ba8 <copyuvm+0xb8>
80106b14:	31 ff                	xor    %edi,%edi
80106b16:	eb 48                	jmp    80106b60 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106b18:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106b1e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106b25:	00 
80106b26:	89 74 24 04          	mov    %esi,0x4(%esp)
80106b2a:	89 04 24             	mov    %eax,(%esp)
80106b2d:	e8 ce d8 ff ff       	call   80104400 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106b32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b35:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106b3a:	89 fa                	mov    %edi,%edx
80106b3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b40:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106b46:	89 04 24             	mov    %eax,(%esp)
80106b49:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b4c:	e8 df f8 ff ff       	call   80106430 <mappages>
80106b51:	85 c0                	test   %eax,%eax
80106b53:	78 63                	js     80106bb8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80106b55:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106b5b:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106b5e:	76 48                	jbe    80106ba8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106b60:	8b 45 08             	mov    0x8(%ebp),%eax
80106b63:	31 c9                	xor    %ecx,%ecx
80106b65:	89 fa                	mov    %edi,%edx
80106b67:	e8 34 f8 ff ff       	call   801063a0 <walkpgdir>
80106b6c:	85 c0                	test   %eax,%eax
80106b6e:	74 62                	je     80106bd2 <copyuvm+0xe2>
    if(!(*pte & PTE_P))
80106b70:	8b 00                	mov    (%eax),%eax
80106b72:	a8 01                	test   $0x1,%al
80106b74:	74 50                	je     80106bc6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80106b76:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80106b78:	25 ff 0f 00 00       	and    $0xfff,%eax
80106b7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80106b80:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if((mem = kalloc()) == 0)
80106b86:	e8 15 b9 ff ff       	call   801024a0 <kalloc>
80106b8b:	85 c0                	test   %eax,%eax
80106b8d:	89 c3                	mov    %eax,%ebx
80106b8f:	75 87                	jne    80106b18 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106b91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b94:	89 04 24             	mov    %eax,(%esp)
80106b97:	e8 f4 fd ff ff       	call   80106990 <freevm>
  return 0;
80106b9c:	31 c0                	xor    %eax,%eax
}
80106b9e:	83 c4 2c             	add    $0x2c,%esp
80106ba1:	5b                   	pop    %ebx
80106ba2:	5e                   	pop    %esi
80106ba3:	5f                   	pop    %edi
80106ba4:	5d                   	pop    %ebp
80106ba5:	c3                   	ret    
80106ba6:	66 90                	xchg   %ax,%ax
80106ba8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106bab:	83 c4 2c             	add    $0x2c,%esp
80106bae:	5b                   	pop    %ebx
80106baf:	5e                   	pop    %esi
80106bb0:	5f                   	pop    %edi
80106bb1:	5d                   	pop    %ebp
80106bb2:	c3                   	ret    
80106bb3:	90                   	nop
80106bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80106bb8:	89 1c 24             	mov    %ebx,(%esp)
80106bbb:	e8 30 b7 ff ff       	call   801022f0 <kfree>
      goto bad;
80106bc0:	eb cf                	jmp    80106b91 <copyuvm+0xa1>
    return 0;
80106bc2:	31 c0                	xor    %eax,%eax
80106bc4:	eb d8                	jmp    80106b9e <copyuvm+0xae>
      panic("copyuvm: page not present");
80106bc6:	c7 04 24 d2 76 10 80 	movl   $0x801076d2,(%esp)
80106bcd:	e8 8e 97 ff ff       	call   80100360 <panic>
      panic("copyuvm: pte should exist");
80106bd2:	c7 04 24 b8 76 10 80 	movl   $0x801076b8,(%esp)
80106bd9:	e8 82 97 ff ff       	call   80100360 <panic>
80106bde:	66 90                	xchg   %ax,%ax

80106be0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106be0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106be1:	31 c9                	xor    %ecx,%ecx
{
80106be3:	89 e5                	mov    %esp,%ebp
80106be5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80106be8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106beb:	8b 45 08             	mov    0x8(%ebp),%eax
80106bee:	e8 ad f7 ff ff       	call   801063a0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106bf3:	8b 00                	mov    (%eax),%eax
80106bf5:	89 c2                	mov    %eax,%edx
80106bf7:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
80106bfa:	83 fa 05             	cmp    $0x5,%edx
80106bfd:	75 11                	jne    80106c10 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106bff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c04:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106c09:	c9                   	leave  
80106c0a:	c3                   	ret    
80106c0b:	90                   	nop
80106c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80106c10:	31 c0                	xor    %eax,%eax
}
80106c12:	c9                   	leave  
80106c13:	c3                   	ret    
80106c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106c20 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	83 ec 1c             	sub    $0x1c,%esp
80106c29:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106c2c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106c2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106c32:	85 db                	test   %ebx,%ebx
80106c34:	75 3a                	jne    80106c70 <copyout+0x50>
80106c36:	eb 68                	jmp    80106ca0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106c38:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c3b:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106c3d:	89 7c 24 04          	mov    %edi,0x4(%esp)
    n = PGSIZE - (va - va0);
80106c41:	29 ca                	sub    %ecx,%edx
80106c43:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106c49:	39 da                	cmp    %ebx,%edx
80106c4b:	0f 47 d3             	cmova  %ebx,%edx
    memmove(pa0 + (va - va0), buf, n);
80106c4e:	29 f1                	sub    %esi,%ecx
80106c50:	01 c8                	add    %ecx,%eax
80106c52:	89 54 24 08          	mov    %edx,0x8(%esp)
80106c56:	89 04 24             	mov    %eax,(%esp)
80106c59:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106c5c:	e8 9f d7 ff ff       	call   80104400 <memmove>
    len -= n;
    buf += n;
80106c61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106c64:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    buf += n;
80106c6a:	01 d7                	add    %edx,%edi
  while(len > 0){
80106c6c:	29 d3                	sub    %edx,%ebx
80106c6e:	74 30                	je     80106ca0 <copyout+0x80>
    pa0 = uva2ka(pgdir, (char*)va0);
80106c70:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80106c73:	89 ce                	mov    %ecx,%esi
80106c75:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106c7b:	89 74 24 04          	mov    %esi,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
80106c7f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80106c82:	89 04 24             	mov    %eax,(%esp)
80106c85:	e8 56 ff ff ff       	call   80106be0 <uva2ka>
    if(pa0 == 0)
80106c8a:	85 c0                	test   %eax,%eax
80106c8c:	75 aa                	jne    80106c38 <copyout+0x18>
  }
  return 0;
}
80106c8e:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106c91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c96:	5b                   	pop    %ebx
80106c97:	5e                   	pop    %esi
80106c98:	5f                   	pop    %edi
80106c99:	5d                   	pop    %ebp
80106c9a:	c3                   	ret    
80106c9b:	90                   	nop
80106c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ca0:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106ca3:	31 c0                	xor    %eax,%eax
}
80106ca5:	5b                   	pop    %ebx
80106ca6:	5e                   	pop    %esi
80106ca7:	5f                   	pop    %edi
80106ca8:	5d                   	pop    %ebp
80106ca9:	c3                   	ret    
