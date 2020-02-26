
obj/__user_faultreadkernel.out:     file format elf32-i386


Disassembly of section .text:

00800020 <opendir>:
#include <error.h>
#include <unistd.h>

DIR dir, *dirp=&dir;
DIR *
opendir(const char *path) {
  800020:	55                   	push   %ebp
  800021:	89 e5                	mov    %esp,%ebp
  800023:	53                   	push   %ebx
  800024:	83 ec 34             	sub    $0x34,%esp

    if ((dirp->fd = open(path, O_RDONLY)) < 0) {
  800027:	8b 1d 00 20 80 00    	mov    0x802000,%ebx
  80002d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  800034:	00 
  800035:	8b 45 08             	mov    0x8(%ebp),%eax
  800038:	89 04 24             	mov    %eax,(%esp)
  80003b:	e8 b8 00 00 00       	call   8000f8 <open>
  800040:	89 03                	mov    %eax,(%ebx)
  800042:	8b 03                	mov    (%ebx),%eax
  800044:	85 c0                	test   %eax,%eax
  800046:	79 02                	jns    80004a <opendir+0x2a>
        goto failed;
  800048:	eb 44                	jmp    80008e <opendir+0x6e>
    }
    struct stat __stat, *stat = &__stat;
  80004a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  80004d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (fstat(dirp->fd, stat) != 0 || !S_ISDIR(stat->st_mode)) {
  800050:	a1 00 20 80 00       	mov    0x802000,%eax
  800055:	8b 00                	mov    (%eax),%eax
  800057:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80005a:	89 54 24 04          	mov    %edx,0x4(%esp)
  80005e:	89 04 24             	mov    %eax,(%esp)
  800061:	e8 22 01 00 00       	call   800188 <fstat>
  800066:	85 c0                	test   %eax,%eax
  800068:	75 24                	jne    80008e <opendir+0x6e>
  80006a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006d:	8b 00                	mov    (%eax),%eax
  80006f:	25 00 70 00 00       	and    $0x7000,%eax
  800074:	3d 00 20 00 00       	cmp    $0x2000,%eax
  800079:	75 13                	jne    80008e <opendir+0x6e>
        goto failed;
    }
    dirp->dirent.offset = 0;
  80007b:	a1 00 20 80 00       	mov    0x802000,%eax
  800080:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    return dirp;
  800087:	a1 00 20 80 00       	mov    0x802000,%eax
  80008c:	eb 05                	jmp    800093 <opendir+0x73>

failed:
    return NULL;
  80008e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800093:	83 c4 34             	add    $0x34,%esp
  800096:	5b                   	pop    %ebx
  800097:	5d                   	pop    %ebp
  800098:	c3                   	ret    

00800099 <readdir>:

struct dirent *
readdir(DIR *dirp) {
  800099:	55                   	push   %ebp
  80009a:	89 e5                	mov    %esp,%ebp
  80009c:	83 ec 18             	sub    $0x18,%esp
    if (sys_getdirentry(dirp->fd, &(dirp->dirent)) == 0) {
  80009f:	8b 45 08             	mov    0x8(%ebp),%eax
  8000a2:	8d 50 04             	lea    0x4(%eax),%edx
  8000a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8000a8:	8b 00                	mov    (%eax),%eax
  8000aa:	89 54 24 04          	mov    %edx,0x4(%esp)
  8000ae:	89 04 24             	mov    %eax,(%esp)
  8000b1:	e8 db 06 00 00       	call   800791 <sys_getdirentry>
  8000b6:	85 c0                	test   %eax,%eax
  8000b8:	75 08                	jne    8000c2 <readdir+0x29>
        return &(dirp->dirent);
  8000ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8000bd:	83 c0 04             	add    $0x4,%eax
  8000c0:	eb 05                	jmp    8000c7 <readdir+0x2e>
    }
    return NULL;
  8000c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8000c7:	c9                   	leave  
  8000c8:	c3                   	ret    

008000c9 <closedir>:

void
closedir(DIR *dirp) {
  8000c9:	55                   	push   %ebp
  8000ca:	89 e5                	mov    %esp,%ebp
  8000cc:	83 ec 18             	sub    $0x18,%esp
    close(dirp->fd);
  8000cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8000d2:	8b 00                	mov    (%eax),%eax
  8000d4:	89 04 24             	mov    %eax,(%esp)
  8000d7:	e8 36 00 00 00       	call   800112 <close>
}
  8000dc:	c9                   	leave  
  8000dd:	c3                   	ret    

008000de <getcwd>:

int
getcwd(char *buffer, size_t len) {
  8000de:	55                   	push   %ebp
  8000df:	89 e5                	mov    %esp,%ebp
  8000e1:	83 ec 18             	sub    $0x18,%esp
    return sys_getcwd(buffer, len);
  8000e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000e7:	89 44 24 04          	mov    %eax,0x4(%esp)
  8000eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8000ee:	89 04 24             	mov    %eax,(%esp)
  8000f1:	e8 79 06 00 00       	call   80076f <sys_getcwd>
}
  8000f6:	c9                   	leave  
  8000f7:	c3                   	ret    

008000f8 <open>:
#include <stat.h>
#include <error.h>
#include <unistd.h>

int
open(const char *path, uint32_t open_flags) {
  8000f8:	55                   	push   %ebp
  8000f9:	89 e5                	mov    %esp,%ebp
  8000fb:	83 ec 18             	sub    $0x18,%esp
    return sys_open(path, open_flags);
  8000fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800101:	89 44 24 04          	mov    %eax,0x4(%esp)
  800105:	8b 45 08             	mov    0x8(%ebp),%eax
  800108:	89 04 24             	mov    %eax,(%esp)
  80010b:	e8 6a 05 00 00       	call   80067a <sys_open>
}
  800110:	c9                   	leave  
  800111:	c3                   	ret    

00800112 <close>:

int
close(int fd) {
  800112:	55                   	push   %ebp
  800113:	89 e5                	mov    %esp,%ebp
  800115:	83 ec 18             	sub    $0x18,%esp
    return sys_close(fd);
  800118:	8b 45 08             	mov    0x8(%ebp),%eax
  80011b:	89 04 24             	mov    %eax,(%esp)
  80011e:	e8 79 05 00 00       	call   80069c <sys_close>
}
  800123:	c9                   	leave  
  800124:	c3                   	ret    

00800125 <read>:

int
read(int fd, void *base, size_t len) {
  800125:	55                   	push   %ebp
  800126:	89 e5                	mov    %esp,%ebp
  800128:	83 ec 18             	sub    $0x18,%esp
    return sys_read(fd, base, len);
  80012b:	8b 45 10             	mov    0x10(%ebp),%eax
  80012e:	89 44 24 08          	mov    %eax,0x8(%esp)
  800132:	8b 45 0c             	mov    0xc(%ebp),%eax
  800135:	89 44 24 04          	mov    %eax,0x4(%esp)
  800139:	8b 45 08             	mov    0x8(%ebp),%eax
  80013c:	89 04 24             	mov    %eax,(%esp)
  80013f:	e8 73 05 00 00       	call   8006b7 <sys_read>
}
  800144:	c9                   	leave  
  800145:	c3                   	ret    

00800146 <write>:

int
write(int fd, void *base, size_t len) {
  800146:	55                   	push   %ebp
  800147:	89 e5                	mov    %esp,%ebp
  800149:	83 ec 18             	sub    $0x18,%esp
    return sys_write(fd, base, len);
  80014c:	8b 45 10             	mov    0x10(%ebp),%eax
  80014f:	89 44 24 08          	mov    %eax,0x8(%esp)
  800153:	8b 45 0c             	mov    0xc(%ebp),%eax
  800156:	89 44 24 04          	mov    %eax,0x4(%esp)
  80015a:	8b 45 08             	mov    0x8(%ebp),%eax
  80015d:	89 04 24             	mov    %eax,(%esp)
  800160:	e8 7b 05 00 00       	call   8006e0 <sys_write>
}
  800165:	c9                   	leave  
  800166:	c3                   	ret    

00800167 <seek>:

int
seek(int fd, off_t pos, int whence) {
  800167:	55                   	push   %ebp
  800168:	89 e5                	mov    %esp,%ebp
  80016a:	83 ec 18             	sub    $0x18,%esp
    return sys_seek(fd, pos, whence);
  80016d:	8b 45 10             	mov    0x10(%ebp),%eax
  800170:	89 44 24 08          	mov    %eax,0x8(%esp)
  800174:	8b 45 0c             	mov    0xc(%ebp),%eax
  800177:	89 44 24 04          	mov    %eax,0x4(%esp)
  80017b:	8b 45 08             	mov    0x8(%ebp),%eax
  80017e:	89 04 24             	mov    %eax,(%esp)
  800181:	e8 83 05 00 00       	call   800709 <sys_seek>
}
  800186:	c9                   	leave  
  800187:	c3                   	ret    

00800188 <fstat>:

int
fstat(int fd, struct stat *stat) {
  800188:	55                   	push   %ebp
  800189:	89 e5                	mov    %esp,%ebp
  80018b:	83 ec 18             	sub    $0x18,%esp
    return sys_fstat(fd, stat);
  80018e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800191:	89 44 24 04          	mov    %eax,0x4(%esp)
  800195:	8b 45 08             	mov    0x8(%ebp),%eax
  800198:	89 04 24             	mov    %eax,(%esp)
  80019b:	e8 92 05 00 00       	call   800732 <sys_fstat>
}
  8001a0:	c9                   	leave  
  8001a1:	c3                   	ret    

008001a2 <fsync>:

int
fsync(int fd) {
  8001a2:	55                   	push   %ebp
  8001a3:	89 e5                	mov    %esp,%ebp
  8001a5:	83 ec 18             	sub    $0x18,%esp
    return sys_fsync(fd);
  8001a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8001ab:	89 04 24             	mov    %eax,(%esp)
  8001ae:	e8 a1 05 00 00       	call   800754 <sys_fsync>
}
  8001b3:	c9                   	leave  
  8001b4:	c3                   	ret    

008001b5 <dup2>:

int
dup2(int fd1, int fd2) {
  8001b5:	55                   	push   %ebp
  8001b6:	89 e5                	mov    %esp,%ebp
  8001b8:	83 ec 18             	sub    $0x18,%esp
    return sys_dup(fd1, fd2);
  8001bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001be:	89 44 24 04          	mov    %eax,0x4(%esp)
  8001c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8001c5:	89 04 24             	mov    %eax,(%esp)
  8001c8:	e8 e6 05 00 00       	call   8007b3 <sys_dup>
}
  8001cd:	c9                   	leave  
  8001ce:	c3                   	ret    

008001cf <transmode>:

static char
transmode(struct stat *stat) {
  8001cf:	55                   	push   %ebp
  8001d0:	89 e5                	mov    %esp,%ebp
  8001d2:	83 ec 10             	sub    $0x10,%esp
    uint32_t mode = stat->st_mode;
  8001d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8001d8:	8b 00                	mov    (%eax),%eax
  8001da:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (S_ISREG(mode)) return 'r';
  8001dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8001e0:	25 00 70 00 00       	and    $0x7000,%eax
  8001e5:	3d 00 10 00 00       	cmp    $0x1000,%eax
  8001ea:	75 07                	jne    8001f3 <transmode+0x24>
  8001ec:	b8 72 00 00 00       	mov    $0x72,%eax
  8001f1:	eb 5d                	jmp    800250 <transmode+0x81>
    if (S_ISDIR(mode)) return 'd';
  8001f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8001f6:	25 00 70 00 00       	and    $0x7000,%eax
  8001fb:	3d 00 20 00 00       	cmp    $0x2000,%eax
  800200:	75 07                	jne    800209 <transmode+0x3a>
  800202:	b8 64 00 00 00       	mov    $0x64,%eax
  800207:	eb 47                	jmp    800250 <transmode+0x81>
    if (S_ISLNK(mode)) return 'l';
  800209:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80020c:	25 00 70 00 00       	and    $0x7000,%eax
  800211:	3d 00 30 00 00       	cmp    $0x3000,%eax
  800216:	75 07                	jne    80021f <transmode+0x50>
  800218:	b8 6c 00 00 00       	mov    $0x6c,%eax
  80021d:	eb 31                	jmp    800250 <transmode+0x81>
    if (S_ISCHR(mode)) return 'c';
  80021f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800222:	25 00 70 00 00       	and    $0x7000,%eax
  800227:	3d 00 40 00 00       	cmp    $0x4000,%eax
  80022c:	75 07                	jne    800235 <transmode+0x66>
  80022e:	b8 63 00 00 00       	mov    $0x63,%eax
  800233:	eb 1b                	jmp    800250 <transmode+0x81>
    if (S_ISBLK(mode)) return 'b';
  800235:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800238:	25 00 70 00 00       	and    $0x7000,%eax
  80023d:	3d 00 50 00 00       	cmp    $0x5000,%eax
  800242:	75 07                	jne    80024b <transmode+0x7c>
  800244:	b8 62 00 00 00       	mov    $0x62,%eax
  800249:	eb 05                	jmp    800250 <transmode+0x81>
    return '-';
  80024b:	b8 2d 00 00 00       	mov    $0x2d,%eax
}
  800250:	c9                   	leave  
  800251:	c3                   	ret    

00800252 <print_stat>:

void
print_stat(const char *name, int fd, struct stat *stat) {
  800252:	55                   	push   %ebp
  800253:	89 e5                	mov    %esp,%ebp
  800255:	83 ec 18             	sub    $0x18,%esp
    cprintf("[%03d] %s\n", fd, name);
  800258:	8b 45 08             	mov    0x8(%ebp),%eax
  80025b:	89 44 24 08          	mov    %eax,0x8(%esp)
  80025f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800262:	89 44 24 04          	mov    %eax,0x4(%esp)
  800266:	c7 04 24 20 18 80 00 	movl   $0x801820,(%esp)
  80026d:	e8 6b 01 00 00       	call   8003dd <cprintf>
    cprintf("    mode    : %c\n", transmode(stat));
  800272:	8b 45 10             	mov    0x10(%ebp),%eax
  800275:	89 04 24             	mov    %eax,(%esp)
  800278:	e8 52 ff ff ff       	call   8001cf <transmode>
  80027d:	0f be c0             	movsbl %al,%eax
  800280:	89 44 24 04          	mov    %eax,0x4(%esp)
  800284:	c7 04 24 2b 18 80 00 	movl   $0x80182b,(%esp)
  80028b:	e8 4d 01 00 00       	call   8003dd <cprintf>
    cprintf("    links   : %lu\n", stat->st_nlinks);
  800290:	8b 45 10             	mov    0x10(%ebp),%eax
  800293:	8b 40 04             	mov    0x4(%eax),%eax
  800296:	89 44 24 04          	mov    %eax,0x4(%esp)
  80029a:	c7 04 24 3d 18 80 00 	movl   $0x80183d,(%esp)
  8002a1:	e8 37 01 00 00       	call   8003dd <cprintf>
    cprintf("    blocks  : %lu\n", stat->st_blocks);
  8002a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a9:	8b 40 08             	mov    0x8(%eax),%eax
  8002ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  8002b0:	c7 04 24 50 18 80 00 	movl   $0x801850,(%esp)
  8002b7:	e8 21 01 00 00       	call   8003dd <cprintf>
    cprintf("    size    : %lu\n", stat->st_size);
  8002bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8002bf:	8b 40 0c             	mov    0xc(%eax),%eax
  8002c2:	89 44 24 04          	mov    %eax,0x4(%esp)
  8002c6:	c7 04 24 63 18 80 00 	movl   $0x801863,(%esp)
  8002cd:	e8 0b 01 00 00       	call   8003dd <cprintf>
}
  8002d2:	c9                   	leave  
  8002d3:	c3                   	ret    

008002d4 <_start>:
.text
.globl _start
_start:
    # set ebp for backtrace
    movl $0x0, %ebp
  8002d4:	bd 00 00 00 00       	mov    $0x0,%ebp

    # load argc and argv
    movl (%esp), %ebx
  8002d9:	8b 1c 24             	mov    (%esp),%ebx
    lea 0x4(%esp), %ecx
  8002dc:	8d 4c 24 04          	lea    0x4(%esp),%ecx


    # move down the esp register
    # since it may cause page fault in backtrace
    subl $0x20, %esp
  8002e0:	83 ec 20             	sub    $0x20,%esp

    # save argc and argv on stack
    pushl %ecx
  8002e3:	51                   	push   %ecx
    pushl %ebx
  8002e4:	53                   	push   %ebx

    # call user-program function
    call umain
  8002e5:	e8 48 07 00 00       	call   800a32 <umain>
1:  jmp 1b
  8002ea:	eb fe                	jmp    8002ea <_start+0x16>

008002ec <__panic>:
#include <stdio.h>
#include <ulib.h>
#include <error.h>

void
__panic(const char *file, int line, const char *fmt, ...) {
  8002ec:	55                   	push   %ebp
  8002ed:	89 e5                	mov    %esp,%ebp
  8002ef:	83 ec 28             	sub    $0x28,%esp
    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  8002f2:	8d 45 14             	lea    0x14(%ebp),%eax
  8002f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("user panic at %s:%d:\n    ", file, line);
  8002f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fb:	89 44 24 08          	mov    %eax,0x8(%esp)
  8002ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800302:	89 44 24 04          	mov    %eax,0x4(%esp)
  800306:	c7 04 24 76 18 80 00 	movl   $0x801876,(%esp)
  80030d:	e8 cb 00 00 00       	call   8003dd <cprintf>
    vcprintf(fmt, ap);
  800312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800315:	89 44 24 04          	mov    %eax,0x4(%esp)
  800319:	8b 45 10             	mov    0x10(%ebp),%eax
  80031c:	89 04 24             	mov    %eax,(%esp)
  80031f:	e8 7e 00 00 00       	call   8003a2 <vcprintf>
    cprintf("\n");
  800324:	c7 04 24 90 18 80 00 	movl   $0x801890,(%esp)
  80032b:	e8 ad 00 00 00       	call   8003dd <cprintf>
    va_end(ap);
    exit(-E_PANIC);
  800330:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
  800337:	e8 86 05 00 00       	call   8008c2 <exit>

0080033c <__warn>:
}

void
__warn(const char *file, int line, const char *fmt, ...) {
  80033c:	55                   	push   %ebp
  80033d:	89 e5                	mov    %esp,%ebp
  80033f:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  800342:	8d 45 14             	lea    0x14(%ebp),%eax
  800345:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("user warning at %s:%d:\n    ", file, line);
  800348:	8b 45 0c             	mov    0xc(%ebp),%eax
  80034b:	89 44 24 08          	mov    %eax,0x8(%esp)
  80034f:	8b 45 08             	mov    0x8(%ebp),%eax
  800352:	89 44 24 04          	mov    %eax,0x4(%esp)
  800356:	c7 04 24 92 18 80 00 	movl   $0x801892,(%esp)
  80035d:	e8 7b 00 00 00       	call   8003dd <cprintf>
    vcprintf(fmt, ap);
  800362:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800365:	89 44 24 04          	mov    %eax,0x4(%esp)
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	89 04 24             	mov    %eax,(%esp)
  80036f:	e8 2e 00 00 00       	call   8003a2 <vcprintf>
    cprintf("\n");
  800374:	c7 04 24 90 18 80 00 	movl   $0x801890,(%esp)
  80037b:	e8 5d 00 00 00       	call   8003dd <cprintf>
    va_end(ap);
}
  800380:	c9                   	leave  
  800381:	c3                   	ret    

00800382 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800382:	55                   	push   %ebp
  800383:	89 e5                	mov    %esp,%ebp
  800385:	83 ec 18             	sub    $0x18,%esp
    sys_putc(c);
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	89 04 24             	mov    %eax,(%esp)
  80038e:	e8 45 02 00 00       	call   8005d8 <sys_putc>
    (*cnt) ++;
  800393:	8b 45 0c             	mov    0xc(%ebp),%eax
  800396:	8b 00                	mov    (%eax),%eax
  800398:	8d 50 01             	lea    0x1(%eax),%edx
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	89 10                	mov    %edx,(%eax)
}
  8003a0:	c9                   	leave  
  8003a1:	c3                   	ret    

008003a2 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  8003a2:	55                   	push   %ebp
  8003a3:	89 e5                	mov    %esp,%ebp
  8003a5:	83 ec 38             	sub    $0x38,%esp
    int cnt = 0;
  8003a8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, NO_FD, &cnt, fmt, ap);
  8003af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b2:	89 44 24 10          	mov    %eax,0x10(%esp)
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8003bd:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8003c0:	89 44 24 08          	mov    %eax,0x8(%esp)
  8003c4:	c7 44 24 04 d9 6a ff 	movl   $0xffff6ad9,0x4(%esp)
  8003cb:	ff 
  8003cc:	c7 04 24 82 03 80 00 	movl   $0x800382,(%esp)
  8003d3:	e8 1a 09 00 00       	call   800cf2 <vprintfmt>
    return cnt;
  8003d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8003db:	c9                   	leave  
  8003dc:	c3                   	ret    

