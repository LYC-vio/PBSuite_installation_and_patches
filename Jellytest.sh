#/bin/bash

Jelly.py setup Protocol.xml
Jelly.py mapping Protocol.xml
Jelly.py support Protocol.xml
Jelly.py extraction Protocol.xml
Jelly.py assembly Protocol.xml -x "--nproc=4"
Jelly.py output Protocol.xml
grep -Ho N jelly.out.fasta | uniq -c
#if no output in stdout(didn't see 1494 in the last line), or only one contig in jelly.out.fasta, then you are all set

