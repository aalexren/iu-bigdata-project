"""
Break large files into chunks.

:source: https://www.oreilly.com/library/view/programming-python-second/0596000855/ch04s02.html
"""

import os

kilobytes = 1024
megabytes = kilobytes * 1000
chunksize = int(1.4 * megabytes)  # default: roughly a floppy


def split(fromfile, todir, chunksize=chunksize):
    if not os.path.exists(todir):  # caller handles errors
        os.mkdir(todir)  # make dir, read/write parts
    else:
        for fname in os.listdir(todir):  # delete any existing files
            os.remove(os.path.join(todir, fname))
    partnum = 0

    input = open(fromfile, "rb")  # use binary mode on Windows
    while 1:  # eof=empty string from read
        chunk = input.read(chunksize)  # get next part <= chunksize
        if not chunk:
            break
        partnum = partnum + 1
        filename = os.path.join(todir, ("part%03d" % partnum))
        fileobj = open(filename, "wb")
        fileobj.write(chunk)
        fileobj.close()  # or simply open(  ).write(  )
    input.close()

    return partnum