008003dd <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  8003dd:	55                   	push   %ebp
  8003de:	89 e5                	mov    %esp,%ebp
  8003e0:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  8003e3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int cnt = vcprintf(fmt, ap);
  8003e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	89 04 24             	mov    %eax,(%esp)
  8003f6:	e8 a7 ff ff ff       	call   8003a2 <vcprintf>
  8003fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);

    return cnt;
  8003fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800401:	c9                   	leave  
  800402:	c3                   	ret    

00800403 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  800403:	55                   	push   %ebp
  800404:	89 e5                	mov    %esp,%ebp
  800406:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  800409:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  800410:	eb 13                	jmp    800425 <cputs+0x22>
        cputch(c, &cnt);
  800412:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800416:	8d 55 f0             	lea    -0x10(%ebp),%edx
  800419:	89 54 24 04          	mov    %edx,0x4(%esp)
  80041d:	89 04 24             	mov    %eax,(%esp)
  800420:	e8 5d ff ff ff       	call   800382 <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8d 50 01             	lea    0x1(%eax),%edx
  80042b:	89 55 08             	mov    %edx,0x8(%ebp)
  80042e:	0f b6 00             	movzbl (%eax),%eax
  800431:	88 45 f7             	mov    %al,-0x9(%ebp)
  800434:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  800438:	75 d8                	jne    800412 <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  80043a:	8d 45 f0             	lea    -0x10(%ebp),%eax
  80043d:	89 44 24 04          	mov    %eax,0x4(%esp)
  800441:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  800448:	e8 35 ff ff ff       	call   800382 <cputch>
    return cnt;
  80044d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800450:	c9                   	leave  
  800451:	c3                   	ret    

00800452 <fputch>:


static void
fputch(char c, int *cnt, int fd) {
  800452:	55                   	push   %ebp
  800453:	89 e5                	mov    %esp,%ebp
  800455:	83 ec 18             	sub    $0x18,%esp
  800458:	8b 45 08             	mov    0x8(%ebp),%eax
  80045b:	88 45 f4             	mov    %al,-0xc(%ebp)
    write(fd, &c, sizeof(char));
  80045e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  800465:	00 
  800466:	8d 45 f4             	lea    -0xc(%ebp),%eax
  800469:	89 44 24 04          	mov    %eax,0x4(%esp)
  80046d:	8b 45 10             	mov    0x10(%ebp),%eax
  800470:	89 04 24             	mov    %eax,(%esp)
  800473:	e8 ce fc ff ff       	call   800146 <write>
    (*cnt) ++;
  800478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047b:	8b 00                	mov    (%eax),%eax
  80047d:	8d 50 01             	lea    0x1(%eax),%edx
  800480:	8b 45 0c             	mov    0xc(%ebp),%eax
  800483:	89 10                	mov    %edx,(%eax)
}
  800485:	c9                   	leave  
  800486:	c3                   	ret    

00800487 <vfprintf>:

int
vfprintf(int fd, const char *fmt, va_list ap) {
  800487:	55                   	push   %ebp
  800488:	89 e5                	mov    %esp,%ebp
  80048a:	83 ec 38             	sub    $0x38,%esp
    int cnt = 0;
  80048d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)fputch, fd, &cnt, fmt, ap);
  800494:	8b 45 10             	mov    0x10(%ebp),%eax
  800497:	89 44 24 10          	mov    %eax,0x10(%esp)
  80049b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80049e:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8004a2:	8d 45 f4             	lea    -0xc(%ebp),%eax
  8004a5:	89 44 24 08          	mov    %eax,0x8(%esp)
  8004a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  8004b0:	c7 04 24 52 04 80 00 	movl   $0x800452,(%esp)
  8004b7:	e8 36 08 00 00       	call   800cf2 <vprintfmt>
    return cnt;
  8004bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8004bf:	c9                   	leave  
  8004c0:	c3                   	ret    

008004c1 <fprintf>:

int
fprintf(int fd, const char *fmt, ...) {
  8004c1:	55                   	push   %ebp
  8004c2:	89 e5                	mov    %esp,%ebp
  8004c4:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  8004c7:	8d 45 10             	lea    0x10(%ebp),%eax
  8004ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int cnt = vfprintf(fd, fmt, ap);
  8004cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004d0:	89 44 24 08          	mov    %eax,0x8(%esp)
  8004d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d7:	89 44 24 04          	mov    %eax,0x4(%esp)
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	89 04 24             	mov    %eax,(%esp)
  8004e1:	e8 a1 ff ff ff       	call   800487 <vfprintf>
  8004e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);

    return cnt;
  8004e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8004ec:	c9                   	leave  
  8004ed:	c3                   	ret    

008004ee <syscall>:


#define MAX_ARGS            5

static inline int
syscall(int num, ...) {
  8004ee:	55                   	push   %ebp
  8004ef:	89 e5                	mov    %esp,%ebp
  8004f1:	57                   	push   %edi
  8004f2:	56                   	push   %esi
  8004f3:	53                   	push   %ebx
  8004f4:	83 ec 20             	sub    $0x20,%esp
    va_list ap;
    va_start(ap, num);
  8004f7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  8004fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800504:	eb 16                	jmp    80051c <syscall+0x2e>
        a[i] = va_arg(ap, uint32_t);
  800506:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800509:	8d 50 04             	lea    0x4(%eax),%edx
  80050c:	89 55 e8             	mov    %edx,-0x18(%ebp)
  80050f:	8b 10                	mov    (%eax),%edx
  800511:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800514:	89 54 85 d4          	mov    %edx,-0x2c(%ebp,%eax,4)
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    uint32_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
  800518:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  80051c:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
  800520:	7e e4                	jle    800506 <syscall+0x18>
    asm volatile (
        "int %1;"
        : "=a" (ret)
        : "i" (T_SYSCALL),
          "a" (num),
          "d" (a[0]),
  800522:	8b 55 d4             	mov    -0x2c(%ebp),%edx
          "c" (a[1]),
  800525:	8b 4d d8             	mov    -0x28(%ebp),%ecx
          "b" (a[2]),
  800528:	8b 5d dc             	mov    -0x24(%ebp),%ebx
          "D" (a[3]),
  80052b:	8b 7d e0             	mov    -0x20(%ebp),%edi
          "S" (a[4])
  80052e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint32_t);
    }
    va_end(ap);

    asm volatile (
  800531:	8b 45 08             	mov    0x8(%ebp),%eax
  800534:	cd 80                	int    $0x80
  800536:	89 45 ec             	mov    %eax,-0x14(%ebp)
          "c" (a[1]),
          "b" (a[2]),
          "D" (a[3]),
          "S" (a[4])
        : "cc", "memory");
    return ret;
  800539:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
  80053c:	83 c4 20             	add    $0x20,%esp
  80053f:	5b                   	pop    %ebx
  800540:	5e                   	pop    %esi
  800541:	5f                   	pop    %edi
  800542:	5d                   	pop    %ebp
  800543:	c3                   	ret    

00800544 <sys_exit>:

int
sys_exit(int error_code) {
  800544:	55                   	push   %ebp
  800545:	89 e5                	mov    %esp,%ebp
  800547:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_exit, error_code);
  80054a:	8b 45 08             	mov    0x8(%ebp),%eax
  80054d:	89 44 24 04          	mov    %eax,0x4(%esp)
  800551:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  800558:	e8 91 ff ff ff       	call   8004ee <syscall>
}
  80055d:	c9                   	leave  
  80055e:	c3                   	ret    

