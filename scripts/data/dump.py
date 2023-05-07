"""
Break large files into chunks.

:source: https://www.oreilly.com/library/view/programming-python-second/0596000855/ch04s02.html
"""

from __future__ import print_function

import os

KILOBYTES = 1024
MEGABYTES = KILOBYTES * 1000
CHUNKSIZE = int(1.4 * MEGABYTES)  # default: roughly a floppy


def split(fromfile, todir, chunksize=CHUNKSIZE):
    if not os.path.exists(todir):  # caller handles errors
        os.mkdir(todir)  # make dir, read/write parts
    else:
        for fname in os.listdir(todir):  # delete any existing files
            os.remove(os.path.join(todir, fname))
    partnum = 0

    f = open(fromfile, "rb")  # use binary mode on Windows
    while 1:  # eof=empty string from read
        chunk = f.read(chunksize)  # get next part <= chunksize
        if not chunk:
            break
        partnum = partnum + 1
        filename = os.path.join(todir, ("part%03d" % partnum))
        fileobj = open(filename, "wb")
        fileobj.write(chunk)
        fileobj.close()  # or simply open(  ).write(  )
    f.close()

    return partnum
