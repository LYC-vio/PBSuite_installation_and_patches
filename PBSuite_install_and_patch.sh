#!/bin/bash

#Create environment for PBSuite
conda create -y -n PBSuite python=3.6
source activate PBSuite
pip install networkx==1.11
conda install -y numpy
conda install -y blasr
conda install -y samtools
conda install -y pysam
conda install -y h5py
pip install intervaltree_bio

cd ..

#Download PBSuite
wget http://deb.debian.org/debian/pool/main/p/pbsuite/pbsuite_15.8.24+dfsg.orig.tar.xz
tar -xvf pbsuite_15.8.24+dfsg.orig.tar.xz
rm pbsuite_15.8.24+dfsg.orig.tar.xz  

cd PBSuite_15.8.24/

#cp patches
cp ../PBSuite_installation_and_patches/patches/*.patch .

#Patch
patch -p0 < fix-syntax-error.patch
patch -p0 < intervaltree-import-statement.patch
patch -p0 < fix-example.patch
patch -p0 < fix-shebang-lines.patch
patch -p0 < blasr-5.patch #blasr-5 interface
patch -p0 < intermediate-reads-files.patch

##py2->py3
patch -p0 < 2to3.patch
patch -p0 < fix_py3.patch

#fix some bugs in the py2->3 process
patch -p0 < 2to3_cleanup_assembly_and_support.patch

#Copy configure files
sed -i 's?pathtopbsuite?'`pwd`'?' ../PBSuite_installation_and_patches/setup.sh
cp ../PBSuite_installation_and_patches/setup.sh .
sed -i 's?pathtopbsuite?'`pwd`'?' ../PBSuite_installation_and_patches/Protocol.xml
cp ../PBSuite_installation_and_patches/Protocol.xml ./docs/jellyExample/
cp ../PBSuite_installation_and_patches/Jellytest.sh  ./docs/jellyExample/
cp ../PBSuite_installation_and_patches/workflow.sh ./docs/honeyExample/

#Test installation
cd ./docs/jellyExample/
sh Jellytest.sh
cd -
cd ./docs/honeyExample/
sh workflow.sh
cd -