0080055f <sys_fork>:

int
sys_fork(void) {
  80055f:	55                   	push   %ebp
  800560:	89 e5                	mov    %esp,%ebp
  800562:	83 ec 04             	sub    $0x4,%esp
    return syscall(SYS_fork);
  800565:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  80056c:	e8 7d ff ff ff       	call   8004ee <syscall>
}
  800571:	c9                   	leave  
  800572:	c3                   	ret    

00800573 <sys_wait>:

int
sys_wait(int pid, int *store) {
  800573:	55                   	push   %ebp
  800574:	89 e5                	mov    %esp,%ebp
  800576:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_wait, pid, store);
  800579:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057c:	89 44 24 08          	mov    %eax,0x8(%esp)
  800580:	8b 45 08             	mov    0x8(%ebp),%eax
  800583:	89 44 24 04          	mov    %eax,0x4(%esp)
  800587:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  80058e:	e8 5b ff ff ff       	call   8004ee <syscall>
}
  800593:	c9                   	leave  
  800594:	c3                   	ret    

00800595 <sys_yield>:

int
sys_yield(void) {
  800595:	55                   	push   %ebp
  800596:	89 e5                	mov    %esp,%ebp
  800598:	83 ec 04             	sub    $0x4,%esp
    return syscall(SYS_yield);
  80059b:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  8005a2:	e8 47 ff ff ff       	call   8004ee <syscall>
}
  8005a7:	c9                   	leave  
  8005a8:	c3                   	ret    

008005a9 <sys_kill>:

int
sys_kill(int pid) {
  8005a9:	55                   	push   %ebp
  8005aa:	89 e5                	mov    %esp,%ebp
  8005ac:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_kill, pid);
  8005af:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b2:	89 44 24 04          	mov    %eax,0x4(%esp)
  8005b6:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
  8005bd:	e8 2c ff ff ff       	call   8004ee <syscall>
}
  8005c2:	c9                   	leave  
  8005c3:	c3                   	ret    

008005c4 <sys_getpid>:

int
sys_getpid(void) {
  8005c4:	55                   	push   %ebp
  8005c5:	89 e5                	mov    %esp,%ebp
  8005c7:	83 ec 04             	sub    $0x4,%esp
    return syscall(SYS_getpid);
  8005ca:	c7 04 24 12 00 00 00 	movl   $0x12,(%esp)
  8005d1:	e8 18 ff ff ff       	call   8004ee <syscall>
}
  8005d6:	c9                   	leave  
  8005d7:	c3                   	ret    

008005d8 <sys_putc>:

int
sys_putc(int c) {
  8005d8:	55                   	push   %ebp
  8005d9:	89 e5                	mov    %esp,%ebp
  8005db:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_putc, c);
  8005de:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e1:	89 44 24 04          	mov    %eax,0x4(%esp)
  8005e5:	c7 04 24 1e 00 00 00 	movl   $0x1e,(%esp)
  8005ec:	e8 fd fe ff ff       	call   8004ee <syscall>
}
  8005f1:	c9                   	leave  
  8005f2:	c3                   	ret    

008005f3 <sys_pgdir>:

int
sys_pgdir(void) {
  8005f3:	55                   	push   %ebp
  8005f4:	89 e5                	mov    %esp,%ebp
  8005f6:	83 ec 04             	sub    $0x4,%esp
    return syscall(SYS_pgdir);
  8005f9:	c7 04 24 1f 00 00 00 	movl   $0x1f,(%esp)
  800600:	e8 e9 fe ff ff       	call   8004ee <syscall>
}
  800605:	c9                   	leave  
  800606:	c3                   	ret    

00800607 <sys_lab6_set_priority>:

void
sys_lab6_set_priority(uint32_t priority)
{
  800607:	55                   	push   %ebp
  800608:	89 e5                	mov    %esp,%ebp
  80060a:	83 ec 08             	sub    $0x8,%esp
    syscall(SYS_lab6_set_priority, priority);
  80060d:	8b 45 08             	mov    0x8(%ebp),%eax
  800610:	89 44 24 04          	mov    %eax,0x4(%esp)
  800614:	c7 04 24 ff 00 00 00 	movl   $0xff,(%esp)
  80061b:	e8 ce fe ff ff       	call   8004ee <syscall>
}
  800620:	c9                   	leave  
  800621:	c3                   	ret    

00800622 <sys_sleep>:

int
sys_sleep(unsigned int time) {
  800622:	55                   	push   %ebp
  800623:	89 e5                	mov    %esp,%ebp
  800625:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_sleep, time);
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	89 44 24 04          	mov    %eax,0x4(%esp)
  80062f:	c7 04 24 0b 00 00 00 	movl   $0xb,(%esp)
  800636:	e8 b3 fe ff ff       	call   8004ee <syscall>
}
  80063b:	c9                   	leave  
  80063c:	c3                   	ret    

0080063d <sys_gettime>:

int
sys_gettime(void) {
  80063d:	55                   	push   %ebp
  80063e:	89 e5                	mov    %esp,%ebp
  800640:	83 ec 04             	sub    $0x4,%esp
    return syscall(SYS_gettime);
  800643:	c7 04 24 11 00 00 00 	movl   $0x11,(%esp)
  80064a:	e8 9f fe ff ff       	call   8004ee <syscall>
}
  80064f:	c9                   	leave  
  800650:	c3                   	ret    

00800651 <sys_exec>:

int
sys_exec(const char *name, int argc, const char **argv) {
  800651:	55                   	push   %ebp
  800652:	89 e5                	mov    %esp,%ebp
  800654:	83 ec 10             	sub    $0x10,%esp
    return syscall(SYS_exec, name, argc, argv);
  800657:	8b 45 10             	mov    0x10(%ebp),%eax
  80065a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80065e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800661:	89 44 24 08          	mov    %eax,0x8(%esp)
  800665:	8b 45 08             	mov    0x8(%ebp),%eax
  800668:	89 44 24 04          	mov    %eax,0x4(%esp)
  80066c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  800673:	e8 76 fe ff ff       	call   8004ee <syscall>
}
  800678:	c9                   	leave  
  800679:	c3                   	ret    

0080067a <sys_open>:

int
sys_open(const char *path, uint32_t open_flags) {
  80067a:	55                   	push   %ebp
  80067b:	89 e5                	mov    %esp,%ebp
  80067d:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_open, path, open_flags);
  800680:	8b 45 0c             	mov    0xc(%ebp),%eax
  800683:	89 44 24 08          	mov    %eax,0x8(%esp)
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	89 44 24 04          	mov    %eax,0x4(%esp)
  80068e:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
  800695:	e8 54 fe ff ff       	call   8004ee <syscall>
}
  80069a:	c9                   	leave  
  80069b:	c3                   	ret    

0080069c <sys_close>:

int
sys_close(int fd) {
  80069c:	55                   	push   %ebp
  80069d:	89 e5                	mov    %esp,%ebp
  80069f:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_close, fd);
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	89 44 24 04          	mov    %eax,0x4(%esp)
  8006a9:	c7 04 24 65 00 00 00 	movl   $0x65,(%esp)
  8006b0:	e8 39 fe ff ff       	call   8004ee <syscall>
}
  8006b5:	c9                   	leave  
  8006b6:	c3                   	ret    

008006b7 <sys_read>:

int
sys_read(int fd, void *base, size_t len) {
  8006b7:	55                   	push   %ebp
  8006b8:	89 e5                	mov    %esp,%ebp
  8006ba:	83 ec 10             	sub    $0x10,%esp
    return syscall(SYS_read, fd, base, len);
  8006bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8006c0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8006c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006c7:	89 44 24 08          	mov    %eax,0x8(%esp)
  8006cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ce:	89 44 24 04          	mov    %eax,0x4(%esp)
  8006d2:	c7 04 24 66 00 00 00 	movl   $0x66,(%esp)
  8006d9:	e8 10 fe ff ff       	call   8004ee <syscall>
}
  8006de:	c9                   	leave  
  8006df:	c3                   	ret    

008006e0 <sys_write>:

int
sys_write(int fd, void *base, size_t len) {
  8006e0:	55                   	push   %ebp
  8006e1:	89 e5                	mov    %esp,%ebp
  8006e3:	83 ec 10             	sub    $0x10,%esp
    return syscall(SYS_write, fd, base, len);
  8006e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8006e9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8006ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006f0:	89 44 24 08          	mov    %eax,0x8(%esp)
  8006f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  8006fb:	c7 04 24 67 00 00 00 	movl   $0x67,(%esp)
  800702:	e8 e7 fd ff ff       	call   8004ee <syscall>
}
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <sys_seek>:

int
sys_seek(int fd, off_t pos, int whence) {
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 10             	sub    $0x10,%esp
    return syscall(SYS_seek, fd, pos, whence);
  80070f:	8b 45 10             	mov    0x10(%ebp),%eax
  800712:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800716:	8b 45 0c             	mov    0xc(%ebp),%eax
  800719:	89 44 24 08          	mov    %eax,0x8(%esp)
  80071d:	8b 45 08             	mov    0x8(%ebp),%eax
  800720:	89 44 24 04          	mov    %eax,0x4(%esp)
  800724:	c7 04 24 68 00 00 00 	movl   $0x68,(%esp)
  80072b:	e8 be fd ff ff       	call   8004ee <syscall>
}
  800730:	c9                   	leave  
  800731:	c3                   	ret    

00800732 <sys_fstat>:

int
sys_fstat(int fd, struct stat *stat) {
  800732:	55                   	push   %ebp
  800733:	89 e5                	mov    %esp,%ebp
  800735:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_fstat, fd, stat);
  800738:	8b 45 0c             	mov    0xc(%ebp),%eax
  80073b:	89 44 24 08          	mov    %eax,0x8(%esp)
  80073f:	8b 45 08             	mov    0x8(%ebp),%eax
  800742:	89 44 24 04          	mov    %eax,0x4(%esp)
  800746:	c7 04 24 6e 00 00 00 	movl   $0x6e,(%esp)
  80074d:	e8 9c fd ff ff       	call   8004ee <syscall>
}
  800752:	c9                   	leave  
  800753:	c3                   	ret    

00800754 <sys_fsync>:

int
sys_fsync(int fd) {
  800754:	55                   	push   %ebp
  800755:	89 e5                	mov    %esp,%ebp
  800757:	83 ec 08             	sub    $0x8,%esp
    return syscall(SYS_fsync, fd);
  80075a:	8b 45 08             	mov    0x8(%ebp),%eax
  80075d:	89 44 24 04          	mov    %eax,0x4(%esp)
  800761:	c7 04 24 6f 00 00 00 	movl   $0x6f,(%esp)
  800768:	e8 81 fd ff ff       	call   8004ee <syscall>
}
  80076d:	c9                   	leave  
  80076e:	c3                   	ret    

0080076f <sys_getcwd>:

int
sys_getcwd(char *buffer, size_t len) {
  80076f:	55                   	push   %ebp
  800770:	89 e5                	mov    %esp,%ebp
  800772:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_getcwd, buffer, len);
  800775:	8b 45 0c             	mov    0xc(%ebp),%eax
  800778:	89 44 24 08          	mov    %eax,0x8(%esp)
  80077c:	8b 45 08             	mov    0x8(%ebp),%eax
  80077f:	89 44 24 04          	mov    %eax,0x4(%esp)
  800783:	c7 04 24 79 00 00 00 	movl   $0x79,(%esp)
  80078a:	e8 5f fd ff ff       	call   8004ee <syscall>
}
  80078f:	c9                   	leave  
  800790:	c3                   	ret    

00800791 <sys_getdirentry>:

int
sys_getdirentry(int fd, struct dirent *dirent) {
  800791:	55                   	push   %ebp
  800792:	89 e5                	mov    %esp,%ebp
  800794:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_getdirentry, fd, dirent);
  800797:	8b 45 0c             	mov    0xc(%ebp),%eax
  80079a:	89 44 24 08          	mov    %eax,0x8(%esp)
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	89 44 24 04          	mov    %eax,0x4(%esp)
  8007a5:	c7 04 24 80 00 00 00 	movl   $0x80,(%esp)
  8007ac:	e8 3d fd ff ff       	call   8004ee <syscall>
}
  8007b1:	c9                   	leave  
  8007b2:	c3                   	ret    

008007b3 <sys_dup>:

int
sys_dup(int fd1, int fd2) {
  8007b3:	55                   	push   %ebp
  8007b4:	89 e5                	mov    %esp,%ebp
  8007b6:	83 ec 0c             	sub    $0xc,%esp
    return syscall(SYS_dup, fd1, fd2);
  8007b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007bc:	89 44 24 08          	mov    %eax,0x8(%esp)
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	89 44 24 04          	mov    %eax,0x4(%esp)
  8007c7:	c7 04 24 82 00 00 00 	movl   $0x82,(%esp)
  8007ce:	e8 1b fd ff ff       	call   8004ee <syscall>
}
  8007d3:	c9                   	leave  
  8007d4:	c3                   	ret    

008007d5 <test_and_set_bit>:
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool
test_and_set_bit(int nr, volatile void *addr) {
  8007d5:	55                   	push   %ebp
  8007d6:	89 e5                	mov    %esp,%ebp
  8007d8:	83 ec 10             	sub    $0x10,%esp
    int oldbit;
    asm volatile ("btsl %2, %1; sbbl %0, %0" : "=r" (oldbit), "=m" (*(volatile long *)addr) : "Ir" (nr) : "memory");
  8007db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007de:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e1:	0f ab 02             	bts    %eax,(%edx)
  8007e4:	19 c0                	sbb    %eax,%eax
  8007e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return oldbit != 0;
  8007e9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8007ed:	0f 95 c0             	setne  %al
  8007f0:	0f b6 c0             	movzbl %al,%eax
}
  8007f3:	c9                   	leave  
  8007f4:	c3                   	ret    

008007f5 <test_and_clear_bit>:
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool
test_and_clear_bit(int nr, volatile void *addr) {
  8007f5:	55                   	push   %ebp
  8007f6:	89 e5                	mov    %esp,%ebp
  8007f8:	83 ec 10             	sub    $0x10,%esp
    int oldbit;
    asm volatile ("btrl %2, %1; sbbl %0, %0" : "=r" (oldbit), "=m" (*(volatile long *)addr) : "Ir" (nr) : "memory");
  8007fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8007fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800801:	0f b3 02             	btr    %eax,(%edx)
  800804:	19 c0                	sbb    %eax,%eax
  800806:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return oldbit != 0;
  800809:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80080d:	0f 95 c0             	setne  %al
  800810:	0f b6 c0             	movzbl %al,%eax
}
  800813:	c9                   	leave  
  800814:	c3                   	ret    

