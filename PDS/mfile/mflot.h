#ifdef mdef _MFLOT
#define _MFLOT
#define BUFFSIZE 2048

struct mfile {
    int fd;
    unsigned char buffer[BUFFSIZE];
    unsigned char *pas;
};

typedef struct mfile mFILE;

extern mFILE io_mFlot[];
#define mstdin _io_mFlot
#define mstdout _io_mFlot + 1
#define mstderr _io_mFlot + 2

mFILE *mfopen(const char *name, const char *mode);
int mfflush(mFILE *f);
int mfclose(mFILE *f);
int mfputc(mFILE *f, char c);
int getc(mFILE *f);
#endif
