#/bin/bash

#If you use a virtual env - source it here
#source /hgsc_software/PBSuite/pbsuiteVirtualEnv/bin/activate
source activate PBSuite

#This is the path where you've install the suite.
export SWEETPATH=pathtopbsuite
#for python modules 
#If you conda envs are not in home dir, you need to modify this line, change ~/.conda to where you've installed conda
export PYTHONPATH=$PYTHONPATH:~/.conda/envs/PBSuite/lib/python3.6/site-packages
export PYTHONPATH=$PYTHONPATH:$SWEETPATH
#for executables 
export PATH=$PATH:$SWEETPATH/bin/