00800815 <try_lock>:
lock_init(lock_t *l) {
    *l = 0;
}

static inline bool
try_lock(lock_t *l) {
  800815:	55                   	push   %ebp
  800816:	89 e5                	mov    %esp,%ebp
  800818:	83 ec 08             	sub    $0x8,%esp
    return test_and_set_bit(0, l);
  80081b:	8b 45 08             	mov    0x8(%ebp),%eax
  80081e:	89 44 24 04          	mov    %eax,0x4(%esp)
  800822:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800829:	e8 a7 ff ff ff       	call   8007d5 <test_and_set_bit>
}
  80082e:	c9                   	leave  
  80082f:	c3                   	ret    

00800830 <lock>:

static inline void
lock(lock_t *l) {
  800830:	55                   	push   %ebp
  800831:	89 e5                	mov    %esp,%ebp
  800833:	83 ec 28             	sub    $0x28,%esp
    if (try_lock(l)) {
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	89 04 24             	mov    %eax,(%esp)
  80083c:	e8 d4 ff ff ff       	call   800815 <try_lock>
  800841:	85 c0                	test   %eax,%eax
  800843:	74 38                	je     80087d <lock+0x4d>
        int step = 0;
  800845:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
        do {
            yield();
  80084c:	e8 d3 00 00 00       	call   800924 <yield>
            if (++ step == 100) {
  800851:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  800855:	83 7d f4 64          	cmpl   $0x64,-0xc(%ebp)
  800859:	75 13                	jne    80086e <lock+0x3e>
                step = 0;
  80085b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
                sleep(10);
  800862:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  800869:	e8 03 01 00 00       	call   800971 <sleep>
            }
        } while (try_lock(l));
  80086e:	8b 45 08             	mov    0x8(%ebp),%eax
  800871:	89 04 24             	mov    %eax,(%esp)
  800874:	e8 9c ff ff ff       	call   800815 <try_lock>
  800879:	85 c0                	test   %eax,%eax
  80087b:	75 cf                	jne    80084c <lock+0x1c>
    }
}
  80087d:	c9                   	leave  
  80087e:	c3                   	ret    

0080087f <unlock>:

static inline void
unlock(lock_t *l) {
  80087f:	55                   	push   %ebp
  800880:	89 e5                	mov    %esp,%ebp
  800882:	83 ec 08             	sub    $0x8,%esp
    test_and_clear_bit(0, l);
  800885:	8b 45 08             	mov    0x8(%ebp),%eax
  800888:	89 44 24 04          	mov    %eax,0x4(%esp)
  80088c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800893:	e8 5d ff ff ff       	call   8007f5 <test_and_clear_bit>
}
  800898:	c9                   	leave  
  800899:	c3                   	ret    

0080089a <lock_fork>:
#include <lock.h>

static lock_t fork_lock = INIT_LOCK;

void
lock_fork(void) {
  80089a:	55                   	push   %ebp
  80089b:	89 e5                	mov    %esp,%ebp
  80089d:	83 ec 18             	sub    $0x18,%esp
    lock(&fork_lock);
  8008a0:	c7 04 24 20 20 80 00 	movl   $0x802020,(%esp)
  8008a7:	e8 84 ff ff ff       	call   800830 <lock>
}
  8008ac:	c9                   	leave  
  8008ad:	c3                   	ret    

008008ae <unlock_fork>:

void
unlock_fork(void) {
  8008ae:	55                   	push   %ebp
  8008af:	89 e5                	mov    %esp,%ebp
  8008b1:	83 ec 04             	sub    $0x4,%esp
    unlock(&fork_lock);
  8008b4:	c7 04 24 20 20 80 00 	movl   $0x802020,(%esp)
  8008bb:	e8 bf ff ff ff       	call   80087f <unlock>
}
  8008c0:	c9                   	leave  
  8008c1:	c3                   	ret    

008008c2 <exit>:

void
exit(int error_code) {
  8008c2:	55                   	push   %ebp
  8008c3:	89 e5                	mov    %esp,%ebp
  8008c5:	83 ec 18             	sub    $0x18,%esp
    sys_exit(error_code);
  8008c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cb:	89 04 24             	mov    %eax,(%esp)
  8008ce:	e8 71 fc ff ff       	call   800544 <sys_exit>
    cprintf("BUG: exit failed.\n");
  8008d3:	c7 04 24 ae 18 80 00 	movl   $0x8018ae,(%esp)
  8008da:	e8 fe fa ff ff       	call   8003dd <cprintf>
    while (1);
  8008df:	eb fe                	jmp    8008df <exit+0x1d>

008008e1 <fork>:
}

int
fork(void) {
  8008e1:	55                   	push   %ebp
  8008e2:	89 e5                	mov    %esp,%ebp
  8008e4:	83 ec 08             	sub    $0x8,%esp
    return sys_fork();
  8008e7:	e8 73 fc ff ff       	call   80055f <sys_fork>
}
  8008ec:	c9                   	leave  
  8008ed:	c3                   	ret    

008008ee <wait>:

int
wait(void) {
  8008ee:	55                   	push   %ebp
  8008ef:	89 e5                	mov    %esp,%ebp
  8008f1:	83 ec 18             	sub    $0x18,%esp
    return sys_wait(0, NULL);
  8008f4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  8008fb:	00 
  8008fc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800903:	e8 6b fc ff ff       	call   800573 <sys_wait>
}
  800908:	c9                   	leave  
  800909:	c3                   	ret    

0080090a <waitpid>:

int
waitpid(int pid, int *store) {
  80090a:	55                   	push   %ebp
  80090b:	89 e5                	mov    %esp,%ebp
  80090d:	83 ec 18             	sub    $0x18,%esp
    return sys_wait(pid, store);
  800910:	8b 45 0c             	mov    0xc(%ebp),%eax
  800913:	89 44 24 04          	mov    %eax,0x4(%esp)
  800917:	8b 45 08             	mov    0x8(%ebp),%eax
  80091a:	89 04 24             	mov    %eax,(%esp)
  80091d:	e8 51 fc ff ff       	call   800573 <sys_wait>
}
  800922:	c9                   	leave  
  800923:	c3                   	ret    

00800924 <yield>:

void
yield(void) {
  800924:	55                   	push   %ebp
  800925:	89 e5                	mov    %esp,%ebp
  800927:	83 ec 08             	sub    $0x8,%esp
    sys_yield();
  80092a:	e8 66 fc ff ff       	call   800595 <sys_yield>
}
  80092f:	c9                   	leave  
  800930:	c3                   	ret    

00800931 <kill>:

int
kill(int pid) {
  800931:	55                   	push   %ebp
  800932:	89 e5                	mov    %esp,%ebp
  800934:	83 ec 18             	sub    $0x18,%esp
    return sys_kill(pid);
  800937:	8b 45 08             	mov    0x8(%ebp),%eax
  80093a:	89 04 24             	mov    %eax,(%esp)
  80093d:	e8 67 fc ff ff       	call   8005a9 <sys_kill>
}
  800942:	c9                   	leave  
  800943:	c3                   	ret    

00800944 <getpid>:

int
getpid(void) {
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
  800947:	83 ec 08             	sub    $0x8,%esp
    return sys_getpid();
  80094a:	e8 75 fc ff ff       	call   8005c4 <sys_getpid>
}
  80094f:	c9                   	leave  
  800950:	c3                   	ret    

00800951 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  800951:	55                   	push   %ebp
  800952:	89 e5                	mov    %esp,%ebp
  800954:	83 ec 08             	sub    $0x8,%esp
    sys_pgdir();
  800957:	e8 97 fc ff ff       	call   8005f3 <sys_pgdir>
}
  80095c:	c9                   	leave  
  80095d:	c3                   	ret    

0080095e <lab6_set_priority>:

void
lab6_set_priority(uint32_t priority)
{
  80095e:	55                   	push   %ebp
  80095f:	89 e5                	mov    %esp,%ebp
  800961:	83 ec 18             	sub    $0x18,%esp
    sys_lab6_set_priority(priority);
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	89 04 24             	mov    %eax,(%esp)
  80096a:	e8 98 fc ff ff       	call   800607 <sys_lab6_set_priority>
}
  80096f:	c9                   	leave  
  800970:	c3                   	ret    

00800971 <sleep>:

int
sleep(unsigned int time) {
  800971:	55                   	push   %ebp
  800972:	89 e5                	mov    %esp,%ebp
  800974:	83 ec 18             	sub    $0x18,%esp
    return sys_sleep(time);
  800977:	8b 45 08             	mov    0x8(%ebp),%eax
  80097a:	89 04 24             	mov    %eax,(%esp)
  80097d:	e8 a0 fc ff ff       	call   800622 <sys_sleep>
}
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <gettime_msec>:

unsigned int
gettime_msec(void) {
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 08             	sub    $0x8,%esp
    return (unsigned int)sys_gettime();
  80098a:	e8 ae fc ff ff       	call   80063d <sys_gettime>
}
  80098f:	c9                   	leave  
  800990:	c3                   	ret    

00800991 <__exec>:

