"""
Compiles data files from chunks.

:source: https://www.oreilly.com/library/view/programming-python-second/0596000855/ch04s02.html
"""

import sys
import os

readsize = 1024

def join(fromdir, tofile):
    output = open(tofile, 'wb')
    parts  = os.listdir(fromdir)
    parts.sort()
    for filename in parts:
        filepath = os.path.join(fromdir, filename)
        fileobj  = open(filepath, 'rb')
        while 1:
            filebytes = fileobj.read(readsize)
            if not filebytes: break
            output.write(filebytes)
        fileobj.close()
    output.close()


if len(sys.argv) < 3:
    print "NO PASSED PATH TO DATA DIRECTORY!"
    sys.exit(1)

data_dir = sys.argv[1]
file_dir = os.path.join(data_dir, sys.argv[2])

if not os.path.exists(file_dir):
    print "DIRECTORY %s DOESN'T EXISTS!" % (file_dir)
    sys.exit(1)

file_csv = os.path.join(data_dir, "%s.csv" % (file_dir))

print "COMPILE %s..." % (file_csv)
join(file_dir, file_csv)
print "SUCCESS!"