int
__exec(const char *name, const char **argv) {
  800991:	55                   	push   %ebp
  800992:	89 e5                	mov    %esp,%ebp
  800994:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  800997:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (argv[argc] != NULL) {
  80099e:	eb 04                	jmp    8009a4 <__exec+0x13>
        argc ++;
  8009a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
}

int
__exec(const char *name, const char **argv) {
    int argc = 0;
    while (argv[argc] != NULL) {
  8009a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b1:	01 d0                	add    %edx,%eax
  8009b3:	8b 00                	mov    (%eax),%eax
  8009b5:	85 c0                	test   %eax,%eax
  8009b7:	75 e7                	jne    8009a0 <__exec+0xf>
        argc ++;
    }
    return sys_exec(name, argc, argv);
  8009b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009bc:	89 44 24 08          	mov    %eax,0x8(%esp)
  8009c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c3:	89 44 24 04          	mov    %eax,0x4(%esp)
  8009c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ca:	89 04 24             	mov    %eax,(%esp)
  8009cd:	e8 7f fc ff ff       	call   800651 <sys_exec>
}
  8009d2:	c9                   	leave  
  8009d3:	c3                   	ret    

008009d4 <initfd>:
#include <stat.h>

int main(int argc, char *argv[]);

static int
initfd(int fd2, const char *path, uint32_t open_flags) {
  8009d4:	55                   	push   %ebp
  8009d5:	89 e5                	mov    %esp,%ebp
  8009d7:	83 ec 28             	sub    $0x28,%esp
    int fd1, ret;
    if ((fd1 = open(path, open_flags)) < 0) {
  8009da:	8b 45 10             	mov    0x10(%ebp),%eax
  8009dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  8009e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e4:	89 04 24             	mov    %eax,(%esp)
  8009e7:	e8 0c f7 ff ff       	call   8000f8 <open>
  8009ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009ef:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009f3:	79 05                	jns    8009fa <initfd+0x26>
        return fd1;
  8009f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f8:	eb 36                	jmp    800a30 <initfd+0x5c>
    }
    if (fd1 != fd2) {
  8009fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009fd:	3b 45 08             	cmp    0x8(%ebp),%eax
  800a00:	74 2b                	je     800a2d <initfd+0x59>
        close(fd2);
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	89 04 24             	mov    %eax,(%esp)
  800a08:	e8 05 f7 ff ff       	call   800112 <close>
        ret = dup2(fd1, fd2);
  800a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a10:	89 44 24 04          	mov    %eax,0x4(%esp)
  800a14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a17:	89 04 24             	mov    %eax,(%esp)
  800a1a:	e8 96 f7 ff ff       	call   8001b5 <dup2>
  800a1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        close(fd1);
  800a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a25:	89 04 24             	mov    %eax,(%esp)
  800a28:	e8 e5 f6 ff ff       	call   800112 <close>
    }
    return ret;
  800a2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a30:	c9                   	leave  
  800a31:	c3                   	ret    

00800a32 <umain>:

void
umain(int argc, char *argv[]) {
  800a32:	55                   	push   %ebp
  800a33:	89 e5                	mov    %esp,%ebp
  800a35:	83 ec 28             	sub    $0x28,%esp
    int fd;
    if ((fd = initfd(0, "stdin:", O_RDONLY)) < 0) {
  800a38:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  800a3f:	00 
  800a40:	c7 44 24 04 c1 18 80 	movl   $0x8018c1,0x4(%esp)
  800a47:	00 
  800a48:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  800a4f:	e8 80 ff ff ff       	call   8009d4 <initfd>
  800a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800a5b:	79 23                	jns    800a80 <umain+0x4e>
        warn("open <stdin> failed: %e.\n", fd);
  800a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a60:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800a64:	c7 44 24 08 c8 18 80 	movl   $0x8018c8,0x8(%esp)
  800a6b:	00 
  800a6c:	c7 44 24 04 1a 00 00 	movl   $0x1a,0x4(%esp)
  800a73:	00 
  800a74:	c7 04 24 e2 18 80 00 	movl   $0x8018e2,(%esp)
  800a7b:	e8 bc f8 ff ff       	call   80033c <__warn>
    }
    if ((fd = initfd(1, "stdout:", O_WRONLY)) < 0) {
  800a80:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  800a87:	00 
  800a88:	c7 44 24 04 f4 18 80 	movl   $0x8018f4,0x4(%esp)
  800a8f:	00 
  800a90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  800a97:	e8 38 ff ff ff       	call   8009d4 <initfd>
  800a9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800a9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800aa3:	79 23                	jns    800ac8 <umain+0x96>
        warn("open <stdout> failed: %e.\n", fd);
  800aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aa8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800aac:	c7 44 24 08 fc 18 80 	movl   $0x8018fc,0x8(%esp)
  800ab3:	00 
  800ab4:	c7 44 24 04 1d 00 00 	movl   $0x1d,0x4(%esp)
  800abb:	00 
  800abc:	c7 04 24 e2 18 80 00 	movl   $0x8018e2,(%esp)
  800ac3:	e8 74 f8 ff ff       	call   80033c <__warn>
    }
    int ret = main(argc, argv);
  800ac8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acb:	89 44 24 04          	mov    %eax,0x4(%esp)
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	89 04 24             	mov    %eax,(%esp)
  800ad5:	e8 f1 0c 00 00       	call   8017cb <main>
  800ada:	89 45 f0             	mov    %eax,-0x10(%ebp)
    exit(ret);
  800add:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae0:	89 04 24             	mov    %eax,(%esp)
  800ae3:	e8 da fd ff ff       	call   8008c2 <exit>

00800ae8 <hash32>:
 * @bits:   the number of bits in a return value
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
  800ae8:	55                   	push   %ebp
  800ae9:	89 e5                	mov    %esp,%ebp
  800aeb:	83 ec 10             	sub    $0x10,%esp
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
  800aee:	8b 45 08             	mov    0x8(%ebp),%eax
  800af1:	69 c0 01 00 37 9e    	imul   $0x9e370001,%eax,%eax
  800af7:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return (hash >> (32 - bits));
  800afa:	b8 20 00 00 00       	mov    $0x20,%eax
  800aff:	2b 45 0c             	sub    0xc(%ebp),%eax
  800b02:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b05:	89 c1                	mov    %eax,%ecx
  800b07:	d3 ea                	shr    %cl,%edx
  800b09:	89 d0                	mov    %edx,%eax
}
  800b0b:	c9                   	leave  
  800b0c:	c3                   	ret    

00800b0d <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*, int), int fd, void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  800b0d:	55                   	push   %ebp
  800b0e:	89 e5                	mov    %esp,%ebp
  800b10:	83 ec 58             	sub    $0x58,%esp
  800b13:	8b 45 14             	mov    0x14(%ebp),%eax
  800b16:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800b19:	8b 45 18             	mov    0x18(%ebp),%eax
  800b1c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  800b1f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800b22:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800b25:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800b28:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  800b2b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b2e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800b31:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800b34:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800b37:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800b3a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800b3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b40:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800b43:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b47:	74 1c                	je     800b65 <printnum+0x58>
  800b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4c:	ba 00 00 00 00       	mov    $0x0,%edx
  800b51:	f7 75 e4             	divl   -0x1c(%ebp)
  800b54:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800b57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b5a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b5f:	f7 75 e4             	divl   -0x1c(%ebp)
  800b62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b65:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6b:	f7 75 e4             	divl   -0x1c(%ebp)
  800b6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800b71:	89 55 dc             	mov    %edx,-0x24(%ebp)
  800b74:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b77:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800b7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800b7d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  800b80:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800b83:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  800b86:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b89:	ba 00 00 00 00       	mov    $0x0,%edx
  800b8e:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  800b91:	77 64                	ja     800bf7 <printnum+0xea>
  800b93:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  800b96:	72 05                	jb     800b9d <printnum+0x90>
  800b98:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  800b9b:	77 5a                	ja     800bf7 <printnum+0xea>
        printnum(putch, fd, putdat, result, base, width - 1, padc);
  800b9d:	8b 45 20             	mov    0x20(%ebp),%eax
  800ba0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba3:	8b 45 24             	mov    0x24(%ebp),%eax
  800ba6:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  800baa:	89 54 24 18          	mov    %edx,0x18(%esp)
  800bae:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800bb1:	89 44 24 14          	mov    %eax,0x14(%esp)
  800bb5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800bb8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800bbb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800bbf:	89 54 24 10          	mov    %edx,0x10(%esp)
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	89 44 24 08          	mov    %eax,0x8(%esp)
  800bca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bcd:	89 44 24 04          	mov    %eax,0x4(%esp)
  800bd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd4:	89 04 24             	mov    %eax,(%esp)
  800bd7:	e8 31 ff ff ff       	call   800b0d <printnum>
  800bdc:	eb 23                	jmp    800c01 <printnum+0xf4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat, fd);
  800bde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be1:	89 44 24 08          	mov    %eax,0x8(%esp)
  800be5:	8b 45 10             	mov    0x10(%ebp),%eax
  800be8:	89 44 24 04          	mov    %eax,0x4(%esp)
  800bec:	8b 45 24             	mov    0x24(%ebp),%eax
  800bef:	89 04 24             	mov    %eax,(%esp)
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, fd, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  800bf7:	83 6d 20 01          	subl   $0x1,0x20(%ebp)
  800bfb:	83 7d 20 00          	cmpl   $0x0,0x20(%ebp)
  800bff:	7f dd                	jg     800bde <printnum+0xd1>
            putch(padc, putdat, fd);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat, fd);
  800c01:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800c04:	05 24 1b 80 00       	add    $0x801b24,%eax
  800c09:	0f b6 00             	movzbl (%eax),%eax
  800c0c:	0f be c0             	movsbl %al,%eax
  800c0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c12:	89 54 24 08          	mov    %edx,0x8(%esp)
  800c16:	8b 55 10             	mov    0x10(%ebp),%edx
  800c19:	89 54 24 04          	mov    %edx,0x4(%esp)
  800c1d:	89 04 24             	mov    %eax,(%esp)
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	ff d0                	call   *%eax
}
  800c25:	c9                   	leave  
  800c26:	c3                   	ret    

00800c27 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  800c27:	55                   	push   %ebp
  800c28:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  800c2a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c2e:	7e 14                	jle    800c44 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  800c30:	8b 45 08             	mov    0x8(%ebp),%eax
  800c33:	8b 00                	mov    (%eax),%eax
  800c35:	8d 48 08             	lea    0x8(%eax),%ecx
  800c38:	8b 55 08             	mov    0x8(%ebp),%edx
  800c3b:	89 0a                	mov    %ecx,(%edx)
  800c3d:	8b 50 04             	mov    0x4(%eax),%edx
  800c40:	8b 00                	mov    (%eax),%eax
  800c42:	eb 30                	jmp    800c74 <getuint+0x4d>
    }
    else if (lflag) {
  800c44:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c48:	74 16                	je     800c60 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	8b 00                	mov    (%eax),%eax
  800c4f:	8d 48 04             	lea    0x4(%eax),%ecx
  800c52:	8b 55 08             	mov    0x8(%ebp),%edx
  800c55:	89 0a                	mov    %ecx,(%edx)
  800c57:	8b 00                	mov    (%eax),%eax
  800c59:	ba 00 00 00 00       	mov    $0x0,%edx
  800c5e:	eb 14                	jmp    800c74 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  800c60:	8b 45 08             	mov    0x8(%ebp),%eax
  800c63:	8b 00                	mov    (%eax),%eax
  800c65:	8d 48 04             	lea    0x4(%eax),%ecx
  800c68:	8b 55 08             	mov    0x8(%ebp),%edx
  800c6b:	89 0a                	mov    %ecx,(%edx)
  800c6d:	8b 00                	mov    (%eax),%eax
  800c6f:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  800c74:	5d                   	pop    %ebp
  800c75:	c3                   	ret    

00800c76 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  800c76:	55                   	push   %ebp
  800c77:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  800c79:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c7d:	7e 14                	jle    800c93 <getint+0x1d>
        return va_arg(*ap, long long);
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8b 00                	mov    (%eax),%eax
  800c84:	8d 48 08             	lea    0x8(%eax),%ecx
  800c87:	8b 55 08             	mov    0x8(%ebp),%edx
  800c8a:	89 0a                	mov    %ecx,(%edx)
  800c8c:	8b 50 04             	mov    0x4(%eax),%edx
  800c8f:	8b 00                	mov    (%eax),%eax
  800c91:	eb 28                	jmp    800cbb <getint+0x45>
    }
    else if (lflag) {
  800c93:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c97:	74 12                	je     800cab <getint+0x35>
        return va_arg(*ap, long);
  800c99:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9c:	8b 00                	mov    (%eax),%eax
  800c9e:	8d 48 04             	lea    0x4(%eax),%ecx
  800ca1:	8b 55 08             	mov    0x8(%ebp),%edx
  800ca4:	89 0a                	mov    %ecx,(%edx)
  800ca6:	8b 00                	mov    (%eax),%eax
  800ca8:	99                   	cltd   
  800ca9:	eb 10                	jmp    800cbb <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8b 00                	mov    (%eax),%eax
  800cb0:	8d 48 04             	lea    0x4(%eax),%ecx
  800cb3:	8b 55 08             	mov    0x8(%ebp),%edx
  800cb6:	89 0a                	mov    %ecx,(%edx)
  800cb8:	8b 00                	mov    (%eax),%eax
  800cba:	99                   	cltd   
    }
}
  800cbb:	5d                   	pop    %ebp
  800cbc:	c3                   	ret    

00800cbd <printfmt>:
 * @fd:         file descriptor
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*, int), int fd, void *putdat, const char *fmt, ...) {
  800cbd:	55                   	push   %ebp
  800cbe:	89 e5                	mov    %esp,%ebp
  800cc0:	83 ec 38             	sub    $0x38,%esp
    va_list ap;

    va_start(ap, fmt);
  800cc3:	8d 45 18             	lea    0x18(%ebp),%eax
  800cc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, fd, putdat, fmt, ap);
  800cc9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ccc:	89 44 24 10          	mov    %eax,0x10(%esp)
  800cd0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  800cd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800cda:	89 44 24 08          	mov    %eax,0x8(%esp)
  800cde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce1:	89 44 24 04          	mov    %eax,0x4(%esp)
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	89 04 24             	mov    %eax,(%esp)
  800ceb:	e8 02 00 00 00       	call   800cf2 <vprintfmt>
    va_end(ap);
}
  800cf0:	c9                   	leave  
  800cf1:	c3                   	ret    

00800cf2 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*, int), int fd, void *putdat, const char *fmt, va_list ap) {
  800cf2:	55                   	push   %ebp
  800cf3:	89 e5                	mov    %esp,%ebp
  800cf5:	56                   	push   %esi
  800cf6:	53                   	push   %ebx
  800cf7:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800cfa:	eb 1f                	jmp    800d1b <vprintfmt+0x29>
            if (ch == '\0') {
  800cfc:	85 db                	test   %ebx,%ebx
  800cfe:	75 05                	jne    800d05 <vprintfmt+0x13>
                return;
  800d00:	e9 33 04 00 00       	jmp    801138 <vprintfmt+0x446>
            }
            putch(ch, putdat, fd);
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	89 44 24 08          	mov    %eax,0x8(%esp)
  800d0c:	8b 45 10             	mov    0x10(%ebp),%eax
  800d0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  800d13:	89 1c 24             	mov    %ebx,(%esp)
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  800d1b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1e:	8d 50 01             	lea    0x1(%eax),%edx
  800d21:	89 55 14             	mov    %edx,0x14(%ebp)
  800d24:	0f b6 00             	movzbl (%eax),%eax
  800d27:	0f b6 d8             	movzbl %al,%ebx
  800d2a:	83 fb 25             	cmp    $0x25,%ebx
  800d2d:	75 cd                	jne    800cfc <vprintfmt+0xa>
            }
            putch(ch, putdat, fd);
        }

        // Process a %-escape sequence
        char padc = ' ';
  800d2f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  800d33:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  800d3a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800d3d:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  800d40:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  800d47:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800d4a:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  800d4d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d50:	8d 50 01             	lea    0x1(%eax),%edx
  800d53:	89 55 14             	mov    %edx,0x14(%ebp)
  800d56:	0f b6 00             	movzbl (%eax),%eax
  800d59:	0f b6 d8             	movzbl %al,%ebx
  800d5c:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800d5f:	83 f8 55             	cmp    $0x55,%eax
  800d62:	0f 87 98 03 00 00    	ja     801100 <vprintfmt+0x40e>
  800d68:	8b 04 85 48 1b 80 00 	mov    0x801b48(,%eax,4),%eax
  800d6f:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  800d71:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  800d75:	eb d6                	jmp    800d4d <vprintfmt+0x5b>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  800d77:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  800d7b:	eb d0                	jmp    800d4d <vprintfmt+0x5b>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  800d7d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  800d84:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  800d87:	89 d0                	mov    %edx,%eax
  800d89:	c1 e0 02             	shl    $0x2,%eax
  800d8c:	01 d0                	add    %edx,%eax
  800d8e:	01 c0                	add    %eax,%eax
  800d90:	01 d8                	add    %ebx,%eax
  800d92:	83 e8 30             	sub    $0x30,%eax
  800d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  800d98:	8b 45 14             	mov    0x14(%ebp),%eax
  800d9b:	0f b6 00             	movzbl (%eax),%eax
  800d9e:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  800da1:	83 fb 2f             	cmp    $0x2f,%ebx
  800da4:	7e 0b                	jle    800db1 <vprintfmt+0xbf>
  800da6:	83 fb 39             	cmp    $0x39,%ebx
  800da9:	7f 06                	jg     800db1 <vprintfmt+0xbf>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  800dab:	83 45 14 01          	addl   $0x1,0x14(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  800daf:	eb d3                	jmp    800d84 <vprintfmt+0x92>
            goto process_precision;
  800db1:	eb 33                	jmp    800de6 <vprintfmt+0xf4>

        case '*':
            precision = va_arg(ap, int);
  800db3:	8b 45 18             	mov    0x18(%ebp),%eax
  800db6:	8d 50 04             	lea    0x4(%eax),%edx
  800db9:	89 55 18             	mov    %edx,0x18(%ebp)
  800dbc:	8b 00                	mov    (%eax),%eax
  800dbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  800dc1:	eb 23                	jmp    800de6 <vprintfmt+0xf4>

        case '.':
            if (width < 0)
  800dc3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800dc7:	79 0c                	jns    800dd5 <vprintfmt+0xe3>
                width = 0;
  800dc9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  800dd0:	e9 78 ff ff ff       	jmp    800d4d <vprintfmt+0x5b>
  800dd5:	e9 73 ff ff ff       	jmp    800d4d <vprintfmt+0x5b>

        case '#':
            altflag = 1;
  800dda:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  800de1:	e9 67 ff ff ff       	jmp    800d4d <vprintfmt+0x5b>

        process_precision:
            if (width < 0)
  800de6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800dea:	79 12                	jns    800dfe <vprintfmt+0x10c>
                width = precision, precision = -1;
  800dec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800def:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800df2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  800df9:	e9 4f ff ff ff       	jmp    800d4d <vprintfmt+0x5b>
  800dfe:	e9 4a ff ff ff       	jmp    800d4d <vprintfmt+0x5b>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  800e03:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  800e07:	e9 41 ff ff ff       	jmp    800d4d <vprintfmt+0x5b>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat, fd);
  800e0c:	8b 45 18             	mov    0x18(%ebp),%eax
  800e0f:	8d 50 04             	lea    0x4(%eax),%edx
  800e12:	89 55 18             	mov    %edx,0x18(%ebp)
  800e15:	8b 00                	mov    (%eax),%eax
  800e17:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e1a:	89 54 24 08          	mov    %edx,0x8(%esp)
  800e1e:	8b 55 10             	mov    0x10(%ebp),%edx
  800e21:	89 54 24 04          	mov    %edx,0x4(%esp)
  800e25:	89 04 24             	mov    %eax,(%esp)
  800e28:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2b:	ff d0                	call   *%eax
            break;
  800e2d:	e9 00 03 00 00       	jmp    801132 <vprintfmt+0x440>

        // error message
        case 'e':
            err = va_arg(ap, int);
  800e32:	8b 45 18             	mov    0x18(%ebp),%eax
  800e35:	8d 50 04             	lea    0x4(%eax),%edx
  800e38:	89 55 18             	mov    %edx,0x18(%ebp)
  800e3b:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  800e3d:	85 db                	test   %ebx,%ebx
  800e3f:	79 02                	jns    800e43 <vprintfmt+0x151>
                err = -err;
  800e41:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  800e43:	83 fb 18             	cmp    $0x18,%ebx
  800e46:	7f 0b                	jg     800e53 <vprintfmt+0x161>
  800e48:	8b 34 9d c0 1a 80 00 	mov    0x801ac0(,%ebx,4),%esi
  800e4f:	85 f6                	test   %esi,%esi
  800e51:	75 2a                	jne    800e7d <vprintfmt+0x18b>
                printfmt(putch, fd, putdat, "error %d", err);
  800e53:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  800e57:	c7 44 24 0c 35 1b 80 	movl   $0x801b35,0xc(%esp)
  800e5e:	00 
  800e5f:	8b 45 10             	mov    0x10(%ebp),%eax
  800e62:	89 44 24 08          	mov    %eax,0x8(%esp)
  800e66:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e69:	89 44 24 04          	mov    %eax,0x4(%esp)
  800e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e70:	89 04 24             	mov    %eax,(%esp)
  800e73:	e8 45 fe ff ff       	call   800cbd <printfmt>
            }
            else {
                printfmt(putch, fd, putdat, "%s", p);
            }
            break;
  800e78:	e9 b5 02 00 00       	jmp    801132 <vprintfmt+0x440>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, fd, putdat, "error %d", err);
            }
            else {
                printfmt(putch, fd, putdat, "%s", p);
  800e7d:	89 74 24 10          	mov    %esi,0x10(%esp)
  800e81:	c7 44 24 0c 3e 1b 80 	movl   $0x801b3e,0xc(%esp)
  800e88:	00 
  800e89:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8c:	89 44 24 08          	mov    %eax,0x8(%esp)
  800e90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e93:	89 44 24 04          	mov    %eax,0x4(%esp)
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	89 04 24             	mov    %eax,(%esp)
  800e9d:	e8 1b fe ff ff       	call   800cbd <printfmt>
            }
            break;
  800ea2:	e9 8b 02 00 00       	jmp    801132 <vprintfmt+0x440>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  800ea7:	8b 45 18             	mov    0x18(%ebp),%eax
  800eaa:	8d 50 04             	lea    0x4(%eax),%edx
  800ead:	89 55 18             	mov    %edx,0x18(%ebp)
  800eb0:	8b 30                	mov    (%eax),%esi
  800eb2:	85 f6                	test   %esi,%esi
  800eb4:	75 05                	jne    800ebb <vprintfmt+0x1c9>
                p = "(null)";
  800eb6:	be 41 1b 80 00       	mov    $0x801b41,%esi
            }
            if (width > 0 && padc != '-') {
  800ebb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800ebf:	7e 45                	jle    800f06 <vprintfmt+0x214>
  800ec1:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800ec5:	74 3f                	je     800f06 <vprintfmt+0x214>
                for (width -= strnlen(p, precision); width > 0; width --) {
  800ec7:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  800eca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800ecd:	89 44 24 04          	mov    %eax,0x4(%esp)
  800ed1:	89 34 24             	mov    %esi,(%esp)
  800ed4:	e8 3b 04 00 00       	call   801314 <strnlen>
  800ed9:	29 c3                	sub    %eax,%ebx
  800edb:	89 d8                	mov    %ebx,%eax
  800edd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800ee0:	eb 1e                	jmp    800f00 <vprintfmt+0x20e>
                    putch(padc, putdat, fd);
  800ee2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800ee6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ee9:	89 54 24 08          	mov    %edx,0x8(%esp)
  800eed:	8b 55 10             	mov    0x10(%ebp),%edx
  800ef0:	89 54 24 04          	mov    %edx,0x4(%esp)
  800ef4:	89 04 24             	mov    %eax,(%esp)
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  800efc:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800f00:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800f04:	7f dc                	jg     800ee2 <vprintfmt+0x1f0>
                    putch(padc, putdat, fd);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800f06:	eb 46                	jmp    800f4e <vprintfmt+0x25c>
                if (altflag && (ch < ' ' || ch > '~')) {
  800f08:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f0c:	74 26                	je     800f34 <vprintfmt+0x242>
  800f0e:	83 fb 1f             	cmp    $0x1f,%ebx
  800f11:	7e 05                	jle    800f18 <vprintfmt+0x226>
  800f13:	83 fb 7e             	cmp    $0x7e,%ebx
  800f16:	7e 1c                	jle    800f34 <vprintfmt+0x242>
                    putch('?', putdat, fd);
  800f18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1b:	89 44 24 08          	mov    %eax,0x8(%esp)
  800f1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f22:	89 44 24 04          	mov    %eax,0x4(%esp)
  800f26:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	ff d0                	call   *%eax
  800f32:	eb 16                	jmp    800f4a <vprintfmt+0x258>
                }
                else {
                    putch(ch, putdat, fd);
  800f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f37:	89 44 24 08          	mov    %eax,0x8(%esp)
  800f3b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  800f42:	89 1c 24             	mov    %ebx,(%esp)
  800f45:	8b 45 08             	mov    0x8(%ebp),%eax
  800f48:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat, fd);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800f4a:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800f4e:	89 f0                	mov    %esi,%eax
  800f50:	8d 70 01             	lea    0x1(%eax),%esi
  800f53:	0f b6 00             	movzbl (%eax),%eax
  800f56:	0f be d8             	movsbl %al,%ebx
  800f59:	85 db                	test   %ebx,%ebx
  800f5b:	74 10                	je     800f6d <vprintfmt+0x27b>
  800f5d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f61:	78 a5                	js     800f08 <vprintfmt+0x216>
  800f63:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  800f67:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f6b:	79 9b                	jns    800f08 <vprintfmt+0x216>
                }
                else {
                    putch(ch, putdat, fd);
                }
            }
            for (; width > 0; width --) {
  800f6d:	eb 1e                	jmp    800f8d <vprintfmt+0x29b>
                putch(' ', putdat, fd);
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	89 44 24 08          	mov    %eax,0x8(%esp)
  800f76:	8b 45 10             	mov    0x10(%ebp),%eax
  800f79:	89 44 24 04          	mov    %eax,0x4(%esp)
  800f7d:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat, fd);
                }
            }
            for (; width > 0; width --) {
  800f89:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  800f8d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800f91:	7f dc                	jg     800f6f <vprintfmt+0x27d>
                putch(' ', putdat, fd);
            }
            break;
  800f93:	e9 9a 01 00 00       	jmp    801132 <vprintfmt+0x440>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  800f98:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f9b:	89 44 24 04          	mov    %eax,0x4(%esp)
  800f9f:	8d 45 18             	lea    0x18(%ebp),%eax
  800fa2:	89 04 24             	mov    %eax,(%esp)
  800fa5:	e8 cc fc ff ff       	call   800c76 <getint>
  800faa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fad:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  800fb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fb3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fb6:	85 d2                	test   %edx,%edx
  800fb8:	79 2d                	jns    800fe7 <vprintfmt+0x2f5>
                putch('-', putdat, fd);
  800fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbd:	89 44 24 08          	mov    %eax,0x8(%esp)
  800fc1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc4:	89 44 24 04          	mov    %eax,0x4(%esp)
  800fc8:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  800fcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd2:	ff d0                	call   *%eax
                num = -(long long)num;
  800fd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fd7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fda:	f7 d8                	neg    %eax
  800fdc:	83 d2 00             	adc    $0x0,%edx
  800fdf:	f7 da                	neg    %edx
  800fe1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe4:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  800fe7:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  800fee:	e9 b6 00 00 00       	jmp    8010a9 <vprintfmt+0x3b7>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  800ff3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ff6:	89 44 24 04          	mov    %eax,0x4(%esp)
  800ffa:	8d 45 18             	lea    0x18(%ebp),%eax
  800ffd:	89 04 24             	mov    %eax,(%esp)
  801000:	e8 22 fc ff ff       	call   800c27 <getuint>
  801005:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801008:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  80100b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  801012:	e9 92 00 00 00       	jmp    8010a9 <vprintfmt+0x3b7>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  801017:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80101a:	89 44 24 04          	mov    %eax,0x4(%esp)
  80101e:	8d 45 18             	lea    0x18(%ebp),%eax
  801021:	89 04 24             	mov    %eax,(%esp)
  801024:	e8 fe fb ff ff       	call   800c27 <getuint>
  801029:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80102c:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  80102f:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  801036:	eb 71                	jmp    8010a9 <vprintfmt+0x3b7>

        // pointer
        case 'p':
            putch('0', putdat, fd);
  801038:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103b:	89 44 24 08          	mov    %eax,0x8(%esp)
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	89 44 24 04          	mov    %eax,0x4(%esp)
  801046:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  80104d:	8b 45 08             	mov    0x8(%ebp),%eax
  801050:	ff d0                	call   *%eax
            putch('x', putdat, fd);
  801052:	8b 45 0c             	mov    0xc(%ebp),%eax
  801055:	89 44 24 08          	mov    %eax,0x8(%esp)
  801059:	8b 45 10             	mov    0x10(%ebp),%eax
  80105c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801060:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  801067:	8b 45 08             	mov    0x8(%ebp),%eax
  80106a:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80106c:	8b 45 18             	mov    0x18(%ebp),%eax
  80106f:	8d 50 04             	lea    0x4(%eax),%edx
  801072:	89 55 18             	mov    %edx,0x18(%ebp)
  801075:	8b 00                	mov    (%eax),%eax
  801077:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80107a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  801081:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  801088:	eb 1f                	jmp    8010a9 <vprintfmt+0x3b7>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  80108a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80108d:	89 44 24 04          	mov    %eax,0x4(%esp)
  801091:	8d 45 18             	lea    0x18(%ebp),%eax
  801094:	89 04 24             	mov    %eax,(%esp)
  801097:	e8 8b fb ff ff       	call   800c27 <getuint>
  80109c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80109f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  8010a2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, fd, putdat, num, base, width, padc);
  8010a9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010b0:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  8010b4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8010b7:	89 54 24 18          	mov    %edx,0x18(%esp)
  8010bb:	89 44 24 14          	mov    %eax,0x14(%esp)
  8010bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8010c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010c5:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8010c9:	89 54 24 10          	mov    %edx,0x10(%esp)
  8010cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010d0:	89 44 24 08          	mov    %eax,0x8(%esp)
  8010d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d7:	89 44 24 04          	mov    %eax,0x4(%esp)
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
  8010de:	89 04 24             	mov    %eax,(%esp)
  8010e1:	e8 27 fa ff ff       	call   800b0d <printnum>
            break;
  8010e6:	eb 4a                	jmp    801132 <vprintfmt+0x440>

        // escaped '%' character
        case '%':
            putch(ch, putdat, fd);
  8010e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010eb:	89 44 24 08          	mov    %eax,0x8(%esp)
  8010ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8010f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  8010f6:	89 1c 24             	mov    %ebx,(%esp)
  8010f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fc:	ff d0                	call   *%eax
            break;
  8010fe:	eb 32                	jmp    801132 <vprintfmt+0x440>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat, fd);
  801100:	8b 45 0c             	mov    0xc(%ebp),%eax
  801103:	89 44 24 08          	mov    %eax,0x8(%esp)
  801107:	8b 45 10             	mov    0x10(%ebp),%eax
  80110a:	89 44 24 04          	mov    %eax,0x4(%esp)
  80110e:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  801115:	8b 45 08             	mov    0x8(%ebp),%eax
  801118:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  80111a:	83 6d 14 01          	subl   $0x1,0x14(%ebp)
  80111e:	eb 04                	jmp    801124 <vprintfmt+0x432>
  801120:	83 6d 14 01          	subl   $0x1,0x14(%ebp)
  801124:	8b 45 14             	mov    0x14(%ebp),%eax
  801127:	83 e8 01             	sub    $0x1,%eax
  80112a:	0f b6 00             	movzbl (%eax),%eax
  80112d:	3c 25                	cmp    $0x25,%al
  80112f:	75 ef                	jne    801120 <vprintfmt+0x42e>
                /* do nothing */;
            break;
  801131:	90                   	nop
        }
    }
  801132:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  801133:	e9 e3 fb ff ff       	jmp    800d1b <vprintfmt+0x29>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  801138:	83 c4 40             	add    $0x40,%esp
  80113b:	5b                   	pop    %ebx
  80113c:	5e                   	pop    %esi
  80113d:	5d                   	pop    %ebp
  80113e:	c3                   	ret    

0080113f <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  80113f:	55                   	push   %ebp
  801140:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	8b 40 08             	mov    0x8(%eax),%eax
  801148:	8d 50 01             	lea    0x1(%eax),%edx
  80114b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80114e:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  801151:	8b 45 0c             	mov    0xc(%ebp),%eax
  801154:	8b 10                	mov    (%eax),%edx
  801156:	8b 45 0c             	mov    0xc(%ebp),%eax
  801159:	8b 40 04             	mov    0x4(%eax),%eax
  80115c:	39 c2                	cmp    %eax,%edx
  80115e:	73 12                	jae    801172 <sprintputch+0x33>
        *b->buf ++ = ch;
  801160:	8b 45 0c             	mov    0xc(%ebp),%eax
  801163:	8b 00                	mov    (%eax),%eax
  801165:	8d 48 01             	lea    0x1(%eax),%ecx
  801168:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116b:	89 0a                	mov    %ecx,(%edx)
  80116d:	8b 55 08             	mov    0x8(%ebp),%edx
  801170:	88 10                	mov    %dl,(%eax)
    }
}
  801172:	5d                   	pop    %ebp
  801173:	c3                   	ret    

00801174 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  801174:	55                   	push   %ebp
  801175:	89 e5                	mov    %esp,%ebp
  801177:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  80117a:	8d 45 14             	lea    0x14(%ebp),%eax
  80117d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  801180:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801183:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801187:	8b 45 10             	mov    0x10(%ebp),%eax
  80118a:	89 44 24 08          	mov    %eax,0x8(%esp)
  80118e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801191:	89 44 24 04          	mov    %eax,0x4(%esp)
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	89 04 24             	mov    %eax,(%esp)
  80119b:	e8 08 00 00 00       	call   8011a8 <vsnprintf>
  8011a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  8011a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011a6:	c9                   	leave  
  8011a7:	c3                   	ret    

008011a8 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  8011a8:	55                   	push   %ebp
  8011a9:	89 e5                	mov    %esp,%ebp
  8011ab:	83 ec 38             	sub    $0x38,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	01 d0                	add    %edx,%eax
  8011bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011c2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  8011c9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011cd:	74 0a                	je     8011d9 <vsnprintf+0x31>
  8011cf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8011d5:	39 c2                	cmp    %eax,%edx
  8011d7:	76 07                	jbe    8011e0 <vsnprintf+0x38>
        return -E_INVAL;
  8011d9:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  8011de:	eb 32                	jmp    801212 <vsnprintf+0x6a>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, NO_FD, &b, fmt, ap);
  8011e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e3:	89 44 24 10          	mov    %eax,0x10(%esp)
  8011e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ea:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8011ee:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011f1:	89 44 24 08          	mov    %eax,0x8(%esp)
  8011f5:	c7 44 24 04 d9 6a ff 	movl   $0xffff6ad9,0x4(%esp)
  8011fc:	ff 
  8011fd:	c7 04 24 3f 11 80 00 	movl   $0x80113f,(%esp)
  801204:	e8 e9 fa ff ff       	call   800cf2 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  801209:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80120c:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  80120f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801212:	c9                   	leave  
  801213:	c3                   	ret    

00801214 <rand>:
 * rand - returns a pseudo-random integer
 *
 * The rand() function return a value in the range [0, RAND_MAX].
 * */
int
rand(void) {
  801214:	55                   	push   %ebp
  801215:	89 e5                	mov    %esp,%ebp
  801217:	57                   	push   %edi
  801218:	56                   	push   %esi
  801219:	53                   	push   %ebx
  80121a:	83 ec 24             	sub    $0x24,%esp
    next = (next * 0x5DEECE66DLL + 0xBLL) & ((1LL << 48) - 1);
  80121d:	a1 08 20 80 00       	mov    0x802008,%eax
  801222:	8b 15 0c 20 80 00    	mov    0x80200c,%edx
  801228:	69 fa 6d e6 ec de    	imul   $0xdeece66d,%edx,%edi
  80122e:	6b f0 05             	imul   $0x5,%eax,%esi
  801231:	01 f7                	add    %esi,%edi
  801233:	be 6d e6 ec de       	mov    $0xdeece66d,%esi
  801238:	f7 e6                	mul    %esi
  80123a:	8d 34 17             	lea    (%edi,%edx,1),%esi
  80123d:	89 f2                	mov    %esi,%edx
  80123f:	83 c0 0b             	add    $0xb,%eax
  801242:	83 d2 00             	adc    $0x0,%edx
  801245:	89 c7                	mov    %eax,%edi
  801247:	83 e7 ff             	and    $0xffffffff,%edi
  80124a:	89 f9                	mov    %edi,%ecx
  80124c:	0f b7 da             	movzwl %dx,%ebx
  80124f:	89 0d 08 20 80 00    	mov    %ecx,0x802008
  801255:	89 1d 0c 20 80 00    	mov    %ebx,0x80200c
    unsigned long long result = (next >> 12);
  80125b:	a1 08 20 80 00       	mov    0x802008,%eax
  801260:	8b 15 0c 20 80 00    	mov    0x80200c,%edx
  801266:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  80126a:	c1 ea 0c             	shr    $0xc,%edx
  80126d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  801270:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return (int)do_div(result, RAND_MAX + 1);
  801273:	c7 45 dc 00 00 00 80 	movl   $0x80000000,-0x24(%ebp)
  80127a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80127d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  801280:	89 45 d8             	mov    %eax,-0x28(%ebp)
  801283:	89 55 e8             	mov    %edx,-0x18(%ebp)
  801286:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801289:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80128c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  801290:	74 1c                	je     8012ae <rand+0x9a>
  801292:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801295:	ba 00 00 00 00       	mov    $0x0,%edx
  80129a:	f7 75 dc             	divl   -0x24(%ebp)
  80129d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  8012a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8012a3:	ba 00 00 00 00       	mov    $0x0,%edx
  8012a8:	f7 75 dc             	divl   -0x24(%ebp)
  8012ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8012ae:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8012b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b4:	f7 75 dc             	divl   -0x24(%ebp)
  8012b7:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8012ba:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  8012bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8012c0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8012c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8012c6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  8012c9:	8b 45 d4             	mov    -0x2c(%ebp),%eax
}
  8012cc:	83 c4 24             	add    $0x24,%esp
  8012cf:	5b                   	pop    %ebx
  8012d0:	5e                   	pop    %esi
  8012d1:	5f                   	pop    %edi
  8012d2:	5d                   	pop    %ebp
  8012d3:	c3                   	ret    

008012d4 <srand>:
/* *
 * srand - seed the random number generator with the given number
 * @seed:   the required seed number
 * */
void
srand(unsigned int seed) {
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
    next = seed;
  8012d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8012da:	ba 00 00 00 00       	mov    $0x0,%edx
  8012df:	a3 08 20 80 00       	mov    %eax,0x802008
  8012e4:	89 15 0c 20 80 00    	mov    %edx,0x80200c
}
  8012ea:	5d                   	pop    %ebp
  8012eb:	c3                   	ret    

008012ec <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
  8012ef:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  8012f2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  8012f9:	eb 04                	jmp    8012ff <strlen+0x13>
        cnt ++;
  8012fb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	8d 50 01             	lea    0x1(%eax),%edx
  801305:	89 55 08             	mov    %edx,0x8(%ebp)
  801308:	0f b6 00             	movzbl (%eax),%eax
  80130b:	84 c0                	test   %al,%al
  80130d:	75 ec                	jne    8012fb <strlen+0xf>
        cnt ++;
    }
    return cnt;
  80130f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801312:	c9                   	leave  
  801313:	c3                   	ret    

00801314 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  801314:	55                   	push   %ebp
  801315:	89 e5                	mov    %esp,%ebp
  801317:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  80131a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  801321:	eb 04                	jmp    801327 <strnlen+0x13>
        cnt ++;
  801323:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  801327:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80132d:	73 10                	jae    80133f <strnlen+0x2b>
  80132f:	8b 45 08             	mov    0x8(%ebp),%eax
  801332:	8d 50 01             	lea    0x1(%eax),%edx
  801335:	89 55 08             	mov    %edx,0x8(%ebp)
  801338:	0f b6 00             	movzbl (%eax),%eax
  80133b:	84 c0                	test   %al,%al
  80133d:	75 e4                	jne    801323 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  80133f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <strcat>:
 * @dst:    pointer to the @dst array, which should be large enough to contain the concatenated
 *          resulting string.
 * @src:    string to be appended, this should not overlap @dst
 * */
char *
strcat(char *dst, const char *src) {
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
  801347:	83 ec 18             	sub    $0x18,%esp
    return strcpy(dst + strlen(dst), src);
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	89 04 24             	mov    %eax,(%esp)
  801350:	e8 97 ff ff ff       	call   8012ec <strlen>
  801355:	8b 55 08             	mov    0x8(%ebp),%edx
  801358:	01 c2                	add    %eax,%edx
  80135a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80135d:	89 44 24 04          	mov    %eax,0x4(%esp)
  801361:	89 14 24             	mov    %edx,(%esp)
  801364:	e8 02 00 00 00       	call   80136b <strcpy>
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	57                   	push   %edi
  80136f:	56                   	push   %esi
  801370:	83 ec 20             	sub    $0x20,%esp
  801373:	8b 45 08             	mov    0x8(%ebp),%eax
  801376:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801379:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137c:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  80137f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801382:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801385:	89 d1                	mov    %edx,%ecx
  801387:	89 c2                	mov    %eax,%edx
  801389:	89 ce                	mov    %ecx,%esi
  80138b:	89 d7                	mov    %edx,%edi
  80138d:	ac                   	lods   %ds:(%esi),%al
  80138e:	aa                   	stos   %al,%es:(%edi)
  80138f:	84 c0                	test   %al,%al
  801391:	75 fa                	jne    80138d <strcpy+0x22>
  801393:	89 fa                	mov    %edi,%edx
  801395:	89 f1                	mov    %esi,%ecx
  801397:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  80139a:	89 55 e8             	mov    %edx,-0x18(%ebp)
  80139d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
  8013a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  8013a3:	83 c4 20             	add    $0x20,%esp
  8013a6:	5e                   	pop    %esi
  8013a7:	5f                   	pop    %edi
  8013a8:	5d                   	pop    %ebp
  8013a9:	c3                   	ret    

008013aa <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
  8013ad:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  8013b6:	eb 21                	jmp    8013d9 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  8013b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013bb:	0f b6 10             	movzbl (%eax),%edx
  8013be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c1:	88 10                	mov    %dl,(%eax)
  8013c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c6:	0f b6 00             	movzbl (%eax),%eax
  8013c9:	84 c0                	test   %al,%al
  8013cb:	74 04                	je     8013d1 <strncpy+0x27>
            src ++;
  8013cd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  8013d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  8013d5:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  8013d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013dd:	75 d9                	jne    8013b8 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8013e2:	c9                   	leave  
  8013e3:	c3                   	ret    

008013e4 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  8013e4:	55                   	push   %ebp
  8013e5:	89 e5                	mov    %esp,%ebp
  8013e7:	57                   	push   %edi
  8013e8:	56                   	push   %esi
  8013e9:	83 ec 20             	sub    $0x20,%esp
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8013f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  8013f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8013fe:	89 d1                	mov    %edx,%ecx
  801400:	89 c2                	mov    %eax,%edx
  801402:	89 ce                	mov    %ecx,%esi
  801404:	89 d7                	mov    %edx,%edi
  801406:	ac                   	lods   %ds:(%esi),%al
  801407:	ae                   	scas   %es:(%edi),%al
  801408:	75 08                	jne    801412 <strcmp+0x2e>
  80140a:	84 c0                	test   %al,%al
  80140c:	75 f8                	jne    801406 <strcmp+0x22>
  80140e:	31 c0                	xor    %eax,%eax
  801410:	eb 04                	jmp    801416 <strcmp+0x32>
  801412:	19 c0                	sbb    %eax,%eax
  801414:	0c 01                	or     $0x1,%al
  801416:	89 fa                	mov    %edi,%edx
  801418:	89 f1                	mov    %esi,%ecx
  80141a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80141d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  801420:	89 55 e4             	mov    %edx,-0x1c(%ebp)
        "orb $1, %%al;"
        "3:"
        : "=a" (ret), "=&S" (d0), "=&D" (d1)
        : "1" (s1), "2" (s2)
        : "memory");
    return ret;
  801423:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  801426:	83 c4 20             	add    $0x20,%esp
  801429:	5e                   	pop    %esi
  80142a:	5f                   	pop    %edi
  80142b:	5d                   	pop    %ebp
  80142c:	c3                   	ret    

0080142d <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  80142d:	55                   	push   %ebp
  80142e:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  801430:	eb 0c                	jmp    80143e <strncmp+0x11>
        n --, s1 ++, s2 ++;
  801432:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  801436:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  80143a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  80143e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801442:	74 1a                	je     80145e <strncmp+0x31>
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	0f b6 00             	movzbl (%eax),%eax
  80144a:	84 c0                	test   %al,%al
  80144c:	74 10                	je     80145e <strncmp+0x31>
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	0f b6 10             	movzbl (%eax),%edx
  801454:	8b 45 0c             	mov    0xc(%ebp),%eax
  801457:	0f b6 00             	movzbl (%eax),%eax
  80145a:	38 c2                	cmp    %al,%dl
  80145c:	74 d4                	je     801432 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  80145e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801462:	74 18                	je     80147c <strncmp+0x4f>
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	0f b6 00             	movzbl (%eax),%eax
  80146a:	0f b6 d0             	movzbl %al,%edx
  80146d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801470:	0f b6 00             	movzbl (%eax),%eax
  801473:	0f b6 c0             	movzbl %al,%eax
  801476:	29 c2                	sub    %eax,%edx
  801478:	89 d0                	mov    %edx,%eax
  80147a:	eb 05                	jmp    801481 <strncmp+0x54>
  80147c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801481:	5d                   	pop    %ebp
  801482:	c3                   	ret    

00801483 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
  801486:	83 ec 04             	sub    $0x4,%esp
  801489:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148c:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  80148f:	eb 14                	jmp    8014a5 <strchr+0x22>
        if (*s == c) {
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	0f b6 00             	movzbl (%eax),%eax
  801497:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80149a:	75 05                	jne    8014a1 <strchr+0x1e>
            return (char *)s;
  80149c:	8b 45 08             	mov    0x8(%ebp),%eax
  80149f:	eb 13                	jmp    8014b4 <strchr+0x31>
        }
        s ++;
  8014a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a8:	0f b6 00             	movzbl (%eax),%eax
  8014ab:	84 c0                	test   %al,%al
  8014ad:	75 e2                	jne    801491 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  8014af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014b4:	c9                   	leave  
  8014b5:	c3                   	ret    

008014b6 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
  8014b9:	83 ec 04             	sub    $0x4,%esp
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  8014c2:	eb 11                	jmp    8014d5 <strfind+0x1f>
        if (*s == c) {
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	0f b6 00             	movzbl (%eax),%eax
  8014ca:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014cd:	75 02                	jne    8014d1 <strfind+0x1b>
            break;
  8014cf:	eb 0e                	jmp    8014df <strfind+0x29>
        }
        s ++;
  8014d1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	0f b6 00             	movzbl (%eax),%eax
  8014db:	84 c0                	test   %al,%al
  8014dd:	75 e5                	jne    8014c4 <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014e2:	c9                   	leave  
  8014e3:	c3                   	ret    

008014e4 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  8014e4:	55                   	push   %ebp
  8014e5:	89 e5                	mov    %esp,%ebp
  8014e7:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  8014ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  8014f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  8014f8:	eb 04                	jmp    8014fe <strtol+0x1a>
        s ++;
  8014fa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  8014fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801501:	0f b6 00             	movzbl (%eax),%eax
  801504:	3c 20                	cmp    $0x20,%al
  801506:	74 f2                	je     8014fa <strtol+0x16>
  801508:	8b 45 08             	mov    0x8(%ebp),%eax
  80150b:	0f b6 00             	movzbl (%eax),%eax
  80150e:	3c 09                	cmp    $0x9,%al
  801510:	74 e8                	je     8014fa <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  801512:	8b 45 08             	mov    0x8(%ebp),%eax
  801515:	0f b6 00             	movzbl (%eax),%eax
  801518:	3c 2b                	cmp    $0x2b,%al
  80151a:	75 06                	jne    801522 <strtol+0x3e>
        s ++;
  80151c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  801520:	eb 15                	jmp    801537 <strtol+0x53>
    }
    else if (*s == '-') {
  801522:	8b 45 08             	mov    0x8(%ebp),%eax
  801525:	0f b6 00             	movzbl (%eax),%eax
  801528:	3c 2d                	cmp    $0x2d,%al
  80152a:	75 0b                	jne    801537 <strtol+0x53>
        s ++, neg = 1;
  80152c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  801530:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  801537:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80153b:	74 06                	je     801543 <strtol+0x5f>
  80153d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801541:	75 24                	jne    801567 <strtol+0x83>
  801543:	8b 45 08             	mov    0x8(%ebp),%eax
  801546:	0f b6 00             	movzbl (%eax),%eax
  801549:	3c 30                	cmp    $0x30,%al
  80154b:	75 1a                	jne    801567 <strtol+0x83>
  80154d:	8b 45 08             	mov    0x8(%ebp),%eax
  801550:	83 c0 01             	add    $0x1,%eax
  801553:	0f b6 00             	movzbl (%eax),%eax
  801556:	3c 78                	cmp    $0x78,%al
  801558:	75 0d                	jne    801567 <strtol+0x83>
        s += 2, base = 16;
  80155a:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80155e:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801565:	eb 2a                	jmp    801591 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  801567:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80156b:	75 17                	jne    801584 <strtol+0xa0>
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
  801570:	0f b6 00             	movzbl (%eax),%eax
  801573:	3c 30                	cmp    $0x30,%al
  801575:	75 0d                	jne    801584 <strtol+0xa0>
        s ++, base = 8;
  801577:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  80157b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801582:	eb 0d                	jmp    801591 <strtol+0xad>
    }
    else if (base == 0) {
  801584:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801588:	75 07                	jne    801591 <strtol+0xad>
        base = 10;
  80158a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  801591:	8b 45 08             	mov    0x8(%ebp),%eax
  801594:	0f b6 00             	movzbl (%eax),%eax
  801597:	3c 2f                	cmp    $0x2f,%al
  801599:	7e 1b                	jle    8015b6 <strtol+0xd2>
  80159b:	8b 45 08             	mov    0x8(%ebp),%eax
  80159e:	0f b6 00             	movzbl (%eax),%eax
  8015a1:	3c 39                	cmp    $0x39,%al
  8015a3:	7f 11                	jg     8015b6 <strtol+0xd2>
            dig = *s - '0';
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a8:	0f b6 00             	movzbl (%eax),%eax
  8015ab:	0f be c0             	movsbl %al,%eax
  8015ae:	83 e8 30             	sub    $0x30,%eax
  8015b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015b4:	eb 48                	jmp    8015fe <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	0f b6 00             	movzbl (%eax),%eax
  8015bc:	3c 60                	cmp    $0x60,%al
  8015be:	7e 1b                	jle    8015db <strtol+0xf7>
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	0f b6 00             	movzbl (%eax),%eax
  8015c6:	3c 7a                	cmp    $0x7a,%al
  8015c8:	7f 11                	jg     8015db <strtol+0xf7>
            dig = *s - 'a' + 10;
  8015ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cd:	0f b6 00             	movzbl (%eax),%eax
  8015d0:	0f be c0             	movsbl %al,%eax
  8015d3:	83 e8 57             	sub    $0x57,%eax
  8015d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8015d9:	eb 23                	jmp    8015fe <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	0f b6 00             	movzbl (%eax),%eax
  8015e1:	3c 40                	cmp    $0x40,%al
  8015e3:	7e 3d                	jle    801622 <strtol+0x13e>
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	0f b6 00             	movzbl (%eax),%eax
  8015eb:	3c 5a                	cmp    $0x5a,%al
  8015ed:	7f 33                	jg     801622 <strtol+0x13e>
            dig = *s - 'A' + 10;
  8015ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f2:	0f b6 00             	movzbl (%eax),%eax
  8015f5:	0f be c0             	movsbl %al,%eax
  8015f8:	83 e8 37             	sub    $0x37,%eax
  8015fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  8015fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801601:	3b 45 10             	cmp    0x10(%ebp),%eax
  801604:	7c 02                	jl     801608 <strtol+0x124>
            break;
  801606:	eb 1a                	jmp    801622 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  801608:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  80160c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80160f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801613:	89 c2                	mov    %eax,%edx
  801615:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801618:	01 d0                	add    %edx,%eax
  80161a:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  80161d:	e9 6f ff ff ff       	jmp    801591 <strtol+0xad>

    if (endptr) {
  801622:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801626:	74 08                	je     801630 <strtol+0x14c>
        *endptr = (char *) s;
  801628:	8b 45 0c             	mov    0xc(%ebp),%eax
  80162b:	8b 55 08             	mov    0x8(%ebp),%edx
  80162e:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  801630:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801634:	74 07                	je     80163d <strtol+0x159>
  801636:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801639:	f7 d8                	neg    %eax
  80163b:	eb 03                	jmp    801640 <strtol+0x15c>
  80163d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801640:	c9                   	leave  
  801641:	c3                   	ret    

00801642 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  801642:	55                   	push   %ebp
  801643:	89 e5                	mov    %esp,%ebp
  801645:	57                   	push   %edi
  801646:	83 ec 24             	sub    $0x24,%esp
  801649:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164c:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  80164f:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  801653:	8b 55 08             	mov    0x8(%ebp),%edx
  801656:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801659:	88 45 f7             	mov    %al,-0x9(%ebp)
  80165c:	8b 45 10             	mov    0x10(%ebp),%eax
  80165f:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  801662:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801665:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  801669:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80166c:	89 d7                	mov    %edx,%edi
  80166e:	f3 aa                	rep stos %al,%es:(%edi)
  801670:	89 fa                	mov    %edi,%edx
  801672:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  801675:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
  801678:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  80167b:	83 c4 24             	add    $0x24,%esp
  80167e:	5f                   	pop    %edi
  80167f:	5d                   	pop    %ebp
  801680:	c3                   	ret    

00801681 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  801681:	55                   	push   %ebp
  801682:	89 e5                	mov    %esp,%ebp
  801684:	57                   	push   %edi
  801685:	56                   	push   %esi
  801686:	53                   	push   %ebx
  801687:	83 ec 30             	sub    $0x30,%esp
  80168a:	8b 45 08             	mov    0x8(%ebp),%eax
  80168d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801690:	8b 45 0c             	mov    0xc(%ebp),%eax
  801693:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801696:	8b 45 10             	mov    0x10(%ebp),%eax
  801699:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  80169c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80169f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  8016a2:	73 42                	jae    8016e6 <memmove+0x65>
  8016a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8016aa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016ad:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8016b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016b3:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  8016b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8016b9:	c1 e8 02             	shr    $0x2,%eax
  8016bc:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  8016be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8016c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8016c4:	89 d7                	mov    %edx,%edi
  8016c6:	89 c6                	mov    %eax,%esi
  8016c8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  8016ca:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  8016cd:	83 e1 03             	and    $0x3,%ecx
  8016d0:	74 02                	je     8016d4 <memmove+0x53>
  8016d2:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  8016d4:	89 f0                	mov    %esi,%eax
  8016d6:	89 fa                	mov    %edi,%edx
  8016d8:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  8016db:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  8016de:	89 45 d0             	mov    %eax,-0x30(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  8016e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8016e4:	eb 36                	jmp    80171c <memmove+0x9b>
    asm volatile (
        "std;"
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  8016e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016e9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8016ef:	01 c2                	add    %eax,%edx
  8016f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8016f4:	8d 48 ff             	lea    -0x1(%eax),%ecx
  8016f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8016fa:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  8016fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801700:	89 c1                	mov    %eax,%ecx
  801702:	89 d8                	mov    %ebx,%eax
  801704:	89 d6                	mov    %edx,%esi
  801706:	89 c7                	mov    %eax,%edi
  801708:	fd                   	std    
  801709:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80170b:	fc                   	cld    
  80170c:	89 f8                	mov    %edi,%eax
  80170e:	89 f2                	mov    %esi,%edx
  801710:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  801713:	89 55 c8             	mov    %edx,-0x38(%ebp)
  801716:	89 45 c4             	mov    %eax,-0x3c(%ebp)
        "rep; movsb;"
        "cld;"
        : "=&c" (d0), "=&S" (d1), "=&D" (d2)
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
        : "memory");
    return dst;
  801719:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  80171c:	83 c4 30             	add    $0x30,%esp
  80171f:	5b                   	pop    %ebx
  801720:	5e                   	pop    %esi
  801721:	5f                   	pop    %edi
  801722:	5d                   	pop    %ebp
  801723:	c3                   	ret    

00801724 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
  801727:	57                   	push   %edi
  801728:	56                   	push   %esi
  801729:	83 ec 20             	sub    $0x20,%esp
  80172c:	8b 45 08             	mov    0x8(%ebp),%eax
  80172f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801732:	8b 45 0c             	mov    0xc(%ebp),%eax
  801735:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801738:	8b 45 10             	mov    0x10(%ebp),%eax
  80173b:	89 45 ec             	mov    %eax,-0x14(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  80173e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801741:	c1 e8 02             	shr    $0x2,%eax
  801744:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  801746:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801749:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80174c:	89 d7                	mov    %edx,%edi
  80174e:	89 c6                	mov    %eax,%esi
  801750:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  801752:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  801755:	83 e1 03             	and    $0x3,%ecx
  801758:	74 02                	je     80175c <memcpy+0x38>
  80175a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  80175c:	89 f0                	mov    %esi,%eax
  80175e:	89 fa                	mov    %edi,%edx
  801760:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  801763:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  801766:	89 45 e0             	mov    %eax,-0x20(%ebp)
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
        : "memory");
    return dst;
  801769:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  80176c:	83 c4 20             	add    $0x20,%esp
  80176f:	5e                   	pop    %esi
  801770:	5f                   	pop    %edi
  801771:	5d                   	pop    %ebp
  801772:	c3                   	ret    

00801773 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  801773:	55                   	push   %ebp
  801774:	89 e5                	mov    %esp,%ebp
  801776:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  801779:	8b 45 08             	mov    0x8(%ebp),%eax
  80177c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  80177f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801782:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  801785:	eb 30                	jmp    8017b7 <memcmp+0x44>
        if (*s1 != *s2) {
  801787:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80178a:	0f b6 10             	movzbl (%eax),%edx
  80178d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801790:	0f b6 00             	movzbl (%eax),%eax
  801793:	38 c2                	cmp    %al,%dl
  801795:	74 18                	je     8017af <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  801797:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179a:	0f b6 00             	movzbl (%eax),%eax
  80179d:	0f b6 d0             	movzbl %al,%edx
  8017a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a3:	0f b6 00             	movzbl (%eax),%eax
  8017a6:	0f b6 c0             	movzbl %al,%eax
  8017a9:	29 c2                	sub    %eax,%edx
  8017ab:	89 d0                	mov    %edx,%eax
  8017ad:	eb 1a                	jmp    8017c9 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  8017af:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  8017b3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  8017b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ba:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017bd:	89 55 10             	mov    %edx,0x10(%ebp)
  8017c0:	85 c0                	test   %eax,%eax
  8017c2:	75 c3                	jne    801787 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  8017c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c9:	c9                   	leave  
  8017ca:	c3                   	ret    

008017cb <main>:
#include <stdio.h>
#include <ulib.h>

int
main(void) {
  8017cb:	55                   	push   %ebp
  8017cc:	89 e5                	mov    %esp,%ebp
  8017ce:	83 e4 f0             	and    $0xfffffff0,%esp
  8017d1:	83 ec 10             	sub    $0x10,%esp
    cprintf("I read %08x from 0xfac00000!\n", *(unsigned *)0xfac00000);
  8017d4:	b8 00 00 c0 fa       	mov    $0xfac00000,%eax
  8017d9:	8b 00                	mov    (%eax),%eax
  8017db:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017df:	c7 04 24 a0 1c 80 00 	movl   $0x801ca0,(%esp)
  8017e6:	e8 f2 eb ff ff       	call   8003dd <cprintf>
    panic("FAIL: T.T\n");
  8017eb:	c7 44 24 08 be 1c 80 	movl   $0x801cbe,0x8(%esp)
  8017f2:	00 
  8017f3:	c7 44 24 04 07 00 00 	movl   $0x7,0x4(%esp)
  8017fa:	00 
  8017fb:	c7 04 24 c9 1c 80 00 	movl   $0x801cc9,(%esp)
  801802:	e8 e5 ea ff ff       	call   8002ec <__panic>
